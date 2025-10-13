Return-Path: <linux-kernel+bounces-850867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33432BD43CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0F3C34F7DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BC31329B;
	Mon, 13 Oct 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uJosDbx9"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68CD30B536
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368685; cv=none; b=dcGpmuYCGLBzB+UeA0uyf9g56LWzmVP5K8iLlS0I0mB/qzmy3D+yNBrh8hbz9yaFOZVga7aFOFFfhK2q2+UczDYhnL4XqO1l4OjNrPdzYy81QZ/422jUxxDPYnefeyPtFKAKdjvvCHs/uYy0TgO0SIgbxM7yDNKLZTpVeA0l8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368685; c=relaxed/simple;
	bh=GOom/VXkrSCRhov7K+YLJwNjxxlLOnx4LbzK593FkGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX7uhLfpKbk56MXKTvNE+u94myi4nT+v9+HhofSlmTrrc9nUrgWQceYUSApMxkaLAlineb+aT5PUqBxP1jdQ5PLFjUDkeGwUsPVLt7+wi5ATwl1G4/ljHzcDylG60Zt+VD395FHFBpTwCtCkrqcFnmqAg/bOF9bB4JcLuWzIhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uJosDbx9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760368677;
	bh=GOom/VXkrSCRhov7K+YLJwNjxxlLOnx4LbzK593FkGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uJosDbx9NLnMdwutCnrKYnOmwhXOaRi9T+8EAzc6vBGyyvme4v3033oayywOUDlhy
	 PgV2+TIY142AClJBPicjrnboA5E0UsNqZl3GeS4NWwOl/gTzKcJDCZFxZcTsbFqoHw
	 oLJY+fi90H/ZCft6pKHe21UB1S8vKqAOwjiF+LwY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 17:17:57 +0200
Subject: [PATCH v4 4/7] sysfs: attribute_group: enable const variants of
 is_visible()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-sysfs-const-attr-prep-v4-4-e0d36e828334@weissschuh.net>
References: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
In-Reply-To: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368676; l=2224;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GOom/VXkrSCRhov7K+YLJwNjxxlLOnx4LbzK593FkGQ=;
 b=th7heMjy6iwHyODvgr4g8uZaZfnH90IGd8oyw0Kaaq73erpiM9BYspJa9VHGPNeweuPBom5RN
 eP9zbchFCNsB6icC6fBAWraKcrWlIM9bUT465sJjVD8HXiP5YqOKeRi
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
index 02e5a9f946ee..ec4aed8c8181 100644
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
2.51.0


