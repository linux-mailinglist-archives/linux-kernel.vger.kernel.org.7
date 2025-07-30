Return-Path: <linux-kernel+bounces-750174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE3B1581F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D6C18A5E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B011D7E54;
	Wed, 30 Jul 2025 04:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pk+6pClk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79933154426
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849734; cv=none; b=nv6XHXyY946qb4Am7U8/J4kr89bs8rBkWpLFD70+VXcH2dnb8HAJEJnslviWylCqpWjZ1M2mEmZHlOeHeN834Gi4KCoa7k5UItZCNkM6zj3+CCfAL2Eew8A1Jp8KkK0dSFQC0hR5AVsJjzDjMVRtKvEruBRg1awKBjSWXGV9x5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849734; c=relaxed/simple;
	bh=drLoJbTRP+KNHfcwMqfWji3vrYtx7Ud+lktOzFvCha8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFRqN1oSDl0LxoPH2NGZ90sGPjZGBL4xPICODRaL2CKye6VNLLv8WCskJhaYZ9qoDAJTnN5uUc1XI+JxH6HKxtmxmzr0yapKtKN3VXroM0jJIb5rHKAizePLsI013JioPLG6YBWwE5aufEYK07jDjFvkfUYqzOprqYODq+S9RSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pk+6pClk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84163C4CEE7;
	Wed, 30 Jul 2025 04:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753849733;
	bh=drLoJbTRP+KNHfcwMqfWji3vrYtx7Ud+lktOzFvCha8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pk+6pClknZmS4mU1MOJ1z5hY/SwSk7PL3fG5Sfb4FCyLy1nTKMByt/hjWOY8muPBH
	 fPLoEVeclwMNmiWccdHkO7TjCBAyzwclglZVBcDGAKysxEYYQB0/KEiGhM8PfeZX3w
	 riQrOI3+5ZL/Vzt0Crtydp7JyomODS8/0UPV4W3o=
Date: Wed, 30 Jul 2025 06:28:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com
Subject: Re: [PATCH v2] /dev/zero: try to align PMD_SIZE for private mapping
Message-ID: <2025073039-confront-harmony-621d@gregkh>
References: <20250730022206.1349706-1-zhangqilong3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730022206.1349706-1-zhangqilong3@huawei.com>

On Wed, Jul 30, 2025 at 10:22:06AM +0800, Zhang Qilong wrote:
> If THP is enable, mapping /dev/zero with a size larger than 2MB could
> achieve performance gains by allocating aligned address. The mprot_tw4m
> in libMicro average execution time on arm64:
>   - Test case:        mprot_tw4m
>   - Before the patch:   22 us
>   - After the patch:    17 us
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/char/mem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..3699e716b84e 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -525,12 +525,20 @@ static unsigned long get_unmapped_area_zero(struct file *file,
>  		 * so as not to confuse shmem with our handle on "/dev/zero".
>  		 */
>  		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
>  	}
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	/*
> +	 * Attempt to map aligned to huge page size if possible, otherwise we
> +	 * fall back to system page size mappings in thp_get_unmapped_area.
> +	 */
> +	return thp_get_unmapped_area(file, addr, len, pgoff, flags);
> +#else
>  	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
>  	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
> +#endif
>  #else
>  	return -ENOSYS;
>  #endif
>  }
>  
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

