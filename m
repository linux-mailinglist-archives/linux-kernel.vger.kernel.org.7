Return-Path: <linux-kernel+bounces-870865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2CC0BDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF853B90A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FC32D5410;
	Mon, 27 Oct 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H0WR+qkH"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2567238145
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544445; cv=none; b=FsTKgv51wWlD98+UGH4xWLn95UZYb/XnaYpZ6JhBQB9SZUxsyKFRfVvUi7Co9miFc0PvwvXYPcCBst+yaPTRM0QO99MwOk61ZJl1GaW29GxlLdHg0ROh4IMfqth+3GHJ5T8k4d/JFY6w5oPXDUxSczBRy5vFbrBIdlEQpt1LNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544445; c=relaxed/simple;
	bh=u+EU8KKrH5ID+5HbxOkW9Wqcr8VXA7wNxx+OfG6IZfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucAYp1R7YzYQT5GvRXxDr0niaAShcG9jbeOI8wtcXErgAr6quR1MOrt1g6x0b4Bp6mM00AYpTJEvSDL9v/Vi0PGUAcm5rHqr81wAoZmFL3LQcr9fCr3E43J51KHhGFQn57ikuzzBcMdwjBNhPjx5cFC6fgBcNIwC3uj8n4G0mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H0WR+qkH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42702037a01so832394f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761544442; x=1762149242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/njuYphPXe8hfmDWuFlJW6IGw1olfhhXsWRDHoUnG8=;
        b=H0WR+qkHcZwIrspd/r0NVy0dyg5jo+pOQjmfsuxbtIBX5D/kn2nIHuWuY+sI2KtoC2
         Ja71N+rcrUHgoOWYIosJu28NxXfuL+rkEo+EB1U3Rh/gkY0xwKE6gQyGTLgobrEb9dJJ
         nac01eZylU0WrqYGRnyB6ko7/XQ7s8f+mcW7lDvkMrOvD2+EEXjoyQbx/Lu1ZqQjuJfc
         ecjt8YT/4igNPSVbOXRWxiy8hGiT4RY86jQZFHGo4UXJWHdowNLIYAIQz1SoQgpiilMX
         /yyBj5BUqr7KrqrmURqv/IVVc6Q6A2+SNtMTtcFbnHNK48VOzie+a/L1wo+08Kks95XO
         VUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761544442; x=1762149242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/njuYphPXe8hfmDWuFlJW6IGw1olfhhXsWRDHoUnG8=;
        b=SDIaw2peF3tSFSxNTNK15KRnjYWp5VROVyJ0duQAdHQYnJdzO4Gnga586qfoPoSjOi
         w4Zj2tu4Elt865N7Yl8hTnU5OQTjivormWi4fyatUQPhNdfPcH7zFsZcqN4gFBOWnxxM
         3x7mpIwdGNV4mTwwYhZi8MASAuFQroXzLkEUBjpXN+QlJKui/Nf9xvyzdwoxBryI/dXC
         vhVXsn34ipukR1ManO04yQ3w4szWlUqZWyfS7OC616WKJRsGGgTXhTNEG9Iz80shsqF4
         Xvr6azHBRHXX8AiUYoSw1RpdMGkqvYolOE5JkcHAPHMYdnf0EcnxB0klSzfZeakK5G7/
         pCag==
X-Forwarded-Encrypted: i=1; AJvYcCU2/oHzRdzmhlSHiSIvfvGgg/wicl4jcxU9qcLPT+4DanH58hzdcT9Z2yhGHVa4sapSmxqqf3E9aU4yKeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94Ng/27cwwfqbzuQSbLm4N/4hwfA+PZadOndJyo+Iammt4vU9
	32VXZLcs0JDokv4E2vHNQacMxdku81vfKCFZJNnfFKr1U4rupDfIQ0kJW+4r5wrWZd8=
X-Gm-Gg: ASbGncu1g5BQGxwn3UVb6mrHmbvhJixx9xxwfkYz3/qK0EulCJpB+cJu/MXdhiq7haG
	BJLdZtsggHY0Fb2HtNn/Q+qp2RH645on+HKCkE/Dn5uL3xLH2AJwUUp/M/ZaDrZS65SifO4uRDc
	zYPmGfbcmAU9CdcRIiQbXi/qTjorTGEqmbG4NsqUPoP1Rbl9yntZwYO1fKfobatw2GlYtsFFcSI
	YIKiQVfRuKb7UpYwlcGTN5kPnnE2GH8X9gQw1u039rWJyHpW3peKu+aEwPJp+byzkC4kSDQSROx
	hPsUJa1Kbsfw7GqXxXWetfiN8rRAI01g64Aj65eAo0QsSRw5HebuuCUvooPjf+3V7PXgiiOVkoi
	Mc54dQrySUWvdwyhtJ0D6pjZJ28yZzlzh+1s7QMC0QVu30kQqQ8N6FBPjVDBau82GsSv3ZyEyea
	1TChVhLNLDEQ==
X-Google-Smtp-Source: AGHT+IG8MPLs1qrZR256g1yVGjEve1aePQI2yiy3sIO7Ehk1lRgqgFIz7r7MQW1cSu+i/lCdhODwrA==
X-Received: by 2002:a05:6000:200f:b0:426:fff3:5d1a with SMTP id ffacd0b85a97d-4284e557389mr8886837f8f.6.1761544442058;
        Sun, 26 Oct 2025 22:54:02 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012899sm6842506b3a.0.2025.10.26.22.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 22:54:01 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:53:59 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, ocfs2-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ocfs2: use correct endian in ocfs2_dinode_has_extents
Message-ID: <yftcjac4lb3j6pkszvd5mvb2myqbfs3k72ey6nj4wgyv3lc2z2@6fny5k356udd>
References: <20251025123218.3997866-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025123218.3997866-1-joseph.qi@linux.alibaba.com>

On Sat, Oct 25, 2025 at 08:32:17PM +0800, Joseph Qi wrote:
> Fields in ocfs2_dinode is little endian, covert to host endian when
> checking those contents.
> 
> Fixes: fdbb6cd96ed5 ("ocfs2: correct l_next_free_rec in online check")
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> ---
>  fs/ocfs2/inode.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index fcc89856ab95..0a0a96054bfe 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -201,13 +201,15 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
>  static int ocfs2_dinode_has_extents(struct ocfs2_dinode *di)
>  {
>  	/* inodes flagged with other stuff in id2 */
> -	if (di->i_flags & (OCFS2_SUPER_BLOCK_FL | OCFS2_LOCAL_ALLOC_FL |
> -			   OCFS2_CHAIN_FL | OCFS2_DEALLOC_FL))
> +	if (le32_to_cpu(di->i_flags) &
> +	    (OCFS2_SUPER_BLOCK_FL | OCFS2_LOCAL_ALLOC_FL | OCFS2_CHAIN_FL |
> +	     OCFS2_DEALLOC_FL))
>  		return 0;
>  	/* i_flags doesn't indicate when id2 is a fast symlink */
> -	if (S_ISLNK(di->i_mode) && di->i_size && di->i_clusters == 0)
> +	if (S_ISLNK(le16_to_cpu(di->i_mode)) && le64_to_cpu(di->i_size) &&
> +	    !le32_to_cpu(di->i_clusters))
>  		return 0;
> -	if (di->i_dyn_features & OCFS2_INLINE_DATA_FL)
> +	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL)
>  		return 0;
>  
>  	return 1;
> -- 
> 2.39.3
> 

