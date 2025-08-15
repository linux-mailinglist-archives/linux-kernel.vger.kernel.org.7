Return-Path: <linux-kernel+bounces-771223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F982B28453
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58515E02A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9B31812D;
	Fri, 15 Aug 2025 16:47:24 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172E3112C4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276444; cv=none; b=jSjZ47h94XzH1UowLnzy8ElpXRHZZhyZZwcOdBXUBDOvIwcfcp+hYs0J2qPmVO91NGmRVMm3Je5n6D/igpU/GtH8SK/mkATWkq5RYgZ1F1IPkzBqy78kYiRWfA89HiEJIJgvvoEPHOatFSw2P5FpgMbhPSPVc26oSILY+VFrLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276444; c=relaxed/simple;
	bh=x7tndlkYkK0f+ND5GLHBi0hV+UtOcv3u6wqalLlGpYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDYNkw+jYX+VPlfqrqgdcbxViG+6GvwH1A/6eh60TT/kVHRJ5mVZscoWg8HQVoOLT0ED8yc+DqRrYxB/b98Um7Q4pvmSh1m5rnbR/QQ/CIvO52q50iqaonhSMUk8Jz5EmHWHYgN+rREPIFEpJD+w3F2j/KmTSmNJ15viJ+IQVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Collins <bcollins@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: [PATCH 0/5] iio: mcp9600: Features and improvements
Date: Fri, 15 Aug 2025 16:46:02 +0000
Message-ID: <20250815164627.22002-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ben Collins <bcollins@kernel.org>

ChangeLog:
v2 -> v3:
  - Improve changelogs in each patch
  - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
    * Set register offsets to fixed width
    * Fix typos
    * Future-proof Kconfig changes
    * Convert to using chip_info paradigm
    * Verbiage: dt -> firmware description
    * Use proper specifiers and drop castings
    * Fix register offset to be fixed-width
    * u8 for cfg var
    * Fix % type for u32 to be %u
    * Make blank lines consistent between case statements
    * FIELD_PREP -> FIELD_MODIFY
    * Remove explicit setting of 0 value in filter_level
  - Based on feedback from David Lechner <dlechner@baylibre.com>
    * Rework IIR values exposed to sysfs. Using the ratios, there was no
      way to represent "disabled" (i.e. infinity). Based on the bmp280
      driver I went with using the power coefficients (e.g. 1, 2, 4, 8,
      ...) where 1 is disabled (n=0).

v1 -> v2:
  - Break into individual patches

v1:
  - Initial patch to enable IIR and thermocouple-type
  - Recognize mcp9601

Ben Collins (5):
  dt-bindings: iio: mcp9600: Add compatible for microchip,mcp9601
  iio: mcp9600: White space cleanup for tab alignment
  iio: mcp9600: Recognize chip id for mcp9601
  iio: mcp9600: Add support for thermocouple-type
  iio: mcp9600: Add support for IIR filter

 .../iio/temperature/microchip,mcp9600.yaml    |   6 +-
 drivers/iio/temperature/Kconfig               |   8 +-
 drivers/iio/temperature/mcp9600.c             | 209 ++++++++++++++++--
 3 files changed, 201 insertions(+), 22 deletions(-)

-- 
2.50.1


