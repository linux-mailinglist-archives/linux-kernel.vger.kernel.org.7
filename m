Return-Path: <linux-kernel+bounces-726888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82DB01268
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A1717544A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AECC1B0F19;
	Fri, 11 Jul 2025 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qTIAOxcm"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDD1AF0A7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752209590; cv=none; b=pGtNuP8Je2GSKGYVSTO9or85tIqn0RgCweQ/BgUHG3KukS4b3u4RWoJV8Crc9RKr9kCxpTdcFPhjSnceicULWHiwqn0RIkf8I5ptwOOUWXu/lATEhUZFROS2mLr7OfRVFKJnPWz5PaXLcM5pH6ziSuWT4uNkfJwsyPkurxfmWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752209590; c=relaxed/simple;
	bh=vga/2vJW0ShfaMf5blGwQhDIQddCnbrc2+8Ck8lgIJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlxBAS1WmpcZPLUPi2UOL6dMj2ypZm3t27fcZRFMa3YrMso9B/HElQ2ItpUepG6/IV06GInzmzrMw7tGnYM+3tSenh2115EHIMUmrredFPPwr0rnOr7xYcLwEbgUGA1Pzw/CLo1U7Mkv60Rgpa85kLc62Wzmrpq+/2erMRukJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qTIAOxcm; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-128-230.bstnma.fios.verizon.net [173.48.128.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56B4qQvY014681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 00:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752209549; bh=U5Ns4wPmD+L7n4vdJW299ED8vP7EdSRntB8yrpUtteQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=qTIAOxcm4KTDYa3xzWBtm3ydOSr2jXwGhFsbJ1hBYXwAolptYhMvn0h27T7gdbkL0
	 gUVeCTuj4WW6i5v5fRhlZr/vlFoa9GDSpBrVDJutkCKDOaOSZESJqYyDGx5/RkNS3J
	 nVztbWpz5tKWGAaelugzkCo+ktRvUR82DdkjstxjxRlgUArkbWsTay5THlHl2yyLRf
	 vwwZvm8UBTv6LCI8OwfocxDgvuWOyVFXdTYlFQ4nrzokp+MKR7IOAN0uqsLN4Fbl4L
	 u6qT0CQfw/qJMYhMzk7M9Cztf4ZId4lrttuGd7IEzPPudnvDQhbWjB3SD8zq7Rv7Da
	 0QWtd/KuzyOQw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E54DA2E00D5; Fri, 11 Jul 2025 00:52:25 -0400 (EDT)
Date: Fri, 11 Jul 2025 00:52:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        Jan Kara <jack@suse.com>, Tao Ma <boyu.mt@taobao.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com,
        syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: inline: convert when mmap is called, not when
 page is written
Message-ID: <20250711045225.GA245049@mit.edu>
References: <20250526-ext4_inline_page_mkwrite-v2-1-aa96d9bc287d@igalia.com>
 <ko3bgsd2wdluordh6phnmou3232yqlqsehxte6bvq34udq5in7@4phfw73mywjo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ko3bgsd2wdluordh6phnmou3232yqlqsehxte6bvq34udq5in7@4phfw73mywjo>

On Mon, May 26, 2025 at 06:20:11PM +0200, Jan Kara wrote:
> 
> So I would *love* to do this and was thinking about this as well. But the
> trouble is that this causes lock inversion as well because ->mmap callback
> is called with mmap_lock held and so we cannot acquire inode_lock here
> either.
> 
> Recent changes which switch from ->mmap to ->mmap_prepare callback are
> actually going in a suitable direction but we'd need a rather larger
> rewrite to get from under mmap_lock and I'm not sure that's justified.

This came up in discussions at this week's ext4 video conference, and
afterwards, I started thinking.  I suspect the best solution is one
where we avoid using write_begin/write_end calls entirely.  Instead,
we allocate a single block using ext4_mb_new_block() (see what
ext4_new_meta_blocks does for an example); then we write the contents
into the newly allocated blocks; and if the allocate and the write are
successful, only then do we start a jbd2 handle, to zero the
i_blocks[] array and then set logical block 0 to point at the newly
allocated data block, and then close the handle.

Splitting the block allocation from the "update the logical->physical
mapping", which is currently done in ext4_map_blocks(), into two
separate operations has been one of the things I had been wanting to
do for a while, since it would allow us to replace the current
dioread_nolock buffered write pqth, where we call ext4_map_blocks() to
allocate the blocks but mark the blocks as uninitialized, and then we
write the data blocks, and then we do a second ext4_map_blocks() call
to clear the uninitialized flag.

So it's a bit more involved since it requires refactoring parts of
ext4_map_blocks() to create a new function, ext4_set_blocks() which
updates the extent tree or indirect block map using block(s) that were
allocated separately.  But this would be useful for things besides
just the inline file conversion operation, so it's worth the effort.

Cheers,

						- Ted

