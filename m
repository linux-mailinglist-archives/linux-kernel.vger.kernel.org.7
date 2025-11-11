Return-Path: <linux-kernel+bounces-895814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D02AC4EFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA02E18C0BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C436A012;
	Tue, 11 Nov 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMsA7uHA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E736A033;
	Tue, 11 Nov 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877984; cv=none; b=eo5+yp24aYz8ymehaKSNFyhVvQOY3TQeL34U093qysUlIRb1GuSo5XbrN70o1FWdNaGbuugXGRaqkwP6WobjjDt7bXwSkeE+XD/DuomupJXtM8NafjIbyk4wMGw2s5plCfrwhTl5z56ihlXeod3RxbJC3uFHy0GtpZ6MoPP2r6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877984; c=relaxed/simple;
	bh=MRIv/WwWQnNcHl/Kgg27XOhKNmjLF/zVaonpwv61t9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2vz2s+wbI05AyofTycWOQdr8QRy6gx2r3fJIxIVY0XXz8ZUrpdtRj5JCBkyUxMmCpiAweEweESh4F1SeZZ9/xll09d/+ZrM6bryl07PvOPVUgacLVtrH0yxGoefaQQA1Obat+PQRTqTM1CtlR6TQ1o0cd4UfZPq9O7kkb3Kq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMsA7uHA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762877983; x=1794413983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MRIv/WwWQnNcHl/Kgg27XOhKNmjLF/zVaonpwv61t9c=;
  b=KMsA7uHATFFhW3O0tF85uxy8UUiCqQkenws3n91noLWy3Os73c2ssdLx
   8NHRduD1ABrp7LAMIddEJiFxdHYzAfsyTyKrh21P6EhGp2j0nfL69Dq/g
   ZmP2JCkuke4DwhVt1VyweMVKIizPCSjFILwTLqx/wABXttNs4mnxODjP5
   vTAqQFP3h1rEJetQFGD/4Wn9IQwAmknZt2Fkjfu4T3SoMmhp6+OnwID67
   A/r0+Buz/CSkK7OLUdudLGOzOn1P1IedjdXCN4Lc5o0qXbDnWoAeLmEoK
   t4FJzONaS8DNlIEFq7jJAQfyYmtNGxj/NEStg8KZXZO9f7sHvLTVRwyBJ
   w==;
X-CSE-ConnectionGUID: 4B1LItW8TJKND9+z4M6i7A==
X-CSE-MsgGUID: R3/Ya+FOSDKm4K1ih5SNJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="65098139"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="65098139"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:19:43 -0800
X-CSE-ConnectionGUID: ya/rlQVGT12nmby3p5vFMw==
X-CSE-MsgGUID: lMpFr96bTRadqOMq6LoGyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193247151"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.244.118]) ([10.245.244.118])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:19:41 -0800
Message-ID: <f1259e37-5671-43ca-85f5-a37b68d5507a@linux.intel.com>
Date: Tue, 11 Nov 2025 18:19:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Don't unchain link TRBs on quirky HCs
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107110837.7b7d686b.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251107110837.7b7d686b.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 12:08, Michal Pecio wrote:
> Some old HCs ignore transfer ring link TRBs whose chain bit is unset.
> This breaks endpoint operation and sometimes makes it execute other
> ring's TDs, which may corrupt their buffers or cause unwanted device
> action. We avoid this by chaining all link TRBs on affected rings.
> 
> Fix an omission which allows them to be unchained by cancelling TDs.
> 
> The patch was tested by reproducing this condition on an isochronous
> endpoint (non-power-of-two TDs are sometimes split not to cross 64K)
> and printing link TRBs in trb_to_noop() on good and buggy HCs.
> 
> Actual hardware malfunction is rare since it requires Missed Service
> Error shortly before the unchained link TRB, at least on NEC and AMD.
> I have never seen it after commit bb0ba4cb1065 ("usb: xhci: Apply the
> link chain quirk on NEC isoc endpoints"), but it's Russian roulette
> and I can't test all affected hosts and workloads. Fairly often MSEs
> happen after cancellation because the endpoint was stopped.
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>

Makes sense, thanks for fixing this

> ---
>   drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index a9e468ea19c5..fc0043ca85a4 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -128,11 +128,11 @@ static void inc_td_cnt(struct urb *urb)
>   	urb_priv->num_tds_done++;
>   }
>   
> -static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
> +static void trb_to_noop(union xhci_trb *trb, u32 noop_type, bool unchain_links)
>   {
>   	if (trb_is_link(trb)) {
> -		/* unchain chained link TRBs */
> -		trb->link.control &= cpu_to_le32(~TRB_CHAIN);
> +		if (unchain_links)
> +			trb->link.control &= cpu_to_le32(~TRB_CHAIN);
>   	} else {
>   		trb->generic.field[0] = 0;
>   		trb->generic.field[1] = 0;
> @@ -465,7 +465,7 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
>   		xhci_dbg(xhci, "Turn aborted command %p to no-op\n",
>   			 i_cmd->command_trb);
>   
> -		trb_to_noop(i_cmd->command_trb, TRB_CMD_NOOP);
> +		trb_to_noop(i_cmd->command_trb, TRB_CMD_NOOP, false);
>   
>   		/*
>   		 * caller waiting for completion is called when command
> @@ -797,13 +797,18 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
>    * (The last TRB actually points to the ring enqueue pointer, which is not part
>    * of this TD.)  This is used to remove partially enqueued isoc TDs from a ring.
>    */
> -static void td_to_noop(struct xhci_td *td, bool flip_cycle)
> +static void td_to_noop(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
> +			struct xhci_td *td, bool flip_cycle)

we could avoid passing xhci pointer to td_to_noop() and just grab it from
the xhci_virt_ep structure instead. i.e. ep->xhci

Otherwise this looks good to me

Thanks
Mathias



