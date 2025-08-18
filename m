Return-Path: <linux-kernel+bounces-774092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2783EB2AE85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51BE564E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D5342CB3;
	Mon, 18 Aug 2025 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBSXm9fb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2737341AD2;
	Mon, 18 Aug 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535748; cv=none; b=G7I/Xf1e1hHao1innVG8mzCnD+haoUq9BEotbVtoFvGeISowd1bEWVB2tNM7Cx5CEpvmPVIBBt27qBVXd0UM8vpq46uDqNWvRQXKvLr5PbCJd0avHa+2KgnjBItZ95z8Mpb53TDBx+xRxn6lSFSw7pKm6kf7DxiTJsAXakb24U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535748; c=relaxed/simple;
	bh=IsR7S16rpX+ohNKnRQ8Ph3kkhG6iUIkOEGBi+rZ2MPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHcrkfSywStt+Y+YVTN5pW97Jj7yxoe9Pt5aYGeJxJg2l9jnTvN/i4ChskaYP/V8abBEV67NM1xq6WUszeqLbQf1AdFs5CITmKUv70QSzwYmRVUnGq9TOqjuYMaF9YSfAtdnjFOs20GQDmDnMcj6W8MKm/DIvPQfpxntmlbe7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBSXm9fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC68C4CEEB;
	Mon, 18 Aug 2025 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755535748;
	bh=IsR7S16rpX+ohNKnRQ8Ph3kkhG6iUIkOEGBi+rZ2MPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBSXm9fbijN+jrcvMRjFo8xKzrIbaoDUzWeA/w0/PS5yA16WemamuNG36z6+fAs2y
	 Fvwg3pHMgRRrbEWlSdrnA66UZA2WJpUeSAHwK3Y1Q5SRZfeDkhcukw2PkLZkcaQD9L
	 /+0MdJDKA0/C/tvXhHFMgF8vVi7Y4A/S6AQUgLSMUGrlfpzUdFjvMxVtnRa0VgljPg
	 +jziAzfRwGimG42rQ0CVTZiKcLuejvPKy4e1bXOxfRf6mCKu3+Ekp4SrgakvwBv/H+
	 kUFAasernbJbVg3F+FWziq9juabolU8SXRn6fplxAaaLP/Wp79d3ItitRIXG0xAvxZ
	 hXdprurBpWjaw==
Date: Mon, 18 Aug 2025 11:49:07 -0500
From: Rob Herring <robh@kernel.org>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/address: Add error logging for of_match_bus() in
 address translation path
Message-ID: <20250818164907.GA1437284-robh@kernel.org>
References: <20250811095342.2383808-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811095342.2383808-1-quic_zhenhuah@quicinc.com>

On Mon, Aug 11, 2025 at 05:53:42PM +0800, Zhenhua Huang wrote:
> The change introduced in
> commit 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
> triggers a warning on the direct ancestor node when translating properties
> like "iommu-addresses"/"reg". However, it fails to issue a warning if the
> ancestor’s ancestor is missing the required cells.
> For instance, if node_c lacks the necessary properties, no warning will be
> generated. Potential issues will be trigger further.

The point of the WARN is to only to check the immediate ancestor.

> node_c {
> 		//NO WARN
> 	node_b {
> 		//WARN on missing of "address-cells" and "size-cells"
> 		node_a {
> 			xxx = <memory_reion>  //contains "iommu-addresses"
> 		}
> 	}
> }

Whether a warning is appropriate here depends on whether there's 
'ranges' properties or not. If your schemas are complete, then they 
should warn on missing 'ranges'. If ranges is present, then we should 
get warnings if #address-cells or #size-cells is missing.

> Since of_match_bus() is now expected to succeed in traslation path,

now expected? Nothing changed in that aspect.

> routine __of_translate_address. Print an error message would help in
> identifying cases where it fails, making such issues easier to diagnose.

For errors in the DT (as opposed to errors using the API), it would be 
better if we can check this at build time rather than run-time. And 
generally I think we should already, but there could be some corner case 
that we don't.

> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  drivers/of/address.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index f0f8f0dd191c..cd33ab64ccf3 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -515,8 +515,10 @@ static u64 __of_translate_address(struct device_node *node,
>  	if (parent == NULL)
>  		return OF_BAD_ADDR;
>  	bus = of_match_bus(parent);
> -	if (!bus)
> +	if (!bus) {
> +		pr_err("of_match_bus failed for device node(%pOF)\n", parent);
>  		return OF_BAD_ADDR;
> +	}
>  
>  	/* Count address cells & copy address locally */
>  	bus->count_cells(dev, &na, &ns);
> @@ -560,8 +562,10 @@ static u64 __of_translate_address(struct device_node *node,
>  
>  		/* Get new parent bus and counts */
>  		pbus = of_match_bus(parent);
> -		if (!pbus)
> +		if (!pbus) {
> +			pr_err("of_match_bus failed for device node(%pOF)\n", parent);
>  			return OF_BAD_ADDR;

If there's no case we expect of_match_bus() failing is correct 
operation, then the error msg should be in the of_match_bus() function 
rather than duplicated here. I'm not sure if there is any such case.

Rob

