Return-Path: <linux-kernel+bounces-785907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495BB35260
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AB72417B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847A2D372E;
	Tue, 26 Aug 2025 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="m4vPpzQS"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA12D3ECC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180129; cv=none; b=KZ8tSgqTixeex+5ng2uy7HbotIZu60Bc9XaKVT52f74DedeS/n9IczyEGBE8r5mkYBoNogsEMuVXHJFQdii0/dKnV4hIhU3U0iJDZBefcm5RTYNnym4FHhLuy1buwjR+z0pxWeUVzzZy7vZNEM5Q8CUBoKqN5NWEb+ej9xz/XjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180129; c=relaxed/simple;
	bh=0sXBa9slQi877e0tzItamSA3Y4MpnexBgbySaeHmURs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYk8+9QZxXwuuNqdiI9oL9B3gdZ6RL5DZpFAa8qzNOXjP77yKGE6hrd87iCsil1NiuvYVGXYOPbCU81usxUB271DDg7eKjzjfEO2tNBf/TkfGUF3JXRnNPXraDrYcm/gpxeEdJBo27Ef9e3pGTS/JAw3zhwc7tgoG9PTUMYrSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=m4vPpzQS; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756180124;
	bh=0ESWAmknthhY3JxvXgyQGe9OLdOPWnyGj/u3/PMw98w=;
	h=From:Subject:Date:Message-ID;
	b=m4vPpzQSVJHqTxRG8gijFhhLNZ6xffbkA3nmykNhNf2Ydj1xejdxVoM7vtd1nKe1/
	 EYHmMyLk95r81gvn9MFSHhbY7nRdpJz8Rz1T9sCOpI2HSl62me5qwpP6T8YQlX7iOW
	 IKr7DRWSHwAiPBY6rOQwm/2e1Z9fyaF1OKiReoAM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68AD2E08000003EF; Tue, 26 Aug 2025 11:46:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7814806291959
X-SMAIL-UIID: 6F2C4A3F9A21424184A1E8AB522127B4-20250826-114617-1
From: Hillf Danton <hdanton@sina.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: syzbot <syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
Date: Tue, 26 Aug 2025 11:46:06 +0800
Message-ID: <20250826034607.5604-1-hdanton@sina.com>
In-Reply-To: <20250825133743.GA1511874@mit.edu>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Aug 2025 09:37:43 -0400 Theodore Ts'o wrote:
> On Mon, Aug 25, 2025 at 06:41:52PM +0800, Hillf Danton wrote:
> > > syzbot found the following issue on:
> > > 
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c5c9c223a721d7353490
> > 
> > --- x/fs/ext4/inode.c
> > +++ y/fs/ext4/inode.c
> > @@ -4573,6 +4573,7 @@ int ext4_truncate(struct inode *inode)
> >  	struct ext4_inode_info *ei = EXT4_I(inode);
> >  	unsigned int credits;
> >  	int err = 0, err2;
> > +	static int subclass = 0;
> >  	handle_t *handle;
> >  	struct address_space *mapping = inode->i_mapping;
> >  
> > @@ -4636,7 +4637,7 @@ int ext4_truncate(struct inode *inode)
> >  	ext4_fc_track_inode(handle, inode);
> >  	ext4_check_map_extents_env(inode);
> >  
> > -	down_write(&EXT4_I(inode)->i_data_sem);
> > +	down_write_nested(&EXT4_I(inode)->i_data_sem, subclass++);
> >  	ext4_discard_preallocations(inode);
> >  
> >  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> 
> This isn't the right way to fix these sorts of Syzbot failures.  First

It is simpler to fix it than create it wrt surviving the syzbot test [1].

[1] https://lore.kernel.org/lkml/68ad1ca1.050a0220.37038e.009e.GAE@google.com/

> of all, we already have subclasses defined.  Secondly, using a
> continuously incrementing subclasses will chew up a huge amount of
> memory until lockdep gives a warning that the kernel exceeded a fixed
> limit, which (a) disables the lockdep checking, so it's counter
> productive, (b) will trigger a syzbot failure, so it doesn't even shut
> up the syzbot noise.
> 
> The combination of maliciously corrupted/fuzzed file systems, and a
> deadlock warning, is something that I just ignore.  Your patch is an
> attempt to do this programmtically, if it worked (and for better or
> for worse, it doesn't).  If there was a way I could tell syzbot ---
> you're just wasting everyone's time, shut up with this combination,
> but there isn't.  So when I have time, I'll recategorize these reports
> to priority low, which is a signal that it's been triaged, and it's
> syzbot noise.
> 
Frankly there is much noise you can safely ignore, like what LT made.

> Cheers,
> 
>						- Ted

