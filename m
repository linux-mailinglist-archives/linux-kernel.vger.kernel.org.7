Return-Path: <linux-kernel+bounces-869712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EDDC088F4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4BD3A6EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37224469E;
	Sat, 25 Oct 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqzuyYsI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65948204583;
	Sat, 25 Oct 2025 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761359611; cv=none; b=eqMvog+9bDCGaLy0Vy2BT25hXQIdT5b7tFq6oKnC+Q2xLwD+97pgHOwqn/nkc76Q+Tf/D1WmAtFt+YayUIrUBPpvm/FiietvJKAVuwuygmfPkRPYzqnLsR11rHCWm9D0bXlp6AxFG10dwZrAVT+4FHClM4AObufLB7pVjsilGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761359611; c=relaxed/simple;
	bh=H6vwnKYEndeJUPyf4ITO8rD38NBCnhRGZasNa0uPvaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDGp+ewV+M5VvJsv0RIuguYylh6zMpZsoBwkiO39y8SvJayW4kztVTixCuRQGX2ZvfaYNJXEUAGkGooQzFEWw6SqJSRxZFwsIJDlS2EgE8tKlwtJiKBGUXD4/bUjfZhyNTYO4v5/gj0JjcIB7ktwnF4eQCi0U4bKhz2HCUhiGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqzuyYsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74962C4CEF1;
	Sat, 25 Oct 2025 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761359610;
	bh=H6vwnKYEndeJUPyf4ITO8rD38NBCnhRGZasNa0uPvaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BqzuyYsIDriEw9/k42HAXlc1D/U6kSDHo7Hvv80bzCIo66X8odW9gRsuSieSBL+kw
	 CeodC1sll/em8ozs5ergMyip7u2bS2rIyJcoG6G+4aIQvYanGHdkZoQpl9w0ENEr91
	 UF0yiZb1fqcNYRDik7STc8BuTqoRVRFVhIjzE0gKPp11PrDHAeE0GcebDngoPicoAI
	 OQpmDdEQMeaf/57xmqW8K/hmfumRBWH24YN67n4LFyHveM0L0a2UHhlfmPUvuRHxYA
	 aE4zV1oHjelSOD3Vef/B3hlW0D6gGOHLJ7M6MffaxnpVUDQGLlDKWiTwFI96UNDxJm
	 qYO2mXD4UXUyA==
Date: Fri, 24 Oct 2025 23:33:20 -0300
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Jani Nikula
 <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
Message-ID: <20251024233320.3346a24d@sal.lan>
In-Reply-To: <20251024200834.20644-1-corbet@lwn.net>
References: <20251024200834.20644-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 24 Oct 2025 14:08:21 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Our documentation-related tools are spread out over various directories;
> several are buried in the scripts/ dumping ground.  That makes them harder
> to discover and harder to maintain.
> 
> Recent work has started accumulating our documentation-related tools in
> /tools/docs.  This series completes that task, moving the rest of our
> various utilities there, hopefully fixing up all of the relevant references
> in the process.
> 
> At the end, rather than move the old, Perl kernel-doc, I simply removed it.

LGTM.

For the entire series:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> 
> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.  I would propose either tools/python or lib/python;
> thoughts on that matter welcome.

Agreed that it should be moved out of scripts/lib. Besides that,
I don't care much about its location. My personal preference would
be (with no particular order):

	- tools/python_lib
	- tools/lib_python
	- tools/lib_py
	- tools/lib

(lib/python works for me as well)

Or, if we don't aim to share code with docs and non-docs python
code, we can use:

	- tools/docs/lib

> 
> Changes in v3:
>   - Now with more caffeine! Properly based on docs-next.
> 
> Changes in v2:
>   - Rebase on top of all of Mauro's changes (the most painful rebase I've
>     ever done, I think).
>   - Land everything in /tools/docs/ rather than /tools/doc/
> 
> v2: https://lore.kernel.org/lkml/20251023161027.697135-1-corbet@lwn.net/
> v1: https://lore.kernel.org/lkml/20250813213218.198582-1-corbet@lwn.net/
> 
> 
> Jonathan Corbet (8):
>   docs: Move the "features" tools to tools/docs
>   docs: move checktransupdate.py to tools/docs
>   docs: move scripts/documentation-file-ref-check to tools/docs
>   docs: move get_abi.py to tools/docs
>   docs: move test_doc_build.py to tools/docs
>   docs: move kernel-doc to tools/docs
>   docs: move find-unused-docs.sh to tools/docs
>   docs: remove kernel-doc.pl
> 
>  Documentation/Kconfig                         |    2 +-
>  Documentation/Makefile                        |    6 +-
>  Documentation/conf.py                         |    2 +-
>  Documentation/doc-guide/checktransupdate.rst  |    6 +-
>  Documentation/doc-guide/contributing.rst      |    2 +-
>  Documentation/doc-guide/kernel-doc.rst        |    6 +-
>  Documentation/doc-guide/sphinx.rst            |    2 +-
>  Documentation/kbuild/kbuild.rst               |    2 +-
>  Documentation/process/coding-style.rst        |    2 +-
>  Documentation/sphinx/kernel_abi.py            |    2 +-
>  Documentation/sphinx/kernel_feat.py           |    4 +-
>  .../it_IT/doc-guide/kernel-doc.rst            |    8 +-
>  .../sp_SP/process/coding-style.rst            |    2 +-
>  .../zh_CN/doc-guide/checktransupdate.rst      |    6 +-
>  .../zh_CN/doc-guide/contributing.rst          |    2 +-
>  .../zh_CN/doc-guide/kernel-doc.rst            |   10 +-
>  Documentation/translations/zh_CN/how-to.rst   |    2 +-
>  .../translations/zh_CN/kbuild/kbuild.rst      |    2 +-
>  .../zh_CN/process/coding-style.rst            |    2 +-
>  .../zh_TW/process/coding-style.rst            |    2 +-
>  MAINTAINERS                                   |    5 -
>  Makefile                                      |    2 +-
>  drivers/gpu/drm/i915/Makefile                 |    2 +-
>  scripts/kernel-doc                            |    1 -
>  scripts/kernel-doc.pl                         | 2439 -----------------
>  {scripts => tools/docs}/checktransupdate.py   |    8 +-
>  .../docs}/documentation-file-ref-check        |    2 +-
>  .../docs}/features-refresh.sh                 |    0
>  {scripts => tools/docs}/find-unused-docs.sh   |    8 +-
>  {scripts => tools/docs}/get_abi.py            |    0
>  {scripts => tools/docs}/get_feat.pl           |    2 +-
>  .../kernel-doc.py => tools/docs/kernel-doc    |    0
>  .../features => tools/docs}/list-arch.sh      |    2 +-
>  tools/docs/sphinx-pre-install                 |    2 +-
>  {scripts => tools/docs}/test_doc_build.py     |    0
>  35 files changed, 50 insertions(+), 2495 deletions(-)
>  delete mode 120000 scripts/kernel-doc
>  delete mode 100755 scripts/kernel-doc.pl
>  rename {scripts => tools/docs}/checktransupdate.py (97%)
>  rename {scripts => tools/docs}/documentation-file-ref-check (99%)
>  rename {Documentation/features/scripts => tools/docs}/features-refresh.sh (100%)
>  rename {scripts => tools/docs}/find-unused-docs.sh (79%)
>  rename {scripts => tools/docs}/get_abi.py (100%)
>  rename {scripts => tools/docs}/get_feat.pl (99%)
>  rename scripts/kernel-doc.py => tools/docs/kernel-doc (100%)
>  rename {Documentation/features => tools/docs}/list-arch.sh (83%)
>  rename {scripts => tools/docs}/test_doc_build.py (100%)
> 

