Return-Path: <linux-kernel+bounces-820722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF011B7EA65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595C71731C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0436999C;
	Wed, 17 Sep 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjVDeEFG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F136D;
	Wed, 17 Sep 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113421; cv=none; b=oo0NyS3TqthjCD0M9KAaf0xCSPInu9/XG/JEPwj6VQqbGB+WK5VSCZqqrZUSnAc84cppbf9ZB2Ou90oJWDnkJ0Dzj/w9aj2PuQ+v118wGrHmeAuVDwWHa8t6a57CGuCWYYZmM32UBj98ZIFgCYUmn9QeEVDurWa7y6edhzNae2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113421; c=relaxed/simple;
	bh=KRsBp9Gi04Q8OS7/4OHYDrvltmfbgN/visXkqBJSvf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9OgpcIduZvNzHpkDn5FvGj0UPpeYegSwSrEF1byC9L3Ge3NM3xgBVpSIAnO9h+CdY/23+hIUVCys5jfSlRNNq0eCzrzYGPVxBoT14DLdTj2Da2NklVizpERxOU0+iWIXBL5e28So8R2hs7tNv+VP4yQmUNPP8pSOnxqVTEUfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjVDeEFG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758113420; x=1789649420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KRsBp9Gi04Q8OS7/4OHYDrvltmfbgN/visXkqBJSvf8=;
  b=ZjVDeEFGgW523xJn3ObPGTZ2sPSvFzQdH9C4qS1lUHmoVBQNOfvdwuQU
   gL7hquRYFT6rMPDbD/dfbwTBuoWS73bW5DuXN2DmRIM9h8IYCUtlO0k6N
   2Y+ZnsTkDnpvAXfBar3G/ejIEzOC2QeBRg/Mmcn43SqiqjdlATdmcE/6m
   VczFxMm9Y7A7wc8zDSYQu7zypsEUKdjPrAlIXRz9ohOA3w55MpeAN3sJ6
   vJG5fI/inC4mTpRpF1s6GdD6ftU1sUwiUpg0feYqJ548EkPecgU3WP+RA
   Km92A/HvUO2SOQ13OczSp+lT94E0E3dSxHfhvLBILbExOpawl9wUnyckk
   A==;
X-CSE-ConnectionGUID: l/Q5DomcRS+sYnO1SPvhPg==
X-CSE-MsgGUID: OWXMX+KZT7mkJpX5OD3I1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60526906"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="60526906"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 05:50:19 -0700
X-CSE-ConnectionGUID: vqszKZX8TyGvI5PixBBnPw==
X-CSE-MsgGUID: 0ptKBxAnRo2FKLRRpfIsrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="198924930"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2025 05:50:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 076FA98; Wed, 17 Sep 2025 14:50:17 +0200 (CEST)
Date: Wed, 17 Sep 2025 14:50:17 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?B?5p2O5L2z5oCh?= <lijiayi@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH RFC] thunderbolt: Re-add DP resources on resume
Message-ID: <20250917125017.GI2912318@black.igk.intel.com>
References: <20250917082456.1790252-1-lijiayi@kylinos.cn>
 <0540df54-efd6-4b79-90f9-ec305e1f5f7e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0540df54-efd6-4b79-90f9-ec305e1f5f7e@kylinos.cn>

On Wed, Sep 17, 2025 at 06:12:31PM +0800, 李佳怡 wrote:
> 
> As requested, I've attached the complete dmesg output (from boot to after
> resume) reproducing the issue.
> 
> Testing Methodology:
> 1. Start with the Targus Thunderbolt dock already connected to the system
> 2. Enter S3 suspend (sleep) with no DP monitor connected to the dock
> 3. Resume from S3
> 4. After the system has fully resumed, connect the DP monitor to the dock

Thanks! It is badly line wrapped. I wonder if you can just attach it?
Anyways I found some unexpected things there:

> [    8.647850] With USB4 patch v1.0.0

What is this? ;-)

> [    8.647860] ACPI: bus type thunderbolt registered
> [    8.664660] [7] nhi_probe:1326: thunderbolt 0000:2c:00.0: total paths: 21
> [    8.665209] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0: allocating
> TX ring 0 of size 10
> [    8.665243] [7] tb_ring_alloc:586: thunderbolt 0000:2c:00.0: allocating
> RX ring 0 of size 10
> [    8.665267] [7] tb_ctl_alloc:665: thunderbolt 0000:2c:00.0: control
> channel created
> [    8.665272] [7] icm_probe:2549: thunderbolt 0000:2c:00.0: ICM not
> supported on this controller
> [    8.665285] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: freeing RX
> ring 0
> [    8.665294] [7] tb_ring_free:840: thunderbolt 0000:2c:00.0: freeing TX
> ring 0

What is this?

Is this Intel TB/USB4 controller or something else? All USB4 compliant
controllers should go directly to tb.c as that's the part dealing with
software connection manager. The above looks like it tries first with the
firmware connection manager and that should not happen outside of Intel
Thunderbolt 3 hosts.

