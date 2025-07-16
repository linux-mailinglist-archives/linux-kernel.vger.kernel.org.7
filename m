Return-Path: <linux-kernel+bounces-732843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A59B06CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5317B5A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245B26E6E8;
	Wed, 16 Jul 2025 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1LjPRapp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3291448D5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641584; cv=none; b=Hi+O3HuGrAa8hCmLcmycHlP5dEvvn37U8OGtA9SeWEgztwqHbcLQF3J+aOAoyIzVoseeVtvSZNCmEJeioZrsf7st/dGl35GQGSO63atd2kiQQUdaEaKAccO23LOzl7GXjTG47fCL0Kd814liY54a8KsFkTYcphs/h9mot1R0/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641584; c=relaxed/simple;
	bh=vTNXN5mG6MauTAyu4fRoFDBWOdAyPEEWCGvO2hSd+R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg7Iksmwr/FLHJUbcjMn+sfF3Rp9lHk7SYHGhkxt42N2bjyQsVRQEZEFUd5fOtt41ZiPfuQp/fR00Qsp2wfSq7msKy2ZA6aQ3fDpTNqiPnm1pGtGhuZNV5ejX2rMiJC3d1DnHLg6TrdNXkqCBjQ7F3E7Gr+9OWUAfYeQLjGre/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1LjPRapp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B39AC4CEF0;
	Wed, 16 Jul 2025 04:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752641583;
	bh=vTNXN5mG6MauTAyu4fRoFDBWOdAyPEEWCGvO2hSd+R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1LjPRapp7/dSeFilF7dF2deUmVaZDZlBjx2+e209Ue7QjK6td6krV3OmOXqjf0fMn
	 jAEF6iFoAgRu6u0M9KP6IX0r84KZjEgiRHxLKtFrKRo0wESdhe2XK3xYQKBTrmOCha
	 4woA3FfIE8/1DAaIh/+NNuqnv89uC8dO4JJbL6Gk=
Date: Wed, 16 Jul 2025 06:53:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Meng Shao Liu <sau525@gmail.com>
Cc: linux-kernel@vger.kernel.org, visitorckw@gmail.com
Subject: Re: [PATCH 1/2] samples/kobject: fix path comment
Message-ID: <2025071648-atonable-antihero-2df2@gregkh>
References: <5be61d284a1850f573658f1c105f0b6062e41332.1752634732.git.sau525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be61d284a1850f573658f1c105f0b6062e41332.1752634732.git.sau525@gmail.com>

On Wed, Jul 16, 2025 at 11:07:33AM +0800, Meng Shao Liu wrote:
> The introductory comment still says the example creates
> /sys/kernel/kobject-example, but the code actually creates
> /sys/kernel/kobject_example.
> 
> Update both comments to reflect the actual sysfs paths. Also,
> fix "tree"->"three" typo in kset-example.c.
> 
> Signed-off-by: Meng Shao Liu <sau525@gmail.com>
> ---
>  samples/kobject/kobject-example.c | 2 +-
>  samples/kobject/kset-example.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
> index c9c3db197..e6d7fc18e 100644
> --- a/samples/kobject/kobject-example.c
> +++ b/samples/kobject/kobject-example.c
> @@ -13,7 +13,7 @@
>  
>  /*
>   * This module shows how to create a simple subdirectory in sysfs called
> - * /sys/kernel/kobject-example  In that directory, 3 files are created:
> + * /sys/kernel/kobject_example  In that directory, 3 files are created:
>   * "foo", "baz", and "bar".  If an integer is written to these files, it can be
>   * later read out of it.
>   */
> diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
> index 552d7e363..579ce1502 100644
> --- a/samples/kobject/kset-example.c
> +++ b/samples/kobject/kset-example.c
> @@ -14,8 +14,8 @@
>  
>  /*
>   * This module shows how to create a kset in sysfs called
> - * /sys/kernel/kset-example
> - * Then tree kobjects are created and assigned to this kset, "foo", "baz",
> + * /sys/kernel/kset_example
> + * Then three kobjects are created and assigned to this kset, "foo", "baz",
>   * and "bar".  In those kobjects, attributes of the same name are also
>   * created and if an integer is written to these files, it can be later
>   * read out of it.
> -- 
> 2.43.0
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

