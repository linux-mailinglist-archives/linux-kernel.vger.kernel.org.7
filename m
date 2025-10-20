Return-Path: <linux-kernel+bounces-860729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2703BF0CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C89064F2F87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB9258CEF;
	Mon, 20 Oct 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmuP3qj6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A2208D0;
	Mon, 20 Oct 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959234; cv=none; b=R4xnb8LPMeC9igKcea6hcfFsmRJZ+Z+yI6LFNzlPTOzr4M4/4WsVh+WkSHdToIW1jSBNUo2Y5cfEgvxTOpBGlH+f6l5sWLc1yW8c18GiB8i2mXISNJsi2G2mfTIBE5OobqurX8sZhzaLWzlq23v72V8M0tYOWWw71SDHAKTK5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959234; c=relaxed/simple;
	bh=mDRQWXzSYZahm5NMGIH5SvQ3MedKjqzuFcwyoAwpRms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABkzhOXlyqvNNZagRJQ77HF7AILM9fk7at3DPwEolKmrikJeKgS2A/8IVW2l+iA3amQ5UnvlDyAVl6tIFy7CzXS8xOJPEySF8h0vzuotsmDsoCxJj+ADQbYLLjiaKJC4uSwCGJiKd4S8oboUtBLp3GMH+sJYnwhqlxzwnnoI0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmuP3qj6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760959232; x=1792495232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mDRQWXzSYZahm5NMGIH5SvQ3MedKjqzuFcwyoAwpRms=;
  b=QmuP3qj6LbMBcjYWqASEcyvQFw8hricwQmCC2EQh3AO2c6/CT36QPZFE
   edZmgSuW3ZNSsDob+bkdFh4QulX63ivMXktzxI69rdy5g1gklF0ZvJmya
   LqX/8gPEhArw7U5oqU+qjfLZKPw20Gxx0ZHAXimXUL3JsAERFIB7PlZ+S
   DLv/U4jvC0k1C2NyxnFjYzWOg9aLIvjAe0ZC2ci+DGdtMSohNfjfb8YXx
   gB2QjTb91VhMxhoGS2xVXbxhgh9TUBqnmV92A6cNzDINrGtZWa+or0H8S
   A7uiAdfo6sVEvQP1KI9lUVAM3bLWe2NO2W/VR8mPzH6DNOY3rMSI5C5JD
   Q==;
X-CSE-ConnectionGUID: eUaAnecgTnqtYraKiSwzKA==
X-CSE-MsgGUID: XToe6vSKSHmmMbcfy48QxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62280933"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="62280933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 04:20:31 -0700
X-CSE-ConnectionGUID: 32/FN154RG6R8K5jqePOCQ==
X-CSE-MsgGUID: /gMrjbSuRX2ZBPKM9+F/JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183321724"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.245.17]) ([10.245.245.17])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 04:20:30 -0700
Message-ID: <7d19444c-930e-4f43-b7bc-00c746d38cc0@linux.intel.com>
Date: Mon, 20 Oct 2025 14:20:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: xhci: limit run_graceperiod for only usb 3.0
 devices
To: Hongyu Xie <xiehongyu1@kylinos.cn>, mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017121254.2887283-1-xiehongyu1@kylinos.cn>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251017121254.2887283-1-xiehongyu1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 15:12, Hongyu Xie wrote:
> run_graceperiod blocks usb 2.0 devices from auto suspending after
> xhci_start for 500ms.
> 
> Log shows:
> [   13.387170] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
> [   13.387177] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
> [   13.387182] hub_suspend:3903: hub 7-0:1.0: hub_suspend
> [   13.387188] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
> [   13.387191] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event
> [   13.387193] hcd_bus_resume:2303: usb usb7: usb auto-resume
> [   13.387296] hub_event:5779: hub 3-0:1.0: state 7 ports 1 chg 0000 evt 0000
> [   13.393343] handle_port_status:2034: xhci-hcd PNP0D10:02: handle_port_status: starting usb5 port polling.
> [   13.393353] xhci_hub_control:1271: xhci-hcd PNP0D10:02: Get port status 5-1 read: 0x206e1, return 0x10101
> [   13.400047] hub_suspend:3903: hub 3-0:1.0: hub_suspend
> [   13.403077] hub_resume:3948: hub 7-0:1.0: hub_resume
> [   13.403080] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
> [   13.403085] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
> [   13.403087] hub_suspend:3903: hub 7-0:1.0: hub_suspend
> [   13.403090] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
> [   13.403093] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event
> [   13.403095] hcd_bus_resume:2303: usb usb7: usb auto-resume
> [   13.405002] handle_port_status:1913: xhci-hcd PNP0D10:04: Port change event, 9-1, id 1, portsc: 0x6e1
> [   13.405016] hub_activate:1169: usb usb5-port1: status 0101 change 0001
> [   13.405026] xhci_clear_port_change_bit:658: xhci-hcd PNP0D10:02: clear port1 connect change, portsc: 0x6e1
> [   13.413275] hcd_bus_suspend:2250: usb usb3: bus auto-suspend, wakeup 1
> [   13.419081] hub_resume:3948: hub 7-0:1.0: hub_resume
> [   13.419086] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
> [   13.419095] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
> [   13.419100] hub_suspend:3903: hub 7-0:1.0: hub_suspend
> [   13.419106] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
> [   13.419110] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event
> [   13.419112] hcd_bus_resume:2303: usb usb7: usb auto-resume
> [   13.420455] handle_port_status:2034: xhci-hcd PNP0D10:04: handle_port_status: starting usb9 port polling.
> [   13.420493] handle_port_status:1913: xhci-hcd PNP0D10:05: Port change event, 10-1, id 1, portsc: 0x6e1
> [   13.425332] hcd_bus_suspend:2279: usb usb3: suspend raced with wakeup event
> [   13.431931] handle_port_status:2034: xhci-hcd PNP0D10:05: handle_port_status: starting usb10 port polling.
> [   13.435080] hub_resume:3948: hub 7-0:1.0: hub_resume
> [   13.435084] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get port status 7-1 read: 0x2a0, return 0x100
> [   13.435092] hub_event:5779: hub 7-0:1.0: state 7 ports 1 chg 0000 evt 0000
> [   13.435096] hub_suspend:3903: hub 7-0:1.0: hub_suspend
> [   13.435102] hcd_bus_suspend:2250: usb usb7: bus auto-suspend, wakeup 1
> [   13.435106] hcd_bus_suspend:2279: usb usb7: suspend raced with wakeup event
> 
> usb7 and other usb 2.0 root hub were rapidly toggling between suspend
> and resume states. More, "suspend raced with wakeup event" confuses people.
> 
> So, limit run_graceperiod for only usb 3.0 devices
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>

Sounds reasonable. I don't recall USB 2.0 devices needing this.

Hub driver has also changed a bit since the xhci run_graceperiod was added.
USB 3 hubs are no longer aggressively runtime suspending after resume. See:
8f5b7e2bec1c usb: hub: fix detection of high tier USB3 devices behind suspended hubs

We could possibly get rid of the whole xhci run_graceperiod by extending the hub driver
change to cover both init and resume paths.

This patch is a good step in that direction

Thanks
Mathias


