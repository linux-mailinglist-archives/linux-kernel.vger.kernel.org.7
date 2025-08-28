Return-Path: <linux-kernel+bounces-790281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94242B3A43A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6471B2747D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6C2253F2;
	Thu, 28 Aug 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy6xN7D1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5C224AF0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394592; cv=none; b=MNTii1gXQ0xZo4AjUnaT5KyDcUMqsSWjVFckjCvSihr5rQ1zaoFYgckHOBIkrEK8qffp2dRRpA1QHe/dZ48CNRCa1rX5AChU48gODEGShyan6cnfBondj7gDCbKfznGysx4h2oK9nZ3HK+7OxRISXT/6w4QtYOuzZ+x/ibhG8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394592; c=relaxed/simple;
	bh=+IyXtugZDAwkV0nQVOTbTUtq9KhDGW63qq1hNOOYnJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG5/6qFSNLY1XzRH+RbI9jDLTPT0RPSTV3SVv6AzbKBG+qSWOAloi6CBA788dg8bNcc0U39Dgd4FvPHrv1AzSBNYc90uZbLslhHvFopT/3v/y6MuLicpj4Ksic0kbDjDD3YO9zm8+lKBOXdfid1ndVm/oNfXg4Lq7k8ndGzXOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy6xN7D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ECBC4CEEB;
	Thu, 28 Aug 2025 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394591;
	bh=+IyXtugZDAwkV0nQVOTbTUtq9KhDGW63qq1hNOOYnJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uy6xN7D1uOPIBoQpgwlyNsfJbS+24BQG0O5abid6fPCHXFDzeLcy4Ym4kxbZL2NCO
	 S3h2n54MmM3T48+C1jFWBWr9F9DbvkZeM2OYuse4Rdtp/fFXGd7eX4ZKEt/X6yOM5J
	 VjBbA6DTD5SfqExyUctidVjT7bsBDppv16ORj3xjUW66LSOI0Wv9KBvLBvFOXcqJZb
	 U6/uAnEC9zkOmxV54EKHgPoBQHpsop0FueOxnuLcS6lZKwtNndYi6fYDIYrBCddfLJ
	 Quq163YxqILJoCKX9DfmYUdDgpr5FSZgwoA74MrfHmOSRukdwdR1+Mt7jmTQNd3JqZ
	 xXuT+V/FZYatw==
Date: Thu, 28 Aug 2025 15:23:09 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
Message-ID: <aLB0XeQh_tm2tXIA@google.com>
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
 <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>

On 08/28, Chao Yu wrote:
> On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > Let's split IPU writes in hot data area to improve the GC efficiency.
> 
> I didn't get it, IPU may be not friendly for migrating data along w/ write in
> hot area?

This deals with IPU in the LFS mode.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index e0f6589c6a1c..bb79dad55ac9 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
> >  
> >  		if (file_is_hot(inode) ||
> >  				is_inode_flag_set(inode, FI_HOT_DATA) ||
> > -				f2fs_is_cow_file(inode))
> > +				f2fs_is_cow_file(inode) ||
> > +				is_inode_flag_set(inode, FI_NEED_IPU))
> >  			return CURSEG_HOT_DATA;
> >  		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
> >  						inode->i_write_hint);

