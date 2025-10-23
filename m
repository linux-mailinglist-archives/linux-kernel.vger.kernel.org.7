Return-Path: <linux-kernel+bounces-867711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F0C03562
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6129E4E8509
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F134DB51;
	Thu, 23 Oct 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFgXaT5x"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B72DCC03
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250431; cv=none; b=htoKoQuw4CcU3yiUiALPIkZiiCgwKz7YXxFkfl1Xx1Ql6a9XC8gc1VGp+6LqygE787oBLP5lyP6mQ+LJFt8YbGxJ+CDhTDdcGHzPlTsbIPfsJEjE4o84P9GusQxkOZwJdKJRhRpNuSo+pXLYZ4oedVzmuVOCzJcmo/2LiWA6aoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250431; c=relaxed/simple;
	bh=i5rElNkVQHLPkzIXomnKwWEfC78FAMj4OakO3rUsQtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X841LOhvt6TpzUahXoqCvDcIzlzoHRc39Oqj8nHYG2E9ryRXiJaeh7fTsMMv9Q9arr0HO+sYN3bDN8VrLcSwnrpuXBNlHOFVJs85VGEzipmQjJdGGX6k64nOheFuy3D6pV+1x7xlyFWmXX8BwE57nTlFuu895woPlsV2oOKZDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFgXaT5x; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-421851bca51so1151276f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761250428; x=1761855228; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2hwEhUqYfYT/qHtg7r3dYTALVK2W+Pk3Q38aU4IIw0=;
        b=bFgXaT5x4Bq6nl0Eoj8PYj6isz+EWfFCFUV/1EusZxC3HNMLwGlIj1Xu7Zk1d1dlsO
         u8J2Q8xWB73ZmEh7cujHIOHiZGBimTdV8RibCKbOJylxHLlE7VZ7hasJI5bHrb7XwEmg
         nv9bpp/Q0z9G4Cqhbn7ItATsL6YcDzNV6lWhfktV9vo3kDgZqxAt8zfQRgSgdEYMK09R
         LSmX/yFl74KbnpwZo1b4ZhZarGacXBreemyj5vmexr4A0MvktLa9cLe70jMqrsKPEo3I
         sjP8y+BnVYPg7T/9t2hOAURHQKtkwxk9sZyAqbUhgVqmh45SJNsW5keOO+MCQ7ek0HmY
         70rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250428; x=1761855228;
        h=content-transfer-encoding:autocrypt:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2hwEhUqYfYT/qHtg7r3dYTALVK2W+Pk3Q38aU4IIw0=;
        b=O9utB4mbZrAr1JeV4FyxW5MKmWF6NaqCLz9R/RseqWr87vjiS195wf66le1DSxWP6L
         ej8IqSwU5TCnW0S1KZ3v4XKh4bkaJnnvretb3hIQIqII+PS47N2MU0QoSJH2mgYnDZsg
         Z03XAgMZIhWnwP/rOr3IQx1SkTgFLIltDSH+YIc0Cq5l4M2TA3G7aJT/3HUAhFz/N3tk
         aN/0ObHVtRQg+OeryWktBTCXCagg26IaF01PtF6MM/R/Qra1oUK2TZ7ZhBKY5TLN/dBO
         ch8xKW8OfEUZdogkKmY6iidZFEOErZeQyinEMT73ZD3frdDPNqp93H0L5vkgobqGubu2
         czBw==
X-Forwarded-Encrypted: i=1; AJvYcCVF5XUSby4OUuM6c/CDq7NOcpijX4cIIBih9b0UpjwfXdyGLL65NKT9d23HuPb+7J/xxbvqjHKSIyCUi0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoK+Ppp1pnTR+sPxJdbHzi4bB3l7JCPRHwm0wdJWnpSpKJmUF
	ZeQU0iY/M0K9cXDWqrfV8s0jx6y5QJFnHwCLC40lxM7OgReP8Plz9l5BTUuRgg==
X-Gm-Gg: ASbGncuHbNywPx8ljNibKlnISS0TXlPgWhXg0BI+PMXhVGekCqmAZQ0rlunrwpTp4Rr
	EppXDogujCgdys63eHSdP4om4kRwtK40tA+Vvq6mvjn4os0hFCVRpbTNZhCqEaQi8rpBYpDnl3g
	SLWsqgcvBr9ksJRue1WfeQhAQ/GWu4jvGIe8DT8b0LkjCfzqHPB1LNml70YXGCmUnAnJgF443wT
	BdgxwhLvuimhNhjMtlXsbiMa+ED9qvvbG783J1HMfEZllLzcQiGOv5m04B7nwxv1tw8jscp1uMc
	fp6isM2MDgSaUd1rSP4S8rg5QpsrhG+e+n9bj/36NHtTO+xS5uYzDW33Ifc6MPWC8AxBKGfP+am
	Nd/ms9mSWPqgj9QGTzqA6h63h9rJDZo2HnnV3yvZ0xxQZe9Hh0xtaTWWP4Q5mEOX1C8sINbpdgg
	uT64Xt4uJwP/kUKobqYYIXy51Ln+NB1t4U/CcgdEoAzCX0j8FnRN7htAwjWMEWjxM635au
X-Google-Smtp-Source: AGHT+IEKK+zOGpZATsQyS1d6e2LRz9SXFTQ+r2qeVseai2EiIfrVWnlXizPcB3r0/oW+AW+IxfnYVA==
X-Received: by 2002:a05:6000:2dc9:b0:428:476e:e0ad with SMTP id ffacd0b85a97d-428476ee1dfmr10606701f8f.18.1761250428146;
        Thu, 23 Oct 2025 13:13:48 -0700 (PDT)
Received: from radijator.localnet (93-138-224-9.adsl.net.t-com.hr. [93.138.224.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adf99sm5889072f8f.28.2025.10.23.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:13:47 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: soc@lists.linux.dev
Cc: Karel Balej <balejk@matfyz.cz>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
Subject: [GIT PULL] PXA1908 DT changes for 6.19
Date: Thu, 23 Oct 2025 22:13:45 +0200
Message-ID: <5048490.31r3eYUQgx@radijator>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=dujemihanovic32@gmail.com;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KUR
 1amUgTWloYW5vdmnEhyA8ZHVqZS5taWhhbm92aWNAc2tvbGUuaHI+iJkEMBYKAEEWIQRt/0HWDf
 MUtbdrpjCtMZNSRY+tAwUCaJ5XkSMdIEFkZHJlc3MgYm91bmNlcyBhcyBvZiB+MzEvMDgvMjAyN
 QAKCRCtMZNSRY+tA/N/AQDth3Xl3wNcETvWPqqfYfyw4BFqbOD05A/W0/G0ZIjFzgD+PZVts3sN
 p5WuEwIxUrWxwavWJQBJwhXeWdru5ol82gmImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60
 DBQJmiSH/AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw
 8A/i4lPOL7NaYoYePDql8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xq
 h2MRcNmJCHA1YhWAbQoRHVqZSBNaWhhbm92acSHIDxkdWplQGR1amVtaWhhbm92aWMueHl6PoiZ
 BBMWCgBBFiEEbf9B1g3zFLW3a6YwrTGTUkWPrQMFAmaJIc4CGwMFCQlmAYAFCwkIBwICIgIGFQo
 JCAsCBBYCAwECHgcCF4AACgkQrTGTUkWPrQPUYAEAlVKitl0w6Wun+hC0JIf8bnc0TnrH8kcDxV
 f5lAF38fcA/j8RxR/p558NTFUyHZt2Sa5AqxVkaA4aJekySytWe1YGuDgEZokhzhIKKwYBBAGXV
 QEFAQEHQMRz0l4Dnk6Vl9YqC+ZGDDpr8SkFDyYOXqdBMGad3VccAwEIB4h+BBgWCgAmFiEEbf9B
 1g3zFLW3a6YwrTGTUkWPrQMFAmaJIc4CGwwFCQlmAYAACgkQrTGTUkWPrQMbkwD+K6jiXYYMRnV
 l/5dpL//wXB1cM72ceR9tXYweMXg1lfABAOugzMF0xypW9zwYAEWVNOAaPsqtEPPYfBY3IXxl6m
 sB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi SoC maintainers,

Here's the first batch of PXA1908 DT changes for 6.19.

Regards,
Duje

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://gitlab.com/pxa1908-mainline/linux.git tags/pxa1908-dt-for-6.19

for you to fetch changes up to 0e53b0bcad00107ce82968e86ca11a23f8a91f48:

  arm64: dts: marvell: pxa1908: Add power domains (2025-10-13 12:11:38 +020=
0)

=2D---------------------------------------------------------------
PXA1908 DT changes for 6.19

Rollup of hardware support which has accumulated since support for the
SoC and coreprimevelte board was merged. This most notably includes
eMMC, PMIC, backlight and touchscreen. A few QoL fixes are also
included.

=2D---------------------------------------------------------------
Duje Mihanovi=C4=87 (10):
      arm64: dts: marvell: samsung,coreprimevelte: Add backlight
      arm64: dts: marvell: samsung,coreprimevelte: Correct CD GPIO
      arm64: dts: marvell: samsung,coreprimevelte: Enable eMMC
      arm64: dts: marvell: pxa1908: Add PWMs
      arm64: dts: marvell: samsung,coreprimevelte: Add vibrator
      arm64: dts: marvell: pxa1908: Move ramoops to SoC dtsi
      arm64: dts: marvell: samsung,coreprimevelte: Drop some reserved memory
      arm64: dts: marvell: samsung,coreprimevelte: Fill in memory node
      arm64: dts: marvell: samsung,coreprimevelte: Add USB connector
      arm64: dts: marvell: pxa1908: Add power domains

Karel Balej (3):
      arm64: dts: samsung,coreprimevelte: add PMIC
      arm64: dts: samsung,coreprimevelte: add touchscreen
      arm64: dts: samsung,coreprimevelte: add SDIO

 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 267 +++++++++++++++++
+---
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |  51 +++-
 2 files changed, 283 insertions(+), 35 deletions(-)




