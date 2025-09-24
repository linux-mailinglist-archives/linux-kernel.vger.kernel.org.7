Return-Path: <linux-kernel+bounces-831241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D6B9C2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBED168BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92849329F19;
	Wed, 24 Sep 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2SakJO1"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A525783F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746569; cv=none; b=GVO2+LHcT0dtHbAVHzMFKRnyX8mZL2d/ytaLlZ2FBOlgswty9BuHZGsApJRoUomsjakVxrFqBdvpGBFxPD6SMElGfRhiEtrUNpqitJD2uejGqpfE2T6k1J0cwZtFVVQuNrIB3hVdiAtlAZFDH6egqvpI8X8HlT03zZvjRuQV0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746569; c=relaxed/simple;
	bh=Ucz/i9AWOR9GXa1xL/rpLdGn6X6OtYj7N42zAdlWFDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh9PwfklD2t7jk0h9w+2w1+0N2X7JGulmjQccpW5aNH3RRCNITq0+F/ramDem/IXz+UGhvkIgMtURwrEue3TTWokHm+efTtujeqgLtz2MnxspvNdDI4Bp4SKuoqzmSfyJ1zl4Ij1LzuLkML6JIIHoYF0M2Hkur9r9DGDxy3m5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2SakJO1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso199585e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746565; x=1759351365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYnzcg/e5OYQohYl91H+gnYqtu6/MdF2Xt8l0Tcfgig=;
        b=T2SakJO1vr3FJERSIz0kEvL/x3IgIfeNLG9Zgp2GR/oP2UgIVxJm06L8A6Smztpr1i
         8dMok9N8R+85Eu8IcwwipwlxaTf5p0IA7uY39uUDNBhrOnB6A6qsBd1CKoYG9UABRSqT
         TI0yhoHXxwMG5Nq6/182c3ShLaw4WkL3ZVMrv+XZm8GKC/34kN8zEMlLow+EczryORoV
         n5Nx2knt0aMTtQCcShYZewSj8L1jJrHabi6sNht8tzK80w1jIufQDHuSRXcslwzJDJI+
         yXSkJMTMc4dAS/MMcyioPGNKas7HlGmuaf2TYpKx5Ilro2kjo3feoAX4KKiknzkHF9GW
         Ifbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746565; x=1759351365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYnzcg/e5OYQohYl91H+gnYqtu6/MdF2Xt8l0Tcfgig=;
        b=Jx1ccjbY7CdT8Jmsk1cn+0oO+TbavkCE9IgP07xx5RhZ7idCqgHYfE0JmO7NEjybPL
         2qn6+7hBDbLta0ayoDzbjaQAyFHwMaZf82YkBmWTVPzfZMFhLr1Z1kipLLFsS+XtLFqj
         VnPl3lFCSH+B2Mxsnt6mUa57Fboyn42EiaJnywgUkd9e29hRvXUkNQcaiUeMvPESgSdb
         TuGNMwssJXd6RKcvPHXwEZpc9xqqUCIilu4TE3mxL0k2hN2i7+/KHu8qgy3Tsf3LdQoX
         nu0+CtMM+FuYKoxxP7ObQtPtgwjA9j/OJpWF0QkPtGBglYBohXA0YRrQ3wf9xZpa4iUQ
         grcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIn5Mc86nbfSZUwOR40ZnMAtaIvvbUu/BQpxjwav5PiSTG+06W13qc5SREASCtI5u+MFrhID/sFkZK/JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lhlSrxUDkDrgU2XqinCqQHByO3UnA1P0JnefPp7QuKM0wTGC
	qQYAf8BPFSvwqsEdLtofiu29Ck80+pUxHHDDeH/2YO0C44wdMzpoaMwp
X-Gm-Gg: ASbGncs+eZuEm7f9fvWLt10e826MIXTnbCD5vygBwqs37Uo+AZf2o5KJ4Wlh4j8h5TJ
	cXEijt//pUsOomP+ErpphKmnyudIl7LUEEYKSmv67abg/nxnJYEOjsIdRoFG7W3cN5qRM3D9zBm
	WpLjiOa+QaPf8zjJ4GyuYj2kk6wMAVtg7nPqa2Wy9EZBmBawdFeTRPa29KqIfTuswOrYK3LFabA
	TZMw7BGDb+idNVWCOdkAH9zbIrV0beVdhhZEQA/UzhRMlmGnmoFNTLE34Vw6VOeoeAP6BmJPQhW
	e5wBe0RPBP5JLp7J48hg1MQVdHUWeL0GKf+G0zrBzHmz7B7ICIuMomPzYir5H+u9yrZbSswj6w8
	QTkna8av8TN7XTrGzq0sb+g2JhwcDSdMhNvk=
X-Google-Smtp-Source: AGHT+IGyzL5f93thSN0PEzq2w767/JoDNWiJBH5bF6LdKrr9vgdH4gRJ604q0DP0F1tZQOVY9vZyEg==
X-Received: by 2002:ac2:4f0e:0:b0:55f:4ac2:a595 with SMTP id 2adb3069b0e04-582d0c284e2mr270160e87.16.1758746565220;
        Wed, 24 Sep 2025 13:42:45 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166560dcsm368e87.94.2025.09.24.13.42.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 13:42:44 -0700 (PDT)
Date: Wed, 24 Sep 2025 22:42:39 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924224239.3ec0fcca.michal.pecio@gmail.com>
In-Reply-To: <20250924195055.15735499.michal.pecio@gmail.com>
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
	<20250924135814.GC5387@cabron.k.g>
	<20250924195055.15735499.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 19:50:55 +0200, Michal Pecio wrote:
> Do you happen to remember what was the reason for padding all TX frames
> to at least 60 bytes?
> 
> This was apparently added in version "v0.5.0 (2002/03/28)".
> 
> I'm yet to test the exact effect of this hack (will the HW really send
> frames with trailing garbage?) and what happens if it's removed (maybe
> nothing bad? or was there a HW bug?), but this part caught my attention
> because I think nowadays some people could consider it "information
> leak" ;) And it looks like a waste of bandwidth at least.

Sorry, stupid question, such frames are illegal.

That being said, I see that other drivers pad them with zeros or
other fixed pattern ('skb_padto(skb, ETH_ZLEN)' seems to be common)
rather than just DMA beyond the specified length.

