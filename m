Return-Path: <linux-kernel+bounces-809707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A6B5110A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F81046131E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF030E83E;
	Wed, 10 Sep 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LSoikkUo"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AC30DEC8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492118; cv=none; b=Zsp2foEkGJ2v2n1DmCee0tUkI98e2mx2L77xrKeedVhH2dM/Nn/krvVIhnCIwVvmDxECXbw63YZcs1O9yhgo6tL4qvtjkhG88F6e8kWuprvI2rqvvMvodMf1jK0DsxZWXUQDeG1zkxaWVM4OpjOTqia4u9WoxDTKJEqJLfqOYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492118; c=relaxed/simple;
	bh=tF8LpkJ22cQEsJ0sRitfP7ZwvVBY3997D3wsT7ETdpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpYomOiiaLLlhdYhQu/RsUjY4/cGvIYa3y/2aR82kR8/JACHpD9QocpqTM5Jy2Z/cnnfG8l16fmxJgCjF6zlNi6sBL77JbOF/Ril0Cy7BWucRwRtDGFNH+hBji69GpMFTXa1g1QLQjxwAY+Wvss0Qzz5mivUkOWyZgkG+hu1T4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LSoikkUo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb5492350so42420105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757492114; x=1758096914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwU6AzP+BVSq2Of14qRAymDuhCNu7ThySnEb4q+EocE=;
        b=LSoikkUo2zJPYm3aF5ylSLw476IhHqpGkVeXF8+kTpUMJ0qnMdMvLOMBpn7Cm7xN5z
         hvedXQ4LZcgoxB+KDE7SP5GZC5S+f7JPM8q+C39f6ZXTkOsEiHzwtiFPHjjKtV9DtSv4
         KgnVlRSsVJ8wlU9jQzfwVd3rge9COxKBYlAJPOCRM1lPRPsRewNkhfD3Z8Jdyjf82dRQ
         jxqmzE1/ulttsMkKi7APfbEngCTo/aPNpQqvUn9LUXe4At4nBlUyvol/6eFBKdnYdMwt
         SV25XaRwIf7PmqfiZSaqPWPUjKyHtWQEmjmbSZZ9Xht2CFvrFTDj5djC+QD2kWuyew/X
         oxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492114; x=1758096914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwU6AzP+BVSq2Of14qRAymDuhCNu7ThySnEb4q+EocE=;
        b=lSmieA2eTpgFTQCEgpddoQZ4TkM7CK38l/POWp3ayWOm7LURBC8uoFvXVzjbtcJnMQ
         cn3thHCOIRipTQ0FY8ODWoi6HtF1UNB8Twh2FNQNg18PcBjpy9/49IWw6+Czz7IU7RjU
         UGHLejm6oPZlIDl7ChAdFIHfyMeCh5zNqx7DnWvzwi+E9JiSx5j2BByuea6fnvs+eBOY
         T57QLauldVdRIUO2JKDZNtFY2YWm8mZaNgjB4Mp9djX7gkQNpwL1MK3fP0bKKwF0fGNR
         XxSghlr5pjEkPPpjvY8ArsH7OCigRxguX4uHvPcaPpldAQv0jPzA43Y9zDvZtkjSkFm5
         ZnhA==
X-Forwarded-Encrypted: i=1; AJvYcCXtyIBjDNIQ9UXKZux87ZQKKkJ3XUjonjSHIvuan1NeZNTh6fF5q+isO0YvJlFKHQK+1NPETgqbn0bXd4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHcsZcGU5YtMPhFma80GE/OuyQ6jhHp0tyiVEHWb4+lK6AbfL
	9J/Uf4Hew9Y8BfPZKPcQb0CGBZYUDFooW+CE2tIiPYIxddY451s3vEkbhHLzcmDqL7w=
X-Gm-Gg: ASbGncshMsjgHJ6RP5G+3+DqCypMio5L8tF9fI2g+aubisoy8poX/QolK2Ufx8eKUHU
	0zIZT/BdwB3DuH/09JjssRYEF9Dx7bWfx0myM8jNcEYSp/NWhtLSZzsypjrlR44bm0ae5i/a2P8
	qf9fdZShFCRMwZB0a6qIvuIsiVfHdyV/pHxA9aWoN3Wk7k4rK/Mr3Oi1QtEH5oa6FVWDFDfU+gS
	1dl3/FjPulRjiI+5S2PvLevaVBWQjLG+C8dVcXpKtAxTxHiZfoyyzx5lP6g9mDVkJsPVbki71eQ
	XxTLnAhkNnlHWhdDFuNa6fEgEBAma7ZK0hJ9IzX/svpgLsiz/k7XLDz2cjDrC47CBRhY9sNT/qp
	BtIuHeEjJgLj+p7lJssV8sjliu/pQCwIp+w==
X-Google-Smtp-Source: AGHT+IFe2wPN6Nmyi5ZfNourrl7iXoPp381GTFJ0zjgYb794H8ra2ZWQb1U1PKqnmRoNzo5YN4u0mQ==
X-Received: by 2002:a05:600c:1e21:b0:45c:a955:4578 with SMTP id 5b1f17b1804b1-45dde02878emr113926945e9.21.1757492113623;
        Wed, 10 Sep 2025 01:15:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm18650015e9.0.2025.09.10.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:15:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Yao Zi <ziyao@disroot.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-gpio@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] gpio: loongson-64bit: Fix a less than zero check on an unsigned int struct field
Date: Wed, 10 Sep 2025 10:15:11 +0200
Message-ID: <175749210857.28519.13259779376506560732.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909190356.870000-1-colin.i.king@gmail.com>
References: <20250909190356.870000-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 09 Sep 2025 20:03:56 +0100, Colin Ian King wrote:
> Currently the error check from the call to platform_get_irq is always
> false because an unsigned int chip->irq.parents[i] is being used to
> to perform the less than zero error check. Fix this by using the int
> variable ret to perform the check.
> 
> 

Applied, thanks!

[1/1] gpio: loongson-64bit: Fix a less than zero check on an unsigned int struct field
      https://git.kernel.org/brgl/linux/c/4c91b0ee35db07ae017dce067c64364c7e95faae

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

