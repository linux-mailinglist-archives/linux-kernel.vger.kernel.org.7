Return-Path: <linux-kernel+bounces-849048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6182BCF13C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE0719A37E7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12B21CC4B;
	Sat, 11 Oct 2025 07:35:18 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB951D63FB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168118; cv=none; b=bU3XIR2QswqPkI2miD0uVIB/aIGrgSBhofCEtQt2UpSMvLemKFljPR8/uM4XATK0Hw6klh6TaGZpHCwt9Y/io+yZFlSaafDf5SKDcgUXaFfPpYaYjHlr8Zaf07RH5FYl3B+jakaXGG9J+nA7N1zS2KuYkKcmxQWhKdHC+b7SIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168118; c=relaxed/simple;
	bh=TBQLi2P+6Wjya3HtvC7MQBbtw1X/zggl0Gk8fLNiK2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sTITcmmNRaM9lpQ2LsLl2FsHid2Jjg7uPbSKkYpycKLEWkMTeaFOIqa9HFQ5rZwv7sf0GbSE9OQ5VJ5opX56kZWAMvZetotHSkwZNq+7T2x5GxH5kxqBy4CTUJlV+dFvt8NDHGkXSdtmYmjUKjpEraBkBRcgIHWZQoHueL4EwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202510111533589541;
        Sat, 11 Oct 2025 15:33:58 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sat, 11 Oct 2025 15:33:58 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 11 Oct 2025 15:33:58 +0800
Received: from localhost.localdomain.com (unknown [10.94.17.204])
	by app4 (Coremail) with SMTP id bAJkCsDwybRmCOpoD_EGAA--.846S4;
	Sat, 11 Oct 2025 15:33:58 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH v9 0/1] [DRIVER] gpu: drm: add support for YHGCH ZX1000 soc chipset
Date: Sat, 11 Oct 2025 15:32:52 +0800
Message-ID: <20251011073253.41422-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwybRmCOpoD_EGAA--.846S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr43GrWDArWfXF4UWr18AFb_yoWrGrW5pF
	4xCFyYkr1UKF4aywn3t3WxAFy3ta1xJFW3Gwn7Xw13uw4UZFy7ZFZYya45uFyDJF97Ja10
	qrnaqF1SgF17AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?k9xv/ZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KYwe0BX3M8xKr62CjdfVXGvWdzm7YiQZ5F18Nc31q0zvicJhtN+6x1xgfgdqdRRrGdKu
	b13jC4C5vDgvmQAcljA=
Content-Type: text/plain
tUid: 202510111533580813d9f6bb974be7680eb6812d86db14
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

v9:
 - Remove the check that will not occur
 - Call drm_edid_connector_update to reset when drm_edid is empty.
v8:
 - Use YHGCH uniformly and add the company's official website.

v7:
 - Delete the three preceding function definitions
 - delete Delete the redundant code and comments
(https://lore.kernel.org/all/20250929063103.7375-1-chuguangqing@inspur.com/)

v6:
 - simplify to return drm_atomic_helper_check_plane_state()
 - remove empty line
 - remove call drm_probe_ddc and smidebug
 - replace drm_err with drm_dbg_kms
 - add callback .disable
 (https://lore.kernel.org/all/20250928054123.32895-1-chuguangqing@inspur.com/)

v5:
  - remove extra level of subdiretories, change to driver/gpu/drm/yhgch
  - remove else from > +        else if (!new_plane_state->visible)
  - remove extra check in function yhgch_plane_atomic_check
  - remove the extra parentheses
  - change the author like other modules
  - use drm_edit_read function instead drm_get_edit
  - remove debug info drm_warn call
  - rename function name smi_connector_helper_detect_from_ddc to
     yhgch_connector_helper_detect_from_ddc, remove extra return statement.
  (https://lore.kernel.org/all/20250925091715.12739-1-chuguangqing@inspur.com/)

v4:
  - remove  VRAM helpers from Kconfig
  - use the coding style in ast/mgag200 for the DDC
  - use plane_state->dst instead of crtc_h/w/x/y.
  - delete duplicate framebuffer's atomic_check.
  - use FIELD_PREP() directly.
  - use dev->mode_config.
  - delete unnecessary drm_atomic_helper_shutdown call
  - add AUTHOR
  - using .enable instead
  (https://lore.kernel.org/all/20250924064954.3921-1-chuguangqing@inspur.com/)

v3:
  - The order of the code blocks has been adjusted, and the "warn-on" branch
     has been removed.
  - removed the related formats for the alpha channel.
  - removed the atomic_flush function.
  - have removed the empty line.
  - have removed the error message here.
  - replaced it with the drmm_encoder_init function.
  (https://lore.kernel.org/all/20250910022311.2655-1-chuguangqing@inspur.com/)

v2:
  - Delete unnecessary comments
  - Delete unnecessary branch
  - Use drm_atomic_helper_check_plane_state
  - remove the alpha formats form this list.
  - use w,h rather than x, y
  - delete type casting
  - use a simple call to drm_atomic_helper_shutdown()
  - delete yhgch_load function
  - delete vblanking code
  - delete unneeded i2c type
  (https://lore.kernel.org/all/20250903054533.68540-1-chuguangqing@inspur.com/)

v1:
  (https://lore.kernel.org/all/20250808053508.52202-1-chuguangqing@inspur.com/)

Chu Guangqing (1):
  [DRIVER] gpu: drm: add support for YHGCH ZX1000 soc chipset

 MAINTAINERS                            |   6 +
 drivers/gpu/drm/Kconfig                |   2 +
 drivers/gpu/drm/Makefile               |   1 +
 drivers/gpu/drm/yhgch/Kconfig          |  11 +
 drivers/gpu/drm/yhgch/Makefile         |   4 +
 drivers/gpu/drm/yhgch/yhgch_drm_de.c   | 391 +++++++++++++++++++++++++
 drivers/gpu/drm/yhgch/yhgch_drm_drv.c  | 309 +++++++++++++++++++
 drivers/gpu/drm/yhgch/yhgch_drm_drv.h  |  51 ++++
 drivers/gpu/drm/yhgch/yhgch_drm_i2c.c  | 114 +++++++
 drivers/gpu/drm/yhgch/yhgch_drm_regs.h | 208 +++++++++++++
 drivers/gpu/drm/yhgch/yhgch_drm_vdac.c | 136 +++++++++
 11 files changed, 1233 insertions(+)
 create mode 100644 drivers/gpu/drm/yhgch/Kconfig
 create mode 100644 drivers/gpu/drm/yhgch/Makefile
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_de.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.h
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_i2c.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_regs.h
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_vdac.c

-- 
2.43.7


