Return-Path: <linux-kernel+bounces-822310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD99B8382D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377B44615F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F22F3632;
	Thu, 18 Sep 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H35qUX0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2E2F1FDC;
	Thu, 18 Sep 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183882; cv=none; b=pGyI7PMNYfGybdozTnfC8+yU9YUCQv6e4XGA4XyMmxuBdbDV00W/8RztWDBJIR+xz5Hb7DemLFCz2lWXOg92TaNbRG9e5j3uavjCmT5m+0uR/FLHgsCAOGYlQhb8cUtmONGds83RTKQS2w9WqCyo4LfIdtNpcwgs5hSmb8F3Vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183882; c=relaxed/simple;
	bh=nr4NWLVlw/K5BK59dcgOAF7rOQHWbDbROkErLKcolIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jn/gHxdj7nIUW5SgqYmFoPfPU/3Q4xyZFNtH9T2HNiJxbiSe7I+2LcItiCz/L2QCCNih4cPgYULM3+2HzNzPwNhK8grAiQhZfmfJyWfht1wD+zRRZ+VR5y1328gbqv6njPFOqCSDuHzb8FbTXr0KhDQ4dbJ38i3If+V9EaDpYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H35qUX0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DE0C4CEE7;
	Thu, 18 Sep 2025 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758183882;
	bh=nr4NWLVlw/K5BK59dcgOAF7rOQHWbDbROkErLKcolIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H35qUX0nnVNeRdkJ3J3gjRuCRR/erGHvGGAFFQ4BSEDvI090nCV3XF9l6bwkzdEk3
	 C00t4swSUs4+md3tmoSIymPaUhTHE+u6bEv6hEazVKDnqEUt0mUY2vGDOPgSyneFfg
	 kV8hne+wkFUvAo/pXNu6qAJh2jTi2gHsoTyyNM5avthukYYeUKmb/RUT3QAlBz6GNj
	 8Vry7KDNMh7XlfmNm7lRAybzgi5ydcflZL12cS1ooBAQ6pTR2Uxs9fuhtWfjwlKrT+
	 RbwVeptRvlUZyfi1Y6A137CbeT5vtKmwO/kmzuDsAf1cd/hXgM4B4J9lmTK0AKNud1
	 BL29rc+AYWOOg==
Date: Thu, 18 Sep 2025 10:24:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v6 10/21] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250918102437.3a9c770b@foz.lan>
In-Reply-To: <ed4eeee3-4e95-4bf4-b19f-cf7d38d8a1ea@gmail.com>
References: <4d4dc78a4e29f2478fd1c1a746378dc61a090ca3.1758018030.git.mchehab+huawei@kernel.org>
	<1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
	<875xdhazcq.fsf@trenco.lwn.net>
	<ed4eeee3-4e95-4bf4-b19f-cf7d38d8a1ea@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Sep 2025 08:43:19 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Jon,
> 
> Jonathan Corbet wrote:
> > Akira Yokosawa <akiyks@gmail.com> writes:
> >   
> >> Wait!  In the cover-letter, you said:
> >>
> >>     It should be noticed that it is out of the scope of this series
> >>     to change the implementation. Surely the process can be improved,
> >>     but first let's consolidate and document everything on a single
> >>     place.
> >>
> >> Removing current restriction on SPHINXDIRS does look inconsistent with
> >> your own words to me.
> >>
> >> So, I guess I have to NAK 06/21 as well.  
> > 
> > Is there an actual problem with this change that we need to know about?
> > I am not quite understanding the objection here.  
> 
> As Mauro has pointed out, and as I could not apply v6 series, I failed
> to look at the whole patch.
> 
> My knee jerk reaction came from the fact that, for example,
> 
>     make SPHINXDIRS=translations/zh_CN pdfdocs
> 
> won't build.  This is because I didn't know such a sub-directory is
> allowed (despite what "make dochelp" says) in SPHINXDIRS.

The build system does support it, provided that the directory has
an index.rst file (not all subdirs have)...

> 
> At the time I made "improvements in CJK font configs", I embedded
> hacky ".. raw:: latex     \kerneldocCJKoff" and others in:
> 
>      Documentations/index.rst
>                    /*/index.rst

... and that ".. raw:: " entries don't depend on previous .rst files.

> , assuming all of those latex macros would appear in translations.tex
> in the right order.
> 
> I admit it was not ideal, but I could not, and still can not, come up
> with a more robust approach.

For LaTeX build, ".. raw:: " entries can be unavoidable, but you could
place it either:

- at conf.py if they're global;
- on each rst file (that's what we do on media);
- in the case of translations, for the languages that require CJK.

Grepping it:

	$ git grep kerneldocCJK Documentation/translations/
	Documentation/translations/index.rst:   \kerneldocCJKoff
	Documentation/translations/it_IT/index.rst:     \kerneldocCJKoff
	Documentation/translations/ja_JP/index.rst:     \kerneldocCJKon
	Documentation/translations/ko_KR/index.rst:     \kerneldocCJKon
	Documentation/translations/ko_KR/process/howto.rst:     \kerneldocCJKoff
	Documentation/translations/ko_KR/process/howto.rst:     \kerneldocCJKon
	Documentation/translations/sp_SP/index.rst:     \kerneldocCJKoff
	Documentation/translations/zh_CN/index.rst:     \kerneldocCJKon
	Documentation/translations/zh_TW/index.rst:     \kerneldocCJKon

Indeed it assumes that translations/index.rst will be the last one,
as it is needed to disable \kerneldocCJKoff.

What I would do is move \kerneldocCJK to each book, e.g.:

   zh_CN/index:	will have a \kerneldocCJK{on/off} pair;
   zh_TW/index:	will have a \kerneldocCJK{on/off} pair;
   it_IT/index: won't use it, as it doesn't need CJK fonts;
   ko_KR/index:	will have a \kerneldocCJK{on/off} pair;
   ja_JP/index:	will have a \kerneldocCJK{on/off} pair;
   sp_SP/index:	will have a \kerneldocCJK{on/off} pair;
   process/index: won't use it, as everything there is in English;

This would likely allow creating each translation on separate books
like:

	make SPHINXDIRS="translations/zh_CN translations/ko_KR ..." pdfdocs

Heh, the audience for each language is completely different, so
merging them altogether is actually weird. This doesn't matter 
much for html output, but for all other outputs, ideally each
translation should be a separate book.

With the current Makefile-hacky-based-approach, supporting separate
build books would be very complex, but with a wrapper containing the
entire building logic, it doesn't sound hard to add support in the
future to build translations as separate entities.=

Heh, when we added Sphinx support, we have a single Documentation
directory, but now we have multiple ones:

	$ find . -name Documentation
	./tools/bpf/bpftool/Documentation
	./tools/perf/Documentation
	./tools/memory-model/Documentation
	./tools/lib/perf/Documentation
	./tools/objtool/Documentation
	./tools/build/Documentation
	./Documentation
	./drivers/staging/most/Documentation
	./drivers/staging/greybus/Documentation
	./drivers/staging/iio/Documentation

Considering that, and considering the some of the above books can
be in ReST format, it doesn't sound too complex to add a --docdir
parameter at sphinx-build-wrapper and do things like:

	./tools/docs/sphinx-build-wrapper --docdir Documentation/translations/zh_CN htmldocs
	./tools/docs/sphinx-build-wrapper --docdir Documentation/translations/zh_TW epubdocs
	./tools/docs/sphinx-build-wrapper --docdir ./tools/bpf/bpftool/Documentation mandocs

On such scenario, we likely need intersphinx, as translation books contain lots of
references pointing to the English one.


Thanks,
Mauro

