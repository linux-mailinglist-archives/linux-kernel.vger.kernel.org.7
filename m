Return-Path: <linux-kernel+bounces-849644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E1BD0927
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04ED1892797
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC62EF65A;
	Sun, 12 Oct 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTUvlY9E"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B718B0F
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292392; cv=none; b=fnQ8BLvi3n2wPqfqfwFsdFCbbfskzf6xl5ixRTTjZFxSvcP2E3qb0yYwU8lGCFRDvMv04NLJHHu65tCOzAv5HfDvL/99+Od/AWSPv34u0qfRUHq0gXBPAccrG6VSG0/zLXF+31MoBdrUq76YECUmkFEqfbifqyTilh8yaj0pDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292392; c=relaxed/simple;
	bh=AhJj9IOMJeJTvwqvszPfrlnQUsLrStlttldkdSZULDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VU7tRsW1JF9mDhHLp21PyWJcDBuCQ8ck2kgpe6EajZow59RbtTn4KJAkLo7xAhVqERf/dTmSUYKdjXwIu58Hmy2DgZKz4UkB2zeuEw+GXGSkSTsW3leB75Bnn44W8zHriFOOmo4E+oYV5ICx2oiLQHEKt9qchlTj6JBwT9Yr8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTUvlY9E; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso2242816a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292391; x=1760897191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKnvs8CIxUPKhz7oYwulrB+BjUViG59C+RwVWWt6TkA=;
        b=fTUvlY9Er8V2O6kgtYIGN19ZnjJkwB9SR5otXbr6P8bUK0XAbm+ncIyjIAoV9OuzG9
         EfjIlAe9tt/UJfXmoZ+sYCAL5V9LlXK0KJAYD/lkf6VaGdbMYJFCRGHQb7hec2V3E/bM
         7wuD+zgdE4NX+qJzwggtRF+yEbhiewXZid7VVnYVviXFs+3owMRZiNlNbWPkCSko9ruG
         Nc2gkV3Wus8SuVUYA/nxKSNVH0pPWfZNEC56JmHa4YPyjQ3JG9WuwTUrycO7UJ1PBrLG
         KioMwewF7V9GsJ7CeHXZKObnth2e7PGaYjw4OaBrxD9lfOjKx2p8yJ24aIigjSY9qlw6
         5BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292391; x=1760897191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKnvs8CIxUPKhz7oYwulrB+BjUViG59C+RwVWWt6TkA=;
        b=XKr45TQi3osY/Sj939PbGikB7Ff2ETGnTmysCHvtc7vuc3NnLmQoc8EutF6vK46P0K
         E5gxPUmOsJSRCGqTMZ7WisZV0xs8CQWeuC4hxxzrncS2fUnQSEoeyzc7tgG7BA2oEiQo
         dRFTlxx4SQBO2djJ/xxJskdaZl167lBccCvl8fuO06oNMdblUTZOnoVUC2+8WVWHgPsx
         9tja/gSMDOMmSkBf3t4tbgSol47t3V93ZP69HiyWzBj7G0pVCe9IjVDLJJmUZwJBzqVo
         crBcE20o4aS4LVy0bt6i2oJv1R+XNTHQ0sEH6zmMK6OY0W0wxuhT3MLOSwpjSEkdlWr2
         CZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUexarGtoebkQmUryaxx5iy7WwMbVZlv8TNf+2FHmbjf9dReuMBJ1fUffvKVd0heyfkmyf7AZf9h3BNMe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhdyQSP/gfUJUbUWH9Ga7tRyL7NtS9P/4gsoEnUbql1HFK30s
	f23JX/hdz05aLghamOlkjQZHJqgaK8tHQEMRcq+20V3mmmjL2MAf0w5U
X-Gm-Gg: ASbGncsnO8WQK8aDI3GwLjL49lHM6sia2m2HwI/eRudPA+VvjvXbZ8z3VTa0ZWSjfgw
	lvshe33YTfu/RhswwAYVoV/dMnRuB+nIeuRWEEddOQIutAPY3wKytKHku0Sq8gfu0YCNamqeSyZ
	kcRxq0eBV74OWrD6hEk08TgE6a9BYPmW+v26j/6kLq9c/D2O8Pfxr++U+P587m5VXVWHvs8pubA
	QdcQ3cs1fnh0fwfMBkGQaJmjHy62bJWmcorakV/sMvo9XejUBLZiFaVwZEnNqVrJq4jMAO5zNLW
	sJ0ECqMJ3VqVuGAGdJyfxYcKIEhp6KChIJ46d6OdivweCBugmrt8NdWSUKiucPGGRXDqptjcpFi
	EJLmPO4e/mJDUUwktYhxT99Ose+PPkTEhIwNcppbaWkPpFNQQiDo=
X-Google-Smtp-Source: AGHT+IFmhUIDI5YazfRri8S6Ev/488WoKLYdvCvSR4xvF4/ODpw6sSz7qfzRIKyIqHTq65Xm/DzsGw==
X-Received: by 2002:a17:903:19e8:b0:28e:ccd7:dd61 with SMTP id d9443c01a7336-29027305380mr229717425ad.57.1760292390563;
        Sun, 12 Oct 2025 11:06:30 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:06:30 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] iio: accel: bma400: Refactor GENINTR config and register macros
Date: Sun, 12 Oct 2025 23:36:07 +0530
Message-ID: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the BMA400 driver with a focus on generic interrupt
configuration and related register usage. The main changes reduce
usage of hard-coded values by introducing macros and formula-based
register addressing, and add a centralized lookup indexed on iio event
direction.

Alongside these updates, the series also reorganizes and renames register
and field macros for consistency with the datasheet, and extends comments
for additional clarity.

All patches are pure refactoring. No functional changes are intended.

Akshay Jindal (6):
  iio: accel: bma400: Reorganize and rename register and field macros
  iio: accel: bma400: Use macros for generic event configuration values
  iio: accel: bma400: Use index-based register addressing and lookup
  iio: accel: bma400: Replace bit shifts with FIELD_PREP() and FIELD_GET()
  iio: accel: bma400: Rename activity_event_en() to generic_event_en()
  iio: accel: bma400: Add detail to comments in GEN INTR configuration

Changes since v4:
- Add INT_STATx field macros corresponding to used INT_CONFIGx fields.
- Make INT_STATx field macro names consistent with others.
- Tied the INT_STATx field to correct INT_STAT register.
- Modified changelog of PATCH 1/6 due to addition of INT_STATx fields.
- Modified changelog of PATCH 4/6.

Changes since v3:
- Insert a new patch into the patch series for replacing explicit bit
  shifts with FIELD_GET and FIELD_PREP macros
- Assigned explicit values to reg field enums introduced.

Changes since v2:
- Split single patch into five smaller patches as suggested
- Addressed review comments related to trailing comma [Patch 2/5]
- Extended renaming of macros to TAP_CONFIG registers [Patch 1/5]
- Addressed review comment received regarding write then replace in
  activity_event_en() [Patch 3/5]

Testing Summary:
- Tested on raspberrypi 4b and 7-semi bma400 sensor breakout board.
- Since no functional impact is there, so before functionality is
  expected to be equal to after change functionality.
- Tested mapping of GEN1 and GEN2 both on INT1 pin as before.
- Tested both activity and inactivity detection by setting attributes
  events/in_accel_mag_falling_en as well as events/in_accel_mag_rising_en.
- Did read and writes on various attributes such that write_event_config(),
  write_event_value() and read_event_value() callbacks are triggered.

 drivers/iio/accel/bma400.h      | 155 +++++++++-----
 drivers/iio/accel/bma400_core.c | 349 ++++++++++++++++++--------------
 2 files changed, 292 insertions(+), 212 deletions(-)

-- 
2.43.0


