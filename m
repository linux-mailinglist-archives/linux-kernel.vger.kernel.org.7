Return-Path: <linux-kernel+bounces-787701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A02B2B379FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67456363BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E4C264A7F;
	Wed, 27 Aug 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU97S1+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE428E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756273630; cv=none; b=Edc2oIdHVvq4VsdVYjdqOZqsAKNlzWQ5hp1i9/eER3SA1YycvCTUcHLdr4UZQRssvUVnEg5pdjDxaiNnA6kkBV+KJycQ9znQBakQgV2Ng6IqgGOp2gBxHxuaK7rd/JZlP1Z81iU0Mfe9r08IRl60D3hrcX2eu1aRJ+BWInkpQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756273630; c=relaxed/simple;
	bh=hoEQy2EMzAl/DWp425B78q++EJxcTbj/XEoxlK1JLgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnNXMUmT49JwVc5sZNfxX7SDwnaQRTzBeRkwf48CXCmZGuPNkdL/Sosh6cSCfh+T2L95h57wR2OCXLKjdPCwEuAtWnvpv9oKUY6NOcqs04Dx4gnFqDZdwCszwGM7z1IWQR3GfJxVT5mlfZh+Z+qpPqolG3Lpb2nnth+s/TVsQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pU97S1+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DC3C4CEEB;
	Wed, 27 Aug 2025 05:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756273630;
	bh=hoEQy2EMzAl/DWp425B78q++EJxcTbj/XEoxlK1JLgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pU97S1+EbF20aHx2YwKsA40Iv6lKwnnEYv+9jrBZ3Ds2AT7wiueBxdNvavyadX7PG
	 NqOX38GyyIcM+7jag8bTwO+v8zGWSfTmfWy4GOT5+Q0HqUK66pgh/Z3CAkehQRHD7N
	 0ETaa8miJK4GCSLLvZRuiEEkdn4L290ff5ndhE52We0JAUtC25nkt4IfII7MYVg3Db
	 7h8q2pq1N2QJqeoxQSWSmFrXJhWJi/398wMTZ/dtQUwQ5y/jUq/EGhkfGVX2zBfc+v
	 2As3XfN8VV+9K8vxBscut4Nez2H1HBDSZeISIhs/HzLz1Belx0dTrYFTX0XeA5Xtec
	 uABcGPypXjQ8g==
Date: Wed, 27 Aug 2025 08:47:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: make sure kho_scratch argument is fully consumed
Message-ID: <aK6b1_UI-xw2rtlZ@kernel.org>
References: <20250826123817.64681-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826123817.64681-1-pratyush@kernel.org>

On Tue, Aug 26, 2025 at 02:38:16PM +0200, Pratyush Yadav wrote:
> When specifying fixed sized scratch areas, the parser only parses the
> three scratch sizes and ignores the rest of the argument. This means the
> argument can have any bogus trailing characters.
> 
> For example, "kho_scratch=256M,512M,512Mfoobar" results in successful
> parsing:
> 
>     [    0.000000] KHO: scratch areas: lowmem: 256MiB global: 512MiB pernode: 512MiB
> 
> It is generally a good idea to parse arguments as strictly as possible.
> In addition, if bogus trailing characters are allowed in the kho_scratch
> argument, it is possible that some people might end up using them and
> later extensions to the argument format will cause unexpected breakages.
> 
> Make sure the argument is fully consumed after all three scratch sizes
> are parsed. With this change, the bogus argument
> "kho_scratch=256M,512M,512Mfoobar" results in:
> 
>     [    0.000000] Malformed early option 'kho_scratch'
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index ecd1ac210dbd7..a90d55121a7a0 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -446,6 +446,10 @@ static int __init kho_parse_scratch_size(char *p)
>  		p = endp;
>  	}
>  
> +	/* The string should be fully consumed by now. */
> +	if (*p)
> +		return -EINVAL;
> +
>  	scratch_size_lowmem = sizes[0];
>  	scratch_size_global = sizes[1];
>  	scratch_size_pernode = sizes[2];
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

