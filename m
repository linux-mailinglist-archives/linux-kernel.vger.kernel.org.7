Return-Path: <linux-kernel+bounces-878669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE2C2135B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD44D349796
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDED22D6400;
	Thu, 30 Oct 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZoYAMV6"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A10267386
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842083; cv=none; b=LlomE8/vwybveYl2Hc49xcFigsx/lh8J5B7bmVjbDOorYsrPkrMF9sV91m8vPdZzSfhsRCL/9xppcyx1RA/eVznhPHXUo5rsj1M58m2bZbfsquC/rN8FoH3Gl54qbvbbxQMFCpEIBXRDtEz2WQMYoy/uELUORqLLx/7K/FoWFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842083; c=relaxed/simple;
	bh=49TrQUGUtrEr2yZhMBoKYVsIAJVY+BeJ0rODJ0UUTWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mprz4UVFmBr845xud7gC2JFDRAbP7+3PUYJU1V9i7H9Zk3LK10mtEma5twLcFzn5KTvjiUljat2wzkOP434KXSYhvcqYlHuYCjQP2jjS5nR5M+vj1qYNNcJO5/d+KfVIjJ41OuZYY7Y244whZrSM2GoAPdt7f5tRTKaiVaHxHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZoYAMV6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1020530a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842081; x=1762446881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GemJnWb5rbunzFGiUAhg7eKB3QXcsT4ACvgb/nKBts=;
        b=QZoYAMV6azRsYI4wMMudbgzETPhyCF0uRFgnDj0kFCm6BbFRka0ARsNJ8jF1RWdhYL
         l8UCmeOlhwEA0ur39my95Pcv6um2mRoe1UG51/CVUOZmadDqZKtaSfsUeDyjiPhNUtLR
         6QMy9UJG2BW19AJ886nRyzTdX9mEsfyzEkUqTJOGtzN1KdpLUzjBrBzjfJyCIjGGYa4e
         FR17otrwGiMGLBF70OWq3PaAnZ8hF/TboHyMnfo4E70RJxITDV8sv2zgYvpxzBgksPTD
         /GM7woueWkZI1Eb399L0zwKUP1IIF+JwBI/UXpG5pfzB3Gs6NJqfJbyRFcfeBgPhMJsh
         FX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842081; x=1762446881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GemJnWb5rbunzFGiUAhg7eKB3QXcsT4ACvgb/nKBts=;
        b=ZHBQnLTxKEnL4I+s75xKkwQvnWojcvdPWoxJtC96yJzM327yNmZIybPMNd3EA9rjuH
         9m1hPHWWF/K4BDKzxyawJe+yY9ONfEv2qKRCsSE5K5pBTatWYCtoFXOjSlSjx6j/yLgw
         njglnNxeT74BjQQ5TlmtqoHxQVahUJ1TILLdSQhOzL3WcWISyFI6A5qfkybnOePziRy2
         R/RQZbscyYxDbuApkCtJpuQOVgIc4SH9PRCrSSG1kv94rlEFInN2e0oA3WhUUE5i95Rf
         /fMCZnUHkQz8d0YTl6c329F5n4SFFsixPVSjjDXcAKE5R45ZgCtpnx03pb4F+OerI7Ft
         DdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwy6PxlLAplswYQt9hxQdZ+dDmKgAbEUe1TBSHKoGQ4rf93UZCju9EX+6fMc/gYLsiCof8Sb7Um4Cw/SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qVoknTSrwxc5BOp6iTmRcMIr2R0SkXGUDsv9+nIYdh8tTdhH
	7rMGUyefUQaXqO6FI9D/KUcqbKh0H5n7LNh0CSn67yVphhw5NVQfGxJR
X-Gm-Gg: ASbGncuHUfgfiOI6DaTU9cwYx4jjkK156uMQB7s7PzliSDZNhOgDAFqsYk3TFN88YvH
	/S4eAW1N/LS6IpL3uF9gHvGreRiuttWkeY5WvyShcglNypDX3X0CQBbR2gcpjiI7FXxl/SGwzMr
	VR+bGzvT9P7XBaJ7CNT8ib82LYyBRbDRiykoDDulf9P/xghSbKm5Cj194EC/UuFXCuGj2RuB1Sj
	P0pvEgaBbNAgBUMJq3dr72/FmkTc0qcdpd/IAb9RbCAcf08U6h+6BmWNgARONEvWvoOmI6aPn7e
	kTOpSVrsYey1l36d3gxbgGEPov2JxxD3Kit/m0GNhVZfCpw8eM+nxEWErW+NT7ihZD48DmYv+lo
	rrD3P5+xnhM5mJEDLVZNYI8t6pj05GHAU8/2kY/VuM8taxT56JASUFyyfYOg+pBG6VX0tQyukqJ
	us4A2t4UvgBD28/xpYoPMkeklZzITd9uqnLZIU0xkNBdRHttp2vDeRSHYxVsnxJe1T+69iEL9Uh
	8uos5R6PphS8rWzlt2uXd0+UMfijfVFGBPNIUOjiSR8L+A=
X-Google-Smtp-Source: AGHT+IFhVPa23fECGvV4dUIAld5HM4HNjatO6IlpoUW53cLuqxeeqTXNZkPLMxgkK1m51ToYYLi7xQ==
X-Received: by 2002:a17:903:1111:b0:267:9931:dbfb with SMTP id d9443c01a7336-2951a526f47mr3589515ad.54.1761842080791;
        Thu, 30 Oct 2025 09:34:40 -0700 (PDT)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:339d:c9c4:e069:47f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm190932845ad.100.2025.10.30.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:34:40 -0700 (PDT)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
Date: Thu, 30 Oct 2025 22:04:08 +0530
Message-Id: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch series adds support for the Texas Instruments ADS1120,
a precision 16-bit delta-sigma ADC with SPI interface.

The driver provides:
- 4 single-ended voltage input channels
- Programmable gain amplifier (1 to 128)
- Configurable data rates (20 to 1000 SPS)
- Single-shot conversion mode

I'm looking for feedback on:
1. The implementation approach for single-shot conversions
2. Any other suggestions for improvement

Datasheet: https://www.ti.com/lit/gpn/ads1120

Ajith Anandhan (3):
  dt-bindings: iio: adc: Add TI ADS1120 binding
  iio: adc: Add support for TI ADS1120
  MAINTAINERS: Add entry for TI ADS1120 ADC driver

 .../bindings/iio/adc/ti,ads1120.yaml          |  50 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1120.c                  | 509 ++++++++++++++++++
 5 files changed, 577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
 create mode 100644 drivers/iio/adc/ti-ads1120.c

-- 
2.34.1


