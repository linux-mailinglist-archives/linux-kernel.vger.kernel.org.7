Return-Path: <linux-kernel+bounces-892083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B9C444D6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EFAA4E74BD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6400C22D793;
	Sun,  9 Nov 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m75WjUhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFB2264C0
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711629; cv=none; b=IRwNHAfDBrYsmWwmq2YDhmaCAH0/96bxMEqBfLy+kFXLOBI3zMHxxFDr/4ExgRSjPbOjJFGlr53QYe4Qg6Pt+a55PW9uoXH98T+eYLfrJvcwYsffGoWDibLiSJlgumeoCFpbdQsDusUcoClrMTlma/IQ53qvFaMOhOrj8bk62Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711629; c=relaxed/simple;
	bh=59w6p5OIO0ukVj/H6iWXGVoWsjSUgZ8nYZ9Xx2PeP8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWOkQHKj5zPd/fF6Kcwtxqy7p7ThsYAQk59Pxj+eR1at9ywC+Q4zWNikGCEvw9JDjUjYePc96H2F57Z2i/VLzuagxuVWcexP5x7Y1GuAQqYqQUiPpH+jk1NDbUHYnNfvU73aJhGXIs7xyhouwQ5BBjsyYNFC37oUYV1nIcrUptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m75WjUhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4887CC4CEF8;
	Sun,  9 Nov 2025 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762711629;
	bh=59w6p5OIO0ukVj/H6iWXGVoWsjSUgZ8nYZ9Xx2PeP8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m75WjUhql6v/TjVEVnpOWQ1J/FB300lERpRYAirZ1FL9l76CpCRBfww1t2a35snQD
	 tJHog/nimE0l2EWB/xf3G7qrVi9oDltBkClxF+5wivdARDiJS82n+dVL+gBKvKd8BR
	 v/8JUuiy6YMgm4mnDcTl44gppUgZ/Wyo5IFO+cH2sa9UGBl+NBzQtaPOFGfayVhBD+
	 867kDhk1O0Gc6+aNChoD4zHmiq4wxs2CHEGKY/HJnXV/ww0wv+WJhTpq7pcJlFswDD
	 AecDB2oiiUD1yMcLmdGjs44qVENg+pvI5a2EtLzvTW+1c+3RwlEOqTma9hq9YQhjBj
	 MpMRGrTMqp8EQ==
Date: Sun, 9 Nov 2025 19:07:04 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 3/4] kernel: Fix off-by-one benign bugs
Message-ID: <d8128f0c8b9fcf5be9684eeee650c24ede242b8e.1762711279.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1758806023.git.alx@kernel.org>
 <cover.1762711279.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1762711279.git.alx@kernel.org>

We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
doesn't write more than $2 bytes including the null byte, so trying to
pass 'size-1' there is wasting one byte.

This is essentially the same as the previous commit, in a different
file.

Cc: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marco Elver <elver@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 219d22857c98..8ef8167be745 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -176,7 +176,7 @@ static bool __report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expect[0];
-	end = &expect[0][sizeof(expect[0]) - 1];
+	end = ARRAY_END(expect[0]);
 	cur += scnprintf(cur, end - cur, "BUG: KCSAN: %s in ",
 			 is_assert ? "assert: race" : "data-race");
 	if (r->access[1].fn) {
@@ -200,7 +200,7 @@ static bool __report_matches(const struct expect_report *r)
 
 	/* Access 1 */
 	cur = expect[1];
-	end = &expect[1][sizeof(expect[1]) - 1];
+	end = ARRAY_END(expect[1]);
 	if (!r->access[1].fn)
 		cur += scnprintf(cur, end - cur, "race at unknown origin, with ");
 
-- 
2.51.0


