Return-Path: <linux-kernel+bounces-874012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5DC154F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04401188A46D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8445D33A025;
	Tue, 28 Oct 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9XBJqx6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B831815D;
	Tue, 28 Oct 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663565; cv=none; b=GPnGe0xoE9IHulL16nO4G6BUXJgJmmZQvnyOLO7K8wRvRsw0RMare7uGeTbTuW2ZUrS8xB0KrDRSV/lFeFuyrrgE9DWOZuKamDLtJD6fqRT/d+72xUboSxd8yE0kfj6A8bvZe69UQe4k+klqqiVz82pmHHjUOTkh0Cn1WCNPHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663565; c=relaxed/simple;
	bh=POA/L+Wqnaka941pgqSwTeo/9UjtqIvrexRYHF12Lgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoumgKfu36Q8VWW+ZhoaxG8oWr3q3vX9HVjBbjzlRKcoDl1myZRhjR29MbwJlUideS0d97ediFDEA6OPNd/6gHeRQPE8rD808+cKTr56Ag6DcJrW/Zz1gsjZ+rRessSDhlnDcRTRmrqx9XhL+sFaE4fu4EHq4mkMOY8q9nqrw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9XBJqx6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761663564; x=1793199564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=POA/L+Wqnaka941pgqSwTeo/9UjtqIvrexRYHF12Lgc=;
  b=a9XBJqx62yrRzqD3V6DdsqfccRZQGjHDYrvz7BifteLmzNWCPiItDBbQ
   uf0yjtybWchLD4ImIL27cGMzGyIHLowKOmZGSlv7U2LjQCgQUVUmglFC4
   57r5xFgrfHLN20TsZ8HxnwOTyqxRCMuPpBM0YefV9IcVcMYQFtIFvOsPK
   ffXkVtS2lhncTDxQ0jMa5tj0mKAFLtyFyIRZpORj6JwM9R68DrKxk26/Q
   WOqVGD+1JIHQ//n0zLy1KC+07sfKuuZibGfXZyTQK+k7vvshGmj7aaFTj
   VIxId1KIy4PSqhEO/jcXRk2jOInPCw9w99ghAjOBwjv1QUL+1YMtEdSBz
   w==;
X-CSE-ConnectionGUID: H/UMtewoRtSBMb1S9Dlz5w==
X-CSE-MsgGUID: T+GdBZ2dQ+upbA1YQzmgPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86393029"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="86393029"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:59:23 -0700
X-CSE-ConnectionGUID: mcigzqBHTMaQSbjsjyi/Rw==
X-CSE-MsgGUID: LcRU3/5gT1qnPA1r6dKsKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="189720822"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.148]) ([10.245.244.148])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:59:21 -0700
Message-ID: <db07f48d-27cf-4681-b10e-38d252e24512@linux.intel.com>
Date: Tue, 28 Oct 2025 16:59:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH] xhci: sideband: Fix race condition in sideband
 unregister
To: Greg KH <gregkh@linuxfoundation.org>
Cc: uttkarsh.aggarwal@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 wesley.cheng@oss.qualcomm.com
References: <51ca2248-5699-4c6d-b037-a57c90ed44ac@linux.intel.com>
 <20251028134452.244096-1-mathias.nyman@linux.intel.com>
 <2025102808-sublime-substance-74bb@gregkh>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <2025102808-sublime-substance-74bb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 15:56, Greg KH wrote:

>> @@ -474,16 +494,23 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
>>   	xhci = sb->xhci;
>>   
>>   	mutex_lock(&sb->mutex);
>> +
>> +	vdev = sb->vdev;
>> +	if (!vdev)
>> +		return;
> 
> Lock is still held :(
> 

Oops, missed one

> I think you need to use guard() to make this more sane.

Clearly yes, I'll send a v2

> 
> thanks,
> 
> greg k-h
> 

Thanks
Mathias

