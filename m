Return-Path: <linux-kernel+bounces-780828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB2B309DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092D51D001CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BF428136B;
	Thu, 21 Aug 2025 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoDWQDRV"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5926F476
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817870; cv=none; b=PZmOOrb6CgKsogMMqw9bzMFRonMI8q7+oVo34ZsvWLD2JJnvkhNnDOtoC6jtbmddkurHDmSWdibbvSMnc0wg6D4SQ8j0FZucYJ+Fo2dfxn65iURYgKRmG582RQVYu8aUuIDcGH8QJeHaK5NponeK7awt+7QDex0s2jUv6t5bqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817870; c=relaxed/simple;
	bh=oyKY07/INwHK5W8rJvhyC42nOS23W04zRzQQa6+Y5HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1/0tKD4cIK3Vn5U2Qu1e/oZejRbFrABvAu5LvxN42BjYMgmSFOIjpzBXdUPUv2mA6IKOc0XGb7lPn1jskH8L8hN44IIZASa0LRt7IoFQ86+1zebzeoqBPx/WXscEIpn3Bwkxx+1A+QJYQE+nesUgrEHtg/k+gsZLWnmjKmcfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FoDWQDRV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-246257e49c8so83025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755817868; x=1756422668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyKY07/INwHK5W8rJvhyC42nOS23W04zRzQQa6+Y5HA=;
        b=FoDWQDRVJdAAy/6b2n/cI05N9Kz0auaOdpSOMm6BjTMuWsuh35Qxqr0IJRnIAWwyb2
         v49M/SvajLhGEy/gNuJixKIt0XMs+NmeKf1lnZv8+yV5bpDMheBB5eq5AarB/zctIJw8
         LVhHcXy1UTtiMqFGiWyIdAycNDXhN2JYM0f5iYUPEY0ol1rnYpMv9TMa7ELe0LA1jgiL
         +fFaKW+KNloi8GuoLo9CrPqLm8/SqMR0XmM9wXbGpIDTSC/NYFyXryoTd0DKYsAPPGsJ
         l0uLHnf/GrWm972CnEJXM2mPv8JwMdVrY1Mn3mouBvkPP7IEyDMQ9ov/lR8Z/oSRpaNp
         reKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817868; x=1756422668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyKY07/INwHK5W8rJvhyC42nOS23W04zRzQQa6+Y5HA=;
        b=eCC+BnlscycExX/wWb+tTw8tAUYmp9ptbgb/aoDwjpSzLKclLeceKRAX9zM2VjpAJV
         87Th2Mb3OHN6rd6bkcJShIYwyoGB9IXSgfe/KMut/jvuy83MhnVS2oyKaw8RzNorYzrr
         sb3dQSduRpM57aZM+9G5vM1gA+/LoPgGks8jo7ulClYV8qDNKJoCBrYOMBI98FfUfNLC
         VLPHbP7qbTGjjN+dnxlFu9B73nx/WgjpL+wozBQTJEr40LvaL13/rfWG0r9FQYobd7dV
         1laLi1tO08G6pP/I6nRDmBMch/xW17pv0DRdPmjyFO6EngZnRUzuzkY0fb8AKQAmMj5m
         Biqg==
X-Forwarded-Encrypted: i=1; AJvYcCWg5DRqv9VxABChMOwUGFcgo1glo1F4npep116TTHSbYXyoSi9Xew6PF230Wj5mYXd76GbZi3bg+2LDl+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiXQ7WGzqz1TXPZDhA78vNTd2Qe65IKyd1WpleRDVVCiCpwlz
	WB28CPJlkiSP6VR1E4MDAk4DWvRsHW3K8D+/qRa/XoNe+aIHC4Gjxevc7ETyIYuc9jiVXoRRsiT
	YpDZ9VFobCaInzXKIabHGz47lcbbvT8n7fD3NX6yK
X-Gm-Gg: ASbGncscSNkOxRWEVpnJT7dkmpbB1E7t7lRiNhGrWqWmZ36nCYGIEoaV7Eo5bW4FFH2
	TxYuk1pXXV9Z5ZIRhGk7sYqIHoZ629KPW2+NdzBaWMv5mgrifc0b03SJ3aP6elHKzAz3/EVrpL4
	RY+O5dtxNRfQJJPcckm1AWN8c0yFQ7I9VV9a08WiUuYBOTg8wu2RhvaUTX8zdNcSpOx0IjvGWdd
	QLb6cbigtk=
X-Google-Smtp-Source: AGHT+IHMkq+K12+g+sEPaH5nrWLu2Vc9mkfwX/OMztYDbNCV9MMh6/uJ9JXM5YbjnlbFQzgQhGYYxAZQd1a2jF+Uodg=
X-Received: by 2002:a17:902:e809:b0:243:597:a301 with SMTP id
 d9443c01a7336-246327944afmr1835075ad.2.1755817868075; Thu, 21 Aug 2025
 16:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819121248.460105-1-petr.pavlu@suse.com>
In-Reply-To: <20250819121248.460105-1-petr.pavlu@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 21 Aug 2025 16:10:31 -0700
X-Gm-Features: Ac12FXwQzn6UYBxjGSTs2pNIL46Ww1C8DAoY0lOp82FnSFRz3SdaQdQtgKNLjWI
Message-ID: <CABCJKucZ1WxDzROye-7cN3wFujV7k7pLsLXLd3Uk_fpgn0XVfw@mail.gmail.com>
Subject: Re: [PATCH] params: Replace __modinit with __init_or_module
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:13=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> Remove the custom __modinit macro from kernel/params.c and instead use th=
e
> common __init_or_module macro from include/linux/module.h. Both provide t=
he
> same functionality.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

