Return-Path: <linux-kernel+bounces-880446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D07C25C07
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A2D4004E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB222C326D;
	Fri, 31 Oct 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIBqVAyg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8CF2C08C2;
	Fri, 31 Oct 2025 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922847; cv=none; b=dvDMex4LDsFKuwnBQ5OGrFImIbjFteoQ1qWNbho6tL11QpiZimsNyhe5jbFbKy/EPMfcoW7Md1yAlHn/vzuEZyE7ANHuzvsqgr9EcVG+0E1XauA/eut0hYPTTLwfsRnL8iQgnYNpQjG9KXwrmb0l1FiVs4MVuoioEmtzprCCjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922847; c=relaxed/simple;
	bh=2992/aGiepAvk4rFlzjAqZ8Bo4XcpdcVK6JMUKNBlaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIHc72x1GrNOuh19fc/nuW4SmVHBXBfp88fwf9gx96Usfty3bG8n/2fwyZ1bjQsWAnq0F9Iq+9QbHXBgOc2pm+A8XXYeYXCjKXPNPsa5C8T1wnWak79yQt8Jo7XzIV6CkhR1FCvldZ0MeH4ybYBqBDe2aW7/JX5d+M3TMQvCV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIBqVAyg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761922846; x=1793458846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2992/aGiepAvk4rFlzjAqZ8Bo4XcpdcVK6JMUKNBlaE=;
  b=XIBqVAygUI1B6F1GaxkkEG6PAPoqcqVsXgFMHFdYTVuYRk8BBtrZ+klR
   WN36fmyJsRK1DOFdkmWY666f8kQdVkM3ZBFkfRRUb19QshqsS/eSN7MTi
   FfuIzmCF5gi2w+6mhYXNhyUDVevhCCHh2BZNVV1rvcUFueNMBIbdlONyx
   d3PnPefPGO2JNN8SgfdtmVRehBGfFp/R4/eJgTuRK5HWUF1QwIrodX+Uu
   vj6giLrOkhi/9tE56zAmXxV2EHQjWjKdzr1ecfesdWlppnDTTp5yWmEa5
   NnYZk1fhrwECB8LV8vJoNve03gVQU4Lu2RhMpoWt++6XdVZ3QFeKlmtuD
   g==;
X-CSE-ConnectionGUID: kpgdRF7YTDGCaCiwc+Eo3A==
X-CSE-MsgGUID: czScV5n1Q3ST+llnrL0+Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63289446"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63289446"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:00:45 -0700
X-CSE-ConnectionGUID: CgDdVfnCTe+n/AziIk2UJA==
X-CSE-MsgGUID: bRalChfrTwmqPTpZDoioMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186995712"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.245.244.92]) ([10.245.244.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:00:44 -0700
Message-ID: <2797d75d-693f-4a99-9465-a340f956cc4f@linux.intel.com>
Date: Fri, 31 Oct 2025 17:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: xhci: Fix a format bug
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251016182813.3d10a8a3.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251016182813.3d10a8a3.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 19:28, Michal Pecio wrote:
> The width of 'addr' depends on kernel configuration and gibberish is
> printed in traces and dynamic debug on some 32 bit systems like ARM:
> 
>    Removing canceled TD starting at 0xf9c96eb0 (dma) in stream 0 URB 54e247b5
>    Set TR Deq ptr 0x205400000000000, cycle 0
> 
>    Successful Set TR Deq Ptr cmd, deq = @f9c96ef0
> 
> Fix it by casting to 64 bits. No effect on unaffected systems.
> Remove the newline which casuses an empty line to appear next.
> 
> Fixes: d1dbfb942c33 ("xhci: introduce a new move_dequeue_past_td() function to replace old code.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>   drivers/usb/host/xhci-ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index c7f658d446cd..6d799a5a062d 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -776,7 +776,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
>   	ep->queued_deq_ptr = new_deq;
>   
>   	xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
> -		       "Set TR Deq ptr 0x%llx, cycle %u\n", addr, new_cycle);
> +		       "Set TR Deq ptr 0x%llx, cycle %u", (u64) addr, new_cycle);


Why not %pad and &addr instead?

Thanks
Mathias

