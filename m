Return-Path: <linux-kernel+bounces-824115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC16B8827A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986677A6FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2742C325C;
	Fri, 19 Sep 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoFrzCsc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06723FC54;
	Fri, 19 Sep 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267057; cv=none; b=S5D5EK0cM4036otQRiERchbF6j+dscc8fI0DO9y17s+EDzQgykv5uTQZ6+VETZX5GNdJzJv82CyyGRUlwIedZSEBclf3REE9VdmhnQr5eRgF+FObVp4xiba3xU+NoEVgBk80crwfMcBzJwafnmdFcDuFMAYb9LvQaXlR4HB1hkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267057; c=relaxed/simple;
	bh=tu4lV9ZsXWbxctsqdTowl+LlLmz17QLXWzaI2s1TGOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boXX6xFUjf41ZVcLus/N+GjQJIeTBeKpqpBjfmceXdsdAEmj433wlS2csF9hinGcyDpc0q70GgXGMLGZA0WacE9lHY6up/g2ZbbDmHyewzspGU4k4WdFJ30/stHqh5m21ASD4BCgPw8kMA2BSFNM0JQI9IMRqlj5/7jKpwOk5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoFrzCsc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758267055; x=1789803055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tu4lV9ZsXWbxctsqdTowl+LlLmz17QLXWzaI2s1TGOg=;
  b=JoFrzCsc5DPYem6uiEvr81WYX70xrVI/u+CLGyR4y+9rjPEdUb/GWhas
   DvjKCBMtvHTR4g8kPe/s+10Q2yH/Rl5NzAcmkF4IRLMVrDJ4lIzBG3Nc1
   7fhQndEEnMfuWH6gpzV35SX7tZUKAAnRSmR1PSrUXvuZFMjndk/t+zUC0
   HdDnVirbVmjC+QYOa3LKy8XojILQ/VgVM0jJFVzumCiw7jnOMnT4isk6r
   CGW5OZA/mky4gCeHQRZkN0sRSRzdv03QjfwfjDCFcxcIXZGvwyTJB8H45
   gMV84sOtqH/pVDgVpVWIjd3cVhiGsRaBorkCgrDPAOXKWtXKe2RSsXgxw
   g==;
X-CSE-ConnectionGUID: LnT7KWZ/SAWijXBaNNgqPA==
X-CSE-MsgGUID: sbd4maSvRPKS6+UdyPpvDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="86049698"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="86049698"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 00:30:55 -0700
X-CSE-ConnectionGUID: 11jwXtONR1epQQOa6x/e6w==
X-CSE-MsgGUID: M8Mg0OhASJWUb8784G4aEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="176207226"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 19 Sep 2025 00:30:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7D2F495; Fri, 19 Sep 2025 09:30:52 +0200 (CEST)
Date: Fri, 19 Sep 2025 09:30:52 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?B?5p2O5L2z5oCh?= <lijiayi@kylinos.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] thunderbolt: Re-add DP resources on resume
Message-ID: <20250919073052.GO2912318@black.igk.intel.com>
References: <20250917082456.1790252-1-lijiayi@kylinos.cn>
 <0540df54-efd6-4b79-90f9-ec305e1f5f7e@kylinos.cn>
 <20250917125017.GI2912318@black.igk.intel.com>
 <f0a04f70-5539-42bd-ac15-07054878acfb@kylinos.cn>
 <20250918162059.GL2912318@black.igk.intel.com>
 <20250918164330.GN2912318@black.igk.intel.com>
 <a3dd4fc5-4312-4c06-a6d7-645ae0f7b68b@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3dd4fc5-4312-4c06-a6d7-645ae0f7b68b@kylinos.cn>

On Fri, Sep 19, 2025 at 03:24:20PM +0800, 李佳怡 wrote:
> 
> 
> 在 2025/9/19 00:43, Mika Westerberg 写道:
> > On Thu, Sep 18, 2025 at 06:20:59PM +0200, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Thu, Sep 18, 2025 at 04:34:31PM +0800, 李佳怡 wrote:
> > > > 
> > > > 
> > > > 在 2025/9/17 20:50, Mika Westerberg 写道:
> > > > > On Wed, Sep 17, 2025 at 06:12:31PM +0800, 李佳怡 wrote:
> > > > > > 
> > > > > > As requested, I've attached the complete dmesg output (from boot to after
> > > > > > resume) reproducing the issue.
> > > > > > 
> > > > > > Testing Methodology:
> > > > > > 1. Start with the Targus Thunderbolt dock already connected to the system
> > > > > > 2. Enter S3 suspend (sleep) with no DP monitor connected to the dock
> > > > > > 3. Resume from S3
> > > > > > 4. After the system has fully resumed, connect the DP monitor to the dock
> > > > > 
> > > > > Thanks! It is badly line wrapped. I wonder if you can just attach it?
> > > > > Anyways I found some unexpected things there:
> > > > > 
> > > > > > [    8.647850] With USB4 patch v1.0.0
> > > > > 
> > > > > What is this? ;-)
> > > > 
> > > > Thanks for your help!
> > > > 
> > > > This is a self-compiled kernel based on version 5.4 with backported
> > > > Thunderbolt drivers. I will also attach the kernel log from a build using
> > > > the linux-6.6.y branch of the community linux-stable repository.
> > > 
> > > Okay but I really suggest using more recent kernel. 6.16 is current stable
> > > so that would be good.
> > > 
> > > > > > [    8.647860] ACPI: bus type thunderbolt registered
> > > > > > [    8.664660] [7] nhi_probe:1326: thunderbolt 0000:2c:00.0: total paths: 21
> > > > > > [    8.665209] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0: allocating
> > > > > > TX ring 0 of size 10
> > > > > > [    8.665243] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0: allocating
> > > > > > RX ring 0 of size 10
> > > > > > [    8.665267] [7] tb_ctl_alloc:665: thunderbolt 0000:2c:00.0: control
> > > > > > channel created
> > > > > > [    8.665272] [7] icm_probe:2549: thunderbolt 0000:2c:00.0: ICM not
> > > > > > supported on this controller
> > > > > > [    8.665285] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: freeing RX
> > > > > > ring 0
> > > > > > [    8.665294] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: freeing TX
> > > > > > ring 0
> > > > > 
> > > > > What is this?
> > > > > 
> > > > > Is this Intel TB/USB4 controller or something else? All USB4 compliant
> > > > > controllers should go directly to tb.c as that's the part dealing with
> > > > > software connection manager. The above looks like it tries first with the
> > > > > firmware connection manager and that should not happen outside of Intel
> > > > > Thunderbolt 3 hosts.
> > > > 
> > > > Yes, there is a mistake. I discovered that during the USB4_NATIVE_CONTROL
> > > > negotiation in the firmware, an OSC_CAPABILITIES_MASK_ERROR bit was being
> > > > set incorrectly, which should not have happened.
> > > > 
> > > > The log I will attach next has been modified to fix this issue.
> > > 
> > > [..]
> > > 
> > > > [    0.498976] [1] tb_switch_reset:1666: thunderbolt 0000:2c:00.0: 0: resetting
> > > > [    0.533329] [1] tb_add_dp_resources:217: thunderbolt 0000:2c:00.0: 0:10: DP IN resource available
> > > > [    0.533959] [1] tb_add_dp_resources:217: thunderbolt 0000:2c:00.0: 0:11: DP IN resource available
> > > 
> > > The DP IN resources were added here.
> > > 
> > > [..]
> > > 
> > > > [   19.035726] [171] tb_switch_set_wake:3445: thunderbolt 0000:2c:00.0: 0: enabling wakeup: 0x3f
> > > > [   19.037401] [171] tb_ring_stop:768: thunderbolt 0000:2c:00.0: stopping RX ring 0
> > > > [   19.037412] [171] ring_interrupt_active:141: thunderbolt 0000:2c:00.0: disabling interrupt at register 0x38200 bit 21 (0x200001 -> 0x1)
> > > > [   19.037439] [171] tb_ring_stop:768: thunderbolt 0000:2c:00.0: stopping TX ring 0
> > > > [   19.037449] [171] ring_interrupt_active:141: thunderbolt 0000:2c:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
> > > > [   19.037463] [171] tb_ctl_stop:733: thunderbolt 0000:2c:00.0: control channel stopped
> > > 
> > > Runtime suspend.
> > > 
> > > (and a couple more)
> > > 
> > > > [  266.399800] [3870] tb_ctl_start:703: thunderbolt 0000:2c:00.0: control channel starting...
> > > > [  266.399808] [3870] tb_ring_start:693: thunderbolt 0000:2c:00.0: starting TX ring 0
> > > > [  266.399821] [3870] ring_interrupt_active:141: thunderbolt 0000:2c:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
> > > > [  266.399826] [3870] tb_ring_start:693: thunderbolt 0000:2c:00.0: starting RX ring 0
> > > > [  266.399837] [3870] ring_interrupt_active:141: thunderbolt 0000:2c:00.0: enabling interrupt at register 0x38200 bit 21 (0x1 -> 0x200001)
> > > > [  266.399848] [3870] tb_switch_resume:3478: thunderbolt 0000:2c:00.0: 0: resuming switch
> > > > [  266.399852] [3870] tb_switch_configure:2590: thunderbolt 0000:2c:00.0: restoring Switch at 0x0 (depth: 0, up port: 5)
> > > > [  266.400032] [3870] tb_switch_set_wake:3447: thunderbolt 0000:2c:00.0: 0: disabling wakeup
> > > 
> > > Around this time you should see the hotplug events coming to the DP IN
> > > adapters. But there is none.
> > > 
> > > There is a bit in the DP adapter config space (DHP) that can be used to
> > > disable this but the spec says it defaults to 0. Anyways I suggest to check
> > > that (and also the Plugged bit). You can dump these using tbtools [1]. Let
> > > me know if you want help with that.
> > 
> > Nevermind about the Plugged bit, that's not applicable here.
> > 
> > Here's how to dump the DHP bit. This is from Intel host:
> > 
> > # tbdump -vv -r 0 -N 1 -a 5 ADP_CS_5
> > 0x0005 0x00004809 0b00000000 00000000 01001000 00001001 ..H. ADP_CS_5
> >    [00:06]        0x9 Max Input HopID
> >    [11:17]        0x9 Max Output HopID
> >    [22:28]        0x0 Link Credits Allocated
> >    [29:29]        0x0 HEC Error Enable (HEE)
> >    [30:30]        0x0 Flow Control Error Enable (FCEE)
> >    [31:31]        0x0 Disable Hot Plug Events (DHP)
> 
> Thank you for your help. As you suggested, I tried kernel 6.16, but the
> issue still persists.
> 
> The logs and device vendor information are included in the attachment. I
> also ran the tbdump command, and the result shows the DHP bit is set to 0.
> Does this indicate there might still be other issues?
> 
> # tbdump -vv -r 0 -N 1  -a 5 ADP_CS_5

Please run it against the DP IN adapters. That's 10 and 11. The 5 above was
just an example from Intel HW.

# tbdump -vv -r 0 -N 1  -a 10 ADP_CS_5

and

# tbdump -vv -r 0 -N 1  -a 11 ADP_CS_5

The lspci dump indicates this is ASMedia host controller. I did not even
know that they have such thing. I thought they only have device (which
should be working in Linux). The host side may require some additional
enablement.

