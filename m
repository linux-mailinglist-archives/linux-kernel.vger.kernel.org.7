Return-Path: <linux-kernel+bounces-895374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41584C4D9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629891898D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB4357A57;
	Tue, 11 Nov 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXccaW8t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD034FF74;
	Tue, 11 Nov 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863191; cv=none; b=uUfsa6FvJnkrU4Snif6vacvc5lGz4HLPnc2AmSjcGlJtyTa6ARa8BkvejzUs72pa7UpA7b2szX+86i+4K2q9+lEW1i7UNEC7FPFOZHI0vJUHNTWnc4ufQQ66Uhh3sGsHhBGN1x1hvEiPW9wbBzy1Dv7em0WRVj/KhrTVb/i7gsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863191; c=relaxed/simple;
	bh=tGF7vUOkTWYNU40VJoQwsrqiEL5d22L+o/k1hoqbYn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY4WQkNdbI6VtDBT2Ju0E2ehtZAbXOaRKE/x/b+e2tXlGd1WF2yTErhHI+VTmlXZPmLsyRyHCqQOf7KHwJaz1Vawv8CBQlev9Eklh7MbZWY8/UR93vTzbgSXMU3T8R1VZ6XiLWuJwmhI9dBEYGqNopsBog4LWHwzuAoZ266o9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXccaW8t; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762863189; x=1794399189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGF7vUOkTWYNU40VJoQwsrqiEL5d22L+o/k1hoqbYn4=;
  b=aXccaW8tOVJfsQblyYfq+iy9bMMv3t7AhKLLeXgqRPmKOTjepR+0AeQo
   wKCiTbxfq8gGvdCedd5mUVSsGnq+z/ypEO8g/s2ZB/iZViZNAbhRPmjWe
   Xh197OKB/QhnAYPwI3UzYMSNOFAP2OwAvr/5wB9mY1VgmuKSO4MDoZ3rH
   6H11LuykHsNr+GpQD7G+C2qYgSYOf6wcFyxrrglAGCX/76E7TtqHE7A43
   H/8FpTWAHefwzxolq5ot5OyeOcoionHz7Gunk1BkN8WkG9dlWKvvmBBmf
   1ymxObBzpqe3nQWORLGg7lssIYoLrMIciQ1+t6V4a+qeidczUcD8QDWzF
   Q==;
X-CSE-ConnectionGUID: PkmqALrWQuyMXRBcRtS6Hw==
X-CSE-MsgGUID: UyGFitdNQNOXpMDVSqgfqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68783791"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="68783791"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:13:08 -0800
X-CSE-ConnectionGUID: fUPflf0RSh6C28tl8Fgskg==
X-CSE-MsgGUID: 5QFVSmn2S2a+I4ccr39yXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188913613"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.244.118]) ([10.245.244.118])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:13:07 -0800
Message-ID: <a5119a19-8660-4f0c-bedd-0a9a0301ef85@linux.intel.com>
Date: Tue, 11 Nov 2025 14:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Assume that endpoints halt as specified
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107111317.69be45a5.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251107111317.69be45a5.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 12:13, Michal Pecio wrote:
> xHCI 4.8.3 recommends that software should simply assume endpoints to
> halt after certain events, without looking at the Endpoint Context for
> confirmation, because HCs may be slow to update that.
> 
> While no cases of such "slowness" appear to be known, different problem
> exists on AMD Promontory chipsets: they may halt and generate a transfer
> event, but fail to ever update the Endpoint Context at all, at least not
> until some command is queued and fails with Context State Error. This is
> easily triggered by disconnecting D- of a full speed serial device.
> 
> Possibly similar bug in non-AMD hardware has been reported to linux-usb.
> 
> In such case, failed TD is given back without erasing from the ring and
> endpoint isn't reset. If some URB is unlinked later, Stop Endpoint fails
> and its handler resets the endpoint. On next submission it will restart
> on the stale TD. Outcome is UAF on success, or another halt on error and
> then Dequeue doesn't move and URBs are stuck. Unlinking and resubmitting
> the URBs causes unlimited ring expansion if the situation repeats.
> 
> This can be solved by ignoring Endpoint Context State and trusting that
> endpoints halt when required, except one known case in ancient hardware.
> The check for "Already resolving halted ep" becomes redundant, because
> for these completion codes we now jump to xhci_handle_halted_endpoint()
> which deals with pending EP_HALTED internally.
> 
> Link: https://lore.kernel.org/linux-usb/20250311234139.0e73e138@foxbook/
> Link: https://lore.kernel.org/linux-usb/20250918055527.4157212-1-zhangjinpeng@kylinos.cn/
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>

Makes sense, I guess we can only trust hardware to update the state in
the endpoint context on specific command completions, not transfer events.

Added to queue, thanks
Mathias


