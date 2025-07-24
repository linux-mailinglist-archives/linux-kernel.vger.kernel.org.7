Return-Path: <linux-kernel+bounces-743441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931DB0FEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522767B3011
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031163F9D2;
	Thu, 24 Jul 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="fY1F3rkO"
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1EAD5A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323801; cv=none; b=Zx617yun0qc7O3xzcApomEK72r40uJSq9sxJCOv47WEIKVshPuo2M7LbuvP6SJh+y5OSzv3kPI4RiNToKiqyeRp+WXNG7IVQzbjdUan9zG4Dz4+BvbfA4cXuwLI7z6v3gCGM7UOxWlFWDPccOLcPUD1uQIvGq3r/vveCe1pjB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323801; c=relaxed/simple;
	bh=+zcw95EukSkI0vH/DiKwSDmuZIlNfD7FQ0s+ng7yGPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwD0u7UGaYEw1bOaxnwO/q/KHvFlVF0Ausb2DZl3RB4RO4fi/8XwEXR6ZMoABDz/qG6C9oOK5UxMUrBovUVnbhpLu8rb+JI72eY0kDQ8klXoN8aAPIP4vim9HT2OI1OioBZaepQ6P9kwB7CAb7784R296gGzMAtMHiUS+QU9DHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=fY1F3rkO; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753323793;
	bh=Vz8F6mDWjYO7B8GMIcMDhA/waawdsJHSt5Ga9ajwcQk=;
	h=From:Subject:Date:Message-ID;
	b=fY1F3rkOnEWqPcubjBiiznA6AGt6AtVOtxgq7jxm6+w9PHoKdVpoLBGDZS04sgb2o
	 Fg0IIw8BqG/SsuoEe3OkmJdg/xvavd0oamrpB0LjDfy5T1c9rupARkqKtl1i+3vWx2
	 qrPxTXVjFkrMohxzVjtkX7kw+PxqZwoHDf7MwQG0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68819905000010A6; Thu, 24 Jul 2025 10:23:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5244286292019
X-SMAIL-UIID: 5A116DC9914844A29E77D650D70A88AF-20250724-102304-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in simple_recursive_removal (5)
Date: Thu, 24 Jul 2025 10:22:44 +0800
Message-ID: <20250724022251.2875-1-hdanton@sina.com>
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
@@ -1276,6 +1276,8 @@ void ieee80211_sta_debugfs_add(struct st
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
+	if (!sta->debugfs_dir)
+		return;
 	debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }
--

