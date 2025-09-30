Return-Path: <linux-kernel+bounces-837049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A64BAB2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADF03C53A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3FA14D283;
	Tue, 30 Sep 2025 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zbu4SIS9"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56E2AE97
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759204144; cv=none; b=SBp3EiAYzMWVJCtvYphbgxx71oZ+8ihm3GKL4fPu49kFkvdaMcGFHASgqWazQ2Xhc3g7G7af39DwaK4lw62a+BCxSeCPZMHvpktkOrvgbWu37DvXkrpsX+p839O1zhRWmvn6Hkufe2hWTRIgS7lD0x6fle37sgzL4gJsJL2kMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759204144; c=relaxed/simple;
	bh=TUUYcN25eW4fu1eV3atj3whoJXKADyD5rgakXdEm1Zc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fYSo+wymkVnJBq09VhOahEsw61lxx7yLA9txaDJp4IWfR5cYcNVEADh7bD0qDP7sdYq4V7zfIQ5PVOzHZy6xcNV/DP1bpasTpo+R4HNvHqxc0P9VY8xhbmh79xjxXM3ATsRXpiPIUk24r87lkg7koAwAWxoIzqnuOytVAb1O270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zbu4SIS9; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759204130; bh=/H2dqFpdqlbU+ifdJyyNe8pZqxWEvCrQnUoxD31YHAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zbu4SIS9iZpZYBwTcsel94b6JdxG8T4U5i8D8kuiiJUJeydRGmmzw91JIGSvt3XF1
	 1owl4FhhQf7gJ8ClpopVsZEDq/MJLkSb+M26sIWDWH2I0d+X+hT5t4olhlLPM1+5z0
	 S7eN/WrIbKaf8qold6oJ+dh58721WN22Nt+KOgso=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id AA625891; Tue, 30 Sep 2025 11:42:38 +0800
X-QQ-mid: xmsmtpt1759203758tfmju9ghf
Message-ID: <tencent_E5865E49816ED4AEC2CC9AA7DF86CC12E706@qq.com>
X-QQ-XMAILINFO: NRYSeI3Ux+UPXG0Qepx2Tp5cve3LFbQjIRidmPs5NbRXo0bG3G9/6gN6+nuP1b
	 KLGdakxbJESCHmT9DbLmZkMeV1Jui3VvnJOiNAFnZL/mq66nlEWGMTX9SwIxRwCrqRnvWHddg4Le
	 +ueigN1iOYQblQLlqWXQHhBv3EQIdj7z5LPym3qxrrf1oap79yRHcqDGnpOtswe3dqDDXlXQwOhQ
	 pAx8UvLrYvSBidJWUlnpYZZ8qCfzOUxXWKubWjObm1DvaJG6BMpcICisBL5Q94Vmj7b2iCo8voWv
	 0crbyfCXo+EPyAhHWELNJpZpzK14QID7M8BggQHlEJA+bVww+pdpbxwr8MF7JUu2NGTGziV9pZ2z
	 CoaHe9vTg++4z22WPh9RKs7miB9mR6DgH8Xsknfj2QFz+DlyhhH8krGbrqD3DmmWQ0w3+Y0AvnTM
	 NKxiKm5xO7rzIkLK1KmbxbCT1wwOjQBqlqQ1neIGPpCJ1LRtm1lU5L+dH53OeWTD8WC7SUBGv7va
	 d/6WuHOJ4xAmg1BNxQrUfM9PRuW6fJh+Ym20jUxgvMMZjIhLes8anbp1VIOXAfIStHlzXBQTbOdL
	 UjEgNvUl02fhFI0Q0uWlsDT3fsJHZ7dEk8Me+stWlu9DkznYMolKCOS+HQ8vgvzjJcwqBw3+nL8K
	 AGu4s16M4rai/+ZhzX7FxR0FiLjGXVPRLkb/ExBAhe7IRnKyObMU5MDlIE/AkZJiSUwJY/CqoMtA
	 +gm+9ZPWoG3ac0i8OS8RWDZcPTCKVIp5QcSg6RsHCLL/Ns6uIKFADmUZfVBS5761DCTQeeadR2QA
	 dGN+EclLOSJh4cFSS4uN1l1pvI9DSefNp6QLG7mf69Z1DZ3Bhceqxzs4YE5pmAPsoSg04J0oCe8o
	 4BiAbBsuuGsTNvh4wXTAk4bqG1qEoEvrREjQrV4exhjsycwtAsbmD0sGQar0hClbWPgz5MvjFdIO
	 kl5NLTU8Q=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ba71155d3eacc8f42477@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_btree_node_read_done
Date: Tue, 30 Sep 2025 11:42:39 +0800
X-OQ-MSGID: <20250930034238.374791-2-eadavis@qq.com>
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

#syz test

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


