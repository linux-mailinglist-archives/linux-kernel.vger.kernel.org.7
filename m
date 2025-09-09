Return-Path: <linux-kernel+bounces-808592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467F1B50200
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F984E4985
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA231A56D;
	Tue,  9 Sep 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCyZEMEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FC25A2DA;
	Tue,  9 Sep 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433585; cv=none; b=jHOvdbsNRUG6J7UUgRuJBg5ALf2zQEe+Mlsav8Jer0DqcxOAltDaud4QflmEnjRG4xs60Fepj/BOBky0rvjOfsm2Odud40xWX6Xgc1t1bYBc3OA0EqyMKuy28/41bBfiGUgsHDt0siX3k58dtwrqNYAaYfO/045ocZjf/GEVn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433585; c=relaxed/simple;
	bh=bmW4vUzXE1B34+Xo98Az94zlo40GHEMWKS5nt0k66QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhFqFP64zKNnMFdM/P0+A1PmAuYl2Csg+j+Pvg6AuVkFtRPn5hycQDXRvWmzvC4CccqXXogkZlI9Bi+havXAJpmnqPnor1W4QjUzHzZ6xEWpyl3UEyWW+Nn1DvahXv8/d0F971/dzvyJBKIlmnZIEDjOpfqadDVSyK58G0Q+1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCyZEMEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A8C4CEF8;
	Tue,  9 Sep 2025 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757433585;
	bh=bmW4vUzXE1B34+Xo98Az94zlo40GHEMWKS5nt0k66QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCyZEMEfN3WZEyC3kp163mOhE5Oo2Q5yDEU/1fyWP4SOUGZDi6r7RmwrheSRs4pqP
	 5suloFBQYkOZgYEcdpf/iC38jyZ3tnyOgDZLjBAdoy/UFOVqAeza07b4f75DJwlC0T
	 FccDSwMPxtRGZR9zTdZnlpz/0b3fTv7S+XIThQlEbOqt0xRUd5pDta5clJJz3dJpD1
	 UF1zL1naTf2xWnq4/PWgw4LLZmwsByxAE4eU+pTqwwWQ+pP5hcGgUrReDXTSDBQvcb
	 6CLiFzFpC3Jo8z6aVY7lG0NZU3IcL3cLaou5e9Akb5X+buPdHufWC8A2sVrLalWMS5
	 2i5q2IxyMFnCQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uw0kw-00000000Qt2-3yHa;
	Tue, 09 Sep 2025 17:59:42 +0200
Date: Tue, 9 Sep 2025 17:59:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Message-ID: <7tk2mkydbcblodhipoddued5smsc3ifnmeqen5wv7eu3mbmvgi@nwxqo5366umj>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <87plbzwubl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plbzwubl.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Tue, Sep 09, 2025 at 08:53:50AM -0600, Jonathan Corbet wrote:
> Finally beginning to look at this.  I'm working from the pulled version,
> rather than the commentless patch (please don't do that again :).

Heh, when I had to rebase it, I noticed it was a bad idea to split ;-)

I'll merge the commentless patch at the next respin.

>  A nit
> from SphinxBuilder::__init__():
> 
> > #
> >         # As we handle number of jobs and quiet in separate, we need to pick
> >         # both the same way as sphinx-build would pick, optionally accepts
> >         # whitespaces or not. So let's use argparse to handle argument expansion
> >         #
> >         parser = argparse.ArgumentParser()
> >         parser.add_argument('-j', '--jobs', type=int)
> >         parser.add_argument('-q', '--quiet', type=int)
> > 
> >         #
> >         # Other sphinx-build arguments go as-is, so place them
> >         # at self.sphinxopts, using shell parser
> >         #
> >         sphinxopts = shlex.split(os.environ.get("SPHINXOPTS", "))
> > 
> >         #
> >         # Build a list of sphinx args
> >         #
> >         sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
> >         if sphinx_args.quiet is True:
> >             self.verbose = False
> > 
> >         if sphinx_args.jobs:
> >             self.n_jobs = sphinx_args.jobs
> > 
> >         #
> >         # If the command line argument "-j" is used override SPHINXOPTS
> >         #
> > 
> >         self.n_jobs = n_jobs
> 
> First of all, I do wish you would isolate this sort of concern into its
> own function.

Ok.

>  But, beyond that, you go to all that effort to parse the
> --jobs flag, but that last line just throws it all away.  What was the
> real purpose here?

heh, it sounds to be something that got lost during a rebase.
This should be, instead:

    if n_jobs:
        self.n_jobs = n_jobs   # this is parser.parse_args().n_jobs from main()

-

Basically, what happens is that the number of jobs can be on
different places:

1) if called via Makefile, no job arguments are passed at
   command line, but SPHINXOPTS may contain "-j"  on it.

   The code shall use jobserver to get it by default, with:

        # Clain all remaining jobs from make jobserver pool
        with JobserverExec() as jobserver:
            if jobserver.claim:
                n_jobs = str(jobserver.claim)
            else:
                n_jobs = "auto" 

            # some logic to call sphinx-build with a parallel flag

        # After with, claim is returned back to the
        # jobserver, to allow other jobs to be executed
        # in parallel, if any.

  this basically claims all remaining make jobs from GNU jobserver.
  So, if the  build started with "-j8" and make was called with
  other args, the number of available slots could be, for
  instance "4".

  The above logic will have jobserver.claim = 4, and run:

    sphinx-build -j4 <other args>

  This is the normal behavior when one does, for instance:

    make -j8 drivers/media htmldocs

2) if called with SPHINXOPTS="-j8", it shall ignore jobserver
   and call sphinx-build with -j8;

both cases (1) and (2) are handler inside a function

-

Now, when sphinx-build-wrapper is called from command line,
there's no GNU jobserver. So:

3) by default, it uses "-jauto". This can be problematic on
   machines with a large number of CPUs but without too much
   free memory (with Sphinx 7.x, one needs a really huge amount
   of RAM to run sphinx with -j - like 128GB or more with -j24)

4) if "-j" parameter is specified, pass it as-is to sphinx-build;

    tools/docs/sphinx-build-wrapper -j16 htmldocs

   this calls sphinx-build with -j16.

5) one might still use:

    SPHINXOPTS=-j8 tools/docs/sphinx-build-wrapper htmldocs

   or, even weirder:

    SPHINXOPTS=-j8 tools/docs/sphinx-build-wrapper -j16 htmldocs

The above logic you reviewed is handling (4) and (5). There:

   - n_jobs comes from command line;

   - this comes from SPHINXOPTS var:
	sphinxopts = shlex.split(os.environ.get("SPHINXOPTS", ""))

if both SPHINXOPTS and -j are specified like:

    SPHINXOPTS=-j8 tools/docs/sphinx-build-wrapper -j16 htmldocs                                                                                                                                                                 
IMO it shall pick the latest one (-j16). 

Yet, perhaps I should have written the code on a different way,
e.g., like:

    if n_jobs:
        # Command line argument takes precedence
        self.n_jobs = n_jobs
    elif sphinx_args.jobs:
        # Otherwise, use what it was specified at SPHINXOPTS if
        # any
        self.n_jobs = sphinx_args.jobs

I'll change it at the next spin and re-test it for all 5 scenarios.

Regards,
Mauro

