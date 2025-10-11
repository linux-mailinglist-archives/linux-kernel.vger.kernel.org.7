Return-Path: <linux-kernel+bounces-849314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC93BCFCDB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE64032FB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 21:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CA27B33F;
	Sat, 11 Oct 2025 21:14:44 +0000 (UTC)
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7EC18A6D4
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.191.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760217283; cv=none; b=T68KF9otXE44wNMYdcVe6Bu+/h3RvKgFmOTkj18C4iPm9k/Up/fS+1Oly3vOdvdhXxCwkfkY8G/dCB39Vk0fqxXOmkuoxVRoO7YA9YyVPr/aGT6aOLIVOrKmZXfvw7NnCHZw888iV5BwwWp1qz5FyhwKBtM4wSfTzCeOCfAjcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760217283; c=relaxed/simple;
	bh=sp0iQMh0FhJe6TxnGJpczgl9o+894oGpx19NY8DQyow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+7D8jhaKM2k4P9nxKjGrCEb76PeGxaHTu3ALSd10PooWOcQzToTsFh0rAqEAxnFkMBRW1XjfczVumF8p8ZJ5/9W7EoWDAaGeYSZqnHFmpUKlCn9BMpPqa+tM60aLQHPE9+3QkN5h8b3Ej4jesDZLDie7F/eH9/NoxYfxGY1Ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name; spf=pass smtp.mailfrom=kevinlocke.name; arc=none smtp.client-ip=107.191.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinlocke.name
Received: from kevinolos.kevinlocke.name (unknown [IPv6:2607:24c0:2300:9fc5:5f91:14c7:425:9c44])
	(Authenticated sender: kevin@kevinlocke.name)
	by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 3A82D455D761;
	Sat, 11 Oct 2025 21:04:45 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
	id DE61A130031C; Sat, 11 Oct 2025 15:04:43 -0600 (MDT)
From: Kevin Locke <kevin@kevinlocke.name>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tools: fix == bashism in kernel-chktaint
Date: Sat, 11 Oct 2025 15:04:26 -0600
Message-ID: <1531d0cd452f1870e1703c263b11d718c46b54bb.1760216665.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When /bin/sh is a shell other than bash, invoking kernel-chktaint with
at least one argument may produce error messages such as the following
(produced by [dash] with argument 1024):

    ./kernel-chktaint: 22: [: 1024x: unexpected operator
    ./kernel-chktaint: 22: [: 1024x: unexpected operator

This occurs because the == operator is not specified for [test in POSIX]
and is not supported by all shells, as noted by shellcheck [SC3014].

To fix the issue and avoid the error message, replace == with =.

[dash]: https://git.kernel.org/pub/scm/utils/dash/dash.git
[test in POSIX]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html
[SC3014]: https://www.shellcheck.net/wiki/SC3014

Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---
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


