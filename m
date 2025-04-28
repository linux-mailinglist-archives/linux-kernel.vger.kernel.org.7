Return-Path: <linux-kernel+bounces-623402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33012A9F534
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7671743BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08AD27A90B;
	Mon, 28 Apr 2025 16:09:21 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F12309A3;
	Mon, 28 Apr 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856561; cv=none; b=T4IRw3PWbJvgldygwbmxlTcI8mU5xfiLK7CLLfYKFjh0fplp5vtly7zX1CaRwKioqxVG8xi2sxCn4MWjDyEPwn43Tv8lnRJpqRFfg2vkyqpinfIsKcmMYu7Ix+69UKkNDfwMtzgAdAQcezWhxw4VSQjV2kHFvl3j2O/kj07l9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856561; c=relaxed/simple;
	bh=/FaUHSkvAnv9zJ4hY+M2/75k8G4lwLns6Abzz4g+xqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCAsArwf+Ehuf5zHAl3iEsxWkGWEYKYkY0OTV2Q7RWbEoKJ8GMLrL7ASpu9i/CheVg5KEtoCHPcfMjKd1jNiqadLBrn8wjsbKxjLi7qz2lI7duWDqC5zfOv2p717xjIOV4emHRFH8xMOU37zO3302hVpNryZ5OIVl5thGwAv8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a01:e0a:3e8:c0d0:efe7:a722:f2bd:741a])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 9C22140B1B;
	Mon, 28 Apr 2025 16:09:09 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:efe7:a722:f2bd:741a) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+843981bb836d699c07d1@syzkaller.appspotmail.com
Cc: kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Mon, 28 Apr 2025 18:09:03 +0200
Message-ID: <20250428160903.20110-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67f76c11.050a0220.258fea.0029.GAE@google.com>
References: <67f76c11.050a0220.258fea.0029.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <174585655000.4181.7587545060140309776@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -976,7 +976,24 @@ int bch2_fsck_update_backpointers(struct btree_trans *trans,
 	int ret = 0;
 
 	if (d->v.d_type == DT_SUBVOL) {
-		BUG();
+		struct bch_subvolume subvol;
+
+		ret = bch2_subvolume_get(trans, le32_to_cpu(d->v.d_child_subvol),
+					     false, &subvol);
+		if (ret && !bch2_err_matches(ret, ENOENT))
+			goto err;
+
+		ret = get_visible_inodes(trans, &target, s, le64_to_cpu(subvol.inode));
+		if (ret)
+			goto err;
+
+		if (target.inodes.nr) {
+			target.inodes.data[0].inode.bi_dir_offset = d->k.p.offset;
+			ret = __bch2_fsck_write_inode(trans, &target.inodes.data[0].inode);
+			if (ret)
+				goto err;
+		}
+
 	} else {
 		ret = get_visible_inodes(trans, &target, s, le64_to_cpu(d->v.d_inum));
 		if (ret)
-- 
2.43.0

