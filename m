Return-Path: <linux-kernel+bounces-868699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D95C05EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FBA4584CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B089358D14;
	Fri, 24 Oct 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFRaRsxX"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95933161B4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303455; cv=none; b=HZykn5xi/TfgG+CovQ9Ywb/ffGIC7bFN2AE6O5vvydUowz2IHoQIY7PusCl5VmVaiBQwwOH96DP12nOE4m7GEqPE8OiRuRtiL1N8VKkOTA7AoTUr7600e7HdUCYjg9ZBsIVbsodWMt/dOSoQ0mEomgp9REMWOYgg8EcPDnHIg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303455; c=relaxed/simple;
	bh=R6v56paA/dEHvU/dNXKGIvdsjJizyetpWPpVvBUzIPQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZfpLd0xVrhWIqtCASSSwWJMhudpDMk9NVNZ8jSBHSpdOmmtnvgZdhheCHkXEXSD5zvV0MpVfAmRWQvMcZ9lUzpM+zdp51PcgnIeQThWnQPFed7P2CqreyvtVTS+RuS6nsZt1wyjgaQSLX6HWEYbibuZaIqNU6pnSHQOkJhEOdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFRaRsxX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3717780ea70so26692521fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303452; x=1761908252; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLgGrwj2cvg8pbP9aZUjo9XHFc3IK9CECbX8yze6a+I=;
        b=OFRaRsxXM7okXRtmnCoO6gnmxBEt/mAQW9PNWFmVpe1kCYDzyscU3BRRFPN8miKj47
         xE+qhSxxzKKrzLm6uPBx0YWeM9nGflIkBRR81WaMY/fpetmvG6UPrvm0WWPagJthDKCL
         NmhXsjqSI4Yo5hWJ9hGp2z5QGgzy5WzOchJ5bASOQ1bMO2SdhZExSLoHvBblTwGWnOyN
         dUNYyXPntWuRWsq1DKnmzx8uco0hKhTg271J3yShnTisOuoKfyjSgbbYOg4Fz82gjOiC
         y5j0jY6HfKkgSoc0NVnd/fNZUS6C25gP6yBk99sqXWpp0u3AWJI3wjcVUZhfBO128jDb
         UoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303452; x=1761908252;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLgGrwj2cvg8pbP9aZUjo9XHFc3IK9CECbX8yze6a+I=;
        b=mTJ/6+jHZr6n+JfrQ4MM0NV32adXmTJKb2hUEUy+Wob+tkR89G8hTEahXJQA+XJHHb
         uOnztzV62ABnHouIQ7E22JD2zDN41o0F78WCp4/UFLILoVqTQswXY+0kotOWNgdqKSXJ
         UiVXEZtl/GZkOZmmqF+l6fWzo0vDXbM7xOzdk61gPyNEQq9/Bvnr7a0W6ZaPbkbDE46z
         C9UNWYdqJfXkkmUyN9NwkBqqVLpWLe/iASqXOZ9jeb6dE2mgSRipOVpY46BsKAV5w96C
         889arrDTMS+1vSYjCcxEUjvjwiDUO8aOmXQ+ISMp+yrDWMsCArBvP2M4A4rdrJ3hBHzt
         3+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDEGMHeP+XwhJoFpjQ1i10yMDgLN8aFh93cDvqNDAOWYFy+vku5SomTB9U04xijIykafe5/FHGxOQiKNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzg7etkLVOm8LTmLG8BQoTiWxlBwpjCh406SFQ0uGJOfupKTgK
	xpyK7Bg28w8sUoN1q5GagfDetorlzG7JTFXgizrPSvyzM5G0xXjm03L3
X-Gm-Gg: ASbGncugHwx1gb4IUsdwF115XT+JFcrgzuMq1h0YqKSNR+WVEF3S50IGz1GctM1PV/9
	ad2scnk4tdhBT+1puT/QdyURR3qmZiSCXkGGYz77Ybrhr+2TxY55YmvGG4xGREhgiRWi4eh4ckj
	YvKWMtGXR8zZzjTTpKonthnt4jUVROcf6ysGJ/RhQZLC3f5xhyjcOCgf10mIY8q1ZR37qqPQmUg
	7yjGo2yZemyMm+52a24zUaGXkvPheoGm+7xYYkXmJGC1P3TqCPsPr/Umc4TthGpenrA7QS0hHSZ
	/gh8tOibfFgqMQ7ywesmbk/oY/Wi2cL3EvW9k0R0M6eYmUbbcoIsggcoUfha5xkXiZ8wTxAfJ1C
	3WJ3DeiqxBq1hNBFaF9ujWDozvE2sO3QVaVyhpC8L0SZCzP9molWvw5/l+1hzeMpmYXx4JTBwoK
	RWibD/F7q28JFD+X7bd5P4Gg9WSvc/eeXESdYInWKIOQxW
X-Google-Smtp-Source: AGHT+IF5dJWz8eNNAmFHIgmHUtxjJ0+59k4uqUMNim6/zblOyHNP4qzO4SmxeZSF1EgjU9z1tA49IA==
X-Received: by 2002:a05:651c:1a08:b0:336:df0e:f4ac with SMTP id 38308e7fff4ca-377979febaemr74275511fa.25.1761303451403;
        Fri, 24 Oct 2025 03:57:31 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67db8fesm10375671fa.38.2025.10.24.03.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:57:30 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 0/6] drm/sitronix/st7571: split up driver to support both
 I2C and SPI
Date: Fri, 24 Oct 2025 12:56:51 +0200
Message-Id: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHNb+2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMT3eISc1NzQ93igpzMEt1kc2OTJAMzQwOzRBMloJaCotS0zAqwcdG
 xtbUAcxhRQl4AAAA=
X-Change-ID: 20251024-st7571-split-c734b06106a4
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=R6v56paA/dEHvU/dNXKGIvdsjJizyetpWPpVvBUzIPQ=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo+1t3aLKOO+EE32uhrK/QULQ+IkiU96FlJcBXr
 G9PfzLvN3KJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPtbdwAKCRCIgE5vWV1S
 Mq/oEAC0bxr4XNigfBCApzjlC/u3jVIW4DTs1eik4K1b+1vDlJsLxlX6opIwqXPfn/GbJxT2xCS
 cL6FTLqEdXyl1AwkCubT8KaG6Y5WC+H/L+qQkV2TF0BgZ72IzHs9rtrrYy1EYajHiVGa6dhUwed
 CX1d2nCdoQd82NG5J2I44EA8oFzz/kJSA1eF7VKNVT2vbl5kTB1srZn3Gc/h9LTVAYQqPw0Bshe
 y9eDd4QYvmHy/SqTGrrbyPckFZ6TonnBT2/3hpSdhwSisn0PmILXNhojBYg657dLUAbG7hpPM48
 wurAeHTbqxpe7Av/De9qcghB+J/ijpPzO1DJqH/LxHzSdN8cUwS1k65WcCbYR1QeHDXqsLPJsL3
 XGpanOvjF15LhnWu7yhbePNXxg/EsoU4NYD5IHjQgyEqPAy7kpl18diJDOrIk3F6NMpEm1NN/bI
 bloy1y51PXJx0ZLhmo8iU44aCsYgOIa0/nkKhtfVHxjyVZEy7BmVZ68sxMsJMlCbhIyVKXdbvpR
 pQ9slkxQ6W4MDzM+AHd580ws9tTOzfsWc0YcBsHQ+1evtBMJA+7XkSzZYhbVua4hKufqgCxhvq3
 +tatrWsmf+zRTS398O23No/wT59+Pq44vvKzclc4957F8kVpf+x2qT8L1yGF35o9HEj40BBldBQ
 i95D/ZvO0rZ5v9g==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

This series splits up the driver and finally implements
support for ST7571/ST7561 connected to a SPI bus.

I've not tested the SPI interface myself as I lack HW, but the
implementation should be okay from what I've read in the datasheet.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Marcus Folkesson (6):
      drm/sitronix/st7571-i2c: rename 'struct drm_device' in st7571_device
      drm/sitronix/st7571-i2c: add 'struct device' to st7571_device
      drm/sitronix/st7571-i2c: move common structures to st7571.h
      drm/sitronix/st7571-i2c: make probe independent of hw interface
      drm/sitronix/st7571: split up the driver into a common and an i2c part
      drm/sitronix/st7571-spi: add support for SPI interface

 MAINTAINERS                           |    3 +
 drivers/gpu/drm/sitronix/Kconfig      |   38 +-
 drivers/gpu/drm/sitronix/Makefile     |    2 +
 drivers/gpu/drm/sitronix/st7571-i2c.c | 1002 ++-------------------------------
 drivers/gpu/drm/sitronix/st7571-spi.c |   75 +++
 drivers/gpu/drm/sitronix/st7571.c     |  918 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/sitronix/st7571.h     |   91 +++
 7 files changed, 1160 insertions(+), 969 deletions(-)
---
base-commit: 7e73cefd2bede5408d1aeb6145261b62d85d23be
change-id: 20251024-st7571-split-c734b06106a4

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


