Return-Path: <linux-kernel+bounces-823763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06DB8764D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EFB1881545
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FD239E8D;
	Thu, 18 Sep 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyFwobFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B72110;
	Thu, 18 Sep 2025 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238788; cv=none; b=USPaO8KixrsyQkzx6+c6JQzIL/LkzDIlkCQHYrWSbxywe6/XB2lX6zUXzIY8YOAlIBhji0Q6LrbFVtLW6HADErnrbJbsZOBG5HfFkes00pFbGC9BFnliCfBTc9porh6JXWsCNtmXFAH1MA9PjQlsvFR40gBEhj79lj6MiVDu7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238788; c=relaxed/simple;
	bh=cmVR3VrPLrmlzgJIOYLioMOVCguB/rlBS4ynnyUtnkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0zGCCCPJbiDTpJd5PDklCmYxZNvOqO356U3pRbyhsnCD0Cdm3Kf0NL0BTKSJ/hLp4YlrNHfmJlCu5Gtzd9VOmydIiCuInC39ROGemstx8GE3VZrMpd9IaJ++LBqsWC2arleBmAnAoaLn300TFdS/f6agllK2x23BYT4YRgV7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyFwobFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DEEC4CEE7;
	Thu, 18 Sep 2025 23:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758238786;
	bh=cmVR3VrPLrmlzgJIOYLioMOVCguB/rlBS4ynnyUtnkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cyFwobFElPn17T8yOchnWssn4j7WFHf3ck/9Wziz0dP/JWFT1O4c3k4cOzE174eeC
	 bpLJ8E6MA9w+ssrR95bajkZO/4vz/2y9mlkvI2g59DL7jnfF9tvdw7UbUzC3YiDjPq
	 20Ki3WJ79dEMs3+GK+KId88Bctlx0aOaDxsbC8z5LYJMkys1dkS4m2LpikG4IlIYQ2
	 TtbqIUMwwjePkhKgtJpiPPsvhxpqcAckRlTFa4OhXE9bfICqqIJUVbuGFmd5RpXEh/
	 JCkhr+/fdGipcwz0gqUvrRYsuOrT74EHXrpLTWSB/m6p+NfMBexC5ZUx6Tv6PpOkiN
	 12ATXtK0k4Npg==
Date: Fri, 19 Sep 2025 01:39:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v8 00/24] Split sphinx call logic from docs Makefile
Message-ID: <20250919013942.030544ed@foz.lan>
In-Reply-To: <878qib7dy6.fsf@trenco.lwn.net>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
	<87ldmb7iuo.fsf@trenco.lwn.net>
	<20250918212304.0efa2847@foz.lan>
	<878qib7dy6.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Sep 2025 13:33:53 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> >> I haven't
> >> had the time to figure it out.  
> >
> > I don't remember anymore what "subproject" really means inside
> > ".. only::", block, but I guess it is meant to be used when one
> > passes SPHINXDIRS.  
> 
> I found myself in a similar position...  it is set in
> Documentation/sphinx/load_config.py, it seems a certain Mauro added that
> in 2019 :) 

LOL!

> Since then, it has seemingly been cargo-culted all over the
> place; I wonder if we really need it.

It looks to me that it have been ages since last touched load_config.py,
as it is hard to remember about its dirty secrets.... Maybe it is part
of some traumatic experiences that we shared ;-)

Anyway, looking at:
	a84d9e899683 ("docs: load_config.py: avoid needing a conf.py just due to LaTeX docs")

and seeking for what we had before, you might noticed that, in the
early days, someone called Jonathan wrote patches for instance, adding
core-api docs, including this one:
	
	commit 22917b992d3713157e759f23a5a090687d004331
	Author: Jonathan Corbet <corbet@lwn.net>
	Date:   Wed Nov 16 16:07:02 2016 -0700

	    docs: Add more manuals to the PDF build
    
	    There were a few manuals that weren't being built in PDF format, but
	    there's no reason not to...
    
	    Signed-off-by: Jonathan Corbet <corbet@lwn.net>

	diff --git a/Documentation/core-api/conf.py b/Documentation/core-api/conf.py
	index fed87ab7f486..db1f7659f3da 100644
	--- a/Documentation/core-api/conf.py
	+++ b/Documentation/core-api/conf.py
	@@ -3,3 +3,8 @@
	 project = "Core-API Documentation"
 
	 tags.add("subproject")
	+
	+latex_documents = [
	+    ('index', 'core-api.tex', project,
	+     'The kernel development community', 'manual'),
	+]

there you can see that our mistic "subproject" tag was already present :-D

What happens is that, before a84d9e899683, for every single book we
wanted to build via SPHINXDIRS, a conf.py file was required. 

The actual logic is a way more complex than that, but what it does is
similar to (untested):

    #
    # namespace comes from conf.py: loadConfig(globals())
    #
    def loadConfig(namespace):
	if os.path.basename(os.getcwd()) != "Documentation":
		config = namespace.copy()
	        config['tags'].add("subproject")
	        namespace.update(config)

(it also has some logic there for latex_documents)

On other words:

- subproject exists only on Documentation subdirs. It is basically
  used to tell *.rst files that SPHINXDIRS=<subdirs>

- its goal is to run genindex when SPHINXDIRS is used to build
  html documentation.

And that explains why when rust is built, it has a duplicated indexes:
neither the current docs Makefile nor sphinx-build-wrapper should be
manually adding "-t subproject".

-

That's said, as part of our doc build cleanups, IMHO we should add on
our todo to drop load_config.py, adding the missing bits on conf.py
while properly documenting it.

Thanks,
Mauro

