Return-Path: <linux-kernel+bounces-887940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F6C39678
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C67A4E5AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4FE27F19F;
	Thu,  6 Nov 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2Xo75aa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2034D3B5;
	Thu,  6 Nov 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414308; cv=none; b=oLefWJU+l4vi8dqeLdggFpDapfsD4QKW5Ig0anXJYpEtC1uJgl8zHV16wPhK8EW0J6zMsWSJkX727UIQZOWtDQihlGaC1KzPglttaJhj2D25wXnzia4lIQcBTJNgZnB/7VK3WpQrQVr23gnpNbelDmjf28BSzHoI3q6gRZyy3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414308; c=relaxed/simple;
	bh=aay8pF37TPmZiDBR5hJ51pIXfqhlRhsR03MyT/+PNes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8jnVnban8shAM7oHmnCyGNhB6AO1mscRDuvR84oOTOLhzE/03Sv3O5d/lgCrBURhWKsV/3FCT5R3cdaVcXX0GHLQZS5pMyYS4pQqwPG4gzfvIlCunSurGW6GG4Y65a1KbGG5v8JEWXByCxbgSmvdCd634WRarRi6ASu9R3Q/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2Xo75aa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762414307; x=1793950307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aay8pF37TPmZiDBR5hJ51pIXfqhlRhsR03MyT/+PNes=;
  b=l2Xo75aavj5jI4hoRp+ZfrzXKJYatsUZ0F3ALGZ1f1cGAuv63lPavYyP
   p7udhAS36AfE0JxFwRed/NxG+2UIbpoqum8gZmGners6fCNgfuz3jNqiL
   O4AAmwKvy4jF0/IvoboJkPZCRdtTe8hcgmU/TLWvUi/dAi3iE/pJ79TI4
   1++utEGLSq/DuAz84+58SP5fYET1uExqhFes3NvkCsWMa3j9wdT7l8R2v
   T3PZm1ZOH8CX+j3OJ4uyP1cxfgIzyCFpNleLc90JoL3YGPvV0OUR9bTla
   Xnti5kEDATHnlebuGijRbXJw5SGYtQVTld5Um8RjT3hJQ8BhkB8S4T99g
   g==;
X-CSE-ConnectionGUID: nUEI7MCuSqqbBZL5tmZBEQ==
X-CSE-MsgGUID: zlndehlHTDekeXirZLeosw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75227521"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="75227521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:31:46 -0800
X-CSE-ConnectionGUID: C+EfSaK/RBeubsoPHU5hUQ==
X-CSE-MsgGUID: NQfMUaRvRMqJ0puexrvkOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="224937059"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:31:45 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGuT7-000000061GY-03Sb;
	Thu, 06 Nov 2025 09:31:41 +0200
Date: Thu, 6 Nov 2025 09:31:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQxO3MaDwFrIwCV0@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <20251105221907.0c8c388b@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105221907.0c8c388b@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 10:19:07PM +0100, Mauro Carvalho Chehab wrote:
> Em Tue,  4 Nov 2025 22:55:02 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:
> 
> > When kernel-doc parses the sections for the documentation some errors
> > may occur. In many cases the warning is simply stored to the current
> > "entry" object. However, in the most of such cases this object gets
> > discarded and there is no way for the output engine to even know about
> > that. To avoid that, check if the "entry" is going to be discarded and
> > if there warnings have been collected, issue them to the current logger
> > as is and then flush the "entry". This fixes the problem that original
> > Perl implementation doesn't have.
> > 
> > As of Linux kernel v6.18-rc4 the reproducer can be:
> > 
> > $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> > ...
> > Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> > ...
> > 
> > while with the proposed change applied it gives one more line:
> > 
> > $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> > ...
> > Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> > Warning: include/linux/util_macros.h:144 expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> > ...
> > 
> > And with the original Perl script:
> > 
> > $ scripts/kernel-doc.pl -v -none -Wall include/linux/util_macros.h
> > ...
> > include/linux/util_macros.h:139: info: Scanning doc for function to_user_ptr
> > include/linux/util_macros.h:149: warning: expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> > ...
> > 
> > Fixes: 9cbc2d3b137b ("scripts/kernel-doc.py: postpone warnings to the output plugin")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  scripts/lib/kdoc/kdoc_parser.py | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> > index ee1a4ea6e725..f7dbb0868367 100644
> > --- a/scripts/lib/kdoc/kdoc_parser.py
> > +++ b/scripts/lib/kdoc/kdoc_parser.py
> > @@ -451,6 +451,13 @@ class KernelDoc:
> >          variables used by the state machine.
> >          """
> >  
> > +        #
> > +        # Flush the warnings out before we proceed further
> > +        #
> > +        if self.entry and self.entry not in self.entries:
> > +            for log_msg in self.entry.warnings:
> > +                self.config.log.warning(log_msg)
> > +
> >          self.entry = KernelEntry(self.config, self.fname, ln)
> >  
> >          # State flags
> 
> No objection of this one, but this breaks the behavior of the -W
> flags.

Sorry for that, but at least now the outcome is much better than before.

> See, the way kernel-doc.pl worked is that:
> 
> 1. Warnings are controlled via several -W flags:
> 
>   -Wreturn, --wreturn   Warns about the lack of a return markup on functions.
>   -Wshort-desc, -Wshort-description, --wshort-desc
>                         Warns if initial short description is missing
> 
>                         This option is kept just for backward-compatibility, but it does nothing,
>                         neither here nor at the original Perl script.
>   -Wall, --wall         Enable all types of warnings
>   -Werror, --werror     Treat warnings as errors.
> 
>   Those affect running kernel-doc manually.
> 
> 2. Warnings are affected by the filtering commands:
> 
>   -e, -export, --export
>                         
>                         Only output documentation for the symbols that have been
>                         exported using EXPORT_SYMBOL() and related macros in any input
>                         FILE or -export-file FILE.
>   -i, -internal, --internal
>                         
>                         Only output documentation for the symbols that have NOT been
>                         exported using EXPORT_SYMBOL() and related macros in any input
>                         FILE or -export-file FILE.
>   -s, -function, --symbol SYMBOL
>                         
>                         Only output documentation for the given function or DOC: section
>                         title. All other functions and DOC: sections are ignored.
>                         
>                         May be used multiple times.
> 
> 
>   Those affect both running kernel-doc manually or when called via make htmldocs,
>   as the kerneldoc Sphinx markup supports them.
> 
> As the filters are only applied at kdoc/kdoc_output.py, printing warnings
> early at kdoc_parser means that, even ignored symbols will be warned.

Maybe I failed to make the point of the reproducer. The kernel doc and prototype
are mismatched, and hence there is no way one may filter this in accordance
with the logic I read. These warnings must be printed independently on the
filters as filters may not be applied to this. Or i.o.w. what has one to put to
-s for the reproducer case to make it visible? Also what should one put to make
it on par with the previous behaviour?

> It might
> also make the same warning to appear more than once, for C files that are listed
> on multiple kerneldoc entries(*).
> 
> (*) There is a logic at kerneldoc.py Sphinx extension and inside kdoc_files
>     to avoid parsing the same file twice, but I didn't test adding a hack
>     similar to this one to double-check that the warning won't appear multiple
>     times when export is used. Maybe it is working fine.
> 
> -
> 
> In summary, if warnings are suppressed, my suggestion would be to check at 
> kdoc_output to see what is filtering them out. 

In the commit message I tried to explain the situation. These warning are
vanished _before any_ output plugin is run. There is *no way* to get them
printed otherwise.  It's, of course, possible that I haven't got deeply the
idea behind architecture of the logging in the Python script. I am all ears for
the improvements that satisfy everybody.

I think the problem is in design, it needs to be redone as Jon said.

> Alternatively, if the idea is to always print warnings, get rid of all
> -W<option> flags, except for -Werror.

Not sure it's wanted behaviour, but I am in favour for anything that makes
warning visible and not silently disappear.

-- 
With Best Regards,
Andy Shevchenko



