Return-Path: <linux-kernel+bounces-785193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6E9B34769
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FFB16F456
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F069301494;
	Mon, 25 Aug 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8+g6R4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83C2F9C39;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139449; cv=none; b=NE4vrMjMxR/jKNKJw+0ipr5h5Q7nBDC8znFz8buxPq0LxC2T9VUI3JWKh4to1KGshudzNwmjT/0UCArh4LzN7BqztyyUXDkeQ26xviEKbqA6oy8qJXWxjQWd/UhourZNpWZKzA+03GhEE6IJcAc59oIHejvibsrw0SNzvwJFFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139449; c=relaxed/simple;
	bh=ZLbhSMLrYrG412X2oMrDythT1CiWtmLDdQQNSbEgmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGJPTimXZrTPGQfHumsKZfzofkHI7oirNEgcNHOxsF4zMWP7tryJvikpDK6yMWjP730HX6XsTEEaf9Jyf5ciSUYwYKesQ/vEFfmKBXLsX2EvkSJn7kVqnpJJ7Lboy4CxO8cWgO8tDpKm+SupQlt7jwTla2N6/5ZiBijB6pZqnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8+g6R4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE7CC113D0;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139449;
	bh=ZLbhSMLrYrG412X2oMrDythT1CiWtmLDdQQNSbEgmmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8+g6R4qWqiOPi1kXfYRrWQzD/YoUuizd9FmCqnkh+bO0ulgH9xvxOAFjrkYseXkK
	 QAwKBi3QKR3LRPmF/eLLObR0uF5MiH4YUUrkQQFWvugrPI+s0hKL7uqiG/GWR/ntuV
	 Be9rz0noLNgCN6k8S/EIpbG+V+XZ+q4wdDdShLz9GZSZ8dqO2B3TKoJy5SV+D89fH7
	 F7F/x1pFCqsJD4TvbmokJyCfCC9jVOGU/6OGmPp4xWqkaM70xSSFBsva7gM4CRu9u/
	 1QhyTFHRxSs2I8kmDYFsff3EiAMUdrx+S/5uK+WnK6WkBaCQxkPvuAdrxFtkv/YKnH
	 +KUMxdNhj4gnw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uqa5n-0000000HALo-1aWZ;
	Mon, 25 Aug 2025 18:30:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] docs: parallel-wrapper.sh: remove script
Date: Mon, 25 Aug 2025 18:30:36 +0200
Message-ID: <7a2d57ae8fddcfdf0498d5dcdab09741df26d222.1756138805.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756138805.git.mchehab+huawei@kernel.org>
References: <cover.1756138805.git.mchehab+huawei@kernel.org>
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


