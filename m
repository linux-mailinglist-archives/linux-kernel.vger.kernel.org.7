Return-Path: <linux-kernel+bounces-773266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B31B29D74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348B4188B6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B873276052;
	Mon, 18 Aug 2025 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JLNqB3Hz"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACF26B0BE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508668; cv=none; b=Xmu9k14ccwsAlv1CYrpdNrfFleQeayy0j82fw5nwGfm68XBDM6Bhk/u0ZLbEqQ1GHQ9HwAJ6hOI3DuA//Nwt2WBvZdjtLanCyzyJj16x8HMljQ7qKdzfPfeOg34IA5qOZl3EUrFXl54VVS8d+cdAPAZsmUc37Ix/Hz6AC6rs6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508668; c=relaxed/simple;
	bh=6yPYTLWJv/UhzZ6I9xrOSjBEbMZEJ3Y35Be016/sqvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y24Sww/L5MoSQSbY60dAxZnNdy6PL5tlKFx+DczuOu1D50xYc02Rv0wvF8k5ao6iGzKmRDLPC2eipeXgo6Tu1y6L/OKTKQWArYm3oEKbKmO5fu8tCUgJSKD6CYYaRdOPtL/nO004d0DB/mzWGTJ0BQ+eMqF8gLK9ZY8kymnRZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JLNqB3Hz; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755508661;
	bh=xYsPGRqKzQNft6o9YPSg0cxoVTrFFFZSsd1jqQqc0lE=;
	h=From:Subject:Date:Message-ID;
	b=JLNqB3HzQOM+Crqip5V5SHrLwyc/JUdr3+28f705HOmBNYydRCegTvwFytpSTDjT1
	 kIhEPsaSX6vd18PKotM/CHZuPJc0qogT164l3PpK+FfjnVnBMgy/tOEYn9jejqpoeF
	 kNEPO1xhcqPfVD8HEAAA38IQIweua2df1S1rb0x4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68A2EFA900005660; Mon, 18 Aug 2025 17:17:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6751284457046
X-SMAIL-UIID: 14EA2045D2104A4F8543BAEADD0872D8-20250818-171731-1
From: Hillf Danton <hdanton@sina.com>
To: "NeilBrown" <neil@brown.name>
Cc: "Amir Goldstein" <amir73il@gmail.com>,
	syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] WARNING in shmem_unlink
Date: Mon, 18 Aug 2025 17:17:18 +0800
Message-ID: <20250818091720.4948-1-hdanton@sina.com>
In-Reply-To: <175547723217.2234665.3959316236142184849@noble.neil.brown.name>
References: <689ff631.050a0220.e29e5.0033.GAE@google.com>, <CAOQ4uxibh4-ZM+77i7pxe_LH-Rt-QG4d0QtDQ27PXV-8Jnj+Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 10:33:52 +1000 NeilBrown wrote:
> On Mon, 18 Aug 2025, Amir Goldstein wrote:
> > Neil,
> >
> > I will have a look tomorrow.
> > If you have ideas I am open to hear them.
> > The repro is mounting overlayfs all over each other in concurrent threads
> > and one of the rmdir of "work" dir triggers this assertion
> 
> My guess is that by dropping and retaking the lock, we open the
> possibility of a race so that by the time vfs_unlink() is called the
> dentry has already been unlinked.  In that case it would be unhashed.
> So after retaking the lock we need to check d_unhashed() as well as
> ->d_parent.
> 
> So something like

#syz test upstream master

--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1552,7 +1552,8 @@ void ovl_copyattr(struct inode *inode)
 int ovl_parent_lock(struct dentry *parent, struct dentry *child)
 {
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
-	if (!child || child->d_parent == parent)
+	if (!child ||
+	    (!d_unhashed(child) && child->d_parent == parent))
 		return 0;
 
 	inode_unlock(parent->d_inode);
--

