Return-Path: <linux-kernel+bounces-794804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B8B3E789
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775F317E9B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FD34320A;
	Mon,  1 Sep 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUpJVLWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819E17AE1D;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737757; cv=none; b=XFcTfy2qsDNRpv/XJg/bkJ+C7fH2W7En9+BIKPh5lnP/ETykHGJIM2ygtev5+nzQOXYvlgny1Hv/Z0iTcIuQq9rFn/f5so73nhptShMphHu9SZ9Q4+XRtkYf4mzErDEzX6qpxRdZeAh5g0Wm//GkcvEY+w+oU8JVetC/wQHPwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737757; c=relaxed/simple;
	bh=Bk0CYZe89uBjJFk60uGMA8W8QHBnNhTf8pNxav8MNh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPnRYaU3f3/Rs11FVwR0Ngts78eo+qeDn/g8g0XK2vzFMpf91NkgBSMMfrjs909gokSfLpPXMW+UaKdyQm0Eetj0pVo+GXMNxcGfOifFhD/puFnn/o0otCKTkwYx0ZZGXP1AR/3deCfWIAANT3nkEn1Cy23CsDYQBjgyvAfU00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUpJVLWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ED8C4CEFF;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=Bk0CYZe89uBjJFk60uGMA8W8QHBnNhTf8pNxav8MNh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUpJVLWTlixSOvfqv/gUFuaT0rDXX6vFTaRBD8awg7mHW06RNZlUDjI3Y5uKTlBWG
	 sydCZ6a+Bu25nq5okcqWwba4+8gZx1LhB1QARnenCapySwK1OgfjTyurUYJV7b3doB
	 a7QKYuc7f4zdBiucGXbDH32KLue//isG/f/tBgRM3rIlxdyausXb9wD/LcOOO+uRHK
	 ESa9bDlK6NK+oQ7CD2XhUKs4XYezbfhbAPhjWgm2kxX5WQ2Gsv0/UxM7YKwGnjKv7j
	 LF+FqmQaJp2k1IV28feRmnQoyex7TuDg4oOt8a4BT7oMsMAdqGmqzEAuNBU/gqFCrG
	 sofs1VJeGjYeQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G3g-2yei;
	Mon, 01 Sep 2025 16:42:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] docs: parallel-wrapper.sh: remove script
Date: Mon,  1 Sep 2025 16:42:25 +0200
Message-ID: <1b52b64a969091d7fadc1580eddeeb2a5b111a43.1756737440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756737440.git.mchehab+huawei@kernel.org>
References: <cover.1756737440.git.mchehab+huawei@kernel.org>
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

