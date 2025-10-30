Return-Path: <linux-kernel+bounces-877734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA6C1EE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EFC1895A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592433B6D2;
	Thu, 30 Oct 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IWL1+ANl"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A5334C34
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811162; cv=none; b=JHN1BdYjT9pTIYyagRpbis5SaFwxESrCBuBNesnL72/Qbt0l7cMbvOMH5z3U1o1ycz+RgnPtKjagKu08GWpOXbKjQ3KCdQWrye20uLPz2FQUJN9hFEX/iTw2sXyYmf3d/Ec2Ny1zi/L/f09nDHS/ts4p4wwWKSdv1ImEuWuuZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811162; c=relaxed/simple;
	bh=p9Kbtdf4LrBZJvlhGyrQ8xwNEm/z9oCOyc3wRrZl5os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzqLK9mPgYWHelQptoRhACUVuOYZPpgkIZD2+ioU76/elkLOC2jJWcIaNSzwXI8YUhIF4TgszI7pFF/8z9DKMIhZ2EMCElBRBkFCtPOnHVmstB6MaXaK5sstqQ1nw672aHYya3g3QUw+Q891EeCZ+UWQkbWycFpLr6uaIIrEQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IWL1+ANl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4270a072a0bso109670f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761811158; x=1762415958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIoxsoXYWqm4Xf1ajsdITMeQ3bdYTIRud5Xrl/r9fQ4=;
        b=IWL1+ANl5AoWxTOtEMKOz9aYdt3IKKVF3chHbxGI5kGBpFN8jX1lrRTy2jfI0/yJJa
         fEkZPFXg4SJ1IWNWGVAtOHayOt75AN/S5YtVSU3ahEQjWtbpCFbKPmFl+DY+9/B8LvWW
         DfaF+j1aBaVWXVpPhCvQXyPqa79stgVubjkGRhFbutLthSa2BvjzVZRJRafvRBth24R8
         1U9L2uuJEtQ3g0TRb6bOAeWfUtPrcAAtJotaa6ZoQO8lZAXxBIkWyTqIkOJZZhFricxC
         DKMi6GxtuVAcdTRbiwO93WTykNCka2jVkGUsMhsbjvuokgiPqPWOIRXkBerGMK+cQGiX
         B0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811158; x=1762415958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIoxsoXYWqm4Xf1ajsdITMeQ3bdYTIRud5Xrl/r9fQ4=;
        b=P1pjn2hf+hKscez1NH7yGS7Gi8LjjuIMXPvIfHvtCkIYFzWiCRckKMU34RGM2OZFfm
         8gpsH5Sif8fe6khhHrwb9aXx8PRyTXEjt1UD7MVzCHSI6kJm13BLwBvGTjcAeUxEK4At
         2nb8T13OxkUZARlR8zExePf9HVizEHAe5NNIFi6T6FJ9GVu/PjOVNW8H08g6+xNBvwz7
         +H3dIjGMz22EC6uezPlCsvENa7B1Pjj3E3JRY5VT/hxlhPrB5Wn3X0+FZ+Eo576kQ7VB
         IHiF216M5PbG5CAbP4JmununN9CVo+WodkBM7HcNjcpXYzaCqyhxowJOTxttV3Zf2TPW
         3h6A==
X-Forwarded-Encrypted: i=1; AJvYcCXawBp6XuejPl5SF4pHAvn1U8Qu/HnKGI92NJIy7gi/ovduQdnZTp290FTKy4xUbGV85FGxZjWXMwSfmcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznnkvgz3Qxa9+lOEESKPpP2/jM3ae8z/ulqKbAlWjMovbOBtj+
	VgfzrslIapelcpi/uwiKXjuT/1oM1Hyo1zJEoRFsX0bjfNPi0C+P0EsLEe3qE9DkmdA=
X-Gm-Gg: ASbGncvTgtCv5CudDx076snb1Yvq3RyCjFu4XJYMvaXQJgUoqaUk7Vro4d2YYBcdUNL
	PMkJMV6E4TlMi2jwv05nZE5ZZ8ZUduCPAsqVQ9HktIeL4isCgYXIlQR7yB4YRPu1tM73NfIhU5H
	SpPzoqSCrkN/c8Cw+QlfQ72jQQG/LowGXFXsl59CDOChU9nV5rxoDIAidBoGh/oJiCgIW58Yejv
	d2/9q6VCIG6Mh2anrAQ9IUPQRmpEt73Y3Gea+E68PZaPqEFNQ+7u3saAej7C/3wNTgj9Gky4V85
	6zTmgoZiyBBjE31Qe5EGzeRTYG2Aptd3/DV85R6dcQY2Yhf0f3IkquGBdi0GV+S0Pt8jqk4sDXz
	y6t4/glecG9luYIWUod1tEtT4zmNT710wtF9SP78dIlDpW0iDb6/BkS+WumpyyKvSLgh+FG7gp1
	o=
X-Google-Smtp-Source: AGHT+IG7qoNWxeH56TLe6+Z4Mf4ydyY551FTBsYsB9Zop338tCPTa37NEB0x1rOcV0kV8iiRB6Eptw==
X-Received: by 2002:a05:6000:26cf:b0:426:ff0e:b563 with SMTP id ffacd0b85a97d-429aef845a1mr2544640f8f.3.1761811158290;
        Thu, 30 Oct 2025 00:59:18 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509894c9sm1616343a91.7.2025.10.30.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:59:17 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:59:15 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029225748.11361-2-eraykrdg1@gmail.com>

Hi,

In my view, combining this patch and another patch [1] is a complete
solution for this bug.

According to the oops stack, the FS is already in read-only mode.
We should forbid any write operations and then perform the inode
sanity check.

And I think ocfs2_validate_inode_block is a good place for make_bad_inode().

[1]:
https://syzkaller.appspot.com/text?tag=Patch&x=1287f614580000
- by albinbabuvarghese20@gmail.com from:
  https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072 

Thanks,
Heming

On Thu, Oct 30, 2025 at 01:57:49AM +0300, Ahmet Eray Karadag wrote:
> Potentially triggered by sequences like buffered writes followed by
> open(O_DIRECT), can result in an invalid on-disk inode block 
> (e.g., bad signature). OCFS2 detects this corruption when reading the
> inode block via ocfs2_validate_inode_block(), logs "Invalid dinode",
> and often switches the filesystem to read-only mode.
> 
> Currently, the function reading the inode block (ocfs2_read_inode_block_full())
> fails to call make_bad_inode() upon detecting the validation error.
> Because the in-memory inode is not marked bad, subsequent operations
> (like ftruncate) proceed erroneously. They eventually reach code
> (e.g., ocfs2_truncate_file()) that compares the inconsistent
> in-memory size (38639) against the invalid/stale on-disk size (0), leading
> to kernel crashes via BUG_ON.
> 
> Fix this by calling make_bad_inode(inode) within the error handling path of
> ocfs2_read_inode_block_full() immediately after a block read or validation
> error occurs. This ensures VFS is properly notified about the
> corrupt inode at the point of detection. Marking the inode bad  allows VFS
> to correctly fail subsequent operations targeting this inode early,
> preventing kernel panics caused by operating on known inconsistent inode states.
> 
> [RFC]: While this patch prevents the kernel crash triggered by the reproducer,
> feedback is requested on whether ocfs2_read_inode_block_full() is the most
> appropriate layer to call make_bad_inode(). Should this check perhaps reside
> within the caller or should the error propagation be handled differently?:
> Input on the best practice for handling this specific VFS inconsistency
> within OCFS2 would be appreciated.
> 
> Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> ---
>  fs/ocfs2/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index fcc89856ab95..415ad29ec758 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1690,6 +1690,8 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
>  	rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
>  			       1, &tmp, flags, ocfs2_validate_inode_block);
>  
> +	if (rc < 0)
> +		make_bad_inode(inode);
>  	/* If ocfs2_read_blocks() got us a new bh, pass it up. */
>  	if (!rc && !*bh)
>  		*bh = tmp;
> -- 
> 2.43.0
> 
> 

