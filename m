Return-Path: <linux-kernel+bounces-720676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A37AFBF22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65EF4A0C68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97265BA36;
	Tue,  8 Jul 2025 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpPUMwLO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A533F3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933575; cv=none; b=Le6qZr0HWJZqNpajt0FWJ1m0IoKofRZf3Bg4maVOUmgvgVg7D3UPAdKUuYAfNzdUw9YhMYqb92DG4Ie4CLkZBmQjWmqYk7Oh84salFEnjGANSJS21mw0B13DDogKg+ZqGLAckjUK/nuMfbUgSdH5ZP2k6tBTP7iyDg0W3o+tLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933575; c=relaxed/simple;
	bh=Cg4tCmXPkkrOzlKioCxtCYjIxNt95LxUF88Gb+F6is8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVac13hst/pdY1l1kBbxDWKjlGsDtwxitYnOpWjXJrKl0KfluWc8vG8L0yA94P4l7jxjauNSf14NTL9goQEJ6RrPBDDaLrBVCe5d40CNkTWpWxEQLgXQeYV19r5Sdk0vLtPHgw6u8DVp99e4WosP4kJ+HBbGNbIBDJvAsTClFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpPUMwLO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b440afa7so36770675ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751933573; x=1752538373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlDwzugOo/DKjpqS8sAMSEvnbA//RO2aaxdwNuyUoE8=;
        b=YpPUMwLOKC6uTnKEJXs/dkpEBCyEL4YlSVz6r46AHzA6f0bQFJV8YcxJ304hRbXT/q
         WYRR2RDjPYyRgIH0gBYhENaRDa8cWVkBDf7ZqHyQqEhc0et9FfTl7nrO0yapZDNG0U63
         xF8ITFnROY9Elc4HwD+OOCjepDlNZD+2DYKIQI101p0pH+jDbXILVV+/y22VlDA6lJJJ
         QTyRKIzs27PIV334Vzzb0pq81A+YXMMTV7miYMvU3kRVds4agKhFPGyKyo/P+BXX+IfP
         3gn8GNPfi8P6gbqPenoYv6kSGTqOw3Z+JGVSzpGmUI799V91z6k3p4PEwWPkrX4qcyev
         b/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933573; x=1752538373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlDwzugOo/DKjpqS8sAMSEvnbA//RO2aaxdwNuyUoE8=;
        b=SqpprTiOz/vqHVZJSkFsAmY1awvvei5TJaYKwAv6lqoEd+mI8uwHVYCJgBz8yIQChf
         ORxHjuYXZjMRJ2ZonLvGZAMuCz0Z/lcGQA+sqXxfb/IqXSRowAlSA8jDuBLZK+c93iZi
         bOmtdIo0ozOazYjjHVP76Mum9muH9zcnzLTA75tv6MeNOdfH472mhE06AqHhPHwnANjt
         FH/b97Ii1g5Jc0MYNqCPi9WkauPqeapKjOrghxkOzdTbTur3/cWrVT4TYtGPcmK3PnXH
         RldbnzMZXmUrl2S2hvA3RCqAjC6dLSgdjbDsdS0scJogWRFsyDbrX3b5wkxCGtII5PIl
         LE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKB5c8SMxS6KB2udEIkKmqVrlC10R/iwPOVURMIqb0fltN95S3JeFVAsaaUoTZH5pZ0awI3SYZz4NK7vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzChbizgz7zzkwIGrPqsL8KWjNW8jlf8AU8xiZ2WgDBYRd7+tgo
	Y8KPMYOuH6iAoW4ORMcfVvBQO8TvXYkYV45VgWFDK2tUZI30Ab01JwLb
X-Gm-Gg: ASbGncufbk//0hg9kKM91KpLf/TpXNUBKwU+DFG7oazQnKHSkwQi9NzVQEBk952o404
	l83SlZGXWm4ByoQd7+o1c2m//7DdMTJhaJG8eJknFH7ppIv1fh+XLjq1R5z51MHVnB29h6EDsV0
	Qzoe1VSGakeZo6QswfSQbU3l+AmgBP3lAcySv+D+EDmQTJf0jh9VNCne9O8ZfB1HD7fMjt97uKe
	scrA63DVqh1hmqvq0y9ZkNwVVNTXYrpSJSVuL6H/Ls2gwxrjHSQcJZEerSQogLJnv7qnKvW/l3l
	Nu18cDQIV3V9vWWzi28/2UAaRXnx61aIWxQgiN/JplIeqFiPQCI4bp6obm7SczsGGGWNouuy+hj
	ddok4a7UuABbI
X-Google-Smtp-Source: AGHT+IGlPYMAjX8N776SnDST+Z1sse3S9TOfo1i7zhuj4vhzwygHl5zuojjfRSeH5rNOjJDfITTiyg==
X-Received: by 2002:a17:903:4b2d:b0:238:f2a:8893 with SMTP id d9443c01a7336-23dd1d5dcb4mr8076965ad.42.1751933572939;
        Mon, 07 Jul 2025 17:12:52 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2601:646:a000:5fc0:268b:48b1:88cf:6e90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845810a5sm101956885ad.180.2025.07.07.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:12:52 -0700 (PDT)
Date: Mon, 7 Jul 2025 20:12:49 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com, 
	jlbec@evilplan.org, ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ocfs2: avoid potential ABBA deadlock by reordering
 tl_inode lock
Message-ID: <kxo27vjuqawoynwttpg56tzhvxeuobmvgdfglp5g2xcuy4vfnq@t7t4zxq27qon>
References: <20250707032951.361331-1-ipravdin.official@gmail.com>
 <11999e4c-b0ef-4718-8e93-75363729515a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11999e4c-b0ef-4718-8e93-75363729515a@linux.alibaba.com>

On Mon, Jul 07, 2025 at 01:58:35PM GMT, Joseph Qi wrote:
> >  	/*
> >  	 * ocfs2_move_extent() didn't reserve any clusters in lock_allocators()
> >  	 * logic, while we still need to lock the global_bitmap.
> > @@ -637,13 +639,11 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
> >  		goto out_unlock_gb_mutex;
> >  	}
> >
> 
> You've missed unlock tl_inode when ocfs2_get_system_file_inode() fails.

I will add it, thanks.

> 
>   
> > -	inode_lock(tl_inode);
> > -
> >  	handle = ocfs2_start_trans(osb, credits);
> >  	if (IS_ERR(handle)) {
> >  		ret = PTR_ERR(handle);
> >  		mlog_errno(ret);
> > -		goto out_unlock_tl_inode;
> > +		goto out_unlock_gb_inode;
> >  	}
> >  
> >  	new_phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, *new_phys_cpos);
> > @@ -704,12 +704,13 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
> >  	ocfs2_commit_trans(osb, handle);
> >  	brelse(gd_bh);
> >  
> > -out_unlock_tl_inode:
> > -	inode_unlock(tl_inode);
> > -
> > +out_unlock_gb_inode:
> >  	ocfs2_inode_unlock(gb_inode, 1);
> > +
> >  out_unlock_gb_mutex:
> 
> inode lock has changed to rw_semaphore, so 'mutex' is no longer proper. 
> 
> >  	inode_unlock(gb_inode);
> > +
> > +	inode_unlock(tl_inode);
> >  	brelse(gb_bh);
> >  	iput(gb_inode);
> >  
> 
> How about the following alternative:
> 
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index 369c7d27befd..d56c337204f6 100644
> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -611,6 +611,8 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  		goto out;
>  	}
>  
> +	inode_lock(tl_inode);
> +
>  	/*
>  	 * need to count 2 extra credits for global_bitmap inode and
>  	 * group descriptor.
> @@ -626,7 +628,7 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  	if (!gb_inode) {
>  		mlog(ML_ERROR, "unable to get global_bitmap inode\n");
>  		ret = -EIO;
> -		goto out;
> +		goto out_unlock_tl_inode;
>  	}
>  
>  	inode_lock(gb_inode);
> @@ -634,16 +636,14 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  	ret = ocfs2_inode_lock(gb_inode, &gb_bh, 1);
>  	if (ret) {
>  		mlog_errno(ret);
> -		goto out_unlock_gb_mutex;
> +		goto out_unlock_gb_inode;
>  	}
>  
> -	inode_lock(tl_inode);
> -
>  	handle = ocfs2_start_trans(osb, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		mlog_errno(ret);
> -		goto out_unlock_tl_inode;
> +		goto out_unlock;
>  	}
>  
>  	new_phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, *new_phys_cpos);
> @@ -703,16 +703,14 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  out_commit:
>  	ocfs2_commit_trans(osb, handle);
>  	brelse(gd_bh);
> -
> -out_unlock_tl_inode:
> -	inode_unlock(tl_inode);
> -
> +out_unlock:
>  	ocfs2_inode_unlock(gb_inode, 1);
> -out_unlock_gb_mutex:
> +out_unlock_gb_inode:
>  	inode_unlock(gb_inode);
>  	brelse(gb_bh);
>  	iput(gb_inode);
> -
> +out_unlock_tl_inode:
> +	inode_unlock(tl_inode);
>  out:
>  	if (context->meta_ac) {
>  		ocfs2_free_alloc_context(context->meta_ac);
> 
> 

This is definitely better. I will update the patch, thank you.

	Ivan Pravdin

