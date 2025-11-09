Return-Path: <linux-kernel+bounces-891981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A9C43FC3
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2F73ADD3D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F32EBDCD;
	Sun,  9 Nov 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld+8G5Qr"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120132D63E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697506; cv=none; b=rPlbKmq9ad70yxtGUiFJYcQffV0rWQNK5JSSVLfgKwjSXl4s8YK0a17JIYfjkKIZsQ/N0bmjykgs1xGxo9Iv1eQ+Xj88nOCHnY7/Kuzg0FqUtO5EJeQ+oycZE10PG/d76xsz6LwWek/xDHU2/qRBU1Em0uRPVHzd2cjlJpKk+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697506; c=relaxed/simple;
	bh=Vy4v663byFI/J5rgp6z8mHMaGRohYoClqvZGWuEUl4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8azgLuOKFaD2n2ebSWdYVkvEreypL6YwsR+WssibP1qmabuqYs/BL3FRWwtFIht651G/3YwTVz+F9NClXcq/AuGThfujoNxs+Q79JQnusfmpf5RmF04fpX8uTGKJha0SygEW+X8nf2s2/oTE9Cvhnkcgv1vtDYtId2NcoeYC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld+8G5Qr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aab7623f42so2554713b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762697504; x=1763302304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/NRAJqvrniTCxicYWw7CVxJQJTdmyRR0h5G6gK7WiU=;
        b=ld+8G5QruDH8P/jraEOiNcHwTHp4TX20qN5xzjcDG58LkSQNsebRjH/t2RBoSE0FRK
         a1pKQ56d6dRhXtB6rkjyrdKpOeOl2U0Td3DldoMHX7noQhqY8dLc+DTstziKIn9gp12q
         I2dq691wjjXc+aWlB3uR/rdiUHbjGCuaifQyQJBgHkao0RhthJdDNsakrlpGq/c+uGVt
         ledTWpNYIlWrnxeuM937yXAVmPsS0zKwLc+pVk75YxDgb585Rq5uju+79fKfc+BedVjk
         7H+jYORB7fJzAuC7FgeXWl1XtZZruGFIckgFdAmzQ5cHrk/JnsqkQ0YMmRf5q9s8Hosx
         YIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697504; x=1763302304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/NRAJqvrniTCxicYWw7CVxJQJTdmyRR0h5G6gK7WiU=;
        b=qLSkuT+Q3h5bjYXgmDQhYyXPxNIq9ATO06RxaCmSdtVsuNctQFToZ0S01NcNP8p6sy
         0G5UuCeFDII8csicr6i/fMA9pSWqI0F2lGZUd5TS6orqoDPIC+6odc9dlHjC6U6iKiY2
         9RG8bgb+Q50XYHQWWWmhxqnj0gtzKWFkj8fTlzN0lnjPNVMcA0ZykIhJUyE5C0vnv9uO
         DrNJcJHhYv9AfktLI+DmsUbh1HdJf89Uo8NPMB45I/JHio6XvcxvyG50oR9Y/gaPlTgA
         mfmlxjNWVzIDYAuqgSXUn5HKgcyoQBA5wx3ACnss5v7rKsOfwjA04EibudM5XlrwQwnf
         FY5g==
X-Forwarded-Encrypted: i=1; AJvYcCWeXf0Ry73ahNsuG28U/L4pANHU1vYWikbuMpLxPUoePaRK31zBgDZ+jCIhnMzkqA9e/IJJSyccXjo2bwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFlb4VSb0DdcXhpf9Q+nRh8+qJBuLsCIpFVBZ5iN9VJBpl1XH
	DKRwVRLvSL6h8Lmbg49b9fIPeZ3nxmXyf3ZdQo/26H2YWL1h83WUo5oy
X-Gm-Gg: ASbGncv7keCp9ADWEH1zdD5Sej7gQUd/YH5o8o1U6euVDdO/Zv0L5q0VgTfYiH3puwk
	wXpllPtHrgAXtC59XtETEo0/WFImKK765yHcMYh+QMvOeuHDcLo2FX+Z/XyzbEz8lrV5jG8fI5a
	JMzBsXNSCUqwvzk72qkNCMQZBzBlUXBmxQCNrMKokJO08znG2Oy9JrcWtJYxqjbMRqRzpd1Sonc
	AMFnEeS9mOqYIMMNRhpHuwgukaabhn8KsxjjWEqWg9t2sPMsuwYPhbU53do1KDMIt8gVxze25BZ
	j3XIRWqWo+8xORCO3RQRJ51plavZ116Jy4wrKPpmCDTPFOO9VP/de/6Kd/XcZgTP4/uQq1zJvT0
	+x4bSTSfaDOGk/T9oziDyblfXnp1v5IKgJRIiT+ajG2e+wqgDM5wnq05quEr0bSOSJhXiL/9XlF
	0BokkviEqH5arT5vD4FSqBHFyDQa29hUkcfy+fOl8lK3XPAmqKOnoUI5NKog4DH6RrywI3j5Gi8
	jTgbHNFNEgoHsumNLeNEtbsf3tpoxh62ZM+/E/aefF+WWSgjOaGhrGR
X-Google-Smtp-Source: AGHT+IEhrosVa9kLKfF0yTd5v+2n7rNzshxcCJDg4A3X/drthxw0eliFiJIyGzq9xbcEMcaJwkIWKg==
X-Received: by 2002:a05:6a20:7488:b0:334:9e5e:c2c2 with SMTP id adf61e73a8af0-353a14b0b6cmr7184434637.13.1762697504346;
        Sun, 09 Nov 2025 06:11:44 -0800 (PST)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:5455:eccf:e73:de96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c801d1sm6582780a12.7.2025.11.09.06.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:11:44 -0800 (PST)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: ti-ads1120: Add driver and dt-binding
Date: Sun,  9 Nov 2025 19:41:17 +0530
Message-Id: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the Texas Instruments ADS1120, a precision 
16-bit delta-sigma ADC with SPI interface.

Why a new driver?
=================
The ADS1120 requires a dedicated driver rather than extending existing 
TI ADC drivers for the following reasons:

ads124s08.c - TI ADS124S08
 
 - This is the closest match (both are delta-sigma, SPI-based)
 
 - However, significant differences exist:
 
    * Different register layout (ADS124S08 has more registers)
 
    * Different command set ADS124S08 has built-in MUX for differential
inputs
     * Different register addressing and bit fields and conversion 
timing and data retrieval.
 
would require extensive conditional code paths that might reduce
maintainability for both devices. A separate, focused driver 
seemed cleaner.

Changes in v2
=============
Driver improvements:
- Fixed all register bit definitions to use field values with FIELD_PREP/FIELD_GET
- Moved DMA buffer to end of struct with proper alignment
- Added comprehensive comments for mutex protection
- Used regmap framework for register access
- Added all 15 channels (differential, single-ended, diagnostic)
- Used guard(mutex) and cleanup.h for lock management
- Used devm_mutex_init() for proper resource management
- Fixed error handling with dev_err_probe() throughout
- Removed redundant state variables (gain, datarate cached in regmap)
- Used sign_extend32() and get_unaligned_be16() for data parsing
- Split SPI transfers for cleaner command/data separation
- Added GPL-2.0-only license identifier

Device tree binding improvements:
- Added required avdd-supply property
- Added optional vref-supply for external reference
- Added interrupts and interrupt-names for DRDY pins
- Added optional clocks property for external clock
- Added ti,avdd-is-ref boolean flag for AVDD reference selection
- Added complete example with all optional properties
- Added datasheet link in binding description

Changes in v1 (RFC)
===================
- Initial RFC submission

Ajith Anandhan (2):
  dt-bindings: iio: adc: Add TI ADS1120 binding
  iio: adc: Add support for TI ADS1120

 .../bindings/iio/adc/ti,ads1120.yaml          | 110 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1120.c                  | 631 ++++++++++++++++++
 5 files changed, 759 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
 create mode 100644 drivers/iio/adc/ti-ads1120.c

-- 
2.34.1


