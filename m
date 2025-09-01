Return-Path: <linux-kernel+bounces-794954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8EEB3EB3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5F61B26242
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2FF32A826;
	Mon,  1 Sep 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDQgZOuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7F2DF13A;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740838; cv=none; b=BDzRRTabzlg4A66/onumSd90CHaUo/psbmWt/5lPOvQMXwIMg/VqiQ52dXbAp8PkgMvOSvF2/LCA8O2PIqtzFC3hw5YyeLIHeHgzsbfRtGeF/ecZNGglMANNiXZAGb7KLQIhvDJ43I1Nmw6qiIIchT0073yaLjg0s1IMUU5KCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740838; c=relaxed/simple;
	bh=Bk0CYZe89uBjJFk60uGMA8W8QHBnNhTf8pNxav8MNh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfhIk845ys8so2eKhS4WqVRDxtl1qcEzh1x0SHHlDKiU2SrZQB/3+SVxdhE2yldYUv2XfebrdL2Iy0RfhmuejGuieaax5kAMJpnjdw7gtx/g0soZ5O+I39wNHD0Jrqb8ZMqu9PR4TpmVxGsdtYfrYgn6FTjQjf53C9IVhRdFfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDQgZOuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCFFC116B1;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=Bk0CYZe89uBjJFk60uGMA8W8QHBnNhTf8pNxav8MNh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDQgZOuN1SsMeomP6+W9qvmlbj0vrm82NAG/eXdQ8FJZt8ECDo046+9xTQGmZyl7L
	 lmgCYjTZfHsj16vLDI+a69zxi52PDF5nbsPDr0zmUA5h0n8aJDlbGS9+KKgUmIAHjl
	 gQjCclO6N0PnerfZUR6Xw8s17Yd7RqvGpjew9vixcU7hMb9PELoal7PDqXRnNkOeM+
	 PqC2F6c8WT+mhh/7ATRqE0Ez6jCjeeWdmTYqfjckIW4id0F6g3+2g0QNxUGti9Cjk4
	 PTsjHedyH4r/lhf4LxxVNh12ZgNxQD7tqyPfh0VwUKhDRFbZZ62GQEqaUuEWrlGPLu
	 vAQdEOnLg8TEw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HMA-39FP;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 09/15] docs: parallel-wrapper.sh: remove script
Date: Mon,  1 Sep 2025 17:33:44 +0200
Message-ID: <1b52b64a969091d7fadc1580eddeeb2a5b111a43.1756740314.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The only usage of this script was docs Makefile. Now that=0D
it is using the new sphinx-build-wrapper, which has inside=0D
the code from parallel-wrapper.sh, we can drop this script.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 Documentation/sphinx/parallel-wrapper.sh | 33 ------------------------=0D
 1 file changed, 33 deletions(-)=0D
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh=0D
=0D
diff --git a/Documentation/sphinx/parallel-wrapper.sh b/Documentation/sphin=
x/parallel-wrapper.sh=0D
deleted file mode 100644=0D
index e54c44ce117d..000000000000=0D
--- a/Documentation/sphinx/parallel-wrapper.sh=0D
+++ /dev/null=0D
@@ -1,33 +0,0 @@=0D
-#!/bin/sh=0D
-# SPDX-License-Identifier: GPL-2.0+=0D
-#=0D
-# Figure out if we should follow a specific parallelism from the make=0D
-# environment (as exported by scripts/jobserver-exec), or fall back to=0D
-# the "auto" parallelism when "-jN" is not specified at the top-level=0D
-# "make" invocation.=0D
-=0D
-sphinx=3D"$1"=0D
-shift || true=0D
-=0D
-parallel=3D"$PARALLELISM"=0D
-if [ -z "$parallel" ] ; then=0D
-	# If no parallelism is specified at the top-level make, then=0D
-	# fall back to the expected "-jauto" mode that the "htmldocs"=0D
-	# target has had.=0D
-	auto=3D$(perl -e 'open IN,"'"$sphinx"' --version 2>&1 |";=0D
-			while (<IN>) {=0D
-				if (m/([\d\.]+)/) {=0D
-					print "auto" if ($1 >=3D "1.7")=0D
-				}=0D
-			}=0D
-			close IN')=0D
-	if [ -n "$auto" ] ; then=0D
-		parallel=3D"$auto"=0D
-	fi=0D
-fi=0D
-# Only if some parallelism has been determined do we add the -jN option.=0D
-if [ -n "$parallel" ] ; then=0D
-	parallel=3D"-j$parallel"=0D
-fi=0D
-=0D
-exec "$sphinx" $parallel "$@"=0D
-- =0D
2.51.0=0D
=0D

