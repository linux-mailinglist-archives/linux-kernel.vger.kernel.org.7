Return-Path: <linux-kernel+bounces-793196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84047B3D039
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 01:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BB37A76F8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77AE260563;
	Sat, 30 Aug 2025 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L78t2IZp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D34245008
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756598080; cv=none; b=fN1v7VFhDYdDsnQbochF1LXzG4mi2a0dHEW4iHx6+wyTNYw+RxOlTqpzTD86zwV5B5Dnj2OEd0jVs9zXsenPu1O1T73RbfYeo92Bpje1DBzSetatyu7NnCNnsYscXtk0P03eF+ORdT2NNm8KhUIeqQu2jPmyZGRzBAjJErJXsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756598080; c=relaxed/simple;
	bh=yiM/nH2gzgtH53jxXENxccB6CslYME6YX4Xg/Vk/cQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9dYl6TZSPU7ROgpRNQYD1Y0/0ZsXA+8qJT9YpBn1JGG5jycoZB/YZjsJ8IjFl9eYRyPif867ikHNx7ylb9uL3vLDa/8V4v3wNCXQWZse5Zhogkqs8bKgvGAaxTalIusKcvAbTTMFO/ro825eG3UC1OZYZxs2NW6RqcF2eEh1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L78t2IZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A29C4CEEB;
	Sat, 30 Aug 2025 23:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756598079;
	bh=yiM/nH2gzgtH53jxXENxccB6CslYME6YX4Xg/Vk/cQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L78t2IZpSo8BksZBMYTPlOHbVtePgR8X/WzoZc34TdErJbBgK4eKzCJVt7yj4tr9b
	 5ZoSZMC/ygt6V3JI7Vke67ucYvsAXYau2IHKL3rPG8rl3JzA97RcgoThxgcBHPPa6R
	 v66KCzxjKtgoWQX1VMm1IXr74/RUIReD2UZbkA13W4cdEiekJcwgyKUFB0iUZbo6iC
	 f48ecbykBotIHIWSVTeTwIvoBmCYqFCzb8Sj07GEPe3aNAamOlThaCtVdPSrmBpyd8
	 MmQdBjDVAhqNtUPQIbp6Wb/PFdNDmSy7vdur5oMGvt1UFemXI6Ka+PsiZD6UkPKUN5
	 ZlpvGvlVUbWwQ==
Date: Sat, 30 Aug 2025 23:54:37 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
Message-ID: <aLOPPQFJEqoYQg24@google.com>
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
 <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
 <aLB0XeQh_tm2tXIA@google.com>
 <c7a0afdc-3f33-4de7-b36d-b0d5f55216e2@kernel.org>
 <aLIR7BaaAizkdzgl@google.com>
 <d0357cd2-5435-4d99-af31-cc56fc05ce9a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0357cd2-5435-4d99-af31-cc56fc05ce9a@kernel.org>

On 08/30, Chao Yu wrote:
> On 8/30/2025 4:47 AM, Jaegeuk Kim wrote:
> > On 08/29, Chao Yu wrote:
> > > On 8/28/2025 11:23 PM, Jaegeuk Kim wrote:
> > > > On 08/28, Chao Yu wrote:
> > > > > On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > > > > > Let's split IPU writes in hot data area to improve the GC efficiency.
> > > > > 
> > > > > I didn't get it, IPU may be not friendly for migrating data along w/ write in
> > > > > hot area?
> > > > 
> > > > This deals with IPU in the LFS mode.
> > > 
> > > Okay, so, we missed to add f2fs_lfs_mode() condition, right?
> > 
> > Why do we need that?
> 
> As you mentioned above, this deals w/ IPU in the LFS mode. Am I missing
> something?

The IPU flag indicates the data is hot. In lfs_mode, we missed to allocate
it into HOT_DATA. In normal mode, IPU will update the data in place, which
doesn't affect anything, while newly create data is also good to store in
HOT_DATA as well. So, I think we don't need other condition here.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > ---
> > > > > >    fs/f2fs/segment.c | 3 ++-
> > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > > > index e0f6589c6a1c..bb79dad55ac9 100644
> > > > > > --- a/fs/f2fs/segment.c
> > > > > > +++ b/fs/f2fs/segment.c
> > > > > > @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
> > > > > >    		if (file_is_hot(inode) ||
> > > > > >    				is_inode_flag_set(inode, FI_HOT_DATA) ||
> > > > > > -				f2fs_is_cow_file(inode))
> > > > > > +				f2fs_is_cow_file(inode) ||
> > > > > > +				is_inode_flag_set(inode, FI_NEED_IPU))
> > > > > >    			return CURSEG_HOT_DATA;
> > > > > >    		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
> > > > > >    						inode->i_write_hint);

