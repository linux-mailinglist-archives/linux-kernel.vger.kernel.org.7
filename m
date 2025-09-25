Return-Path: <linux-kernel+bounces-832068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F8B9E441
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C3F165BED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05182E8B9B;
	Thu, 25 Sep 2025 09:18:49 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F12DE1F0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791929; cv=none; b=Zwr1NCIS8D4dKdaUpRkPHADVVz3Cv+oldpcvQNyt6J9ydLtydIqN7cWhlw15cHcbPBByrCSsjGB5Z2IQs6E5txOYSoBnseJaV6bxeK4qHs/urWYr6EAJusyxEE+J3Y8eq30jvNvJ+xMAZUnfWIeuktnPERXzEv6e6OvGgAeWlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791929; c=relaxed/simple;
	bh=DhpBhDbEnO8y53fewYRWNvA6A8iWG5EjVGSuIXjEFH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OphJgRQokJ7MhSmhWMTnl57ic5h9jYj2/ahZncFJBZOD99PWI3R9Q6EhjmulkxwcFBsKwiGhreGyRprSrANraIKzgUevfzRNBQECgZVJk7HW7RhQIuAh/zt1fWLiYaFHxIe6F3U7VCSXW1zvB1xaYrkZUBfCAahn4CuckFD3eQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201604.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202509251718310645;
        Thu, 25 Sep 2025 17:18:31 +0800
Received: from localhost.localdomain.com (10.94.5.4) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.58; Thu, 25 Sep 2025 17:18:32 +0800
From: Chu Guangqing <chuguangqing@inspur.com>
To: <tzimmermann@suse.de>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <airlied@gmail.com>, <simona@ffwll.cc>,
	<dmitry.baryshkov@oss.qualcomm.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH v5 0/1] [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset
Date: Thu, 25 Sep 2025 17:17:14 +0800
Message-ID: <20250925091715.12739-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <ouli257ffd7ocmwzywxq5zlapw7j4aqowy3oeu74x46dmpymah@b6r7py6bixsp>
References: <ouli257ffd7ocmwzywxq5zlapw7j4aqowy3oeu74x46dmpymah@b6r7py6bixsp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20259251718322ef4a34a8d88378959c156918904eed6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Hi Dmitry,

I have read Documentation/process/submitting-patches.rst. however, the content
 is quite extensive. Please point out any omissions if there are any.

Q:Is there a need to probe here just print an error?
A: it will be re-probe at detect_ctx

Q:No .disable() ?
A: yes, we have only implemented the enable function

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
  [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset

 MAINTAINERS                            |   5 +
 drivers/gpu/drm/Kconfig                |   2 +
 drivers/gpu/drm/Makefile               |   1 +
 drivers/gpu/drm/yhgch/Kconfig          |  11 +
 drivers/gpu/drm/yhgch/Makefile         |   4 +
 drivers/gpu/drm/yhgch/yhgch_drm_de.c   | 415 +++++++++++++++++++++++++
 drivers/gpu/drm/yhgch/yhgch_drm_drv.c  | 310 ++++++++++++++++++
 drivers/gpu/drm/yhgch/yhgch_drm_drv.h  |  51 +++
 drivers/gpu/drm/yhgch/yhgch_drm_i2c.c  | 114 +++++++
 drivers/gpu/drm/yhgch/yhgch_drm_regs.h | 208 +++++++++++++
 drivers/gpu/drm/yhgch/yhgch_drm_vdac.c | 121 +++++++
 11 files changed, 1242 insertions(+)
 create mode 100644 drivers/gpu/drm/yhgch/Kconfig
 create mode 100644 drivers/gpu/drm/yhgch/Makefile
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_de.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.h
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_i2c.c
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_regs.h
 create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_vdac.c

-- 
2.43.5


