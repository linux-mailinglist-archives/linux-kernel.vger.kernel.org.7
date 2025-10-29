Return-Path: <linux-kernel+bounces-875426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44777C19001
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21019506AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4731A7F9;
	Wed, 29 Oct 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oeE4A9wc"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6D1D2F42
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725544; cv=none; b=lGGw2DVXNtCCC0MPmr1n+C/R7TchPUcK3LeU76K1puiWwQPcPCMo7EGKegxCdjLZtkbsg+qRzih8GjZQ6WOenHxYjOEG3jo6wPPbKGPijVRVoRjGJJliaE2GfhdBUJJNo+zT/Y2Npe7Jrxlmyzo47nYMfYSsQMl7gaaJ2sB1VH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725544; c=relaxed/simple;
	bh=N004Uk3t+Ean9/Bx8sNBms7jh3PkbCRlHcUdP2D8ljo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqcPqsTMujlStGra18u93dbch8wb0y5UeklWvliPzj/gM5/wK/lEHWNHe2oV8JG+ZxKJHxjo55tBLJiEeEsT/fCZ2nTTL/asenlytqya1F42MDPDDPhRaUBTAn3MB8OncfW7HLWXAt4CphqammdzFv/cXZn1JPzb3PolInlgdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oeE4A9wc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761725541;
	bh=N004Uk3t+Ean9/Bx8sNBms7jh3PkbCRlHcUdP2D8ljo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oeE4A9wc2smFbM0ORoITpFk/lAn6f5RTubgi1W52n3vc7skVJIkwGZGsWN+UVcKfm
	 41ARKfPVOZrYImN81zDj+/JkpsLPqRoz3+YKnQkhQbJ433qMd+14sacbKljhQIkV82
	 uLvVbMPWHyM+RDjWotkjyMMiyP09R/b5gtmxIrIE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 09:12:13 +0100
Subject: [PATCH v5 4/7] sysfs: attribute_group: enable const variants of
 is_visible()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-sysfs-const-attr-prep-v5-4-ea7d745acff4@weissschuh.net>
References: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
In-Reply-To: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725539; l=2230;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N004Uk3t+Ean9/Bx8sNBms7jh3PkbCRlHcUdP2D8ljo=;
 b=3suqCqDRglkoPZYAa4LmBL+2dAQXGm0fcTtq2krt5jb1GkSjTxVRmqN4uNVqTTqt5WDn3Dh/p
 Hj0Z1eAsxuCBA9PV2awHP11VPW1oHgOvB39iq974hvrxzARGkdtolnJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When constifying instances of struct attribute, for consistency the
corresponding .is_visible() callback should be adapted, too.
Introduce a temporary transition mechanism until all callbacks are
converted.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/group.c      | 10 ++++++++--
 include/linux/sysfs.h |  8 ++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 2d78e94072a0..d53570953617 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -36,6 +36,9 @@ static umode_t __first_visible(const struct attribute_group *grp, struct kobject
 	if (grp->attrs && grp->attrs[0] && grp->is_visible)
 		return grp->is_visible(kobj, grp->attrs[0], 0);
 
+	if (grp->attrs && grp->attrs[0] && grp->is_visible_const)
+		return grp->is_visible_const(kobj, grp->attrs[0], 0);
+
 	if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
 		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
 
@@ -61,8 +64,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			 */
 			if (update)
 				kernfs_remove_by_name(parent, (*attr)->name);
-			if (grp->is_visible) {
-				mode = grp->is_visible(kobj, *attr, i);
+			if (grp->is_visible || grp->is_visible_const) {
+				if (grp->is_visible)
+					mode = grp->is_visible(kobj, *attr, i);
+				else
+					mode = grp->is_visible_const(kobj, *attr, i);
 				mode &= ~SYSFS_GROUP_INVISIBLE;
 				if (!mode)
 					continue;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 9cef5bf24ba7..592886ed6ca9 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -104,8 +104,12 @@ do {							\
  */
 struct attribute_group {
 	const char		*name;
-	umode_t			(*is_visible)(struct kobject *,
-					      struct attribute *, int);
+	__SYSFS_FUNCTION_ALTERNATIVE(
+		umode_t			(*is_visible)(struct kobject *,
+						      struct attribute *, int);
+		umode_t			(*is_visible_const)(struct kobject *,
+							    const struct attribute *, int);
+	);
 	umode_t			(*is_bin_visible)(struct kobject *,
 						  const struct bin_attribute *, int);
 	size_t			(*bin_size)(struct kobject *,

-- 
2.51.1.dirty


