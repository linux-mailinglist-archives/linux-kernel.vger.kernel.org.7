Return-Path: <linux-kernel+bounces-873773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E654C14ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE401B221F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C904C32E6B5;
	Tue, 28 Oct 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="VNx6oLH0"
Received: from out198-9.us.a.mail.aliyun.com (out198-9.us.a.mail.aliyun.com [47.90.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261032D7DA;
	Tue, 28 Oct 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655180; cv=none; b=d5BomGDJfmMIbN6FI704PacYLdx9aZ5Hmespgu5AZQffO99Mq684U3pUNdz2b5psK5GZu6EZ9Zu4SB1IPku7s4r52crXP/Ly+J7uaMTDMX06JEZ14bFHXPoFtP2fP8vY0qC313kd3g4PV326uldll8Jk1yJM4pmfsYQPafGg8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655180; c=relaxed/simple;
	bh=tIBFUfB6QlsKoLYSLzx7JqIy3Ba4v25jwlLLmDYWlmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8Vpv1EwT51qb/0WBpzMW/BbbAxrXoVmfQxBpLd1tyID/KVk0p+8I/h3sUty3tUQ/bQNe8ZJwAFQewgmllPXCI5Vh6wPNoF+P8BA9yqFfzfemh9vuhNvbSlgyUN9LWYBxWI4c1+YMXyzA3HEMvNWWoJtobs7n9vOGJBAz3ose3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=VNx6oLH0; arc=none smtp.client-ip=47.90.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1761655163; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8rFH4thlQmElnslr1bW600elt3sgQ3K0TLP6mKWzDnc=;
	b=VNx6oLH0Gz8KP+ODdcFX7JgcAC0rR4oEgDe+L2EcJoDWtsvxN3Iyqho5dv+Z7CrJQ9TyjTCo6TnROKlTNjNI6Oe9LL5ovpwZrMiHPXmnG+HW+s+c3HeHkGfufkYyc0wG0+eL5v3ED9DVK17BNpe8xKXUfzBZBAq2EJ7Z5foiwX56uhCXcVi/NHjBRZgmbprMmV87SdnzUa/65A6PJxHPbsO9r3cNMqhd1B3QGhnQi52gt8UjFeq+1YvwKrATvUvPDQmaKeUZ7M5W08OpnP3lGGh1I39r8qJ4Z1MXAsrb9q9Sc+hYR5uzCJfNhH+sR3GE/omkL6OF9IrD8/OnMffnLw==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f9Oy78H_1761654839 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 20:34:01 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	srinivas.kandagatla@oss.qualcomm.com,
	wangweidong.a@awinic.com,
	arnd@arndb.de,
	cy_huang@richtek.com,
	nick.li@foursemi.com,
	shenghao-ding@ti.com,
	alexey.klimov@linaro.org,
	niranjan.hy@ti.com,
	linux@treblig.org,
	zhangyi@everest-semi.com,
	thorsten.blum@linux.dev,
	kuninori.morimoto.gx@renesas.com,
	yesanishhere@gmail.com,
	marco.crivellari@suse.com,
	ebiggers@google.com,
	ardb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V3 0/7] Rework the awinic driver
Date: Tue, 28 Oct 2025 20:33:50 +0800
Message-ID: <20251028123357.46161-1-wangweidong.a@awinic.com>
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

v2 -> v3: Change the tree to
          https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

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
 sound/soc/codecs/aw-common-device.c           |  507 +++++
 sound/soc/codecs/aw-common-device.h           |  204 ++
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
 24 files changed, 2926 insertions(+), 5361 deletions(-)
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


base-commit: 2103a2df654868faf4ac0924ce529b11cca729bc
-- 
2.47.0


