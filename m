Return-Path: <linux-kernel+bounces-867343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C3C02543
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1CA1895412
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800428507E;
	Thu, 23 Oct 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RFNeNZM3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EC1F5827;
	Thu, 23 Oct 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235851; cv=none; b=MIzdV7tBgNHEVlocMdfxYsNSNssylK1zgl/f4pvaYB/5Enmhiyeeowcv6B/CBs+9eOMk4ZYAUzozgOmzWMaNXF7ghtaQdJrngI3HBeMTebAFSXidGkCUnwbUSgF2zrsX2oLqodKsAFnjldcKV0rK15OqmuDgsV4NfLYkPXdGAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235851; c=relaxed/simple;
	bh=46k+a9Ya8EgQTaPyaeGRfgSMsUtCAwkK6KKA2c3ABTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4sJf+cs6lyqQw+pUAO1SGiJblDHea8oaR1syycTthK5/LIJ0refNU2txcUGzg6gy4wxTQ2I+xwb2gc+h5XbfO5dLtHc/g5jm4ugG1P8kOepG1dHyIZpNCN+lIlbfN5w4UCWyLzeeVbDEbsOlhixKRqPOZI1jXWyVbAztoxXuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RFNeNZM3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 16EC840B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235843; bh=w825mHvLqruVst1CB5Lj+3JFW5SQbhsFelKXGVnuD2E=;
	h=From:To:Cc:Subject:Date:From;
	b=RFNeNZM3VkxnfePNsi6+cYg25Iy4h79HLaWxUbMqAHp54DhSFK+B2T+jhpNdL97qf
	 gjCvt7FkgPjCxphHUOIaPFudI/eVMLRDnEqYKpP/Bbg9L5dNIJRxG1yaFsLakuv7bf
	 4v6kr6/Ku1aQTAritNIDhEtlpNpJWy6cRsMrEAwHnbwu8E7c0Bf/wI4o7qjD2kyFgP
	 wMe56h2uL1yUqzp9O3akGLG1jN9+duGscAG9RkOryshGE2vQ75APYggy0CUGe0myqk
	 lpPtWMbM0kM8v2Dj0ocHAEY6FkJI2V8cXc17RbyNPYfof5YrxNAO5SSKf+wQvwO16x
	 7gVL+fmDuzbYA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 16EC840B1B;
	Thu, 23 Oct 2025 16:10:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 00/10] Collect documentation-related tools under /tools/docs
Date: Thu, 23 Oct 2025 10:10:08 -0600
Message-ID: <20251023161027.697135-1-corbet@lwn.net>
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

Recently, the idea of creating a dedicated directory for documentation tools
came up; I decided to see what it would look like.  This series creates a
new directory, tools/docs, and moves various utilities there, hopefully
fixing up all of the relevant references in the process.

At the end, rather than move the old, Perl kernel-doc, I simply removed it.

The big elephant lurking in this small room is the home for Python modules;
I left them under scripts/lib, but that is an even less appropriate place
than it was before.  I would propose either tools/python or lib/python;
thoughts on that matter welcome.

Changes in v2:
  - Rebase on top of all of Mauro's changes (the most painful rebase I've
    ever done, I think).
  - Land everything in /tools/docs/ rather than /tools/doc/

v1: https://lore.kernel.org/lkml/20250813213218.198582-1-corbet@lwn.net/

Jonathan Corbet (10):
  docs: Move the "features" tools to tools/docs
  docs: move checktransupdate.py to tools/docs
  docs: move scripts/check-variable-fonts.sh to tools/docs
  docs: move scripts/documentation-file-ref-check to tools/docs
  docs: move get_abi.py to tools/docs
  docs: move test_doc_build.py to tools/docs
  docs: move kernel-doc to tools/docs
  docs: move split-man.pl to tools/docs
  docs: move find-unused-docs.sh to tools/docs
  docs: remove kernel-doc.pl

 Documentation/Kconfig                         |    2 +-
 Documentation/Makefile                        |    8 +-
 Documentation/conf.py                         |    2 +-
 Documentation/doc-guide/checktransupdate.rst  |    6 +-
 Documentation/doc-guide/contributing.rst      |    2 +-
 Documentation/doc-guide/kernel-doc.rst        |   18 +-
 Documentation/doc-guide/sphinx.rst            |    2 +-
 Documentation/kbuild/kbuild.rst               |    2 +-
 Documentation/process/coding-style.rst        |    2 +-
 Documentation/sphinx/kernel_abi.py            |    2 +-
 Documentation/sphinx/kernel_feat.py           |    4 +-
 .../it_IT/doc-guide/kernel-doc.rst            |    8 +-
 .../sp_SP/process/coding-style.rst            |    2 +-
 .../zh_CN/doc-guide/checktransupdate.rst      |    6 +-
 .../zh_CN/doc-guide/contributing.rst          |    2 +-
 .../zh_CN/doc-guide/kernel-doc.rst            |   16 +-
 Documentation/translations/zh_CN/how-to.rst   |    2 +-
 .../translations/zh_CN/kbuild/kbuild.rst      |    2 +-
 .../zh_CN/process/coding-style.rst            |    2 +-
 .../zh_TW/process/coding-style.rst            |    2 +-
 MAINTAINERS                                   |    8 +-
 Makefile                                      |    2 +-
 drivers/gpu/drm/i915/Makefile                 |    2 +-
 scripts/kernel-doc                            |    1 -
 scripts/kernel-doc.pl                         | 2439 -----------------
 scripts/sphinx-pre-install                    |    2 +-
 .../docs}/check-variable-fonts.sh             |    2 +-
 {scripts => tools/docs}/checktransupdate.py   |    8 +-
 .../docs}/documentation-file-ref-check        |    2 +-
 .../docs}/features-refresh.sh                 |    0
 {scripts => tools/docs}/find-unused-docs.sh   |    8 +-
 {scripts => tools/docs}/get_abi.py            |    0
 {scripts => tools/docs}/get_feat.pl           |    2 +-
 .../kernel-doc.py => tools/docs/kernel-doc    |    0
 .../features => tools/docs}/list-arch.sh      |    2 +-
 {scripts => tools/docs}/split-man.pl          |    0
 {scripts => tools/docs}/test_doc_build.py     |    0
 37 files changed, 63 insertions(+), 2507 deletions(-)
 delete mode 120000 scripts/kernel-doc
 delete mode 100755 scripts/kernel-doc.pl
 rename {scripts => tools/docs}/check-variable-fonts.sh (98%)
 rename {scripts => tools/docs}/checktransupdate.py (97%)
 rename {scripts => tools/docs}/documentation-file-ref-check (99%)
 rename {Documentation/features/scripts => tools/docs}/features-refresh.sh (100%)
 rename {scripts => tools/docs}/find-unused-docs.sh (79%)
 rename {scripts => tools/docs}/get_abi.py (100%)
 rename {scripts => tools/docs}/get_feat.pl (99%)
 rename scripts/kernel-doc.py => tools/docs/kernel-doc (100%)
 rename {Documentation/features => tools/docs}/list-arch.sh (83%)
 rename {scripts => tools/docs}/split-man.pl (100%)
 rename {scripts => tools/docs}/test_doc_build.py (100%)

-- 
2.51.0


