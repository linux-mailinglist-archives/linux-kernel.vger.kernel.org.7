Return-Path: <linux-kernel+bounces-821173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66350B80A45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BFB04E33C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F434A32F;
	Wed, 17 Sep 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVKUlqpI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227603451AA;
	Wed, 17 Sep 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123483; cv=none; b=dUy0HDK4XQ8dBy0rV9f+CXH259RUoP+RM2lZKd0oCiDPnH1vdVgD9o/6sZ5R6miX3on0G0+qg9RVH+AAGdjWKwO19h3Loy9sc2G2vQu7HGqXCgnhrinjfa/Rbn2SZp9y+hOKeGY0GeNQ3qgzGVNUZE0RbCkNlC27Xw7NDCf20Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123483; c=relaxed/simple;
	bh=j0Hkr8sHi8/5STCPzojZ4wVrJ+HWHvW45PeNdOOWqaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=so1BmDGYx+0aCg+POgrepF/Dq+3VDY8kHRSmWYjP+Kpu4l1gTMuPpyZtSLxWQVrQ1IIkQeYGuixIGsxw8+OfiaO8IkgoXSpK4fbMGagzte+jBYCv8c2PYAL3D0EYX6U7QvRSO8vDhXYG85hzwflG5d1dQNNCbusw1Z2006pA9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVKUlqpI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758123482; x=1789659482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j0Hkr8sHi8/5STCPzojZ4wVrJ+HWHvW45PeNdOOWqaw=;
  b=XVKUlqpIr+0K+pdVz3gyn0C3N655YnqHFbYZ+uM6MzwDqagsdYRNs65i
   UCSfsUY8UcdtvkDxiNp/oAzSi50sC70UJXS6BKll1st3gwSrBvPGeVp56
   WoorY0J9cB/oT2vPCuoiQW25FE0Zd/lqsiCgqwAQ6VnzvAtPLH3QMSF8S
   ROM/AKYKo4T8dzXtzzFKTu86A7HUyuaMSl7kEsekbW+khVVBuG2uivzdC
   ZzHchEUyR8ODLpptfpDNQ8xo3xogdzwh8VNu4C1v5Tw4wCg3HenahDOTg
   6bHPzYMxQvqJvnJXNct+ws2HTnREkp5VTfkVSLSlcZQY6qVfRjAG0tFfF
   A==;
X-CSE-ConnectionGUID: 9iIgvRqtRHKzxw6LjRZb/Q==
X-CSE-MsgGUID: oAwXQnwvSVi/VFsZD3dONQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77874161"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="77874161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 08:38:02 -0700
X-CSE-ConnectionGUID: mT5gS3xISFqKPJ/ygijklg==
X-CSE-MsgGUID: EPitxodfQSe2edfO9y6SWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="180413389"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.223]) ([10.125.111.223])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 08:38:01 -0700
Message-ID: <fd83a975-8ea8-4117-9e1d-b122d1ee7f48@intel.com>
Date: Wed, 17 Sep 2025 08:38:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/20] Add CXL LSA 2.1 format support in nvdimm and cxl
 pmem
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Neeraj Kumar <s.neeraj@samsung.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com,
 a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
 cpgs@samsung.com
References: <CGME20250917134126epcas5p3e20c773759b91f70a1caa32b9f6f27ff@epcas5p3.samsung.com>
 <20250917134116.1623730-1-s.neeraj@samsung.com>
 <20250917155053.00004c03@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250917155053.00004c03@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 7:50 AM, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 19:10:56 +0530
> Neeraj Kumar <s.neeraj@samsung.com> wrote:
> 
> 
> Hi,
> Not sure what difference between the two versions I'm seeing is.
> Patch 02 is missing in both of them.
> 
> Jonathan
> 

Neeraj,
If you resend the series again with patch 2 included, please add the prefix RESEND in the patch subjects. Thanks!

