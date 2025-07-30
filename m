Return-Path: <linux-kernel+bounces-750393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F8B15AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57EB166DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3D1F4E59;
	Wed, 30 Jul 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="d+krU0jG"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E52036EC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864668; cv=none; b=GsI4Ffz+QihQr4yK8C12vwL4lBeelss2sasuflES+IO1OENtiH2dFfcjnXALZftLhmaX456tQzG2XeqwqSFmzqlagM9sVfkRiQihYo7SdJkUB+YzRW6xhjezYYIy8H4Gb5Ialg/lTHYk0EDw4yb96yXMecDJyrBwq3VLCQVGIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864668; c=relaxed/simple;
	bh=B82ab2JHYLPIN3AJMj5XwkBGgCy3pNUczkiTx1pcPfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra08Ko41jk3uGduOo3dFrhGuLU1puK97Pxw6Hcm3gMd/PlDI2KLL82U9/mOwji+qpLYrEYc7nD+FTIozLl0SuAMFfbV4ILHgYJlujueiwKlPHN4Ho9xqKbmkEnbscsHikF33IfoLr0bzfj4tLXGMz++umcffJlxosX9rZ19mKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=d+krU0jG; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753864658;
	bh=TsCZZ4oZsd4hsK/7we+ITUEpP90XQsX6sTNtYeIS/v8=;
	h=From:Subject:Date:Message-ID;
	b=d+krU0jGlHDMpqvlgh4DyJ6nPM4tVR8ZlaMbs+SmG+HkjxhJtcLm1RHhnwK1DfBzQ
	 Jw1lIJw4ewcaZSzJjAgbtg/Ri/uFNIQv3id4sih2o+hbz52TNbLrreB8itAlV/wdQA
	 1eF+LrFq7TjrtnC/cBmRNQQsVMmwY2jM6tQY4iqA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6889D9A100000F32; Wed, 30 Jul 2025 16:36:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2033724457024
X-SMAIL-UIID: 691A3219AAEC416DBE6565DAA3C5054E-20250730-163652-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Xiao Ni <xni@redhat.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
Date: Wed, 30 Jul 2025 16:36:40 +0800
Message-ID: <20250730083641.3512-1-hdanton@sina.com>
In-Reply-To: <68894408.a00a0220.26d0e1.0012.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 29 Jul 2025 14:58:32 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c89782580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d51af648924b64c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=9921e319bd6168140b40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f7034580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165e44a2580000

Test Yu Kuai's fix (https://lore.kernel.org/lkml/20250730073321.2583158-1-yukuai1@huaweicloud.com/)

#syz test

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -636,6 +636,12 @@ static void __mddev_put(struct mddev *mddev)
 	    mddev->ctime || mddev->hold_active)
 		return;
 
+	/*
+	 * If array is freed by stopping array, MD_DELETED is set by
+	 * do_md_stop(), MD_DELETED is still set here in cause mddev is freed
+	 * directly by closing a mddev that is created by create_on_open.
+	 */
+	set_bit(MD_DELETED, &mddev->flags);
 	/*
 	 * Call queue_work inside the spinlock so that flush_workqueue() after
 	 * mddev_find will succeed in waiting for the work to be done.
-- 

