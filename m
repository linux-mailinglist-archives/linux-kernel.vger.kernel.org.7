Return-Path: <linux-kernel+bounces-877696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFDC1ECBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32D23BD440
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A533769F;
	Thu, 30 Oct 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3yRpJFl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23265632
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809808; cv=none; b=mO7+fpiWB/NnmgBq2LoQXn4zoEJay//M31UCLh8R2TtTpPnxYKDWLdX8B+ly+gdGPO64evP8jeZm91UOWoYe8fEFZIaZCo38aS1fc6xBszQiuzBjpTpVcI00NgmYt9g9tscmE2YI/O8N+JSyfYPv+QdsOq2soRdCKSNsb8j+hK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809808; c=relaxed/simple;
	bh=PDinnCm5jla/4B2FamrD8dHf56xMvUHthDRCHVkC5QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZYDosGcXtJ45f4dQ3phLoTZMzclKV3aTUKEAYpLUf7w3qrHsqaKUQ2S0B8BQPh9kDnmkLUGzQY9HUr9IQxZ1/C6xpPHmSUuR3ZBbsO0kjpqE24OteNQ0QuDdbvQzoyumK6gJutYaDcpxwTgt5F2TF+iGmgkOOeGpEnromFtaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3yRpJFl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761809807; x=1793345807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PDinnCm5jla/4B2FamrD8dHf56xMvUHthDRCHVkC5QE=;
  b=Z3yRpJFl07DqZOpU5VIGTpyAJ5XAUo8WrrhNaVRu8fYETGHBy7e+L2KS
   Wt6VwRG2e9S6v8IdGHl27NJKn6EF7Q1RhOJzxvaY82yjQM4eLullTYmk5
   hU8xDB7ziCwLypHxSNm4mfAT7aXqbXVhuP3iTMp6RO1AFfed4brsXUb0e
   F660tqKdZ3e4q/FumwN8EvMiFTqxR4Aw0MODy2Bw0h5ihv7Ybz+tuJTTD
   9wMzO1l/sJ7VyK/oyUOD2f3lZ9vd5+i/uCQqNAGo27EX60C+sXkn7S+FH
   rGOVMhloxhSx4PWHFcX90c9rjUTGeKO34rgKptM5Cf9lT4AbVePwEHlv/
   w==;
X-CSE-ConnectionGUID: /hgIl3A6Tym9638zmmdCmA==
X-CSE-MsgGUID: zjlcD1CTQ4yxQlvH8uDUJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75290501"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75290501"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:36:46 -0700
X-CSE-ConnectionGUID: 0gmsjGzpQlSgo0AvvuZu6w==
X-CSE-MsgGUID: +VPJL5tDSnyYx83TN1QG+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="223103490"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:36:45 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEND8-00000003phC-260e;
	Thu, 30 Oct 2025 09:36:42 +0200
Date: Thu, 30 Oct 2025 09:36:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 3/6] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aQMVivr15od8Mpct@smile.fi.intel.com>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-5-andriy.shevchenko@linux.intel.com>
 <aQLHDaIqkMQTJHTT@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQLHDaIqkMQTJHTT@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 10:01:49AM +0800, Feng Tang wrote:
> On Wed, Oct 29, 2025 at 12:07:38PM +0100, Andy Shevchenko wrote:
> > There is no need to keep a custom structure just for the need of
> > a plain array of strings. Replace struct sys_info_name with plain
> > array of strings.
> > 
> > With that done, simplify the code, in particular, naturally use
> > for_each_set_bit() when iterating over si_bits_global bitmap.

...

> >  		names[0] = '\0';
> > -		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> > -			if (si_bits & si_names[i].bit) {
> > -				len += scnprintf(names + len, sizeof(names) - len,
> > -					"%s%s", delim, si_names[i].name);
> > -				delim = ",";
> > -			}
> > +		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
> > +			len += scnprintf(names + len, sizeof(names) - len,
> > +					 "%s%s", delim, si_names[i]);
> > +			delim = ",";
> 
> For SYS_INFO_PANIC_CONSOLE_REPLAY bit, it is a NULL string, no need for
> an extra ','?

If you look closer to the original code, the behaviour is the same. Feel free
to update behaviour separately as I tried to keep the functionality to be not
changed with my series (with the exceptions of the fetching issue).

-- 
With Best Regards,
Andy Shevchenko



