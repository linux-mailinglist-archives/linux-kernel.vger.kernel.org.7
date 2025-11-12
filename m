Return-Path: <linux-kernel+bounces-896559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30461C50AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FBF189811F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5C2DBF40;
	Wed, 12 Nov 2025 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTB+v3NM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112B35958;
	Wed, 12 Nov 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928047; cv=none; b=J+F09p3kO5s53sNO82CAFXzRqoATppIRecJ62G13myzj5wPgYIoCCD5yBV22yQG13uTSqhK8XzUEHLRV4UqSP6zeLAIhn4KGyKpVIKmc0T0vS3uWbML3Jcf9FggusMPNyb7zxQhLKxNgzqpXig7P4Hhsm2w/8INDvo1o71Y1AM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928047; c=relaxed/simple;
	bh=G5iECnerdsVT4LC6jCWPFJW8NjU+pWzUl9LUg8UPdS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrohlA2BNAIKPHnsvxeOT1NVVxOmFrVSOMcqicTPCwVclBx+ue1XHOipz2KQ+DB8+xMPeCPkGKiQe7gj/Cy7o4U90Rl0RisXo9Glz4+Jzyz2DJgUd55NhUg6Tk1s7vj13V3oNvt+E7i96beXjNDRHUDPTGII5RMX7zbEe0NPqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTB+v3NM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762928045; x=1794464045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G5iECnerdsVT4LC6jCWPFJW8NjU+pWzUl9LUg8UPdS0=;
  b=VTB+v3NMuSB+9B4sXPk+1XcquxedfQit3ZXhrxUg1LOUbE0ZBeregZIR
   2hvIes5bpidoi65KW1EVjGpauCn4z6MxoVB4UfFHsA/kQJPIpRTt7yLFn
   jnbxQUbaTTwudVcfu+Uu9EpwPtIDAVKZXFbpp1x4wMDp+aDDrWI3eZHQS
   yGZERiOMOhotcWCWmr0BHu4Cy8PKInGGVP/smLluMR3TOwiK/z9jtx9E1
   kjCyPSsAfOrUZQhkWnijiXuxj331hYK92kJ9TiIluMlf0EbUnHslmFnx+
   8A55XV3+K3UOxJBORojqz4wns7y8h2uLrAKLV+scGIOAYIy2g85q0PUgL
   w==;
X-CSE-ConnectionGUID: pjYLlPz8Sse/F4vvq7ly9A==
X-CSE-MsgGUID: 1yWYr1moQ2Swan4XGu1rKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="68847726"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="68847726"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 22:14:04 -0800
X-CSE-ConnectionGUID: IgPIk0HvSlWi8rgYEjGXFA==
X-CSE-MsgGUID: d+pvoL3VSaihQb/3BgbAkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="212528421"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.246.105.97]) ([10.246.105.97])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 22:14:03 -0800
Message-ID: <679f8b6d-727e-44b2-abd8-714dffc35228@linux.intel.com>
Date: Wed, 12 Nov 2025 14:13:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] soundwire: send multi sections in one BPT stream
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
References: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
 <aRQXWpLqDm8EduYN@vaman>
Content-Language: en-US
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <aRQXWpLqDm8EduYN@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2025 1:12 PM, Vinod Koul wrote:
> On 21-10-25, 17:43, Bard Liao wrote:
>> Currently we send a BRA message with a start address with continuous
>> registers in a BPT stream. However, a codec may need to write different
>> register sections shortly. It makes more sense to send different
>> register sections in a BPT stream and no need to close/open the BPT
>> stream repeatedly.
>>
>> This series depends on the "ASoC/soundwire: add fake BPT frame to align
>> Intel DMA buffer size" series. Sending it now to get more review time.
> 
> I have applied it on top of above series, pls check why it is not
> applying in :
> error: patch failed: drivers/soundwire/intel_ace2x.c:156
> error: drivers/soundwire/intel_ace2x.c: patch does not apply
> 

Hi Vinod,

I just tried "git am" this series again and it can apply on top of
04878e873d94 ("ASoC/soundwire: add fake BPT frame to align Intel DMA
buffer size").
Also, I checked drivers/soundwire/intel_ace2x.c line 156 and it has the
same content as the "soundwire: introduce BPT section" patch.
Sorry, I have no idea why it didn't apply. Could you please try again?


