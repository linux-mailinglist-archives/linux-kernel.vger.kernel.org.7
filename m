Return-Path: <linux-kernel+bounces-850798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0EBD3E10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95B5C4F5850
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E93093AD;
	Mon, 13 Oct 2025 14:50:17 +0000 (UTC)
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3926F46F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.191.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367016; cv=none; b=nt1/zZTVavQRbwKkO8kRe2namtmMF5nYTHcwnRus4VSXPSJYWg9MN23bgbdK7t1hFn2BZMP9+TigCsKKUnJR+/GI+sS29dEVp+rVGW3mlkhpwLFUVNPxQKM1Uagyea79bi5HWNg3mhtgdVr4ACTd+TW1TYsuKCPrKttT+FEDsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367016; c=relaxed/simple;
	bh=sQeJ8bD4IfYyMZCLNov2zWJKPCILBytUcTXJfnzUbGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwRRVduB2akn62cVAjWLiG0pHBFRsp3g98iL3b4vRFIw1DYHMnfi0kzjp43ynSuKhh3u6icF51wpKn8oWjvcHrXCqffr8RicaykLphCGVdQQhMmCiz+J0xAD5fINi0QzQDrtqXujXVLVqq7aaG0h89YDPPyktA0XwAFioQ7CL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name; spf=pass smtp.mailfrom=kevinlocke.name; arc=none smtp.client-ip=107.191.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinlocke.name
Received: from kevinolos.kevinlocke.name (unknown [IPv6:2607:24c0:2300:9fc5:9d63:bab1:b47d:8e70])
	(Authenticated sender: kevin@kevinlocke.name)
	by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 1B999455E95B;
	Mon, 13 Oct 2025 14:50:07 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
	id 53AB913003B9; Mon, 13 Oct 2025 08:50:05 -0600 (MDT)
From: Kevin Locke <kevin@kevinlocke.name>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools: fix == bashism in kernel-chktaint
Date: Mon, 13 Oct 2025 08:41:51 -0600
Message-ID: <cfa643395a4ae569838b7992c3fe7a3c3797831d.1760366509.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <47d80432-3838-4fc7-898c-9a9154080113@leemhuis.info>
References: <47d80432-3838-4fc7-898c-9a9154080113@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When /bin/sh is a shell other than bash, invoking kernel-chktaint with
at least one argument may produce error messages such as the following
(produced by dash 0.5.12 with argument 1024):

    ./kernel-chktaint: 22: [: 1024x: unexpected operator
    ./kernel-chktaint: 22: [: 1024x: unexpected operator

This occurs because the == operator is not specified for test in POSIX
and is not supported by all shells, as noted by shellcheck SC3014.

To fix the issue and avoid the error message, replace == with =.

Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---

Thanks for the reviews and feedback Thorsten and Randy!  I agree it
probably doesn't matter, but I appreciate the value of consistency and
of being aware of those conventions, and it's an easy fix.  Thanks for
letting me know about it!  Here's an updated version with an improved
commit message.

Thanks again,
Kevin

Changes since v1:
 * Remove superfluous links in Markdown format from commit message.
 * Add version of dash used to commit message.

 tools/debugging/kernel-chktaint | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index e7da0909d0970..051608a63d9f1 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -19,7 +19,7 @@ EOF
 }
 
 if [ "$1"x != "x" ]; then
-	if  [ "$1"x == "--helpx" ] || [ "$1"x == "-hx" ] ; then
+	if  [ "$1"x = "--helpx" ] || [ "$1"x = "-hx" ] ; then
 		usage
 		exit 1
 	elif  [ $1 -ge 0 ] 2>/dev/null ; then
-- 
2.51.0


