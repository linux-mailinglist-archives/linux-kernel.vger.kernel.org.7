Return-Path: <linux-kernel+bounces-837086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C9BAB48A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5909A3AA892
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D824677D;
	Tue, 30 Sep 2025 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="T0sjrHXo"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B71DB125
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759205363; cv=none; b=UGHnkOaekpO8ChLh2QIgHsQ1zfqVQHcsBKdv/W99nJT5GlNLfyH6r8nhxAOYW+bajxnhgbKILWQHu+mxZtTq7M+g3S++QMov8ZUHNuRo+U1sVpqtkWrpSeL8IlA10opFSvC+WbswZGKy2jHfk7135qVg/wtnjeiH62wZ+NZqXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759205363; c=relaxed/simple;
	bh=e91nYpP4wOcbApUS43qCyRsQIfjk2ChjpZB6vDTOQd0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rmH9jPQiSPOfvY0esLsvdy8PxstnLS9wHtiptpuoF2dORINdthYAeVUeO0nFPgmLbYlA6cJnV82+wwoloWY79HjkDWH/1pHhDc1Cbq6oUHCoJNA97HPOpiwjdRXk28RAxzFDJ8FwsfH1FFoUEiLnPmU/T+c039lHYOCTDeti1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=T0sjrHXo; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759205052; bh=zALH48yt5jjQHyegDw16Z2xAPKQsnZYvtHfbWPKUNRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0sjrHXoLfwRXkFeqf1wHKADNUv9qf1gfexpqABOeDbWzC5Dzdovq6P3zW7XCuoov
	 qWN1dT7IvI/6mFTWnBK4gXKnF8DOklRpkGR6eJtbGBKoqYnQ6LIPMjz7epmwNkmKIh
	 R8XqormflcK+KQSeIZcxdcGb3TUBBFZVPmg3u0uI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 10A948F5; Tue, 30 Sep 2025 12:04:10 +0800
X-QQ-mid: xmsmtpt1759205050tjyjmyhnn
Message-ID: <tencent_9DCD93762363A97943B5A44E7760377DE605@qq.com>
X-QQ-XMAILINFO: ND7qRx54ek/phkc/aXANJxK6pn6iOivOA7dNV/KQVGVcPxhOZ3UIO6iVKisfqD
	 dLAkebrYORFQftKsJ0BaQND9uRnLWw8x1ihn6A6DE6h/S1jSVP13Tl+tXJSaHM4oAEClVUTS9JNf
	 FsYVpzYlBM+kCoemVkT9ohMi9pJxRdU8OGr37GlZebhprVPAsN2PglWB3s7fnpy06W94G0wHdeBE
	 Oou4Kv29cPC12q5WASQWDDB3M2fS+qeCor872Xw6iXb9IMaHulqoDAyeY8hSckAMNBbGAnPt7T+9
	 MzwF3ZQHT6iMuhOtS08ryapHNkzPcyXJNKvwL4yejvmgoHPzv58+H2nHLIfGP86T7ASffGaz6gr/
	 u8USbc/8M1vVeIz69DTfNOdzFtQWNM0f1RkZ0/S4bScULZ1I6M55MSLrZUGZhcjgss5k8Y3ISbiy
	 GV2FTW5xZDqXbFB9x5X032mKwLp3wrBAGvRRUlEKSjVuXrYV4Yfy9vGqGYDp1q9DUWU/tRP3NJiq
	 mh3oqgKa9+y7Mhf7Et1X/8xmejT4REQc1jToRZJB6h+SgWpqdfr3YJsraqqeZydQuyt1PqL0aJZb
	 xtilojWoKWxWBoVD9Eig2Qb3hLOdAo6MKdicunFILZnQp3+E8IWyfa6s/U7pohJzuo0wK0K5OJyz
	 kG9y4tomaFmXtEPADIXzaW5qif32kI6iRGtnGNTgAu2dKSwp7wjAZMnqVH/+Da+gSUeVbUSe0iNk
	 H253ozBk3e29vwoTc1D/c8UE9frdKqP20elqofv9/y5fIOwiu94lYCDV7KTZDxtAFHyoCBcJLl7Z
	 fDvrpnHRSdqfA6xH87iShfFGSYMQR4OcM2abJ0FbglGvzcWoj4pXf15GJLSAznSZoZRQT6l2TLrF
	 hZYJkPl9ClMz17ZPDyuqvMiNGjB+VHPepdJgyETfZHMdr3PcT9emqusdZR5BQUTIKJVedk+P3eHy
	 pgtmU2EvuY2tADsqveRrkDBxrCS3ZGdikm6k4sBcyytIMXXrhQKCwZgcH3VJMztw8x0+iwd4TCTK
	 CWkVEl+Q==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ba71155d3eacc8f42477@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_btree_node_read_done
Date: Tue, 30 Sep 2025 12:04:11 +0800
X-OQ-MSGID: <20250930040410.392916-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68dad4bb.a70a0220.10c4b.0086.GAE@google.com>
References: <68dad4bb.a70a0220.10c4b.0086.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream 083fc6d7fa0d 

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 590cd29f3e86..ab14fff1452f 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -1087,6 +1087,13 @@ int bch2_btree_node_read_done(struct bch_fs *c, struct bch_dev *ca,
 		     "bad magic: want %llx, got %llx",
 		     bset_magic(c), le64_to_cpu(b->data->magic));
 
+	btree_err_on(ptr_written >= btree_sectors(c),
+		     -BCH_ERR_btree_node_read_err_must_retry,
+		     c, ca, b, NULL, NULL,
+		     btree_node_bad_magic,
+		     "wrong written %u, btree sectors is %lu",
+		     ptr_written, btree_sectors(c));
+
 	if (b->key.k.type == KEY_TYPE_btree_ptr_v2) {
 		struct bch_btree_ptr_v2 *bp =
 			&bkey_i_to_btree_ptr_v2(&b->key)->v;


