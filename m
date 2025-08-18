Return-Path: <linux-kernel+bounces-773358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86FB29EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E851770DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC7310645;
	Mon, 18 Aug 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="dVBeylwH"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62099310642
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511707; cv=none; b=BTvKRYXHGF7QGTOjmQp3mITe2a2rmGRYi/81pRz2A9QMpso6p7F3q1cBo0g4VB1+xv2P0Plea14f6bAWoX0+J7IGV6/5EulczchwJYXtL4uYLr2XwL8V194bGC2oM8umbu/PFteqFUDonnURSQqOtCkbj7SfZ86iyZcCV7IusNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511707; c=relaxed/simple;
	bh=zjXG6WuxySoofRY719uXjFTJxOn5sdIbu67fLho2WCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZR+RHxIJoGtp4qE1280YD9JMTujnCmdNa7WhOHXLNiJBGVRcdISS0PVk2pZg2/GlJTit7KVPMGd04KyRdH+Odz2uLHJyMtuOF0Yy26SOD3rh8Yr/EGyIL17TIMYF6KYC4C4zesWIDetx1JIvgJqetRm+kVJx7mEmpliM92WEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=dVBeylwH; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755511701;
	bh=YYzIAf0R13QLBWU8U4BOSu0ixlCeodegePD6X3A0J2g=;
	h=From:Subject:Date:Message-ID;
	b=dVBeylwHYcjTKhG7WZKCqtbL5ywryYZ+V9JZ51+SSDjDNZ0gMqcy8muhrywA+YR5r
	 w9IzJJrs/T6IEbdnqI2l8FBRq6PdzuTp2pz6XV+v9yK8nHnGS1y77/lVO3rxR1vO/2
	 9FOMf2UV09xJ7MV5sON28fJM6sy7uLZFEg+Spl2s=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68A2FB87000052D9; Mon, 18 Aug 2025 18:08:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4946286685229
X-SMAIL-UIID: 20D7D3B21E8245C9B76D6B1134AD62F3-20250818-180809-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in vfree (2)
Date: Mon, 18 Aug 2025 18:07:57 +0800
Message-ID: <20250818100758.5020-1-hdanton@sina.com>
In-Reply-To: <68a2decd.050a0220.e29e5.009a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 18 Aug 2025 01:05:33 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=15232442580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> dashboard link: https://syzkaller.appspot.com/bug?extid=f65a2014305525a9f816
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cbaba2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1157faf0580000

#syz test upstream master

--- x/include/linux/mm_types.h
+++ y/include/linux/mm_types.h
@@ -1166,6 +1166,7 @@ struct mm_struct {
 #ifdef CONFIG_PREEMPT_RT
 		struct rcu_head delayed_drop;
 #endif
+		struct work_struct drop_work;
 #ifdef CONFIG_HUGETLB_PAGE
 		atomic_long_t hugetlb_usage;
 #endif
--- x/kernel/fork.c
+++ y/kernel/fork.c
@@ -666,6 +666,14 @@ static void cleanup_lazy_tlbs(struct mm_
 		on_each_cpu(do_check_lazy_tlb, (void *)mm, 1);
 }
 
+static void mmdrop_workfn(struct work_struct *work)
+{
+	struct mm_struct *mm;
+
+	mm = container_of(work, struct mm_struct, drop_work);
+	futex_hash_free(mm);
+	free_mm(mm);
+}
 /*
  * Called when the last reference to the mm
  * is dropped: either by a lazy thread or by
@@ -689,9 +697,8 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
-	futex_hash_free(mm);
-
-	free_mm(mm);
+	INIT_WORK(&mm->drop_work, mmdrop_workfn);
+	schedule_work(&mm->drop_work);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
 
--

