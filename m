Return-Path: <linux-kernel+bounces-875425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA01C18EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE13A354F49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C88331A7F3;
	Wed, 29 Oct 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QVbQtY+V"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1E313267
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725544; cv=none; b=XiFdXm4rBeGKrAGm1fxisuxcpri7Kn5TKNTtGLxudyl++1mUf0gjLn0KI8Yt1m27/nuPz5pYqshq5APawptawoHw8/xmCUTyICdf4TcUeUjy+42UJbWW1ex1YJpIJKKjeftaVvdVxkbKGLppz6bQRtIpbqtEHCVlL4W/hklHCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725544; c=relaxed/simple;
	bh=19O6n4zMvqFGGfFmciXXxZCWuGMUjPAhCkGujLjF1tA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iu6WMgyC5zHwkoQSjMnZWCgn/mMoucVkG+zmWdQpGkVxzC9DssobjiJGYLBgCTsQGR8gF+fPTfEEdDCiFS80lQkjjBIHVrI4Ae83ZmqYB8xHwY96/vv10QjYR4mXU3FluhnO7cTkK2ZlVTf4SjktAKYD8Nx7fjrLw/Eqo4k8W58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QVbQtY+V; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761725541;
	bh=19O6n4zMvqFGGfFmciXXxZCWuGMUjPAhCkGujLjF1tA=;
	h=From:Subject:Date:To:Cc:From;
	b=QVbQtY+V1qaw3opkGKtZ5i54Jz0t330zwfqUZDHJJZEOzXzQdE4g36QQG7ddWv0/F
	 +QOeoknDczbKTTnsnTykKsDS1oIU5au2k8eTp4W66sWz8qzBzOMR6Vk84rSz2Hg2IN
	 3H6eVRDTxxkJ8+a1ssYzHhRb2ahFhQWyKc9jgxMQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 0/7] sysfs: prepare the constification of struct
 attribute
Date: Wed, 29 Oct 2025 09:12:09 +0100
Message-Id: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFnMAWkC/3XNwW4CIRDG8VcxnIthBljBU9+j8bCFoctl1zB0q
 zH77kUT9aB7/H/J/OYimEomFvvNRRSaM+dpbGE/NiIM/fhDMsfWAhVaBWAknzmxDNPIVfa1Fnk
 sdJTkDRjvMAaTRLttY8qnm/t1aD1krlM5397McF3vYrciziCVBEs7jN+9QWU//ygzcxh+h+1IV
 VzZGZ9Uh36NwkZ5CjaR9srp9JbST8oBrFG6USr6nU7JdH0KbynzoECBXqNMo0hF3ZFDp7V5oZZ
 l+QeW8bZMoAEAAA==
X-Change-ID: 20250114-sysfs-const-attr-prep-e9414982dc4f
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725539; l=2256;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=19O6n4zMvqFGGfFmciXXxZCWuGMUjPAhCkGujLjF1tA=;
 b=M2d0czKto/e/1kLEQWGmiQv1sR5IuBWTcG0CyGozo6IvHB5vhgwfPp/I0Q8WwuKXer1CtTnpx
 2MNJOKg+r2HBjgzSRJyxxXNguXbrrAjts6jkiDTYVcRrkdTmaRgYJx1
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
Changes in v5:
- Use the new CONFIG_CFI over the old CONFIG_CFI_CLANG
- Link to v4: https://lore.kernel.org/r/20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net

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


