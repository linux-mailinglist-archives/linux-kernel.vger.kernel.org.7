Return-Path: <linux-kernel+bounces-791019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88497B3B12E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D3CA022F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9021E0AF;
	Fri, 29 Aug 2025 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeW6ifDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BE1A58D;
	Fri, 29 Aug 2025 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435920; cv=none; b=HbgANsIaWad30fgHV+R2A0bHGrzeQaCKDG7Esm+Hqol0PkduGSkimKwbZlwr49LQi+sNLk9wUKGnVOHjtHjmjo+zJlAQeP5FTPh01TTiFarHU4hste0ZSi5Stb9CHcYjwjdTpJpNmbXq0sKoRVfigL0hOldCtH8pRtD0E0Q8tGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435920; c=relaxed/simple;
	bh=1Jif1ziL73F88a8XuYzpyb1G5ZPVF7MdjBrOhu0rLFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZhD5S3G4l4VwbIQuHbQZ0si8TrHGNhveD8MdzG5RuZF8TRXshXsyyXRDToEwcc1ZfvLn8UHQmUVOXs09GDsTVPSf+H8Zp+ECD82KhnIAbV4YHSoQdg2awsrQp0c1YFqkeLqh8KDglxIWOmaWPtfv7ORw41PY+CGnlRZrEI/0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeW6ifDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893FEC4CEEB;
	Fri, 29 Aug 2025 02:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756435920;
	bh=1Jif1ziL73F88a8XuYzpyb1G5ZPVF7MdjBrOhu0rLFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeW6ifDR+NO8PTcUuURRFW8uolWO4lAUUtTdPbN/Ae7ReIyZqY6toN1DSnCazhDVB
	 hEEIjzCJgBHuuiP5Un8xMHSCmk1VD8A3R/o5brXDCkhpNr70OvN4WBSwdsuEOGsWN8
	 /wa3MW/1c/qWSBopKss+CXgNuH7r5po+uyLin/V0ZlPRiSTuAgBUErYIvzWk3wEq7l
	 kGD0EB6wCk9CkwmLHZ1cERNtq1UTBz1ZC/bjrxBzqhREsZ13dBejXJUjk765AR/iDz
	 V1aVJXczCGQIg7QiFOicLQV5YjzgmBdNYDlFhUYAWelqJniti/3unbCN3OLjbpT2zT
	 3aJgDNPyFTCtA==
Date: Fri, 29 Aug 2025 10:51:52 +0800
From: Coly Li <colyli@kernel.org>
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Cc: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcache: fixed the issue of low rate at the tail end of
 dirty data writeback
Message-ID: <dwxgw72rv3tehln3yj3f66wg3gl664obbxkvmirh7l5bbw4sgq@62mtjzuxftdi>
References: <20250813032343.18472-1-zhoujifeng@kylinos.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813032343.18472-1-zhoujifeng@kylinos.com.cn>

On Wed, Aug 13, 2025 at 11:23:43AM +0800, Zhou Jifeng wrote:
> When c->gc_stats.in_use > BCH_WRITEBACK_FRAGMENT_THRESHOLD_LOW, since the
> dirty_buckets will not decrease before the GC is triggered, while the
> number of dirty sectors waiting for write-back will continuously decrease
> , the fps = dirty / dirty_buckets * fp_term gradually approaches 0.
> Eventually, when dirty < dirty_buckets, the writeback rate drops to the
> lowest level. The larger the cache space is, the higher the dirty value
> will be when the write-back speed of dirty data drops to 4k/s. This is
> inconsistent with our expectations.
> 
> This solution is to set the dirty data write-back speed limit to the
> maximum value when c->gc_stats.in_use is high and dirty < dirty_buckets,
> so that only a small amount of dirty data can be quickly written back.
> 
> Signed-off-by: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
> ---
>  drivers/md/bcache/writeback.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> index 453efbbdc8ee..9fc00fe11201 100644
> --- a/drivers/md/bcache/writeback.c
> +++ b/drivers/md/bcache/writeback.c
> @@ -121,6 +121,13 @@ static void __update_writeback_rate(struct cached_dev *dc)
>  		}
>  		fps = div_s64(dirty, dirty_buckets) * fp_term;
>  		if (fragment > 3 && fps > proportional_scaled) {
> +			/*
> +			 * When there is only a small amount of dirty data, complete the
> +			 * write-back operation as quickly as possible.
> +			 */
> +			if (fps == 0)
> +				fps = INT_MAX;
> +

This will cause int overflow when calculating new_rate.

I agree with your motivation, and this is a bug which should be fixed.
Let me think how to fix it in a more clear and understoodable way.

Thanks.

Coly Li


>  			/* Only overrite the p when fragment > 3 */
>  			proportional_scaled = fps;
>  		}
> -- 
> 2.18.1
> 
> 

