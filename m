Return-Path: <linux-kernel+bounces-824231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF1B88740
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FAC625676
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287F33064B7;
	Fri, 19 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMVE4BEQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5D24EA81;
	Fri, 19 Sep 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271287; cv=none; b=m4+5o+v9+ZyhVmqXAqx9pzLYY6g2S/KbU/vnVMiJlB1J12nKg6mJBgAG16qkCin/ph6xQUK0BG2U1M5SG9/Vt6n/M8PvmPWgkhG7UrhMbkN4Pk8dw62LUESgWEv0OjOtU68h9FKL2c+tfxAUiMEHhcuODgp+M4Lx6Bhh4SDWz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271287; c=relaxed/simple;
	bh=Vut4j2QwB+ycC5MyIVa/yNlcRE5SgARDhd2XYVQQ3Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNReAk/89JW7pNJvNDdEH7mMAfWxJztdBqIXbu9qFJ1jiEFzvS9FtMnjH4htNgRCeyW6wtWfOWrczu9GTNvqUMVNka6YMsMo7U8ET63y7rSC+eja3mRYTJajqLdZxNDNrQyVze3iFUAmQkNPRMmxH/jg1Ss3sEH8NCZQ3w9dyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMVE4BEQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758271285; x=1789807285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vut4j2QwB+ycC5MyIVa/yNlcRE5SgARDhd2XYVQQ3Lk=;
  b=cMVE4BEQPSe9UJMySzog+uAd0LVi30FATKmDSEh6UWsyuZFekgTkbAFq
   IVZsVGBAMhshs18/EOXSk+JrzqHMb4pBgvrEVjoV95le2emc3AwToVTYJ
   fT92SEHCFkpPMCaaHxE3RZar+e9/C5hy/+SrOtjXp6JatjyHLHp/aAx/M
   CONxqz2jMOkFMoYKJUoXjc9bqlQiD3oRG6jXFVsjMa/pOOqtTd7eMSLYh
   CKG29889F/85dCZDwrWUVsUXrkjgYypYpuxvB/c7IO9BQsIVBR/reezuO
   XO5qOR36qb3vJ8HOrcRxZjix3C4I+U8IRz+6rFyOQ+iStV0OUWGq2B1tD
   g==;
X-CSE-ConnectionGUID: PAkeFQlSTqOJkxj+0Ev3Qw==
X-CSE-MsgGUID: IMy5Uo/mTnS6cz4zWKch8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60502958"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="60502958"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:41:24 -0700
X-CSE-ConnectionGUID: VO7GjojLSRmxRZHvpJd+ww==
X-CSE-MsgGUID: 55kTMOPQSHuiPf5/2JYl9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="175334544"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 01:41:23 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B32EA95; Fri, 19 Sep 2025 10:41:21 +0200 (CEST)
Date: Fri, 19 Sep 2025 10:41:21 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?B?5p2O5L2z5oCh?= <lijiayi@kylinos.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] thunderbolt: Re-add DP resources on resume
Message-ID: <20250919084121.GP2912318@black.igk.intel.com>
References: <20250917082456.1790252-1-lijiayi@kylinos.cn>
 <0540df54-efd6-4b79-90f9-ec305e1f5f7e@kylinos.cn>
 <20250917125017.GI2912318@black.igk.intel.com>
 <f0a04f70-5539-42bd-ac15-07054878acfb@kylinos.cn>
 <20250918162059.GL2912318@black.igk.intel.com>
 <20250918164330.GN2912318@black.igk.intel.com>
 <a3dd4fc5-4312-4c06-a6d7-645ae0f7b68b@kylinos.cn>
 <20250919073052.GO2912318@black.igk.intel.com>
 <0f9a0d5a-d51c-45f4-8f1c-050e7c609baa@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f9a0d5a-d51c-45f4-8f1c-050e7c609baa@kylinos.cn>

On Fri, Sep 19, 2025 at 04:00:48PM +0800, 李佳怡 wrote:
> > The lspci dump indicates this is ASMedia host controller. I did not even
> > know that they have such thing. I thought they only have device (which
> > should be working in Linux). The host side may require some additional
> > enablement.
> 
> Apologies, Please find the latest results.
> 
> # tbdump -vv -r 0 -N 1  -a 10 ADP_CS_5
> 0x0005 0x0000d809 0b00000000 00000000 11011000 00001001 .... ADP_CS_5
>   [00:06]        0x9 Max Input HopID
>   [11:17]       0x1b Max Output HopID
>   [22:28]        0x0 Link Credits Allocated
>   [29:29]        0x0 HEC Error Enable (HEE)
>   [30:30]        0x0 Flow Control Error Enable (FCEE)
>   [31:31]        0x0 Disable Hot Plug Events (DHP)
> 
> # tbdump -vv -r 0 -N 1  -a 11 ADP_CS_5
> 0x0005 0x0000d809 0b00000000 00000000 11011000 00001001 .... ADP_CS_5
>   [00:06]        0x9 Max Input HopID
>   [11:17]       0x1b Max Output HopID
>   [22:28]        0x0 Link Credits Allocated
>   [29:29]        0x0 HEC Error Enable (HEE)
>   [30:30]        0x0 Flow Control Error Enable (FCEE)
>   [31:31]        0x0 Disable Hot Plug Events (DHP)

Thanks! DHP bits are not set as expected.

> Regarding the ASMedia host controller: if hotplug events for the DP IN
> adapter are not being generated, is it feasible to manually add the DP IN
> resource as I initially thought, or is that approach incorrect for this
> scenario?

Well the host router exits sleep (runtime resume) and once it is being
enumerated again by the driver it is expected to send the plug events to
the DP IN adapters according to the spec. I prefer not to add things like
these if there is a standard way. Are you associated with ASMedia or you
just have a machine that has this controller? If you are then is there
possibility to talk to the hardware folks and ask if this is known issue or
perhaps it has some older firmware? I definitely like to get this working
but we should first figure out if this is some sort of known issue perhaps?

