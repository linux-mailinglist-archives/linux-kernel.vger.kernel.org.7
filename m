Return-Path: <linux-kernel+bounces-729014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0F7B0308B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01D54A177A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800C2777F3;
	Sun, 13 Jul 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l+3tpc2K"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B581917E3
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400344; cv=none; b=ZTJNSb61ASB5P6gYPXF2gbZueeBmyVaITjxAJZ1nPahqcPpDz657q0iAHh7Aee597j3RSBEaTVWmNLw7YRpanSxZwcN175fvMB5BFPsSepBpzuFAZ8Iwwny8hD1dl2OOXaq8tTK7+Scvm7YuTmQpFCUoWmRJmqjm9vG4EvSQDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400344; c=relaxed/simple;
	bh=axgjOipNhsQwsfFExnvVSYdlVFYrEP8GxSu6z0dPl4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JZZ2hE5B7pqoT+NhjYtpHgdV5cnGSvlIs6PDnPbpjzN9fQLGMGwO2d4NSqEShflMdrIgiJAgz7ak6bLc6HNo6ojNFZLyg55bFve3PvdNQ/y8LrTpByY3xnsx0NeIjOfGAxbDOPuWhyXDekilT3iB8ROa6icGMbiTC9Uq8oVDizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=l+3tpc2K; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752400334;
	bh=axgjOipNhsQwsfFExnvVSYdlVFYrEP8GxSu6z0dPl4s=;
	h=From:Subject:Date:To:Cc:From;
	b=l+3tpc2K6R5gO4GWZnvOBgaHd1p/G9cO57RWL4WwAx7dMljoybg7wfK4DIoXY9Uyp
	 y9oKeH+k4+KsXiwbprjCvPA2KBRMmFCjdazIubuoPQjEliuvYhRE9XSdP508Kgb7cA
	 mDQeRqYuWEhWBxWzWKfim9LB2UlN5XKEzPzAbWX8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RESEND v2 0/7] sysfs: prepare the constification of struct
 attribute
Date: Sun, 13 Jul 2025 11:52:12 +0200
Message-Id: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752400333; l=1787;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=axgjOipNhsQwsfFExnvVSYdlVFYrEP8GxSu6z0dPl4s=;
 b=4QRARld/Tyry4fxAILc0f+VdXBWnv9bD9uQq6oAvObUS6leXu5KXe63qS5XjqjUyb8VfVM7+B
 lgLC9sPyG+sDXGbrawdpFcbe9noTlwCQRhgMd1fONNjRrt0UOjqL1tX
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

Based on driver-core-next.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
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
base-commit: c79cbde9b7bc7a650af96269588518950e3c2441
change-id: 20250114-sysfs-const-attr-prep-e9414982dc4f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


