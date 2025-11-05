Return-Path: <linux-kernel+bounces-887152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D47C3765E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C291A22D50
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C949D33DEF3;
	Wed,  5 Nov 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIUdsBB5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94F33A000;
	Wed,  5 Nov 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368721; cv=none; b=eiYYXDUgg4QDEzy//lyGAiyNqVeQdTecH7DI2bnC69YxZxNQu6/U9IeBOHLJ3WVIf28dYt/V/b5RQ+s2PdhM5VSWbPMJ95qZFf8ctHUwaCxDZRuwTZHy4nE9L4eBRAkb4KjS7f6kGBnf6AgYVNBs7VER5Lv5SWnJBTUFUhzYasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368721; c=relaxed/simple;
	bh=qzu24zFEFiyiD2yNvbHESw70LjQHeD9bn6/zBdj6VEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL+jKSUbN2hTYXktN8oMYPYy2f82gnUYPhX3qrlOqeVu7lHbTjiZBuiEdjDy1M4lUPFITBY/1Pr/H11pCrA0aGJFd9pEG5QaLb6rCt0SgQBbAKlaDxohH4MHqEgUAbNpvJeSjKmAqVCneM2s9OR2NBJTWS5SDzbuJFOPQOjeNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIUdsBB5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762368720; x=1793904720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qzu24zFEFiyiD2yNvbHESw70LjQHeD9bn6/zBdj6VEg=;
  b=FIUdsBB5Jy/KCDJ1flBl8NFmVPjatY2qbSPR03CShQOxj4NZ2RU+0pnJ
   7XdxliIEkzMCITsTiCy8DIN0oNfWNYpmf10SIYLg/GaSR1ix/zVKW8LQz
   IlkA6f8m9Pb7P/lKdtLx4BdlhcrSYeU1zE6y2RNj0n40naJDUHRvYPbd7
   5ZVGGKUsAAzM8gm1cgYoW8xmbepEYPHETquz5G8u424TETZruux7App+y
   KjycFtowXZ0Nc2qHcDB19pfs9QoOLl6EmIExI7Lnd6L/lP8lLOaH+xT5e
   yfR2WXSskUzc/dkabgw9d7mPU1IKIfRUeHS1TJEga23cntc5FJk7C1r19
   A==;
X-CSE-ConnectionGUID: LL8RGKOqSk2tsLOkKB9QAw==
X-CSE-MsgGUID: L3acQW/9Qmq4DlAnwmTSUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68353361"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="68353361"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:51:59 -0800
X-CSE-ConnectionGUID: Wt7+KRpgS0OpdwD2eAKEdA==
X-CSE-MsgGUID: 2lJdzH8QR/unRzO6aHP4Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="186823985"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:51:58 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGibp-00000005sMG-0wR7;
	Wed, 05 Nov 2025 20:51:53 +0200
Date: Wed, 5 Nov 2025 20:51:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQucyOYwv28Rbzrl@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <87sees73i5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sees73i5.fsf@trenco.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 11:12:18AM -0700, Jonathan Corbet wrote:
> [Heads up to Stephen: this change will add a bunch of warnings that had
> been dropped before.]
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > When kernel-doc parses the sections for the documentation some errors
> > may occur. In many cases the warning is simply stored to the current
> > "entry" object. However, in the most of such cases this object gets
> > discarded and there is no way for the output engine to even know about
> > that. To avoid that, check if the "entry" is going to be discarded and
> > if there warnings have been collected, issue them to the current logger
> > as is and then flush the "entry". This fixes the problem that original
> > Perl implementation doesn't have.
> 
> I would really like to redo how some of that logging is done, but that
> is an exercise for another day.  For now, I have applied this one,
> thanks.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



