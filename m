Return-Path: <linux-kernel+bounces-867486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43017C02C36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8A1F4E0633
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A734A3D6;
	Thu, 23 Oct 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLRAGeN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635C236453;
	Thu, 23 Oct 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241177; cv=none; b=gmrCWPJl5bIx7jHD22qObHdsHjE8/ai5MKRqbsg2NQVFyj9tfcOSazVC16W2rzaB9lfspl0a+0C7wdADIgDSmB+ScfSi2BIYcJ74jXmQW4V7jZP5VVysATVXJDSWhqq0qGj6CAXfmV4B0iMzebnNqst9mBjDTESIdWwF2FAFe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241177; c=relaxed/simple;
	bh=y8FcQl/tdhUR9emAymQCDVyljD2NFGR2+Z65Qge1MJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cu2aX+NWqL6mx7ODQWV4VcYJSuUvYr+bEN766RMpeYKcQRMzulUiDBJwA5JFxuFgsoDm/lqAUHFjGi67ux4elRtQQGsnQtG3zZHz96xjoQUnjDymee+r6JrHY/ypdrZbRS705Fz4QcGmvYlLRYokEEqHBYGmMtZ9J9hI9ojxqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLRAGeN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCB8C4CEE7;
	Thu, 23 Oct 2025 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761241176;
	bh=y8FcQl/tdhUR9emAymQCDVyljD2NFGR2+Z65Qge1MJc=;
	h=From:Date:Subject:To:Cc:From;
	b=RLRAGeN/43K4pTReEel9mg67U5oa02cfOnXqw+capCfwW6lJ6n9KErRBKgq8Q/p5C
	 3Qzc+SDtfkn9cM+5ChQM80BwLuYbpeqXaiCk6Goav2JvIjnC+oAatXgJUUMV6edEg9
	 p9Cok6IJs59JF+nEy6vFIEp/9DB2xjVlPZxERM0FrhQQ6skk2AyoP0C5Pul7QcPYzF
	 0TWkbXXqbBkjlSGSTuMsZ3z/OHswrAfLyFdA9oUKrNRoeFQDsqEditk/5zA/i8JPt1
	 t2OtXeXNGUXefVAziXfeiR7w8zuSBpqCiCDmYPcN3yR8VwtbSww+52bSOQAyN/2Td3
	 jqdpwmPpnCPNg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 23 Oct 2025 10:38:50 -0700
Subject: [PATCH] jfs: Rename _inline to avoid conflict with clang's
 '-fms-extensions'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-jfs-fix-conflict-with-clang-ms-ext-v1-1-e219d59a1e68@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QrCMBAEf6XcswtppEj8FfEhphd7UlPJBS2U/
 nsPHwd2djZSrsJK126jyl9RWYpBf+ooTbE8GTIak3d+6J0/45UVWVakpeRZUsNP2oQ02xZvBa8
 NMfoxuEtw4RHIjj6VzfhHbvd9PwBu+OaEdAAAAA==
X-Change-ID: 20251023-jfs-fix-conflict-with-clang-ms-ext-aa2d907909b9
To: Nicolas Schier <nsc@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Dave Kleikamp <dave.kleikamp@oracle.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2945; i=nathan@kernel.org;
 h=from:subject:message-id; bh=y8FcQl/tdhUR9emAymQCDVyljD2NFGR2+Z65Qge1MJc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBm/MvwiHc7rTVoxw1ps7+wnKXdD07weVZzI3HP0EN/vg
 09MmeJdO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEGo4xMkxZuiX1SgiPteei
 3+UtClKmlz5MWP2jKbPZtks9rCLpz0RGhp2Lr259fKWa+eXrf4KZLw+p3DiyRnRpbdM0iWrbnY8
 +rmQAAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 778740ee2d00 ("Kbuild: enable -fms-extensions"), building
fs/jfs fails with clang:

  In file included from fs/jfs/jfs_unicode.c:8:
  fs/jfs/jfs_incore.h:86:13: error: type name does not allow function specifier to be specified
     86 |                                         unchar _inline[128];
        |                                                ^
  fs/jfs/jfs_incore.h:86:20: error: expected member name or ';' after declaration specifiers
     86 |                                         unchar _inline[128];
        |                                         ~~~~~~~~~~~~~~^

'-fms-extensions' in clang enables several other Microsoft specific
keywords such as _inline [1], presumably for compatibility with MSVC, as
Microsoft's documentation [2] mentions:

  For compatibility with previous versions, _inline and _forceinline are
  synonyms for __inline and __forceinline, respectively

Rename the _inline array in 'struct jfs_inode_info' to _inline_sym to
avoid this conflict, which is not a large workaround as this member is
only ever referred to via the i_inline macro.

Fixes: 778740ee2d00 ("Kbuild: enable -fms-extensions")
Link: https://github.com/llvm/llvm-project/blob/249883d0c5883996bed038cd82a8999f342994c9/clang/include/clang/Basic/TokenKinds.def#L744-L79 [1]
Link: https://learn.microsoft.com/en-us/cpp/c-language/inline-functions [2]
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I will stuff this into kbuild-next by Saturday morning UTC unless
Nicolas is able to take it sooner to ensure it makes the Monday -next
release.
---
 fs/jfs/jfs_incore.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 10934f9a11be..5aaafedb8fbc 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -76,14 +76,14 @@ struct jfs_inode_info {
 		struct {
 			unchar _unused[16];	/* 16: */
 			dxd_t _dxd;		/* 16: */
-			/* _inline may overflow into _inline_ea when needed */
+			/* _inline_sym may overflow into _inline_ea when needed */
 			/* _inline_ea may overlay the last part of
 			 * file._xtroot if maxentry = XTROOTINITSLOT
 			 */
 			union {
 				struct {
 					/* 128: inline symlink */
-					unchar _inline[128];
+					unchar _inline_sym[128];
 					/* 128: inline extended attr */
 					unchar _inline_ea[128];
 				};
@@ -101,7 +101,7 @@ struct jfs_inode_info {
 #define i_imap u.file._imap
 #define i_dirtable u.dir._table
 #define i_dtroot u.dir._dtroot
-#define i_inline u.link._inline
+#define i_inline u.link._inline_sym
 #define i_inline_ea u.link._inline_ea
 #define i_inline_all u.link._inline_all
 

---
base-commit: ac1280211e1c41704c756fd1bc5512f92010b3f0
change-id: 20251023-jfs-fix-conflict-with-clang-ms-ext-aa2d907909b9

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


