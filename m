Return-Path: <linux-kernel+bounces-873737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299E5C14914
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E01AA4C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFE32B9A5;
	Tue, 28 Oct 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOCD6XDa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D816DC28;
	Tue, 28 Oct 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653736; cv=none; b=FIlecJs36zHwl1273XRPLBQTu7BIVS6x+egdtw44VU26VN3vGPfwLepbEZnWm3kq1reVrsRa7a7E7lrx3UobTjsePTrj/a1KLE4NjcoQB5SLgMJVcQSOraFAUZpsR/YqEA4kwMita8q1n3kBsNlniVTHgagVl8aXr/iTT8wxf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653736; c=relaxed/simple;
	bh=9O8Dv73cqeiMHr34ohoGC3ZLMBjgNNoJIYPYXf9HsrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpIz/u4p3v6fsTAcSxTGLrhKkwvi0gsdS7tueruRAG8eVn7Ot3G9pH6X93LPGc0lh6Ih8OzMnv1suzyuJGjNctJdOMOwfvZ/l5oUbtqOxhj9tJZB+wrvtrD0WY8psEOiNvGpCJwNQIrqBLXpzXoYgYVMQ/mIevqyds5Ja0uhhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOCD6XDa; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761653735; x=1793189735;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9O8Dv73cqeiMHr34ohoGC3ZLMBjgNNoJIYPYXf9HsrQ=;
  b=QOCD6XDaUYnzrau9fmZ6L3Qm5jk5tBpm9HJYN1kUi0ElHN6zmI+9SOot
   /4RFjkDdFGEEyyOhLZzl31m5Qp7yAo40JwWwYktOKA89B4QgTV5vypuGz
   Okk5/tAdHDOWXPs0ocuX3sjLNX58THeCYoxFU6mUOH3I/WEJYahZKzGmT
   luR71rOXia5hZrJmStF/w9pYfrDAS/8wCLQt1DJVyYmgoOg9Yz/SNtm5s
   c0jnee6UyHOc6YbvUVzubmqWU7hhPv7Pfaez9llmNC4vwP5tP2kZDGy6f
   bkoSvvLWHc4S7eEN3aVaPilz94yPtlnRk78hUo5oEPzeurVhCThZKVgnk
   Q==;
X-CSE-ConnectionGUID: exNRZD4wRhKFDgHoQ3bLIA==
X-CSE-MsgGUID: xsvPHLodSAi1Z7918vw2Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86377309"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="86377309"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 05:15:34 -0700
X-CSE-ConnectionGUID: FL0fjhCXSbSqJuWpZ95QHg==
X-CSE-MsgGUID: f959LzMNS9e4iVk5oicfFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="189686396"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.148]) ([10.245.244.148])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 05:15:31 -0700
Message-ID: <51ca2248-5699-4c6d-b037-a57c90ed44ac@linux.intel.com>
Date: Tue, 28 Oct 2025 14:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: sideband: Fix race condition in sideband unregister
To: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 wesley.cheng@oss.qualcomm.com
References: <20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 10:00, Uttkarsh Aggarwal wrote:
> A kernel panic was observed due to a race condition between un-registering
> sideband and creating sideband interrupters. The issue occurrs when thread
> T1 runs uaudio_disconnect() and released sb->xhci via sideband_unregister,
> while thread T2 simultaneously accessed the now-NULL sb->xhci in
> xhci_sideband_create_interrupter() resulting in a crash.
> 
> By locking the mutex before modifying sb->xhci, any thread calling
> xhci_sideband_create_interrupter() will either see a valid sb->xhci or wait
> until xhci_sideband_unregister() completes.
> 

Looks like there is a bigger issue with xhci_sideband_unregister() and the mutex.
New endpoints and interrupter can be added to the sideband after
xhci_sideband_unregister() cleared the existing ones, and released the mutex.

We should avoid taking and releasing the mutex several times in unregister,
and make sure we set a flag during first time unregister takes the muxtex, and make
sure no new endpoints and interrupter are added if this flag is set.
Also avoid creating unnecessary locking dependencies between mutex and xhci spinlock.

the xhci->lock looks correct

Maybe we can use sb->vdev as a flag, I'll look into this.

Thanks
Mathias



