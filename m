Return-Path: <linux-kernel+bounces-804142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FCDB46AB1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FBE1BC658F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F202DE718;
	Sat,  6 Sep 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKeUgGsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07252C032C;
	Sat,  6 Sep 2025 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757151658; cv=none; b=tCOHhiFLcMugfO31cieY2tr0X9xR5HxbsC4CixgrVLFzUnoKOf9NChRMf1HT8qXe7YsvD2GkfjKF8d6ZbS0MNwMXnWJdJV3NsTU+JHCqCNZVhPHc/YFItYnGDWu28DzeCOradkUp7KDUj1igyh91t9vA6+WU2EMSHld6IxESEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757151658; c=relaxed/simple;
	bh=JUFAncsfpeE15TmlQMq7DVXe85G2NJmyOIEQi4XGq9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdKu7D3nSBTdh45nk41nNwN+lmiAY4V5F7WCPVNQjqEvLqI+MsJglI/O+JJZ09odcYV8L5PqX0SlHuCdHPhIM/Kxi6JL3hCUSNB9hYfsexYJhrn1QQD3JDDDZgAXCXjw0+GsWmxuxPfjgjM58sq2LGewITZ6a5a4q0NYgOAewFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKeUgGsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2659CC4CEE7;
	Sat,  6 Sep 2025 09:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757151658;
	bh=JUFAncsfpeE15TmlQMq7DVXe85G2NJmyOIEQi4XGq9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKeUgGsnbPm9s4K1qJOODWBi7kvtOwgEJsdNNW8/FS3VucolozDc6bGibglhxgPdB
	 bT38JKE8U7esiywfsBnt0Gq+ghIxCOCg8wiJLnetGOU0AoogCvAIF9ltp5U4hxb9jU
	 fGQbC16F8io8WWjTJJCCxtet7hUUtcRI0mpypmuksls0Xmww8tTCVkrbk454ZedkGE
	 xHk1Nu79KTEdjymJRJTw/ytft4MFOnjUIdykR5GP26nI8R7mRMZwerNIxHPAcbm0Sg
	 +vEcR1NSxybDg1dYhnHi9uvFQG0CEGIkvxv1k0TQCAfw6Zp13t0hxV6TWPeeBZ+pP/
	 4IRfsevlgTcqQ==
Date: Sat, 6 Sep 2025 11:40:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 00/19] Split sphinx call logic from docs Makefile
Message-ID: <20250906114052.4d2109f9@foz.lan>
In-Reply-To: <87y0qskhm0.fsf@trenco.lwn.net>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<87y0qskhm0.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 05 Sep 2025 10:07:51 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > This series does a major cleanup at docs Makefile by moving the
> > actual doc build logic to a helper script (scripts/sphinx-build-wrapper).
> >
> > Such script was written in a way that it can be called either
> > directly or via a makefile. When running via makefile, it will
> > use GNU jobserver to ensure that, when sphinx-build is
> > called, the number of jobs will match at most what it is
> > specified by the "-j" parameter.  
> 
> I will try to make another pass over this stuff later today.  I would
> really appreciate some more eyes on it, though, and perhaps even some
> reports of testing.  This is a significant change, and the presence of
> surprised would not be ... surprising ...

Take your time.

Yeah, tests are very welcomed. The change itself is not significant
in the sense that we just moved a complex logic with lots of magic
from Makefile to Python (*) without changing the implementation, but 
yeah, it requires testing. From my side, I've been testing cleandocs,
htmldocs and pdfdocs for 3-4 weeks now on over ~20 different distros,
all without O=, but didn't make any burn-in test for the other targets.

I've got (and fixed) some corner cases, but I won't doubt that other
corner cases might be there.

(*) It actually solved one issue: with current implementation, at least for me,
    using V=1 doesn't show the sphinx-build command line, as this is hidden
    inside the complex makefile foreach macro:

	loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;

	quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
	      cmd_sphinx = \
	       PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
	       BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(src)/$5/$(SPHINX_CONF)) \
	       $(PYTHON3) $(srctree)/scripts/jobserver-exec \
	       $(CONFIG_SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
	       $(SPHINXBUILD) \
	       -b $2 \
	       -c $(abspath $(src)) \
	       -d $(abspath $(BUILDDIR)/.doctrees/$3) \
	       -D version=$(KERNELVERSION) -D release=$(KERNELRELEASE) \
	       $(ALLSPHINXOPTS) \
	       $(abspath $(src)/$5) \
	       $(abspath $(BUILDDIR)/$3/$4) && \
	       if [ "x$(DOCS_CSS)" != "x" ]; then \
	               cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
	       fi

	htmldocs:
	...
	       @+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))

    IMHO, this is problematic, as it makes harder to debug corner
    cases. While doing this changeset, I actually had to add an echo
    line to show the command line, to ensure that sphinx-build was
    called with the same arguments.

    On a side note, the above macro is complex and hard to maintain.

    One of the reasons why the Python script is bigger is that it
    has one statement per line instead of trying to do lots of
    calls inside a single statement like above (there, cmd_sphinx
    has 8 function calls; htmldocs foreach line has 3).

    The core of cmd_sphinx grew from 14 LOC on Makefile to 64 lines
    in Python, not counting:

	- comments
	- CSS logic
	- path handling logic
	- jobserver logic (in Makefile, this is a single "+" character,
  	  at the foreach line)

    I remember I had to touch on the foreach/call logic there a couple
    of times in the past. It is not the easiest thing to do.

Thanks,
Mauro

