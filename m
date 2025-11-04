Return-Path: <linux-kernel+bounces-884954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF68C3190B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD31F4FC725
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB13331A70;
	Tue,  4 Nov 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu/DmIlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3059330B2B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266770; cv=none; b=GW4D/Y92ErdeD1/r93+zzPcjcEtikBpLZj3axABjT1MVC16cmXsLyaLokiAp8TWcXeI6ZstOfLWuUH0S5Gc5FaSrIt9sy9f9+/DgkvdQiUxSScwF51JlcgCxEa7k0YhNGHCjvBi40wRqXtQcpgKrl5om4h9kOPFqIzo/PAAPjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266770; c=relaxed/simple;
	bh=RORlDZODXaQvDU2xYSdqK34eg3g039xujjqxDT3MR80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzulmN3og3Qsb97r/THS5ec6kjgFseptgjUEZbFG1oXMBVd6wCvqNtmbQq3L85S7nOAwWOyeRNUnU1Yg+0vCsSAXpJYw7/OrcwneFS+TmOhijLleRZ0vf0EhUCUxhuSgt8W9Nbjje9f/HASQcBaRhUxL/L+YC99RJt+qyCzrw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu/DmIlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6212DC116B1;
	Tue,  4 Nov 2025 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762266769;
	bh=RORlDZODXaQvDU2xYSdqK34eg3g039xujjqxDT3MR80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu/DmIlAB5Kq9YX5KdYPEScDdxOcvtnhommT7pX+0QcphEpKxyk1bEZbEyk8V0NEk
	 a0wrz3MWKZhMkalsjp3HtpQS1Eym66KN0kQm2gCu6/zd8BkRtQ+Cff5zRUZ+JpyOnZ
	 hxM3eNqaBWAsZoCe6WoOlQhhLmxyWYo7WGWF64mUjG1Z0hOQRJg7xLa8RPmtRjsJst
	 gqyR5LibszsQsOEBd3iV9M5JM2WueL0l5P4Bc7Q86iT3hTijngXJIJu5oHWXNc49YV
	 GhBxMUrUvh7aeIABcXutqnbfg1UTsicDuZUCRD1X5Fm6R+IBQGxxVKU1xJhlrJMtDA
	 HWUJvljcoDm3A==
Date: Tue, 4 Nov 2025 16:32:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: warn and exit when unpreserved page wasn't
 preserved
Message-ID: <aQoOinskO4_BzzeQ@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
 <20251103180235.71409-3-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103180235.71409-3-pratyush@kernel.org>

On Mon, Nov 03, 2025 at 07:02:32PM +0100, Pratyush Yadav wrote:
> Calling __kho_unpreserve() on a pair of (pfn, end_pfn) that wasn't
> preserved is a bug. Currently, if that is done, the physxa or bits can
> be NULL. This results in a soft lockup since a NULL physxa or bits
> results in redoing the loop without ever making any progress.
> 
> Return when physxa or bits are not found, but WARN first to loudly
> indicate invalid behaviour.
> 
> Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index c2bcbb10918ce..e5fd833726226 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -167,12 +167,12 @@ static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
>  		const unsigned long pfn_high = pfn >> order;
>  
>  		physxa = xa_load(&track->orders, order);
> -		if (!physxa)
> -			continue;
> +		if (WARN_ON_ONCE(!physxa))
> +			return;
>  
>  		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> -		if (!bits)
> -			continue;
> +		if (WARN_ON_ONCE(!bits))
> +			return;
>  
>  		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
>  
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

