Return-Path: <linux-kernel+bounces-857817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D764BE8016
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590376E15DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41498312835;
	Fri, 17 Oct 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="E+4hY8wq"
Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com [47.90.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD73192D68;
	Fri, 17 Oct 2025 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695894; cv=none; b=Xo+PYczQ4KzggXzle762NYUKRQBCa0yrK6ml3Szr2VenJcw0Byz0RKobfhPGu90o1cfUikPe28Z19LRl4YakerPELjZyfmSA3B4vIRtdnUtk5SAnNuoJ8+h48VwvqrRrSj4SiaPp/0QPkvQ5VjLwYrrd34CMxkjFsuynhDyHUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695894; c=relaxed/simple;
	bh=agLtSGA315wQSbDN3l9qUz1xWxIu7clrjXShj5qul3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQaLmfGwsS1JjmVdRMzglkNMJKLwStIeTSpJGF48NOQeedGAVecIB95eta6jSvz3J+hqWASllmG/PW//bd7PA/SqSJeanK37RaqfifQEDn6L692YeakntWriTioXAEH6BMOi8j0xWZfLYYW4WQtuiU0Y5bVfMcDZfreVVSwdnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=E+4hY8wq; arc=none smtp.client-ip=47.90.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1760695871; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hD487TBwCfAj/EQzQtUedndjr1GxY9IP6djdv+S7ck4=;
	b=E+4hY8wqSuOek6jwS7vMbjWDiIOkHSR2SS8+UJvsY6EL/NtqL9uLM0cUcIm43OBBXa8rCLw4nFfevEWDGn0I7+leba9pm9QRBHHc4wH7RFhNlq7+bLaEWpcVjWzpArQ2OwoRYYz8GBHsjyXlY0hGuxm7W4tS+L4michMu3y9UH98k/vbUBJvRMq+dfTi0ibbK6fPM63YbEbpVvtg5eA02Cd3BCtp1NdOLvTEy0X9mzaETmRXSgJwHGYCwzoz7YTxkHThwaY2SEq8Npd1v/e28Faw4Irqe1L7SHOYvu8mYYrFM0M9FEK84OhmTumScXAJn9xtrH3YxIhawfDGMKSG/g==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f0sBXv9_1760695867 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 18:11:09 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	arnd@arndb.de,
	wangweidong.a@awinic.com,
	srinivas.kandagatla@oss.qualcomm.com,
	cy_huang@richtek.com,
	nick.li@foursemi.com,
	hangyi@everest-semi.com,
	alexey.klimov@linaro.org,
	niranjan.hy@ti.com,
	shenghao-ding@ti.com,
	linux@treblig.org,
	rf@opensource.cirrus.com,
	thorsten.blum@linux.dev,
	yesanishhere@gmail.com,
	ardb@kernel.org,
	ebiggers@google.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V2 0/7] Rework the awinic driver
Date: Fri, 17 Oct 2025 18:10:58 +0800
Message-ID: <20251017101106.370742-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Rework the awinic driver, extracting common components into 
separate aw-commmon-firmware.c and aw-common-device.c files.

v1 -> v2: Correct the definition error of "__AW88395_H__"
          Fix the issue of mistakenly deleting "acpi_match_table"

Weidong Wang (7):
  ASoC: codecs:Rework the awinic driver lib
  ASoC: codecs: Rework the aw88395 driver
  ASoC: codecs: Rework the aw87390 driver
  ASoC: codecs: Rework the aw88081 driver
  ASoC: codecs: Rework the aw88166 driver
  ASoC: codecs: Rework the aw88261 driver
  ASoC: codecs: Rework the aw88399 driver

 sound/soc/codecs/Kconfig                      |   14 +-
 sound/soc/codecs/Makefile                     |    8 +-
 sound/soc/codecs/aw-common-device.c           |  508 +++++
 sound/soc/codecs/aw-common-device.h           |  206 ++
 .../aw88395_lib.c => aw-common-firmware.c}    |  150 +-
 sound/soc/codecs/aw-common-firmware.h         |  211 ++
 sound/soc/codecs/aw87390.c                    |  118 +-
 sound/soc/codecs/aw87390.h                    |   16 -
 sound/soc/codecs/aw88081.c                    |  357 +---
 sound/soc/codecs/aw88081.h                    |   33 -
 sound/soc/codecs/aw88166.c                    |  819 ++------
 sound/soc/codecs/aw88166.h                    |   58 -
 sound/soc/codecs/aw88261.c                    |  427 +---
 sound/soc/codecs/aw88261.h                    |   52 -
 sound/soc/codecs/aw88395.c                    | 1333 +++++++++++++
 .../{aw88395/aw88395_reg.h => aw88395.h}      |   58 +-
 sound/soc/codecs/aw88395/aw88395.c            |  576 ------
 sound/soc/codecs/aw88395/aw88395.h            |   58 -
 sound/soc/codecs/aw88395/aw88395_data_type.h  |  142 --
 sound/soc/codecs/aw88395/aw88395_device.c     | 1720 -----------------
 sound/soc/codecs/aw88395/aw88395_device.h     |  214 --
 sound/soc/codecs/aw88395/aw88395_lib.h        |   92 -
 sound/soc/codecs/aw88399.c                    | 1027 ++--------
 sound/soc/codecs/aw88399.h                    |   93 +-
 24 files changed, 2929 insertions(+), 5361 deletions(-)
 create mode 100644 sound/soc/codecs/aw-common-device.c
 create mode 100644 sound/soc/codecs/aw-common-device.h
 rename sound/soc/codecs/{aw88395/aw88395_lib.c => aw-common-firmware.c} (89%)
 create mode 100644 sound/soc/codecs/aw-common-firmware.h
 create mode 100644 sound/soc/codecs/aw88395.c
 rename sound/soc/codecs/{aw88395/aw88395_reg.h => aw88395.h} (91%)
 delete mode 100644 sound/soc/codecs/aw88395/aw88395.c
 delete mode 100644 sound/soc/codecs/aw88395/aw88395.h
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_data_type.h
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_device.c
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_device.h
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_lib.h


base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
-- 
2.47.0


