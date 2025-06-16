Return-Path: <linux-kernel+bounces-687590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7937ADA6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 05:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA191891362
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 03:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A286295511;
	Mon, 16 Jun 2025 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTxSnDOb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01032AD00
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750044455; cv=none; b=fve+wqCOfArOFwdexDHAPmQMqnwqNITIZ5MkFLrtR769Z6H04aW/GOIq763iCnHg2DG6BVzADpbvJ0ENZmGUoSkCpedTXYxB367/l1TcWbXiQCdRTZlDFPATIfnC2wMpE1bgPmysiYFx/wi7TslVYaqdHuBUGAdleQ5eaBTx2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750044455; c=relaxed/simple;
	bh=uxMcnxSah9aMa+8ILzcDP7SuWEBEsRK+BQxyFazc45c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcXx40I8lfhUqnzmsYUkLUwy+XmvaNB/bbQLEscIIrZhLvlNwpdmkOkDb/IzWEO+h2xolR3ZyLjmLRWMxkp0pJhs0pR7sADoZVw282PQu/bIAh5dzXHKTXWWTczSNtymYaT+doj9txAaGvrLTXo6VZ7eGU/lfGnPvTynDQzp3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTxSnDOb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750044454; x=1781580454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uxMcnxSah9aMa+8ILzcDP7SuWEBEsRK+BQxyFazc45c=;
  b=HTxSnDObrO2b97s2B+tpqDNxzpKWI2bA6LNZDkQX0sdaiMuQM8IOQtG+
   9lG3Tev+J7cSDkKGMc9lkVAQtayE7m4uqIRgsSkj7umy7VmjwkU13MQUl
   Wk29LeQLKEqT6ENPZOwmsjxLubhq/OYtcneiaNtruXf+URQs0MY75Ic3S
   0BBr6gPV71CBaisyab0wCSn/6yKUHON64P42LqzkdtpoqVGDxFTRVekcx
   snko8d3OftpmYfu3IU2WL1opbYE9o4IwU2pRLROXNvyc37Rt6DcSD0GY7
   MQKH5LsOn6raFgGlGeYk484pvZMqaIFdIKsNZNJOlB6/e0cIBLNeUcwKg
   w==;
X-CSE-ConnectionGUID: zCjSJfFmSI2mti7r43sGZA==
X-CSE-MsgGUID: dsLbywuqSXeboFNQN0rrjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52269782"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52269782"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 20:27:34 -0700
X-CSE-ConnectionGUID: JpviFFLOTQCsk9oYDhWIPA==
X-CSE-MsgGUID: keVs2t7JTn6iHxc8oobEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="149262496"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 20:27:30 -0700
Message-ID: <8471eefd-bb69-4734-a1ba-772788d07d96@linux.intel.com>
Date: Mon, 16 Jun 2025 11:26:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] iommu: Deprecate viommu_alloc op
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 yi.l.liu@intel.com, peterz@infradead.org, jsnitsel@redhat.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <cover.1749882255.git.nicolinc@nvidia.com>
 <5b32d4499d7ed02a63e57a293c11b642d226ef8d.1749882255.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5b32d4499d7ed02a63e57a293c11b642d226ef8d.1749882255.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/25 14:35, Nicolin Chen wrote:
> To ease the for-driver iommufd APIs, get_viommu_size and viommu_init ops
> are introduced. Now, those existing vIOMMU supported drivers implemented
> these two ops, replacing the viommu_alloc one. So, there is no use of it.
> 
> Remove it from the headers and the viommu core.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

