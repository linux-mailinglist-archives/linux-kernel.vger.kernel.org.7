Return-Path: <linux-kernel+bounces-890425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0825FC4006D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA2B3A8053
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13912C0F72;
	Fri,  7 Nov 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRXwjQp4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8C29AB05;
	Fri,  7 Nov 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520832; cv=none; b=Si1u9bB6tFUbggXoTttHSWdyKqP+pA/zdtD3O8WxxFWNuua0f1EdF06kpud2y0zF7+hSudLxPeHyk3INuwGybO5QT4fNNto/GZYLAkybYxulaYWIjStgztmCZWtSWZ2JBEJfkutyb57mraGdERA/l87IC6JULA3uEX+K6Ak8Kf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520832; c=relaxed/simple;
	bh=Arh6N3NfBR0FuAyS3Jw6dWZcigtKhb6A0yhJ27FMXRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmFftgjh5HIzAnO0BQETbYZiIrFkYSOuhcDl2w+nKqG5JPuQ0dU3aN2p1GV0U317pJo761oLDSc9wXBF5RMy2jx7p5463K4+hSR9XDFkg6EEgTIzAszacdLTaKXzVCybIatd5fdGTg9tgda2/pNe+giIqliMDBsQ3s+RZe+azX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRXwjQp4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762520830; x=1794056830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Arh6N3NfBR0FuAyS3Jw6dWZcigtKhb6A0yhJ27FMXRY=;
  b=WRXwjQp4JDmtD3V0YAtsWc2fNJiiWEcaxqeApttiiisProEq+Aqr3bUb
   c8QtrVDVnVSQNoQ/MEJi0JaRIKSdB7644H6dEWALWQ4OeXO3SD9WaKJC4
   vjujv4zYDsQD/vxpGJdrLqXkIR3s/YeFa5GVf3wQk45pMiDuFnnrn7DC6
   lfua1iPwORmwYSD0vVbXCWNQGro3wHU+G+eHRHwXWvsYJ+jUJhLT3Af6V
   fLnxTZ2M1csPXnyoQHS22F9OVSgm9p/7H8bF4eptwQvKGqeFDlMJFJqQO
   150ifQ4dkQuBIe0KKvHXDmOcB/J0tLL/ukB06ALwueWlPpvyNz+yVxGos
   w==;
X-CSE-ConnectionGUID: 2aZjc/J7QX+TPqOImAJ4ZQ==
X-CSE-MsgGUID: fQWFuwgwQR2LnJEnMmtIpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64585206"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64585206"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:07:07 -0800
X-CSE-ConnectionGUID: I5m7OHzBRyKH1THxKrPSaA==
X-CSE-MsgGUID: Aay3VkqPRVKfvgV0SaNBMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192127191"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.61]) ([10.245.245.61])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:07:05 -0800
Message-ID: <5e55d9ba-6b4f-4d92-bb47-04b4a68328d2@linux.intel.com>
Date: Fri, 7 Nov 2025 15:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] usb: host: xhci: Release spinlock before
 xhci_handshake in command ring abort
To: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 wesley.cheng@oss.qualcomm.com
References: <20251022100029.14189-1-uttkarsh.aggarwal@oss.qualcomm.com>
 <8750e1e4-41fb-4fe7-b97e-9d2a26db45c6@linux.intel.com>
 <93a08563-a8f2-4004-bf91-884611b7cc7d@oss.qualcomm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <93a08563-a8f2-4004-bf91-884611b7cc7d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 11:57, Uttkarsh Aggarwal wrote:
> 
> 
> On 10/22/2025 6:19 PM, Mathias Nyman wrote:
>> On 10/22/25 13:00, Uttkarsh Aggarwal wrote:
>>> Currently xhci_handshake is a polling loop that waits for change of state.
>>> If this loop is executed while holding a spinlock with IRQs disabled, it
>>> can block interrupts for up to 5 seconds.
>>>
>>> To prevent prolonged IRQ disable durations that may lead to watchdog
>>> timeouts, release the spinlock before invoking xhci_handshake() in
>>> xhci_abort_cmd_ring().
>>>
>>> The spinlock is reacquired after the handshake to continue with controller
>>> halt and recovery if needed.
>>
>> Is this a real issue?
>>
>> It should be extremely rare that commands need to be aborted, and even
>> less likely that it takes five seconds to stop the command ring.
>>
>> Can you take logs and traces of this (if it's reproducible).
>> I suspect there is some other issue that needs to be fixed.
>>
>> I agree that keeping the spin lock for up to five seconds isn't a good idea, but
>> just unlocking before the command ring has stopped opens up new race risks.
>>
>> We need to ensure that queuing a new command mid ring abortion, before ring stopped,
>> doesn't cause new issues, or that handling command completion events, including the
>> "stop command ring" event, before polling for a stopped ring works fine.
>>
> 
> Hi Mathias,
> 
> Yes, actually when we do usb headset connected, no audio playing, resume the device and do some operations like volume +/-, there will be xhci_handle_command_timeout.
> 
> logs:
> 
> It’s wdog bark, we can see : xhci_handle_command_timeout kicked in since 68346, but not end till 68356 dog bark.
> 
> [68346.109071][T25562] [2025:09:04 23:19:02](2)[25562:kworker/2:3]lwz debug: xhci_handle_command_timeout start
> [68346.109081][T25562] [2025:09:04 23:19:02](2)[25562:kworker/2:3]lwz debug: xhci_handle_command_timeout xhci_abort_cmd_ring start
> [68346.109083][T25562] [2025:09:04 23:19:02](2)[25562:kworker/2:3]lwz debug: xhci_abort_cmd_ring start
> [68346.109084][T25562] [2025:09:04 23:19:02](2)[25562:kworker/2:3]lwz debug: xhci_abort_cmd_ring xhci_trb_virt_to_dma
> [68346.109087][T25562] [2025:09:04 23:19:02](2)[25562:kworker/2:3]lwz debug: xhci_abort_cmd_ring xhci_handshake_check_state start
> ….
> [68356.215787][    C1] [2025:09:04 23:19:10](1)msm_watchdog 17600000.qcom,wdt: Causing a QCOM Apps Watchdog bite!
> [68356.215790][    C1] [2025:09:04 23:19:10](1)[RB/E]rb_sreason_str_set: sreason_str set wdog_bite
> 
> Call Trace:
> xhci_configure_endpoint hang in below call stack.
> 
> Stack:
> __switch_to+0x1a8
> schedule+0xacc
> schedule_timeout+0x4c
> wait_for_common+0xc0
> wait_for_completion+0x18
> xhci_configure_endpoint+0xe4
> xhci_check_bandwidth+0x1a8
> usb_hcd_alloc_bandwidth+0x37c
> usb_disable_device_endpoints+0xb0
> usb_disable_device+0x30
> usb_disconnect+0xd0
> hub_event+0xc4c
> process_scheduled_works+0x208
> worker_thread+0x1c0
> kthread+0xfc
> ret_from_fork+0x10
> 
> Finally crash on dog bite.
> 
> sdei_wdg_bite_cb[qcom_sdei]+0x110
> sdei_event_handler+0x3c
> do_sdei_event+0x88
> __sdei_handler+0x48
> __sdei_asm_handler+0x110
> __const_udelay+0x148
> xhci_handshake+0x58
> xhci_handle_command_timeout+0x248
> process_scheduled_works+0x208
> worker_thread+0x1c0
> kthread+0xfc
> ret_from_fork+0x10
> 
> Based on the logs and crash stacks I have collected so far, including the watchdog bark and the prolonged execution of xhci_handle_command_timeout,
> it seems likely that there's an underlying issue causing the ring to hang during xhci_configure_endpoint.
> 
> Thanks,
> Uttkarsh,
> 

Thanks Uttkarsh

Best guess is that this is somehow related to xHC suspend/resume as xHC and command processing
are stopped during suspend. xhci_suspend() also wipes the command ring clean of any pending
command TRBs without any warning.

A suspended host could also return 0xffffffff on register read, which in turn would cause
xhci_handshake(reg, CMD_RING_RUNNING, 0, 5sec) to run for full five seconds unsuccessfully
waiting for the  "command ring running" bit to clear.

Could you add xhci dynamic debug and tracing and reproduce this?
It could show how we end up in this situation.

mount -t debugfs none /sys/kernel/debug
echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
echo 1 > /sys/kernel/debug/tracing/tracing_on
< Reproduce issue >
Send output of dmesg
Send content of /sys/kernel/debug/tracing/trace

I'll also write a testpatch with extra debugging related to command ring

Thanks
Mathias


