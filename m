Return-Path: <linux-kernel+bounces-816384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D512B57322
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D844F161C76
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34AC7261C;
	Mon, 15 Sep 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyNQjpDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6852765D4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925419; cv=none; b=JHKatZv6vAAHIDXV01FHywJfM3zOLBfrcK0AAAttEfbqigreA36VxbIAyEn7XsY4PR2W+0LZEU756+fID/ULuyUMPDG9569MgAkyl/75y0xx1K8IQZfDvyqmgwiKALIAzC6vE3MuK9gTRkKcueAvQNdxQjRgxS0lY4iWsm7DVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925419; c=relaxed/simple;
	bh=eOv6Qte1h1FSP1weoRfTb6/mca0YwiPhewjYEEdYcls=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iNW9Tux4B0My95co0s6hEr9OURrqNGgXnbH94ptWyFGI6TS2dQpfk/h5lCXKcX5LLGCXuQT6L8B013xeEGo9FJFtpycukEs7/uzJL9Yl+Tu6A6kk4Yk+/rIMGVUjYAZAM6OUVrbS0VOWjGkW6B9eauZJ0DTiX0zRNNty3Xpt4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyNQjpDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5CDC4CEF1;
	Mon, 15 Sep 2025 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757925418;
	bh=eOv6Qte1h1FSP1weoRfTb6/mca0YwiPhewjYEEdYcls=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uyNQjpDaZAjBRTfWzbtea+LlLRj0q+62H+UtSCTQ4zK8W6tLwjqAgLwyQilKlY8o6
	 tsitEWn+95/ikWEM3Kay6zhapCIretaGsKQs0TJ90vz6zPbjipcj8hCFrYDeSWjeMf
	 ZisGMFOtFW9eGvg3lriVRWgngoso1NIYrL/p+0ew23mqCbuJTShK87vH+i5nXRq2/f
	 sO06ifxp3yTyNy8EM8EHG8hJE5xfvrOlYtkcbkSyRcTDuLzM718YL84p1JPEHyvSW9
	 yxQ0jimrYoTm/BI2ZerhbcWucAj224pjtysR3okPIx2MZBMpmOnGOnFW4aOpKq75fJ
	 hdcmXFoxfDTWA==
Message-ID: <b42b161d-cd5d-45dc-8e84-c2b28eb632e5@kernel.org>
Date: Mon, 15 Sep 2025 16:36:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH 2/2] f2fs: Enhance the subsequent logic of
 valid_thresh_ratio to prevent unnecessary background GC
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
 <20250909134418.502922-3-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250909134418.502922-3-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 21:44, Liao Yuanhong wrote:
> When the proportion of dirty segments within a section exceeds the
> valid_thresh_ratio, the gc_cost of that section is set to UINT_MAX,
> indicating that these sections should not be released. However, if all
> section costs within the scanning range of get_victim() are UINT_MAX,
> background GC will still occur. Add a condition to prevent this situation.

For this case, f2fs_get_victim() will return 0, and f2fs_gc() will use unchanged
segno for GC?

Thanks,

> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  fs/f2fs/gc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4a8c08f970e3..ffc3188416f4 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -936,6 +936,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>  		}
>  	}
>  
> +	if (f2fs_sb_has_blkzoned(sbi) && p.min_cost == UINT_MAX) {
> +		ret = -ENODATA;
> +		goto out;
> +	}
> +
>  	/* get victim for GC_AT/AT_SSR */
>  	if (is_atgc) {
>  		lookup_victim_by_age(sbi, &p);


