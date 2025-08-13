Return-Path: <linux-kernel+bounces-766840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B80B24BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714561BC0D10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18312ECEAE;
	Wed, 13 Aug 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ubujwUqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3992EACE0;
	Wed, 13 Aug 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095066; cv=none; b=sIQxeNWjE7+iCtTmZTzhFdrB3ACL8mNrniXbehZ8dUzfXxsKfyXtrw9YHc1Cq3dGxvnFOfIl/0c8qgw9lNXfKO1t++e3tW4L6s/F8Ketu+5JdhabTdh/geqvnbeZs7xP5QHhdKJy3mc7TDSwS0xWxJ92kp6FJLKrF3GiVwyf3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095066; c=relaxed/simple;
	bh=EL8zuATq/vTVaRGjgFWkxH0/nSk/CrCXQFtz7NVjENg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL2xzl57WKoBXHBnonHOIhdDd37TYnsHdAFHGg2LG/qzK+583r6bcC7skhjntwOdhhQaDKI6NgHeWxxRjVGppz2xW4o54UZm3cDLXoHIg1RXOqJPJmhYoAhJAupWGzDaN5kc5lWegIyD1sYX3dwi/OIyn8cW7uTlmxhFEE6BvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ubujwUqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48848C4CEEB;
	Wed, 13 Aug 2025 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755095065;
	bh=EL8zuATq/vTVaRGjgFWkxH0/nSk/CrCXQFtz7NVjENg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubujwUqHZHWgb5jPFmRXo7dIHOvLiUtZ+gax1NHSFT5h7wazOapqfbHllgs+jliTL
	 /DvZqsZ8qhIh0z3/Qc/5GE8X0DFQzcajqVQWFB1dG6HaxfmhPKafJMKIMTZOVWfM32
	 rIsFTWmyBSl3bTujQcrkvMntL7FPVZjMKGzTaQcI=
Date: Wed, 13 Aug 2025 16:24:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: most: video: improve arguments to copy_to_user()
Message-ID: <2025081323-paralyses-monetary-89f0@gregkh>
References: <aJx6OF6L2Nza9zQ0@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJx6OF6L2Nza9zQ0@bhairav-test.ee.iitb.ac.in>

On Wed, Aug 13, 2025 at 05:12:48PM +0530, Akhilesh Patil wrote:
> Define cnt constant as unsigned long as expected by copy_to_user()
> to avoid implicit type conversion. Define rem constant as unsigned long
> to compare it with the same type size_t of count variable.
> Use standard helper min() to carry out careful comparison to achive
> same functionality.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> This patch is motivated from coccinelle report which suggested to use
> kernel standard helper min(). During build check, I found that
> comparison max()  showing error while comparing variables of
> different types. Hence this patch also fixes that to make comparison of
> save types.
> 
> Compile tested only.
> ---
>  drivers/staging/most/video/video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index 2b3cdb1ce140..4b15c390c32d 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -172,8 +172,8 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
>  
>  	while (count > 0 && data_ready(mdev)) {
>  		struct mbo *const mbo = get_top_mbo(mdev);
> -		int const rem = mbo->processed_length - fh->offs;
> -		int const cnt = rem < count ? rem : count;
> +		unsigned long const rem = mbo->processed_length - fh->offs;

Why is this unsigned long now?  processed_length is a u16 and offs is a
u32.  So really this could have gone negative :(


> +		unsigned long const cnt = min(rem, count);

But count is size_t, so again, why unsigned long?

I understand the goal of using min(), but it feels like you just might
have broken something with the loss of the overflow check :(

thanks,

greg k-h

