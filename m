Return-Path: <linux-kernel+bounces-772717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35781B296BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2686620069A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890E24503B;
	Mon, 18 Aug 2025 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4U2XFJN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC1244698
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482986; cv=none; b=i6mqVQYD24mpbm/WO8hNq5VWgUjp5MMYEwIM5cbm7K/NyWz9uOdpx8D4o7GW1S8FsusSdf8plOAfy5PgPY5hL3KZIXTn7NKS8Kgf9+aNR6R4VyoiUEw0LQLf/EUouV+kTHKf48WdzWI+8eMaLYTKu86Xfm+9rN5ONvjRndEzyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482986; c=relaxed/simple;
	bh=PQtomDfNLffO/JV0pTF/9gpLXmzy60eG5zevRwteCCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUZrVJzXQjRLUeGZXNH0dm9mOg9DUpIvWhELvBcsePIvv2VHjSCt44QSMaXDY47420r1uHmaYm1d0vPc3CrMB9RqhplwAorcro9FfSbMifUW92UXiBBd2gY30KVbc0IxlnspAedpQZz281vSULg3Ztnxd1OlXGJPZBvHTZaJKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4U2XFJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F4EC116D0;
	Mon, 18 Aug 2025 02:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755482986;
	bh=PQtomDfNLffO/JV0pTF/9gpLXmzy60eG5zevRwteCCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4U2XFJN93qi2ClpA4Czgw7kvLkCju99lUl9Rii5qI1TrUloUKaO6iDrDgLbXEwxT
	 XdbxwlTkx2AgMX7pJMGZQHHm/hs1Pa/jDCzAhPJnGw+e7IsgUENY569xthoDIAczUj
	 F0RIHQg9uLxc2UBJrWC8JUcBe9NpaFAYpGV3r7L1kZeUfTX0xpUEfjIPKsUNysrU3P
	 c0h8rno7SLRoDAaogcO84+AuUE3oqMOD8z6QfZk91QEwiyOhq7QfWzGJwXR0J/61Nc
	 s+sq49yVlG30eIicJhsKgwiKaX5xNmLT0THJ0CMsVCOy6R2AbG5ZCNv5VOhHrVyswV
	 6/QOjvvjCwWRQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to allow removing qf_name
Date: Mon, 18 Aug 2025 10:09:39 +0800
Message-ID: <20250818020939.3529802-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250818020939.3529802-1-chao@kernel.org>
References: <20250818020939.3529802-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mount behavior changed after commit d18535132523 ("f2fs: separate the
options parsing and options checking"), let's fix it.

[Scripts]
mkfs.f2fs -f /dev/vdb
mount -t f2fs -o usrquota /dev/vdb /mnt/f2fs
quotacheck -uc /mnt/f2fs
umount /mnt/f2fs
mount -t f2fs -o usrjquota=aquota.user,jqfmt=vfsold /dev/vdb /mnt/f2fs
mount|grep f2fs
mount -t f2fs -o remount,usrjquota=,jqfmt=vfsold /dev/vdb /mnt/f2fs
mount|grep f2fs
dmesg

[Before commit]
mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
mount#2: ...,quota,jqfmt=vfsold,...
kmsg: no output

[After commit]
mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
mount#2: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
kmsg: "user quota file already specified"

[After patch]
mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
mount#2: ...,quota,jqfmt=vfsold,...
kmsg: "remove qf_name aquota.user"

Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
Cc: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 465604fdc5dd..07f6c8cac07a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1219,8 +1219,11 @@ static int f2fs_check_quota_consistency(struct fs_context *fc,
 				goto err_jquota_change;
 
 			if (old_qname) {
-				if (new_qname &&
-					strcmp(old_qname, new_qname) == 0) {
+				if (!new_qname) {
+					f2fs_info(sbi, "remove qf_name %s",
+								old_qname);
+					continue;
+				} else if (strcmp(old_qname, new_qname) == 0) {
 					ctx->qname_mask &= ~(1 << i);
 					continue;
 				}
-- 
2.49.0


