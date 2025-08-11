Return-Path: <linux-kernel+bounces-762173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0313B20303
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B3189353B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73B2DE6E8;
	Mon, 11 Aug 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p86CrrAF"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F82DCF6D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903674; cv=none; b=AYf238T4WEGeooK4MYBUxrRQsHuM1WQD6uvDUn6pVnjwrPHAEUSbUzURsjfmsXD5ONS6c48R4GG6DnEsvrwgL2QglRx8TxVV533GboDZnmRSrPGW8g0zDyJcy9m11y7W68WBXxF8YGm6EC9kWvoUX06tSe+2ZZx+5YhIc8jiAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903674; c=relaxed/simple;
	bh=cqU0PLp2RlumLkRgw/nfqdxzb8kyCbuP1/hjrIv1dXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnR5F6xA7Q+43TVZ7tSeKV/rIvlhRI3+CpsVQGviqKyHiVR+tnxMHXFtsWow1SqsjEpj4QowkdVRYmdQnrVM8pZMpa4HbpwIFTSBFT8pRb87NyVGWOD1hfKiQyffHVTrntEHNq86C5NwIoHicoipThV6Q0PuoeSw3CtsHq4apkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p86CrrAF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903670;
	bh=cqU0PLp2RlumLkRgw/nfqdxzb8kyCbuP1/hjrIv1dXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p86CrrAFy3lri5B9JhUbrGbmxR74avy5v4CSfHWllyxthz5f8TJYgBewMxk4goTw+
	 PhwaNhjPhHHdvZpUX1Rzztan79vc3Ho62bklT3Xxy9YP8ZWu9E4W+2op0M4xvUSf5S
	 Q0fIeq6Wih/JhXmAM+GIHG+hzoQWkNVlZXhGRX2E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Aug 2025 11:14:30 +0200
Subject: [PATCH v3 4/7] sysfs: attribute_group: enable const variants of
 is_visible()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-sysfs-const-attr-prep-v3-4-0d973ff46afc@weissschuh.net>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903670; l=2324;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cqU0PLp2RlumLkRgw/nfqdxzb8kyCbuP1/hjrIv1dXA=;
 b=z42UvULM4vkV5Mv93hSrMBmsfQEJf63fMxwLrKfplhy8oYVIDRMVgRf19jxtOs2Vk/4PBM7w9
 yCOOuZDVv87ChQ9KhyQNyZAQjv6Us4qzy+k8cIujZC+x6K8V36AONKJ
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
index 2d78e94072a0d4ed957560c60cc3c5dd49ab6fb4..d514ce8ac4d964676006dc45a31bb9f5fe5fd5dd 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -36,6 +36,9 @@ static umode_t __first_visible(const struct attribute_group *grp, struct kobject
 	if (grp->attrs && grp->attrs[0] && grp->is_visible)
 		return grp->is_visible(kobj, grp->attrs[0], 0);
 
+	if (grp->attrs && grp->attrs[0] && grp->is_visible_new)
+		return grp->is_visible_new(kobj, grp->attrs[0], 0);
+
 	if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
 		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
 
@@ -61,8 +64,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			 */
 			if (update)
 				kernfs_remove_by_name(parent, (*attr)->name);
-			if (grp->is_visible) {
-				mode = grp->is_visible(kobj, *attr, i);
+			if (grp->is_visible || grp->is_visible_new) {
+				if (grp->is_visible)
+					mode = grp->is_visible(kobj, *attr, i);
+				else
+					mode = grp->is_visible_new(kobj, *attr, i);
 				mode &= ~SYSFS_GROUP_INVISIBLE;
 				if (!mode)
 					continue;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 3966947e78b8c030971daf5ee66bf5ab40bc2a17..1807b0369bd4d993deab81c4497903468b751a19 100644
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
+		umode_t			(*is_visible_new)(struct kobject *,
+							  const struct attribute *, int);
+	);
 	umode_t			(*is_bin_visible)(struct kobject *,
 						  const struct bin_attribute *, int);
 	size_t			(*bin_size)(struct kobject *,

-- 
2.50.1


