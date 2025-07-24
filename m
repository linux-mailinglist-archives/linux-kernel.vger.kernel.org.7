Return-Path: <linux-kernel+bounces-744191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AEDB1094C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18B5164E34
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5113E2750F8;
	Thu, 24 Jul 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2sl/Wn2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B82750F6;
	Thu, 24 Jul 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356803; cv=none; b=iFPyhJsAcjBTrwTe82NxRfcRU5bPnv9iwqMcIVWj9QqWPX3iS8q1FVx90G9d8Ehy7xmnoWjjxzYUxxQ3Jay35idANRGSN0wfgkwF+LVEC+o6NBrbcJM7sK7q2ZhVi6O45zoAGh3bZ1IKadi8sMmsqVM1eRU8crCDGFK5/oyLrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356803; c=relaxed/simple;
	bh=lDnwCdX+NKqdtDDi8VUr93VKMdqOc/4K7u67AT/OKA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CllCenxGMidQ1I5yuKsSibVQVdsdcj7WMqmGwdW9uWvrdEsrucGk0V3rFjYW714yc+LdJr01RjYWpdwVTmAU7Q/O+Pv9uaQCQ+csTubKPERNNwQ/UNXVU+ZblS/ZRWyOCYFvsDqUsV90B1u39EMNolfkRMOrZwffh3COtHcsX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2sl/Wn2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7796C4CEED;
	Thu, 24 Jul 2025 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753356803;
	bh=lDnwCdX+NKqdtDDi8VUr93VKMdqOc/4K7u67AT/OKA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2sl/Wn2clmFwIsufObEG+et9w3xv5LRoa1hTQn3J12vJayjBFBT3eCMkG2phiZKqh
	 8wtoCyQYfbEcs87qCIKwqYC6GGnIiGqCzHB/NbhRZUDga76m2VheLAKsYDxr8GJCwq
	 l1LH0rLpovyOGzeb7/zmr7RCwfcJbqmzqSAJ/LTU=
Date: Thu, 24 Jul 2025 13:33:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: samiksha.palav27@gmail.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Add hardware acceleration for 16bpp
 imageblit
Message-ID: <2025072451-spokesman-chevron-5b88@gregkh>
References: <20250724105254.3926-2-samiksha.palav27@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724105254.3926-2-samiksha.palav27@gmail.com>

On Thu, Jul 24, 2025 at 04:22:08PM +0530, samiksha.palav27@gmail.com wrote:
> From: shdwcodr <samiksha.palav27@gmail.com>
> 
> This is my first kernel patch, as mentioned in my kernel introduction.
> I'm starting out with drivers/staging, and this patch targets the
> sm750fb driver.
> 
> Previously, all image depths other than 1 fell back to cfb_imageblit().
> This patch adds support for hardware-accelerated blitting for 16bpp
> images using sm750_hw_imageblit().
> 
> The fallback path for other depths remains unchanged, with a TODO
> comment in place for future enhancements.
> 
> Signed-off-by: shdwcodr <samiksha.palav27@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 53 +++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 1d929aca399c..e65b747fbfd0 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -121,12 +121,12 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
>  		sm750_hw_cursor_set_size(cursor,
> -					fbcursor->image.width,
> +					 fbcursor->image.width,
>  					fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)
>  		sm750_hw_cursor_set_pos(cursor,
> -				       fbcursor->image.dx - info->var.xoffset,
> +					fbcursor->image.dx - info->var.xoffset,
>  				       fbcursor->image.dy - info->var.yoffset);
>  
>  	if (fbcursor->set & FB_CUR_SETCMAP) {
> @@ -249,10 +249,51 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
>  	pitch = info->fix.line_length;
>  	Bpp = info->var.bits_per_pixel >> 3;
>  
> -	/* TODO: Implement hardware acceleration for image->depth > 1 */
> -	if (image->depth != 1) {
> -		cfb_imageblit(info, image);
> -		return;
> +	static void write_pixel(struct fb_info *info, int x, int y, u32 color)
> +
> +	{
> +		u32 location;
> +		u8 *fb_ptr = (u8 *)info->screen_base;
> +
> +		location = (y * info->fix.line_length) + (x * (info->var.bits_per_pixel / 8));
> +
> +		if (info->var.bits_per_pixel == 16) {
> +			u16 c = ((color >> 8) & 0xF800) |
> +				((color >> 5) & 0x07E0) |
> +				((color >> 3) & 0x001F); // Convert 24-bit RGB to RGB565
> +			*((u16 *)(fb_ptr + location)) = c;
> +		} else if (info->var.bits_per_pixel == 32) {
> +			*((u32 *)(fb_ptr + location)) = color;
> +		}
> +	}
> +
> +	void sm750fb_imageblit(struct fb_info *info, const struct fb_image *image)
> +
> +	{
> +		/*
> +		 * TODO: Add hardware-accelerated support for more image depths
> +		 * Currently only 16-bit (RGB565) images are handled in fast path.
> +		 */
> +		if (image->depth != 16) {
> +			cfb_imageblit(info, image);
> +			return;
> +		}
> +
> +		/* Accelerated rendering for 16-bit (RGB565) images */
> +		const u16 *src = (const u16 *)image->data;
> +
> +		u32 fg_color = ((image->fg_color & 0xF800) << 8) |
> +			       ((image->fg_color & 0x07E0) << 5) |
> +			       ((image->fg_color & 0x001F) << 3); // RGB565 → RGB888
> +
> +		for (int j = 0; j < image->height; j++) {
> +			for (int i = 0; i < image->width; i++) {
> +				u16 pixel = src[j * image->width + i];
> +
> +				if (pixel) // Draw only non-zero (foreground) pixels
> +					write_pixel(info, image->dx + i, image->dy + j, fg_color);
> +			}
> +		}
>  	}
>  
>  	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
> -- 
> 2.43.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

