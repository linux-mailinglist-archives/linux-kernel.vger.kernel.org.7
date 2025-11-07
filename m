Return-Path: <linux-kernel+bounces-890923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25191C4164F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A68188E505
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7152D837C;
	Fri,  7 Nov 2025 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVCyBR31"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA82D4805;
	Fri,  7 Nov 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542584; cv=none; b=cxq7RFYzMGh8AqkpD0VFA1JDZa3reW9CGTzSWbjG9KDYKXQAUwfJaHPYTGMuydEMtNNTssfE2WoftwVkqRcyTzK7dmBp0mpily2lt+Ek/cIsbiHjGTzEvrB69nPL1v6yB5Nw0fyX4mB9zKvNuqSbxCKURa7Ldd93z4p6MeueHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542584; c=relaxed/simple;
	bh=kBwFe0sXve6jPm7a+F1rFRS2v1YsDzxaljaTFwH/aQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gD5wsz2iTG0fpOdLbGU9kzrmhgjJw5EcvRdHV9udxJJW4gGodY2OYzjsBDdlsLyy5EE4SVvQ26gI8sO2BBhbJnlbSfmTPVY9HLiVTZlOjXpmres3rrijsnvt0gWyvxySpPNc6LLzTroTXeTwWfyzmNBCijHXU5JGKWLtDiho3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GVCyBR31; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=N0QufLNKsmFXFm1Ir0rKB8tkDRwt5DmDLkWfSkjtNjI=; b=GVCyBR31RL8tRLBsP9HdnR73h0
	yfAt7h+06tRMVKRUru+TnBowRjvw1bspqQaKHYE6f4P8a1SrCU0DcmPN2rShiQFVDGNq6dQ0UmHmg
	Df+7CNvVz9LMOv7ljOlGpmZJPRGk2FSFaXYePBd8RLkjwDpVQkioR5J5sX1WwpQdMUliwEXdMslyv
	ClpavSM1iegPlV7AxN7qyo73HT6emDUaEREYpUXJIN54hIQunO6BG8+cbeEzj9uxIAOtRbPIoPD7e
	1mgprhcO/FqkmWenRPBymdPz78C8iC983kFUkaNL0VZbg1VCgV+tm5y08IdUjhx+DSB8RJtHmSz33
	kJA8h/Gg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHRq9-00000000eCO-3kgD;
	Fri, 07 Nov 2025 19:09:41 +0000
Message-ID: <6b20fde4-e416-4d77-a6d0-32fc3319fc6a@infradead.org>
Date: Fri, 7 Nov 2025 11:09:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommupt: Describe @bitnr parameter
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
 <20251107081300.13033-4-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251107081300.13033-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


grumble...

On 11/7/25 12:13 AM, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warnings when making htmldocs:
> 
> WARNING: ./drivers/iommu/generic_pt/pt_common.h:361 function parameter 'bitnr' not described in 'pt_test_sw_bit_acquire'
> WARNING: ./drivers/iommu/generic_pt/pt_common.h:371 function parameter 'bitnr' not described in 'pt_set_sw_bit_release'
> 
> Describe @bitnr to squash them.
> 
> Fixes: bcc64b57b48e ("iommupt: Add basic support for SW bits in the page table")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/iommu/generic_pt/pt_common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
> index b5628f47e0db40..3b4e371089140a 100644
> --- a/drivers/iommu/generic_pt/pt_common.h
> +++ b/drivers/iommu/generic_pt/pt_common.h
> @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
>  /**
>   * pt_test_sw_bit_acquire() - Read a software bit in an item
>   * @pts: Entry to set

    * @pts: Entry to read

> + * @bitnr: Bit to read
>   *
>   * Software bits are ignored by HW and can be used for any purpose by the
>   * software. This does a test bit and acquire operation.
> @@ -364,6 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
>  /**
>   * pt_set_sw_bit_release() - Set a software bit in an item
>   * @pts: Entry to set
> + * @bitnr: Bit to read

    * @bitnr: Bit to set

>   *
>   * Software bits are ignored by HW and can be used for any purpose by the
>   * software. This does a set bit and release operation.

-- 
~Randy

