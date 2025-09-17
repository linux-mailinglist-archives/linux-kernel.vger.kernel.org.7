Return-Path: <linux-kernel+bounces-820623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5009B7D063
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D578B581126
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390E31A7FA;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2OdkxGB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56130CB50;
	Wed, 17 Sep 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111355; cv=none; b=jZLcWDkZTwEmsrgH2XhuiU9tSVzAqMsCAICl6jZ5sBYDgIIbmlmzFgubGD9Zor9ysl2OS1nafb4pVrtpgS9/+yPqwu6TtdKd7K83aZQdg69zSEUDJ3a8ciy9VM49XOm9KQ9fd6PyJxRWAnMiLvr4sDv1zLMPNHpaVOWEUjZWeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111355; c=relaxed/simple;
	bh=ZLbhSMLrYrG412X2oMrDythT1CiWtmLDdQQNSbEgmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dax/ufaHo2pSWhz3RoPV6aOKXwLnXIlETFDVApiWLn3SGUnK+oMAx521quSNB9KbAn7tCeQ4LwOUFClSDYOLxyX0a7MTtC2PgBafopw0UTzDyp4VxRm06M5fBzpDg/CffIS6mWRBdQZPlIrdpl5RSzW+NmdOlfVe8Ldlisq3rqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2OdkxGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFFCC4CEF5;
	Wed, 17 Sep 2025 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111354;
	bh=ZLbhSMLrYrG412X2oMrDythT1CiWtmLDdQQNSbEgmmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2OdkxGBcl6PWAso9+K3wR9CNuvL87Bz1Tc20BhYfgk4l4ITFHH6u+9yeJ9dDIVgu
	 /bz8qmcuMJrFyvFyI3AaM4UHplw4+0E2Uqt9z099IPXlDJOMmO45B0zjkH4gU2KibR
	 d6tKSxA7TKnaPkJWTs4l2reJ22UHiDXp9U+SGP4ezwJbCyoJCeDkuUi/aUpMkCPU/i
	 C69zaQK8GVSyNXEHHhlPTR5V39fTr9zA/R4AiFQgGXxtKRldahlfZfvi8bCZptqbEv
	 Np8vEH/2NIuBioaZO8+/0eHCSAKA9vbvbKncfg3Q2vPVh6EIb4PYqyV3mL9mMPT04b
	 lHVTJ0eTs281g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGdw-1VMu;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/24] docs: parallel-wrapper.sh: remove script
Date: Wed, 17 Sep 2025 14:15:06 +0200
Message-ID: <1f9e6c7cfd74fcbaf788687d006d63d57ffdd049.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The only usage of this script was docs Makefile. Now that
it is using the new sphinx-build-wrapper, which has inside
the code from parallel-wrapper.sh, we can drop this script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parallel-wrapper.sh | 33 ------------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 Documentation/sphinx/parallel-wrapper.sh

diff --git a/Documentation/sphinx/parallel-wrapper.sh b/Documentation/sphinx/parallel-wrapper.sh
deleted file mode 100644
index e54c44ce117d..000000000000
--- a/Documentation/sphinx/parallel-wrapper.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Figure out if we should follow a specific parallelism from the make
-# environment (as exported by scripts/jobserver-exec), or fall back to
-# the "auto" parallelism when "-jN" is not specified at the top-level
-# "make" invocation.
-
-sphinx="$1"
-shift || true
-
-parallel="$PARALLELISM"
-if [ -z "$parallel" ] ; then
-	# If no parallelism is specified at the top-level make, then
-	# fall back to the expected "-jauto" mode that the "htmldocs"
-	# target has had.
-	auto=$(perl -e 'open IN,"'"$sphinx"' --version 2>&1 |";
-			while (<IN>) {
-				if (m/([\d\.]+)/) {
-					print "auto" if ($1 >= "1.7")
-				}
-			}
-			close IN')
-	if [ -n "$auto" ] ; then
-		parallel="$auto"
-	fi
-fi
-# Only if some parallelism has been determined do we add the -jN option.
-if [ -n "$parallel" ] ; then
-	parallel="-j$parallel"
-fi
-
-exec "$sphinx" $parallel "$@"
-- 
2.51.0


