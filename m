Return-Path: <linux-kernel+bounces-833922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD691BA356D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6453B6210
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517602F260C;
	Fri, 26 Sep 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="kzpCxJC9"
Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63692EB842;
	Fri, 26 Sep 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882375; cv=none; b=hUUo+/MGKZzTh8Mi1tNTe2J8RZfu6ARXz++J1VYAKGAbxPzk4BRkUuFtB1ODpLPBOQy1t/u8eZBo9i64ShWVB+xVFhKO3vCDrK2F5XlWMIVFWwl1UKXq9QXxS1thPITHtmkR/1V/5RWENttyuWb8zuFHeeUYbau+vJrtoAqo09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882375; c=relaxed/simple;
	bh=8wDASfLDBw6i55POleIOnTWWlFR9LiJv1no/yHM0N98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SQ914vzkKuJfPcor6VuAFZZKBnDV+qQvnygQmBLDWpJKixxjqXPZQST7oGOezVJmqS8HXPrGP8tepNuCMXpwhRK9ZKS6ZAxQc0VE8RlPGgj1feuoxUxoWXOkPD8ynY+IvH9N50iGF7nSjIgrWAVoO9vtDYUDksvWIeJjEOGUI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=kzpCxJC9; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1758882361; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2opQkZ27zYn7x/FAA6g5GRhpv3B0H16CIxgH/O3xW/w=;
	b=kzpCxJC9O9Ri2WrwLKuChKtrFpTfJrz21kowNjpHDHflCDXCj8mwVH+oLPEEwllIvy/+b+lVyaZpYz4sWmDsvMAXb1mrdbbYfv3/D+gWaQL7CD/BydT88GV3oNb/pwDSquEcjEnToxDhwQupvgjjlFydQWQop9w3G6QRuXlWtX/Xccp2n0wbVaU+fyWhjN5o656PvYd/xv/H/g17hr2x1v8uvPCQgUDLEgI4USBBqgTVaNJMT4zJ+6uP/5ilI/UQqxPXLeWMM2NoMIuCnt3kOHwj0rmPHh1Vl38Vq7okKmAJo4C8aa4n21rJzYobMUvKbNksaLKkfeM3trbyXZsVpg==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.ensjOsh_1758882039 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 18:20:41 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	cy_huang@richtek.com,
	ivprusov@salutedevices.com,
	zhoubinbin@loongson.cn,
	zhangyi@everest-semi.com,
	jack.yu@realtek.com,
	shenghao-ding@ti.com,
	rf@opensource.cirrus.com,
	git@apitzsch.eu,
	nuno.sa@analog.com,
	colin.i.king@gmail.com,
	thorsten.blum@linux.dev,
	yesanishhere@gmail.com,
	ebiggers@google.com,
	ardb@kernel.org,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH V1 0/7] Rework the awinic driver
Date: Fri, 26 Sep 2025 18:20:30 +0800
Message-ID: <20250926102037.27697-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Extract the awxxxx driver common interfaces into
aw-common-firmware and aw-common-device
to facilitate subsequent driver usage.
Other drivers adapt to the corresponding interfaces.

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
 sound/soc/codecs/aw-common-device.c           |  509 +++++
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
 sound/soc/codecs/aw88395.c                    | 1337 +++++++++++++
 .../{aw88395/aw88395_reg.h => aw88395.h}      |   58 +-
 sound/soc/codecs/aw88395/aw88395.c            |  576 ------
 sound/soc/codecs/aw88395/aw88395.h            |   58 -
 sound/soc/codecs/aw88395/aw88395_data_type.h  |  142 --
 sound/soc/codecs/aw88395/aw88395_device.c     | 1720 -----------------
 sound/soc/codecs/aw88395/aw88395_device.h     |  214 --
 sound/soc/codecs/aw88395/aw88395_lib.h        |   92 -
 sound/soc/codecs/aw88399.c                    | 1025 ++--------
 sound/soc/codecs/aw88399.h                    |   93 +-
 24 files changed, 2933 insertions(+), 5360 deletions(-)
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


base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
-- 
2.47.0


