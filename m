Return-Path: <linux-kernel+bounces-857065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A341BE5D18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 383214E7DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20992E62CF;
	Thu, 16 Oct 2025 23:52:59 +0000 (UTC)
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1D2D7DCA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.191.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658779; cv=none; b=blIlBLvR/4BnjK7CBfxJy2D9eSC7TpLYpsNm+zWRk0THRdE7cjt+Sfqq+tdDS/qwrcrvTcDzsdqBIAARyIY9UfSZF+Tck8lSOFkIElMrdkUN1NTEryhje/GK8GKzz9hO9Dx1gHqJ0lqLWPOMC9cLkPgIgnFGQxs79Onth9AtfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658779; c=relaxed/simple;
	bh=WwwkjaCFZBE85WW1CRKf3dBhMGARO4Hu5gTN65LRi/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahe9hUQGh9GLq1uWAuSE+NoMerW5upnkdiOEHUBxly2LFJ5ArNDBMh3HXnDtkgpQyryGaqAcReExyjBWlpB0GN/edDADRsrY0Gq+2XU9UflaXWoqjXu1qa/jd56MDtAkV5jUCYziSHpR9zHuhCYgg04Jzpe0JVNCvHYA5SvPW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name; spf=pass smtp.mailfrom=kevinlocke.name; arc=none smtp.client-ip=107.191.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinlocke.name
Received: from kevinolos.kevinlocke.name (unknown [198.60.113.91])
	(Authenticated sender: kevin@kevinlocke.name)
	by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 1F2DD45607A7;
	Thu, 16 Oct 2025 23:52:50 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
	id 1D1D513004F6; Thu, 16 Oct 2025 17:52:48 -0600 (MDT)
From: Kevin Locke <kevin@kevinlocke.name>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tools: remove unnecessary x suffix in test strings
Date: Thu, 16 Oct 2025 17:47:09 -0600
Message-ID: <a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016214707.5c3d373b@pumpkin>
References: <20251016214707.5c3d373b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An "x" suffix was appended to test variable expansions, presumably to
avoid issues with empty strings in some old shells, or perhaps with the
intention of avoiding issues with dashes or other special characters
that an "x" prefix might have avoided.  In either case, POSIX ensures
that such protections are not necessary, and are unlikely to be
encountered in shells currently in use, as indicated by shellcheck
SC2268.

Remove the "x" suffixes which unnecessarily complicate the code.

Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
Suggested-by: David Laight <david.laight.linux@gmail.com>
---

Thanks David, that's a good point about the x suffixes.  Since
shellcheck warns about the x prefixes (SC2268) and I'm not aware of any
shells currently in use which require them, I think they are safe to
remove to clean up the code a bit.  Here's a patch to do just that,
which can be applied on top of my previous patch.

Since -o is an XSI extension to POSIX, I've stuck with ||, but I think
you are right that x would not be required in that case either.

Thanks again,
Kevin


 tools/debugging/kernel-chktaint | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 051608a63d9f..051ac27b58eb 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -18,8 +18,8 @@ retrieved from /proc/sys/kernel/tainted on another system.
 EOF
 }
 
-if [ "$1"x != "x" ]; then
-	if  [ "$1"x = "--helpx" ] || [ "$1"x = "-hx" ] ; then
+if [ "$1" != "" ]; then
+	if  [ "$1" = "--help" ] || [ "$1" = "-h" ] ; then
 		usage
 		exit 1
 	elif  [ $1 -ge 0 ] 2>/dev/null ; then
-- 
2.51.0


