Return-Path: <linux-kernel+bounces-871008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E88C0C399
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7483BDCAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F52E716A;
	Mon, 27 Oct 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp3V3Zdd"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B77B19D065
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552386; cv=none; b=IYhetvXfn2lzWSrNK2Tk5uW7QjrLNnFfmn4OmRFF6YgQRlh2Ddif1UXoSMaQbnBiT8DGNaXtSvft0n9SrfQh8DqXAdFcQKrQXXN9aTC5RN88Z50pzGWmWqDY9XUgHW2i+IprmvGymBjsPe6hU9t/52BVSIL+LuyPFaWZbiHMZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552386; c=relaxed/simple;
	bh=SHyI8R4tmfpX+TjjAvSZcqT4Jl7+j2cCDwZNAwIZGOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mUv+XrGGgoGWMi6Ks1/8CHtHtCn02LvPzWN1i5lgTtZ5yPoqipzLnIpQkeSjMPS0mZ4hPvky/wZvWOoxOUVsRrxZsfhzcqyZ/UncgDtXEe5BFkA2MCuwK9TGZkPAYmRq1rk5oa8Se39p2Xfr4qgYclzxKyX/+zuy01HKYU9mIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp3V3Zdd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso8207265e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552383; x=1762157183; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1ar+zOx3UK5ZzhkLv+Cc5rARED6vyzcN8kpDrUCdNc=;
        b=Xp3V3Zddmb30VrD7iVWWzgHTkW6hmjXeCI4v3xMSELYH/I/Gt8wNepTT1xZG1mBa98
         MpYYVIoTPvwnarQGhWHctmRiVAhCe4APuHa3wlHoZaT3whXAn690JdyerSGY6S0Ec+oz
         iluPldsYKxG2KegXnAVT1T+bagndd27yFJ1fNq1Lz3nG0xTns1dCPPbBrGlBVN7EXtwO
         Ew3NNFx/CUBsmjoVPFKWbyS16pHW5VhX6togN7VBRpYYlHJSjHM4fXtrFg46mGsqLXpk
         SR7ggcOIfPxVkaGZ+ueDoF7igt3x4z75nb0ywH1tCZYeNvzbaYKrWYPvQ2Pcg/lIEzQV
         EdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552383; x=1762157183;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1ar+zOx3UK5ZzhkLv+Cc5rARED6vyzcN8kpDrUCdNc=;
        b=kkVxIM2bnnybNiL1sTs2BHVA9vlutB0KBvdKZZ1qMYc8HM7F6iW11/OTc+c2NqisfV
         NubUJzyG675HJd1d+mK/7DfvS6+svQ2xhB2uDAJHz49ScHbcnLFTdtqYPnW6E/8N9ct1
         wt73K4p3CyzEbUhNEHYaKZcIB4IgAzpoo3idiMtoi900y+FjDkZEAUCXel28CQmjiOxw
         d1EOpkTbR37UeXBYB0BBOZHBhpXewYNVCsxaR8nwgOcJVoM7ehHl288IcO8RP8U9uEU8
         mgQOqsHLBxe4XkHNbccx8MCMUOsRd9RqTTNgV6ve8CMO+TlCctbXaqsctj0nXhVK11Z/
         kMIw==
X-Forwarded-Encrypted: i=1; AJvYcCVTNK16HX35WZOfRZ20KR3OziWbGWe5cSowcn1yevBF1H+wmxjzMF6DzKqFMOOdjhsVtcqTP7k8Pz9M4k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iTWT2h8mCJ1ZZJ8ul0GOD3H6c31LxZgI3s0MTmk2XXaxG3Zg
	wJAfZhuvRFpKsQ8e20s1PeRWbxdL7Y5WSfZSXVri693IY/mDPVE5buBm
X-Gm-Gg: ASbGncvMCTEtDBGAsDGdSWXM7z6BZhlIs5or/reqlgyxoXvfOPVQyHlpdg+GmxJnSOK
	prmTbjsRK9YYgpErfmiY++elg6vVeL7bFrKUzBZrvaDQHaPTHwNSSVgCwhvIGKg48PFwkd8V/9O
	M9oBaHc+j7jwz8RxsXC7VCJWP4XMua6QWU0Hwe9pJL7/Zd38lJfPAkphMBxPtyz+aUI1+fR7H8+
	qFFRCwhAYM7UNaCDQCeXwnIIaswIl6iOadIUjMYr/o+f1Iu7NYbRU1lVtdioEqhECWerFcqf+gB
	2yI2sizgBbTExHJuDrKsTkli+eIF2ODSeTCNg3BWlPJjllrQEINBkFxits2UKlD7fknbqQuXn/h
	49T4si1KeGnDwcNiKaKHuEvcDSt6Mc+NpXvTWH6FVLuKIYrcUZysaewrd3XqjkFpYGBxUgmXYt1
	9Q2aM7OM/eO/70wkUBnSU7q0caBqFD2/EZHLjRDKsLCLAK
X-Google-Smtp-Source: AGHT+IHFD/pP4nQCmY0EGsGYROyGVf/b4kAAN6SMJ1j5q07/foKaGrRisSOwr9EE60mOw2Upx+akoA==
X-Received: by 2002:a05:6512:3c82:b0:592:ee37:935f with SMTP id 2adb3069b0e04-592fc14ab79mr2762129e87.23.1761552382395;
        Mon, 27 Oct 2025 01:06:22 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm2210689e87.6.2025.10.27.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:06:20 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 0/6] drm/sitronix/st7571: split up driver to support
 both I2C and SPI
Date: Mon, 27 Oct 2025 09:05:40 +0100
Message-Id: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQn/2gC/3XMQQ6DIBCF4auYWZdmQJTqqvdoXKCiTqJigJA2h
 ruXuu/yf8n7TvDGkfHQFic4E8mT3XOIWwHDovfZMBpzg0BRcRSS+aAqxZk/VgpsUKXsseZYawn
 5cjgz0fviXl3uhXyw7nPpkf/WP1DkDNlYYiP65sFLnJ7zpmm9D3aDLqX0BZ3QAQKoAAAA
X-Change-ID: 20251024-st7571-split-c734b06106a4
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=SHyI8R4tmfpX+TjjAvSZcqT4Jl7+j2cCDwZNAwIZGOs=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo/yfZ6lE31RLIHMMdUpzBdIAbtj8tbfuXtK1pA
 vZdgsxX10mJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaP8n2QAKCRCIgE5vWV1S
 MlduD/0YBuEsX6OM/b+GTbUOByMwjJPSqIEhUnjWivr0lu5tR7rwpb/AqHp+DN4d8xu0LUKYSkD
 U0nvwE2kvqdWqJfBBCU4xzYS7Nbm1CZFJg+So82FdSPkjLJNkDJX0oWH9JOvFB4TM2QvaH4rjKW
 9ke2BzSY/VzZkUiBwJ3lWAzPSWnZxui+AQ+WSF8boQljOP2Luiv7K5gDOgmHQWxvfV7hRug4QUf
 aUqXsGj7IPJT69mU8Hzdw57N6ecipzVduImjgZiYTlQHSpD9mdXf3qvxC55x5K/KnpldOVJvk3/
 2MxpwRVep4HBZAZJstOMucS2n8GIAAE00HrOTfXH3mGQ7ITHT79gnvBfXHeZYmZy09QrhjfaSPx
 5X932T82lCZCYDcsfftaKvYKtOOeK9JNHkAOwhwRECzv369GEP338OeF2Kht190ec/fp5t5x+fK
 py687eo9TCqFM2e8hdqV4iuiFQWweKRruIA/4AIiwU/EcxR1bVuqUa1aO4AYmJyEZKIRNoj2KsI
 mX659BEqs5tcEMfjFNcZ64t9ceW933ZANQqwFZgyXOrsCeo4j3qaE0Nw2GRH/XBPqaU5JP9e4s6
 QW0p+yoZVPBlpuG1/Mzp63k3vBlekJvSNmyoRl69dIXQcCIhmtM+YJRETQFQ7OzTlqtH4xe1Wc7
 XenI6C9JP+eqS0Q==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

This series splits up the driver and finally implements
support for ST7571/ST7561 connected to a SPI bus.

I've not tested the SPI interface myself as I lack HW, but the
implementation should be okay from what I've read in the datasheet.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v2:
- Add MODULE_IMPORT_NS to st7571-i2c.c st7571-spi.c (Kernel test robot)
- Link to v1: https://lore.kernel.org/r/20251024-st7571-split-v1-0-d3092b98130f@gmail.com

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
 drivers/gpu/drm/sitronix/st7571-i2c.c | 1003 ++-------------------------------
 drivers/gpu/drm/sitronix/st7571-spi.c |   76 +++
 drivers/gpu/drm/sitronix/st7571.c     |  918 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/sitronix/st7571.h     |   91 +++
 7 files changed, 1162 insertions(+), 969 deletions(-)
---
base-commit: 07a4844f2ef49f352ef46d0a4774ad63576a6694
change-id: 20251024-st7571-split-c734b06106a4

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


