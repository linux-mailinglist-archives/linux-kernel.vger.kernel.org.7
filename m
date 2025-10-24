Return-Path: <linux-kernel+bounces-869480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3921C07FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505143BBCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FD22E2F13;
	Fri, 24 Oct 2025 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="O2aGKPL5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1D2E1F0E;
	Fri, 24 Oct 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336532; cv=none; b=ckj0JLEsHijJRrLTW9zr42NAxkC2v6yskNTAViGoc56lGkw4Q8yLS+lopXMqBj7mQbPIsRS+w1nMy81VInl7sPhHG7jRx5/WplKE94w+j1+Y4OE1MOm7Pzc4bE1sXVQ9cw6iTREbzDc8Ri6T5knbDiiQOMJptzNdGgyMCXobSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336532; c=relaxed/simple;
	bh=Uq1E/YDIotsd7E/m6onK0Ac9WboBT/qXCo/XhRTpoEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXKapLZsmZzt9e1LVH0c0xCcE4LwjxzeRO0xeGR4CTZs19A7QwRq0S44qyta11QqJ5blX/QDQKOeHW+4wJNolCs13WpRelhEJKBwbnQzW++uS3CHVPn2IM0vTyEEq2O+/hcyRRq9MtPjggDVBNxfrLoziebS8ljlwLpcv1SGA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=O2aGKPL5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5BA2540AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761336523; bh=dI8S0kC4HGNOoAJoqqvVEx6xf1jpureXIelcQ/0mudw=;
	h=From:To:Cc:Subject:Date:From;
	b=O2aGKPL5X81oGkmYbkyfFbskUnBXlmrtElCAFtpcJ0KisOaZB/NXWdALhY6yM0UF3
	 18w9LqwYkfVS9sOxpCoTAwO1D4MJmlxNQFMZGwKTRLMTvW0e4HnynQ8P/SYZYBPpaO
	 sMQGCXmVxF3aVbR9qp5TYi7IzT0E2yYFbPhSUDHXbze5j0bTzspt6jrI2ASzWDHo6n
	 Z0hQsQLaPgKT3Q502XQMpeC1OLLzyBm6SW1BAgDw0l2DSgWR8IPcearQEVOvDetgd/
	 v8MSCf81K0CSa8qrZWjUOZPXt+hzTzjKv+upxg0ZA9MXoJw812AtHoIez4iKGna0/c
	 AkiK7MafDHmGA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 5BA2540AED;
	Fri, 24 Oct 2025 20:08:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 0/8] Collect documentation-related tools under /tools/docs
Date: Fri, 24 Oct 2025 14:08:21 -0600
Message-ID: <20251024200834.20644-1-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our documentation-related tools are spread out over various directories;
several are buried in the scripts/ dumping ground.  That makes them harder
to discover and harder to maintain.

Recent work has started accumulating our documentation-related tools in
/tools/docs.  This series completes that task, moving the rest of our
various utilities there, hopefully fixing up all of the relevant references
in the process.

At the end, rather than move the old, Perl kernel-doc, I simply removed it.

The big elephant lurking in this small room is the home for Python modules;
I left them under scripts/lib, but that is an even less appropriate place
than it was before.  I would propose either tools/python or lib/python;
thoughts on that matter welcome.

Changes in v3:
  - Now with more caffeine! Properly based on docs-next.

Changes in v2:
  - Rebase on top of all of Mauro's changes (the most painful rebase I've
    ever done, I think).
  - Land everything in /tools/docs/ rather than /tools/doc/

v2: https://lore.kernel.org/lkml/20251023161027.697135-1-corbet@lwn.net/
v1: https://lore.kernel.org/lkml/20250813213218.198582-1-corbet@lwn.net/


Jonathan Corbet (8):
  docs: Move the "features" tools to tools/docs
  docs: move checktransupdate.py to tools/docs
  docs: move scripts/documentation-file-ref-check to tools/docs
  docs: move get_abi.py to tools/docs
  docs: move test_doc_build.py to tools/docs
  docs: move kernel-doc to tools/docs
  docs: move find-unused-docs.sh to tools/docs
  docs: remove kernel-doc.pl

 Documentation/Kconfig                         |    2 +-
 Documentation/Makefile                        |    6 +-
 Documentation/conf.py                         |    2 +-
 Documentation/doc-guide/checktransupdate.rst  |    6 +-
 Documentation/doc-guide/contributing.rst      |    2 +-
 Documentation/doc-guide/kernel-doc.rst        |    6 +-
 Documentation/doc-guide/sphinx.rst            |    2 +-
 Documentation/kbuild/kbuild.rst               |    2 +-
 Documentation/process/coding-style.rst        |    2 +-
 Documentation/sphinx/kernel_abi.py            |    2 +-
 Documentation/sphinx/kernel_feat.py           |    4 +-
 .../it_IT/doc-guide/kernel-doc.rst            |    8 +-
 .../sp_SP/process/coding-style.rst            |    2 +-
 .../zh_CN/doc-guide/checktransupdate.rst      |    6 +-
 .../zh_CN/doc-guide/contributing.rst          |    2 +-
 .../zh_CN/doc-guide/kernel-doc.rst            |   10 +-
 Documentation/translations/zh_CN/how-to.rst   |    2 +-
 .../translations/zh_CN/kbuild/kbuild.rst      |    2 +-
 .../zh_CN/process/coding-style.rst            |    2 +-
 .../zh_TW/process/coding-style.rst            |    2 +-
 MAINTAINERS                                   |    5 -
 Makefile                                      |    2 +-
 drivers/gpu/drm/i915/Makefile                 |    2 +-
 scripts/kernel-doc                            |    1 -
 scripts/kernel-doc.pl                         | 2439 -----------------
 {scripts => tools/docs}/checktransupdate.py   |    8 +-
 .../docs}/documentation-file-ref-check        |    2 +-
 .../docs}/features-refresh.sh                 |    0
 {scripts => tools/docs}/find-unused-docs.sh   |    8 +-
 {scripts => tools/docs}/get_abi.py            |    0
 {scripts => tools/docs}/get_feat.pl           |    2 +-
 .../kernel-doc.py => tools/docs/kernel-doc    |    0
 .../features => tools/docs}/list-arch.sh      |    2 +-
 tools/docs/sphinx-pre-install                 |    2 +-
 {scripts => tools/docs}/test_doc_build.py     |    0
 35 files changed, 50 insertions(+), 2495 deletions(-)
 delete mode 120000 scripts/kernel-doc
 delete mode 100755 scripts/kernel-doc.pl
 rename {scripts => tools/docs}/checktransupdate.py (97%)
 rename {scripts => tools/docs}/documentation-file-ref-check (99%)
 rename {Documentation/features/scripts => tools/docs}/features-refresh.sh (100%)
 rename {scripts => tools/docs}/find-unused-docs.sh (79%)
 rename {scripts => tools/docs}/get_abi.py (100%)
 rename {scripts => tools/docs}/get_feat.pl (99%)
 rename scripts/kernel-doc.py => tools/docs/kernel-doc (100%)
 rename {Documentation/features => tools/docs}/list-arch.sh (83%)
 rename {scripts => tools/docs}/test_doc_build.py (100%)

-- 
2.51.0


