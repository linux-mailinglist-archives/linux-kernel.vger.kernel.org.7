Return-Path: <linux-kernel+bounces-759821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B96B1E338
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9251AA060D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91529259C85;
	Fri,  8 Aug 2025 07:19:42 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736E2586E8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637582; cv=none; b=Zp5aC6zrSN0pfI9JIYPh+nkamSQRc/cZJs+LkOdywujE+IZaA09cdWvXr4ugVh8avTDXPd0DYKssQlhETCB0z1vdPz7Nly/4mtSfzf2wC4swyvnRgt5CI5bOqhAEh3h9fGDBYYI4PLKVA764yQUPcZLGPL3yLIU9jOs/dhR6mNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637582; c=relaxed/simple;
	bh=cZ44JH1ekoPQtXsMtLV3ek8ocL0uu0eQOM4DigjajZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQP3Sj9O8LmSqpQrCQGNzazYjt8+a87QEYJEQgm7JpyZq7R3woPh7xHbkdIpPdsnjpqdPIU701txEOLJouYhFM2VbV4oQ5Pgouf5e98ruOy5/4EwGvz+XaZ/ae8iO8Wa+RMf2EwQN8sg6/ul8hS/RoPowFmjhZEKxR72pA0H7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202508081519236158;
        Fri, 08 Aug 2025 15:19:23 +0800
Received: from localhost.localdomain.com (10.94.14.254) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.57; Fri, 8 Aug 2025 15:19:22 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	chuguangqing <chuguangqing@inspur.com>
Subject: [PATCH 0/1] add Yhgch soc chipset support
Date: Fri, 8 Aug 2025 15:15:39 +0800
Message-ID: <20250808071918.52377-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250808071918.52377-1-chuguangqing@inspur.com>
References: <20250808053508.52202-1-chuguangqing@inspur.com>
 <20250808071918.52377-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20258081519235b5f15493e19385d92f39372a92583c0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

add Yhgch soc chipset support for Yhgch BMC chipset

chuguangqing (1):
  [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset

 MAINTAINERS                                   |   5 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/yhgch/Kconfig                 |   5 +
 drivers/gpu/drm/yhgch/Makefile                |   4 +
 drivers/gpu/drm/yhgch/yhgch-drm/Kconfig       |  12 +
 drivers/gpu/drm/yhgch/yhgch-drm/Makefile      |  20 +
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_de.c    | 458 ++++++++++++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.c   | 374 ++++++++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.h   |  53 ++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_i2c.c   |  89 ++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_regs.h  | 209 ++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_vdac.c  | 116 +++++
 13 files changed, 1348 insertions(+)
 create mode 100644 drivers/gpu/drm/yhgch/Kconfig
 create mode 100644 drivers/gpu/drm/yhgch/Makefile
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


