Return-Path: <linux-kernel+bounces-847131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B45BCA008
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977171A63E08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06942E8B74;
	Thu,  9 Oct 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miU5UIJT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61F21FF4D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025421; cv=none; b=aLnDWvapsQTz67wqt75X8h5fqiVfRehm8b/TdKBJXAUXS0y/nzBjRQI8WQxURIsjjNF0VcOdeZmxKM9ucWvJIHkkLNcoxawv+RYflRHWPosR3uLI7n0T4s426r6AOR0gjruuoYm65szws+tmixQ43JRAGAoq4gyLY/WuqIpHjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025421; c=relaxed/simple;
	bh=fEPjMABZJqK2RV7aPLAwmCyreoCKrgnuKQ175KZEw7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=PVVORYiPvZWKpjq28c1RxPi7ZVfnzY4/nODY7LyO+Xa4+EO+dSSX8LWJnmbbrprNR+M9vBYonNN4NBYyD1t+Jea2n0p7VZXuocUpXpCE369l+HVu+lLQQM28sGwjeKoKwcswAf6VjkcWYGNSF3m2SDYp2TU3FHjZUjTjP7RMlH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miU5UIJT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso811931b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025419; x=1760630219; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgo3KudljITGQSuGvHmW5cffvohs9TZ6aTPtPKYUDQo=;
        b=miU5UIJTb62u6fi7DEk4gYEdJb68gKcH2l3HvT/cV2qBeAo4YdBA8byWePEXY8N7Ev
         pure7uVMLefE7qeO5MxlENEEN6SxD6V+XDmrICyoplzgWcfOLAFssCMTI1OYFQl1fWft
         p8dBPIX2cTW0y+vcYqD4tAfNMg6qyOPx1k+fxjL18nELU7c6G2UxWTAoJmS74noFo+Oa
         Swgllip9u8wXjuPN6ygj1r89rHyAZww1ZCyv1I5zNh3i3aOy7EGoxfPTbtaD+ba206Cg
         CfprQxYExXoDRBQEY+4G/mvNE793vZvbo2tzMjVol0WO8AM/1my9aitoti6vx6pgDIwH
         RAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025419; x=1760630219;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qgo3KudljITGQSuGvHmW5cffvohs9TZ6aTPtPKYUDQo=;
        b=XR4bccMPGKPgT3qRpst5uW891wbm5iqFVmITX9km2JdREil3JO/XiNzGFA8WZbQakM
         jO0iNtQYCM8T5EUNIJ5J8NOAFTkqqnC+Gq9oSnGB0XJH0VHtFbH0d4YKxiOeM3mq15Ys
         /TSBk7xCHjzrba9Ta7byBeXPX+OUrTB3bh0X0a63EA4kwhCT5J80lk7u+hS63NtSIzkC
         KZMJJUjGdChsrq83vNcYaJOJIqvLEB1IqnUo1bj1jXjILVlG5rvu1IphQE7xKq53avgf
         jt5kNBL6GHExZrsthOJY/PKAwUrlLgI5fbHIxX90iwILjrttEvF8ZcC+bUXli8pKg96K
         wr7g==
X-Forwarded-Encrypted: i=1; AJvYcCVIx1xMxdh+XULmegXeDSaxoT1hr1dOO3YweOQf0pGv/HlHomGPJOJ39eEcOMJ6bgb6xA17UDI75AMCsxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwGE+X/vVBo/tqH9MS3q4Z2zbgM2GDJ31TXfoUTI0VB58LAZj
	KNULRnO8y6IK484d16de0TNRR0cNrqHAgj3mXnPDF/XrDBpP63K0vlRN
X-Gm-Gg: ASbGnct9gLk9f4yB/EOp3C74yOO5b2XCNmRYqg7Dv3Amy69efkf5jX4xm6LPDvC9oGl
	0T5PpfIXHjbQCYmZd9jb7T0UI2HcRxA8LwN153nQt/GLehXtErtPmbLIshYFg6Lp+NjN0Frw9lU
	Ry1dxPkSFfwQXQD0DA+p5xy6PtW0tWauc9sr/VSuSJllEfxkWPJpv8Y97llpkCpAd2RL4xSFczY
	yMck21zBZBk0573PD4wnu4nx8ihecOrzQvZsqo7IxKcxHGr3Nxe4smCDEBmFN8NUxcnmrCBAh0L
	yhAHvYp8sqc0KFGB0AqYgPsnpdKXd5vb9jZkq23zlFEaa8rbFqVyKsSSTS5zR9InI7az1l5m8OJ
	l0Jkrfi4CREI7foDHdApSk/imQ5FGbvdzPsyQh0zNdBE=
X-Google-Smtp-Source: AGHT+IEFf2RnfqrbKgLS8ZhhKtvMKGc2UMdAzovJyGrgaoGsX6xngdyLDG8NWdEBK5j0gpEaPZA0hw==
X-Received: by 2002:a17:903:3c25:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-290273ef107mr101385425ad.32.1760025418779;
        Thu, 09 Oct 2025 08:56:58 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0712fsm32711735ad.71.2025.10.09.08.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 08:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Oct 2025 00:56:55 +0900
Message-Id: <DDDWXTRCYVDA.33VBJ38T4QBXH@gmail.com>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: dlink: handle dma_map_single() failure
 properly
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251002152638.1165-1-yyyynoom@gmail.com>
 <20251003094424.GF2878334@horms.kernel.org>
 <DDA4Y2GRUHD4.1DFHX01NOJYCB@gmail.com>
 <20251008091346.GO3060232@horms.kernel.org>
In-Reply-To: <20251008091346.GO3060232@horms.kernel.org>

> Sorry for the slow response, I've been ill for the past few days.
No worries. I hope you're feeling better now.
>
> I did also consider the option above. That is handling the
> errors in the loop. And I can see some merit in that approach,
> e.g. reduced scope of variables.
>
> But I think the more idiomatic approach is to handle them 'here'.
> That is, at the end of the function. So I would lean towards
> that option.
Not only with `goto`, but there are also issues such as replacing  `printk(=
)`
with `netdev_info()`. So for now, I'll send the patch that fix `alloc_list(=
)`
correctly.

