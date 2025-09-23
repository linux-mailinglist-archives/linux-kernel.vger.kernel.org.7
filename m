Return-Path: <linux-kernel+bounces-829239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D7B96978
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF12483B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD223D2B8;
	Tue, 23 Sep 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLeOySXV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80217A5BE;
	Tue, 23 Sep 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641471; cv=none; b=BVPVUb1JOe1Pi+SSm8W+xNWgwDJkqYLj5/DC1VaJi2aJI1bJ9rOgwEPZ+ywD7o0ntQfExTenWcVEk09wrNOIE9dNAwkx9749mIDyTWw7e9U+Mf2i/LHXSvjZ26R6o7F+0KTWCxmDMONilLROsRCbliDIRQpGz0L5ENhbNarB4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641471; c=relaxed/simple;
	bh=VissSN4DHuu/OV0m7zZVQ1TWut0ZMqT61xOdJ1tJB7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u01Xhhi9ak4fmm2OHbq8plnAkefjiep9O+S3DoJ2P6Ev4/r2X6ABTnqhC+lfp/hWrOsYBJf9Rj/ty7kZHt6MQ9ze7DdslJnsMoGcJpvoaLUUew9nevWLhI7Q5bgZzz90r5C8BThjg4G+mcQgQg7xijjO2UyCOK1choI8X/nvpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLeOySXV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758641470; x=1790177470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VissSN4DHuu/OV0m7zZVQ1TWut0ZMqT61xOdJ1tJB7s=;
  b=hLeOySXVZrFjV4N4JYc91+qVWzaEXz/zbSj9bUVeyFUTE3CriU5hrArK
   OU5zwKVX+3fQPKJW9aJHnHFs++W4+IGEI9xpFht4LR11SW+6O0g4f8pHe
   01GfNRFcz1z86l0hcbtkZTXE9kAXm5IfUYkNkNLs690y/TTCCML7PtZrg
   gQJIRkbLYkGTrqSK/AmJlE8MuMlgpNykGO7S0307HqkifEQv3TpfdzoWd
   z++EZUxp6AJpArP5klILmB0TMh+moONO6zgmYmm6dR61SvBTc6q/JV0Ej
   yuvPh6V0GjvFzDFwuifRzVC0MXKlDalnv/57laVtl3bGVS8DwPQZd/0tn
   w==;
X-CSE-ConnectionGUID: 6cC1zGIATRuVKByGn/zxOg==
X-CSE-MsgGUID: IyFy7vPCQMCRCAf8OTRQFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60141845"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="60141845"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 08:31:09 -0700
X-CSE-ConnectionGUID: SdWAWjV/S2yVCNW1dAQ4Tg==
X-CSE-MsgGUID: neD2jkpORK6qW2OQvT2XnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="176077521"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 23 Sep 2025 08:31:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A238C95; Tue, 23 Sep 2025 17:31:05 +0200 (CEST)
Date: Tue, 23 Sep 2025 17:31:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	YehezkelShB@gmail.com, westeri@kernel.org, michael.jamet@intel.com,
	andreas.noever@gmail.com
Subject: Re: [PATCH v2] thunderbolt: Fix use-after-free in tb_dp_dprx_work
Message-ID: <20250923153105.GA2912318@black.igk.intel.com>
References: <20250923051357.12206-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923051357.12206-1-duoming@zju.edu.cn>

Hi,

On Tue, Sep 23, 2025 at 01:13:57PM +0800, Duoming Zhou wrote:
> The original code relies on cancel_delayed_work() in tb_dp_dprx_stop(),
> which does not ensure that the delayed work item tunnel->dprx_work has
> fully completed if it was already running. This leads to use-after-free
> scenarios where tb_tunnel is deallocated by tb_tunnel_put(), while
> tunnel->dprx_work remains active and attempts to dereference tb_tunnel
> in tb_dp_dprx_work().
> 
> A typical race condition is illustrated below:
> 
> CPU 0                            | CPU 1
> tb_dp_tunnel_active()            |
>   tb_deactivate_and_free_tunnel()| tb_dp_dprx_start()
>     tb_tunnel_deactivate()       |   queue_delayed_work()
>       tb_dp_activate()           |
>         tb_dp_dprx_stop()        | tb_dp_dprx_work() //delayed worker
>           cancel_delayed_work()  |
>     tb_tunnel_put(tunnel);       |
>                                  |   tunnel = container_of(...); //UAF
>                                  |   tunnel-> //UAF
> 
> Replacing cancel_delayed_work() with cancel_delayed_work_sync() is
> not feasible as it would introduce a deadlock: both tb_dp_dprx_work()
> and the cleanup path acquire tb->lock, and cancel_delayed_work_sync()
> would wait indefinitely for the work item that cannot proceed.
> 
> Instead, implement proper reference counting:
> - If cancel_delayed_work() returns true (work is pending), we release
>   the reference in the stop function.
> - If it returns false (work is executing or already completed), the
>   reference is released in delayed work function itself.
> 
> This ensures the tb_tunnel remains valid during work item execution
> while preventing memory leaks.
> 
> This bug was found by static analysis.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Because it is pretty late in the cycle, I would like to get some exposure
for this one before it goes to stable trees. I applied this to my
thunderbolt.git/next now. Once it is pulled into mainline this will be
picked up by the stable machinery too.

Thanks!

