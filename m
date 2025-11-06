Return-Path: <linux-kernel+bounces-888565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE3C3B2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474BD460C89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3832ABF6;
	Thu,  6 Nov 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umurNRIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3292D531;
	Thu,  6 Nov 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434753; cv=none; b=ectb0D9kFcGEht2UlV4pFFGYVyjzrm0pRt3eYo7Z45rkcSWG/P/OwJxlm/16rm68s/WTHTa9FeiOOXZcnfnjA7zTS+/gBEPtr+e1XIAhUU9qKOzc4rO6qdXMe+T/tGzV2QhzXYmyI91bpw8uHl2jLgHD37cI+l64PneLN2OnJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434753; c=relaxed/simple;
	bh=jW/9N9Kbhh2Gta55fasTKB2i3WMcMbCAvYsE2ozkwE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVG4dRmb2CKGNiDnl1x8KQojtLhJodCvn8UmWTKaCz7xaZIFRsjineLO16qGKWubRinXpVZio8o4ZfLHlgsCCfOVQBFp2b+pA920+EUBsrD+u+xYEAW+hloRYSVWi7DfJjF9+PDxFsCjoZYwjDjuC0j61VySo3+tq3Qj1TQqp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umurNRIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B5FC4CEFB;
	Thu,  6 Nov 2025 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762434753;
	bh=jW/9N9Kbhh2Gta55fasTKB2i3WMcMbCAvYsE2ozkwE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umurNRIbED9AV7S9HCzMudqiUsIeLUqE4IdR1ZFlmWH7hvCDUbiYvaI/oJtXYAu1A
	 B4j+tI72qA9dMWIbSAokEdbhrw2Klu4cjYhJmw1sqXj9KYH/Vam3L+3DXO7EAeezIE
	 HnTpdADXtrbVomggyDGsmf5d+ryM7yn8UHnJ9UTIuD7imnGQ8mHu0tMCBOjYoHNOzL
	 5FoTwYg5NhZzqasqeuKO9Jcs6e+vIEY4vf5YG1aZpLxyskCG9KNdqQ+QiI/5ycjvHI
	 M/MMlzSqjYO3OBZ91P97U7rrBlxNDxO9q7ndC8xuBhhDxJWhSDYUZnFjsAvnNoDAhV
	 O8onVApi/Lulg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vGzmw-000000013rw-3gnX;
	Thu, 06 Nov 2025 14:12:30 +0100
Date: Thu, 6 Nov 2025 14:12:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <3fnulqi7hfplggfqevab525clikq7fnsnt72lauddzy32sepyq@maux2bgqa3np>
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
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Thu, Nov 06, 2025 at 09:31:40AM +0200, Andy Shevchenko wrote:
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

That's why I said I'm not against ;-)

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
> with the logic I read.

I see.

> These warnings must be printed independently on the
> filters as filters may not be applied to this. Or i.o.w. what has one to put to
> -s for the reproducer case to make it visible? Also what should one put to make
> it on par with the previous behaviour?

FYI, I'm not a big fan of warning suppression. I only implemented the
-W flags on Python after implementing all other functionalities.

I did it mostly because I wanted to be bug-compatible with the perl
version. Heh, even on the perl version, one of the -W flags weren't
used.

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

Originally, the warning function were just printing all warnings there
directly. After I finished the script, I had to move them to be shown
after filtering, in order to reproduce the same behavior of the -W flags.

If we get rid of them (your patch effectively did that), we can just
simplify the warning function and drop the prints from the output module.

From my side, IMO this is the best alternative.

> > Alternatively, if the idea is to always print warnings, get rid of all
> > -W<option> flags, except for -Werror.
> 
> Not sure it's wanted behaviour, but I am in favour for anything that makes
> warning visible and not silently disappear.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Thanks,
Mauro

