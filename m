Return-Path: <linux-kernel+bounces-762497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A48B2078C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EDE18C26C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE32D1916;
	Mon, 11 Aug 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gd4s835o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10182D131A;
	Mon, 11 Aug 2025 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911497; cv=none; b=R1O7rMHZMbVHgQncM0NUEWCx5Cbg1WUzaFyvq0l9pLpeokod4ZTxHFWqxPSEODLRLlGKj0GFeIwpYA/iwPfv3Z0/rwjsuBIEWHLVbGWgc7cHX9165LCxhwxcgmRAixnMIFaPmztHInfUQX7AHRlTFz6qPKgiXUKkC4tw16T19z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911497; c=relaxed/simple;
	bh=z6aR+7JuU8jZhZ8v97qaGdr7z50WI/qLLgahBL/4SLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9345Y7EV6DCHAC8MmU+5tCLtcLeOd+pJ/q4a64BNR9Sx7b8Bp8sGdp58YYgv2++YXtThGdi42EaWJhFXuPRhNpyq6/hHn1GBl3yt10d0cw7kskDXyVIuoMQPTEtJBsgJlLQqLK5WQJ8YpThE6W9WEi5N/gRLiFgrtrQCcXSK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gd4s835o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1FFC4CEED;
	Mon, 11 Aug 2025 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754911497;
	bh=z6aR+7JuU8jZhZ8v97qaGdr7z50WI/qLLgahBL/4SLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gd4s835oHyxyQvX/dUDrcmTS85c926LAUjejEMEhq4ozbtd6ncd8Loj5veOwY9qXz
	 u3mjVohujZRhBFt3C0hIdhuSeG8GJkh/StRb/Mm+lkFnZ96R1NbUIRrc2shWqdS9vN
	 pY5KYA8PRsoU6CgafCW1wFElWUwJTPik3kU6IE+o=
Date: Mon, 11 Aug 2025 13:24:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liuqiqi@kylinos.cn
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: mm:fix duplicate accounting of free pages in
 should_reclaim_retry()
Message-ID: <2025081110-bacon-recreate-df6f@gregkh>
References: <2025011510-CVE-2024-57884-4cf8@gregkh>
 <20250811095330.1573939-1-liuqiqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811095330.1573939-1-liuqiqi@kylinos.cn>

On Mon, Aug 11, 2025 at 05:53:30PM +0800, liuqiqi@kylinos.cn wrote:
> In the zone_reclaimable_pages() function, if the page counts for NR_ZONE_INACTIVE_FILE, 
> NR_ZONE_ACTIVE_FILE, NR_ZONE_INACTIVE_ANON, and NR_ZONE_ACTIVE_ANON are all zero, 
> the function returns the number of free pages as the result.
> 
> In this case, when should_reclaim_retry() calculates reclaimable pages, 
> it will inadvertently double-count the free pages in its accounting.
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 34410d24dc15..a9aaefdba7a2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -393,14 +393,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>         if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
>                 nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>                         zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
> -       /*
> -        * If there are no reclaimable file-backed or anonymous pages,
> -        * ensure zones with sufficient free pages are not skipped.
> -        * This prevents zones like DMA32 from being ignored in reclaim
> -        * scenarios where they can still help alleviate memory pressure.
> -        */
> -       if (nr == 0)
> -               nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
> +
>         return nr;
>  }
>  
> @@ -6417,7 +6410,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
>                 return true;
>  
>         for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {
> -               if (!zone_reclaimable_pages(zone))
> +               if (!zone_reclaimable_pages(zone) && zone_page_state_snapshot(zone, NR_FREE_PAGES))
>                         continue;
>  
> signed-off-by: liuqiqi <liuqiqi@kylinos.cn>
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not submit this patch to the proper subsystem and maintainers.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

