Return-Path: <linux-kernel+bounces-853804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE65BDCA16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F303A0122
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D7272E4E;
	Wed, 15 Oct 2025 05:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEspjceI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE8E555
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507124; cv=none; b=oNzlTvkilZjW3g6eBUtKN0509l3icshKUTRuQRl9vgMzs1yLGhaAlx4IxjbOKb+GmhrUCZuozBuFceq+nOdbjlLNl9PpN4teZhQP/FqwC0ctAJVxxMaaMt0Ba7chjf1I3BeueeQ952ffHXg0A+/0/hqjFDfFtY/qGwhgmwl/skQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507124; c=relaxed/simple;
	bh=7t4WHmGMZOMUvkBaKzuB50AlbNaTvFFiF6i/fWevqf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtjjfpwGYhmNfFZc0RBZojZqwGdqLWzTQaC0wfMx0gdzkNOiq5a/D0xa3zmvSmdRaPk0NyXPzY5NpnbtQT77hSSU1o0AvdTjfbazb6rfESFhjuCqEJlStK2KnVhKCMdtmiYqzNrmn2HrKruTzqVa3rUmVXeG8m2gTz/qoANW5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEspjceI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760507123; x=1792043123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7t4WHmGMZOMUvkBaKzuB50AlbNaTvFFiF6i/fWevqf4=;
  b=oEspjceI1iV8NnZA2bsQMDA2IIqH34yk4+opXgRDrcZ+pTPh6enDydgQ
   6tRzEYPYeqSDaNN8Ax5K+t0njPu4I/0immULoxSNEJQijAY+LzjaG5L/4
   1pfV8cTokipux3O/mGJrZhMvDsuJO6RX9iwMN+jzsdwHH0u2HgON2r7MY
   YwVeMJNDoWbUwVqpsBzu35zHW/3CwM1bc6GswGsgtOgj5cMekrWDWPaXK
   D/FT+CQkbdrN4PYmharbfYF20qM/jrHNEoNGCu6zOWdA9pUazZdGIM02z
   YrY5aGMy8CgQQVmjHTzGDRllay/bpXGVqXMRP/CV9/aHQ9GAwiFrCcWKq
   Q==;
X-CSE-ConnectionGUID: gaM+xAaZR7KuW+M/c8YXRg==
X-CSE-MsgGUID: a70lN4FpQBCe1cgVQ6dBlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="65294033"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="65294033"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:45:21 -0700
X-CSE-ConnectionGUID: rXO3+RVUTyCu6YukaLG17w==
X-CSE-MsgGUID: LbxYOTXbR16gXOZDUB9aHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205776314"
Received: from nneronin-mobl1.ger.corp.intel.com (HELO [10.94.249.136]) ([10.94.249.136])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:45:19 -0700
Message-ID: <20b455f6-829a-43e8-83a8-5ee0eb9bbaf0@linux.intel.com>
Date: Wed, 15 Oct 2025 08:45:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Suspend regression in v6.18-rc1
To: Phillip Susi <phill@thesusis.net>, linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <871pn5j6vm.fsf@vps.thesusis.net>
Content-Language: en-US
From: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
In-Reply-To: <871pn5j6vm.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/10/2025 4.22, Phillip Susi wrote:
> I have a suspend regression in v6.18-rc1 that results in this in my
> dmesg when I try to suspend:
> 
> [   36.739259] Freezing remaining freezable tasks
> [   36.740378] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   36.740414] printk: Suspending console(s) (use no_console_suspend to debug)
> [   36.783363] xhci_hcd 0000:51:00.0: Root hub is not suspended
> [   36.783366] xhci_hcd 0000:51:00.0: PM: pci_pm_suspend(): hcd_pci_suspend [usbcore] returns -16
> [   36.783378] xhci_hcd 0000:51:00.0: PM: dpm_run_callback(): pci_pm_suspend returns -16
> [   36.783383] xhci_hcd 0000:51:00.0: PM: failed to suspend async: error
> -16
> 
> I have bisected it to this commit:
> 
> commit 719de070f764e079cdcb4ddeeb5b19b3ddddf9c1 (HEAD)
> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
> Date:   Thu Sep 18 00:07:22 2025 +0300
> 
>     usb: xhci-pci: add support for hosts with zero USB3 ports
>     
>     Add xhci support for PCI hosts that have zero USB3 ports.
>     Avoid creating a shared Host Controller Driver (HCD) when there is only
>     one root hub. Additionally, all references to 'xhci->shared_hcd' are now
>     checked before use.
>     
>     Only xhci-pci.c requires modification to accommodate this change, as the
>     xhci core already supports configurations with zero USB3 ports. This
>     capability was introduced when xHCI Platform and MediaTek added support
>     for zero USB3 ports.
>     
>     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220181
>     Tested-by: Nick Nielsen <nick.kainielsen@free.fr>
>     Tested-by: grm1 <grm1@mailbox.org>
>     Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
>     Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>     Link: https://lore.kernel.org/r/20250917210726.97100-4-mathias.nyman@linux.intel.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> It sounds like it may be related to these errors that I have had on this
> system since I built it last year:
> 
> Oct 14 20:55:36 faldara kernel: hub 10-0:1.0: USB hub found
> Oct 14 20:55:36 faldara kernel: hub 10-0:1.0: config failed, hub doesn't
> have any ports! (err -19)
> 
> I believe this system has a usb hub with "zero ports" that this patch
> was meant to fix, but up until now, has only resulted in this beign
> dmesg error.  I no longer see this error after this commit.
> 
> This is an ASrock 650E Taichi Lite motherboard I built last year.
> 
> What additional information can I provide?

Hi,

Thank you for reporting.

I believe this might be related to the issue in this thread:
https://lore.kernel.org/linux-usb/CABpa4MA9unucCoKtSdzJyOLjHNVy+Cwgz5AnAxPkKw6vuox1Nw@mail.gmail.com/

The specific fix:
https://lore.kernel.org/linux-usb/20251013100424.42d5b9d2.michal.pecio@gmail.com/

Best Regards,
Niklas


