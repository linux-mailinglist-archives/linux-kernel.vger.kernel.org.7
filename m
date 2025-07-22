Return-Path: <linux-kernel+bounces-740226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ABCB0D196
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8676C1AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DD28CF56;
	Tue, 22 Jul 2025 06:02:58 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167628B4F3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164178; cv=none; b=FZ1kYWm6LW5+gxc/eHMBQj9yNKn72yg9/fZbvSHEShXPJMAuNPB206zMOIFCr6u8b9C6WObsusjNN4DTHuTgPCPjt3vmLTDaoVvit1Qlj/E4jp3BDnsOrorJlkBFVYOscqzGlAkewR5K8t+8C88XmkIO6CykIrVuBPwGBdEtCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164178; c=relaxed/simple;
	bh=UfQ3VJGtVqSJsSlcGejXJaFG7CD0ZGrElD20IS5KC0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiTZIZGW+skHbRPhljgym3CXqbAy7Sfvt4vomNtoKQze9gkCp0S+J5G6A787uFidfde7bPbkcuTpGGkOUmKHbd26jraj/X9b19YFu/CIPPVHmWFlw86ZRic9KTj4Qho6aYlXoIc+cEL1EMN1G/2W160IXGp2Tqs4tkYz6BVaCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-03fff7000000aab6-42-687f298450ec
From: "yohan.joung" <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	pilhyun.kim@sk.com,
	"yohan.joung" <yohan.joung@sk.com>
Subject: [PATCH v3] f2fs: zone: wait for inflight dio completion, excluding pinned files read using dio
Date: Tue, 22 Jul 2025 15:02:40 +0900
Message-ID: <20250722060240.1469-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhesuzULdFsz7D4NZXPovTU88yWTxZP4vZ
	4tIid4vLu+awObB4bFrVyeaxe8FnJo/Pm+QCmKO4bFJSczLLUov07RK4MloeRhVs4KrofHeR
	qYFxH0cXIyeHhICJxNITs5lg7Ne9R9hAbDYBDYk/vb3MILaIgKbEkc6Z7F2MXBzMAm2MEu1H
	m1hBEsIC6RJtT2aC2SwCqhLT+7rZQWxeATOJ1pdTWSCGakrs+HKeCSIuKHFy5hOwOLOAvETz
	1tnMEDV3WSUm36qCsCUlDq64wTKBkXcWkpZZSFoWMDKtYhTJzCvLTczMMdYrzs6ozMus0EvO
	z93ECAymZbV/IncwfrsQfIhRgINRiYdXoaEuQ4g1say4MvcQowQHs5II77fdQCHelMTKqtSi
	/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MlmsPJQX3paRflgrsyxET
	axNsF3l2zGdK9J7TsyfsOSEZZHK32v9YqXR2lMW3z6bWltPOtN5+xlY41zRR+sakcK3LB7n6
	TFduFrLanVISs6pvgpXOq51x+a3+k58vLlGaeObX2/yfzOGOc4u1tCIzPxk9Xeezu01p7y2D
	9HMn2hIWdp3fmGigxFKckWioxVxUnAgANLIxZyICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJMWRmVeSWpSXmKPExsXCNUNljm6LZn2GwbTFrBanp55lsniyfhaz
	xaVF7haXd81hs5gw9yqTxfut9xgd2Dw2repk89i94DOTx7fbHh6fN8kFsERx2aSk5mSWpRbp
	2yVwZbQ8jCrYwFXR+e4iUwPjPo4uRk4OCQETide9R9hAbDYBDYk/vb3MILaIgKbEkc6Z7F2M
	XBzMAm2MEu1Hm1hBEsIC6RJtT2aC2SwCqhLT+7rZQWxeATOJ1pdTWSCGakrs+HKeCSIuKHFy
	5hOwOLOAvETz1tnMExi5ZiFJzUKSWsDItIpRJDOvLDcxM8dMrzg7ozIvs0IvOT93EyMwQJbV
	/pm0g/HbZfdDjAIcjEo8vAoNdRlCrIllxZW5hxglOJiVRHi/7QYK8aYkVlalFuXHF5XmpBYf
	YpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MG698p3N0mHqRqvmH7cc5k8LOR4SwP9z
	9295pULPncd+ZWouFtk5Tffgma9fjr35MU2ZOdzC2jz0YlvP2i3zSl57Hmd4f51LZZmUIhvL
	9JCon35eKqfORQdEvGYUEbra/jj10enbyoxpZyNXqplr7pxl8Ohi9TNfs9Oib4w28jr3LTNJ
	PBG/ab0SS3FGoqEWc1FxIgDtdD7QDAIAAA==
X-CFilter-Loop: Reflected

read for the pinfile using Direct I/O do not wait for dio write.

Signed-off-by: yohan.joung <yohan.joung@sk.com>
---
 fs/f2fs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4039ccb5022c..58a4d25eb08f 100644
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
+		(!f2fs_is_pinned_file(inode) || !dio))
 		inode_dio_wait(inode);
 
-	if (f2fs_should_use_dio(inode, iocb, to)) {
+	if (dio) {
 		ret = f2fs_dio_read_iter(iocb, to);
 	} else {
 		ret = filemap_read(iocb, to, 0);
-- 
2.33.0


