Return-Path: <linux-kernel+bounces-886467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEEFC35AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665CA56040A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3519B3126CD;
	Wed,  5 Nov 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pxs0hYXh"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2731328A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346734; cv=none; b=ReMkiPV30dQUBFgA1kj6CXSUcxvIrcmfIPd7fqBXS5SrtdokaLKZgrNaCAng1SyJp9bdl1aGIkiYlc0vCfyzFGBvODGrq7meAcNZTmXszUv58h1+LLBAVYWehLhUt7bZqA0oXFrNSOpgfj6avX7pYOKnrHQ0FSZ90OyX2AywrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346734; c=relaxed/simple;
	bh=vr58Rxv58WIV+Na4NCCrbGSjfMLysQWOnLWdBpGAA30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=F8AGblSxxxeNVpnYmCpTmg1ds1sqgzM+qgbrgmXEjqr74acNOkkkgoYGHqJv/1lbHTP+yq308J4ws77cP/1m9n+nuYH7oxzyTWhWbWuOZCMAub1KdsCKqsBPtnN9N7NOwcSw5oGB/yg9Wj7S28/uiz4VDpMt/f3ynphVQMwZgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Pxs0hYXh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251105124525euoutp026a3e42b2e6fb9c11c8f695a6690f6537~1HQJshRc82277722777euoutp02a
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:45:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251105124525euoutp026a3e42b2e6fb9c11c8f695a6690f6537~1HQJshRc82277722777euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762346725;
	bh=CG8DxT5IJUW0aZvaLpIKID3K5WMSr0E4K4/UlToBMNQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Pxs0hYXhhWVS3JIqECUp53TObJGZ3LK3HZZ5K2o4JtVkCn/F7S6HMzRlpu/EmHIBb
	 jKq49ty2FlJVhNgfWrTscjqoMMnIHCoiTn+tJ92dthmsfjczQB9qoNkeeFl/GtwgXZ
	 yywilQQp+dUrhYQa1moaxDuVWE9wRrekFu/8eHzo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251105124525eucas1p1cb8af8e425097de995b73445aac08729~1HQJUFBPp1324313243eucas1p1Z;
	Wed,  5 Nov 2025 12:45:25 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251105124524eusmtip1430c65842a4994e78ca9a6ccfd56dfa9~1HQIbSPoN1476314763eusmtip17;
	Wed,  5 Nov 2025 12:45:24 +0000 (GMT)
Message-ID: <ae76317f-6ea2-4413-adf9-2260db49b658@samsung.com>
Date: Wed, 5 Nov 2025 13:45:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: Allow use of DMA_BIT_MASK(64) in global
 scope
To: James Clark <james.clark@linaro.org>, Robin Murphy
	<robin.murphy@arm.com>, Nathan Chancellor <nathan@kernel.org>, Nick
	Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>, Vinod Koul
	<vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guodong Xu
	<guodong@riscstar.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251030-james-fix-dma_bit_mask-v1-1-ad1ce7cfab6e@linaro.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251105124525eucas1p1cb8af8e425097de995b73445aac08729
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251030140656eucas1p1db40ecf9e84bcabee73b9cfb0b777c4a
X-EPHeader: CA
X-CMS-RootMailID: 20251030140656eucas1p1db40ecf9e84bcabee73b9cfb0b777c4a
References: <CGME20251030140656eucas1p1db40ecf9e84bcabee73b9cfb0b777c4a@eucas1p1.samsung.com>
	<20251030-james-fix-dma_bit_mask-v1-1-ad1ce7cfab6e@linaro.org>

On 30.10.2025 15:05, James Clark wrote:
> Clang doesn't like that (1ULL<<(64)) overflows when initializing a
> global scope variable, even if that part of the ternary isn't used when
> n = 64. The same initialization can be done without warnings in function
> scopes, and GCC doesn't mind either way.
>
> The build failure that highlighted this was already fixed in a different
> way [1], which also has detailed links to the Clang issues. However it's
> not going to be long before the same thing happens again, so it's better
> to fix the root cause.
>
> Fix it by using GENMASK_ULL() which does exactly the same thing, is much
> more readable anyway, and doesn't have a shift that overflows.
>
> [1]: https://lore.kernel.org/all/20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com/
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Thanks, applied to dma-mapping-fixes branch.

> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 8248ff9363ee..2ceda49c609f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -90,7 +90,7 @@
>    */
>   #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
>   
> -#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> +#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
>   
>   struct dma_iova_state {
>   	dma_addr_t addr;
>
> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251030-james-fix-dma_bit_mask-624dbeb89afa
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


