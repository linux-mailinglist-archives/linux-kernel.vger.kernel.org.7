Return-Path: <linux-kernel+bounces-829039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E3B96236
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184734A156B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B417F265CB3;
	Tue, 23 Sep 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciZEy9D6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8025B2FA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636173; cv=none; b=Tpk6G4Ayf/baAAKLZHi/LrstlGZCLd09iab066hEZbbycfQNcgRZX8r7XmolJonDF52wOK42CidCMi9I6EI2rHLbXQmongamTHtOHl/G2rz3Rih5wUBBbdXrBA2HlXbGJy317lDM+kI59qssIgRnEusrzmF9LMIm/v7osqEmNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636173; c=relaxed/simple;
	bh=aQUw+ZQU6opQZV9jZCF+9yMEFosgWXmVNWXDvI93Q/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SUQIlMRcgJDMB9Mge8kwscD7HUWOAAx3mYpv4TucjA2Y8V97tZDfWcGA7yqbyR4wvy1YunC7mbN9geCezfF5PB+pG11n8QUlrbzRwmmISpWXHfKYxiixNakD+RlFiN9ulwkSLJsZnqtpbSC1ISbCyy5zFX5e5+XzMUXWl+MM9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciZEy9D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799C4C116C6;
	Tue, 23 Sep 2025 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758636173;
	bh=aQUw+ZQU6opQZV9jZCF+9yMEFosgWXmVNWXDvI93Q/c=;
	h=From:Date:Subject:To:Cc:From;
	b=ciZEy9D6+ZnGaoeQ9XbAM9FV3jumrqGrbWA935TPM30hYSQP5hZXqF4glNfpLZ3DM
	 1Gv6bCTaBGbFyd6r1DMWmTRxfipZBvV3/6Emz6PxC3YkuN01Y5IJm2xLEXrO3qEZFF
	 IHbKxwGHUPjOu3OfgKrU8AUhB/ZnkI74qTujkiPc3tvMxctGhlnVaSS7JUR3QZQkjY
	 Za/HFYPuh6p1vBVcrpGeBKtdSSIRBWvrtqLvzH5Cg7hRi6pckItw20iI8rtajbloE0
	 UREiQHAHKaoiUgynXVCOiPq6pELzGOOeTTRC1WVWxgoAMiejRFkmNgrSFh3/+vcS84
	 DWOfB1B9AEr9g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 23:02:45 +0900
Subject: [PATCH] locking/local_lock: fix shadowing in
 __local_lock_acquire()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-local_lock_internal_fix_shadow-v1-1-14e313c88a46@kernel.org>
X-B4-Tracking: v=1; b=H4sIAISo0mgC/yWN2wrCMBBEfyXss8EardL+ipSwpmu72CQ1iRco/
 XcX+zJwZuDMApkSU4ZWLZDozZljEDjsFLgRw0Cae2Ewlamrxhz1FB1OVvJhORRKQejOX5tH7ON
 HGzJoTtTUdDmDSOZEsv4Prt3GiZ4v+SlbCTfMpF30nkurYuKBw95jFjV06/oD/H/q9aEAAAA=
X-Change-ID: 20250923-local_lock_internal_fix_shadow-2e2a24e95e76
To: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=aQUw+ZQU6opQZV9jZCF+9yMEFosgWXmVNWXDvI93Q/c=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXVnRaGE14cSYhiaefbQKLG0dNGr/zudNTNiqt3rKxp
 H37wzkvOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExk4lWG/3FdGYtDTyWcurt5
 9udHvBx3TIL6DC5NE98Rd2DbpqOHOpUYGWa836evr7Xox18HjrXT+PyyZtxYHFy7M0r8h0/Rndl
 ap3kA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The __local_lock_acquire() macro uses a local variable named 'l'. This
being a common name, there is a risk of shadowing other variables.

For example, it is currently shadowing the parameter 'l' of the:

  class_##_name##_t class_##_name##_constructor(_type *l)

function factory from linux/cleanup.h.

Both sparse (with default options) and GCC (with W=2 option) warn
about this shadowing.

This is a bening warning, but because the issue appears in a header,
it is spamming whoever is using it. So better to fix to remove some
noise.

Rename the variable from 'l' to '__lock' (with two underscore prefixes
as suggested in the Linux kernel coding style [1]) in order to prevent
the name collision.

For consistency, also rename 'tl' to '__trylock'.

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
I did not include a Fixes tag because I do not think that this is
worth backporting. But if you do mind, there it is:

Fixes: 51339d99c013 ("locking/local_lock, mm: replace localtry_ helpers with local_trylock_t type")
---
 include/linux/local_lock_internal.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index d80b5306a2c0ccf95a3405b6b947b5f1f9a3bd38..69feb161c5e6c94e36ba30b2c625eac0065d1e3d 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -96,18 +96,18 @@ do {								\
 
 #define __local_lock_acquire(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__trylock;				\
+		local_lock_t *__lock;					\
 									\
-		l = (local_lock_t *)(lock);				\
-		tl = (local_trylock_t *)l;				\
+		__lock = (local_lock_t *)(lock);			\
+		__trylock = (local_trylock_t *)__lock;			\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired == 0);	\
-				WRITE_ONCE(tl->acquired, 1);		\
+				lockdep_assert(__trylock->acquired == 0);\
+				WRITE_ONCE(__trylock->acquired, 1);	\
 			}),						\
 			local_lock_t *: (void)0);			\
-		local_lock_acquire(l);					\
+		local_lock_acquire(__lock);				\
 	} while (0)
 
 #define __local_lock(lock)					\

---
base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
change-id: 20250923-local_lock_internal_fix_shadow-2e2a24e95e76

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


