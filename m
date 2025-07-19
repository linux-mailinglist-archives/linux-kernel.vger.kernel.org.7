Return-Path: <linux-kernel+bounces-737812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91CB0B0DD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB3B1890322
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C240223324;
	Sat, 19 Jul 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FvguZnfM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2621D3EE
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752941297; cv=none; b=hHsHeQcgm4NmGxNT3Peoy37oFliTn8k9DRIUHYQbBKDFIjAubKvR7jsrKemL+yqvy0fZCktuaLhFGi+r4s/OrTBwH36uJm+xrZA/YLREc+LehXg54gYxkDk53u134OuRkRodXLrsu+bwOwwLEjamKjOjvYWjYYGTHpus3Ro934o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752941297; c=relaxed/simple;
	bh=5SiHkdSfMvJG/38SvtyuLJIKJ0dECiYN4f8f1myRAcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj7KKRiQ/0eFzqzTKpGFPoeVK2PkUT5CxLAz1ezt8GuyjgIEjkGJn0r+Z5zsmMaK3y3jcZeBjrzTSPzRjJUkIAcmLQXwQGO4iDCpsQ5m/wZ00mAmR7/QMw026JHyOMDtoRbauXg8fh6xlBdx98U5kwf4s5D8H2LOeRUuRDjqOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FvguZnfM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561607166aso23365705e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752941294; x=1753546094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTlKTKLRAHSXeKTWI+ECpHm9HjExYSOWdZ9iUWEg/Lw=;
        b=FvguZnfM13nj2QfDtXK+0eshzwlkEOutWDDNgHGr8SzYta47xZK+5K+mXviNYe28Bl
         RC4wpHZgSUYzOyPI743rCUhYrDj6p7EbP0IV1Ksoqz/+UVMuMr9WoJImMKtKOT7Nv72M
         dkLvQnM46VMQb6Ef/fSyEFPR7fY5hcyv5kuXviZHhv9Gp8DMq+XQsBdlyxW38KWQuMA/
         IqwQ3OmzJCMQhuMKvuJDU44yVMjrxY44PSwYCZCZY4dqvBl3ALhouS1DwURRNF6GaiA6
         KH7sprE90Wk2Vn4IRBHVenWGErYiR9Yb4FJKokApUD6tnm/o13cuLcciocTrlZJn6Kx8
         j7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752941294; x=1753546094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTlKTKLRAHSXeKTWI+ECpHm9HjExYSOWdZ9iUWEg/Lw=;
        b=ZMwAajFHbUgLovpweyXCdwBxD0GoxAUpIXcJ3D+VdcU23HfvId/rq0ZZ6cCqOjCxyF
         UakY32bLUearUdlVBN+p/YrStpAp0/Bay8oVkD/A0cV781efPVPY1EUQ5zCEwRo2XNbW
         x+5wkJUwVzlpYgH8Mh91vBQAQL2NPlO7WtSfc2ezOqo9RwOdolMHoIzfplboLX6tWwJI
         YqggaIUIQ5x0XIeagPRJWCpvvFHAkq7+KABfV20CiB8DF49W00Alle/cCcU/M1ozL6Zn
         f/mXLC+oiwyVIaZa320xOHMFFqgKHbka2Ln7tHvjK7xmtWydSwmXOd8FJ1tUQMbPUUWT
         bKWg==
X-Forwarded-Encrypted: i=1; AJvYcCXFxL7bvyitPWa9x/yTY/hzN3mL7YK4qYYnTvOUsMXKcRvFBnsAJutthmdDaQQHAsV7i5/gNl7NFXNAy/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEN7ZymqhvTTO8idt9GpI61HdYtE7B+R+113EjD7lFK/yOmIv
	+z7n1GXsl5ogDvT4QRWImXUor1ai/8HbC0yqfycbK7VbpgXUVeKIs2jyby2jextzZn4=
X-Gm-Gg: ASbGncuGwTzWM7+vvq8GarFeSD4TOFiF93qBBJwC/JMGdc4/RC8ex7bd+QjlRv6vyER
	Gx7q6BZdmVZSUyNCFjm1y1T7U5/gaafYANElMmFlwm28T9U3h7pc4n3s7EV0G0i3gdFZusvYWRW
	WAQoFKAkpSOEH1mH8Jf/7zCKJfEvj62oKXNADUwUSG1FASAyvqU+B98vLHtTWbEqQZq7XDymZHi
	WUtAyV/kqyofEaNtX0rjAbV9TprvHsytxlX6n1x3yLT/Oo/lbn6POZDZ8EzYYsnjS0IMxNq8BpJ
	OdR3cZ+/lXHYUDwHNfXn3TZ/dFIfu5Hzdzkez8gyxgEE8e9RMmYiwF+ifM+nyY7IqpUxlIuY9jt
	MXLTpuL0g0QXmFOK0SBljCQ==
X-Google-Smtp-Source: AGHT+IGnOBvW0E6NXV1F/jlGY1sueqHdOmWBvkE0ycL/8cWGRkeUGSG3bu+eguNmgts+kPclqi1RAw==
X-Received: by 2002:a05:600c:64ca:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45630b6d6dcmr139212165e9.30.1752941294010;
        Sat, 19 Jul 2025 09:08:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:caa7:1023:8441:61fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f8a9sm51500725e9.26.2025.07.19.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 09:08:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] gpio: sysfs: Fix an end of loop test in gpiod_unexport()
Date: Sat, 19 Jul 2025 18:08:12 +0200
Message-ID: <175294121708.8606.9732156006120686279.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <747545bf-05f0-4f89-ba77-cb96bf9041f1@sabinyo.mountain>
References: <747545bf-05f0-4f89-ba77-cb96bf9041f1@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 18 Jul 2025 16:22:15 -0500, Dan Carpenter wrote:
> The test for "if (!desc_data)" does not work correctly because the list
> iterator in a list_for_each_entry() loop is always non-NULL. If we don't
> exit via a break, then it points to invalid memory.  Instead, use a tmp
> variable for the list iterator and only set the "desc_data" when we have
> found a match.
> 
> 
> [...]

Thanks for catching it. This is not obvious because in normal circumstances
we'll always find a matching descriptor and exit the loop via break so it's
hard to trigger a bug this way. Anyway, the patch is correct so applied.

[1/1] gpio: sysfs: Fix an end of loop test in gpiod_unexport()
      https://git.kernel.org/brgl/linux/c/5607f5ed3c5f30f41e72ce09c8e616af0fc0d474

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

