Return-Path: <linux-kernel+bounces-779017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F65B2EDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FEE5C696A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACF2D481D;
	Thu, 21 Aug 2025 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTzEDAuS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590102BE650
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756749; cv=none; b=j3geU1N6CDMW7VGb5um7qHMbA99Ovv6SmnViU/jjBK8fLhgISGSjZvct0XGNFNOndt4jh5oc1JObFO6gYJlgZDFd7bjaMkMI9cqmrHGj6xFXMO0rOGHHc589PKVzxCrJX373aYj2SRqxWVxOsyhb/O4cZnB6schhrz+W+EoswrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756749; c=relaxed/simple;
	bh=crfZgghiSU/uO6D9y+ZWXGgC49OVn31zOIZJtYoqshA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTPXqNF2YZzCXTwIrmcc29srkPNxRFYsk11B0YqsFHH27eYEdZwcE68fw3qYIvO2eiCT9qOVkGnegZ9/uiaGIBwPP0u5OAQLB0BmyvzedaPBya/r+j/M3kvmQ5CA8L9rOkHlORb0U/K2xMLHHBLQvNdp6zzIfCdEumOrREkMfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sTzEDAuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB62C4CEED;
	Thu, 21 Aug 2025 06:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755756749;
	bh=crfZgghiSU/uO6D9y+ZWXGgC49OVn31zOIZJtYoqshA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTzEDAuS4uk3f42FXBxoe4+Ds2hVg8wLuhYR+/X9NgoEkUwwbLAD0YIrJldRfnSQm
	 FriX0dKXz2nYIt0Mt8w+oklJH6BcnaPhnTExdE0IgSASVmi0wXwnyTzRYhPftluYY7
	 EccYHJreyfiXQ3FK6RKqa15ePo/KIUrKAHcjjxjs=
Date: Thu, 21 Aug 2025 08:12:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zsolt Kajtar <soci@c64.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: monochrome mode with 512 glyphs
Message-ID: <2025082128-appraisal-wince-844f@gregkh>
References: <20250821035533.8206-1-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821035533.8206-1-soci@c64.rulez.org>

On Thu, Aug 21, 2025 at 05:55:33AM +0200, Zsolt Kajtar wrote:
> In monochrome mode the lowest 2 bits of the attribute are used for the
> intensity. If a 512 glyph font is loaded the lowest attribute bit is
> used for the MSB.
> 
> The result is that with normal intensity (1) the MSB of the glyph can
> be set.
> 
> Due to this on my setup the erase character becomes 0x120 instead of
> 0x20. As 0x120 is allocated to U+0161 in the loaded font the erased area
> will be filled with "s" instead of spaces.
> 
> To make the 512 glyph case work in monochrome mode the intensity was cut
> down to one bit (bold only) in this patch.
> 
> Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>  drivers/tty/vt/vt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 62049ceb3..8eebb5f17 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -667,7 +667,7 @@ static u8 build_attr(struct vc_data *vc, u8 _color,
>  	{
>  	u8 a = _color;
>  	if (!vc->vc_can_do_color)
> -		return _intensity |
> +		return (_intensity & ~(vc->vc_hi_font_mask ? 1 : 0)) |

For some reason you didn't cc: all of the maintainers and the subsystem
mailing list for this code :(

Anyway, this is anything but obvious as to what is happening, can this
somehow be documented in the change to make it more clear?

thanks,

greg k-h

