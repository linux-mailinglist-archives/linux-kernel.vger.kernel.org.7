Return-Path: <linux-kernel+bounces-823368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE5B8637C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991647C65F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3C2BDC3F;
	Thu, 18 Sep 2025 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWpvUTCn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D490258EE9;
	Thu, 18 Sep 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216807; cv=none; b=AdB401xzp0yTAOf1tHqHni0HiNA+zK55tlVzfyqg+nDyQeBgwu8ud7KlGusA7MpcZU8JH32hXkao8jH2e4QObolIeoVn3n2fEjKxiX3PW4CzSH081TZXLC92zB5S5/xO7mPdEdP9QjGRDifuW40ALppKHAhp7OLIfQWnEsHzyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216807; c=relaxed/simple;
	bh=o5Mi5RTVZPdLCZiio2GuBYItztE9raPW/ws7HtV0wuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4yvyDa+xjvHyPIRSRtfMvQvfdBRVzfJj9XVcEezL2roTf25uQO1L7RyCPdexFZrYLdHWBh8nEJvu7ssjd9YguddxhgbdAOfABn91J76FmRODuW4kh7XcxPBoVawTT/g7ZAd+b4Bn97/SaecvTiVMumwp53yqTtJmLtySKlkTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWpvUTCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA31EC4CEE7;
	Thu, 18 Sep 2025 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758216805;
	bh=o5Mi5RTVZPdLCZiio2GuBYItztE9raPW/ws7HtV0wuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWpvUTCnUin5ZWvmLL9oVblUw6/pVt/Ezs3LZt3OguqkkYoAKQ4tdfCdGgTcv4a7I
	 fvPcPFck8GiQQ6k/B3DyRvHrI+7o+XAChY7I4GZOk6kBa2bC36uFDriPP0HsSRqFA2
	 KjjYhOKzgiiWxyX3BlnzEn9ByXnXuv1KGZdyh+CXniMI+PVi1vzMF4uFeAyCvQyAzs
	 +swMynGhtsVI8IrVBlate8WzbqQbUCi71q71xdcUShYWF6U9jmr4lXWjfuOH0BaLua
	 nEOddxlE4L8Nt/kJPcgLv/6nKRLPVgEmSg7mK+67aoc/Ztt60nYWqeupFiWkXe/yn7
	 urpT5p3gKOUyA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzIVX-0000000D09x-329n;
	Thu, 18 Sep 2025 19:33:23 +0200
Date: Thu, 18 Sep 2025 19:33:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/24] scripts/jobserver-exec: move the code to a class
Message-ID: <t565x25o3gftbwzekhx6uanmxbkfdeqyydhkulwru5uszbw5wd@d7edoparssgv>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
 <4749921b75d4e0bd85a25d4d94aa2c940fad084e.1758196090.git.mchehab+huawei@kernel.org>
 <87segj7l5r.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87segj7l5r.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Thu, Sep 18, 2025 at 10:58:08AM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > +class JobserverExec:
> > +    """
> > +    Claim all slots from make using POSIX Jobserver.
> > +
> > +    The main methods here are:
> > +    - open(): reserves all slots;
> > +    - close(): method returns all used slots back to make;
> > +    - run(): executes a command setting PARALLELISM=<available slots jobs + 1>
> > +    """
> > +
> > +    def __init__(self):
> > +        """Initialize internal vars"""
> > +        self.claim = 0
> > +        self.jobs = b""
> > +        self.reader = None
> > +        self.writer = None
> > +        self.is_open = False
> > +
> > +    def open(self):
> > +        """Reserve all available slots to be claimed later on"""
> > +
> > +        if self.is_open:
> > +            return
> > +
> > +        try:
> > +            # Fetch the make environment options.
> > +            flags = os.environ["MAKEFLAGS"]
> > +            # Look for "--jobserver=R,W"
> > +            # Note that GNU Make has used --jobserver-fds and --jobserver-auth
> > +            # so this handles all of them.
> > +            opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> > +
> > +            # Parse out R,W file descriptor numbers and set them nonblocking.
> > +            # If the MAKEFLAGS variable contains multiple instances of the
> > +            # --jobserver-auth= option, the last one is relevant.
> > +            fds = opts[-1].split("=", 1)[1]
> > +
> > +            # Starting with GNU Make 4.4, named pipes are used for reader
> > +            # and writer.
> > +            # Example argument: --jobserver-auth=fifo:/tmp/GMfifo8134
> > +            _, _, path = fds.partition("fifo:")
> > +
> > +            if path:
> > +                self.reader = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
> > +                self.writer = os.open(path, os.O_WRONLY)
> > +            else:
> > +                self.reader, self.writer = [int(x) for x in fds.split(",", 1)]
> > +                # Open a private copy of reader to avoid setting nonblocking
> > +                # on an unexpecting process with the same reader fd.
> > +                self.reader = os.open("/proc/self/fd/%d" % (self.reader),
> > +                                      os.O_RDONLY | os.O_NONBLOCK)
> > +
> > +            # Read out as many jobserver slots as possible
> > +            while True:
> > +                try:
> > +                    slot = os.read(self.reader, 8)
> > +                    self.jobs += slot
> > +                except (OSError, IOError) as e:
> > +                    if e.errno == errno.EWOULDBLOCK:
> > +                        # Stop at the end of the jobserver queue.
> > +                        break
> > +                    # If something went wrong, give back the jobs.
> > +                    if self.jobs:
> > +                        os.write(self.writer, self.jobs)
> > +                    raise e
> > +
> > +            # Add a bump for our caller's reserveration, since we're just going
> > +            # to sit here blocked on our child.
> > +            self.claim = len(self.jobs) + 1
> > +
> > +        except (KeyError, IndexError, ValueError, OSError, IOError):
> > +            # Any missing environment strings or bad fds should result in just
> > +            # not being parallel.
> > +            self.claim = None
> 
> Sigh ... this kind of massive try/except block is one of the best ways
> I've found in Python to hide bugs - and Python has a few of those.  I
> realize this is existing code, this is not the place to fix it, but I
> would like to clean that up at some point.

Agreed: this class deserves some cleanup.

While working here, I considered doing more changes, but I refrained
myself. As you pointed, this is not the right series to do large
changes. Also, this is used not only for documentation build but also
inside scripts/Makefile.vmlinux_o. A major change there could affect
vmlinux generation.

Btw, besides Python cleanups, IMHO jobserver class could benefit
on having a maximum value for claim (which could even be 1). I was
also tempted to add a jobserver-aware subprocess.call here.

That's said, doing a risk analysis, if it fails to properly read
jobserver pipes, the except logic will set claim to None, which:

- for documentation: will use "-jauto";
- for vmlinux generation: will probably use a single job when
  building vmlinux. If target dependencies are correct, this
  should not cause build failures.

On my tests, I didn't get any such exception for doc build. I
wrote a small testbench to check if jobserver was handling claim
the right way. Before/after the changes, the behavior remained
the same, and caim was always initialized when running via make.

-- 
Thanks,
Mauro

