Return-Path: <linux-kernel+bounces-869900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5BC08F61
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 083F24E65A1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95B2F7AAC;
	Sat, 25 Oct 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="N6wHXizT"
Received: from smtp.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05C2F618B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761391077; cv=none; b=qntdYOIBZWPm315Fu8gQ4K6w5i70nlafvTRK7Y7VuQ49+gZIbL7aD1yQd5Ylf8XKIqsbJaFWwaUj0zSEM+yb0WJzgtByOWUjXBuT/Lg2FBj4FuwDmUbNG0DAnlwR52f9c7f1bKYqP9OM7g/yeiV9ZyeBwvTMUV+IWHCNlR6dR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761391077; c=relaxed/simple;
	bh=rToOlBVa0seIk9cZAhalyksEJosElZgKUnKVSSTyRcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSommV2NynhgTQmEIN4J3NlfWkHERAYqPdlJhBVyALprNeBZ4iWM4ldM8vlMarBCdhvHoT8CNrlaTbg56Xk+QbWHYwqgoORTWwWTPgwpx+VXOZrZYtkUFY5uHhvxBh6l0OCZw1DDNwBAm2JYcQSafbqSG3IUHy7S3TT+ja9t56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=N6wHXizT; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CcHGvE38qB8skCcHSvnEto; Sat, 25 Oct 2025 13:17:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761391075;
	bh=0l/wY++KmID5MdksSCXlO5KXcYonclJ1OjINevUWC98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=N6wHXizTh1Tw0OYBE9zsatpOX4PnkDmEvse1odCYX0KxM3lRNWRhVi+8g8jGXyBEH
	 PqzXBa89qhGnuLutsMUuodoXOJoR6VlYxM4dRVdHg36BQkKXkGNHMM59TC1ws+YFWX
	 Dz6nmXrB6Lz72BARCr8KQVVsZpKu/qv82Y1xhXth9DpoYO3PxNkIAWZ5b1cjqJgWNm
	 a5qWMx2iKHrVlDOaRx+LuW7MoijNhb1+HF4TLPVQcQ0k2dWkbrTpsQgn9JXgIFCHgZ
	 ZyrtUe62aa0EfMapSfDYtmHSPJf4lhsHMt7wkQYnUyUiv+mgioxEnss494psL35IWW
	 vagpOxeak5pcA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Oct 2025 13:17:55 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: a.hindborg@kernel.org,
	leitao@debian.org
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] configfs: Constify ct_group_ops in struct config_item_type
Date: Sat, 25 Oct 2025 13:15:37 +0200
Message-ID: <6b720cf407e8a6d30f35beb72e031b2553d1ab7e.1761390472.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
References: <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make 'ct_group_ops' const in struct config_item_type.
This allows constification of many structures which hold some function
pointers.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only files that explicitly use ct_group_ops.

The script used for that is:
  while IFS= read -r -d '' file; do
    obj="${file%.c}.o" ; echo -e "\nCompiling $file" ; make "$obj"
  done < <(git grep --name-only -z ct_group_ops '*.c')
---
 fs/configfs/dir.c        | 2 +-
 include/linux/configfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 81f4f06bc87e..4bcd14b3434c 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -598,7 +598,7 @@ static void detach_attrs(struct config_item * item)
 static int populate_attrs(struct config_item *item)
 {
 	const struct config_item_type *t = item->ci_type;
-	struct configfs_group_operations *ops;
+	const struct configfs_group_operations *ops;
 	struct configfs_attribute *attr;
 	struct configfs_bin_attribute *bin_attr;
 	int error = 0;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 698520b1bfdb..31a7d7124460 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -65,7 +65,7 @@ extern void config_item_put(struct config_item *);
 struct config_item_type {
 	struct module				*ct_owner;
 	struct configfs_item_operations		*ct_item_ops;
-	struct configfs_group_operations	*ct_group_ops;
+	const struct configfs_group_operations	*ct_group_ops;
 	struct configfs_attribute		**ct_attrs;
 	struct configfs_bin_attribute		**ct_bin_attrs;
 };
-- 
2.51.0


