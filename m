Return-Path: <linux-kernel+bounces-848152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CDFBCCBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AA5421562
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C69286D7D;
	Fri, 10 Oct 2025 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgV4fAzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D093283683
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095344; cv=none; b=XXES78ibKINQ9e+7EmXpaJJ1Vg0iyDKNclZe3wtNVMCCN8bqDqJpaD2DefhoKvjPPHCc/aZhN3tpg0UYunFgSF1JphvwgueTNv80kLN0VZdnP7O8AeW/Dx3E6qgIXB6pssuhus8hA7ed08azOjjPASVLvRpIEuXQkEz8bcS4xHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095344; c=relaxed/simple;
	bh=ipDFmTZaSzTUHl8DLEVjC9m2bvCsB+Elcb4FVEuSNYI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G8UZvRmpE6WhMpfUNaXUZ1kM4EvCQUqwNAHlUKO101wgF/eBaj6uDA0ZgIQvSYPJsAd37fT5Ys4IBEk5/xZ2W6B8nHtj5qa+rj+ymseLqjM742PAzC/X9pxsqJjDfY7+XbyhkJkesyhP/CkG7HCJyXkJ07BJ4HoaNy1p4sHyskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgV4fAzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11799C4CEF1;
	Fri, 10 Oct 2025 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760095343;
	bh=ipDFmTZaSzTUHl8DLEVjC9m2bvCsB+Elcb4FVEuSNYI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QgV4fAzf4CKD/BUuqB1aLHDeP2Pn+8ah410jvVwNwjW0o4RRbFUwe1CgqmINLX4I5
	 OGhg1yLuj2moTJAqxGBOLaqCjQbpYohg8d05v9XOazJaRz6h50I0vt0l221k5vCD81
	 xWxlwSG9r6y5QchxohIOZpo4gffP1JNJTjiI9MJKALDwg6SP1bd6UKE2mWtkoRc8ux
	 vgcm0C6rAfGsIyVPh2MxMbT3wV7auWa+HtzFT98gdWEWhkx8SScmAMbB+shzmSXfwU
	 396TAmPKOJ6guf2zTnkGgVa8EOZfl94IMVdltZeyu4tNC0dRneQnK2n/0ruPjPy0mS
	 +D2cqXXYzB9pA==
Message-ID: <1a46c78e-86b2-4e26-971f-c7716143f6af@kernel.org>
Date: Fri, 10 Oct 2025 19:22:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, tuan.zhang@amlogic.com, jianxin.pan@amlogic.com
Subject: Re: [PATCH v2] f2fs: Use mapping->gfp_mask to get file cache for
 writing
To: jiucheng.xu@amlogic.com, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20251010-origin-dev-v2-1-952a3c98cd9c@amlogic.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251010-origin-dev-v2-1-952a3c98cd9c@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 18:45, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> On 32-bit architectures, when GFP_NOFS is used, the file cache for write
> operations cannot be allocated from the highmem and CMA.
> 
> Since mapping->gfp_mask is set to GFP_HIGHUSER_MOVABLE during inode
> allocation, using mapping_gfp_mask(mapping) as the GFP flag of getting file
> cache for writing is more efficient for 32-bit architectures.
> 
> Additionally, use FGP_NOFS to avoid potential deadlock issues caused by
> GFP_FS in GFP_HIGHUSER_MOVABLE
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

