Return-Path: <linux-kernel+bounces-830007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B38B98707
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E46519C7062
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257924728F;
	Wed, 24 Sep 2025 06:52:08 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113015E5C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696728; cv=none; b=nWDdfLDa93p5PQvX5z0r0KHFEcBrbEbHf/6pLQvrnU+n4Iw3IumsieuI09YNWkSrNlvjW1nTIrzFzh7G4fp2VXM9xkj9Za7TtGOxMOj8g2nqBgPjf/LMKk9Tl/jK9l5CQYVSKVKHetT3P7OF0sJne865JI4yq5dT89dY039/iyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696728; c=relaxed/simple;
	bh=lKQ53BNxxQ4UM9Zrikah5EBu3fjh53ZLgMbeVMQIaq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grjstgqZrfywE4OZzEO5ZKplFhfacg/PR4cOEuyTXEy0ULPDZaNFAmqC4bc4fwyQLICgvsX0lKv4G4+PQLQXQXbgrBo6ZSu/A7jH7WBJRxpzAcyZUIbL7FRwvmUOs/Cyn3NbkOgWFQpLMIm43NWV7fHiw5E17jWgNJeMuKb82W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202509241450466645;
        Wed, 24 Sep 2025 14:50:46 +0800
Received: from localhost.localdomain.com (10.94.5.170) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.58; Wed, 24 Sep 2025 14:50:47 +0800
From: Chu Guangqing <chuguangqing@inspur.com>
To: <tzimmermann@suse.de>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <airlied@gmail.com>, <simona@ffwll.cc>,
	<dmitry.baryshkov@oss.qualcomm.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH v4 0/1] [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset
Date: Wed, 24 Sep 2025 14:49:53 +0800
Message-ID: <20250924064954.3921-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <d518790b-a224-443a-bbd2-1dfb41f8b0bd@suse.de>
References: <d518790b-a224-443a-bbd2-1dfb41f8b0bd@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025924145046bcdf406d4afb10f49daffd5e3e59633b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Sorry, Thomas. The changes have been made this time.

>Hi
>
>Am 10.09.25 um 04:23 schrieb Chu Guangqing:
>> +    select DRM_VRAM_HELPER
>> +    select DRM_TTM_HELPER
>
>I told you twice that VRAM helpers are obsolete and what to use instead.
>
It has been modified.
>> +
>> +struct yhgch_vdac {
>> +	struct drm_connector base;
>> +	struct i2c_adapter adapter;
>> +	struct i2c_algo_bit_data bit_data;
>> +};
>
>I've asked you several times whether to adopt the coding style in
>ast/mgag200 for the DDC.
It has been modified.
>
>No only that you not respond to to any of my reviews, you keep on submitting the same code again and again. Linux kernel development does not work like that.
>
>NAK on this driver until you get your act together.
>
>Best regards
>Thomas
>

to Dmitry:
1. use plane_state->dst instead of crtc_h/w/x/y.
2. delete duplicate framebuffer's atomic_check.
3. use FIELD_PREP() directly.
4. use dev->mode_config.
5. delete unnecessary drm_atomic_helper_shutdown call
6. add AUTHOR
7. using .enable instead 

Chu Guangqing (1):
  [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset

 MAINTAINERS                                   |   5 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/yhgch/yhgch-drm/Kconfig       |  11 +
 drivers/gpu/drm/yhgch/yhgch-drm/Makefile      |   4 +
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_de.c    | 423 ++++++++++++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.c   | 310 +++++++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.h   |  51 +++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_i2c.c   | 114 +++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_regs.h  | 208 +++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_vdac.c  | 123 +++++
 11 files changed, 1252 insertions(+)
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/Kconfig
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/Makefile
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_de.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.h
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_i2c.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_regs.h
 create mode 100644 drivers/gpu/drm/yhgch/yhgch-drm/yhgch_drm_vdac.c

-- 
2.43.5


