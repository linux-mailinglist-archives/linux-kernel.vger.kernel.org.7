Return-Path: <linux-kernel+bounces-852871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2035BDA243
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B324018815B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801072FE05B;
	Tue, 14 Oct 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1kiADu0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72852FE04D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453198; cv=none; b=u7vFbBXpTT5jz8KVNNI08tEAwO321ZOpSvRj1j+3Xa1lqFkJrbqI8sh1PFhK13qqQYagEBQC1X4aZVOYoWtO8jFlSGgYcTMjThdd+4QcHtZzqLggpUqTTwoL/gVYqn0BwkrzT16i+dt5MKJVzJQxB3Y5Ur+DIIXILdXWYweua08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453198; c=relaxed/simple;
	bh=Mfsgymobg7RCbU6eQtCvuZmpzzO0amxoBjQtmL5VC4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpuk8iC1w3u9FFVTlWyvYNAk4384RdWhqSvk5fiK2pV+QU+Az6xLZwPJIe2OxHGwK35DyqubS28GTHKkbbc5cd97CuTo2dWBWMTldpQIKLjffgS1x+34rkDFCc3Y6i1Ff/9ONdFx83VkJZ76nHB/VaqEeqnjP6v0gjCY1hkssHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1kiADu0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760453197; x=1791989197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mfsgymobg7RCbU6eQtCvuZmpzzO0amxoBjQtmL5VC4U=;
  b=I1kiADu0gyPTbxQshjbnQWoddAQ7PhQv0cFRlzFfc7OchIZiad4VB3OM
   74mzN2eHIG+OMB7Rj/hTWZQssXAsC+NjGJowuPE0uXE+MT1/Do9eENoJ0
   479taQeIMeAnhxvq2x0G+4Y70afIW2W37D5g6JcOtzEcXAV1Fp9FgqfbB
   iB9ULs7Raet+vLFUpykGoAUaAehkiFfZQ9Hqo892/qIM29fpcVFvPhIAn
   LMbrr0imszr9CYa1rlKEPV7i1E4x01q1eHA4qpN0Sy9JJq5npdidvKU6Y
   2ZjmYQGIX4RN+2hVFWJ5jDDGHCAcGFqRGJaSAn8cvOzJVMQTjj601kqWl
   A==;
X-CSE-ConnectionGUID: 71UXhr6SQ/SI1wu9Gv+sKg==
X-CSE-MsgGUID: ARnhMsh4RaODftLZPq9vIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73214442"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="73214442"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:46:36 -0700
X-CSE-ConnectionGUID: J6Y4sPUnSKShu7SiJInITQ==
X-CSE-MsgGUID: jJAVLorqTMW13d75G4ViLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="219042713"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:46:34 -0700
Date: Tue, 14 Oct 2025 16:44:40 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Feng Chen <feng.chen@amlogic.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: Linux 6.18-rc1
Message-ID: <aO5h2AELcno8ecEG@mev-dev.igk.intel.com>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>

On Mon, Oct 13, 2025 at 10:08:22AM -0700, Guenter Roeck wrote:
> On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
> > Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
> > 
> > Things look fairly normal: size-wise this is pretty much right in the
> > middle of the pack, and nothing particular stands out in the shortlog
> > of merges this merge window appended below. About half the diff is
> > drivers, with the res being all over: vfs and filesystems, arch
> > updates (although much of that is actually devicetree stuff, so it's
> > arguably more driver-related), tooling, rust support etc etc.
> > 
> > This was one of the good merge windows where I didn't end up having to
> > bisect any particular problem on nay of the machines I was testing.
> > Let's hope that success mostly translates to the bigger picture too.
> > 
> 

[...]

> ============================================================
> 
> powerpc
> -------
> 
> Building powerpc:skiroot_defconfig ... failed
> --------------
> Error log:
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c: In function 'ixgbe_fwlog_init':
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:3938:40: error: 'struct ixgbe_adapter' has no member named 'ixgbe_dbg_adapter'
>  3938 |                 .debugfs_root = adapter->ixgbe_dbg_adapter,
> 
> struct ixgbe_adapter only provides ixgbe_dbg_adapter if CONFIG_DEBUG_FS=y,
> but commit 641585bc978e0 ("ixgbe: fwlog support for e610") uses it
> unconditionally.
> 
> Author: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>

Sorry, I completely missed that. Thanks for catching it.
The fix is here [1]

[1] https://lore.kernel.org/netdev/20251014141110.751104-1-michal.swiatkowski@linux.intel.com/T/#u

[...]

