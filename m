Return-Path: <linux-kernel+bounces-744069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C21B107A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BBF7A6255
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2D9262FF8;
	Thu, 24 Jul 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="SjhXZlLD"
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B0262FE2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352646; cv=none; b=tOXSHo5iqnvhdp8H+Xyd+9hFJcrBDcTRBFU2su2fkaYyEp7nw6WjNyg0MSI14cwqOMxY+JykOekfad+jFbhdvv8pxOgPk1AQAzlQtOk6r0SKPt+geZdTCVp9zTfboP9MJOYm/0/Iq0b2EtUI+KS8uLoVXwnlfG6JOZWnj8gMxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352646; c=relaxed/simple;
	bh=tG1OGtZVlNjh37Vvnlw6u12UxoGE7dfOLWAAvWi7ovY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUGSJ2K3hEhUjH5a0OPTh7xNitt2MyIeVXwVuym0sTbhtyiuKfqDmLRpEVvh9Pet/kjCK+tMWLhzEeGOczk7AHDbkZdrGa2E6vU7xGk80g/H6EGA7fMJO77DgjN2lmMA3mnZOtW2A2ql24IH07Z4ikt3AWBz7F8+RoAZf3WuWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=SjhXZlLD; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753352636;
	bh=P0tpx9o88yjWpi1MSG/TQa/3HNijRhoye0BMy9WRrpI=;
	h=From:Subject:Date:Message-ID;
	b=SjhXZlLDduINPY+UB10R+YNvJlxUgTmrYiRxREuvFWuGWCkL16NWF936wkrIP4z1L
	 hFJnbN2nYKOBqp4yLTbqB/YTsKjeET8e3ZbEnyIwqox+N2UuwBLzsAbi0XwHmNJXa2
	 M2JiUr1FkYvixAUKQtaKsSRRyEa9J0RbzXbfq8lM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6882098E00007BAE; Thu, 24 Jul 2025 18:23:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1707006816422
X-SMAIL-UIID: 31EC0702ECB946FFA8F864368ECCA907-20250724-182312-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in simple_recursive_removal (5)
Date: Thu, 24 Jul 2025 18:22:59 +0800
Message-ID: <20250724102300.2988-1-hdanton@sina.com>
In-Reply-To: <688119a0.050a0220.248954.0007.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 23 Jul 2025 10:19:28 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b42fd4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6ccd49ae046542a0641
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134baf22580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d5a4f0580000

#syz test

--- x/net/mac80211/sta_info.h
+++ y/net/mac80211/sta_info.h
@@ -705,7 +705,7 @@ struct sta_info {
 	struct sta_ampdu_mlme ampdu_mlme;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct dentry *debugfs_dir, *pd;
 #endif
 
 	u8 reserved_tid;
--- x/net/mac80211/debugfs_sta.c
+++ y/net/mac80211/debugfs_sta.c
@@ -1252,6 +1252,7 @@ void ieee80211_sta_debugfs_add(struct st
 	 * dir might still be around.
 	 */
 	sta->debugfs_dir = debugfs_create_dir(mac, stations_dir);
+	sta->pd = stations_dir;
 
 	DEBUGFS_ADD(flags);
 	DEBUGFS_ADD(aid);
@@ -1276,7 +1277,14 @@ void ieee80211_sta_debugfs_add(struct st
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
-	debugfs_remove_recursive(sta->debugfs_dir);
+	struct dentry *stations_dir = sta->sdata->debugfs.subdir_stations;
+
+	if (!sta->debugfs_dir)
+		return;
+	if (!stations_dir)
+		return;
+	if (sta->pd == stations_dir)
+		debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }
 
--

