Return-Path: <linux-kernel+bounces-762171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3BB20300
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B48624E287B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD82DCF7E;
	Mon, 11 Aug 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="L3OaLHYr"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B92DCF42
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903674; cv=none; b=E+zHnGhzFoD1rm9Wp1vULyJIpA+zbQC2Sw6gkjlcEIR1uzG1yxmXf9SnmMSwpCyHiQOSAte8cXPuyguBpMBW9/Ay9Qcwycx1XZ3HxkBjdiyqHs9BLCOEF9mJzA+v9VTlrZ+7Rwge1OUh4XUgodTDwtyK1O1E2wrHDEwhSzUVHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903674; c=relaxed/simple;
	bh=Y86A0PjUEvP4nLOi1TH2788i9IOsqowj4hBewpzEKS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TZ62RqXdPD/zXI9wFPP9BltCQqnqFJ/EPZMmPIIGy+ySyeR7x/WjAP5negUupBqXBEcYd1HuaXpYI362YgJFeLQztPHGducX0luRvsWN4skBXepGslWtbqZB4ylk2yQ0+k66/U+WIfLuMOT7AS580wtJJKyzXwTHP6IlUNLt9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=L3OaLHYr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903670;
	bh=Y86A0PjUEvP4nLOi1TH2788i9IOsqowj4hBewpzEKS8=;
	h=From:Subject:Date:To:Cc:From;
	b=L3OaLHYrQE4kR+ZRwL6GFMmpbDjWMXMXZLB+MtriGIFtt2nXk4T5H2CtaQktVd66Q
	 TDoREGsf/3l12a7DaI+vQjyj17aHlmygc+a0M+YzW0tb1IjN26CF4Y7hNVsU+7pP4y
	 giv9kzevLj7GsTC6WSafVp4WDJrvcCS4i1o/nUHk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/7] sysfs: prepare the constification of struct
 attribute
Date: Mon, 11 Aug 2025 11:14:26 +0200
Message-Id: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHK0mWgC/3XNQQ7CIBCF4as0rMUAhVpceQ/jotJB2NCGQbRpe
 ndpE+PCdPm/ZL6ZCUL0gORczSRC9uiHUKI+VMS4LjyA+r40EUwoxrmkOKFFaoaAiXYpRTpGGCl
 oyaVuRW+kJeW2jNa/N/d6K+08piFO25vM1/UrNjti5pRRruAk+nsnBVOXF3hENO7pjgESWdksf
 lQj9B4lCqXBKAu1Zm1t/6hlWT7PbvvJCgEAAA==
X-Change-ID: 20250114-sysfs-const-attr-prep-e9414982dc4f
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903670; l=1904;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Y86A0PjUEvP4nLOi1TH2788i9IOsqowj4hBewpzEKS8=;
 b=V5yJAQo+UD5cTa18PT/ujst4qaRtb6QcnSC/mdZSmXUZvb6VSOdEBhl5+RScJNnGpjdb/rj+R
 Y+86yt9oz3QBSA11sQPQrQp23izUM22d75zGytBO5BU8sS0MQsiXG71
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The migration of 'struct attribute' and its related structures and
macros are more complicated than those for 'struct bin_attribute'.
Mostly because they are all shared by various custom attribute types.
Introduce some initial utilities to support the migration.
These are enough to migrate some specialized attributes atomically or
those which don't use 'struct attribute' in their callbacks stepwise.

The big outstanding problems are 'struct device_attribute' and
'struct kobj_attribute'. These are used everywhere and I'm not yet sure
about a migration plan.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Rebase von v6.17-rc1
- Link to v2: https://lore.kernel.org/r/20250629-sysfs-const-attr-prep-v2-0-9ec5fe39083f@weissschuh.net

Changes in v2:
- Rebase onto driver-core-next
- Simplify attribute macro definitions
- +Cc Danilo
- Link to v1: https://lore.kernel.org/r/20250116-sysfs-const-attr-prep-v1-0-15e72dba4205@weissschuh.net

---
Thomas Weißschuh (7):
      sysfs: attribute_group: allow registration of const attribute
      sysfs: transparently handle const pointers in ATTRIBUTE_GROUPS()
      sysfs: introduce __SYSFS_FUNCTION_ALTERNATIVE()
      sysfs: attribute_group: enable const variants of is_visible()
      samples/kobject: add is_visible() callback to attribute group
      samples/kobject: constify 'struct foo_attribute'
      sysfs: simplify attribute definition macros

 fs/sysfs/group.c               | 10 +++++++--
 include/linux/sysfs.h          | 48 +++++++++++++++++++++++++-----------------
 samples/kobject/kset-example.c | 44 ++++++++++++++++++++++++++------------
 3 files changed, 67 insertions(+), 35 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250114-sysfs-const-attr-prep-e9414982dc4f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


