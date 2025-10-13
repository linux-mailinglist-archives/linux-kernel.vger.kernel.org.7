Return-Path: <linux-kernel+bounces-850106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B667FBD1E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556DE3BB219
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A56E2EB5D5;
	Mon, 13 Oct 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kXjh+Fg6"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBE23771E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342208; cv=none; b=r71/I4o2kvbOb+DlqiY9m410wbN2FVmEn00CzRwhc4N3de9TTvrlUIXNCBO0LEt1dnTb1budtDVlJTdMl3njQimha0m8vLvcFpsHvJQi+aXiF+STZXSLHNI2tSdkKSVNumZwi+ljNC8erMhgZR/bZnWbgS6U4amnl4YV1XEs414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342208; c=relaxed/simple;
	bh=sEIvW6x+4sTQzQpZS8eYIM18pCv2WKw2KDmKBteSd/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEZmL5h5MCyIljXmfjbrWVxMK5j+7sEwkIJkTMZqIGVsgKmgO1TYDHYx1stMkoL4Jg8yEQpB7nr1leVR/rxCk0rV+zz84hRj8aGkH8wV9XPPLdA6cztVBnXpHoPVsV0Y5Dr7vqkmCGykWX2X7CqgECxKBmun1hFuNmDn9pCJBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kXjh+Fg6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so20557095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760342204; x=1760947004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0aoo737rUcrndFNFlvfDOz8wB9RR5RiC0gdxVfmpG8=;
        b=kXjh+Fg6h5WXbH7vA0Q/n1MCItSQ4p1o55O+dd3lU+8Vf7/h0UTuCpq6JrxoKQnid+
         G3nC6yqL+XoOqeOW6oU2G0uBJzROSOons+tZh90WFSnTLNzV2mPw7E15IqRzXTYKirlk
         6/WCIg+lH8ycwbV7bbLgsR/OCXhu2hKCNLX4ilqrWjA4ueJtlBmQHOnblsoZnrVG/ahd
         t8VxqU3T+Hx20rECPu2HPAe6VTV4SB7yDs1ifvBkAJV3iaPVkBXmCPN6IGTJ+IxwECYR
         p4sLDUoyxvOgmy84THtttxHkYDmtMu7KR8UKilMNunhQ087ga5zZjkMDVDMsxTv7yj3O
         5law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342204; x=1760947004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0aoo737rUcrndFNFlvfDOz8wB9RR5RiC0gdxVfmpG8=;
        b=Qu8FbNjRQXsyo4tBnGKc47EgAJtfaniIBF02SxlIOwoAiN6IQ5Ty7qYVsjWfSDA9Zm
         AfF3BqEoIcbke/v2sipYBBZhU20dhuvW8VLQi9YjvRqF2xSTd6KMjcLHfqAznzylAnu9
         uMCIo++zQz+bymyYPKMDVHZZWkaevxVXmn5sFXM+MH2npcYo16P2agij0fXc3Qclxa1x
         C21lewNcy2roZ+7ZVdHoqbrXZd83l+5FNqD+DVF/AqXuwFBRqLn3RjZ3JrQafnufha0Z
         Vmk+qUvPEZR7cizT/JR//gphbE4SQ3NXSfE3KCejau8jSBMRoULxAbPKlR25o0BdT5la
         AZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUUrjsv58DIAjk5TjoC1axrveaeiV1lahijxyLOKPDNs0y3GJ6TBZfFpWL3nY99DE3cd94hQPcdCovCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6A0Y430BtW6JeYjNl/VSUh1joz07P8krXKfH/oP6RveuToG24
	VbeXQz4a8FFHVFiJDsLj+LvtGdPPkvb8dEUFkpo1OFo46+2/bWXLFPQBDRjRbY6tL+Y=
X-Gm-Gg: ASbGncvLTd08+NcSa9L2LiCmQq3JDE3QRk3W89f+ePhgj4s2caLDVdnB9enUZlSca2u
	LirptkSSqhWHOir/N1WiNFM/U0Cu28wJcdZsRg3ZSlHegmorZ6/sT+Sd4O5tFBREFHPEsm2GiDo
	9NBSfMDr4RBx2G0FjXNNQVAI3B08mzd12I/mREa5EXYzCHrOgTPsmRRKw12hAuNqShSC8NJL17n
	bxcdg09r3+VBTY2xJA62IdoPjTmxKqYCXXv+hxuAoKo2xpc4RARrwH2STg6gt0lq63fgpY8DqBe
	8DXnr1Mq7k6GppHIm/7jHCtjTIaQiOJ/taMpBaY/bElbrnMMueU3iMvnnuNbuC5kHyGb9Jv+bbR
	EEc698/YvSkkHncMY8VlRUet18U/QmoN/FTduTJ4OA1ST6jOrellf
X-Google-Smtp-Source: AGHT+IHbBMNeuHP6tB+J+HPOKsz3zV/StZbuZtzRNYS/jnkQ9BzVlYWtECo63vrhgtc/+iqlaZmKBQ==
X-Received: by 2002:a05:600c:138a:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-46fa9b092aemr121418325e9.26.1760342204324;
        Mon, 13 Oct 2025 00:56:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fc45:d50e:e755:a6e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb32a84edsm96545345e9.4.2025.10.13.00.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 00:56:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] gpio: rework debug macros
Date: Mon, 13 Oct 2025 09:56:40 +0200
Message-ID: <176034219937.9647.13899884811798472759.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
References: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 22 Sep 2025 11:54:01 +0200, Bartosz Golaszewski wrote:
> Rename the chip_$level() macros to gpiochip_$level() and reuse some code
> in macro definitions.
> 
> No functional change.
> 
> 

Applied, thanks!

[1/4] gpiolib: remove unnecessary 'out of memory' messages
      https://git.kernel.org/brgl/linux/c/0ba6f1ed3808b1f095fbdb490006f0ecd00f52bd
[2/4] gpiolib: rename GPIO chip printk macros
      https://git.kernel.org/brgl/linux/c/d4f335b410ddbe3e99f48f8b5ea78a25041274f1
[3/4] gpiolib: reuse macro code in GPIO descriptor printk helpers
      https://git.kernel.org/brgl/linux/c/3f0be1783a8ff57f77e6f9a12621903b5a496d40
[4/4] gpiolib: reuse macro code in GPIO chip printk helpers
      https://git.kernel.org/brgl/linux/c/1540b799d271b545bf04726906184bdf29ab272b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

