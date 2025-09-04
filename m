Return-Path: <linux-kernel+bounces-800157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB313B43435
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C4D1883521
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE862C0266;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ3ae1hB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23902BE03B;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=AVbSXrwbaSz4LxffwXNiGSUkSVQ1pNhULm772iU3+VHNgmhgZ7Mw82Rgkwb26099iLfycb8jaf8AcuaY8CCZ9ilCyanx7zHVP5jVKl5o/BEgAo/D3iZ5q9hee26W61xRy0nmRnEMbpMt13+nlkrnEiiApU84BV7p/IAFP1t+8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=ZLbhSMLrYrG412X2oMrDythT1CiWtmLDdQQNSbEgmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hWBtBs6jjaxMvfVmmNoZM2sMexCTpESotzeIjSbEqemZfisKmACy/MC6lPMMSbwRK3IsrKB5hkeXQFi2VYqM9gxnsADTgQleli9I5V67giDCyK2MbtXqJ0gR3RyBfuL+85i7dA/YdDHPppJ65bZtY+5vU1j8XDK/6iBCjPtJHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ3ae1hB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07FFC4CEFE;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=ZLbhSMLrYrG412X2oMrDythT1CiWtmLDdQQNSbEgmmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJ3ae1hBCzr9H6EM6d5j3Pa+M9XZcoFHapiHSRm2OGbUUTm8lrWNpZVlaComxf03e
	 2eJwL286weD4fMgVCBLau4guEVjfoS6Jd6Xm24KSOs2e4VrP7mzmv/F2cakfWCWcBn
	 udVcPA8jIbIb9bLpM9gVCEAotdnvrN7k7HXCFK8kNlQnJQno02zJG6/j4C4IkOx6Gj
	 G0oRGmaIFu2SzsURPMy0158El7f7DqvSgg0aPmjw3RBfIVv2m9AIo7IchytY1+evvI
	 FAClPJcO0odOY/ovyYdy5lNPARO9JZJnJjiL70+xqSPJj2J8CLA+w6nGTt+F2bQXCI
	 z1IrXBAJl/nag==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jPr-40xC;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/19] docs: parallel-wrapper.sh: remove script
Date: Thu,  4 Sep 2025 09:33:11 +0200
Message-ID: <36db8fe6394b8339c2a45a1e698fc224fe35c9f4.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
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


