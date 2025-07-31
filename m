Return-Path: <linux-kernel+bounces-752517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A65AB17680
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C087AB254
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57D239E96;
	Thu, 31 Jul 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy1aXI4n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DFD635
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989404; cv=none; b=TCQ+gIS6sM3JwjaWm1iR7tkdJ9AB8gN9W0a+OUcZ2tu2c+o3vR+jirlzv8xsnX/G/P5H1moU8xG/ltIHkjVAO5u0NB34dT3ejgcy6bAmCsVOCs3Bzb3qlPZy79jaJOL9I0UsQJAxNFEJ6XWV8JocttrcR4+cVTN/yIkQtAZ0f8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989404; c=relaxed/simple;
	bh=JclIlVrchu2b7vC+SRInxLWXEUZ1woNLPFBbrOlTD0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ/PI+C0/NPDluPqTIWW5SepHrhmWaKruVPVB+Ro9VqYM3YCfKXyxKt0mnLAP0AQD0XN6Rdmv3rxqExo4RnhhRrcgEiWUK8iM1G9iXgthKEB5q81/hv4+AAjB62vVDImopghz0Gt3BHCqhHyuktw+qGp6OeMsP57gvvMbycPXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy1aXI4n; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753989403; x=1785525403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JclIlVrchu2b7vC+SRInxLWXEUZ1woNLPFBbrOlTD0c=;
  b=Qy1aXI4nQNsAp2aK5VOv1jlnynS0M/nuxgJIIgeRAkrN0AQZEqAjLFPU
   pR50cTAKHsvWPb5ObcPI2ebjW9q3V+OJP8pqxoEmUjNAFWH5WpuApsFgO
   DlcSPC4wUlBXhpSpYj75B13HnVipUnvkWGdDpftFCovxvVw8kN5/j76LV
   VhCi8xDB1DH+Qpd6DbDT/rvAYId71PNwBH0lvOinj1MZ7ZlMsoXonDHBS
   gSLtgzxWgR2n5M9Neiqhnvr2hOOQgC2HBO32IJWvBKEf5baVv7aw4nFzS
   qy7XkxeXBfg5lQcsXymsrtS0MbViUYkVEtRBcgzKz23/Uz0ZGaEp8VwMR
   A==;
X-CSE-ConnectionGUID: WXoshwFmSVij3wCv7kRYlw==
X-CSE-MsgGUID: Djfofvl/QMCjP/9EYXvtgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="55394225"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="55394225"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 12:16:42 -0700
X-CSE-ConnectionGUID: 63rJmOFOTKie73XG+BCSKA==
X-CSE-MsgGUID: EE2+SKpdRQ2qj96OioOrZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="162923656"
Received: from spandruv-desk2.amr.corp.intel.com (HELO desk) ([10.124.222.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 12:16:42 -0700
Date: Thu, 31 Jul 2025 12:16:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tsx: Get the tsx= command line parameter with
 core_param()
Message-ID: <20250731191636.7vepzhy44ajftqry@desk>
References: <20250731083433.3173437-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731083433.3173437-1-ptesarik@suse.com>

On Thu, Jul 31, 2025 at 10:34:33AM +0200, Petr Tesarik wrote:
> Use core_param() to get the value of the tsx= command line parameter.
> Although cmdline_find_option() works fine, the option is reported as
> unknown and passed to user space. The latter is not a real issue, but
> the former is confusing and makes people wonder if the tsx= parameter
> had any effect and double-check for typos unnecessarily.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

