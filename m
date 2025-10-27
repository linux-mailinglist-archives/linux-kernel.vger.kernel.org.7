Return-Path: <linux-kernel+bounces-871440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 299BAC0D3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C850E34CEAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069A2FF67F;
	Mon, 27 Oct 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JnkdrF/g"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B12FE586
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565643; cv=none; b=Vp/K6Nhb/yCh0FX99jvDXC5/THZR1eD9e+j0p9nLE3v4KX5EHUWQFGjVq9Grr2UvbDmzDVrhLiRYLnvPyAJ6lWgq4EAOz6+C0s3IcL70qDMQb0Ei9mIvOBMLcmRCsP4IyjBZ0o7iwIwBkOJpzigDc/Z7Jqo//56ECisd/DvwliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565643; c=relaxed/simple;
	bh=F9hQ1aXhK3lDTwlNe0UmsgkyS6BDOP0RXEkmxmRZoe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al+12Bj8yxIa+XPyhPJ2r8Z0zx8chPHODswKMYLJhMHp2zB1jF3hVmk8sv8QzRd8zqL8Sk+WG7e1K6r+WGup9bIO2mAa8ARMmOdxpbiHCOVSRU2Sh33535rqetIcbClQpHpkmEmLftzpmAJ+J7LzBN03uCUMQM6UEWoYM6smX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JnkdrF/g; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 28C4D59947;
	Mon, 27 Oct 2025 12:47:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761565639;
	bh=F9hQ1aXhK3lDTwlNe0UmsgkyS6BDOP0RXEkmxmRZoe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnkdrF/gLW0DfLLhNrdPqWMTXkUTxTIRnzpVDtAGJQXxPS3e49wP7rC4ROgNLcqJ6
	 4UxcsY+7x1yz0w9pUNSAKyhrNNcB1bmgIhugZN89xH+FJ3KG3IICqbMEadXQAI4KTL
	 QEbmRpFTqpVZg3Tr4MmASqV0k1bo8jMT+bQRbt03RnUSzZyBjT+Cdzcb7xN8SuEHHX
	 JuwV3sgcgmRUEjpmw5re1hAEyZ8DF8ngUL5cwz9pTKd28z6haKrvCC7AwVykVWe4Hj
	 uYkVjl0yO9UXV/oMcwBVmHVrg8qvOoh3F3smRDASFo40PphGqubj7lTpR4EBvecO7W
	 UU+0FTNwsp0eQ==
Date: Mon, 27 Oct 2025 12:47:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/pages: use folio_nr_pages() instead of shift
 operation
Message-ID: <qv6ewao263euzrq6w62ftjaunaxizlxbpunlgflga6uvsiwyek@hi3gjlwk77la>
References: <20251004032351.51150-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004032351.51150-1-pedrodemargomes@gmail.com>

On Sat, Oct 04, 2025 at 12:23:51AM -0300, Pedro Demarchi Gomes wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>  drivers/iommu/iommu-pages.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

