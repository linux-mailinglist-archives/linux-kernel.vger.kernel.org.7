Return-Path: <linux-kernel+bounces-888675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B3C3B94E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D480034E74E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862D33BBDD;
	Thu,  6 Nov 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Qwg3oM9j"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE52E0407
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438188; cv=none; b=iyhlqN7Py2of8l8gseteZpmvqI/EKSJzOM2c0b+ykG5M1t5we0KdPmu8nqyOKzv1/Aoo5b5YFUAcQ9UrpWtP22J3FosdWD86FJ59Mee1JGKo8JNxTP6hhmFEaD7Wf0goLwX/Rli6b1uElSuVxEx7KvfNJ5KW9FElucBbvF/WqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438188; c=relaxed/simple;
	bh=Z3uANiNMk4r6fnAxcqCq/CTkxJgzvPJiltqaGzoO5Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEONxe5YM5NLjMPtcu84IHGehlSXqRZFkWTFELBlK1aV2QEOlsOd15Kw7h3MsR9CLZreJNgkPrYleQ6s+9vxa/emG5c7t5xGJFbj9HFL5L2gxhtIwePXbisPt1nHCDRDCGs+vZEboQ75X6AJwJRPZHynqHy/mCc1r1lsBpNqs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Qwg3oM9j; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-124-240.bstnma.fios.verizon.net [173.48.124.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A6E9UPM017790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 09:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762438174; bh=8DMDfezeAVfp6kmu589LYOzfvjXtFG4WQ0MxWGtbsEw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Qwg3oM9jsv3wsjryz3eZq8trFBFiLPw3VYSPzAL7N5DjQ29omMPp+3gC5PwVXtVP2
	 X7Q3VvFAgF5QRI5HzFgaVf7CSpMYC8Dh3/kYaiRA2jNtHW0Y9I7BsXR4RQYpUpNnB0
	 ZGt86KxY2WWCgGxmhbsJNonNR/LI0CcZarq3zL8taZSvSOyZLwJjyYR7qnEPyz9JtK
	 Kc5/hRu3oMYn4tZd7RrFogXeduYKHZrAvDm8o4Xxo5oFzaYuyxKypkhSawNdUXjWVE
	 NQ4coqTSeGimCK55wVUz+ryVv847wO9Zv1bhFoeUPWdth3BScKZ3PzevyEODJ449eD
	 ouvRMLwoxf2rg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3F8942E00D9; Thu, 06 Nov 2025 09:09:30 -0500 (EST)
Date: Thu, 6 Nov 2025 09:09:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: =?utf-8?B?56ug5oC/6LS6?= <12421252@zju.edu.cn>, security@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] ext4: KASAN use-after-free and Oops in
 ext4_xattr_set_entry with crafted ext4 image
Message-ID: <20251106140930.GC826105@mit.edu>
References: <dd5c923.1fc4a.19a5475534a.Coremail.l1zao@zju.edu.cn>
 <2025110632-fondue-chewer-2e20@gregkh>
 <58255d5d.20a1f.19a585765c9.Coremail.12421252@zju.edu.cn>
 <2025110602-display-remodeler-80f0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025110602-display-remodeler-80f0@gregkh>

On Thu, Nov 06, 2025 at 05:50:35PM +0900, Greg KH wrote:
> 
> > I ran e2fsck -fn on the extracted image and it does report errors
> > (including “padding at end of block bitmap is not set”), so it seems
> > fsck already detects the corruption. Next time I will evaluate the
> > impact more carefully before contacting the Linux community again.
> 
> That's great to hear, but I'm sure the ext4 developers would still
> appreciate a kernel patch for this if you have one :)

A couple of other things.  First of all, when you send a report which
involves a corrupted file system, please include a copy of the
corrupted file system so the file system developers don't have to
waste a lot of time digging it out of the poc.c file.  For reports
from the upstream syzkaller, developers use syzbot website too
download artifiacts like the corrupted file system, and in cases where
they can't reproduce the problem, they can request that the syzbot
test a proposed patch for them.

One of the problems with academic researchers sending reports from
forked syzkallers is that they often don't stand up the webserver,
which causes a lot of extra effort from upstream maintainers from
responding.

I did spend an hour or so trying to pry out out the image, and took a
look at it long enough to confirm that indeed, the file system was
corrupted and so it's very low priority for me to debug it --- since
as Greg has pointed out, if you can mount a file system, in general
you're asking for problems.  Sure, you can disable setuid programs,
et. al, but for a **long** time, the block device is considered part
of the trust boundary.

Yes, there are some particularly bone-headed decisions made by certain
distributions, such as Red Hat mounting file systems whenever someone
is stupid enough to insert a USB stick (scattered in the parking lot
of the targetted defense contractor by the MSS or the CIA) in their
laptop.  This is **why* e2fsprogs and xfsprogs ships udev rules which
override that particular bit of product-manager driven stupidity.  (I
wlil note that most enterprise sysadmins already disable USB mounts.)
But if someone really wants to do that stupid thing, they should send
us patches; it's not high priority for me to fix.

That being said, it does look that e2fsck doesn't actually fix the
problem.  The issue seems to be a maliciously corrupted inode with
bogus extended attributes inline in the inode structure.  There are
other things corrupted by syzkaller, including block bitmap padding,
but it's not really relevant for the reproducer.

If you want to save time for the upstream maintainer, please try to
minimize the reproducer.  That means removing irrelevant bits from the
file system image, and those bits of the reproducer which is
completely irrelevant.  I'll try to take a look at it later, when I
have free time.  But if you'd like to help me, try to create a minimal
reproducer.

Cheers,

						- Ted


