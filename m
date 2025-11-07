Return-Path: <linux-kernel+bounces-890515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C0C4039D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 134CE34EB04
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776F32721B;
	Fri,  7 Nov 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m54AXq6O"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C818320CC2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523847; cv=none; b=dgjlBwx50xX2d1ig3FXNqjif7hQRnl+4/7kReYao2JAibd6XKeSwMgpBcDOfE0ilNLR64K6aTRPJXvmH+5xVk7WKLkGwAaz9r1smye8oY2mEa5Avs14ZGx6akyo4pDxb4/a3F7gxQzZlCrknvNAiHnZp1ylTkMyc61f6/KsjfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523847; c=relaxed/simple;
	bh=pU1/d3gTQ3oOdrNMuwLNWQMPQlhrormAWhdG+nQqqZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcqLVlJ7gtzhrK/9fNTkkJdS6Qp/1Sznb+K8nl/aLALg77fzs2gvchxego0TpWbYfLo09biOCZZ/EU6G3+9cM3eMOBu2bV1/nrKYS/HNL/VgXDKMCbbzRRetRCJd+Dnp/tZRb7KiPwNGM8DxPOcYR3Btr6Ue1fg8Gwpwtn6DVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m54AXq6O; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a48fc48deso7279931fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523843; x=1763128643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmTmsZO+E5ineqtVbOXnuX3qzTxvM93F9HyZ2/MV6QE=;
        b=m54AXq6OPUT/DAxGH4PVrpXzN0MqFPPWaCfBPchovIRCdVYeGUcPBSKroXiNMY/1JF
         vcnFJTBbhEpnewuMK3IG6Kv5e/51bgUfk7ZmlSfGWOddsX7sbgY1LxZ2X2M+mYuftXk9
         ReAucveDqxqK2pxoK1nrbylv+nbYdRe0kPvGhJBhJ0Z/TshFvP1pkSaKfYa+h8v/Qpvn
         5RUbppmEBthm+uw7uxj2N+bPLYT1pgXwgKdUQwZgsLmHo6p5MrE1VlTM6hr7zS4axNbB
         i+SJ67Pj7B8JTPHy3Dos5eoft1g/g7DJmHOC256vP3Y6jp4wKwBbekRCQhBQXSXpOVJm
         FIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523843; x=1763128643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmTmsZO+E5ineqtVbOXnuX3qzTxvM93F9HyZ2/MV6QE=;
        b=EvXH3p834WfkFSwb7UTBwiTx3f7/yaNU2vJuYhtuZvYnr8prQPgCvtP0bgMJ37xiFj
         SYoP8AioTnkJWN9BZG/x1azNA/hI7/McAFNuqcdtYt2SpM9dtK978f4BrEju3QUsI4og
         Ci96sXvff+YDlKES2bIqUvTeDHVOaaa2QJ10KBHGgzxaXAJ/LAB+lWdI+rCV73dMw3eM
         QNudi0D5LIKP6yZ4R2Mt6sY7WhMugKn6ZDPR6SbkgLItEGzXRmBQjwZIM1ljE6n18Gtg
         HBpajyvq+wP5wZqxGAq3zOVZl9WHbbmjK0VrucZ1Vk/u3X97worqVsqNPmOe/WEYzgP2
         NxSg==
X-Forwarded-Encrypted: i=1; AJvYcCXeuMjhQLBHi3CX5rDOg9Z4YJkD0cZgdC1NJ7zouDGNcLxJlFtANc4fJZ8FwYwKfrSltCPoHW+CEMKt12o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfdiho5g2dvygCUGhvsZJFx2NaMrqeTbYTnTMQD4yXKTaJImuR
	XN+m8nV4Ph67N9UWeOg4g5GS7zqLI2nj3uaYh9iynx1+rKnoBCkYp6rp
X-Gm-Gg: ASbGncswHWZujPsEItfCuSxdBY882xEk2owazUP6wQv6aICTchuJbVDuDhDkn8atocY
	epYj4wmmC9n3gn7NgmYl5SSWtGqPP+vEU0CnYq09FHN74Efuv1TqzCbXK/iAkKcxx9m6ht2Gn4p
	KbXAu6WLLX6XTb3lvHMu5pP+9qTXKONa7silyzNuwuuN0mo1cDNO3MpxJs+gwTF0+fl2JGq6Pt/
	+W1BIUu4J+/4nLaWS41iIPS54RTUARQ6rv6kiEFkYtnTT+bymX5e33RaXPBcJEBrKfljqN50D0u
	0A2pCkea3yKS0d70weC17R0VeeMftEG6e5aEO9WuxOf+z4oxSCRyjhfZJ20op9HJkpCRBZso96F
	yd3oF1N0qeoLmfdHaenLe0hjEcXKEMUHotZQOA6934yvwOafSlfJzJbYDj4GPkTJcQ+0FGojGsw
	UkA8F48/xrcYwV2SUSljGSYN702SaWw6ppW0HWd9aEsfwfCTErupYbAnbnLA==
X-Google-Smtp-Source: AGHT+IGuna97US5S+FEJvdQXB1ZSmKd9d9FBrPTuZIikplId7oOFsTN/OD71KzPyK4H+bf41lFXeyA==
X-Received: by 2002:a05:651c:110f:b0:378:ec26:bac with SMTP id 38308e7fff4ca-37a7312d659mr6724151fa.15.1762523843126;
        Fri, 07 Nov 2025 05:57:23 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0790a7sm13094511fa.22.2025.11.07.05.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 05:57:22 -0800 (PST)
Message-ID: <5189f05c-136f-4ad9-b309-159607e6e930@gmail.com>
Date: Fri, 7 Nov 2025 15:57:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ROHM BD71828 CHARGER
To: Lukas Bulwahn <lbulwahn@redhat.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2025 14:36, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
> adds the file bd71828-power.c in drivers/power/supply/, whereas commit
> b838cecc2291 ("MAINTAINERS: Add entry for BD71828 charger") from the same
> patch series, adds a section referring to the non-existing file
> bd71828-charger.c in the directory above.
> 
> Adjust the file entry to refer to the intended existing file.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

Yours,
	-- Matti

