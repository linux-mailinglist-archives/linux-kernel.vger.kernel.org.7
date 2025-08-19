Return-Path: <linux-kernel+bounces-776335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DAEB2CC23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFCB72276C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B830C345;
	Tue, 19 Aug 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZyaUzdx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44F1E5205
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628329; cv=none; b=pzPYF/HymDySDaLKp79eWK0lg/Oqcz4oS2mpamL66GkWv54MuXfBC3ZD6mIB8qSzJAUHv72mhDWAg2w0o3DpknNY1GeouSdxLVttoGOwutkIJEPOX/+yGFL8KhBQtKR/nUw/xpxVZpllgktB4WsxfySch4TkrlIqHPLp8+wwBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628329; c=relaxed/simple;
	bh=uOHwFiQlQPZAlD0LCU1WUw0rPD7BaCiHD15MEjlYOAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUnlLjOSpLLvdt4+NajQawKKYjGVJuYcK+Gtj42Cb9uNNTCfmXVOiCuSgvsny5ygnCLh7AjOMQIYyFqB+Ye5LYgMyI/tZc9kL/7s6c5bY2UDed+l6mS+N+K2j+SknlIY7mXHsUUFflBzxf9pqztqilJMCObTntUm+DujHY1SXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZyaUzdx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755628328; x=1787164328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uOHwFiQlQPZAlD0LCU1WUw0rPD7BaCiHD15MEjlYOAo=;
  b=HZyaUzdxhtI8hM1hcA0Y0QvR2buqyd+eeNVtVzUrRoDyKZQk+o216z6x
   cZVzU/m7WDiTvXUVVns4//AHfmw+nGvKrUOAUF1WGwvkV3syM6gWoJdJN
   pNSHUC9GabS/MgO1MqWPl0z/386BmXhnYnPZ0G2XF5cCpdTuytUh6TYBN
   sMVmugJRWt+dEtAR8XrHW8l0jqGG1vlqgLlT73XZa1akMSPD3Fl5ENsy7
   EpnUWo7ODDZqqZkazUSqyRI5IpEZ12MlliJeWIZMn7ZCnLpkBOTV62qqF
   zjoPUPvLWTVUbAzb5NY9m3z6404DroylDAsvwo4ezPhUXVMdAK7yP7g0w
   Q==;
X-CSE-ConnectionGUID: XN5CX4UcTWe6uTA+exRadw==
X-CSE-MsgGUID: iJ0yER8IQN6uNva4LeAzJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58032793"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58032793"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:32:06 -0700
X-CSE-ConnectionGUID: izkkLU90QlWYy85PvIvszw==
X-CSE-MsgGUID: esGE6tiKTymQW/8gtru2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168709053"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO desk) ([10.124.220.165])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:32:05 -0700
Date: Tue, 19 Aug 2025 11:31:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/intel: Refresh the revisions that
 determine old_microcode
Message-ID: <20250819183157.v5sqqjkwh4amikbe@desk>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-2-sohil.mehta@intel.com>
 <20250819051940.sqdjdvwupvocuf7w@desk>
 <0bfc7329-e13b-4781-a331-9f8898110b5f@citrix.com>
 <cbd74335-055d-46e5-9dc3-9197ff95cebf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd74335-055d-46e5-9dc3-9197ff95cebf@intel.com>

On Tue, Aug 19, 2025 at 09:13:27AM -0700, Sohil Mehta wrote:
> On 8/19/2025 4:18 AM, Andrew Cooper wrote:
> > On 19/08/2025 6:19 am, Pawan Gupta wrote:
> >> On Mon, Aug 18, 2025 at 12:01:36PM -0700, Sohil Mehta wrote:
> >>> Update the minimum expected revisions of Intel microcode based on the
> >>> microcode-20250512 (May 2025) release.
> >>>
> >>> Cc: <stable@kernel.org> # v6.15+
> >>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> >>> ---
> >>>  .../kernel/cpu/microcode/intel-ucode-defs.h   | 86 +++++++++++--------
> >>>  1 file changed, 48 insertions(+), 38 deletions(-)
> >>>
> >> ".model = 0x55, .steppings = 0x0040" is being removed? Total number of
> >> entries in the table are being reduced by ~10.
> > 
> 
> Based on the diff stat, aren't the total entries increasing by 10?

Ya, sorry my bad.

