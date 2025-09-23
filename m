Return-Path: <linux-kernel+bounces-828898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C1B95C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECC718A2CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35F322C94;
	Tue, 23 Sep 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TBTj2fHD"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0404322DC7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629414; cv=none; b=haXRIh+2QWT8cLb0ohqnULMxFZ/DTwv8Vb6DbmZzwz7/xgP0wiYlXoJdZkdD363YlzoGa2fx72nLilyRP8Marhuy12CdIAm32A3gcMqVgLIs1wUmf4hVkHBxKeoX9kafMFu1uEQKD6keOLlYSs/g/ePR+63LMJ8sMV4AjKz2wYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629414; c=relaxed/simple;
	bh=86ujaIA25Y7ndJzivkOtthSsdvh4Gt2SZ0tHSdykE3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqGq4/MoYXYVcjZsZ1mr19YAAPD6ORFyhhSXWvrei7PhSO24jZUEIKZAOdSx/iqrz6ogX4dyNBmkfVTBAk2Sg1z/u7/7ZeVZMEh7kI9WSUx2/7lngLTzcNY6kpEmsxTqcm79G2r1MKvt6r8MaAG9YSWsfCKmmnBbHPasY1gZDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TBTj2fHD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-223.bstnma.fios.verizon.net [173.48.111.223])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58NC9sO7032033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 08:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758629396; bh=49iSOLLb1QbNUwpl4qSuS6TXaZr85TUR3lyHl4NFknM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TBTj2fHDDkjX5dnKLKb7ihDbF/qWAya+ZHrGysVeEzWuGWTfVXxWpDvJlTVUdeKTt
	 Deytw8r5LEXUbKI7t4bpOfHH6IeawWmTwwBpAACeSrvbLauOn4D1sLUPsqNVOTRnLp
	 mqeWRUVjmeWSGLs7juijAauFLQpo4W9rcw0V85tIThdYOVYsbnW1n/usYOLezkQMnz
	 XoHO6wnsMH0KrTej51GodS3qAUfV5YcsklVJHjTgMkXRsOBEaQgrUnNMuXshyxbMJR
	 HgAkqJf9lvESjV1l+zWQdhYVI05kYO4Lt2BT5+h4bR4y5+DRiaNb/7WSnN4BNBr+E6
	 q3vcbWIzo1Ghg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 2B5832E00D9; Tue, 23 Sep 2025 08:09:54 -0400 (EDT)
Date: Tue, 23 Sep 2025 08:09:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: validate xattr entries in ext4_xattr_move_to_block
Message-ID: <20250923120954.GA531144@mit.edu>
References: <20250923092512.1088241-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923092512.1088241-1-kartikey406@gmail.com>

On Tue, Sep 23, 2025 at 02:55:12PM +0530, Deepanshu Kartikey wrote:
> During inode expansion, ext4_xattr_move_to_block() processes xattr entries
> from on-disk structures without validating their integrity. Corrupted
> filesystems may contain xattr entries where e_value_size is zero but
> e_value_inum is non-zero, indicating the entry claims to store its value
> in a separate inode but has no actual value.
> 
> This corruption pattern leads to a WARNING in ext4_xattr_block_set() when
> it encounters i->value_len of zero while i->in_inode is set, violating
> the function's invariant that in-inode xattrs must have non-zero length.
> 
> Add validation in ext4_xattr_move_to_block() to detect this specific
> corruption pattern and return -EFSCORRUPTED, preventing the invalid
> data from propagating to downstream functions and causing warnings.
> 
> Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Thanks for the patch!  Could you try moving the validation test to the
check_xattrs() function?  This should hopefully catch other
maliciously fuzzed file systems so it might address other syzbot
complaints.

Something like:

		if (ea_ino && !size) {
			err_str = "invalid size in ea xattr";
			goto errout;
		}

In retrospect, we probably should have had the code interpret
e_value_size==0 as meaning that the xattr entry is always unused, so
that tests such as:

		if (!last->e_value_inum && last->e_value_size) {

could become

		if (last->e_value_size) {

But there are also places where the code assumes that if e_value_inum
is non-zero, it doesn't need to test e_value_size.

It should be the case where whenever we clear e_value_inum, we also
set i_value_size to zero.  So having e_value_num!=0 && e_value_size==0
should only be the case when someone is trying to maliciously play
games with us.

Cheers,

						- Ted

