Return-Path: <linux-kernel+bounces-806659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7257FB49A04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352E34E08D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD6295511;
	Mon,  8 Sep 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BsJ+hE50"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DE12CDA5;
	Mon,  8 Sep 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359939; cv=none; b=RU6lYzlpVQgb5WLVLHZlO9Tp6uJ/aH55lZpxcE5LZR4bDr9oKBFeI7r7/0/e6hJ6wRiXahIx3YUXhc7UQZu80pWLb5yrlnYcEVpDoKZ4Q9pSyOiuycWekj/hAHetp3lVX6r46HN4ij09KyK7a8TMv5Be4PyPetbBfLWw0MZLjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359939; c=relaxed/simple;
	bh=svwIjY0odUvrkEDPsSID8kA/rnu9D+UdLxV13N8PzoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVhcRjQgMk9VUTgF558Pb3kh2WNHCci+a+LcLgU/7deqdn2C/aRwzUeDzaQZIJ4fa8gmbJ2ahJaLNjnPfBX6P8JNERxYHgpMVPIEJF+9xGV75JKMnWDD+E+EjsXXAoUAIbixS1/qPlYoVFH9NN7KahLFnUSBEc4qjjEfEGkxIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BsJ+hE50; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CBB2940AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757359931; bh=04ulyLXE+0xvoTpvavjUlihUixTI43QBBYVfUuXOlHk=;
	h=From:To:Cc:Subject:Date:From;
	b=BsJ+hE50SK+OQCJtXVe1DZ7g43d2UlDERpy7TNkNBDNB+StzYZisnoQ7dZEhj5F2a
	 rcxkX2mzKU/toNyTENKs0niFWDbDMeEOQaC7Bw44H+b57EzQ19wrBGtMSXd3ePIw9Y
	 CFr141I/ICady/xI/7LO0ToemUHgEpl/Ioq1+4AohvavUbk9wb4PsoD16abVDHXGsq
	 0Nea2F/q+plBk1N92AFMQXaZ4/5xqtH0OlEeQVN+pccy/vTjYWjzEAJIygWRpVpQnu
	 o3ytQy7m10CvMU3/jRrdsRnytHMYV7GRmjGi3T5Kg3cp0yeVXk/v5D7holWjpwbNWQ
	 c4EcKobdnE5NA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CBB2940AE2;
	Mon,  8 Sep 2025 19:32:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linuxfoundation.org>, linus.walleij@linaro.org
Subject: [PATCH] docs: update the guidance for Link: tags
Date: Mon, 08 Sep 2025 13:32:10 -0600
Message-ID: <87segwyc3p.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

As stated definitively by Linus, the use of Link: tags should be limited to
situations where there is additional useful information to be found at the
far end of the link.  Update our documentation to reflect that policy, and
to remove the suggestion for a Git hook to add those tags automatically.

Link: https://lore.kernel.org/all/CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com/
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/maintainer/configure-git.rst | 28 ----------------------
 Documentation/process/5.Posting.rst        |  7 +++---
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
index 0a36831814ea..0c21f203cf7a 100644
--- a/Documentation/maintainer/configure-git.rst
+++ b/Documentation/maintainer/configure-git.rst
@@ -28,31 +28,3 @@ You may also like to tell ``gpg`` which ``tty`` to use (add to your shell
 rc file)::
 
 	export GPG_TTY=$(tty)
-
-
-Creating commit links to lore.kernel.org
-----------------------------------------
-
-The web site https://lore.kernel.org is meant as a grand archive of all mail
-list traffic concerning or influencing the kernel development. Storing archives
-of patches here is a recommended practice, and when a maintainer applies a
-patch to a subsystem tree, it is a good idea to provide a Link: tag with a
-reference back to the lore archive so that people that browse the commit
-history can find related discussions and rationale behind a certain change.
-The link tag will look like this::
-
-    Link: https://lore.kernel.org/r/<message-id>
-
-This can be configured to happen automatically any time you issue ``git am``
-by adding the following hook into your git::
-
-	$ git config am.messageid true
-	$ cat >.git/hooks/applypatch-msg <<'EOF'
-	#!/bin/sh
-	. git-sh-setup
-	perl -pi -e 's|^Message-I[dD]:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
-	test -x "$GIT_DIR/hooks/commit-msg" &&
-		exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
-	:
-	EOF
-	$ chmod a+x .git/hooks/applypatch-msg
diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 22fa925353cf..9999bcbdccc9 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -207,10 +207,9 @@ document with a specification implemented by the patch::
 
 	Link: https://example.com/somewhere.html  optional-other-stuff
 
-Many maintainers when applying a patch also add this tag to link to the
-latest public review posting of the patch; often this is automatically done
-by tools like b4 or a git hook like the one described in
-'Documentation/maintainer/configure-git.rst'.
+As per guidance from the Chief Penguin, a Link: tag should only be added to
+a commit if it leads to useful information that is not found in the commit
+itself.
 
 If the URL points to a public bug report being fixed by the patch, use the
 "Closes:" tag instead::
-- 
2.51.0


