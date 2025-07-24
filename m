Return-Path: <linux-kernel+bounces-743481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3194B0FF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE86C4E1269
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D5185B67;
	Thu, 24 Jul 2025 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="bg7sUtXc"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA01A2387
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328112; cv=none; b=Hhj67iho1IZWaCfKL2phwsXrtxtTM5Q8h4JJVe2DwjPVWOaqqQSpJQ4L//Iy9v85d/y1q8Z3r9vGIXAcU1TYfIpTvG/JGKgY2qJU/B39cnqugYWUhZUqNBuYPNYwaJz0No//Czfg8gWu0bng5yonCLlsjWqDZfa/uiNvKGqTcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328112; c=relaxed/simple;
	bh=xtNKawSC/cKf01BoyFxHxSA5wtqogrkZp/T5huyAOB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5ajlSv9VjhHR2pyqiMBpiA4YPtrIJ4f93jZkD2qnEDVvAmIWSKwWfAhFzjz+AfcS7GuU5dVtRX2MK7fC/tcKWFma1XHhi1EhcG8TGBDk40frW009o3IfgdYDIk3eE1CIGkSGGW9oHbM+u9muP9R+/0dqvK2vcuHdxQ6nQlrt28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=bg7sUtXc; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753328107;
	bh=gawcy53PQ/EWCAcSWIrZB5rsnhaqH+ZdcNvU666ZkxY=;
	h=From:Subject:Date:Message-ID;
	b=bg7sUtXc8LcHdIrzgd6X6BqwB4g0C9x0ePBsi53cBlOZnfxuLTVk8FV+F4N9wEvrA
	 orkFVScNr+kfnuM1V+UVroGjTGOXeWLoP5lXhg3CIGT9LiDCywk6ytYmZycXs+TtU0
	 uDu8vDY/9qY/3m0uUbl46p5+DU8zF2fvWLJjJHuQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6881A9E4000037D6; Thu, 24 Jul 2025 11:35:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 801924456689
X-SMAIL-UIID: 8F350F7EE4DF491B8623B89C00A87559-20250724-113503-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in simple_recursive_removal (5)
Date: Thu, 24 Jul 2025 11:34:48 +0800
Message-ID: <20250724033449.2927-1-hdanton@sina.com>
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

--- x/net/mac80211/debugfs_sta.c
+++ y/net/mac80211/debugfs_sta.c
@@ -1276,6 +1276,12 @@ void ieee80211_sta_debugfs_add(struct st
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
+	struct dentry *stations_dir = sta->sdata->debugfs.subdir_stations;
+
+	if (!stations_dir)
+		return;
+	if (!sta->debugfs_dir)
+		return;
 	debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }
--

