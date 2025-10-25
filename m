Return-Path: <linux-kernel+bounces-869901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1ACC08F64
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EF31C21CC2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EEC2F8BC1;
	Sat, 25 Oct 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QiNWXidt"
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A292F7AB6
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761391080; cv=none; b=uoJQm0X6UbZfiqSojFto6JmprhzPhmBBLq9cpn6BvSweNj21ygSdXyI5yTWyT4xnmyHNwyXonJEPtRljZYYcyc9rhnd+6+Id8/SgnMSjF1GK33mqYSHIoeG+NLtfKUxZsQdPbAXHobooURdigeHXZwRjKjMtyq3EL/JIRety9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761391080; c=relaxed/simple;
	bh=SpKHxgF2ARH/BdQ+OHb950R1xoLHDWjTlV7gpt4N14g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7vUyzs7KvtzWt2SoumjNejChPQfmyBSk/zl3sQN9pQ6RvuBUFWt9nHsmjiL9o3dbAMz79Si37AwQKuDntZsmYFtrkCenxdxowFI3DUEjzfAxU/5LNMnlvCmQegmEypTlD/6HrxZ/elJ7uO5aq1snS6vs9yVpcbWatjuigB4CQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QiNWXidt; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CcHGvE38qB8skCcHVvnF0T; Sat, 25 Oct 2025 13:17:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761391077;
	bh=4NvIhj9vk2wKrMeBxFqBm5W9goe8YypRXR6TDgExS7s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QiNWXidtwAu+bQgUFAifYtVFcwtjcDkHQPDlo2NPATjQ/gncEDChUaSeKD9+yY4wM
	 FoPIu1YWkl3+TWlYAeKr4BqY6FvdtSIStyVEP2Ih2o2VgPNYx9ADg0CkeAnCJKWdol
	 jjXfb1NDFVb8h7/sa0kXZQE15U33Z3ImRde81TOwqETj6LIizt99am+Yw2OOdiw3No
	 aP4EC03SCXvp2jrRU43FILva6CHCVrkteiXgWFDYoAg5SLX/7t/+Vmao0XvXjXwifH
	 WU3htYpSPGCervNcg88Hvoik/BiilfBKllJpCprCWpOrkCro99mOG5UCuGJu0JaTUz
	 MtLZSotTxUqRA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Oct 2025 13:17:57 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: a.hindborg@kernel.org,
	leitao@debian.org
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] configfs: Constify ct_item_ops in struct config_item_type
Date: Sat, 25 Oct 2025 13:15:38 +0200
Message-ID: <f43cb57418a7f59e883be8eedc7d6abe802a2094.1761390472.git.christophe.jaillet@wanadoo.fr>
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

Make 'ct_item_ops' const in struct config_item_type.
This allows constification of many structures which hold some function
pointers.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only files that explicitly use ct_group_ops.

The script used for that is:
  while IFS= read -r -d '' file; do
    obj="${file%.c}.o" ; echo -e "\nCompiling $file" ; make "$obj"
  done < <(git grep --name-only -z ct_item_ops '*.c')
---
 fs/configfs/file.c       | 2 +-
 include/linux/configfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 0ad32150611e..affe4742bbb5 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -30,7 +30,7 @@ struct configfs_buffer {
 	size_t			count;
 	loff_t			pos;
 	char			* page;
-	struct configfs_item_operations	* ops;
+	const struct configfs_item_operations	*ops;
 	struct mutex		mutex;
 	int			needs_read_fill;
 	bool			read_in_progress;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 31a7d7124460..ef65c75beeaa 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -64,7 +64,7 @@ extern void config_item_put(struct config_item *);
 
 struct config_item_type {
 	struct module				*ct_owner;
-	struct configfs_item_operations		*ct_item_ops;
+	const struct configfs_item_operations	*ct_item_ops;
 	const struct configfs_group_operations	*ct_group_ops;
 	struct configfs_attribute		**ct_attrs;
 	struct configfs_bin_attribute		**ct_bin_attrs;
-- 
2.51.0


