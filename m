Return-Path: <linux-kernel+bounces-806450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CF9B496EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A59B7A8E19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F221B9D2;
	Mon,  8 Sep 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBSVPuQS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE930F939
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352569; cv=none; b=W0xumn3dsGiQ0j/iPo/0sLKy8NBLL7L4PxOCdW3C8GkDeP9FiERV3w8sRVGIGXJ30UtX7aXnrC8qoACJTobz+emjZXuDQ0w65SsfPKJ907pzp2Wq4yKvmfEg6/IzhNpjgz6bnTFa7Xze39BlVcXgMqd7aVhsK8TRml+8tM4//ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352569; c=relaxed/simple;
	bh=2jVIlp4YJQWSApvNNX81mwY2g6Tsq2fudoG/2z4lnWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLJgLOYGqN8cxtU6wUgtpyXb5JfmJ6VXqKsWUfifKQ+QRHvH/nufQiu35TT2CWSc6OatKzDm6CRObZtpJdGEv0eQ91BNrhoGPor21oWuQYhgnaTqDO/rOEZHyAGMpS9kFpN0tKDFgED5/ZZx2s7pfVRkM/ryhlHA59QClVJfHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBSVPuQS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757352568; x=1788888568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2jVIlp4YJQWSApvNNX81mwY2g6Tsq2fudoG/2z4lnWc=;
  b=PBSVPuQSyEXuZHvBSBkmaXozaZ1sRJCreQj2vlbhe0ZbUbFQLD0N62pu
   hne3p0cjs9yoiAoVP9MAavYgJkdNnE0oRssDh26wUtv8o/Xq73EHbwSO5
   49wn6JECN0/Dm7gGRNEk9ifzX8R8kDW1IgWjmF+Ezk6Km/Md1+6gV4/1n
   J5DI+OezsOKItQ2eRQ3JJzjkohNVpsrtskLA6l2jYxE4pc4zULASRSbIg
   lI5ksuObIDzAaa9QaIOO1kk0iPvvcUisFQqTheAFTdDT4CJQyGw1hzm/U
   7hDXEz0R1ciijtNxtEaFPRLFewh58dPLc43yFwxTan5nAvU4BFp3SJhyF
   A==;
X-CSE-ConnectionGUID: wwZfKzADQeCyWvt6QJMb+w==
X-CSE-MsgGUID: /rJDR+4zSZeACkSaHVuJfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70318567"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="70318567"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 10:29:27 -0700
X-CSE-ConnectionGUID: QPUdSPTTR/25a62lTvwe8Q==
X-CSE-MsgGUID: K+3AOsuYT0atUKylbWvkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="172774866"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.113]) ([10.125.110.113])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 10:29:26 -0700
Message-ID: <32e8ab29-40d3-46e2-974a-a75d79bca440@intel.com>
Date: Mon, 8 Sep 2025 10:29:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH fwctl 0/2] fwctl/mlx5: Add few new FW rpc commands
To: Saeed Mahameed <saeed@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>
References: <20250908165256.1255985-1-saeed@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250908165256.1255985-1-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/25 9:52 AM, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Hi Jason and Dave,
> 
> This series adds few new commands to fwctl/mlx5 driver:
> 1) Adjacent function query commands and their scope
> 2) Modify congestion status command
> 
> For more details please see each patch description.
> 
> Thanks,
> Saeed
> 
> Avihai Horon (1):
>   fwctl/mlx5: Allow MODIFY_CONG_STATUS command
> 
> Saeed Mahameed (1):
>   fwctl/mlx5: Add Adjacent function query commands and their scope
> 
>  drivers/fwctl/mlx5/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Straight forward enough, mlx5 specific adds
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

