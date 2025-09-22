Return-Path: <linux-kernel+bounces-827119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B723B905B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F036A189D5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F9E305E3B;
	Mon, 22 Sep 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfn9oJZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1EB305946;
	Mon, 22 Sep 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540496; cv=none; b=NslVBMG6jb1TVtWUNunuRoj9VH6PgEvVgyq3n9kd8Bu0sCvZ8c5INJPb26bS8bFGPmwMLZC8wCU3M+YAVAFvh9L855sMLSzbo9MhmCn9Nw43CEgABmG/2HVZieVt2zlYSapqqd8vIYR5yKG8OQL7NYHKfKGm6h+JtX75b+nh4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540496; c=relaxed/simple;
	bh=cx8TTwxmLFcAxdxM7m5mGXYnTtA3aP17ucoXL3wPr84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5lYSiX4MGUf388ERJTCHgys3dlLPMD4B5zmhO2BuMfnMVhtKwdCHMZkvUddMjU8ZfHEV2oPmydeFnAeF73lxsCaRlDyHVKivu5PIRCCxrucH5752fYf/Fm36z7DlCMfHO3ept1PAGiO1YdwKr61x/8vk0bKHsp7eKDNFkMNkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfn9oJZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D63C113D0;
	Mon, 22 Sep 2025 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758540495;
	bh=cx8TTwxmLFcAxdxM7m5mGXYnTtA3aP17ucoXL3wPr84=;
	h=From:To:Cc:Subject:Date:From;
	b=pfn9oJZx/CEKFF7cm1Y8Z5toRS0pAyG489zgxC5+J/KcL+8D56hQOsHDV6WS4g7ej
	 xqLiM+Mp48YHYWLpNFaizbDa//AT1KbXJmUoRkNWKEeTBmcPVZGJx5+VpFq1u5gJ1I
	 JXlRVTrQGPcW74U7bh6Eh0L9DNzy6A8YQIDGvlqv3Jpx8NhdRRqc0pPuuG3D/cfPUp
	 7YfaSJFW4i63R3gJzpl9Ss0jdnHKxkiuqswkDWRxzuplsaZ0hod6+fI35jf1GVLNKU
	 v5XGnHZ7mKgE++NFXDA+m+8mkU6dO4OVMiQWRPChzdLInzgMZP1rkGSffea1ysGOHM
	 UPzwXR4eT28Pw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0eiL-00000005vOm-3GBO;
	Mon, 22 Sep 2025 13:28:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 0/3] fixes/improvements for top of docs/build-script
Date: Mon, 22 Sep 2025 13:27:37 +0200
Message-ID: <cover.1758539031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This series contain the 3 patches against build-script I sent in
separate:

- patch 1 solves a problem with Tumbleweed build. I opted to be verbose 
  at the comments to properly describe what we're addressing and why;
- patch 2 solves an issue that sometimes happen on my machine while checking
  for CONFIG_RUST=y;
- patch 3 contains a request from Akira to allow running just the PDF
  step when pdfdocs target is selected.

on patch 3, I opted to not modify Makefile, as I don't see why most
people would want to proceed with PDF builds when latex build fails.
For those who want such feature, e. g. simulate "make -i pdfdocs" behavior,
all it is needed after the change is to run:

	tools/docs/sphinx-build-wrapper latexdocs || echo "LaTeX error: $?"
	tools/docs/sphinx-build-wrapper -s pdfdocs

eventually adding some extra flags to the second command from the command
line arguments below:

  --paper {,a4,letter}  Paper size for LaTeX/PDF output
  --deny-vf DENY_VF     Configuration to deny variable fonts on pdf builds
  -v, --verbose         place build in verbose mode
  -j, --jobs JOBS       Sets number of jobs to use with sphinx-build
  -i, --interactive     Change latex default to run in interactive mode
  -s, --skip-sphinx-build
                        Skip sphinx-build step

E.g. running the second step with, for instance, with:
	tools/docs/sphinx-build-wrapper -v -s -i --deny-vf ~/.my-deny pdfdocs

to:
- assume that sphinx-build --builder latex was already executed (-s);
- provide a summary of what PDF files were built at the end (-v);
- run LaTeX in interactive mode in case of errors (-i);
- use a custom deny-list for variable fonts (--deny-vf).

If we add this at docs Makefile, and allow all possible alternatives,
this would just add uneeded complexity there, IMO.

Mauro Carvalho Chehab (3):
  tools/docs: sphinx-build-wrapper: fix compat with recent Tumbleweed
  docs: Makefile: fix rustdoc detection
  tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step

 Documentation/Makefile          |  4 ++-
 tools/docs/sphinx-build-wrapper | 43 ++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.51.0



