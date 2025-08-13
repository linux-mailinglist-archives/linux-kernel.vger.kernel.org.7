Return-Path: <linux-kernel+bounces-767536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF29B255B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931D93B0F36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085313009DA;
	Wed, 13 Aug 2025 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="slRKuGc+"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522B3009CF;
	Wed, 13 Aug 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121124; cv=none; b=oCAYX0eQVX3Lkv3GrWaEC/e/6Bhq0wgqSTeIrtvKJnGsBJn8VInoHKVi6Zw2AZ8SP7UVyWTjuPWfxf9oAtNCJ2wcwQdki+5p9322x6cUjJwdywvF9jbavbueDj2/jaJfFGNkDnit8iCmKqLyEbfnm3v1yXKM/hTje5N/eMy3BJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121124; c=relaxed/simple;
	bh=yxW3W9IvKecYEZUhbSo4eofslmYWk13CHPGYlgXXf1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IafGKLkVBMdJY+H5Sf12/Jpp5eXk21khlUGcxrk4BpaB1g7mQaRuaATWrbvLpn/I8FdhUqitP+/EivBGk5aWJxU4zL1JRU/To8FSiaa7vqny2Yc+pgYeeM4bz3V7roKLeiz0ULy+Ne+Gcib58h27BmHfKN9+xJ1BtSRfGXq79Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=slRKuGc+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E232E40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755121122; bh=bibpI1D0gWSehw0HlCLpe2YD6WongsUxbLNx5E0jdng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=slRKuGc+yVtu/YQ72r7aVCRUe+7MzQY3P8BueY1zQc779tnmNfNQ6f2hbOtPQaszN
	 /w22qQkbzY/B4t1VHgkCjMbMFhsTa4cw1Rh7YJZEjgMDKX0IZR60iqzEuU/99q9ycg
	 Q+S+HBX1tW7FyEkp6aLgyWd8cpjBJX9DCAY5cs5kxdlDCtCrUVkXrpmXKMcY/f4C7l
	 Br/4/5PO3D3c/brMJE7ifronXufkC030zZ4GvLwXEoOI5aACwIC0wHlKmp5/JU3rfR
	 5ni7g7MBH/IaS59nbXv3YilbgxyG+RZIrphmAWU22C/NGBEE7mo2bQr7zbhpGJG3GF
	 cXz0lGhWuOHgg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E232E40AB4;
	Wed, 13 Aug 2025 21:38:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH RFC 00/13] Collect documention-related tools under
 tools/doc
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
Date: Wed, 13 Aug 2025 15:38:41 -0600
Message-ID: <87y0rmaom6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[Adding some CCs - sorry, folks, I messed that part up somehow...]

Jonathan Corbet <corbet@lwn.net> writes:

> Our documentation-related tools are spread out over various directories;
> several are buried in the scripts/ dumping ground.  That makes them harder
> to discover and harder to maintain.
>
> Recently, the idea of creating a dedicated directory for documentation tools
> came up; I decided to see what it would look like.  This series creates a
> new directory, tools/doc, and moves various utilities there, hopefully
> fixing up all of the relevant references in the process.
>
> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
>
> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.  I would propose either tools/python or lib/python;
> thoughts on that matter welcome.
>
>
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
>  rename {scripts => tools/doc}/sphinx-pre-install (99%)
>  rename {scripts => tools/doc}/split-man.pl (100%)
>  rename {scripts => tools/doc}/test_doc_build.py (100%)
>
> -- 
> 2.50.1

