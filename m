Return-Path: <linux-kernel+bounces-772793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601BEB2978D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E91B7A1D47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C298B23ABBB;
	Mon, 18 Aug 2025 04:00:09 +0000 (UTC)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73F25F988
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489609; cv=none; b=s7ZZHjPn5Ln1aDkl1rNDyprVBzDtJcPA6DkDSa/zhMpwRwRT14UCldBLlGmkMdYeE4hEfUfAa4oj/uuL2sVO99ej/JmtroF8Omlh0MTjUCyA1tk8A8122CIXS7JXbZgjFag+R3Cxp1pBtCnaVkG+kQ2bF12Eb8zb/FTgvQIz31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489609; c=relaxed/simple;
	bh=kc+VtVq4mXb6dGLxZKenFKrUWMqzyRC/UyfP8youVPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IYwP9jqWeEmxhfKCNXlOht345TOcbL/qE71nob9RfksGzLw4VoK9Q6Spkuxd0xbflSIhROOufyUg+LHFobgrVaTvJ2JyH/qpr3BpOWb3DWvQ62tbNMh9ltU+Obmhxlvu4VtMU8lMHX+HzdVBdPp7GNCL0s6iRxMZLsowG0t+LXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
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
Subject: [PATCH v5 0/5] iio: mcp9600: Features and improvements
Date: Sun, 17 Aug 2025 23:59:48 -0400
Message-Id: <20250818035953.35216-1-bcollins@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ChangeLog:
v4 -> v5:
  - Missed a one line fix to IIR patch (5/5)

v3 -> v4:
  - Based on feedback from David Lechner <dlechner@baylibre.com>
    * Allow fallback compatible in dt-bindings for mcp9601.
  - Based on feedback from Jonathan Cameron <jic23@kernel.org>
    * Be explicit in patch description for fixed width changes.
    * Check chip_info for NULL to quiet warnings from kernel-test-robot
    * Remove "and similar" for long description of MCP9600.
  - Based on lots of feedback, use frequency values for IIR, and use
    filter_type[none, ema] to enable or disable.
  - Set default 3 for thermocouple in dt-binding
  - Rework open/short circuit in dt-bindings

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
  iio: mcp9600: White space and fixed width cleanup
  iio: mcp9600: Recognize chip id for mcp9601
  iio: mcp9600: Add support for thermocouple-type
  iio: mcp9600: Add support for IIR filter

 .../iio/temperature/microchip,mcp9600.yaml    |  25 +-
 drivers/iio/temperature/Kconfig               |   8 +-
 drivers/iio/temperature/mcp9600.c             | 220 ++++++++++++++++--
 3 files changed, 231 insertions(+), 22 deletions(-)

-- 
2.39.5

