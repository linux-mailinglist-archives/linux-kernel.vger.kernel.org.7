Return-Path: <linux-kernel+bounces-740186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16AB0D128
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57591888444
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FBC28C036;
	Tue, 22 Jul 2025 05:20:59 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5F28A3F3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753161659; cv=none; b=eKIIYPsAC7fFjnp7skSKHoW5oMpaEWtkPuM/6CCMSY3hz52AvUQrALO0xP5TwjE5e6w7xxNEl8hJGe4TDH6zk1mOmV10TR3MN+k38UjGDIE5dRhGRRX4PLjAQGoYfzmA98cxqkvMClMM8LXxYzXLusT0yhLnB9Hyz1572HuAVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753161659; c=relaxed/simple;
	bh=hqjmti6hfc0kusm0pTRInK3QvqGfQH8DNj5bjvmY6c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqwyQHqBlqwyJwgeu7Kpiwdeybnl5oubi9bSP6UVLHwgnXVGegSXPFdTvHX/w4E5A9uZacjevkpvIZwbRz90L0vX/3cr7iJNsZUqfC4q51X4pqfNQPufT4vfFwrzDM2njMzRVI4j3bwRmgQkotYWpYhjJvqXbLvfdQiY0DVWIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-03fff7000000aab6-16-687f1fb28103
From: "yohan.joung" <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	pilhyun.kim@sk.com,
	"yohan.joung" <yohan.joung@sk.com>
Subject: [PATCH v2] f2fs: zone: wait for inflight dio completion, excluding pinned files read using dio
Date: Tue, 22 Jul 2025 14:20:45 +0900
Message-ID: <20250722052046.1445-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsXC9ZZnoe4m+foMgxMdihanp55lsniyfhaz
	xaVF7haXd81hc2Dx2LSqk81j94LPTB6fN8kFMEdx2aSk5mSWpRbp2yVwZUxbElKwnqvizNwu
	pgbGvRxdjJwcEgImEldbbrPD2P9+P2ADsdkENCT+9PYyg9giApoSRzpnAtVwcTALtDFKtB9t
	YgVJCAukS6w59QHMZhFQldi2azlYA6+AmcTyRUuZIYZqSuz4cp4JIi4ocXLmExYQm1lAXqJ5
	62xmkKESAndZJW5f3gTVIClxcMUNlgmMvLOQ9MxC0rOAkWkVo0hmXlluYmaOsV5xdkZlXmaF
	XnJ+7iZGYDgtq/0TuYPx24XgQ4wCHIxKPLwKDXUZQqyJZcWVuYcYJTiYlUR4v+0GCvGmJFZW
	pRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamDk5PZd78Xey2cw9crZ
	BVZ9H5aGZS7a8PhkxSb3H7tUvzW0/okREV71aaPJ+XX3iu6aCUvc51l52IAhoE2ivrnsWSzj
	1O/rDY2T5vYbVMV3NKpt2KnItlDI/8yx7kPa9pqXbi5wXbOk6ZbU91hmCeEV/KsuMbdPYL34
	/GpSwilWxtLe2xO+10cosRRnJBpqMRcVJwIAK2M0yCMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJMWRmVeSWpSXmKPExsXCNUNlju4m+foMg/87JC1OTz3LZPFk/Sxm
	i0uL3C0u75rDZjFh7lUmi/db7zE6sHlsWtXJ5rF7wWcmj2+3PTw+b5ILYInisklJzcksSy3S
	t0vgypi2JKRgPVfFmbldTA2Mezm6GDk5JARMJP79fsAGYrMJaEj86e1lBrFFBDQljnTOZO9i
	5OJgFmhjlGg/2sQKkhAWSJdYc+oDmM0ioCqxbddysAZeATOJ5YuWMkMM1ZTY8eU8E0RcUOLk
	zCcsIDazgLxE89bZzBMYuWYhSc1CklrAyLSKUSQzryw3MTPHTK84O6MyL7NCLzk/dxMjMECW
	1f6ZtIPx22X3Q4wCHIxKPLwKDXUZQqyJZcWVuYcYJTiYlUR4v+0GCvGmJFZWpRblxxeV5qQW
	H2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTBqJSRO2bW0vNV32/pGoXMKTdZvevk1
	c2LuZ+xi2TQ748RM/XV/poRb30vZdlvtUXR+0uSf/LZeh5hlrwR82PhAY33Qj8MLm9cvsP2W
	5zfn1nr+k5c4zhuw8zQ+MHEN27s4O6/6qWDJh21TX+68cyb1z7aYyW96nbeYfe1bE3dlS+4t
	RwkphR8ZSizFGYmGWsxFxYkAFvgumAwCAAA=
X-CFilter-Loop: Reflected

read for the pinfile using Direct I/O do not wait for dio write.

Signed-off-by: yohan.joung <yohan.joung@sk.com>
---
 fs/f2fs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4039ccb5022c..2b7e5c46c1ae 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4834,6 +4834,7 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	const loff_t pos = iocb->ki_pos;
 	ssize_t ret;
+	bool dio;
 
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
@@ -4842,12 +4843,15 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
 					iov_iter_count(to), READ);
 
+	dio = f2fs_should_use_dio(inode, iocb, to);
+
 	/* In LFS mode, if there is inflight dio, wait for its completion */
 	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
-	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE))
+	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
+		!(f2fs_is_pinned_file(inode) && dio))
 		inode_dio_wait(inode);
 
-	if (f2fs_should_use_dio(inode, iocb, to)) {
+	if (dio) {
 		ret = f2fs_dio_read_iter(iocb, to);
 	} else {
 		ret = filemap_read(iocb, to, 0);
-- 
2.33.0


