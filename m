Return-Path: <linux-kernel+bounces-794310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B9B3DFDE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F2C7AF9B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51E30DEC0;
	Mon,  1 Sep 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVsKYkO0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66822EE268;
	Mon,  1 Sep 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721678; cv=none; b=HNV3EOvf3AIV0Dd8ylfNnojOOx1/DbkTIpB/hMVp2FNX3ExEeQtMjwoHSU9IcMkg2ITGyDzlfsfIIz2hnhLsGtdGl65gLxKAOG7SJWRISxaq/QXeUkVdEdtp7sLMkUozrGiyTC9tLZwV8YHNH20MLnrB01JcO1+N3egGR8hgIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721678; c=relaxed/simple;
	bh=++rslcevR8QjmGoAcvJL5azDRHJk0uixOjvrEL/xZR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3JgvxZ9psfLCyDvIBbHfloU58D4q5iqZ1FlftJeESbQMM9rzWyX96zqVPeNSF2lMb/TMn3H0Ev2Jj9y6iY9mjTfaULwc0fGys0iaZQdeXsnpv7h4cX8UDsNxxjwEA9jAOIXRCx6MhaiIXlEd0YN4fPrBltkOTULpy53bufbmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVsKYkO0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756721677; x=1788257677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=++rslcevR8QjmGoAcvJL5azDRHJk0uixOjvrEL/xZR4=;
  b=VVsKYkO0nfUcOcxYEeXq2jzHU3w06/UT4pLN2oILnUBAqs/YpJPNZ5XA
   GizyrfCwr0+orN8TACyapokEqGRCIckDXio0a2sz5lF8PEtmdhBqdhhYV
   vBIMvpUt54bBGug2OhuM9u00AzU3HUiSiugKX//ASztABxHOnBPWkH4R9
   bBcmtybmtMNO4TJSLzV5uRXt+NueLZzm3D8/ADr+RwZka1cVH0YJXI3c1
   PJy7+d+JCk4vHD26D9KvxRtgeKmHP84bLzFYbYTj1dpDPJdO5tmkQ7M4K
   THBLhLWRXhNE6hkQsdgY6xGagXKeg8wTzEBfyQbBX7aoCmXz0OIeo8oWH
   Q==;
X-CSE-ConnectionGUID: wpQJ7XdeQziN+uIN7rCOyg==
X-CSE-MsgGUID: Es4humV3RZW/yrk5oz+8+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="46557119"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="46557119"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 03:14:36 -0700
X-CSE-ConnectionGUID: Uef/WmyORcS59GHhWDr9YA==
X-CSE-MsgGUID: jO5WfRq2SpShvbeGn9wU5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201911481"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.170]) ([10.245.244.170])
  by orviesa002.jf.intel.com with ESMTP; 01 Sep 2025 03:14:34 -0700
Message-ID: <f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
Date: Mon, 1 Sep 2025 13:14:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 6.17-rc3] usb/xhci: possible memory leak after
 suspend/resume cycle.
To: David Wang <00107082@163.com>, =?UTF-8?Q?Micha=C5=82_Pecio?=
 <michal.pecio@gmail.com>
Cc: WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, surenb@google.com, kent.overstreet@linux.dev
References: <20250829181354.4450-1-00107082@163.com>
 <20250830114828.3dd8ed56.michal.pecio@gmail.com>
 <5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.8.2025 13.17, David Wang wrote:
> 
> At 2025-08-30 17:48:28, "Michał Pecio" <michal.pecio@gmail.com> wrote:
>>
>> Hi,
>>
>> Good work, looks like suspend/resume is a little understested corner
>> of this driver.
>>
>> Did you check whether the same leak occurs if you simply disconnect
>> a device or if it's truly unique to suspend?
>>
>>> And bisect narrow down to commit 2eb03376151bb8585caa23ed2673583107bb5193(
>>> "usb: xhci: Fix slot_id resource race conflict"):
>>
>> I see a trivial bug which everyone (myself included tbh) missed before.
>> Does this help?
>>
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index f11e13f9cdb4..f294032c2ad7 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -932,7 +932,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
>>   */
>> static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_id)
>> {
>> -	struct xhci_virt_device *vdev;
>> +	struct xhci_virt_device *vdev, *tmp_vdev;
>> 	struct list_head *tt_list_head;
>> 	struct xhci_tt_bw_info *tt_info, *next;
>> 	int i;
>> @@ -952,8 +952,8 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
>> 		if (tt_info->slot_id == slot_id) {
>> 			/* are any devices using this tt_info? */
>> 			for (i = 1; i < HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
>> -				vdev = xhci->devs[i];
>> -				if (vdev && (vdev->tt_info == tt_info))
>> +				tmp_vdev = xhci->devs[i];
>> +				if (tmp_vdev && (tmp_vdev->tt_info == tt_info))
>> 					xhci_free_virt_devices_depth_first(
>> 						xhci, i);
> 
> I confirmed this *silly* code is the root cause of this memory leak.
> And I would suggest simpler code changes (which is what I was testing):
> 
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 81eaad87a3d9..c4a6544aa107 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -962,7 +962,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
>   out:
>          /* we are now at a leaf device */
>          xhci_debugfs_remove_slot(xhci, slot_id);
> -       xhci_free_virt_device(xhci, vdev, slot_id);
> +       xhci_free_virt_device(xhci, xhci->devs[slot_id], slot_id);
>   }
>   
>   int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
> 

Thanks to both for catching this

I can quickly turn this into a proper patch unless one of you would like to submit one?

Thanks
Mathias

