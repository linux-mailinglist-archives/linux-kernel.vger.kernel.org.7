Return-Path: <linux-kernel+bounces-896634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F2C50DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AC23A0841
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4B2E7658;
	Wed, 12 Nov 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K//WRk+l"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976E2F068E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930786; cv=none; b=BSMpCXhtQ+TRy0Fe9ISXdyBviv/sot8eymhFOjrepETeTFzBH3QTEUWHrolxsFHOSgEbifIb37ZiO+k//t8uixXK0uAnspdncPWiiDtm74Uv1ainJLC9mcKkzmdB56YeWBiCSi/uG4Dsjx9JVngGHd0dM3xnnQ0l9ZqBEhqyFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930786; c=relaxed/simple;
	bh=nyZtONnnlVOHu7K4pPYC9VaZOxERptmNZ6w7cHqJ9eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkoufH5qCaLToYZ9ng9vI27PIokZsDVO2OL1xMaKi4VzviiZSlTFk2PF079FdHZWEAHRIjGq8kghJYDrIjnBztNlJoHf//14Z+g+aYbzfceUQK7dm7v0wxGGDyuekZAWMd4U898iV4hs9xwUCngHt4g96LEAtywSoSIe+HpjADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K//WRk+l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c5e0f94eso40091f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762930782; x=1763535582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzTQiJM+cXpP6/qVO6OnvYZS5jUav/J5E78kowl/WGI=;
        b=K//WRk+lqqpCqihXo4mTxJ82OOo2whdqVIjlCJGy81fRzes9u2Cn6AgEMFupjX+N+g
         oxNUwU2QVHsjBRZ1hMMrWVj8GFuYPvdlVKyaGD5avsGbE62JA742TAiZJFvTCfhKoHyA
         kFwe0z3zeqNDnBQtQ49oX5VuUGGFZ8aT+MAElcKVmXcWER+op+xlHsFDEKAUqeqqgyjm
         yHkpsiNlYWpty81EkGPud+626Ul4qlBPs6h8gMPvJYt4E9XwNdtSynASk3tY3yzATfIQ
         6/kUUoV7wwleCUGKGvEMHPUWz/PEB7ZIUrpoW/0qVFrxbCifWIX3TRORa7dw3IEE/7V2
         4y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930782; x=1763535582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzTQiJM+cXpP6/qVO6OnvYZS5jUav/J5E78kowl/WGI=;
        b=Y+XhWAmxZvn1PACAgIWsbyZEBgSdMuuU44zDVILYIx+xRL6GmrrhfkamKuss6R5cJX
         Aqc536+HY9J45iH51ZOvkD7vB4PxG1sRhjEmIT3/2mbI0h9W1m4doZMKoOGVIbrSvlwX
         bN0UlVQ0qAMvfcg0lsddVlrmIhFOf4Z7otW3gPCYFqCn94NGUrZVD3Xlhu9dKna+ATWM
         427w3srOUBYD9ynxavtdv/vIAkodaSzY/0L3B6CwH5jWsJVWAfGw7fc6pMvrSunUkh6V
         nVhUvdyT6wWapYEH0f966GzVuMH89Z5QYO5wVpYE1pAVjqgDz97XQT4/pBsBl/j39WGy
         qLJg==
X-Forwarded-Encrypted: i=1; AJvYcCXcVDlgLxjETc69GlJ8uJbvxKEIwoM/dHj2LuZ5bNYdLrPoyRyV21chqxJJs7mTlrKF+owcvWyvbhiHOww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoOtJrCzauljH43cJQRbt//VO7LMLPUX2bnvdgirD5vRPZ8HZ
	9eplHfsYTe1Qv2VIIO+eKC4MwPmAPsc15eiGUPMklNt40y9vTAO7yd9m9KWgfNMudqc=
X-Gm-Gg: ASbGncu6wHaT6JXWfsYnhMOEvXhtclmtM+RjXmuKn/BlsmDPTB7xw9Paho4qwGjlMfH
	sOYEnTcBDM6UmKs7rIzNLHHIMCTx/v/RETICLqprAtWb6g9wgr3RcJVDhoOil8HIhq3oon+ZLpj
	PPjcb4nOKSREOTh2NyNJfA9/4npz2XCoEjM36Jw2ucQtTPAK/fswTg8tA7Z9x6WL2DahK+ZCM3D
	at1wWtUCEYGNRLTkj49wXg+/tEZwqciiNSXbal9Wq/rMkMon/C8FNE6OeusyDo8d3T4/KD2ecAi
	V2In6IyKriJRcwciAaYcj+2BBFjTwylSRWo9eEorifSpHiMLYgFWkWXAScLOUIaC55ggR38+v18
	V6sah48iADpY0MF2DOAJ6iLa0hh2iKp0eHQxa4K2e3jLiF29WQQwLKAEf+suKA2eLo6qmcERe/t
	8=
X-Google-Smtp-Source: AGHT+IGlezVpQs3jxZ10NkBjnORVb8zYogF3MpAou+pO/oIjm0w7IG3Wqh0lbj2Tma2JDDJ0ukTl/A==
X-Received: by 2002:a05:600c:1f8c:b0:46e:36f9:c57e with SMTP id 5b1f17b1804b1-477871f41e5mr7815605e9.5.1762930782029;
        Tue, 11 Nov 2025 22:59:42 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf097esm19033955ad.32.2025.11.11.22.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:59:41 -0800 (PST)
Date: Wed, 12 Nov 2025 14:59:38 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>, glass.su@suse.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ocfs2: give ocfs2 the ability to reclaim suballoc
 free bg
Message-ID: <6bt4hapd3fij4nlekl5dj2g2bxgcmfujuxfzb37lpjfypbzda6@ahgdnhjablpi>
References: <20240908140705.19169-1-heming.zhao@suse.com>
 <20240908140705.19169-2-heming.zhao@suse.com>
 <c87729aa-79ca-47ca-97b5-4af7c3829e12@linux.alibaba.com>
 <7c8e2f25-6263-441d-b299-cc81109875b9@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8e2f25-6263-441d-b299-cc81109875b9@suse.com>

Hi Joseph,

Sorry for waking up this thread. Please see my comments below.

On Wed, Oct 09, 2024 at 10:56:47AM +0800, Heming Zhao wrote:
> On 10/8/24 15:16, Joseph Qi wrote:
> > 
> > 
> > On 9/8/24 10:07 PM, Heming Zhao wrote:
> > > The current ocfs2 code can't reclaim suballocator block group space.
> > > This cause ocfs2 to hold onto a lot of space in some cases. for example,
> > > when creating lots of small files, the space is held/managed by
> > > '//inode_alloc'. After the user deletes all the small files, the space
> > > never returns to '//global_bitmap'. This issue prevents ocfs2 from
> > > providing the needed space even when there is enough free space in a
> > > small ocfs2 volume.
> > > This patch gives ocfs2 the ability to reclaim suballoc free space when
> > > the block group is freed. For performance reasons, this patch keeps
> > > the first suballocator block group.
> > > 
> > > Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> > > Reviewed-by: Su Yue <glass.su@suse.com>
> > > ---
> > >   fs/ocfs2/suballoc.c | 302 ++++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 292 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> > > index f7b483f0de2a..d62010166c34 100644
> > > --- a/fs/ocfs2/suballoc.c
> > > +++ b/fs/ocfs2/suballoc.c
> > > @@ -294,6 +294,68 @@ static int ocfs2_validate_group_descriptor(struct super_block *sb,
> > >   	return ocfs2_validate_gd_self(sb, bh, 0);
> > >   }
> > > +/*
> > > + * hint gd may already be released in _ocfs2_free_suballoc_bits(),
> > > + * we first check gd descriptor signature, then do the
> > > + * ocfs2_read_group_descriptor() jobs.
> > > + *
> > > + * When the group descriptor is invalid, we return 'rc=0' and
> > > + * '*released=1'. The caller should handle this case. Otherwise,
> > > + * we return the real error code.
> > > + */
> > > +static int ocfs2_read_hint_group_descriptor(struct inode *inode,
> > > +			struct ocfs2_dinode *di, u64 gd_blkno,
> > > +			struct buffer_head **bh, int *released)
> > > +{
> > > +	int rc;
> > > +	struct buffer_head *tmp = *bh;
> > > +	struct ocfs2_group_desc *gd;
> > > +
> > > +	*released = 0;
> > 
> > I'd like the caller is responsible for the initialization.
> 
> OK.
> 
> > 
> > > +
> > > +	rc = ocfs2_read_block(INODE_CACHE(inode), gd_blkno, &tmp, NULL);
> > > +	if (rc)
> > > +		goto out;
> > > +
> > > +	gd = (struct ocfs2_group_desc *) tmp->b_data;
> > > +	if (!OCFS2_IS_VALID_GROUP_DESC(gd)) {
> > 
> > How to distinguish the release case or a bug?
> 

I rechecked the code and withdraw my previous comments, as the release gap
doesn't exist.
The reason: ocfs2 locks alloc_inode before calling threads A and B.

Redarding the question: How to distinguish the release case or a bug?

(Hope I correctly understand your question) my answer:
ocfs2_read_hint_group_descriptor is derived from ocfs2_read_group_descriptor.
The differ is:
- ocfs2_read_group_descriptor calls ocfs2_read_block() and passes the
  'validate':ocfs2_validate_group_descriptor.
- ocfs2_read_hint_group_descriptor calls ocfs2_read_block and passes the 
  'validate':null

The job of distinguishing between a release case or a bug is similar to that of
ocfs2_read_group_descriptor. I directly call ocfs2_validate_group_descriptor
and ocfs2_validate_gd_parent after the GD signature is correct. If we
encounter a bug case, the subsequent validation functions will handle it.
Btw, in the new function _reclaim_to_main_bm(), the
memset(group, 0, sizeof(struct ocfs2_group_desc)) will clean up all group info.
Therefore, after applying this patch, the GD area is full with ZEROs after being
released.

Why can't we reuse the existing ocfs2_validate_group_descriptor()?
It calls ocfs2_validate_gd_self(), which triggers do_error() and makes the volume
read-only.

Thanks,
Heming

> Good question.
> 
> Before this patch, OCFS2 never releases suballocator space.
> The ocfs2_read_group_descriptor() doesn't need to handle the
> case of reading a bad 'struct ocfs2_group_desc'.
> 
> After this patch, there is a gap between
> _ocfs2_free_suballoc_bits() and ocfs2_read_hint_group_descriptor().
> 
> 
>      thread A                          thread B
> -------------------------------------------------------------
> ocfs2_claim_suballoc_bits
>  hint is not zero
>   ocfs2_search_one_group
>    + ocfs2_read_hint_group_descriptor
>    | + OCFS2_IS_VALID_GROUP_DESC(gd)
>    |    returns true
>    |                                _ocfs2_free_suballoc_bits
>    + ...                             + free the last bit of gd
>    |                                    + release gd
>    + ocfs2_block_group_set_bits
>       uses released gd, data corruption
> --------------------------------------------------------------
> 
> I plan to introduce a new cache_info flag 'OCFS2_CACHE_CLEAN_GD' to protect this case.
> e.g. (just demo, not tested)
> 
> 
>      thread A                          thread B
> -------------------------------------------------------------
> ocfs2_read_hint_group_descriptor()
>   ocfs2_read_block()
> 
>   //protect code begin
>   ci = INODE_CACHE(inode);
>   ocfs2_metadata_cache_io_lock(ci);
>   if (ci->ci_flags & OCFS2_CACHE_CLEAN_GD)
>       goto free_bh;
>   ocfs2_metadata_cache_io_unlock(ci);
>   //protect code end
> 
>   gd = (struct ocfs2_group_desc *) tmp->b_data;
>   if (!OCFS2_IS_VALID_GROUP_DESC(gd)) {
>      ... ...
>   }
> 
>                               _ocfs2_free_suballoc_bits()
>                                 ... ...
>                                 if (ocfs2_is_cluster_bitmap(alloc_inode) ||
>                                     (le32_to_cpu(rec->c_free) != (le32_to_cpu(rec->c_total) - 1)) ||
>                                     (le16_to_cpu(cl->cl_next_free_rec) == 1)) {
>                                         goto bail;
>                                 }
> 
>                                 //protect code begin
>                                 ci = INODE_CACHE(alloc_inode);
>                                 ocfs2_metadata_cache_io_lock(ci);
>                                 if (ci->ci_num_cached > 1) {
>                                         goto bail;
>                                 }
>                                 ci->ci_flags |= OCFS2_CACHE_CLEAN_GD;
>                                 ocfs2_metadata_cache_io_unlock(ci);
>                                 //protect code end
> 
>                                 _ocfs2_reclaim_suballoc_to_main(handle, alloc_inode, alloc_bh, group_bh);
> --------------------------------------------------------------
> 
> > 
> > > +		/*
> > > +		 * Invalid gd cache was set in ocfs2_read_block(),
> > > ... ...
> > > +/*
> > > + * Reclaim the suballocator managed space to main bitmap.
> > > + * This function first works on the suballocator then switch to the
> > > + * main bitmap.
> > > + *
> > > + * handle: The transaction handle
> > > + * alloc_inode: The suballoc inode
> > > + * alloc_bh: The buffer_head of suballoc inode
> > > + * group_bh: The group descriptor buffer_head of suballocator managed.
> > > + *           Caller should release the input group_bh.
> > > + */
> > > +static int _reclaim_to_main_bm(handle_t *handle,
> > 
> > Better to rename it to _ocfs2_reclaim_suballoc_to_main().
> 
> OK.
> > 
> > > +			struct inode *alloc_inode,
> > > +			struct buffer_head *alloc_bh,
> > > +			struct buffer_head *group_bh)
> > > +{
> > > +	int idx, status = 0;
> > > +	int i, next_free_rec, len = 0;
> > > +	__le16 old_bg_contig_free_bits = 0;
> > > ... ...
> > > +	le32_add_cpu(&rec->c_free, count);
> > >   	tmp_used = le32_to_cpu(fe->id1.bitmap1.i_used);
> > >   	fe->id1.bitmap1.i_used = cpu_to_le32(tmp_used - count);
> > >   	ocfs2_journal_dirty(handle, alloc_bh);
> > > +	/*
> > > +	 * Reclaim suballocator free space.
> > > +	 * Bypass: global_bitmap, not empty rec, first rec in cl_recs[]
> > 
> > s/not empty rec/non empty rec
> 
> OK.
> 
> /Heming

