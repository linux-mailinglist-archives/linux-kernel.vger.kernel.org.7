Return-Path: <linux-kernel+bounces-891441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88DC42ABB
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ABB54E36D0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7C2EA14E;
	Sat,  8 Nov 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="awipZKPz"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D0286412
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594936; cv=none; b=Ah5T/T11J6ujvopQ9RS7v+kj8FLy2xXqaCPgAlG4EIsgn4fOgTq/irBq65Gz6WAoSP4ePAomftNYBTSkH7k4eyshfbZa7RRTdZLsuCV2KOBrzbrlZUM6gW6F9l9fTZ/F1ag62m85QlHIh1zAI50Wzy/Hw+mZkftQrrD4R1uAE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594936; c=relaxed/simple;
	bh=pUwHRDTnZUaY2JTMTyu2pTtjojEHM3ZDzJwHFa7V86E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NbN7m9VA0ZyZJ1HH00DYujAcsaHYQX7s+nfzJdnZEmCfWHtqaj7+DdJrM/XnEnI6PVLcv1BuZjpjfkmPScCOvWYRzrNS9Oo1lWsPzcnivTHPqOvxk6fwA7x9F0HtThpVstxcGNZOs5JwANpqo9BDJ27u/yYz2WwtqWLM4Idhhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=awipZKPz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47118259fd8so10356455e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 01:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762594932; x=1763199732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9YmxWtXYqkzVIIum7XUTZUx/6VEWdJTe6WXroNegUE=;
        b=awipZKPz55XQR5l0SdgcCOXPVWkZHUkUPolhsu0IuZfeOcia7lM/KsqxJETjmPCubO
         FX2R2Q9//vOSdb9W3jAVG7mYifIiqfIOa/SblRd8Y3eTyEEDKJua/kshFzvjt8JU7rIY
         ZSMXWJhrQus8XA6rXp/MQ86w48P4m9oGAfLuxVYvxV36kBgoojxqhq9bPXMkei9J4eTo
         lfag1f+7+bcfA7hnDcBfQbTsz5IfPZUlsUQBFIRoyinkZTlPpkWIMrI/Qwl9s0GwENet
         vIQlJNfRzxDxcVgarLznoGwJsPndhky0Bqthx0q/WZA1NUK2X87JE1Uet0E0akVUzgAw
         jgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762594932; x=1763199732;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9YmxWtXYqkzVIIum7XUTZUx/6VEWdJTe6WXroNegUE=;
        b=GMk7XJ2g2unwuRIuFIh8raxp8z4yJmoKtHqAb+QwnQ0Vnf9rCqu/xrxctH/2ffhxRm
         Cgz7v6DlO2Vf3O3xETdTZxMx3isBFS7EYbyxSQnqeIfN6sEBVAgkq2bFmW6SF9JmmUmk
         aG9VdcOETzRi3QGTyTuwh1V2nhvKql6FQV/pjJTEcntlugiUXk5HllkNaVhy8866qr5M
         +USPEVGebKvwn5fd8OzCz1jCVUL8vfRKAaOwJCih9R6cTuQWL7lKOHtdJBC9Q7Ngs+9r
         nZF2sRJhcgIS+R5yLgtTJHbcSx2tTHU4JaLIrHJzZCwAY+NnIdVRL11jRniFIlbfrjBV
         BPOA==
X-Forwarded-Encrypted: i=1; AJvYcCVtiYXMOD/NFq89T9be1uLTy8ELX/bX2Pr2yxJVnKetX5x2sBtlLXjyjIV2PazDU4UUZIuu4oj5zrWE63M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylr7KUY6KIDyGIwP4nq5/2m3rzOQXj4zmSDvBeHPE37BALmKug
	LanKxkDOFKkmWp1Y+3bz6rK1F4ut0BEt+0Lc5kZqEKhGdrXbo9aIQ2lAFf8SS57IlCA=
X-Gm-Gg: ASbGncvRtNfQ/kpnR66a/XN4efdXVUVrZ4UODfZz1HIxpFr/7eJUHEdZ6PmbSuniEOh
	G6QVntsE8UZT8EcowAtk0YbZQAvJSTG7cjyCeZ2MVc2zl8HO6lLAMoPl+kbVyHv3omNaUMl113c
	BpLbz+yKg7RzdXZfkPPN4nb72hoaC+CgnBGCFc0zOK7Qg1iINm5scLyx73725xXEFhUUJaQc5CC
	VPnuLunGpeQujYvDizjRPwb3aI4zF2XJ11624FDryNLPK1D/exLHSGuq/EhGpFXii5h8OeAn2hI
	2Cq9Ig0D34KjyQAlteUPPdscH/KKhpslv6UKRC3sw5BfI9XO5IAzNyK0u01hDBvp1FZSDyFRbl5
	GSBWRGRBcj0WqtOoxXCh+4rO+vfV+6YD8gr8V6j1C6b3Eur3BPvNo4Hof2dYNlKwg7OfeITlLla
	pJV+U5/kPnIM5ugyRaJ68=
X-Google-Smtp-Source: AGHT+IH3BtLqTQUB+SHQHAtRZHshnkzra2M/BuhwjfAVOXR0jPqldKeFSnSP5TDfhaeqsZUfxrXZjg==
X-Received: by 2002:a05:600c:1f10:b0:475:de81:563a with SMTP id 5b1f17b1804b1-4777328fc3emr14493545e9.33.1762594931960;
        Sat, 08 Nov 2025 01:42:11 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcfd2e5sm93911435e9.13.2025.11.08.01.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 01:42:11 -0800 (PST)
Message-ID: <8bdaf52f-0e4d-4455-a33e-d2151154589a@tuxon.dev>
Date: Sat, 8 Nov 2025 11:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: at91_dt_defconfig: set MMC_SPI to module
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, ardb@kernel.org, martin.petersen@oracle.com,
 mihai.sain@microchip.com, ebiggers@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250923094552.430595-1-manikandan.m@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250923094552.430595-1-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/25 12:45, Manikandan Muralidharan wrote:
> Change CONFIG_MMC_SPI from built-in to module in the
> at91_dt_defconfig. This allows the MMC over SPI driver to
> be loaded only when needed for WILC subsystem.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Applied to at91-defconfig, thanks!

