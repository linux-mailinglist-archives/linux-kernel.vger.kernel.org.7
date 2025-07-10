Return-Path: <linux-kernel+bounces-726632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45EBB00FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B3E4834B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D6286416;
	Thu, 10 Jul 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PgKoilmP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488118CC13;
	Thu, 10 Jul 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190314; cv=none; b=uyVXL3eXo3aAmheEs5ZdwpSvz7QEOi1GeWAonU4EiopeCv2iN5bgtg9OFUMyU4LVg7TadGwvYNYzvJGfA2AtM5/VgRIV7uGa2rcFLJ6Yz2PnJr2F0H1Sc8sATtZnoQk6wVrx8nJhYcg7bpBGEMk/LICsVlFlCRHtSSLLqnuYCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190314; c=relaxed/simple;
	bh=e+9oE4tFEgJqyssITU7SmT1Wj4bt1/qv8hhUI1OKfkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWNAnq3H2A0gSE7h0Rc65KSimGH/Rl9dinnI+QEqBpj/G9TuDq+xeh5wgKFI4rkaotj3QYMA1ytDeqKNZT0lpZ7CIMy3sA8tbtB0BxijITJwN5O/I/PLWZdcRNsUMB8RK5Ds/ZYHpmJFw4E6SRLrHHiOnGmGjnegs+OCU9iuugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PgKoilmP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 65C1E406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190312; bh=FFnQcTfH9qdg+H+dQEtKQknPmhcY6JqQEwXr/M0Zlmg=;
	h=From:To:Cc:Subject:Date:From;
	b=PgKoilmPvLekFt0IkWowASjwF4zUeCwr2gKcbWiUzWV2QD/dNgN19HH+LaUjQMPR+
	 jerx0RREBOEuhbYCwcfBhG/ST/ud69unwUEAmNbWMKF9DyoOw+o+Wm4nCPiSmCLtB7
	 AfC5gjv3et7y8Hmb6+l9tpp3yQPgCh8I06asFGIlZMrYiyLEmbmahlgl1hj2mEhdlj
	 S/f2u6V3bvU5QMm6r+oR7Dj5sDOXX0Mk/UYSYOUafVwXPE6+51KIJgc/fdm9caw4qr
	 gvXPKyUTB6zTg5en2pUUNAEC/1Vsp1Ni8BguoqutfmmgRgkm0Bpl/O5XIfHRVg3Iil
	 gT6XlZXmMJVNA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 65C1E406FA;
	Thu, 10 Jul 2025 23:31:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 00/12] Thrash up the parser/output interface
Date: Thu, 10 Jul 2025 17:31:30 -0600
Message-ID: <20250710233142.246524-1-corbet@lwn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kerneldoc parsing phase gathers all of the information about the
declarations of interest, then passes it through to the output phase as a
dict that is an unstructured blob of information; this organization has its
origins in the Perl version of the program.  It results in an interface
that is difficult to reason about, dozen-parameter function calls, and
other ills.

Introduce a new class (KdocItem) to carry this information between the
parser and the output modules, and, step by step, modify the system to use
this class in a more structured way.  This could be taken further by
creating a subclass of KdocItem for each declaration type (function,
struct, ...), but that is probably more structure than we need.

The result is (I hope) clearer code, the removal of a bunch of boilerplate,
and no changes to the generated output.

Changes since v1:
- Coding-style tweaks requested by Mauro
- Drop the reworking of output-text accumulation for now
- Add a warning for prehistoric Python versions

Jonathan Corbet (12):
  docs: kdoc; Add a rudimentary class to represent output items
  docs: kdoc: simplify the output-item passing
  docs: kdoc: drop "sectionlist"
  docs: kdoc: Centralize handling of the item section list
  docs: kdoc: remove the "struct_actual" machinery
  docs: kdoc: use self.entry.parameterlist directly in check_sections()
  docs: kdoc: Coalesce parameter-list handling
  docs: kdoc: Regularize the use of the declaration name
  docs: kdoc: straighten up dump_declaration()
  docs: kdoc: directly access the always-there KdocItem fields
  docs: kdoc: clean up check_sections()
  docs: kdoc: emit a warning for ancient versions of Python

 scripts/lib/kdoc/kdoc_files.py  |   4 +-
 scripts/lib/kdoc/kdoc_item.py   |  41 ++++++++
 scripts/lib/kdoc/kdoc_output.py | 172 ++++++++++++--------------------
 scripts/lib/kdoc/kdoc_parser.py | 171 +++++++------------------------
 4 files changed, 144 insertions(+), 244 deletions(-)
 create mode 100644 scripts/lib/kdoc/kdoc_item.py

-- 
2.49.0


