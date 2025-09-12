Return-Path: <linux-kernel+bounces-813781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D8B54A95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE01D7A9C77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD92FB989;
	Fri, 12 Sep 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TngnCdv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497D2DECBC;
	Fri, 12 Sep 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675065; cv=none; b=cpxC7xXImV1rSXXCOz0rpeLkzLUdy7SiA2VqD4r7p53135kVj81Lu10ondqmgCGfM3qD1Ney4sOLdRcan0AKJJNkIog2UV5USC5LKQvcDOa+pUB1acj3SwTIQYvHxK0k3Ote6zvOdKS6U9W4j0wr6GPo452OQlvYazHziI6fomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675065; c=relaxed/simple;
	bh=LWW3qkzTHqxFfVn0e2vWAWfsKkyT4vOUAIOgqy6CFkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DR+snhNVArTT7gJzSbgncBvNENxWR/4thjVCrNO10OgG+a7RQj9rJfOl4Fj7NGzEJdsBYynxboAlqxlSIH1T9r9nSjtj5jxrmkcAjkLM7xZOCyehP4HJYmApm+w9BlTt1roJ8lQxCPoBsJOiZFnBRyC2HMK05FAoThSwIjBhqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TngnCdv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40680C4CEF1;
	Fri, 12 Sep 2025 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757675064;
	bh=LWW3qkzTHqxFfVn0e2vWAWfsKkyT4vOUAIOgqy6CFkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TngnCdv3CgS6R8AiKSrzXiQRMntsF7ol0dUHXffCq2RAHxxYqngn8EERLUpcqj9w5
	 ycOSALpP3hKu/a0r1JBYu5yPabYdl0yVw6PM19TEVEt7e4ZkM5cmQ3s77DHoznf0qH
	 agU1Xg0cMIXTfXt1UvXjxdweNFiVN3Dx/ZNpk0B9ie+nIhbltI6wx2R76CKpxTESM7
	 mnwh4BHLXjLc488Mji1FG/1sntX/8YqWDPKzsPzOlV9RRwtVyYD8HDESucNc6s2kus
	 cFv7DrhtTseSPu8pPLHeKlHQV0hn1IgM7pwW5SpIWgx3wWqPVj5VOkj0USk9pPyAXP
	 KCdEEIL2bhTMQ==
Date: Fri, 12 Sep 2025 13:04:20 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, jani.nikula@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250912130420.6c14dbbd@foz.lan>
In-Reply-To: <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
References: <20250910153334.0b3e1440@foz.lan>
	<28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 12 Sep 2025 19:15:44 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [-CC: rust people and list]
> 
> OK, Looks like I have to bite.
> 
> On Wed, 10 Sep 2025 15:33:34 +0200, Mauro Carvalho Chehab wrote:
> [...]
> 
> > The current approach of using LaTeX for PDF is dirty:
> > 
> > - Sphinx can't produce a LaTeX file from the Kernel trees without
> >   hundreds of warnings;
> > - latexmk hides some of them, but even it just one warning is reported,
> >   the return status is not zero.  
> 
> This sounds interesting to me.
> As far I remember, I have never seen such strange results of latexmk
> under build envs where all the necessary packages are properly installed.

I saw it here on multiple distros including Fedora (which is the one
I use on my desktop). Media jenkins CI running on Debian always suffered
from such issues, up to the point I started ignoring pdf build results.

> I think what you are trying here is to paper over whatever bug in latexmk/
> xelatex by always ignoring their exit status.  Am I guessing right?
> 
> If that is the case, I'd rather report such an issue at upstream
> lagtexmk/xelatex.

I'm not entirely sure if this is a bug or a feature. Last time I got
one such error and did a web search, I saw similar reports explaining
the error code as if it is an expected behavior.

This is a known bug, and the current building system has a poor man
workaround for it already:

	pdfdocs: latexdocs
	       @$(srctree)/scripts/sphinx-pre-install --version-check
	       $(foreach var,$(SPHINXDIRS), \
	          $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
	          mkdir -p $(BUILDDIR)/$(var)/pdf; \
	          mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
	       )


see the "||" at make pipeline. The final "|| exit" makes the build
ignore pdf build errors. It is there since the beginning:

	cb43fb5775df ("docs: remove DocBook from the building system")

Thanks,
Mauro

