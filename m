Return-Path: <linux-kernel+bounces-894584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66342C4B5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B97C434CB01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38013491D6;
	Tue, 11 Nov 2025 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YO4nAP+f"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E617640E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832647; cv=none; b=ha1MIzGdAuCWQDR3oO7LGaDu5LxJb96VUrsn12xXvm0+oY/wYFyPbuROISGulQ9DbsojMo50LbZPJp/u+dBbuNRCtz+TN8+HfCK+/h3BfVu18a2UpHBlqtOU9NYqUfE7Wvyk2NTBanfmTLq+suZqX416gmGpulZflsMp4rTtVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832647; c=relaxed/simple;
	bh=0ZECHkUSj6g52R5EQ80fJPC8fk2deCqZl66ciVcyS1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haRhmRym4HNJNCVjafrL9LQptZqgViWGiQK+SpXsbpQ7ijFn7jsWV9nPxElbMZKQZQJg98DbLY5aIbkXE4nI8yE5V9E6c+IG1/LTpIXyPCymHPFMWqHq6WSs+3eiuh9SdaUNlF4L7AKI37j7n1YkU+oZt1j8JT/Jzn1zbZegAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YO4nAP+f; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47107a9928cso1430535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762832643; x=1763437443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iPZXAZg8pQGqZG4u6J8NA9VICiZVn+zK9boW+BJKwU=;
        b=YO4nAP+f4xWHAYoBC+LvWra4IiFlQfl+d9X8gGBscHn7CL/hD7Cm98QhcV6KMWfRS3
         dniYnBtrpYeMVeBXBo48ldSVSj1Ou3U3hOK+YfuNQOYKw8p3Iwa9PWVTsz/61D3KqW4a
         NLnikcgIv/+bVGkb3hoEb732D0u1xZBFPkaUTQUTDF1/xZ6+GopfC02IJpX2ddRWEBgp
         zCy0IHswzdtmJggzKuuP1gySGmifTT84aUywdosUSEZnQpJzGHMEueWT24edWA0x+DMY
         szfheSMj9QwytnpMvL4o1nGQZi2r7VU9K2MSogA4nZbiWSUDeihOgGyn2CEcc+A4vrXy
         PP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762832643; x=1763437443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iPZXAZg8pQGqZG4u6J8NA9VICiZVn+zK9boW+BJKwU=;
        b=LjzxMAL+hlTpOa1YEvCcvhnwA43U7g9SMQ4uPS2iB2Z/5YofHgjm/LvaInQWCwINRP
         YBjrc6r1wHScWgFkE0NMdTuJLDWqogonhIIX0SLGKwbXM5HGE+yQeVRsuK1FP+aVOSs6
         aumJRn4EtlYlE627yJAjzn/RZO6QkZq332qzQenJm3vG/bpIi0UUfGXqcFSjmPt5OVYd
         ROBm6AZLghHhHEJ0cqtl5wzkRnsESH9lMJDZ96j6hpZbhoV1X5yAOmaqTLtcpQ7oDnqT
         aA/+7DeWurzerbMVjc282y1wTIVtV0HtS3c4Hry+xkEsgj791vMFP7rvonTcC/GFuz0I
         VBuA==
X-Forwarded-Encrypted: i=1; AJvYcCVcg6/Q5yfKDy6e6963Qr+Owj/gBo7NhqBZv9kmJ1PfrfkB3Ch2RDX84asd+wQkc6c17UxeB8Gh3C0jYRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkg58R14iCwNBUjrHF86x2ssFo0zVhSmz0Zis0XUGr6erZXZ0
	yb82BRXibP7UniCjjGm06S08uD1s40SkPlbnX2H6aFO3FAZfsgsJENfnrx2Z2GcOW00=
X-Gm-Gg: ASbGnctylHDhIN8I3Rv+33r/k9Og+9CXu/Oqtiy3IkROQd+RIUdf4/aMqo5uj/uTma2
	Q6rcsUP1ae3aznaqXXdVKlGPSOuUkT5m6MgIRHDYjPTGlB98kS75gfNp/XgKazqJ8K2Kw6qPj4Z
	zYu9OUx0Hmk7FwevJKlkL42x7+rqYWZtyj3g4jpfmaQVOaxvzwo4RhF73LkxfbvuqK2/Agbov16
	QWBuANVamcZNLUy6G1ZI3KbPfdgGT2su6R6ISBIOtwl2HMwWCQBOsdxcqgIrxqLSnDOSxoWjyrP
	LaVGh96oOLLYiNPrqdl7S4FxQykaNkM/U/xzfwX0IwPJkXcZL02cKKQKCZivVq5QQ1gkDtwXnEM
	8kpZ9Y+wDbPyzdWtyy6TxgTwHlCdpkOaAijvv7G7tIiNMOBFtNYvw+pLQkgLd/tecAQlDWa25Lm
	HV7fEQzylaKjW3tlUWlS5l
X-Google-Smtp-Source: AGHT+IEX3tDhRdCNc6A4BdqS22VA4H5jZdKkaZYPwJQeMyXBuJuX4/SBu7LMBMgcRV1F8yhicXZQTg==
X-Received: by 2002:a05:600c:4711:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-4777329f181mr52644895e9.7.1762832643133;
        Mon, 10 Nov 2025 19:44:03 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740b5sm166132835ad.70.2025.11.10.19.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 19:44:02 -0800 (PST)
Date: Tue, 11 Nov 2025 11:44:00 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [RFT PATCH] ocfs2: Invalidate inode if i_mode is zero after
 block read
Message-ID: <tocd57rydneodajmr7o2r4drjimixftcppzsbycxlwvophhxgi@jhq5lazi5buu>
References: <20251108120133.37443-3-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108120133.37443-3-eraykrdg1@gmail.com>

On Sat, Nov 08, 2025 at 03:01:35PM +0300, Ahmet Eray Karadag wrote:
> A panic occurs in ocfs2_unlink due to WARN_ON(inode->i_nlink == 0) when
> handling a corrupted inode with i_mode=0 and i_nlink=0 in memory.
> 
> This "zombie" inode is created because ocfs2_read_locked_inode proceeds
> even after ocfs2_validate_inode_block successfully validates a block
> that structurally looks okay (passes checksum, signature etc.) but
> contains semantically invalid data (specifically i_mode=0). The current
> validation function doesn't check for i_mode being zero.
> 
> This results in an in-memory inode with i_mode=0 being added to the VFS
> cache, which later triggers the panic during unlink.
> 
> Prevent this by adding an explicit check for (i_mode == 0, i_nlink == 0, non-orphan) 
> within ocfs2_validate_inode_block. If the check is true, return -EFSCORRUPTED to signal
> corruption. This causes the caller (ocfs2_read_locked_inode) to invoke
> make_bad_inode(), correctly preventing the zombie inode from entering
> the cache.
> 
> Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> Previous link: https://lore.kernel.org/all/20251022222752.46758-2-eraykrdg1@gmail.com/T/
> ---
>  fs/ocfs2/inode.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 14bf440ea4df..d966df3aa605 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1455,7 +1455,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
>  		     (unsigned long long)bh->b_blocknr);
>  		goto bail;
>  	}
> -
> +	if (!le16_to_cpu(di->i_links_count) && !le16_to_cpu(di->i_mode) &&
> +		!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL)) {

1.
di->i_links_count is the low 16 bits of i_nlink. We need to check both
di->i_link_count and di->i_link_count_hi.

2.
We are only interested the the di members' value being ZERO.
Therefore, calling le16_to_cpu() to perform the conversion is wasting CPU cycles.

3.
The ocfs2_dinode structure has dozens of members, and syzbot could potentially
corrupt any one of them. At the same time, the probability of this type of syzbot
error occurring in a real-world scenario is practically zero. My idea is to
minimize unnecessary checks.
I prefer to remove the check for OCFS2_ORPHANED_FL.

4.
It is an error/exception if either i_links_count or i_mode is zero.
The code "!di->i_links_count && !di->i_mode" need to be changed to '||'. (I
didn't test it)

Thanks,
Heming

> +		mlog(ML_ERROR, "Invalid dinode #%llu: "
> +			"Corrupt state (nlink=0, mode=0, !orphan) detected!\n",
> +		        (unsigned long long)bh->b_blocknr);
> +		rc = -EFSCORRUPTED;
> +		goto bail;
> +	}
>  	/*
>  	 * Errors after here are fatal.
>  	 */
> -- 
> 2.43.0
> 
> 

