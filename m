Return-Path: <linux-kernel+bounces-692309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38947ADEFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 16:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033C616529D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052B2DFF3C;
	Wed, 18 Jun 2025 14:35:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632FD2877E3;
	Wed, 18 Jun 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257318; cv=none; b=ZwLwEHghN7p7DMqQikjMAupJr8LlAej3cRFnPM9lOMSM0tfDeGzs7F15yxeuBShww7KWEq/Kjs2uylScxcSKnkGJbvZY1NbxRpK2uhl/efZmTZMs4xk4iPXXjSP71xU7PlKd/VQ6wjGJB8nh+hLeHQh1FosoIaRQHuzze3AmLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257318; c=relaxed/simple;
	bh=IX2MDoOm1kWwcARKzwFsPOZ7vwlSkraLHEHhna4OJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxnAM0Y5rPO4QNyyISxUuHHDvTK5eYunZiYrj8zxSMEWzoSMCeVjnUScDkvWMPcMduUUpUOovPBFKNaHDzgO89wSBdXTUd1E5Sarb9MQezMUykAg9mtFN1/6OK/Uhueq5l/EeZqvQYsGCzWb7R1jcNTNTvDebs1hT1+0r0FL2pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7A5C4CEE7;
	Wed, 18 Jun 2025 14:35:10 +0000 (UTC)
Date: Wed, 18 Jun 2025 15:35:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: ankita@nvidia.com
Cc: jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	will@kernel.org, ryan.roberts@arm.com, shahuang@redhat.com,
	lpieralisi@kernel.org, david@redhat.com, ddutile@redhat.com,
	seanjc@google.com, aniketa@nvidia.com, cjia@nvidia.com,
	kwankhede@nvidia.com, kjaju@nvidia.com, targupta@nvidia.com,
	vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
	jhubbard@nvidia.com, danw@nvidia.com, zhiw@nvidia.com,
	mochs@nvidia.com, udhoke@nvidia.com, dnigam@nvidia.com,
	alex.williamson@redhat.com, sebastianene@google.com,
	coltonlewis@google.com, kevin.tian@intel.com, yi.l.liu@intel.com,
	ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
	linux-mm@kvack.org, tabba@google.com, qperret@google.com,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, maobibo@loongson.cn
Subject: Re: [PATCH v7 1/5] KVM: arm64: Rename symbols to reflect whether CMO
 may be used
Message-ID: <aFLOnN_Ha3s724rK@arm.com>
References: <20250618065541.50049-1-ankita@nvidia.com>
 <20250618065541.50049-2-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618065541.50049-2-ankita@nvidia.com>

On Wed, Jun 18, 2025 at 06:55:37AM +0000, ankita@nvidia.com wrote:
> -static bool kvm_is_device_pfn(unsigned long pfn)
> +static bool kvm_can_use_cmo_pfn(unsigned long pfn)
>  {
> -	return !pfn_is_map_memory(pfn);
> +	return pfn_is_map_memory(pfn);
>  }

I wonder, why not just use pfn_is_map_memory() directly? At a quick
grep, it's only used in one place and your patches don't seem to modify
this function further.

-- 
Catalin

