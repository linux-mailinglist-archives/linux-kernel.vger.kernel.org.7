Return-Path: <linux-kernel+bounces-830924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BCB9AEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C18321226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDE130C36D;
	Wed, 24 Sep 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHUJ1d9o"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441262D97BA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732779; cv=none; b=YbDApL+joX7Qj6XVHIU90aQEpkKGwU+vAL45sT8DNXFZdOc4XOf4l/Yg5SWRdkPzc8TqYjpR91LcNpu3teOM+W4dAajL1ucU6G8omCiC6iOuEV7QdoMNp6fb+Nal37muKheuPWv3M76Dn+a2cljKoWgoaTHxMP/Q+y20qx0JU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732779; c=relaxed/simple;
	bh=UrMcgnvepEFw09AKY27xiaGcVJTODrGC0uo1csSp3i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhUgv2jqUL2cuZujNYrvuRQKCThZG89wOtK3Pa5HSH2dlX7TNO3x6C6dQ3NqBhW+A1/kKP643Mw+GCzqIbFVHyU0Tv/arvwklkLmNES6gsz6glxsIrmQ956D/7nI+/4mnN4ajEJhhxJv2EWdiFH7OZye9D1DZm8HRRflQ3bexF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHUJ1d9o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so7044235e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758732775; x=1759337575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzTtM9WAsK07z8tZ50EdByhyU/vMqn0St2F82RyVOyM=;
        b=PHUJ1d9o45OIzhnq3djs1HIoKODo1lgRlGRwzGJDHXVsLMkqO51dD+xZZLKMBRMObl
         NAYxaB9E3n/wYtLxbi+wrUQCJHaIt3zs4T93EP942naLHn0QAeZqwibmFt9OT2es0I31
         WyREvH3HlCQrAFQNBM1rwMqkJhex0AWnCfGTMuIElDY0/UOyM9IvBKFYs+DRtZGJ4iet
         OT3AasX+9vHtoIUFSWoa1s4DRxrp+7+rXc+rAck4fMop0e6hbywTddfVL53KPyPm3WuI
         G/s9jTBJqGI+c8U2aIu0NfjaHwFtAV8gP6bIRos8r5WYUB7sVwqPyWlmUJJ14BGw7xOb
         dbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758732775; x=1759337575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzTtM9WAsK07z8tZ50EdByhyU/vMqn0St2F82RyVOyM=;
        b=o3/i4eoioF5tDbcBxMuJ1SUtKpcxHOhCKY+XtFhngqRw8LJpM+c/AR75pxB5ePokC4
         YT4rDulxt3qsrErybGLQH3pR4jZ2zdIqQxAccdZ0fls9rI/x57WxyBQHouT0ZTw+WOOw
         zIyJ7S4hnahkAmxGnHaw+1z68SqKTZ9Tk9tKEMd1lgcp3Ydp5zUzT2dOnWvgUFHdnUB5
         eMV4nyoBfzNsIgyJALyNc574P5FlA0RkmRM+HBcarFFoSqBCik5MbsxOUcCXv6qDEXac
         9qh9RN/wYXkeYUXbXEKmeMTaZDGVRNjCdg+/drwz/kMswj+qJJwHy1uI7n3GMpqh/Kl2
         PFYg==
X-Forwarded-Encrypted: i=1; AJvYcCXrIaL+dN1bxMfndSdWV7I+a/HWPP1zYEczZPsUDEXdSLIcpeEG8rnkwQcg5qfj7fykVJoO7ZJ3KxGad+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BDiSn9vig4wuNhPSweBameT9A3xwGr7B6psXKnsb//Sa/3hD
	C7qb3Dk6T4RXAXZQ3F5hllrYz/mTKM7pKPVEo1v/NJ/Qlemi09ABarav
X-Gm-Gg: ASbGncvQMB45gfOXJLe44BOeLc51veFSbnHLn1UKkJCmProAL3SmXeoOPAKNZDezXXN
	HqkQQQgnw1Yx8e9IY5LfE7I12uwfWhasqmlr3BIOFh5e2xC7YGsQ3CgJLF3C3xdnXKHvBwPVm8s
	8sTdlLca/2r/RGS3EXGET4jkGoaWa9zdVK16RKVRDAN48pXdoq3Hfx+YWgZ0xN+aVjoM+H5WqTu
	8gqNFjuWuyMDa9jDhJiz1Llf+UXH4Ioc7wwUqxKnWU4znSn/ZHxfDyn2kLnKcA4/E3B/be3S5LT
	gpFAu3xSgP7H5IwUXI5NQOl9Q8y2BM19EdM0FvQLDKKCOTMqCxUfv0IACiAVX5LGFHsv8WXxkp7
	bQ4RmIVDIykolZAIVQtr+usbLWfguhs99yWq2dSjAtoyldDzsrnPf5F3Kkono16FFPhM1UhU9T4
	/nUsasgtCH+A==
X-Google-Smtp-Source: AGHT+IHV6Of+qXakfqJ0XhbATMb2AIuLl9e0wcQPO7/GLftVgSTayzqBT8eCMUUPgRnR+4vlJm1a1w==
X-Received: by 2002:a05:600c:45c6:b0:46b:2fd3:b55f with SMTP id 5b1f17b1804b1-46e32c2f45amr3319005e9.4.1758732775255;
        Wed, 24 Sep 2025 09:52:55 -0700 (PDT)
Received: from radijator.localnet (93-138-236-234.adsl.net.t-com.hr. [93.138.236.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f02f332c31sm22789020f8f.45.2025.09.24.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:52:54 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: soc@lists.linux.dev
Cc: Karel Balej <balejk@matfyz.cz>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
Subject: [GIT PULL] PXA1908 DT changes for 6.18
Date: Wed, 24 Sep 2025 18:52:52 +0200
Message-ID: <4685744.LvFx2qVVIh@radijator>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi SoC maintainers,

Here's the first batch of PXA1908 DT changes for 6.18.

Regards,
Duje

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://gitlab.com/pxa1908-mainline/linux.git tags/pxa1908-dt-for-6.18

for you to fetch changes up to efab3844c6f18327886c5c2e0e40acccaf976a89:

  arm64: dts: marvell: samsung,coreprimevelte: Add USB connector (2025-09-2=
0 14:08:32 +0200)

=2D---------------------------------------------------------------
PXA1908 DT changes for 6.18

Rollup of hardware support which has accumulated since support for the
SoC and coreprimevelte board was merged. This most notably includes
eMMC, PMIC, backlight and touchscreen. A few QoL fixes are also
included.

=2D---------------------------------------------------------------
Duje Mihanovi=C4=87 (9):
      arm64: dts: marvell: samsung,coreprimevelte: Add backlight
      arm64: dts: marvell: samsung,coreprimevelte: Correct CD GPIO
      arm64: dts: marvell: samsung,coreprimevelte: Enable eMMC
      arm64: dts: marvell: pxa1908: Add PWMs
      arm64: dts: marvell: samsung,coreprimevelte: Add vibrator
      arm64: dts: marvell: pxa1908: Move ramoops to SoC dtsi
      arm64: dts: marvell: samsung,coreprimevelte: Drop some reserved memory
      arm64: dts: marvell: samsung,coreprimevelte: Fill in memory node
      arm64: dts: marvell: samsung,coreprimevelte: Add USB connector

Karel Balej (3):
      arm64: dts: samsung,coreprimevelte: add PMIC
      arm64: dts: samsung,coreprimevelte: add touchscreen
      arm64: dts: samsung,coreprimevelte: add SDIO

 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 266 +++++++++++++++++=
+---
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |  46 ++++
 2 files changed, 278 insertions(+), 34 deletions(-)




