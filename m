Return-Path: <linux-kernel+bounces-891431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E3C42A69
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C503834993E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2E2EA749;
	Sat,  8 Nov 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qmChAzpA"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE67235360;
	Sat,  8 Nov 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594605; cv=none; b=B9v6ephMtLdJO2fKxxei9O2Jr3jMeigyBL8aL6l0gXUUC5SZc4wBALx+RxIBncBxtGni2DmHq+dQXsBPIDfgo6YeIFR2ku6v+m6V4cpoxiG4mBXvKOmM5nhEKzjdcBuKEAr8JTliJlUU0OR+5DSA2MomZfeV69XpD71c6GSkIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594605; c=relaxed/simple;
	bh=BhhSYA/yQZfYitLuF4IY7WD/v9JWZaXGBTVLojARsv0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tEeS5gzlENIgDrjiPvGzaLmUN9XXbkWOn2z7yOFXd64CQro5Uv0paRQFrCQ6/nKq6JMYMv8HgBjiwmqzJ9BviG4Q0558/7w5rhfsvo57dymuAcG/y8oBryYDVAD/ewvfhiOGk4trd4rLxAac+SL7PGLhibcTgqZyAQBJ1o4VNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qmChAzpA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.172] (mob-5-90-142-135.net.vodafone.it [5.90.142.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33A98DD9;
	Sat,  8 Nov 2025 10:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762594484;
	bh=BhhSYA/yQZfYitLuF4IY7WD/v9JWZaXGBTVLojARsv0=;
	h=From:Subject:Date:To:Cc:From;
	b=qmChAzpA1D9im/tXnzs+pwgybmBljME+K0Cr3qpeur/RS3clH3QBFZknzLiDxyyJw
	 ufKt5n7PBSVUR9doHlwPxtRvct4ceQBJgsjL5WpYK92kIi3ZSQ68gN9Yc9MDGW0/3J
	 ZE8tXPhsub7EZYWgsw3eyBAR3Z1WXK98SaooILv0=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Subject: [PATCH v9 0/8] media: Introduce V4L2 generic ISP support
Date: Sat, 08 Nov 2025 10:36:21 +0100
Message-Id: <20251108-extensible-parameters-validation-v9-0-6a7e22aa57d0@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUPD2kC/43Qz2oDIRAG8FcJnmvx76o59T1KDzqOjZDsBl2Wl
 JB3rwm02UOXevwG5vcNcyUVS8ZK9rsrKbjkmqexBfeyI3Dw4yfSHFsmggnNDOMULzOONYcj0rM
 v/oQzlkoXf8zRz22ZgpU8maQBWCCNORdM+fKoeP9o+ZDrPJWvR+PC79Mf3P6PL5wy6hIIAw6Ms
 PCWI/o6jWHyJb7CdCL3jkWsXM46XNFcg2AdtwhKyQ1XPl3LXYcr7/dGYMxKZYNkG65auaLnXtV
 cyRJq7xwEnjZc/XQd1x2ubi4OMTilBuvT1h+GX5czZjrcobk6Ge6iS9Kh3nDNyuWqwzXNHQZhA
 0YN3tkN167crv/a5voUvAreBCXiH+7tdvsG+TbCcT8DAAA=
X-Change-ID: 20250701-extensible-parameters-validation-c831f7f5cc0b
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Keke Li <keke.li@amlogic.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dan Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Antoine Bouyer <antoine.bouyer@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6558;
 i=jacopo.mondi@ideasonboard.com; h=from:subject:message-id;
 bh=BhhSYA/yQZfYitLuF4IY7WD/v9JWZaXGBTVLojARsv0=;
 b=owEBbQKS/ZANAwAKAXI0Bo8WoVY8AcsmYgBpDw8lZork7+wch0LJyMIkMt584D14/Y9QKj2ai
 gExnKh1pSyJAjMEAAEKAB0WIQS1xD1IgJogio9YOMByNAaPFqFWPAUCaQ8PJQAKCRByNAaPFqFW
 PA/aEADBfoMyvkoo9ErdWAMc+RKsrgooN5iAOIJjpAe15exE4BXXWvUq1qnSz5RmYmoSYTcqGTK
 yjoqWeDGnQ0tRxlhLcqJrYqB5V0baX7WOWcsf4hmRR2leC8taO4RerDmxFE7PQEwmVIiadao4Iv
 fsWncThhrpOt8OYVQPNBsynCvFuetIdUSyOLSfI8AE2Aos5czJ3nE7LdVJRx2cZivC/7ECkzP2h
 52NA9IApiLvcCrI0JMvarTQuv+9NKO8xJpx/t4pked46uMy8mfnrc19KCh9PIozWTUaIHFcK1AV
 bct8Pj8/w/c0s8VZLwOxbNTyjoZILsR8o6jCCiXGvXOFoChHlgri146tdzDlyrYF40GatvwDOqu
 JReAk1A023rqCLfzxvhZiWyg/Y2uPZxiJaF9e6jVIZdkoakqyjU/8TRr2DcdpgvA+EIESpULKk7
 LYTi9cNDlaULrwvVVCEVfjdQJIEnROLmw2DBrJfOHTyPj/EbIit+05HV3izSGyaWYAH32EXAWAP
 9BprTFDJUpGvamJl5g8A1HKRBiEu1B4dUZopypGeqOAJKsqRoltnp3mVpC2OWFsZLD3pk9u/Jeb
 SYFnbONeVeYuEHWkES5MrJ4onUxI4kmtkiV1/z9WBDlI2AkYjm1AvI1GZna0DghPnh7uXpIw+HT
 bPayhmhf1V2SE8g==
X-Developer-Key: i=jacopo.mondi@ideasonboard.com; a=openpgp;
 fpr=72392EDC88144A65C701EA9BA5826A2587AD026B

Extensible parameters meta formats have been introduced in the Linux
kernel v6.12 initially to support different revision of the RkISP1 ISP
implemented in different SoC. In order to avoid breaking userspace
everytime an ISP configuration block is added or modified in the uAPI
these new formats, which are versionated and extensible by their
definition have been introduced.

See for reference:
e9d05e9d5db1 ("media: uapi: rkisp1-config: Add extensible params format")
6c53a7b68c5d ("media: rkisp1: Implement extensible params support")

The Amlogic C3 ISP driver followed shortly, introducing an extensible
format for the ISP configuration:

6d406187ebc0 ("media: uapi: Add stats info and parameters buffer for C3 ISP")

with a very similar, if not identical, implementation of the routines to
validate and handle the ISP configuration in the ISP driver in the
c3-isp-params.c file.

fb2e135208f3 ("media: platform: Add C3 ISP driver")

With the recent upstreaming attempt of the Mali C55 ISP driver from Dan,
a third user of extensible parameters is going to be itroduced in the
kernel, duplicating again in the driver the procedure for validating and
handling the ISP configuration blocks

https://patchwork.linuxtv.org/project/linux-media/patch/20250624-c55-v10-15-54f3d4196990@ideasonboard.com/

To avoid duplicating again the validation routines and common types
definition, this series introduces v4l2-isp.c/.h for the kAPI
and v4l2-isp.h for the uAPI and re-organize the RkISP1
and Amlogic C3 drivers to use the common types and the helper validation
routines.

The v4l2-isp abstraction will be augmented to support statistcs as well.

If the here proposed approach is accepted, I propose to rebase the Mali
C55 driver on top of this series, to use the new common types and
helpers.

Tested on Mali C55 and RkISP1 with camshark

Thanks
  j

Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
Changes in v9:
- Modify the RkISP1 and C3 params drivers to enumerate their block info
  with macros (and static_assert they're of the correct size)
- Modify documentation according to Laurent's suggestion
- Link to v8: https://lore.kernel.org/r/20251020-extensible-parameters-validation-v8-0-afba4ba7b42d@ideasonboard.com

Changes in v8:
- Address Michael comments and reword documentation
- Use the correct "metadata capture" for stats and "metadata output" for
  parameters. I mixed up the two in the previous revisions.
- Link to v7: https://lore.kernel.org/r/20251014-extensible-parameters-validation-v7-0-6628bed5ca98@ideasonboard.com

Changes in v7:
- Moved version to the v4l2-isp uAPI
- Moved version check to the v4l2-isp.c helpers
- Link to v6: https://lore.kernel.org/r/20251007-extensible-parameters-validation-v6-0-5f719d9f39e5@ideasonboard.com

Changes in v6:
- Rename all symbols to v4l2_isp
- Changed the interface of the two buffer validation functions
- Reworked the rkisp1 and c3 porting accordingly
- Updated documentation
- I have moved v4l2_params_buffer_size() from uAPI because it was
  convenient for linux but not required in userspace
- Link to v5: https://lore.kernel.org/r/20250915-extensible-parameters-validation-v5-0-e6db94468af3@ideasonboard.com

Changes in v5:
- Move everything to v4l2-isp prefix except from format documentation
  which still is about 'extensible-parameters' (to be paired in future
  with extensbile-stats)
- Simplify documentation and move it part to the driver-api
  Documentation
- Remove 'group' and 'features' from the generic handlers definition and
  adjust rkisp1 accordingly
- Link to v4: https://lore.kernel.org/r/20250820-extensible-parameters-validation-v4-0-30fe5a99cb1f@ideasonboard.com

Changes in v4:
- Fix the definition of V4L2_PARAMS_FL_PLATFORM_FLAGS
- Add __counted_by() attribute to the data[] flexible-array member of
  v4l2_params_buffer
- Minor style change
- Link to v3: https://lore.kernel.org/r/20250819-extensible-parameters-validation-v3-0-9dc008348b30@ideasonboard.com

Changes in v3:
- Rebased on latest media-committers/next
- Take in Dan's suggestion in block size validation
- Documentation minor spelling fixes
- Link to v2: https://lore.kernel.org/r/20250710-extensible-parameters-validation-v2-0-7ec8918ec443@ideasonboard.com

Changes in v2:
- Make v4l2_params_buffer directly usable
- Centralize ENABLE/DISABLE flags definition and validation
- Take in Dan's v4l2_params_buffer_size()
- Allow blocks to only contain the header if they're going to be
  disabled
- Documentation fixes as reported by Nicolas
- Link to v1: https://lore.kernel.org/r/20250708-extensible-parameters-validation-v1-0-9fc27c9c728c@ideasonboard.com

---
Jacopo Mondi (8):
      media: uapi: Introduce V4L2 generic ISP types
      media: uapi: Convert RkISP1 to V4L2 extensible params
      media: uapi: Convert Amlogic C3 to V4L2 extensible params
      media: Documentation: uapi: Add V4L2 ISP documentation
      media: v4l2-core: Introduce v4l2-isp.c
      media: rkisp1: Use v4l2-isp for validation
      media: amlogic-c3: Use v4l2-isp for validation
      media: Documentation: kapi: Add v4l2 generic ISP support

 Documentation/driver-api/media/v4l2-core.rst       |   1 +
 Documentation/driver-api/media/v4l2-isp.rst        |  49 ++++++
 .../userspace-api/media/v4l/meta-formats.rst       |   1 +
 Documentation/userspace-api/media/v4l/v4l2-isp.rst |  67 +++++++++
 MAINTAINERS                                        |  10 ++
 drivers/media/platform/amlogic/c3/isp/Kconfig      |   1 +
 .../media/platform/amlogic/c3/isp/c3-isp-params.c  | 165 ++++++---------------
 drivers/media/platform/rockchip/rkisp1/Kconfig     |   1 +
 .../media/platform/rockchip/rkisp1/rkisp1-params.c | 150 ++++++-------------
 drivers/media/v4l2-core/Kconfig                    |   4 +
 drivers/media/v4l2-core/Makefile                   |   1 +
 drivers/media/v4l2-core/v4l2-isp.c                 | 128 ++++++++++++++++
 include/media/v4l2-isp.h                           |  91 ++++++++++++
 include/uapi/linux/media/amlogic/c3-isp-config.h   |  92 +++---------
 include/uapi/linux/media/v4l2-isp.h                | 102 +++++++++++++
 include/uapi/linux/rkisp1-config.h                 | 107 +++----------
 16 files changed, 590 insertions(+), 380 deletions(-)
---
base-commit: b4fbb13db86adb0bae1d7f968b61ea8dc9635e33
change-id: 20250701-extensible-parameters-validation-c831f7f5cc0b

Best regards,
-- 
Jacopo Mondi <jacopo.mondi@ideasonboard.com>


