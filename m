Return-Path: <linux-kernel+bounces-822029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B35B82E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37CC1BC17D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98859271A71;
	Thu, 18 Sep 2025 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0JBnrM/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476926FDBB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170407; cv=none; b=Cg0UxI6o+3qAexasVkXa6HuHamOpFIozqjIaj8EUuTL5J6p4cWJWzpMjDSUp2VGuTwaj+9i8ynwOKD/2xkDONItHfFYyxxrDsEZ00mCvm+KNen2oE74S7eh3Rt3q+oaFJrA6fwtoM/BTewnifX8/VCKs1abzLtgew51uEsk+m5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170407; c=relaxed/simple;
	bh=pOk5q/atPUmn+YqKUA8I3WWKQTeq1u0M+5hox5rZKrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mt6a67bXSSeFuZY0VlT/YruCrMns1SQ6lYtdZ4C/wxlE42NnaU3Df83OY0MJ1+qYJ+dhb96XFLaiRNJCNVW9Tpyo1wPX2DE7DqP5dnhta6fuzJWETOpsR8vISpVCzCmohIu2SUszMef3/yIe38oh6iv5J6ffyPhsbTmFUUGXJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0JBnrM/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758170406; x=1789706406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pOk5q/atPUmn+YqKUA8I3WWKQTeq1u0M+5hox5rZKrE=;
  b=L0JBnrM/a7KnkUhRhggUgcMrHWJOwcpnd01/r0v+mfE9mvCm+qeY3kse
   xS4uEf2ul5gPreWuCRIZPudDp2TpCMZPqQnUyAeopr6IjAmbdut7g4nDB
   jJSMtTacLT4YPQorfIdKcDNz1MufYCxMXQBQWvKcwmjahVAOiiXVKAT1x
   8e24edF5ZZUN+tcNw5VX0bCjn65ARQJh/0bzuOSQKHZPwLdt1+PTVcoFo
   9zzPkXZ4UPF7kjEovjrRdohyjUPrkerz3otfpmZ9scj+J9xPd9XSPiXNo
   Y44LG464lvLoE8NF9Kr+CMBcy6XxUL4Ulz2gCuNgSTFcr/l/dr7RBp2DB
   Q==;
X-CSE-ConnectionGUID: k0EZSDvrTvyX9q9QnycG3Q==
X-CSE-MsgGUID: dP5e4HFoTlalNqnmslz/Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77926768"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="77926768"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:40:05 -0700
X-CSE-ConnectionGUID: zxq7F8UqQUaJHyxKeVBTsg==
X-CSE-MsgGUID: qboF4ChFS7CkjNx7WaakVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175827284"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:40:03 -0700
Message-ID: <7c211a7a-c68d-41c6-8f1b-76af74a3def6@linux.intel.com>
Date: Thu, 18 Sep 2025 12:37:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: debugfs: Avoid dumping context command
 register
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250917025051.143853-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250917025051.143853-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 10:50, Lu Baolu wrote:
> The register-based cache invalidation interface is in the process of being
> replaced by the queued invalidation interface. The VT-d architecture
> allows hardware implementations with a queued invalidation interface to
> not implement the registers used for cache invalidation. Currently, the
> debugfs interface dumps the Context Command Register unconditionally,
> which is not reasonable.
> 
> Remove it to avoid potential access tonon-present registers.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 1 -
>   1 file changed, 1 deletion(-)

Queued for v6.18.

