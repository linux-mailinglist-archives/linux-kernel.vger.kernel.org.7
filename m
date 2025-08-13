Return-Path: <linux-kernel+bounces-767674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C785B2578E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB895A85DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0C302779;
	Wed, 13 Aug 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXYNJsPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6E2FC890;
	Wed, 13 Aug 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127784; cv=none; b=kNUr52qIGEURi0pTPtF+uNFCembLr88e0E+wZSs18D8fNe154O6AEVnyK2PkcKERJJjnNIuDYugNoUMytR3OlViXXYmpHSz1c2uxOAbo9XC/y/Pi9CqP+05s3+uLQwklNkJaS8VtSnb+OCyzIme6sVq2/JCDmvT+35uCzttJbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127784; c=relaxed/simple;
	bh=ziSfoknMH5h3TXjzmmojwrcw+kVqkFWXQYJtaH4hbks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQmGk8B4rapcjkbqbU89/i8IwXTSkTjfmRSCCrFGYZaCti64EBRWgr/C8xRtX6bGdHA9AH13y9uRLXmi+pFohpxFuz0IY/9OoqQvEsCggeRicbdxNafxHljbVVzzz0++VlAPCuJ2Vc49ZklcXLBufvjwaja+d+mEA3DT0rfvuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXYNJsPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF1BC4CEFB;
	Wed, 13 Aug 2025 23:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755127784;
	bh=ziSfoknMH5h3TXjzmmojwrcw+kVqkFWXQYJtaH4hbks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXYNJsPB7lNyiTOr7FckiRFkvE5R+6dFhuZItSaog0p3/lTPt+7ixc/3S5GIl0xk4
	 H4RrTP0Lck6DfdhNIG+HALY2aUIBjBe2OYdZj5O2mv0iztif4e/uueQa0LpwIVXUDE
	 45YfOL6tAvB4yA6vmNPYTVniobqUGTpnsgqmdMajQg57kwslB/5vJ4pGB02vel2VJg
	 k7lyaRIXB/IkO1RF0Etc86CEMgCG7OPfGsUD6/N+GQflXpieftij0Qtn/Ue5AamPJY
	 fVMcjWlCOD+HiWi3BWAdJc9voRJyZZKp9ZcmxeJKrnJVMZ1QICv4T0eTTOKQoYWJuz
	 6DzGmPkU/Ar9g==
Date: Thu, 14 Aug 2025 01:29:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RFC 00/13] Collect documention-related tools under
 tools/doc
Message-ID: <20250814012939.0850e5e6@foz.lan>
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:31:59 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Our documentation-related tools are spread out over various directories;
> several are buried in the scripts/ dumping ground.  That makes them harder
> to discover and harder to maintain.
> 
> Recently, the idea of creating a dedicated directory for documentation tools
> came up; I decided to see what it would look like.  This series creates a
> new directory, tools/doc, and moves various utilities there, hopefully
> fixing up all of the relevant references in the process.

I would prefer tools/docs ;-)

The rationale is that it is common to have patches for Documentation
described with "docs:" prefix. Anyway, I don't mind that much.

Btw, one of my pending patch series is creating a new *.py script over
tools/docs (moving a script from Documentation/sphinx) ;-) 

> 
> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
> 
> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.

Agreed.

> I would propose either tools/python or lib/python;
> thoughts on that matter welcome.

Wither way works for me.

> Jonathan Corbet (13):
>   docs: Move the "features" tools to tools/doc
>   docs: move checktransupdate.py to tools/doc
>   docs: move scripts/check-variable-fonts.sh to tools/doc
>   docs: move scripts/documentation-file-ref-check to tools/doc
>   docs: move parallel-wrapper.sh to tools/doc/
>   docs: move get_abi.py to tools/doc
>   docs: move sphinx-pre-install to tools/doc
>   docs: move test_doc_build.py to tools/doc
>   docs: move parse-headers.pl to tools/doc
>   docs: move kernel-doc to tools/doc
>   docs: move split-man.pl to tools/doc
>   docs: move find-unused-docs.sh to tools/doc
>   docs: remove kernel-doc.pl
> 
>  Documentation/Kconfig                         |    2 +-
>  Documentation/Makefile                        |   24 +-
>  Documentation/conf.py                         |    2 +-
>  Documentation/doc-guide/checktransupdate.rst  |    6 +-
>  Documentation/doc-guide/contributing.rst      |    2 +-
>  Documentation/doc-guide/kernel-doc.rst        |   18 +-
>  Documentation/doc-guide/parse-headers.rst     |    6 +-
>  Documentation/doc-guide/sphinx.rst            |    6 +-
>  Documentation/kbuild/kbuild.rst               |    2 +-
>  Documentation/process/coding-style.rst        |    2 +-
>  Documentation/sphinx/kernel_abi.py            |    2 +-
>  Documentation/sphinx/kernel_feat.py           |    4 +-
>  Documentation/sphinx/kerneldoc-preamble.sty   |    2 +-
>  .../it_IT/doc-guide/kernel-doc.rst            |    8 +-
>  .../it_IT/doc-guide/parse-headers.rst         |    6 +-
>  .../translations/it_IT/doc-guide/sphinx.rst   |    4 +-
>  .../sp_SP/process/coding-style.rst            |    2 +-
>  .../zh_CN/doc-guide/checktransupdate.rst      |    6 +-
>  .../zh_CN/doc-guide/contributing.rst          |    2 +-
>  .../zh_CN/doc-guide/kernel-doc.rst            |   16 +-
>  .../zh_CN/doc-guide/parse-headers.rst         |    6 +-
>  .../translations/zh_CN/doc-guide/sphinx.rst   |    4 +-
>  Documentation/translations/zh_CN/how-to.rst   |    4 +-
>  .../translations/zh_CN/kbuild/kbuild.rst      |    2 +-
>  .../zh_CN/process/coding-style.rst            |    2 +-
>  .../zh_TW/process/coding-style.rst            |    2 +-
>  Documentation/userspace-api/media/Makefile    |    2 +-
>  MAINTAINERS                                   |   11 +-
>  Makefile                                      |    2 +-
>  drivers/gpu/drm/i915/Makefile                 |    2 +-
>  scripts/kernel-doc                            |    1 -
>  scripts/kernel-doc.pl                         | 2439 -----------------
>  .../doc}/check-variable-fonts.sh              |    2 +-
>  {scripts => tools/doc}/checktransupdate.py    |    8 +-
>  .../doc}/documentation-file-ref-check         |    2 +-
>  .../scripts => tools/doc}/features-refresh.sh |    0
>  {scripts => tools/doc}/find-unused-docs.sh    |    8 +-
>  {scripts => tools/doc}/get_abi.py             |    0
>  {scripts => tools/doc}/get_feat.pl            |    2 +-
>  scripts/kernel-doc.py => tools/doc/kernel-doc |    0
>  .../features => tools/doc}/list-arch.sh       |    2 +-
>  .../sphinx => tools/doc}/parallel-wrapper.sh  |    0
>  .../sphinx => tools/doc}/parse-headers.pl     |    4 +-
>  {scripts => tools/doc}/sphinx-pre-install     |    2 +-
>  {scripts => tools/doc}/split-man.pl           |    0
>  {scripts => tools/doc}/test_doc_build.py      |    0
>  46 files changed, 91 insertions(+), 2538 deletions(-)
>  delete mode 120000 scripts/kernel-doc
>  delete mode 100755 scripts/kernel-doc.pl
>  rename {scripts => tools/doc}/check-variable-fonts.sh (98%)
>  rename {scripts => tools/doc}/checktransupdate.py (98%)
>  rename {scripts => tools/doc}/documentation-file-ref-check (99%)
>  rename {Documentation/features/scripts => tools/doc}/features-refresh.sh (100%)
>  rename {scripts => tools/doc}/find-unused-docs.sh (79%)
>  rename {scripts => tools/doc}/get_abi.py (100%)
>  rename {scripts => tools/doc}/get_feat.pl (99%)
>  rename scripts/kernel-doc.py => tools/doc/kernel-doc (100%)
>  rename {Documentation/features => tools/doc}/list-arch.sh (83%)

>  rename {Documentation/sphinx => tools/doc}/parallel-wrapper.sh (100%)
>  rename {Documentation/sphinx => tools/doc}/parse-headers.pl (98%)

I prefer if you don't touch those two. I'm already handling them.

Basically, parallel-wrapper.sh will be decommissioned; parse-readers.pl
will become parse-headers.py (on my series, at tools/docs, but if you
opt to tools/doc, I'll update it.

>  rename {scripts => tools/doc}/sphinx-pre-install (99%)
>  rename {scripts => tools/doc}/split-man.pl (100%)
>  rename {scripts => tools/doc}/test_doc_build.py (100%)

Thanks,
Mauro

