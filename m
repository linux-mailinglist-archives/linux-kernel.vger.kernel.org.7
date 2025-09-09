Return-Path: <linux-kernel+bounces-808328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3EB4FE2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983C91882706
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570E27AC4D;
	Tue,  9 Sep 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn/jUSDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3E341643
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425883; cv=none; b=TTdX7fpY4FqO1GSxBCjgNKY8GoBEAHxizLP0Xq5tLAmESqh+Sv618iOD5LBma1dtpSh+MhzLV2lukw9vYciPZU8VgiJw18aAoVgMwYKIzmfXtsXeXDIgQW3V6+/4qFd+jDOlb8vl9pUQMRgZWTilhYtje8HYYeVg3dldpP5aFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425883; c=relaxed/simple;
	bh=TWpNWzHs45xAgF+r9lLIz/NbDh6h7qbU1BoOKtSoccs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcBTuv7KYng0nT3EsRZZ8+kdO2Xo86vmJBa5oYMU53AZPt34B7S4eALaBQu5Hxy3VhWMn47kbJjwmGLf4eP2jKy+mW5nK+43V55hosel7DkBsgngo9iRFxzdpCIIDU82b8faZ3eA/kO+Bfvt1vnzxBAe/1757TeYwwz3gbihjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn/jUSDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870E1C4CEF4;
	Tue,  9 Sep 2025 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757425883;
	bh=TWpNWzHs45xAgF+r9lLIz/NbDh6h7qbU1BoOKtSoccs=;
	h=From:To:Cc:Subject:Date:From;
	b=Cn/jUSDBSZHKG/8TCFuS44gmKsbm/dFQdpypHZ1JxyUxKFWBAhcDB1jxuuwBlb7Aj
	 lZ2RaLWua2D47S0lxeJid/0t4hezQ6DAqN5ek6c1UNHeMfaTKQ0HlYu6JDt3pY2wYX
	 kin7zfAuXcNAh+FJ8LkVAuIOlwfjbbJdXeV2CgfICIFn6/EzmSOQqNxCwO5rMr+KE6
	 7c22KoWP8vYj/H6tq9ZsuLNxX4HYnrNmGwPGoOBItxKZEGtZxKS6KWLCNU7nXEJ2Mh
	 RIHc7mAuTKJe2AIqIPHiqfCbLt5kDWd5+uqJ06A+9IDFOURByiJualxy3HWRDNhLhg
	 YyxWnHAHUubAw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] Documentation/maintainer-tip: Update Link tag rules
Date: Tue,  9 Sep 2025 15:51:19 +0200
Message-ID: <20250909135119.10420-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Remove the rule about Link tag pointing to the upstream submission of
a patch as this is "frowned upon" now. Clarify when a Link tag should be
used.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/process/maintainer-tip.rst | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 41d5855700cd..9dd700948261 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -377,11 +377,18 @@ following tag ordering scheme:
 
      Link: https://lore.kernel.org/email-message-id@here
 
-   This URL should be used when referring to relevant mailing list
-   topics, related patch sets, or other notable discussion threads.
+   This URL should be used when referring to relevant mailing list topics,
+   related patch sets, or other notable discussion threads.  Do not add a Link
+   tag to simply point to the mail which became the upstream commit - the Link
+   should contain interesting and otherwise relevant information regardling
+   the evolution of the change or any related side-discussion. See
+   https://lore.kernel.org/r/CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com
+   for more info.
+
    A convenient way to associate ``Link:`` trailers with the commit
    message is to use markdown-like bracketed notation, for example::
 
+
      A similar approach was attempted before as part of a different
      effort [1], but the initial implementation caused too many
      regressions [2], so it was backed out and reimplemented.
@@ -389,15 +396,6 @@ following tag ordering scheme:
      Link: https://lore.kernel.org/some-msgid@here # [1]
      Link: https://bugzilla.example.org/bug/12345  # [2]
 
-   You can also use ``Link:`` trailers to indicate the origin of the
-   patch when applying it to your git tree. In that case, please use the
-   dedicated ``patch.msgid.link`` domain instead of ``lore.kernel.org``.
-   This practice makes it possible for automated tooling to identify
-   which link to use to retrieve the original patch submission. For
-   example::
-
-     Link: https://patch.msgid.link/patch-source-message-id@here
-
 Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
 they just complicate automated extraction of tags.
 
-- 
2.51.0


