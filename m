Return-Path: <linux-kernel+bounces-740946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED3B0DCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBE21608E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871962EA15B;
	Tue, 22 Jul 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G44437V6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88F2E9759
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192919; cv=none; b=MHQw34Mu25a9NUEimH9+Dx8aOoaik8Yibsz2xAZGXJh73O8rkVRcjVIs58uDkAZv+5AfrCErwiHsdfDV5kPZCa9YRy3cXOMeNi7pjGnfgDkMIEfNKaB8mmV45koxKK7FOhAkn7izFEcc9kGNgsJhRet/PjLMQF4eJDJCZ0zBFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192919; c=relaxed/simple;
	bh=oujexYziHgPEDcDx7x1RYjfQC+/RIpBUJRP2MbMPYJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg76uRZHItZnzD9/Isv0H5wgY0QLmZa5tL6kK57PdBMzM35b5Es4kr/ZepiCD1RLfxmWgqrhgyk+d58kbWF6w5eD+bk7Rw/tyWCuo9JyYao1hrpnmPRcMw7ZLMxp+JVIwyICGxNEmc2fezklM3GuSkkiz/2Ru4GLytdzPx9Xp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G44437V6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7561AC4CEF7;
	Tue, 22 Jul 2025 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753192918;
	bh=oujexYziHgPEDcDx7x1RYjfQC+/RIpBUJRP2MbMPYJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G44437V6zc3RRb1EuCGCfuuEnJ07kAW/wsYjpBm8OmiB9hTdtAv80wb1ej2FX2EnN
	 6+HmEVHCE1bDMhZAF+Vt8TYCvH71Q+HtgWWukjAJu+KaZYNC5GbBhqeuC12GXOz6Va
	 bvPuGtxnV8YqXpR1IpQ/+pRPFEp1/pI5hgv0np+dO5+J5xFiknR3J61cL0A9o7cJZm
	 54PdtwRRVaTH5sPuotqtWT7QjUQdIDJUMNs7cGWIRCJSe5cUHKOSbvi2EqsyGZqtTL
	 sEF6B9IiUtrnq3AaEUQZNOd4FjMOE4x2mbp5enjjF0v21taQAIZvOY4DcMHV3dSUNF
	 NwFyFRSblIffg==
Date: Tue, 22 Jul 2025 15:01:53 +0100
From: Will Deacon <will@kernel.org>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, sudeep.holla@arm.com,
	Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 3/3] arm64: cacheinfo: Provide helper to compress
 MPIDR value into u32
Message-ID: <aH-Z0SNzNVz0cToB@willie-the-truck>
References: <20250711182743.30141-1-james.morse@arm.com>
 <20250711182743.30141-4-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711182743.30141-4-james.morse@arm.com>

On Fri, Jul 11, 2025 at 06:27:43PM +0000, James Morse wrote:
> Filesystems like resctrl use the cache-id exposed via sysfs to identify
> groups of CPUs. The value is also used for PCIe cache steering tags. On
> DT platforms cache-id is not something that is described in the
> device-tree, but instead generated from the smallest MPIDR of the CPUs
> associated with that cache. The cache-id exposed to user-space has
> historically been 32 bits.
> 
> MPIDR values may be larger than 32 bits.
> 
> MPIDR only has 32 bits worth of affinity data, but the aff3 field lives
> above 32bits. The corresponding lower bits are masked out by
> MPIDR_HWID_BITMASK and contain an SMT flag and Uni-Processor flag.
> 
> Swizzzle the aff3 field into the bottom 32 bits and using that.
> 
> In case more affinity fields are added in the future, the upper RES0
> area should be checked. Returning a value greater than 32 bits from
> this helper will cause the caller to give up on allocating cache-ids.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
> Changes since v1:
>  * Removal of unrelated changes.
>  * Added a comment about how the RES0 bit safety net works.
> ---
>  arch/arm64/include/asm/cache.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index 99cd6546e72e..09963004ceea 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -87,6 +87,23 @@ int cache_line_size(void);
>  
>  #define dma_get_cache_alignment	cache_line_size
>  
> +/* Compress a u64 MPIDR value into 32 bits. */
> +static inline u64 arch_compact_of_hwid(u64 id)
> +{
> +	u64 aff3 = MPIDR_AFFINITY_LEVEL(id, 3);
> +
> +	/*
> +	 * These bits are expected to be RES0. If not, return a value with
> +	 * the upper 32 bits set to force the caller to give up on 32 bit
> +	 * cache ids.
> +	 */
> +	if (FIELD_GET(GENMASK_ULL(63, 40), id))
> +		return id;

Why is it safe to ignore the other RES bits (i.e. 31, 29:25)? If the
architects decide to pack some additional affinity information in there,
we're in trouble, no?

Will

