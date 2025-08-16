Return-Path: <linux-kernel+bounces-771703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45504B28A86
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CED556420F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415171C5F1B;
	Sat, 16 Aug 2025 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="nkWtlI8f"
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EE7483
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755318264; cv=none; b=aI4CspaVyAVH3XFi/k/MfXp2BB11cQeeT8xhWhKIxOHp9SCXYTZZ2TMuOPmqNkSOi2zVCkzzSUte3spJ7hTXscEhWXbfkwDanK/N83opbL77OYzgvbF8GeNzpk1pfgZ4SM641fNl4NyD0Fc+knb4kB+UUSF72CSEkPfse1RTrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755318264; c=relaxed/simple;
	bh=E1l+WGs9w7O1aRXsyZL64Rvr7xQkDuY0hlFTXzMl/rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWwlWYb/0URFDysaGLYPj/ultsGIcCWuxqIcmLk3QHSBTmiS4iSVupvtmXLdmlcYvoeBgLcbWfs13BEE/dPIJeWNpKkBwAfxkjy+FfHV0WYSyGZjQtxFehNMsh4/YCxfrnEfcrhA5ZqggkCdrxEuM0Zlvcv0ehC5mZmQihkDJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=nkWtlI8f; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755318258;
	bh=OFCHlS1CNSBte6A65Jbvwgvzy7oCkJJNKQ/aghptRCU=;
	h=From:Subject:Date:Message-ID;
	b=nkWtlI8f8HMsRdeJ8FUQ1TN5bRgf/kszHXe+SsZYArhfvoGPZT5JCjLYsTq1lMeM+
	 A3Zy0IgB7bJQTYLSJKpGXq1dur7MaIlNefu6qWLkSKDh1oGViftiSz73j8j/UR3MTT
	 oGesmT7uCdmrx8whx32XAaLbNCGtmMvpeRnlry+4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68A007E500005FB0; Sat, 16 Aug 2025 12:24:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5443246685137
X-SMAIL-UIID: ED7A58B478D4450794B98573947CCE2B-20250816-122407-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4e221abf50259362f4f4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mremap
Date: Sat, 16 Aug 2025 12:23:55 +0800
Message-ID: <20250816042357.4704-1-hdanton@sina.com>
In-Reply-To: <689ff5f6.050a0220.e29e5.0030.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 15 Aug 2025 20:07:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a66af0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4e221abf50259362f4f4
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fb3c34580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173c2dbc580000

#syz test

--- x/mm/mremap.c
+++ y/mm/mremap.c
@@ -1823,7 +1823,7 @@ static unsigned long remap_move(struct v
 	unsigned long target_addr = new_addr;
 	unsigned long res = -EFAULT;
 	unsigned long last_end;
-	bool seen_vma = false;
+	bool seen_vma = false, allowed;
 
 	VMA_ITERATOR(vmi, current->mm, start);
 
@@ -1865,7 +1865,8 @@ static unsigned long remap_move(struct v
 		vrm->new_addr = target_addr + offset;
 		vrm->old_len = vrm->new_len = len;
 
-		if (!vma_multi_allowed(vma)) {
+		allowed = vma_multi_allowed(vma);
+		if (!allowed) {
 			/* This is not the first VMA, abort immediately. */
 			if (seen_vma)
 				return -EFAULT;
@@ -1881,7 +1882,7 @@ static unsigned long remap_move(struct v
 			return res_vma;
 
 		if (!seen_vma) {
-			VM_WARN_ON_ONCE(vma_multi_allowed(vma) &&
+			VM_WARN_ON_ONCE(allowed &&
 					res_vma != new_addr);
 			res = res_vma;
 		}
--

