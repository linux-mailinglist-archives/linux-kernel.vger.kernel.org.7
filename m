Return-Path: <linux-kernel+bounces-828508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33DB94BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93E31902B57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD431077A;
	Tue, 23 Sep 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="d+sI+hsb"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9E274FDE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612127; cv=none; b=YRAsTH+DNMLMVBRHpr7SoiHJzHf//3ZgZGntQsokZgzWM87qWetzGP47h+vlqCaTn1YdPaXaxHnmWHbKfAvDnRMuLKbpvDNWr29B9gBtG+CbR3uDZB58nMDdZ/z08i9d2h7th//EOv90sDAOU89YoOFGKPECb/Lhj3+RJE3IYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612127; c=relaxed/simple;
	bh=/F9txF44LQ9F0ShqkV89WJE6ZxqbGMBARkYVzbY0Wws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvA+spxActmUVOqi627qSlmkdbh+QpK555IrzCmlzAkUjTgArWeDI6XLNkgIr93EsjFHVa2/8qqIGVXvJAwInsnPiyiq2JlbrQvs+wJkfCW2FfRJGarAWANI4E4AogOoSRwrNnqD+a7G95MYK8Hsv8UrlGq5/bvW5AwwfPCDlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=d+sI+hsb; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758612120;
	bh=/XKimRw+DrkLBdfXw8ceaHS+QiQX8AF6397Lzy88B8E=;
	h=From:Subject:Date:Message-ID;
	b=d+sI+hsbCDSJavdX4v7Poi/iw350Iz6MXLnrRJYOpSYXJP0yRqR+HilwMDDjdtMij
	 xrEzCOO13lQ/k52u56tU16CR2lta/8fViVli72/hhskyy1OSsW20Vp9giO2Komeyhh
	 j014crTKKBKp2Bf5sP9FBTEHVYJL4Tvk3XxbL/80=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68D24A8C00007703; Tue, 23 Sep 2025 15:21:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8998014456699
X-SMAIL-UIID: 9CF76B1E7FA74EC5A382CC73D76570F0-20250923-152149-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
Date: Tue, 23 Sep 2025 15:21:38 +0800
Message-ID: <20250923072139.7466-1-hdanton@sina.com>
In-Reply-To: <68d1b079.a70a0220.1b52b.0000.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 22 Sep 2025 13:24:25 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c238e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
> dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e427c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb8142580000

#syz test linux-next  master

--- x/block/blk-mq-tag.c
+++ y/block/blk-mq-tag.c
@@ -565,6 +565,7 @@ struct blk_mq_tags *blk_mq_init_tags(uns
 	if (!tags)
 		return NULL;
 
+	INIT_LIST_HEAD(&tags->page_list);
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
--- x/arch/x86/kvm/emulate.c
+++ y/arch/x86/kvm/emulate.c
@@ -4001,7 +4001,6 @@ static int check_perm_out(struct x86_emu
 #define D2bv(_f)      D((_f) | ByteOp), D(_f)
 #define D2bvIP(_f, _i, _p) DIP((_f) | ByteOp, _i, _p), DIP(_f, _i, _p)
 #define I2bv(_f, _e)  I((_f) | ByteOp, _e), I(_f, _e)
-#define F2bv(_f, _e)  F((_f) | ByteOp, _e), F(_f, _e)
 #define I2bvIP(_f, _e, _i, _p) \
 	IIP((_f) | ByteOp, _e, _i, _p), IIP(_f, _e, _i, _p)
 
@@ -4088,8 +4087,8 @@ static const struct opcode group4[] = {
 };
 
 static const struct opcode group5[] = {
-	F(DstMem | SrcNone | Lock,		em_inc),
-	F(DstMem | SrcNone | Lock,		em_dec),
+	I(DstMem | SrcNone | Lock,		em_inc),
+	I(DstMem | SrcNone | Lock,		em_dec),
 	I(SrcMem | NearBranch | IsBranch | ShadowStack, em_call_near_abs),
 	I(SrcMemFAddr | ImplicitOps | IsBranch | ShadowStack, em_call_far),
 	I(SrcMem | NearBranch | IsBranch,       em_jmp_abs),
--

