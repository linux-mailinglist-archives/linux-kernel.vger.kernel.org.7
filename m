Return-Path: <linux-kernel+bounces-782000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F6B319B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3932E4E54EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42302FD7C9;
	Fri, 22 Aug 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EIsaIcZc"
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2FB2FF161
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869530; cv=none; b=CBMMfEHD2S+3SmRK0wklF0jgB8E/abNWFIqhW3CQAXgj7EyX/rgMbrDaw6nVCh2VS423n9+owLT0wUM0wB1x1N2X6rrGCakUQ4XmbCPF/JRY6eKO31rIAgWTpEaPG4HjHzizsQygzyvF4RlMGPj74JuFqRmf3VKhteOXoPeCtrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869530; c=relaxed/simple;
	bh=L45oTMiOlaaOd+nPv6NQxIvpKmSWzZsDRWEfVybZ0Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubOX3uGTu/NI2VzotXwaoLjEUcERO5pZVVLgJi5sPmIv0b/RZjtxBbuzOQsjpJB1+coiyCcXCC0inJnolKOGBw0jLvkVZ1C2fS+qFszCYneXL89a3BiJvChh/eJrbl/fjeHqvxMZ8b876e05+shvJ7CTLdmgbfoYg0Lvjt9M9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EIsaIcZc; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755869528; x=1787405528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cUSZ5JNVmVEfL0q8eL0Od4vX8QNOMh2ME0a+7nBrD8Y=;
  b=EIsaIcZcyt+on8pJUxpUMaGn7PkC8o8T/hluU5kahnHEqVNNB+w6rk3x
   0FnyTUL463tfDYhBWRGhM11Gd7HyjuW20ysBnIfBXrl5U9gkVCW5hHxRD
   sby5kwQmH939R2ASEhw6I09qKdkEZMxB67n1KEUVz45vU1kjaTbN2H5kJ
   zUhH7rGfhMaiPMWzdwPd44rB3EZThEJR7BZcBgO568LP3hrFWiyI6lzcR
   7d95aO+42fQVEZ5UHU5T+aHPnKIR1e+SwwwuyiTQsZ50H4H/XS4bAaIrd
   GPn4KeSq/wqtzvIBDA+RzVp68MTtprcto6du4RhMmR6gbnJcj3AkTjXi0
   w==;
X-CSE-ConnectionGUID: c8BtiNQ7T3eBo84peV0pVg==
X-CSE-MsgGUID: X9wldqwcTbScmfgxX6+5CQ==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1613018"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:32:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:57093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.67:2525] with esmtp (Farcaster)
 id 766ae113-6b2f-4cb8-9843-db8ece196c13; Fri, 22 Aug 2025 13:32:06 +0000 (UTC)
X-Farcaster-Flow-ID: 766ae113-6b2f-4cb8-9843-db8ece196c13
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 22 Aug 2025 13:32:06 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 22 Aug 2025 13:32:00 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
Date: Fri, 22 Aug 2025 22:31:48 +0900
Message-ID: <20250822133148.199-1-yuichtsu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

#syz test

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 795c6388744c..3947ef762aaa 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -59,7 +59,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,

        sb->s_maxbytes = MAX_LFS_FILESIZE;
        sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
-       sb->s_blocksize = 1 << sb->s_blocksize_bits;
+       sb->s_blocksize = BIT(sb->s_blocksize_bits);
        sb->s_magic = V9FS_MAGIC;
        if (v9fs_proto_dotl(v9ses)) {
                sb->s_op = &v9fs_super_ops_dotl;

