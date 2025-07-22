Return-Path: <linux-kernel+bounces-740951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58D3B0DD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F746188E450
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB12EA753;
	Tue, 22 Jul 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wot0JqVP"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC52E1724
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193102; cv=none; b=ErOgtrsRM3oKKiVC6gqTei3qao1F1/z2yraiTFmbbC+vqFNKxklI9lCVsgg2MUDgg2R4h2olvNR/wj1jMy+kyMQULJa9CwKaoK49Z+crcv9t4cyt65nZ5VQv1kbOhmj6wagq4xstPP7bRBvVkFjiFahguz95TBQ16bNJyLXYkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193102; c=relaxed/simple;
	bh=/oJFpL/qioW8vYik6ecZfIbYZuNesfEGbgYsl9ugCps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN+61rRswOQhDSVY4twyvRFujjzyZEb7cHcbE8aq/1uhbA1M2h3rZd3Zi3Aj0q63kh5L9BAcxhKE9uaSBBss2uoPtwXTfHUvUEUx4v8zaBJH7iFxOTSMo5ALiHB6zkaj/TutDWGUFeFDyldQwJhu4dZr6QKrSaKT1LWU7VFmZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wot0JqVP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so41279341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753193099; x=1753797899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oJFpL/qioW8vYik6ecZfIbYZuNesfEGbgYsl9ugCps=;
        b=Wot0JqVPEXkMSLT7AC7eeCvy7FXrJjh1TIParIHDUzTWLnxoOAOj+0zzarP1DNEmFG
         jjIxNgMnsDvTHsLM2j9eSqHPU+L/hy+wzx/KW5dUi/GIwSdc6b6ZHb85c2xmhVCGdMcr
         bN/W/wJ3Cdk47Xlwk/J6FiyFGvBFh8gpCzubAlxhuLrjL2xjBrAX4MJuhcy8C4LrCHbC
         Kt51rfa3CpeidfNsTBQmwFmEj5cjIEZXoGdKju0j17GkAlM/0JIsf1pexE6aovMK7kVL
         UeGm9Ykv9lGexGIylWxZxs7kQB9DyiYu092bSp2Kco3isQE2Wut78+Ns1jTNn5HZd1fU
         VlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193099; x=1753797899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oJFpL/qioW8vYik6ecZfIbYZuNesfEGbgYsl9ugCps=;
        b=q7KGQDQTiaxxZzYYztfjSEkbZGihz/wo3ux4sHfflkgdhEBl+9oOo6qzUUewQbm4fG
         WmJmmutBQtDPYuZWJQnhQaeuIp2k1qLpuTtS0NnNF21MyM0SnjuqPFqyQwAiz8ffe2+N
         KHnp393Y3d3SSIILBXBrbOip9SAiSyQC7Pj2uEeRLv9/0tW0JHMQSigcarME+lExCRtx
         GN9LyVsR+qgicP1dtqq1NLDh3GscUv8rCxnJNDLYfq9kDGSepREttt97NsNEcPhmKPb5
         y7IIb06te1LzWSlx160d0pocnq24+vsyUoBpCl3gz4apqtb5clXwlX+DmgalivIzubby
         B7wg==
X-Forwarded-Encrypted: i=1; AJvYcCUqx3Mdp68v/RpKFD+aBLWhMVNU9JERePOf0qjpSkGgCj5kAj46UQFKCXNV1AKsJXJAfQttxYKDIvTjx0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWN0GrVmOlA5PE6r2qPX2w5P83T6iz9oPqVJ0wELlqoLTHGgi
	xGku3Kv3+Xqrr+L8+GV5inlXsuEdUMS8fGI2fqEYEaMxGh7nQlKFKRyUZJ2hKXhJwwhcct90PYc
	lk6/wx1qmarvureWD5GtgSy212EmmzFusVHosBn9P
X-Gm-Gg: ASbGncv1GGgY4T61ghR9j6XThdEHlSmiwft2/DjfTux8aylnZEVn94vemIQD162uIOV
	ZyFcxVqccIynTeeTh6/bx9El5TVFi8Vqlw6E1XNOVUtoomJ0vc7V58F2jcalhe30xhpdPPNwIYH
	LwEJletgrYf6mdWzRPUPfgFxcLpYOtDptxEhmn4ZCedRxlidr4CvjWhL+qz+arJ5hZjg7GQp86x
	URzwu5mYVsoiWiX
X-Google-Smtp-Source: AGHT+IHfWFn0yBFNphwhG6GHfW6hWSddAmiFuPrhbHTKC8yPHWBWCSlcRrgV4lNzSaqZhZd21fW1iq9s7XLPhpv1Gxw=
X-Received: by 2002:a05:622a:653:b0:4ab:af74:e0be with SMTP id
 d75a77b69052e-4abaf74e17amr253639241cf.43.1753193098809; Tue, 22 Jul 2025
 07:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716081441.93088-1-nbd@nbd.name>
In-Reply-To: <20250716081441.93088-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:04:47 -0700
X-Gm-Features: Ac12FXxqPV_GV0PovyzMNBY1n0-MH84t7kYRdSouBY061BcCtVj6nz7uduEtEVo
Message-ID: <CANn89i+SHNfG3UxTOwr9kE26hbF-0_E7YJpt=3OHriMGLG7PeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:14=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> Only handles packets where the pppoe header length field matches the exac=
t
> packet length. Significantly improves rx throughput.
>
> When running NAT traffic through a MediaTek MT7621 devices from a host
> behind PPPoE to a host directly connected via ethernet, the TCP throughpu=
t
> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/=
s,
> using fraglist GRO.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---

Shouldn't we first add GSO support ?

Otherwise forwarding will break ?

