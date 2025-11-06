Return-Path: <linux-kernel+bounces-887950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02407C396D8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDF53B1119
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B242D978D;
	Thu,  6 Nov 2025 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6n3Mu63"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9C221DAD;
	Thu,  6 Nov 2025 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414976; cv=none; b=SeeE/7UEgxeTDKnRHVQ9oqKtdOjLyUjJR0vdjGvNkdJ7WMFiiRLyU6kbCtdEyf3o6LQhRk2dbv4TcNWfpg5a2vWNwxRivtRj/XiKlcsgdKxzdGm1V5YO35KDDdzVGJEuoYQkEXwVE38/czK8MUbqe4YHXLwdCIjYzYuHaeVROuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414976; c=relaxed/simple;
	bh=nznNOJke/HsHcL6wnwE9U6YanC5PrPcGspq9GWIpTZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls63FJcpJAjo+nCoiQ2Az8Dab2y5POk/q4jezTVHH3My9K0o+WY1NHDotCkxU+Q7EGN5fIHqYx5kU8doAvM1kJCs2J41Vx4rCGENxHm70+cqpgv/HP7m5noN918CUb3uhV6dZZrxOO0oXUg8hAoxjxbq/AcygHBWKvanwqduY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6n3Mu63; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762414974; x=1793950974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nznNOJke/HsHcL6wnwE9U6YanC5PrPcGspq9GWIpTZ8=;
  b=j6n3Mu63Gr6f5gmzLmQfNDcko4dxv7bzbOdZ+Dc0BTZQODiWnAlT6BoN
   RibTobX+vwTGDxo9yyOvDvnh2T6xOa70AjChGuItKN4ScgMgF+XkbNQGU
   BeDlYZ/8noT3NQ8MtUHdzJj9aBgJ4EDJDPi3WSYuZmpvlAd7zv/wXbJZ0
   fvsReZmY/29lTSZm0LlCph8pUnzFVCE0wztNixKP2/lkzpcqGxwmbFhj3
   bQJnvc0fQklSTw6Ixp4yeVkzzAkXOhyTxeO7oYrsBF/nPRcnE7Ys7eAyz
   TiZ9cX5MQAJT192xyxA7gb8+R2iiwWD5FvDSAJq6pIcfGZzk2wfSMIMEK
   Q==;
X-CSE-ConnectionGUID: HZXpHnb+RD6TgsR1mMd59Q==
X-CSE-MsgGUID: SlIgmzryTj+/1yfU/7U4+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64641824"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="64641824"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:42:54 -0800
X-CSE-ConnectionGUID: ixjo2uwZRdumvVGHCDTVzQ==
X-CSE-MsgGUID: WCD4RGnJS1C8Vlg+w/SWEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="187532947"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:42:53 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGudt-000000061QD-17zx;
	Thu, 06 Nov 2025 09:42:49 +0200
Date: Thu, 6 Nov 2025 09:42:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQxReIZvnH7wvdi3@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <20251105221907.0c8c388b@foz.lan>
 <aQxO3MaDwFrIwCV0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQxO3MaDwFrIwCV0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 09:31:41AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 05, 2025 at 10:19:07PM +0100, Mauro Carvalho Chehab wrote:
> > Em Tue,  4 Nov 2025 22:55:02 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:
> > 
> > > When kernel-doc parses the sections for the documentation some errors
> > > may occur. In many cases the warning is simply stored to the current
> > > "entry" object. However, in the most of such cases this object gets
> > > discarded and there is no way for the output engine to even know about
> > > that. To avoid that, check if the "entry" is going to be discarded and
> > > if there warnings have been collected, issue them to the current logger
> > > as is and then flush the "entry". This fixes the problem that original
> > > Perl implementation doesn't have.
> > > 
> > > As of Linux kernel v6.18-rc4 the reproducer can be:
> > > 
> > > $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> > > ...
> > > Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> > > ...
> > > 
> > > while with the proposed change applied it gives one more line:
> > > 
> > > $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> > > ...
> > > Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> > > Warning: include/linux/util_macros.h:144 expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> > > ...
> > > 
> > > And with the original Perl script:
> > > 
> > > $ scripts/kernel-doc.pl -v -none -Wall include/linux/util_macros.h
> > > ...
> > > include/linux/util_macros.h:139: info: Scanning doc for function to_user_ptr
> > > include/linux/util_macros.h:149: warning: expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> > > ...
> > > 
> > > Fixes: 9cbc2d3b137b ("scripts/kernel-doc.py: postpone warnings to the output plugin")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  scripts/lib/kdoc/kdoc_parser.py | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> > > index ee1a4ea6e725..f7dbb0868367 100644
> > > --- a/scripts/lib/kdoc/kdoc_parser.py
> > > +++ b/scripts/lib/kdoc/kdoc_parser.py
> > > @@ -451,6 +451,13 @@ class KernelDoc:
> > >          variables used by the state machine.
> > >          """
> > >  
> > > +        #
> > > +        # Flush the warnings out before we proceed further
> > > +        #
> > > +        if self.entry and self.entry not in self.entries:
> > > +            for log_msg in self.entry.warnings:
> > > +                self.config.log.warning(log_msg)
> > > +
> > >          self.entry = KernelEntry(self.config, self.fname, ln)
> > >  
> > >          # State flags
> > 
> > No objection of this one, but this breaks the behavior of the -W
> > flags.
> 
> Sorry for that, but at least now the outcome is much better than before.
> 
> > See, the way kernel-doc.pl worked is that:
> > 
> > 1. Warnings are controlled via several -W flags:
> > 
> >   -Wreturn, --wreturn   Warns about the lack of a return markup on functions.
> >   -Wshort-desc, -Wshort-description, --wshort-desc
> >                         Warns if initial short description is missing
> > 
> >                         This option is kept just for backward-compatibility, but it does nothing,
> >                         neither here nor at the original Perl script.
> >   -Wall, --wall         Enable all types of warnings
> >   -Werror, --werror     Treat warnings as errors.
> > 
> >   Those affect running kernel-doc manually.
> > 
> > 2. Warnings are affected by the filtering commands:
> > 
> >   -e, -export, --export
> >                         
> >                         Only output documentation for the symbols that have been
> >                         exported using EXPORT_SYMBOL() and related macros in any input
> >                         FILE or -export-file FILE.
> >   -i, -internal, --internal
> >                         
> >                         Only output documentation for the symbols that have NOT been
> >                         exported using EXPORT_SYMBOL() and related macros in any input
> >                         FILE or -export-file FILE.
> >   -s, -function, --symbol SYMBOL
> >                         
> >                         Only output documentation for the given function or DOC: section
> >                         title. All other functions and DOC: sections are ignored.
> >                         
> >                         May be used multiple times.
> > 
> > 
> >   Those affect both running kernel-doc manually or when called via make htmldocs,
> >   as the kerneldoc Sphinx markup supports them.
> > 
> > As the filters are only applied at kdoc/kdoc_output.py, printing warnings
> > early at kdoc_parser means that, even ignored symbols will be warned.
> 
> Maybe I failed to make the point of the reproducer. The kernel doc and prototype
> are mismatched, and hence there is no way one may filter this in accordance
> with the logic I read. These warnings must be printed independently on the
> filters as filters may not be applied to this. Or i.o.w. what has one to put to
> -s for the reproducer case to make it visible? Also what should one put to make
> it on par with the previous behaviour?
> 
> > It might
> > also make the same warning to appear more than once, for C files that are listed
> > on multiple kerneldoc entries(*).
> > 
> > (*) There is a logic at kerneldoc.py Sphinx extension and inside kdoc_files
> >     to avoid parsing the same file twice, but I didn't test adding a hack
> >     similar to this one to double-check that the warning won't appear multiple
> >     times when export is used. Maybe it is working fine.
> > 
> > -
> > 
> > In summary, if warnings are suppressed, my suggestion would be to check at 
> > kdoc_output to see what is filtering them out. 
> 
> In the commit message I tried to explain the situation. These warning are
> vanished _before any_ output plugin is run. There is *no way* to get them
> printed otherwise.  It's, of course, possible that I haven't got deeply the
> idea behind architecture of the logging in the Python script. I am all ears for
> the improvements that satisfy everybody.
> 
> I think the problem is in design, it needs to be redone as Jon said.
> 
> > Alternatively, if the idea is to always print warnings, get rid of all
> > -W<option> flags, except for -Werror.
> 
> Not sure it's wanted behaviour, but I am in favour for anything that makes
> warning visible and not silently disappear.

Thinking more on this, I believe the -Wall must imply that any filters become
no-op.

-- 
With Best Regards,
Andy Shevchenko



