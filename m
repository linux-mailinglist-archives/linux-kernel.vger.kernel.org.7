Return-Path: <linux-kernel+bounces-784779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F12B340E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F163B7B45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321E272811;
	Mon, 25 Aug 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ej21sl26"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6078F29
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129089; cv=none; b=kJzj44sNccmgp61c69RCIunAFu0LJOhdpr/5aOPVlrON9/2VPrhOi9kgt3lEJKFcf34U1SEGMYbuwZYXCCiYzR97N0eQPMvKcXBCi8EAhjVRJliTMLGxg5FuqcFMwDCiDTcAUp35CX60MhEHaEGcFny4QhDOs58rlnJcoM7wbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129089; c=relaxed/simple;
	bh=BHMvzg2b3Q99pUM2LkIF3pQZHrcwjZy8f0DBK73CqTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko/Dkm8JvUwnb9EIRovwDK+2/Gk+WCxYGCMMARLDiKz7RXi3dcC2hGfxXlyXHLr4QT3aY32XWIuD6C1l4w9FLKzQQLaJxjpo8jIJLL219HaOcB6wi1zTbn2mkCK5DClV+HAmYuygl6vSD0rOzmnF5Mn+3yVsmGD5adz4v2bd8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ej21sl26; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-146.bstnma.fios.verizon.net [173.48.121.146])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57PDbhaD000596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 09:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756129069; bh=DhKcm+2HIXxor3Yfwk81KfyIYu4BusrCprsTFNUMOd8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ej21sl26LAyyvIBOGAerawfp4yK7A56MPoYu0eEkuGeQRBSYD4cdpGb6Mm2MKp0mf
	 0AZlh0RzF/9cGbZdJFdcq0bsCkqcFLt7vZisb4vOYZILHZ3yub3M4mSjfp1Vg88Y6j
	 BpeAWUfRWvMAU2G1ZCyu33DN641tTCT2jForSD05ddeU0MvKeMsU1KmsK4cl+r/f8m
	 EdR0MtVzKMALcaVKHW2QHD2iKhVCsZaXiR0zF1fdmlBaAZp6SGNp1xGwPguGDXTOXw
	 l5A1OBYX6oM8CV78n0AZv0r8TY+AulgDCXbKuTRpFKYDoK8gz16NkeHwUmYRVeMPBh
	 DeHc/FtbXhMHQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 97B652E00D6; Mon, 25 Aug 2025 09:37:43 -0400 (EDT)
Date: Mon, 25 Aug 2025 09:37:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
Message-ID: <20250825133743.GA1511874@mit.edu>
References: <68ac2412.050a0220.37038e.0089.GAE@google.com>
 <20250825104155.5420-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825104155.5420-1-hdanton@sina.com>

On Mon, Aug 25, 2025 at 06:41:52PM +0800, Hillf Danton wrote:
> > syzbot found the following issue on:
> > 
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c5c9c223a721d7353490
> 
> --- x/fs/ext4/inode.c
> +++ y/fs/ext4/inode.c
> @@ -4573,6 +4573,7 @@ int ext4_truncate(struct inode *inode)
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  	unsigned int credits;
>  	int err = 0, err2;
> +	static int subclass = 0;
>  	handle_t *handle;
>  	struct address_space *mapping = inode->i_mapping;
>  
> @@ -4636,7 +4637,7 @@ int ext4_truncate(struct inode *inode)
>  	ext4_fc_track_inode(handle, inode);
>  	ext4_check_map_extents_env(inode);
>  
> -	down_write(&EXT4_I(inode)->i_data_sem);
> +	down_write_nested(&EXT4_I(inode)->i_data_sem, subclass++);
>  	ext4_discard_preallocations(inode);
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))

This isn't the right way to fix these sorts of Syzbot failures.  First
of all, we already have subclasses defined.  Secondly, using a
continuously incrementing subclasses will chew up a huge amount of
memory until lockdep gives a warning that the kernel exceeded a fixed
limit, which (a) disables the lockdep checking, so it's counter
productive, (b) will trigger a syzbot failure, so it doesn't even shut
up the syzbot noise.

The combination of maliciously corrupted/fuzzed file systems, and a
deadlock warning, is something that I just ignore.  Your patch is an
attempt to do this programmtically, if it worked (and for better or
for worse, it doesn't).  If there was a way I could tell syzbot ---
you're just wasting everyone's time, shut up with this combination,
but there isn't.  So when I have time, I'll recategorize these reports
to priority low, which is a signal that it's been triaged, and it's
syzbot noise.

Cheers,

						- Ted

