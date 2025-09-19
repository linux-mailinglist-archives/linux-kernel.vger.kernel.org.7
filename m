Return-Path: <linux-kernel+bounces-824313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787ABB88A35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219C81B2661C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF523090FA;
	Fri, 19 Sep 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhz40lt0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391DE303A20
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275100; cv=none; b=qXXeM7IEUeO7TLnkSrEtVShXt53WZmlGrdaS4REh/l8dltVwSN3mkDsbgnCJKy5DOk2jwFwGPlYClJn+JQmW31RG06j2coxLk6qXHR8zXfQwXsTTmVCkAdMYzLWNCsJkV4+/WA57BlzEIwUjIaohXqFRDNGpFIipl4LcKRH7UtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275100; c=relaxed/simple;
	bh=GevPAgZnxPiABiyE8TgVYJoyrxKHZP9YdLV2GloJTu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c781PWaVjPbNLXG9pGHHuGjLqzfZTbFnBB17AQtRbL3jKylKVJx4/syYAJKk/cW2zoz3LPetJaCsEZin2jNnf05kYcn3fihhLjyIZOEZVK6OIG6TIh8oCpYtV7KaDtbO6tILk1Jl+L8IFZeGV9KemKy9v1iiTa2AWR8lWf0yR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhz40lt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADABC4CEF1;
	Fri, 19 Sep 2025 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275099;
	bh=GevPAgZnxPiABiyE8TgVYJoyrxKHZP9YdLV2GloJTu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhz40lt0SEu3HxgEYIqaeltRAt4aEBgazYuPF9b2ALx7MPrXRYZh7j4KBJAYjZ4Ab
	 PhrajEYLtN+XhORv3jeUevqKHzRSuZHfsqfmH9EgBXtCpe2gtbQdOcrRd5UJsyc46b
	 tFfY75K57McmOcZnLHImyV5Dv9LtW/GSpwXzxy2jZAovnc2lvPkPRezqGEDhD4l1sO
	 Oh7o8eWuoZ5F6RLqO/4487IB1qBqFdXUKxmxATUT5sPDlCVokiHWmWYxV/1qF9/pD2
	 ELNo7ibLVq3SzpiwEe2yb4CBGNo4N9NRP2IuIfBoXVJJE3/eIIGQXtNQv5jj26TxRe
	 dkNeFxtNu9B6w==
Date: Fri, 19 Sep 2025 12:44:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: only fill kimage if KHO is finalized
Message-ID: <aM0mFDdoQ4r1f9Mo@kernel.org>
References: <20250918170617.91413-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918170617.91413-1-pratyush@kernel.org>

On Thu, Sep 18, 2025 at 07:06:15PM +0200, Pratyush Yadav wrote:
> kho_fill_kimage() only checks for KHO being enabled before filling in
> the FDT to the image. KHO being enabled does not mean that the kernel
> has data to hand over. That happens when KHO is finalized.
> 
> When a kexec is done with KHO enabled but not finalized, the FDT page is
> allocated but not initialized. FDT initialization happens after
> finalize. This means the KHO segment is filled in but the FDT contains
> garbage data.
> 
> This leads to the below error messages in the next kernel:
> 
>     [    0.000000] KHO: setup: handover FDT (0x10116b000) is invalid: -9
>     [    0.000000] KHO: disabling KHO revival: -22
> 
> There is no problem in practice, and the next kernel boots and works
> fine. But this still leads to misleading error messages and garbage
> being handed over.
> 
> Only fill in KHO segment when KHO is finalized. When KHO is not enabled,
> the debugfs interface is not created and there is no way to finalize it
> anyway. So the check for kho_enable is not needed, and kho_out.finalize
> alone is enough.
> 
> Fixes: 3bdecc3c93f9f ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Nice catch!

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 8079fc4b9189..5ff959a90165 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1242,7 +1242,7 @@ int kho_fill_kimage(struct kimage *image)
>  	int err = 0;
>  	struct kexec_buf scratch;
>  
> -	if (!kho_enable)
> +	if (!kho_out.finalized)
>  		return 0;
>  
>  	image->kho.fdt = page_to_phys(kho_out.ser.fdt);
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

