Return-Path: <linux-kernel+bounces-861604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4DBF32BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B83684FA6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062412D6E6E;
	Mon, 20 Oct 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cXBMjwhh"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82F26A0D0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987865; cv=none; b=gWRB/XwmI6O0YXuSNNJpmanmtqBgWpkfv5GENsuLVXCAZ/OZJQTozgImJ7hkPfds0RuzJB15hSVWxLGA5e8YHcRKRXph9L6Vton+dAPErlffTEEbKcC+F3TXWfa/EZQ8GhAzQQUP3RoHHs1rFCbMkthxE1klKwPhDK8v1Nu3TaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987865; c=relaxed/simple;
	bh=rwe67KlzgVEU0q6posof/Uf1LS61e3v2dpbkz+mjDGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jl51Hqtk0LGUEHlZaVmEwp3TvwJAWM0iNSwRtJ7v2r96WtV6tuMukumjr0KI57s1709VZNwWBHW9XzSInHXspx8+8diYgLtUBWYn533A3towCSchCqJoPMqow1XBAOJAFUD/jp080rwvXujSp86LZekOQ96KJTS+0HgFJSkD6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cXBMjwhh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4283be7df63so1272131f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987862; x=1761592662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3hw419kHIanWXI8S7q/r2sYT6jc1swylj0x7Y5Ea4A=;
        b=cXBMjwhhJiK6yHo9TUOFPB5y+KOfGdmBos68jAXLctZrNS0xOTP+waqLRT+/56sIaZ
         4tIg4AR8zswgHSOxaIGYCctSqGb7/McigfRwAmLjyrqp84P7+GfL8YIZjM80UAH8jY5C
         bFlehrNsu00ry18LRzzU3cTbbY8/wNyRkayMGd15ffVTVFpuk5RnFr1TcGdPTLAd7YmI
         C4pS5EcbeQIGA3UgJ9tSGUvBpDVL5pK5w+0VRZTwMJPL+DAN7Y2h8sX2qxZKgpMMKa+8
         4UtLVI8Re7CClNQp8gy6dP1Ab5Lv5NpVbh+mVUIJesuZ6UcM2l5heo9b4krWuJunjX3Z
         PhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987862; x=1761592662;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3hw419kHIanWXI8S7q/r2sYT6jc1swylj0x7Y5Ea4A=;
        b=ms/2UuZboZvIyRQFtJT0Cx6IqNjdAX7oK4oHDoP81dMp5PHkHyx26lc07vjA0C4ifo
         z/3fkhakI2aIbwRb0OAXhrSrB7tya+e6XW6rmZC2viJlpYh8v0FG8DprQJl6yNkW1xaz
         T027EX4PzeoC8TxI5jHJ2zGLCQI/c7XKiDWoalXza4PMo7Tbl33wUgu/se+sP9F/zgQ5
         eHisAanN/x4r7P+IdiJLqkmazXse7rZ7fUjYr1zB/cFZtepMkZhxRgLh9PBm2dQcD4Yd
         iNy+XrYjIcE8y9e34LbWrHDcftp11GhWHUHpwTF07mMoocOcmXB6+qRbWjr17wfE+AY0
         VENw==
X-Forwarded-Encrypted: i=1; AJvYcCUScSDAGZDNywak+34MwdsObwKtVTS32ZTlkw4H0rKFQwcNNx2ccbffUzzCpTYy52Y66JnjCOCFH/3gCSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oVmBUXJo5NQBaYQkk6Ld1Vgq4w0GaQmpGJw41MaXq01ddBx4
	FMP1FIoqVI4KXdiUx59s9edDr51xqgQVdPYK1Igc8p1hO6Q37H3wwnQIC+D/cb5XO6e1dw/7ld5
	p28gx
X-Gm-Gg: ASbGnctICsmbbey1hUfY7WUwG1EMTG0hFp6L59KqkaEBTCZfZnwEyeNcnkVcV5zg6mT
	EsEXD1XNsGQ2f2JnGIwi27Efu/EadZPg3HGDBtrnuf+hTP+ye2G1NBcVMQRHpuMI5Uxl5VxiGk8
	Km6Ru07BcaIoyc6e1cFAsKljhYvqLP1CHfbIJI0dHdaEpoa8dSyqRLqA3hIax0pppOLM63p7R6o
	fGViue3KyJKEz+7UCJoNi8QeY6kNQLGWnbi6gSVPt9q+aq5vKQY6tty1d6yrg69su4+6I6OVmOn
	M3rJL6VrbPWt/otDmN3ExIv+o+nZAhvCkhSRABR5ixL9mWZCSUNr+gBwybspIZ88eI70bC0FbR5
	CnfX35SMnBHibUMnUqlWPLLRm7mhR8+AI6sOXlrWE83TtAxbGNYeqrc0HrxsoyJCP2M5SYNQ9d2
	CMbaNf/qkmoGT8r0xdq/w=
X-Google-Smtp-Source: AGHT+IGK6tHTgvB0+6Qz+f3/Hvkcp/D3IAI05W/uCv4j1nGOxIb4P88xZ43wqUbIHoY/frZXUcKPpg==
X-Received: by 2002:a05:6000:25e1:b0:427:580:99a7 with SMTP id ffacd0b85a97d-42705809a1emr8127287f8f.59.1760987861989;
        Mon, 20 Oct 2025 12:17:41 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm16797899f8f.42.2025.10.20.12.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:17:40 -0700 (PDT)
Message-ID: <ebe90c15-bb39-45a9-9016-e5ec864e549d@tuxon.dev>
Date: Mon, 20 Oct 2025 22:17:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/31] clk: at91: clk-slow: add support for parent_hw
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <ba17012ff9130fa50954163a07c9dd6245b66e21.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <ba17012ff9130fa50954163a07c9dd6245b66e21.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/25 00:16, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add support for parent_hw in slow clock drivers. With this parent-child

s/parent_hw/parent_data

> relation is described with pointers rather than strings making
> registration a bit faster.
> 
> All the SoC based drivers that rely on clk-slow were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---

