Return-Path: <linux-kernel+bounces-765740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66976B23DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462F21B61FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E608818786A;
	Wed, 13 Aug 2025 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="hvsv0x0G"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA2273FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048431; cv=none; b=V/0bu6m8n88pH/jhMihDN7Kz+xVpJAdyXR8nFRjXKcC2PvXDiG2GGdwQRrhddUvkPlAgxdBLC0UJHqjdbRwebFVwCFAzhQ/K8ttorxdJB5UGAOVmv8Qdnmjus0ioCVU5e7ezqloSqF4WphA3dj8AQ4Xj5qgtcUza9zOCSEUD/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048431; c=relaxed/simple;
	bh=8qMVFp3s2HecNj91FjwX6jmJWVPU1vDcSxdrHObR3Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTlOOI+Lf895B4tI/QTKVAK0DSjEmOVprxDVUhZVr8uqAEd6n+M3NbNCwgEB4fuyaQUdDlc/lcIMCDfDVqPl2UPdBaSd/oPSUZW6GjjWC2j5ovTZrRlsQfNC5SxEJna8/CTjSpIoY5ocXiBq/fxI8pESqnuRy0XgKLHAHgnZEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=hvsv0x0G; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755048426;
	bh=9QcoHBd3sTyQ0GOfKTg0on10X99SJiR9GOfT9RINdP0=;
	h=From:Subject:Date:Message-ID;
	b=hvsv0x0GLSrls/tEqfp8w9OoVm/v+yY0Z5n4r4bU+O0NiS9LpSypAYVb2g+tjxEFc
	 sDAtwmRdH9X88EhzV9ySVMm5N/pY0M8f+W0i4Ki4s7x/ii94L8QkfrJOKhiqbfQMBr
	 2q/Rfl1Cg3nv7gXEPBw94sUkQincCVK/rKERmUD0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689BE9C1000054F6; Wed, 13 Aug 2025 09:26:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 373804456936
X-SMAIL-UIID: 3D91035282AA47EFB2A2A8A8563F7744-20250813-092627-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
Date: Wed, 13 Aug 2025 09:26:15 +0800
Message-ID: <20250813012616.4382-1-hdanton@sina.com>
In-Reply-To: <689bb893.050a0220.7f033.013a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 12 Aug 2025 14:56:35 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=165fe9a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14172842580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b04c34580000

#syz test

--- x/mm/mremap.c
+++ y/mm/mremap.c
@@ -837,7 +837,6 @@ unsigned long move_page_tables(struct pa
 		new_pmd = alloc_new_pmd(mm, pmc->new_addr);
 		if (!new_pmd)
 			break;
-again:
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
@@ -856,8 +855,9 @@ again:
 			continue;
 		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
+		/* bail out to avoid clearing new_pmd */
 		if (move_ptes(pmc, extent, old_pmd, new_pmd) < 0)
-			goto again;
+			break;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
--

