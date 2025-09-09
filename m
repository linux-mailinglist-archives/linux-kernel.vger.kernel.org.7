Return-Path: <linux-kernel+bounces-808217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580AAB4FC01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0990017DEAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E2933CE9D;
	Tue,  9 Sep 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkUKeMv+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4EF9C1;
	Tue,  9 Sep 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423078; cv=none; b=rZIf3Y31SBEuk5CFOxIQBtogMfjaoT2dWKVZ8sRS8raoJv3TcCVVfXHxfId8rT7sHRARApPCLOKYH3nDNKDnP5J75wLVPEkUu1UZGVGyjDcdmyb1Iz6Z0fZShtNci7dvkzYoFxWVdg+fq52opSXH0xGoW/2BiCpOO3+ZCdM1RVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423078; c=relaxed/simple;
	bh=2XAecwrmpL2ME82rkHSXihuD/QhtSEyswB/Tapt+0cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxkL6cDTbNoRFHpNwPlMfsDTgma0D0XGGwrHvuagvEir7JOC279jyyCzuTvw3E6Mpc2n4bRJzW6EUOKnN3RbezHAUUKXT1Q5ddlTzwMSyPoG4tVyJHRFZfWgw1Pqk237K1B0N6q0fmxtK9QKIXNf0AKmjVDCDbFLJzOpz+WyUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkUKeMv+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757423077; x=1788959077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2XAecwrmpL2ME82rkHSXihuD/QhtSEyswB/Tapt+0cQ=;
  b=jkUKeMv+FRDepHrn4fdGWRqXgxlbP3Iy/X5KUVxRimHtH2VGvMnxkjew
   hVNzeEKZtI68n9PB057yRwQOP0NH23eDBGHL9slS8cxiVy8DX3D2dZE5t
   qrqdEIZR162nzkfcpv6/6TV2qlRCUvYzW9hXVImwc70JN8VSW2vE6opEk
   Br5wxrJnrWVanPKdSMmGstQjgF12dSxTH8csJuiXVKn0pQVK3MCEk84eq
   cqtTS36J3KUyEx4u68WyX70An5/nxvS0zEy6MylhLTwXTBslpL7KKEuio
   833+ktnvdbInjp6wkTXseI/lENXcHq1an0x3vw2bt1mJlV9WVnyXMNztk
   Q==;
X-CSE-ConnectionGUID: CTKfm2wkSMiQiXLl4cvdUQ==
X-CSE-MsgGUID: ikXLcoBDS3WcSDPlSh7GRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="62332874"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="62332874"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:04:36 -0700
X-CSE-ConnectionGUID: EKr4eiYkS2q3SOwhsjGziw==
X-CSE-MsgGUID: Jd/DxpVWSzavxrF7NxmweQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="203855368"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.110]) ([10.245.244.110])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2025 06:04:35 -0700
Message-ID: <6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
Date: Tue, 9 Sep 2025 16:04:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250908130128.7ed81912.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8.9.2025 14.01, Michal Pecio wrote:
> Hi Mathias,
> 
> I wanted to finish and send v2 of "Simplify TD cancellation and drop
> some states" over the weekend, but I encountered an annoying roadblock
> and I need your input.
> 
> Basically, there is a bug: URB_ZERO_PACKET is queued as two TDs, and
> when the first TD halts, the driver simply advances to the second one.
> 
> I found that extending the event handler to cover this case requires
> multiple changes:
> 
> 1. obviously, all TDs must be cancelled, not just the current one
> 2. they may be given back in weird order (waiting for Set Deq), so
>     we need to store the status on urb_priv and override td->status
> 3. xhci_invalidate_cancelled_tds() would need to recognize multiple
>     halted TDs on the same URB as valid
> 
> This is doable, and I have already implemented most of it in that
> series, but there is an alternative solution: simply stop worrying
> about halted multi-TD URBs, because this is the only case and it
> can be converted to pretend that it's just one TD per URB as usual.
> 
> If you are OK with this patch, cancellation logic will be simpler,
> because this time there really are no remaining cases of multi-TD
> URBs except isochronous. This is clear in xhci_urb_enqueue():
> 

Adding the zero-length TRB to the original TD when we need to send a
zero-length packet would simplify things, and I would otherwise fully
support this, but the xHCI spec is pretty clear that it requires a
dedicated TD for zero-length transactions.

See xhci spec section 4.9.1:

"To generate a “zero-length” USB transaction, software shall explicitly
define a TD with a single Transfer TRB, and its TRB Transfer Length
field shall equal ‘0’. Note that this TD may include non-Transfer TRBs,
e.g. an Event Data or Link TRB."

Thanks
Mathias

