Return-Path: <linux-kernel+bounces-876280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C5C1B1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0CA5C07E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0415344035;
	Wed, 29 Oct 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpkJTtEK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB633F38B;
	Wed, 29 Oct 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745971; cv=none; b=FRnFKhuP6tSyyTTtfdfWGgncfrn4kt5H9j+1NVyaHUSUsnL8+lolkdnuTdXPpq9XDn+YubmuliXZOVRdeTXFHIrj8QA4/1l329YZfamRS42Ow3/wyEUvZZ4engeDywjBSazgdUzxL9aA1Fs+ZW5eKvgmd2LlzT/1mfxdZB8e/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745971; c=relaxed/simple;
	bh=uEzEVMAmlZ1UdzJzRdCeu/dkCEkm209uPwJYmbUO1aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjP4ql4IF+5toGK1OLYFfU5+eMt/deqkTIMe1iVFhKdT40GNazeAisguMDtx7rb0Ch169PThMG5ANCC48JypAC+PumJLgClP2X55ccqJYEnSlXzpISDXO0J/z9mxe//laG7kp6KV0KuMnaW4RDpYxKI9dvjbChpi9pbK892ACHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpkJTtEK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761745969; x=1793281969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uEzEVMAmlZ1UdzJzRdCeu/dkCEkm209uPwJYmbUO1aM=;
  b=jpkJTtEKRrjv6H/rZqlKOzXu3MH6D37YTcrLroUU92iuy54pWG7t4Rbq
   rF4f4iR4SXeDDvVQIqu6PC1izKg/elHpQHKvrapmdOiRxZ/PRfeoq2U6H
   2SoKwzGUSJr6mr+xuqKg3veEj2M3r00oNfoENs2ssrYDcjfMOOCjGXgC3
   eKYAVZx3ong0/bA3prDMHrY79YjeH5hIsCXCcLlSvb89Mnx+7EP+3wwj1
   KxvQbwT7K8d06JMjNwX2zKeDKRFWbspc4YMJf6U69viD2sXA9uQjLN/CE
   g68tNkSz4FvkNB2D+huItb5MkpXF4mTz5tF9IJVpbHQ5hTTMsS/0JzrG2
   g==;
X-CSE-ConnectionGUID: Ndb5QhUTTaCw6/LNJy2jvg==
X-CSE-MsgGUID: wcckYlNlRaatf6ELQtbVog==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="81496241"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="81496241"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:52:32 -0700
X-CSE-ConnectionGUID: Gn0zPnNTRW61Baw4/cfMHg==
X-CSE-MsgGUID: SMOIUL2yRIOvr/1nYT1qkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185371315"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.23]) ([10.245.245.23])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:52:30 -0700
Message-ID: <094a2124-f6c9-4510-b7ec-8df872882a7d@intel.com>
Date: Wed, 29 Oct 2025 15:52:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v3] xhci: sideband: Fix race condition in sideband
 unregister
To: Greg KH <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: uttkarsh.aggarwal@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, wesley.cheng@oss.qualcomm.com
References: <2025102948-trickery-creative-417e@gregkh>
 <20251029122436.375009-1-mathias.nyman@linux.intel.com>
 <2025102956-daunting-roping-a987@gregkh>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <2025102956-daunting-roping-a987@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 14:51, Greg KH wrote:
> On Wed, Oct 29, 2025 at 02:24:35PM +0200, Mathias Nyman wrote:
>> Uttkarsh Aggarwal observed a kernel panic during sideband un-register
>> and found it was caused by a race condition between sideband unregister,
>> and creating sideband interrupters.
>> The issue occurrs when thread T1 runs uaudio_disconnect() and released
>> sb->xhci via sideband_unregister, while thread T2 simultaneously accessed
>> the now-NULL sb->xhci in xhci_sideband_create_interrupter() resulting in
>> a crash.
>>
>> Ensure new endpoints or interrupter can't be added to a sidenband after
>> xhci_sideband_unregister() cleared the existing ones, and unlocked the
>> sideband mutex.
>> Reorganize code so that mutex is only taken and released once in
>> xhci_sideband_unregister(), and clear sb->vdev while mutex is taken.
>>
>> Use mutex guards to reduce human unlock errors in code
>>
>> Refuse to add endpoints or interrupter if sb->vdev is not set.
>> sb->vdev is set when sideband is created and registered.
>>
>> Reported-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
>> Closes: https://lore.kernel.org/linux-usb/20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com
>> Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> ---
> 
> Looks good, thanks for respinning this.  I don't know if it fixes the
> issue, but it looks sane :)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing this.

I don't have the hardware to test this myself either

Thanks
Mathias

