Return-Path: <linux-kernel+bounces-797724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E969BB4147F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7036542561
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40012D73B1;
	Wed,  3 Sep 2025 05:47:05 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7572D7812
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878425; cv=none; b=bqm4IgCxk9XLoxYf10EjbPbt4+OJiZ+xno8eKc7IB/11O+Nxc/AKQnXVKxUuFrdOzKZy0MB62AQgPOTYRtcJLuJSx3NJpC6APB6ukKfmQF/I7fqy2RUmY7+ymXz9DFDegeFk46tlmr+ABY7ZZTolz2i/RRBJfIZfQaS0HSI2CuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878425; c=relaxed/simple;
	bh=UtqEZnPKmkjhxwGxiPB+6zaJYg6zzmzrZLQWRMKXxIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqLM6K6IX8MCCLr0iG4ps88nzxUCmCEITlOgucPn2ugAmU7dgJ1nP/heTjkFudfMZlBzfqUobWnufVPyNbNiXxLeXWRFtSJTHCz83xnBM/81eb1AJb1Le5CyCF5MJsziMoeouAkxu+0Mpx2bOH4TWXNSweZiFtegq3mcSr/S+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202509031346473286;
        Wed, 03 Sep 2025 13:46:47 +0800
Received: from localhost.localdomain.com (10.94.10.238) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 3 Sep 2025 13:46:47 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <tzimmermann@suse.de>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <airlied@gmail.com>, <simona@ffwll.cc>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	chuguangqing <chuguangqing@inspur.com>
Subject: [PATCH v2 0/1] [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset
Date: Wed, 3 Sep 2025 13:45:32 +0800
Message-ID: <20250903054533.68540-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <086d09a9-680e-48bd-8624-2d3400a57222@suse.de>
References: <086d09a9-680e-48bd-8624-2d3400a57222@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025903134647c97faec2c4897fbdff081ed5fe2aaf10
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

1. Delete unnecessary comments
2. Delete unnecessary branch
3. Use drm_atomic_helper_check_plane_state
4. remove the alpha formats form this list.
5. use w,h rather than x, y
7. delete type casting
8. use a simple call to drm_atomic_helper_shutdown()
9. delete yhgch_load function
10. delete vblanking code
11. delete unneeded i2c type 

Some other hardware-related issues cannot be confirmed for the time being, but the current code has passed the test.

chuguangqing (1):
  [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset

 MAINTAINERS                                   |   5 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/yhgch/Kconfig                 |   3 +
 drivers/gpu/drm/yhgch/Makefile                |   1 +
 drivers/gpu/drm/yhgch/yhgch-drm/Kconfig       |  12 +
 drivers/gpu/drm/yhgch/yhgch-drm/Makefile      |   5 +
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_de.c    | 428 ++++++++++++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.c   | 324 +++++++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_drv.h   |  54 +++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_i2c.c   | 108 +++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_regs.h  | 209 +++++++++
 .../gpu/drm/yhgch/yhgch-drm/yhgch_drm_vdac.c  | 110 +++++
 13 files changed, 1262 insertions(+)
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


