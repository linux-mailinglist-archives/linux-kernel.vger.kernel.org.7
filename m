Return-Path: <linux-kernel+bounces-782042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA0B31A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22013B0EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F9303C91;
	Fri, 22 Aug 2025 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="RbA1zhpq"
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0E304972
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870366; cv=none; b=kEFSVTJKOSCdY7+cea0QURq/vmG9qd25PXwPP48XWqkwU7nIR/998BTWaWKBnv7FExbjjX2PHaKyB4pBN//p98lGWPg2I97XImE4bfyBuFm1vrP1se3OHnYQXgqhiDnAvdkr0KJ/j6bQQULU4zsMXZSnS2oROhl8JQhjKpq8/x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870366; c=relaxed/simple;
	bh=ZOSMC4OjWtW7yb2kPuRGEeroGWUx6GoEMLywU+D92k0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxlO6SGOHSTjdTUPxydCCRT6ssIaXtJanLbt4Qywo6uTIGoGVqcOYiU8x5jDr4nPgs/VBfY/9pT1vZeY+lfWHbQIURpMU3qfFvxEs1me2/ssOEjXYE2sJFsMnZkR9S0Dmf7U/GKO9QIo4ihUDeusImvz4MrOFMa4GjvQ/87c+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=RbA1zhpq; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755870365; x=1787406365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tPUYH0q4GZEUEc5Nb9dVSHQ3jDJPvNwKWupuLPdNVIw=;
  b=RbA1zhpqho/P0RbEUr3FW6DeMVVS2iZQWz5Kj8KD30oj55J/xa3XacFz
   ZHMBFtv1UQkkzxCArEwiWMteoKxh1uZDW7kGOMdTwMKmHMn8yfDQjzC+r
   t+7xDeVmUBIFh1zNz4Rcsl9S4fhCc3QpLly3Ru2Pd5hICVH420+rbpjnG
   AADxbiJMwkHCfuxe+O+ZgIeBdMOeKWq2ui6NmsMl1N+yGIdgMb7toVM7D
   LORSTd5ytQynC7DUPF8idkZYdYJzMr9OVIIPmHj1Zrf4W9exNYPZLrKw4
   kAuX2nLXTSqvgB7uLSPnCquhp3AkmT+oOLBvs/wddF/CmAwe05/yTJPKT
   g==;
X-CSE-ConnectionGUID: S3DhnRCdQSuOt4hjDM+CjA==
X-CSE-MsgGUID: ahs/uZtoS4OQ2fAexoYzPQ==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1501244"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:46:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:57568]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.152:2525] with esmtp (Farcaster)
 id 17fe71fe-729e-465b-86aa-91a1b544a24e; Fri, 22 Aug 2025 13:46:02 +0000 (UTC)
X-Farcaster-Flow-ID: 17fe71fe-729e-465b-86aa-91a1b544a24e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 22 Aug 2025 13:46:02 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 22 Aug 2025 13:46:01 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
Date: Fri, 22 Aug 2025 22:45:48 +0900
Message-ID: <20250822134548.415-1-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <68a6e577.050a0220.3d78fd.0020.GAE@google.com>
References: <68a6e577.050a0220.3d78fd.0020.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

#syz test

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 795c6388744c..3947ef762aaa 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -59,7 +59,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses, int flags)
        sb->s_maxbytes = MAX_LFS_FILESIZE;
        sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
-       sb->s_blocksize = 1 << sb->s_blocksize_bits;
+       sb->s_blocksize = BIT(sb->s_blocksize_bits);
        sb->s_magic = V9FS_MAGIC;
        if (v9fs_proto_dotl(v9ses)) {
                sb->s_op = &v9fs_super_ops_dotl;

