Return-Path: <linux-kernel+bounces-874806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DAC1723A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7328C4E56B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF8B355802;
	Tue, 28 Oct 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZrcjpYbc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8701D27B6;
	Tue, 28 Oct 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689426; cv=none; b=uc1md/skSlrvuG7p3ka8Kkr8YI6StAbst03CpRMuFAVYJv1zuUtMBUgVmPyBuNm/7jxMFO29y1hhqZ4dnV5lMwhyCqOj3da+Ffugn8ti5rU79roiDMMgI5ebQCO7qSZFveG/zmO+hBS8Csg5qfIOBi0dtnGI2kwryDEukz2k+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689426; c=relaxed/simple;
	bh=ZLwp9qIjcnp78J9fRFwIlVctWu/FfLSTpJQPReDtOa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdNVdJzXnjUvOk/fN9HyT6ie2ywROVhmV64Xr6aUV7nxoWUrNZ7s98VnNKE6FmUXZQwkvhOBkn63C/MgpDxbYCyiAQSNBl4LPMvDKEPwPY6+efrA1mLiMKGS1lG41kigPQ51G7kTaa1tWiYepfmermuepNfRpAfGS2svbxco3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZrcjpYbc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0649D406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761689424; bh=GRyVqOAd1J4TiuELHiNqKcYNcbyLQ7FcpXGKr0vuqZw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZrcjpYbcSkJAdByOeeV3NQA46XDyF+0dW8dH+Hc4HbN2kZKOEIEQ0a/cBsPiqsRGO
	 cI8TjEgrSlqGOGeakzBm+Iu83yvXkM/qtAJTiVmUSgKOnHQqTaOz1J7vqNhAnw3ZKy
	 eGX6Ta5s4m2u61nfoK/W5omkGOqatWuhCy9MRFiBsaMcX7chV0xZ5TDYTQoMYJPCxP
	 RMhnUsHfhABPQdaJK0r0NKULisYkoDiIv2vjOoAVjMOVugavUF3Ef6M8dVBtQkEG0l
	 78IPUGU2WTBCdGCSVwUjpcdhiX4mM9c0WgqXQ7wMVym2rLAs72KV0EgEmAw5W1sKsf
	 O+wGLhMPbMZ1g==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 0649D406FB;
	Tue, 28 Oct 2025 22:10:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 0/7] Collect (most) documentation-related tools under /tools/docs
Date: Tue, 28 Oct 2025 16:10:08 -0600
Message-ID: <20251028221017.5785-1-corbet@lwn.net>
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
/tools/docs.  This series nearly completes that task, moving most of the
rest of our various utilities there, hopefully fixing up all of the
relevant references in the process.

The one exception is scripts/kernel-doc; that move turned up some other
problems, so I have dropped it until those are ironed out.

At the end, rather than move the old, Perl kernel-doc, I simply removed it.

The big elephant lurking in this small room is the home for Python modules;
I left them under scripts/lib, but that is an even less appropriate place
than it was before.  I would propose either tools/python or lib/python;
thoughts on that matter welcome.

Changes in v4:
  - Leave scripts/kernel-doc in place for now.

Changes in v3:
  - Now with more caffeine! Properly based on docs-next.

Changes in v2:
  - Rebase on top of all of Mauro's changes (the most painful rebase I've
    ever done, I think).
  - Land everything in /tools/docs/ rather than /tools/doc/

v2: https://lore.kernel.org/lkml/20251023161027.697135-1-corbet@lwn.net/
v1: https://lore.kernel.org/lkml/20250813213218.198582-1-corbet@lwn.net/


Jonathan Corbet (7):
  docs: Move the "features" tools to tools/docs
  docs: move checktransupdate.py to tools/docs
  docs: move scripts/documentation-file-ref-check to tools/docs
  docs: move get_abi.py to tools/docs
  docs: move test_doc_build.py to tools/docs
  docs: move find-unused-docs.sh to tools/docs
  docs: remove kernel-doc.pl

 Documentation/Kconfig                         |    2 +-
 Documentation/Makefile                        |    6 +-
 Documentation/doc-guide/checktransupdate.rst  |    6 +-
 Documentation/doc-guide/contributing.rst      |    2 +-
 Documentation/doc-guide/sphinx.rst            |    2 +-
 Documentation/sphinx/kernel_abi.py            |    2 +-
 Documentation/sphinx/kernel_feat.py           |    4 +-
 .../zh_CN/doc-guide/checktransupdate.rst      |    6 +-
 .../zh_CN/doc-guide/contributing.rst          |    2 +-
 Documentation/translations/zh_CN/how-to.rst   |    2 +-
 MAINTAINERS                                   |    4 -
 scripts/kernel-doc.pl                         | 2439 -----------------
 {scripts => tools/docs}/checktransupdate.py   |    8 +-
 .../docs}/documentation-file-ref-check        |    2 +-
 .../docs}/features-refresh.sh                 |    0
 {scripts => tools/docs}/find-unused-docs.sh   |    6 +-
 {scripts => tools/docs}/get_abi.py            |    0
 {scripts => tools/docs}/get_feat.pl           |    2 +-
 .../features => tools/docs}/list-arch.sh      |    2 +-
 tools/docs/sphinx-pre-install                 |    2 +-
 {scripts => tools/docs}/test_doc_build.py     |    0
 21 files changed, 28 insertions(+), 2471 deletions(-)
 delete mode 100755 scripts/kernel-doc.pl
 rename {scripts => tools/docs}/checktransupdate.py (97%)
 rename {scripts => tools/docs}/documentation-file-ref-check (99%)
 rename {Documentation/features/scripts => tools/docs}/features-refresh.sh (100%)
 rename {scripts => tools/docs}/find-unused-docs.sh (85%)
 rename {scripts => tools/docs}/get_abi.py (100%)
 rename {scripts => tools/docs}/get_feat.pl (99%)
 rename {Documentation/features => tools/docs}/list-arch.sh (83%)
 rename {scripts => tools/docs}/test_doc_build.py (100%)

-- 
2.51.0


