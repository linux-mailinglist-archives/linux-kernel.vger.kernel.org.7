Return-Path: <linux-kernel+bounces-879593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7777C23889
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14608188E91E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9500329373;
	Fri, 31 Oct 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHl/hhiC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8E32936F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895344; cv=none; b=gI0FTQay6BlQSvvZFOY0rz4Y0ppeoCucEw6xX7YINDf58QvUyLBgXKP7J3Y1hSkkyzs3wp0hgHfUyVZzyY8tZgbCw7zvdv0RC5VubZMhA/EcCWGse1nL7hZo5mpqplYh9XI+4pw187bxlDk8I65evISS/bRaktrmJxrczbXRl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895344; c=relaxed/simple;
	bh=IGO37Vx7AkDFjALF9SjftVfw8wTRgnkVRtKMK4hFrZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ1216BiI4mwC9HN58Uo7xFrX5cEHD3e5a2Km3Q7AmFellld/GY80qm1SaH5fKI05e1ArjGAUAW6Y11HgQ0JC/KX2F2AzEVQG4vIlpCUsPU/sbw2rx16OLaV17p8G73EUZSXqAbxEHDNP1FwZOfk1nYqQTRAH2A4HZ8jjX3dDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHl/hhiC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761895342; x=1793431342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IGO37Vx7AkDFjALF9SjftVfw8wTRgnkVRtKMK4hFrZk=;
  b=lHl/hhiCuvn7fCO5qqFoNz4+skX08QNcQuu1r9Nd44SICUK/WERlyPpA
   ls1RbFDMlLE32mUA6gSZr4mz9beDXbPAkyBOHE/z3/vN5YwpizIzgkcYB
   6UNl97fdr4qzhKL0D0cvNq2tpGVsAJMl/FBcFtQlo1f+hSldz2wvqPtz5
   gI6X9DzWiQ+bwNGa9nFzidjL0eRC7KF9EvRay4W5YLZIBi5KPUnZEA6Ry
   0CugA9rsU6FYgzzBYS9vybljIuSp65cYoB+caH9M55WXuxdIgSk6GMIf7
   /AJkOJ+fpZyI4RUn/Zo3Xc4DHkZGha/+e4lw7iRosrqlHa46+0VVhg6nl
   g==;
X-CSE-ConnectionGUID: qLYEgjiaS+CKywrRwYUqPw==
X-CSE-MsgGUID: XzP1yZKHRBexuTxzVHbPQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64081915"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64081915"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:22:21 -0700
X-CSE-ConnectionGUID: q0fJ1ApyTP6y45DCGY0JvQ==
X-CSE-MsgGUID: xIxxGKFKRgWevmRgJ0UpIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="191312280"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:22:19 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEjSi-00000004C0X-1Pq2;
	Fri, 31 Oct 2025 09:22:16 +0200
Date: Fri, 31 Oct 2025 09:22:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] panic: sys_info: Factor out read and write
 handlers
Message-ID: <aQRjp4dgn6yWASqC@smile.fi.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
 <20251030132007.3742368-7-andriy.shevchenko@linux.intel.com>
 <20251030201612.8970ca04e861a4f111cc1371@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030201612.8970ca04e861a4f111cc1371@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 08:16:12PM -0700, Andrew Morton wrote:
> On Thu, 30 Oct 2025 12:44:22 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> checkpatch wanted this:

Makes sense. Have you applied this update to your tree already? Or should I
send (re-send) a formal patch?

> --- a/lib/sys_info.c~panic-sys_info-factor-out-read-and-write-handlers-checkpatch-fixes
> +++ a/lib/sys_info.c
> @@ -43,7 +43,7 @@ unsigned long sys_info_parse_param(char
>  
>  #ifdef CONFIG_SYSCTL
>  
> -static int sys_info_write_handler(struct ctl_table *table,
> +static int sys_info_write_handler(const struct ctl_table *table,
>  				  void *buffer, size_t *lenp, loff_t *ppos,
>  				  unsigned long *si_bits_global)
>  {
> @@ -62,7 +62,7 @@ static int sys_info_write_handler(struct
>  	return 0;
>  }
>  
> -static int sys_info_read_handler(struct ctl_table *table,
> +static int sys_info_read_handler(const struct ctl_table *table,
>  				 void *buffer, size_t *lenp, loff_t *ppos,
>  				 unsigned long *si_bits_global)
>  {

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



