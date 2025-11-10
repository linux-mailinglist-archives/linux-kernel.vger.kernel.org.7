Return-Path: <linux-kernel+bounces-894207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C4C4979C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C732D4E1A47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1E2F6582;
	Mon, 10 Nov 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pIXInYQt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC62727EB;
	Mon, 10 Nov 2025 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812287; cv=none; b=UcR4gZx/HfkbAzDRKkCf2OLwEJBbcK6f0Hl6JmNEHDS7deZ6iM/jCluROkC2vwEkuIEzHZOqdHT0o2VC4pFAsGcNWGGxMPOvre27gD0RPKhike9s+bkxJ5sIJTqI/HkP2ZwOeHpSS9qTgmks1DFhEJ3He3cxJab6VoPagDzniJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812287; c=relaxed/simple;
	bh=ysLJ+cVVbgXgaAATs0FNh9aBq2y/183NqfKLzkhWmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4vNZoQCjLWOpDDRR2GVwLMZZuhUGZZw/v1HsIngUOM0+nfGndmVu88gqmNMBrHcvucxeuEtULIjvh8QBbNnwMGupYj522BJtCUbcpO3wgqgO7vSHEQKDO4VN5gsCITNIyPo+CNe1+STm1Ev0BA2TOgPJHww18tCkoz9czH2bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pIXInYQt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B77340B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762812284; bh=hJaCH/+T+7zqCr4cqeP8WR2d3qYzMPvYxUh93a8pSUY=;
	h=From:To:Cc:Subject:Date:From;
	b=pIXInYQt2yxRdOwBL7um/ryuL/KfgH+SPhnq87/xZBZt4hE0USXaKq2Dyh6NJ26kW
	 df6ZXUMr1ZFIFcPuKd496HUPYkZHkZ1Ohc7gwhqOwYOxfLNfZhwNJ48lw2sWV8dBxV
	 kX+vbeAop2cNxgfKB3tIlxtz8oT6+ViPe+lzkyuKE5qwqF9Mo4yzfxl47D07Gcn6td
	 OVmiZuof7M5dWxrAmvOeRocQ0DOWXNV3DTU3H6jidiFTpuw9IMX7yNsDP5A8FMOIff
	 xV/pwxmEo4wNUh90IdE/ToObYu9YiVwzgsYe3c47u2u88cbkEr2DLGvMNug5CUuHH5
	 5VxOPbbjNX0pg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 7B77340B69;
	Mon, 10 Nov 2025 22:04:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] Move Python modules to tools/lib/python
Date: Mon, 10 Nov 2025 15:04:28 -0700
Message-ID: <20251110220430.726665-1-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/lib was always a bit of an awkward place for Python libraries; give
them a proper home under tools/lib/python.  Put the modules from
tools/docs/lib there for good measure.

The second patch ties them into a single package namespace.  It would be
more aesthetically pleasing to add a kernel layer, so we could say:

  from kernel.kdoc import kdoc_parser

...and have the kernel-specific stuff clearly marked, but that means adding
an empty directory in the hierarchy, which isn't as pleasing.

There are some other "Python library" directories hidden in the kernel
tree; we may eventually want to encourage them to move as well.

Jonathan Corbet (2):
  docs: Move the python libraries to tools/lib/python
  docs: bring some order to our Python module hierarchy

 .pylintrc                                              |  2 +-
 Documentation/Makefile                                 |  2 +-
 Documentation/sphinx/kernel_abi.py                     |  4 ++--
 Documentation/sphinx/kernel_include.py                 |  4 ++--
 Documentation/sphinx/kerneldoc.py                      |  6 +++---
 MAINTAINERS                                            |  3 +--
 scripts/jobserver-exec                                 |  2 +-
 scripts/kernel-doc.py                                  |  6 +++---
 tools/docs/check-variable-fonts.py                     |  8 ++++++--
 tools/docs/get_abi.py                                  | 10 +++++-----
 tools/docs/parse-headers.py                            |  9 ++++++---
 tools/docs/sphinx-build-wrapper                        |  6 +++---
 tools/docs/sphinx-pre-install                          |  5 ++++-
 tools/{docs/lib => lib/python}/__init__.py             |  0
 tools/lib/python/abi/__init__.py                       |  0
 {scripts/lib => tools/lib/python}/abi/abi_parser.py    |  2 +-
 {scripts/lib => tools/lib/python}/abi/abi_regex.py     |  4 ++--
 {scripts/lib => tools/lib/python}/abi/helpers.py       |  0
 .../lib => tools/lib/python}/abi/system_symbols.py     |  2 +-
 {scripts/lib => tools/lib/python}/jobserver.py         |  0
 tools/lib/python/kdoc/__init__.py                      |  0
 .../{docs/lib => lib/python/kdoc}/enrich_formatter.py  |  0
 {scripts/lib => tools/lib/python}/kdoc/kdoc_files.py   |  4 ++--
 {scripts/lib => tools/lib/python}/kdoc/kdoc_item.py    |  0
 {scripts/lib => tools/lib/python}/kdoc/kdoc_output.py  |  4 ++--
 {scripts/lib => tools/lib/python}/kdoc/kdoc_parser.py  |  4 ++--
 {scripts/lib => tools/lib/python}/kdoc/kdoc_re.py      |  0
 tools/{docs/lib => lib/python/kdoc}/latex_fonts.py     |  0
 .../lib => lib/python/kdoc}/parse_data_structs.py      |  0
 tools/{docs/lib => lib/python/kdoc}/python_version.py  |  0
 30 files changed, 48 insertions(+), 39 deletions(-)
 rename tools/{docs/lib => lib/python}/__init__.py (100%)
 create mode 100644 tools/lib/python/abi/__init__.py
 rename {scripts/lib => tools/lib/python}/abi/abi_parser.py (99%)
 rename {scripts/lib => tools/lib/python}/abi/abi_regex.py (99%)
 rename {scripts/lib => tools/lib/python}/abi/helpers.py (100%)
 rename {scripts/lib => tools/lib/python}/abi/system_symbols.py (99%)
 rename {scripts/lib => tools/lib/python}/jobserver.py (100%)
 create mode 100644 tools/lib/python/kdoc/__init__.py
 rename tools/{docs/lib => lib/python/kdoc}/enrich_formatter.py (100%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_files.py (99%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_item.py (100%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_output.py (99%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_parser.py (99%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_re.py (100%)
 rename tools/{docs/lib => lib/python/kdoc}/latex_fonts.py (100%)
 rename tools/{docs/lib => lib/python/kdoc}/parse_data_structs.py (100%)
 rename tools/{docs/lib => lib/python/kdoc}/python_version.py (100%)

-- 
2.51.0


