Return-Path: <linux-kernel+bounces-761341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC32B1F891
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120153BB254
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DBB1C861D;
	Sun, 10 Aug 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="SujXDIlU"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263018FC92
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805967; cv=none; b=HHJErs8CitZ/cEnpuAF7qPIDtyO23kWuhIRkrH21T9uhzZlVXblGVsmgH8JsTmu7LMWaR8LWyr57bMF0PYdntDBdLhLAj9IJD8iGN5KeKBs0J3REDAPSN1sI3tvRREXnzZN8+jHHDcV+3zYZ0tCVwSlVPi4mHZGE6RohcqAcxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805967; c=relaxed/simple;
	bh=4XHmcM7fML6dqcwyzuILOOxazeY1/gJDKj81dKMfDgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTqP8dRUVgYUmiQfj91XPbVH0SqXDoyJCXfFQe+gcusQyOdINu3oBaJhA9h6OiBtQPsX1eBAY7IVa3nJKmtm7IXcryHdWriNmOOBj3OC3B4dJoA0ITDN4TOg8ieKA8tiS+M6m8Yd1vqzIxaI6+LB6uo0p7PYbl2lwd4JVPm8I4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=SujXDIlU; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754805961;
	bh=ZewGuYVPNLZbb9yG6TY0OO7gkHqJyc63CzEmP0Q4+eI=;
	h=From:Subject:Date:Message-ID;
	b=SujXDIlU3mnWfslZummv9sZRzGJ3L7iJU+5Ynzqrlo7k4hJ7tMQZcR8o4CdvtMcmM
	 mQo8aE5Wen8ASNCuPz2aaNfilIMXdFDvvgnNsr+EZP8ZQiSlgRF1EEyH9tllN5STxj
	 IB1C4qnS73GsDPt0AdabNDNq+Ia4DeeGIGYFZSkc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 689836C3000024A8; Sun, 10 Aug 2025 14:05:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8166556292133
X-SMAIL-UIID: 0A77EEC8A2414FDBBF001D4467F170D2-20250810-140556-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
Date: Sun, 10 Aug 2025 14:04:43 +0800
Message-ID: <20250810060545.4177-1-hdanton@sina.com>
In-Reply-To: <6897b156.050a0220.51d73.0082.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 09 Aug 2025 13:36:38 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0227b49b5027 Merge tag 'gpio-updates-for-v6.17-rc1-part2' ..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1422d434580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
> dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117c72f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab7ea2580000

#syz test

--- x/mm/rmap.c
+++ y/mm/rmap.c
@@ -2283,6 +2283,7 @@ static bool try_to_migrate_one(struct fo
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	bool anon_exclusive, writable, ret = true;
+	int check_excl = 1;
 	pte_t pteval;
 	struct page *subpage;
 	struct mmu_notifier_range range;
@@ -2422,6 +2423,7 @@ static bool try_to_migrate_one(struct fo
 			if (pte_dirty(pteval))
 				folio_mark_dirty(folio);
 			writable = pte_write(pteval);
+			check_excl = 0;
 		} else if (likely(pte_present(pteval))) {
 			flush_cache_page(vma, address, pfn);
 			/* Nuke the page table entry. */
@@ -2446,10 +2448,17 @@ static bool try_to_migrate_one(struct fo
 		} else {
 			pte_clear(mm, address, pvmw.pte);
 			writable = is_writable_device_private_entry(pte_to_swp_entry(pteval));
+			check_excl = 0;
 		}
 
-		VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
-				!anon_exclusive, folio);
+		if (check_excl) {
+			pfn = pte_pfn(pteval);
+			subpage = folio_page(folio, pfn - folio_pfn(folio));
+			anon_exclusive = folio_test_anon(folio) &&
+					PageAnonExclusive(subpage);
+			VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
+					!anon_exclusive, folio);
+		}
 
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
--

