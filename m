Return-Path: <linux-kernel+bounces-864960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0609BFBF87
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640713A97F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE85E348479;
	Wed, 22 Oct 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG0QACUd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D63451DE;
	Wed, 22 Oct 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137382; cv=none; b=MDv9ui8bJS4nC0CwUa287svkrrQQVGaphbbB3DgDbiaUIbrvehRK584fhk5G6nY8QvrOWuzNIlYsZHmfRQeP1m9GVvT05LsDGmZghC5WZI4QN2+ywWc5FRN8ZeVXPCZrmxkOLUeLIvvl3qA0SgVRzSMzTzMhL+EYEY+GYuzBA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137382; c=relaxed/simple;
	bh=/ZnI6BI229Yo0/6OXULrETdJyv1kLFZnayOq3DFTj/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q88YChYptwedVPB6jOW0copDIxZ8rKJokowniYFQhvqvGnd8kqORcOce44D2vMcPqENjoyBDwhLaukmqb0om7auAWukfekVmL9LurMQklXy2XorMNcYq9/sq7cR+eorVEdpVEx5EDNu8W2CvmSJgKTn2Ym0kl4Hj8cqqW/nkhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG0QACUd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761137369; x=1792673369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/ZnI6BI229Yo0/6OXULrETdJyv1kLFZnayOq3DFTj/U=;
  b=iG0QACUdEXFkHOyiMjsydqh8NVFxi/BQExDtpamK7t7o7XHWUUKZ7bxY
   I+j2/j25GyrKpPREeGZmLGbdtC5WH8zgt/FXytNlRsQwEDzuWsGs1gr0n
   NQXj2qroE1nFRrTpsjoAUaLEwiG5Y1ohm3hGgnbHD/9Wq9dM7cS1kNUrz
   n2FpsKHCalddPMTDmD1yVWfAez2G5Sg9aqNOy0VsXLlSBHO+yvbZemvFq
   QcLFebC0/JYxRVzSKIXdiZbiPfuLFPD5b2nU47lXIrB6/YoukkWY2TvKc
   dkPq7EDxi41pOlj1Xkq2SCjNkKBLKZVFXD5Pq07bkhbt15X8eTnk2c6hP
   g==;
X-CSE-ConnectionGUID: ybfR/JhFQzeMovfUGnfusQ==
X-CSE-MsgGUID: 4UcjVawGS8CDKjJ/mA12lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74720771"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="74720771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 05:49:27 -0700
X-CSE-ConnectionGUID: RiKucL7WTR6qcI54uvuUig==
X-CSE-MsgGUID: ZnqfOyqoQsuHMpKVuTfBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="221055454"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.49]) ([10.245.244.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 05:49:24 -0700
Message-ID: <8750e1e4-41fb-4fe7-b97e-9d2a26db45c6@linux.intel.com>
Date: Wed, 22 Oct 2025 15:49:22 +0300
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 wesley.cheng@oss.qualcomm.com
References: <20251022100029.14189-1-uttkarsh.aggarwal@oss.qualcomm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251022100029.14189-1-uttkarsh.aggarwal@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/25 13:00, Uttkarsh Aggarwal wrote:
> Currently xhci_handshake is a polling loop that waits for change of state.
> If this loop is executed while holding a spinlock with IRQs disabled, it
> can block interrupts for up to 5 seconds.
> 
> To prevent prolonged IRQ disable durations that may lead to watchdog
> timeouts, release the spinlock before invoking xhci_handshake() in
> xhci_abort_cmd_ring().
> 
> The spinlock is reacquired after the handshake to continue with controller
> halt and recovery if needed.

Is this a real issue?

It should be extremely rare that commands need to be aborted, and even
less likely that it takes five seconds to stop the command ring.

Can you take logs and traces of this (if it's reproducible).
I suspect there is some other issue that needs to be fixed.

I agree that keeping the spin lock for up to five seconds isn't a good idea, but
just unlocking before the command ring has stopped opens up new race risks.

We need to ensure that queuing a new command mid ring abortion, before ring stopped,
doesn't cause new issues, or that handling command completion events, including the
"stop command ring" event, before polling for a stopped ring works fine.

Thanks
Mathias



