Return-Path: <linux-kernel+bounces-789871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3048B39BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353761892D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A630DEA6;
	Thu, 28 Aug 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="GMFupP5I"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73A191F6A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381703; cv=none; b=lcKJ2KHi1aJw2y9lXPn82oXSCY+jr0DdFCf0TQnx3INE5kMfuSutLqnh3DuYpl9wO3hPlByWSG7yzxicDL1I0/vG4YKY3iLDrXG+5KhJnaoVaWcGEV9MO7NEmp9LSUWUjn/49MWletSSxbcKWjx6ERejzLi62JirkdjIjEJXLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381703; c=relaxed/simple;
	bh=afpSC4cmjWRzckLpMEpAKGiYuCxs0nC3dBOrmMrgb3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sedv1usqCpsZuvcvYrYAHl32tnWYS04pFyt15MZg4uyknKyRKyzyaSUIm0085Il2Hro9UOWO/MQkve+YASzpHxYG7ViXnpNzgBHfcGjBM6BMWMICYo2W4FxzNlIX44NnRuJh8x8XO7hC9uY9iSuBM/FLzTprqClClv02JcqC6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=GMFupP5I; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756381697;
	bh=JbkEXeQUYOPWbe4S1ypa1iSdTM3ldviuhRFwkWxcLcA=;
	h=From:Subject:Date:Message-ID;
	b=GMFupP5IYY0wtO9RagsEPIFpEHlXg447AuhVCDe1OH0LnfH6qvwnQPcDiR5oMM1Sn
	 HOIx//R4AbwrAvuasEncEAL8w90Y3AuKJgVi2+OgYUfPPcpasyZSocN7An7hp/zzcB
	 9WZs4KnTMQtULwRAYKeIG3QdWcrm4D0Mp3q7sROI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68B041F500005B2A; Thu, 28 Aug 2025 19:48:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1281104456989
X-SMAIL-UIID: 6B635EDDC3124B7D975639503F1E0C9D-20250828-194807-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+69c74d38464686431506@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in copy_process
Date: Thu, 28 Aug 2025 19:47:54 +0800
Message-ID: <20250828114755.5981-1-hdanton@sina.com>
In-Reply-To: <68af9193.a00a0220.2929dc.0006.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 27 Aug 2025 16:15:31 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1036def0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=69c74d38464686431506
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13595c62580000

#syz test

--- x/mm/oom_kill.c
+++ y/mm/oom_kill.c
@@ -997,6 +997,8 @@ static void __oom_kill_process(struct ta
 		queue_oom_reaper(victim);
 
 	mmdrop(mm);
+	write_lock_irq(&tasklist_lock);
+	write_unlock_irq(&tasklist_lock);
 	put_task_struct(victim);
 }
 
@@ -1031,6 +1033,8 @@ static void oom_kill_process(struct oom_
 		mark_oom_victim(victim);
 		queue_oom_reaper(victim);
 		task_unlock(victim);
+		write_lock_irq(&tasklist_lock);
+		write_unlock_irq(&tasklist_lock);
 		put_task_struct(victim);
 		return;
 	}
--- x/mm/page-writeback.c
+++ y/mm/page-writeback.c
@@ -3014,7 +3014,7 @@ bool __folio_end_writeback(struct folio
 
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
-		struct bdi_writeback *wb = inode_to_wb(inode);
+		struct bdi_writeback *wb;
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
@@ -3022,6 +3022,7 @@ bool __folio_end_writeback(struct folio
 		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 					PAGECACHE_TAG_WRITEBACK);
 
+		wb = inode_to_wb(inode);
 		wb_stat_mod(wb, WB_WRITEBACK, -nr);
 		__wb_writeout_add(wb, nr);
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
@@ -3054,7 +3055,7 @@ void __folio_start_writeback(struct foli
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
-		struct bdi_writeback *wb = inode_to_wb(inode);
+		struct bdi_writeback *wb;
 		unsigned long flags;
 		bool on_wblist;
 
@@ -3065,6 +3066,7 @@ void __folio_start_writeback(struct foli
 		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 
 		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
+		wb = inode_to_wb(inode);
 		wb_stat_mod(wb, WB_WRITEBACK, nr);
 		if (!on_wblist) {
 			wb_inode_writeback_start(wb);
--

