Return-Path: <linux-kernel+bounces-796409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1147EB4007A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64B25E582B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57062F5484;
	Tue,  2 Sep 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bOGDraZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A4283FF1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815619; cv=none; b=qgEbXeE79hxfmS2psC5GcZW3Myc9JjiaJV17F4u8FxWUMNHYS3WLlm8iR7JLuPsPrHFKeEyJaI6wvNJLUy2pBRoXfEd9w61xBiUxMnGF47JUltqIF2yXCEPavkWfwD65dcgGdXw7svfWFF5dmduWAoeEAt/zAt8JKD2jX85R8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815619; c=relaxed/simple;
	bh=w1sPfj70OZMyCNthCSh4tLSSVvSVVQfwa3PIpM97PRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkJroGQmFvGWmqJr9s68PaWS23ImBHV3G7lmGC+CfsOcWr/e9+H8msAd0XwGmlc4sIQYhOtOb671Sp/j2SAlcVUSszUqCJcTk5NKDwrrlTF2u1yy1HbeZTQexmJtqwnEuCJ2BGel3rsv44nw3PECR46BHxDRUuNH9dA1T4KMZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bOGDraZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1471FC4CEED;
	Tue,  2 Sep 2025 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756815617;
	bh=w1sPfj70OZMyCNthCSh4tLSSVvSVVQfwa3PIpM97PRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOGDraZdGpH451WUrWLJGmEnX8DO9O82d5lyl8V7NuhR/Od49FaKruw8LUmefNCk3
	 ZuTg+9F/1dxvjx9jtrurhRxAg9oeR4QFywUlQdw7yhmDod8k3QhKc7RZeFVZcRs/ul
	 EGjFDhvVe8j+VZkl9mGXCW0d8R0ObPxikEeA4z+k=
Date: Tue, 2 Sep 2025 14:20:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH] driver core: auxiliary bus: Optimize auxiliary_match_id()
Message-ID: <2025090222-darn-tweet-739c@gregkh>
References: <20250902-fix_auxbus-v1-1-9ba6d8aff027@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-fix_auxbus-v1-1-9ba6d8aff027@oss.qualcomm.com>

On Tue, Sep 02, 2025 at 08:05:32PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> Variable @match_size is fixed in auxiliary_match_id().
> 
> Optimize the function by moving the logic calculating the variable
> out of the for loop.

Optimize it how?  Does this actually result in a difference somehow, if
so, what?

Please be specific.

> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/base/auxiliary.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 12ffdd8437567f282374bbf3775d9de7ca0dc4c7..9a53ada043045031e565ade57fd7ba781e7d20ea 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -171,14 +171,14 @@
>  static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
>  							    const struct auxiliary_device *auxdev)
>  {
> -	for (; id->name[0]; id++) {
> -		const char *p = strrchr(dev_name(&auxdev->dev), '.');
> -		int match_size;
> +	const char *p = strrchr(dev_name(&auxdev->dev), '.');
> +	int match_size;
>  
> -		if (!p)
> -			continue;
> -		match_size = p - dev_name(&auxdev->dev);
> +	if (!p)
> +		return NULL;
> +	match_size = p - dev_name(&auxdev->dev);
>  
> +	for (; id->name[0]; id++) {
>  		/* use dev_name(&auxdev->dev) prefix before last '.' char to match to */
>  		if (strlen(id->name) == match_size &&
>  		    !strncmp(dev_name(&auxdev->dev), id->name, match_size))
> 

thanks,

greg k-h

