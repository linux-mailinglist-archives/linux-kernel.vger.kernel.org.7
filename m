Return-Path: <linux-kernel+bounces-817103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3FB57E01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6870718833BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45B2DC79E;
	Mon, 15 Sep 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFIodkMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF21F4C8B;
	Mon, 15 Sep 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944242; cv=none; b=syoJbqWnL4rF/xbsK/VGHxLr7+uy2UqoR2hP7eMK13NNe+4d/95nrIWJKXvhvZveocE6JWKG0o9cd5fuII43Eo5kRA4kZ/H8U6hfLiSevGUtsHMILudjMiMktpWuZVsqHutQU4Scc1FT/6+gl8cZOt+CVWfdh0x14Cjwj3sEQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944242; c=relaxed/simple;
	bh=VVQSZnONJmQxNkcY9qahnzNb2KqMvwCvZikB0PJzuC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSR6eyOP2adN+v4WoVs7S9bkXapleXXbUK3dfk/cgyyjcid/8kAIHgqQkzye6fivKyAMgWaeYnLkAucv9Jp2BTXuBY/Zhz4uheXQ7fxRSf4TctZ5EQU0sV1XREhqnVbXnRkwmmQUJ1XJ8hWE7gM1eD+Q4aQpj7iKzGa1wcRU13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFIodkMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEC1C4CEF9;
	Mon, 15 Sep 2025 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944242;
	bh=VVQSZnONJmQxNkcY9qahnzNb2KqMvwCvZikB0PJzuC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFIodkMdEQxYvS8UdQjhKiaJ1Oud523FjVkTUx9kUtbjwkeBFAKXSWGZ5bNi9SlXi
	 J4f9zHrf7vdowBooqY2YS8nqH/Bl/Dy1zt/4bUiTzZnL8WMpfQcjTNugzG12EGlEvZ
	 35mi3GZhTBzkyb5YHO/LGs8cHzY9Tml3voBlKNzvYU2IOKySRDm3bV7vZdVAdGQ7AN
	 KsPQjaJDx5Jr4lLMGmBJLcQVIsx+hmrvj+OY4aUJDW0f91TZDkNngy11AHSbHYU5T2
	 sL6pFvAHW9JRmkSpPOYUnZJXNYL94H3xKTlA+oK1k2kJrQ5K0ruln0VV/yW/We0lYt
	 v6SJ9I+tuNmRA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uy9bL-0000000AJon-36ku;
	Mon, 15 Sep 2025 15:50:39 +0200
Date: Mon, 15 Sep 2025 15:50:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Message-ID: <s5gyu27qlfg7frb4v3ssqms6inqammtakwchgl635r3ahooj5n@vhw5tnyti7nd>
References: <20250910153334.0b3e1440@foz.lan>
 <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
 <20250912130420.6c14dbbd@foz.lan>
 <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
 <6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
 <aa2aa8d2-f7f1-4f04-a9b0-f08160f9ea81@gmail.com>
 <20250915125805.25b48d09@foz.lan>
 <803501857ad28fc9635c84b7db08250dc4b9a451@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <803501857ad28fc9635c84b7db08250dc4b9a451@intel.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Mon, Sep 15, 2025 at 03:54:26PM +0300, Jani Nikula wrote:
> On Mon, 15 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > IMHO, long term solution is to change SPHINXDIRS into something
> > like:
> >
> > 	make O=doc_build SPHINXTITLE="Media docs" SPHINXDIRS="admin-guide/media userspace-api/media driver-api/media/"
> >
> > would create something similar to this(*):
> >
> > 	doc_build/sphindirs/
> > 		|
> > 		+--> index.rst
> > 		+--> admin-guide -> {srcdir}/Documentation/admin-guide/media/
> > 		+--> usespace-api -> {srcdir}/Documentation/admin-guide/media/
> > 		\--> driver-api -> {srcdir}/Documentation/admin-guide/media/
> 
> So you're basically suggesting the documentation build should support
> cherry-picking parts of the documentation with categories different from
> what the upstream documentation has? 

No. I'm saying that, if we want to have a single build process
for multiple sphinxdirs, that sounds to be the better way to do it
to override sphinx-build limitation of having single source directory.

The advantages is that:
    - brings more performance, as a single build would be enough;
    - cross-references between them will be properly solved.

The disadvantages are:
    - it would very likely need to create copies (or hard symlinks)
      at the build dir, which may reduce performance;
    - yet-another-hack;
    - increased build complexity.

I'm not convinced myself about doing it or not. I didn't like when
I had to do that after the media book was split on 3 books. If one thinks
that having for loops to build targets is a problem, we need a separate
discussion about how to avoid it. Also, this is outside of the scope of
this series.

-

Another alternative to achieve such goal of not needing a loop at Sphinx
to handle multiple books in parallel would be to submit a patch for 
Sphinx to get rid of the current limitation of having a single book
with everything on a single directory. Sphinx has already hacks for it
with "latex_documents", "man_pages", "texinfo_documents" conf.py variables
that are specific for non-html builders.

Still, when such variables are used, a post-sphinx-build logic with a
per-output-file loop is needed.

> I.e. even if we figured out how to
> do intersphinx books, you'd want to grab parts from them and turn them
> into something else?

Either doing it or not, intersphinx is intestesting. 

> Ugh.
> 
> 
> BR,
> Jani.
> 
> 
> -- 
> Jani Nikula, Intel

-- 
Thanks,
Mauro

