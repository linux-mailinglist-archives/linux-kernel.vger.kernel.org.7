Return-Path: <linux-kernel+bounces-870871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF51C0BE07
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BBCC4EE8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339A2D7D42;
	Mon, 27 Oct 2025 05:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M3oTfQqC"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179742D739D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544503; cv=none; b=Dr+J5JS7ukIQqcCWvBkNMKcon5r1hNZJbVW/IMXxJ36Md0PhY+RPA3/ZJ42EFFUGDVaKn7dOSlXeg6w9UOO2a9+M0+RGOVDaDEaKSODrbT7fTU1/m3tOIqjo/l5XICfI6LzhjkfX1Muc0BvZtnQAimSnVkU0N8FjF9iwm3T8k8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544503; c=relaxed/simple;
	bh=PB8WecR2U1B+Hxs9rgzKpR8yvRUOHT8PkEQpI7oryDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYAimj3OkVjcEVYSbGSAtMs55CmnN3BH+x6cJACcOaUBQcNrQqzy/b+7x1oALZby8ZJEVp0KcJ2iFU+vOAj+UZGHRgJuA9pijryWoV2RQGiA+qX9B4wjxCj1YK+RHop2oGXUOiUsJSItzDdwPs5Lvk9qLYU1hNyAB0ncFpAc3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M3oTfQqC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42844985499so534574f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761544499; x=1762149299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yq4vwZctVyt51YfNqUdUcSX+iGUldMtiGd+UYdT9hA=;
        b=M3oTfQqCqe2xgcMW+UUorucOs3lZKxZyUTMMxBfiQs3+02EaAsJXltvf/UC9owpWyH
         /EiQMh2NbhoDiSTVn6ebisSxumABkdpqLxbzfbu5kr+8VnSbaYrPFpFSAxcg9ZtRmHc+
         YLYw9zXk9HcFiK90c8vHgnXRlTgGLDmcz3MIwlbUxjvXoEb9BoNE40bZhDTon8723Lty
         9hyM8PC0fRxtwSye+3LL7KllTTj+KWAInSXdCBUNhB28r9G2GoI/0KewCz8s+bgGRjR8
         OSwAshAY92fsEofiWhzPAU+wvgtUSNVdP4XYNZsMJOXE5YhU5xWPhl2hpOK3qPYQmx9z
         39xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761544499; x=1762149299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yq4vwZctVyt51YfNqUdUcSX+iGUldMtiGd+UYdT9hA=;
        b=iQHY364jU5bmT0MoMAbo7b4CLkAxoWimiAm6mCOrwKl8RlFSTEvzmBSLpe78HkJUnE
         Sm3soHgTYEuMDXJiN/8MCZgLNr9ID6Qva4pLWQQRV3mZC8E2zi3Y7mcdusW9U00g77Mh
         Xu1/xIa25d6pYOc9lIJsXW45JAIsU7BAVVjDcxfGfKWvUxLWcpDzzD4QnDNy0ukMs3fI
         vNjCAXgA3sdJd9m+fMc2nKTK23Uu11Fq+pCiZqVoqMNhyOsSkQiFpfDNoYFsaEZFL5sY
         DGFnEAz7tYParvfshu62fHALAcZRmL92SaPJDTeek8api9nZllIHODXl7tAZnC4Zoz5j
         w8ow==
X-Forwarded-Encrypted: i=1; AJvYcCV36YIWVnDIVSFULwfJEvQKrU6DI3FiI3M8Xo8q8eKgZtQMWyaDqPPSE4gPUKsRW+U9ezeAcykfQZsVY+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvt7pJysJDmMQosEkNXK4PdA+r+9SPCh3HrEVHgqeYYQupKBb
	/O2qpLMNro+AX46IctwIH3ctYzDp8NLsyOpu+Njjj1CVylJSPfH2m1TiMdm7vsM3GcEpvQXfO9F
	q/9IQ
X-Gm-Gg: ASbGncu5rKnLpvAAuH5DFG9aJxOA0OT8110iVEqmXWETKWcTabd4be++3B37ex02HPF
	qyS+MP6fAPI2HHkLy1EVNTuLZfBd7ZjZ4fgtGw4Btltj5CRFjsGWIniNGDBhvq+Mw96C5oToqyw
	XyuOqiGSiihjLAr3wVJCmrBLea5/mx5cW0Y9pXeQsY7dNGuU3+3nyu8RfDGey+ZxFEQKYWziyBw
	exzhHH1AZVZTuTmqWnBqsk64XkUFaHASm4wKbbAZbvtt6BBvpNMxCsf1IQVQg23v9RDtfcxmPOD
	pl9a1gwKkdFT0X5aO7d8KgGaPF09AJvS47jjJZ2emgjx6KhsN4w9gMG4nWuJRFkB/GprMXyR8kz
	KHxKBeYDrBQmS9NV7BvCp87lJFyuCf2VTs1TKd9+gbl/hh483ca1xCi2K6oErr3VJyyLO78vs/Z
	3kvc7pDR70pQ==
X-Google-Smtp-Source: AGHT+IHb6LEjAqeuzjsWCQ23HOGwypxJZ0QLL76KYcBnRCofwqhTksYZD99UW2uKcwX0zR8fOmjHuw==
X-Received: by 2002:a05:600c:1c06:b0:475:decc:2a0b with SMTP id 5b1f17b1804b1-475decc2de2mr32669325e9.3.1761544499349;
        Sun, 26 Oct 2025 22:54:59 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bf4sm6871227b3a.1.2025.10.26.22.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 22:54:58 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:54:56 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, ocfs2-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ocfs2: convert to host endian in
 ocfs2_validate_inode_block
Message-ID: <honfnctqux4wuiv4dzjzwklavw2uxqyonyyvo3wgb7bzhrseik@bn6ehubxfiuw>
References: <20251025123218.3997866-1-joseph.qi@linux.alibaba.com>
 <20251025123218.3997866-2-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025123218.3997866-2-joseph.qi@linux.alibaba.com>

On Sat, Oct 25, 2025 at 08:32:18PM +0800, Joseph Qi wrote:
> Convert to host endian when checking OCFS2_VALID_FL to keep consistent
> with other checks.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> ---
>  fs/ocfs2/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 0a0a96054bfe..dc4044a565b5 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1481,7 +1481,7 @@ int ocfs2_validate_inode_block(struct super_block *sb,
>  		goto bail;
>  	}
>  
> -	if (!(di->i_flags & cpu_to_le32(OCFS2_VALID_FL))) {
> +	if (!(le32_to_cpu(di->i_flags) & OCFS2_VALID_FL)) {
>  		rc = ocfs2_error(sb,
>  				 "Invalid dinode #%llu: OCFS2_VALID_FL not set\n",
>  				 (unsigned long long)bh->b_blocknr);
> -- 
> 2.39.3
> 

