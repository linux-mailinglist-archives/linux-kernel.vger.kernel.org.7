Return-Path: <linux-kernel+bounces-792439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A0B3C3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B678A64BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E2242D7C;
	Fri, 29 Aug 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO6RcUPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235019D07A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500462; cv=none; b=AzDYIcHyU/SMwDgjcSMnVhkGiWBVxXRZnauL84H4mS0Enaypp8JHysJ9OFZeoguReRJCgWQMP+28Nad+/ap9PCUx9Nau5u7i5sC6u7T75PzuZNqEiyV/evXIBTO06sB6KAVtD5eL667MUNmwPKkdIw6QDrUHos3mBy7NNoHghmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500462; c=relaxed/simple;
	bh=F7fZbKF+Hhm6Gj12IyHGEeCDC6NcPiaP7jk7hL0CUx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5ju9AJLG/+54XOj6zz6zOclr2ifMeQkYnbPu6bAeKritS9CzQjNiSeJJ7PKEeuWjcE53SVK25ndcpd113+zi7n40ZI230kNOxMWTlLJsQZ485Lkr0+TppXMzwhiAVuLVBBkmesEoUYqIZw7WA70EOjlPJRvQweMqemXU8dW5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO6RcUPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2965C4CEF0;
	Fri, 29 Aug 2025 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756500462;
	bh=F7fZbKF+Hhm6Gj12IyHGEeCDC6NcPiaP7jk7hL0CUx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gO6RcUPdD6Sr/1T6nxF3eQx7oOBz3hVuMlPGNctbxpsU8M0jFcnVplvJxVR8xGCd7
	 PdzZbp4n7jpG41CPMyU55n8Yj6nhNX6n26rVhYYYbN6cyhKos/tJC420fFE50vF8Fk
	 XjAXWQcxGV7m9Kgkz2xYOIPm5BqBAV5wIYYTN+QZWfUJRkT4+MiX0dDNSgs7Vmua5/
	 w1Vl4f6sP0MikljP/RQIqnJBiWpl1TeRxCsgU4ABI7Zb7dbVo2SiHq6H3ZRWUT1i22
	 sk+M4QbiIi8qvtr2fVHSJQuoX0CDVEdiTwmHXvz+BpPfFpBLTp+xK5ktg6sulc7QGL
	 3jbbiuAc+R2Xw==
Date: Fri, 29 Aug 2025 20:47:40 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
Message-ID: <aLIR7BaaAizkdzgl@google.com>
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
 <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
 <aLB0XeQh_tm2tXIA@google.com>
 <c7a0afdc-3f33-4de7-b36d-b0d5f55216e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a0afdc-3f33-4de7-b36d-b0d5f55216e2@kernel.org>

On 08/29, Chao Yu wrote:
> On 8/28/2025 11:23 PM, Jaegeuk Kim wrote:
> > On 08/28, Chao Yu wrote:
> > > On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > > > Let's split IPU writes in hot data area to improve the GC efficiency.
> > > 
> > > I didn't get it, IPU may be not friendly for migrating data along w/ write in
> > > hot area?
> > 
> > This deals with IPU in the LFS mode.
> 
> Okay, so, we missed to add f2fs_lfs_mode() condition, right?

Why do we need that?

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >   fs/f2fs/segment.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index e0f6589c6a1c..bb79dad55ac9 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
> > > >   		if (file_is_hot(inode) ||
> > > >   				is_inode_flag_set(inode, FI_HOT_DATA) ||
> > > > -				f2fs_is_cow_file(inode))
> > > > +				f2fs_is_cow_file(inode) ||
> > > > +				is_inode_flag_set(inode, FI_NEED_IPU))
> > > >   			return CURSEG_HOT_DATA;
> > > >   		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
> > > >   						inode->i_write_hint);

