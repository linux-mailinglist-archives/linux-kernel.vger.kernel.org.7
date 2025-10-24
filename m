Return-Path: <linux-kernel+bounces-869002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B3C06B12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17B33B5426
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B22153C1;
	Fri, 24 Oct 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rko+w4s6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D961A9FAC;
	Fri, 24 Oct 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315879; cv=none; b=P800W6NLr50PNNSXbH8YLbvnjpWwMVMDD+rk0BAWn5MeIXsyV0DhSSbG8b/9b0TD6uv0uoxf7J4p6FMHFzmsYqqWLtERzs0tMQmXMi6ptVGqdzvh9ezFWpZeTCIArle8Rmd8GWtnF2EpZcCW5rZuAsYngAVKFV7Cj7UTVUTGKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315879; c=relaxed/simple;
	bh=eAHw5OUZPHJyXkIei0o2MaB9jn5jCq9NHCTpyU4jQ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh0jgDo8t9jVYt5Zc/5gsu18yGneR6mssHWEiWN7ujrN5QLyqtMSOgdHLnxOAjb9RUw9ECart8uLdKv5/WXebakIWwyobJ2LvGY3qZ5IKCc0gGuFw5zbPo/9n1FLB9JgBe6FqiV9W1FwkO8QYjbUEv4mma00ZnHoT6Vilk1ov/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rko+w4s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11847C4CEFF;
	Fri, 24 Oct 2025 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761315879;
	bh=eAHw5OUZPHJyXkIei0o2MaB9jn5jCq9NHCTpyU4jQ8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rko+w4s6eu54dHaksuSRcL+BvGJ3mxvBrlQRZWLFK8D5G8MWbvxMIDWXFdt8lY6+R
	 R0nb18VSxIanHX44H7usKi1WgKK+GQcnzzQHrxR9Gw5fc6XDhxmzf6DwEqQhWcrYrz
	 Z196B87ekd8s7Z8BiXWxN7eAeYtzkzHGjy89NMVzbES9JEZmpd0mkBJQJ3rSNJ3XnU
	 T4bLC4Yck+eoZH31fiuNUrECrXpewLA+plN3n9YQ1xKeLnECYZ8/yCbCuCkujBjvas
	 Fgn3eDMMOo3o16bSAcM8MchI54mFyBRH5sJSSKLe4Do9nOh7jcVIeYvN7PcudcajCy
	 unZaYQ/Mgclig==
Date: Fri, 24 Oct 2025 11:24:28 -0300
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Jani Nikula
 <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Collect documentation-related tools under
 /tools/docs
Message-ID: <20251024112428.44965f06@sal.lan>
In-Reply-To: <20251023161027.697135-1-corbet@lwn.net>
References: <20251023161027.697135-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 23 Oct 2025 10:10:08 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Our documentation-related tools are spread out over various directories;
> several are buried in the scripts/ dumping ground.  That makes them harder
> to discover and harder to maintain.
> 
> Recently, the idea of creating a dedicated directory for documentation tools
> came up; I decided to see what it would look like.  This series creates a
> new directory, tools/docs, and moves various utilities there, hopefully
> fixing up all of the relevant references in the process.
> 
> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
> 
> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.  I would propose either tools/python or lib/python;
> thoughts on that matter welcome.

Hmm... What about tools/docs/python?

> 
> Changes in v2:
>   - Rebase on top of all of Mauro's changes (the most painful rebase I've
>     ever done, I think).

Sorry for that! Yeah, renaming patches are very hard to rebase. It is
usually better to have a renaming script and re-run it if changes get
merged.

>   - Land everything in /tools/docs/ rather than /tools/doc/
> 
> v1: https://lore.kernel.org/lkml/20250813213218.198582-1-corbet@lwn.net/
> 
> Jonathan Corbet (10):
>   docs: Move the "features" tools to tools/docs
>   docs: move checktransupdate.py to tools/docs
>   docs: move scripts/check-variable-fonts.sh to tools/docs
>   docs: move scripts/documentation-file-ref-check to tools/docs
>   docs: move get_abi.py to tools/docs
>   docs: move test_doc_build.py to tools/docs
>   docs: move kernel-doc to tools/docs
>   docs: move split-man.pl to tools/docs
>   docs: move find-unused-docs.sh to tools/docs
>   docs: remove kernel-doc.pl
> 
>  Documentation/Kconfig                         |    2 +-
>  Documentation/Makefile                        |    8 +-
>  Documentation/conf.py                         |    2 +-
>  Documentation/doc-guide/checktransupdate.rst  |    6 +-
>  Documentation/doc-guide/contributing.rst      |    2 +-
>  Documentation/doc-guide/kernel-doc.rst        |   18 +-
>  Documentation/doc-guide/sphinx.rst            |    2 +-
>  Documentation/kbuild/kbuild.rst               |    2 +-
>  Documentation/process/coding-style.rst        |    2 +-
>  Documentation/sphinx/kernel_abi.py            |    2 +-
>  Documentation/sphinx/kernel_feat.py           |    4 +-
>  .../it_IT/doc-guide/kernel-doc.rst            |    8 +-
>  .../sp_SP/process/coding-style.rst            |    2 +-
>  .../zh_CN/doc-guide/checktransupdate.rst      |    6 +-
>  .../zh_CN/doc-guide/contributing.rst          |    2 +-
>  .../zh_CN/doc-guide/kernel-doc.rst            |   16 +-
>  Documentation/translations/zh_CN/how-to.rst   |    2 +-
>  .../translations/zh_CN/kbuild/kbuild.rst      |    2 +-
>  .../zh_CN/process/coding-style.rst            |    2 +-
>  .../zh_TW/process/coding-style.rst            |    2 +-
>  MAINTAINERS                                   |    8 +-
>  Makefile                                      |    2 +-
>  drivers/gpu/drm/i915/Makefile                 |    2 +-
>  scripts/kernel-doc                            |    1 -
>  scripts/kernel-doc.pl                         | 2439 -----------------
>  scripts/sphinx-pre-install                    |    2 +-
>  .../docs}/check-variable-fonts.sh             |    2 +-
>  {scripts => tools/docs}/checktransupdate.py   |    8 +-
>  .../docs}/documentation-file-ref-check        |    2 +-
>  .../docs}/features-refresh.sh                 |    0
>  {scripts => tools/docs}/find-unused-docs.sh   |    8 +-
>  {scripts => tools/docs}/get_abi.py            |    0
>  {scripts => tools/docs}/get_feat.pl           |    2 +-
>  .../kernel-doc.py => tools/docs/kernel-doc    |    0
>  .../features => tools/docs}/list-arch.sh      |    2 +-
>  {scripts => tools/docs}/split-man.pl          |    0
>  {scripts => tools/docs}/test_doc_build.py     |    0
>  37 files changed, 63 insertions(+), 2507 deletions(-)
>  delete mode 120000 scripts/kernel-doc
>  delete mode 100755 scripts/kernel-doc.pl
>  rename {scripts => tools/docs}/check-variable-fonts.sh (98%)
>  rename {scripts => tools/docs}/checktransupdate.py (97%)
>  rename {scripts => tools/docs}/documentation-file-ref-check (99%)
>  rename {Documentation/features/scripts => tools/docs}/features-refresh.sh (100%)
>  rename {scripts => tools/docs}/find-unused-docs.sh (79%)
>  rename {scripts => tools/docs}/get_abi.py (100%)
>  rename {scripts => tools/docs}/get_feat.pl (99%)
>  rename scripts/kernel-doc.py => tools/docs/kernel-doc (100%)
>  rename {Documentation/features => tools/docs}/list-arch.sh (83%)
>  rename {scripts => tools/docs}/split-man.pl (100%)
>  rename {scripts => tools/docs}/test_doc_build.py (100%)

At the description you mentioned libs, but I'm not seeing anything
at the above diffstat showing such renames.
> 

Regards,
Mauro

