Return-Path: <linux-kernel+bounces-767514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A57EB25587
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CAF3AFDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB762FF149;
	Wed, 13 Aug 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AK4M5pne"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975322C0F6C;
	Wed, 13 Aug 2025 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120755; cv=none; b=uNejAoM75GKaBS49Rq9T6iqpkdAh3esCBszojR0RQU/jJHdM3x5n1woXwbRrwPgeo27qoDk0lbntRyTNZjbCSr7T1caebT5oFaS470KD5ZEsMZxwyRxUArDMnOdCBhpTZmr/QzCoBSHl5NTdMnk1grCreLXWUsad+bVfdxg6fbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120755; c=relaxed/simple;
	bh=aH/XhcoxK5+xsYwCIg0HXR7FYUacfE5oSjAX8/zKZdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0E7MeB1/Y+CHfpOrygX638yqqw6bY2wTULr5rGc8KWq8DN4bRiTbjUHkaqnFHWXUMAGqtisTYz/ahdOnetWspgYBCt2VXcAZL6uchxdI+nfqcVALlOIQ5003lM4mpezQ90eFNeJlsrfVhVIvlnNDfNhvWNbODYsLi9MOV0AUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AK4M5pne; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4F9B940AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120747; bh=KBY6lEuTrDQ1werGJLYGj3gDC7V/DWoVgSoxV56zSaM=;
	h=From:To:Cc:Subject:Date:From;
	b=AK4M5pneMcSeauzUTh0z7uIKVKwdWJszAtvcZ/UY0Enas4nG8iGieRP39nW0eeX/N
	 sp7qcsCBOJiy5t06asdHeuAkfgqqDTLfBi8xLzIo806lrkI08veCcaar/ChcOWvdAs
	 KxFhpZ2Elv4bmTSVLAR7wxJ3j9McE6Nl9m0nAS8Qb8ZJzIXv0ImHd32m4PonkHpAx1
	 kyHMhgQRjdkKapAQfKant06fUrzFUqICkTQSU6L8gqYgNxn9aBnwgsnsMvNJ4Iq0wC
	 TbhtrVhagvChQcmE3IC9zTikGzl6Lj9ctNvoP2uIfywoxFLTmRayiwz3DtUlYR6gvT
	 Dl6jS5Y8Glnjg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 4F9B940AB4;
	Wed, 13 Aug 2025 21:32:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RFC 00/13] Collect documention-related tools under tools/doc
Date: Wed, 13 Aug 2025 15:31:59 -0600
Message-ID: <20250813213218.198582-1-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
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
new directory, tools/doc, and moves various utilities there, hopefully
fixing up all of the relevant references in the process.

At the end, rather than move the old, Perl kernel-doc, I simply removed it.

The big elephant lurking in this small room is the home for Python modules;
I left them under scripts/lib, but that is an even less appropriate place
than it was before.  I would propose either tools/python or lib/python;
thoughts on that matter welcome.


Jonathan Corbet (13):
  docs: Move the "features" tools to tools/doc
  docs: move checktransupdate.py to tools/doc
  docs: move scripts/check-variable-fonts.sh to tools/doc
  docs: move scripts/documentation-file-ref-check to tools/doc
  docs: move parallel-wrapper.sh to tools/doc/
  docs: move get_abi.py to tools/doc
  docs: move sphinx-pre-install to tools/doc
  docs: move test_doc_build.py to tools/doc
  docs: move parse-headers.pl to tools/doc
  docs: move kernel-doc to tools/doc
  docs: move split-man.pl to tools/doc
  docs: move find-unused-docs.sh to tools/doc
  docs: remove kernel-doc.pl

 Documentation/Kconfig                         |    2 +-
 Documentation/Makefile                        |   24 +-
 Documentation/conf.py                         |    2 +-
 Documentation/doc-guide/checktransupdate.rst  |    6 +-
 Documentation/doc-guide/contributing.rst      |    2 +-
 Documentation/doc-guide/kernel-doc.rst        |   18 +-
 Documentation/doc-guide/parse-headers.rst     |    6 +-
 Documentation/doc-guide/sphinx.rst            |    6 +-
 Documentation/kbuild/kbuild.rst               |    2 +-
 Documentation/process/coding-style.rst        |    2 +-
 Documentation/sphinx/kernel_abi.py            |    2 +-
 Documentation/sphinx/kernel_feat.py           |    4 +-
 Documentation/sphinx/kerneldoc-preamble.sty   |    2 +-
 .../it_IT/doc-guide/kernel-doc.rst            |    8 +-
 .../it_IT/doc-guide/parse-headers.rst         |    6 +-
 .../translations/it_IT/doc-guide/sphinx.rst   |    4 +-
 .../sp_SP/process/coding-style.rst            |    2 +-
 .../zh_CN/doc-guide/checktransupdate.rst      |    6 +-
 .../zh_CN/doc-guide/contributing.rst          |    2 +-
 .../zh_CN/doc-guide/kernel-doc.rst            |   16 +-
 .../zh_CN/doc-guide/parse-headers.rst         |    6 +-
 .../translations/zh_CN/doc-guide/sphinx.rst   |    4 +-
 Documentation/translations/zh_CN/how-to.rst   |    4 +-
 .../translations/zh_CN/kbuild/kbuild.rst      |    2 +-
 .../zh_CN/process/coding-style.rst            |    2 +-
 .../zh_TW/process/coding-style.rst            |    2 +-
 Documentation/userspace-api/media/Makefile    |    2 +-
 MAINTAINERS                                   |   11 +-
 Makefile                                      |    2 +-
 drivers/gpu/drm/i915/Makefile                 |    2 +-
 scripts/kernel-doc                            |    1 -
 scripts/kernel-doc.pl                         | 2439 -----------------
 .../doc}/check-variable-fonts.sh              |    2 +-
 {scripts => tools/doc}/checktransupdate.py    |    8 +-
 .../doc}/documentation-file-ref-check         |    2 +-
 .../scripts => tools/doc}/features-refresh.sh |    0
 {scripts => tools/doc}/find-unused-docs.sh    |    8 +-
 {scripts => tools/doc}/get_abi.py             |    0
 {scripts => tools/doc}/get_feat.pl            |    2 +-
 scripts/kernel-doc.py => tools/doc/kernel-doc |    0
 .../features => tools/doc}/list-arch.sh       |    2 +-
 .../sphinx => tools/doc}/parallel-wrapper.sh  |    0
 .../sphinx => tools/doc}/parse-headers.pl     |    4 +-
 {scripts => tools/doc}/sphinx-pre-install     |    2 +-
 {scripts => tools/doc}/split-man.pl           |    0
 {scripts => tools/doc}/test_doc_build.py      |    0
 46 files changed, 91 insertions(+), 2538 deletions(-)
 delete mode 120000 scripts/kernel-doc
 delete mode 100755 scripts/kernel-doc.pl
 rename {scripts => tools/doc}/check-variable-fonts.sh (98%)
 rename {scripts => tools/doc}/checktransupdate.py (98%)
 rename {scripts => tools/doc}/documentation-file-ref-check (99%)
 rename {Documentation/features/scripts => tools/doc}/features-refresh.sh (100%)
 rename {scripts => tools/doc}/find-unused-docs.sh (79%)
 rename {scripts => tools/doc}/get_abi.py (100%)
 rename {scripts => tools/doc}/get_feat.pl (99%)
 rename scripts/kernel-doc.py => tools/doc/kernel-doc (100%)
 rename {Documentation/features => tools/doc}/list-arch.sh (83%)
 rename {Documentation/sphinx => tools/doc}/parallel-wrapper.sh (100%)
 rename {Documentation/sphinx => tools/doc}/parse-headers.pl (98%)
 rename {scripts => tools/doc}/sphinx-pre-install (99%)
 rename {scripts => tools/doc}/split-man.pl (100%)
 rename {scripts => tools/doc}/test_doc_build.py (100%)

-- 
2.50.1


