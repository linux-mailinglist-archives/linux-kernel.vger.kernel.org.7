Return-Path: <linux-kernel+bounces-850860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F784BD4A52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773EA3E36A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB430B505;
	Mon, 13 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cs9yr5tB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7430AD01
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368681; cv=none; b=tHDae5VPEbTnkGTfRZJUvzoQhXlGe1M4ImXco5RKci9Bv6wxkG+YBTPXwetueH6sumkkFbuaZ+ZOU+hddKuZwUG9l7jx10w2xpdFOY1JHE8l6WSBQFgDyRZcfmV9deCnIvVhBIio48xDGIDPxri6EK11hiTRCZUrwDMB6+m7NB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368681; c=relaxed/simple;
	bh=qP13U0z69r3V6e3GMmvP60/AkklKJ7cBt7ijHznvQvE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gHwd+ikNfIvHuoUq8g7gZQFgJWnZYoR/tHO7zYNMQatkDtPufBpuUcE3dbNFc9X/Los011GsRgUQ415egKk0uOXisjq+9hKSOsrRUtdmpBUgJX1D/TXo+kHSrem6dOdF3IN/tmiolH1PySU+Kk9zjFte81yZrO17Xf4PBdEcM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cs9yr5tB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760368677;
	bh=qP13U0z69r3V6e3GMmvP60/AkklKJ7cBt7ijHznvQvE=;
	h=From:Subject:Date:To:Cc:From;
	b=cs9yr5tB35D4c9Fu4iRyeCriYMRzBqLz8MBq0kQWlIZRxd2gOuqcRwlerh0hAfCfL
	 svsgJ+FBk4R1sNM20fDRMbkIOiPpeIjbYg4/8xEEdBGPpZIH2uGH4L3IV/yHsyAQQO
	 Dz66NjWCu4jo1kAXBbtqM9VLEErNU67IKHr9uWDI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 0/7] sysfs: prepare the constification of struct
 attribute
Date: Mon, 13 Oct 2025 17:17:53 +0200
Message-Id: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACIY7WgC/3XNTQ6CMBCG4auQrq3pL1BX3sO4wHYq3YDpVJQQ7
 m4hMSyU5fsl88xEEGIAJKdiIhGGgKHvcqhDQWzbdHegweUmggnNOFcUR/RIbd9hok1KkT4iPCg
 YxZWphbPKk3ybRx/eq3u55m4Dpj6O65uBL+tXLHfEgVNGuYZKuFujBNPnFwREtO2zPXaQyMIOY
 qNKYfYokSkDVnuQhtXS/6XkRtWc71EyU8yZSnqvysbbH2qe5w9loyoHVQEAAA==
X-Change-ID: 20250114-sysfs-const-attr-prep-e9414982dc4f
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368676; l=2077;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qP13U0z69r3V6e3GMmvP60/AkklKJ7cBt7ijHznvQvE=;
 b=ekggbDzXpQgn6eaayGT+XPcAVDMpXmhF6wKohgsapR15cWbIpRvpdVhi60DxN5GVZ5+jf0vzF
 VR5KjwyXzjkAUydLlAIbIWBoOSQRr8+AiAhRjGoAbD8wXhwFZJPJPQx
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
Changes in v4:
- Rebase onto v6.18-rc1
- Rename _new -> _const
- Link to v3: https://lore.kernel.org/r/20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net

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
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250114-sysfs-const-attr-prep-e9414982dc4f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


