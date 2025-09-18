Return-Path: <linux-kernel+bounces-822890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B9B84E92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5A57BE042
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE921D3E8;
	Thu, 18 Sep 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV2TgxXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A41078F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203540; cv=none; b=KeTsMbpdwVejuvHq0hofxnQY2aNxoQ9aOICj7Uibc84im1GEJujVAe/nYWO8KP0A4N81QFWCBLSW6QQWWlKDX7zUDA2QmbTsTKc0PW77riMCNf0+KDrYyYG6UkiZCJNrGy+Q+3qfE/p4Q5BuPLKQHmoh+avMsnD+4Okxer4zjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203540; c=relaxed/simple;
	bh=rBM77CT0fDiwZ5fv3ggT1HQ8jZJeuFQd7kHGWdmBYPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvKojJtQOBJ2DEY005r17FTLYrQ0VC7MEWRwMAy5czjMLuPLSymyWi0N7WgiEvuyZ3tclADGiGJAmSxOlV7oKeVt7L6bueIO5hdKAGFo+l/rCFAGBbIuSw7Hkx/KZp1VM61uykW600Z6QET+JnJ7d+tznvXrsfsN0BbsfkyZ/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV2TgxXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B4C4CEE7;
	Thu, 18 Sep 2025 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758203540;
	bh=rBM77CT0fDiwZ5fv3ggT1HQ8jZJeuFQd7kHGWdmBYPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mV2TgxXmBs7Jc1RRbR4ZgbTiwx8Xhl3TnF0eIEcSImofolTjNd32s8OiyP3gt2VCQ
	 OEiws3R2SAUQuFW4X72BkcW0HpD0yH21ZpVpixjCMFGCG619QvQYWAtv5hBcqNLh1c
	 kp0iy8t6FwRhH1+oCgNOnKJRxJ96y0hAjkdSecKX2awOT/jW7WXCF8rkNhOSNaWTcF
	 XIjsvpd9dmUOUsx+6wj8rDKbOZKgPvjBN8Hyhyb31Hu7D8gf7VS3Pxvu2kQSgYB31/
	 fKmGawJKXxALuhBi8rMi1nT5eqV1kGK6X3iMQ0zl5YV4afyhOkQWWgeNwtqKFj9WN7
	 WGAorlexjWeQA==
Date: Thu, 18 Sep 2025 14:52:14 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com,
	yangyicong@hisilicon.com, wangyushan12@huawei.com,
	hejunhao3@h-partners.com
Subject: Re: [PATCH v6 3/3] MAINTAINERS: Remove myself from HiSilicon PMU
 maintainers
Message-ID: <aMwOjne-iiFCdo9n@willie-the-truck>
References: <20250814091622.23269-1-yangyicong@huawei.com>
 <20250814091622.23269-4-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814091622.23269-4-yangyicong@huawei.com>

On Thu, Aug 14, 2025 at 05:16:22PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Remove myself as I'm leaving HiSilicon and not suitable for maintaining
> this. Thanks for the journey.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Thanks, Yicong, for all your contributions to the perf drivers and help
with reviewing over the years.

We will miss you :(

Will

