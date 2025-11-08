Return-Path: <linux-kernel+bounces-891726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25616C4354C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14AEF4E3DCD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C25C289378;
	Sat,  8 Nov 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzyt1Yoy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7B287508
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640438; cv=none; b=NuGn10cFfePzjVr7X1+CBeldwlNQ9ejKNcD6ZAjo2f87xVLQD4C3DXV2LvgFolXaY7UmH9XNw2x9JCBq7TYRRFncxV9XEsDWkyJtJ3+DEHC6yOtn8AXY4IyOnHtU3sYRT7tyOOXBpUyZP2jmrxRVbdbKNKWKX/j3xoQ2cwdPu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640438; c=relaxed/simple;
	bh=59w6p5OIO0ukVj/H6iWXGVoWsjSUgZ8nYZ9Xx2PeP8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI7dgzeuPvl7hLjwvbq/Mo2y3BGDmUXEjRjtEwXj4bB/WX5jqoEgNopJSw2CVH8iKuZ6TknK15aoIj1RrZnQ++uy1qlpM940AqFE6O1QI0LHDejce9W2G6fEIroPoBJjeNKLkeZl/XG095Rgzl//NzzCt42r+qNWmATFx1FImrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzyt1Yoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A42C113D0;
	Sat,  8 Nov 2025 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762640438;
	bh=59w6p5OIO0ukVj/H6iWXGVoWsjSUgZ8nYZ9Xx2PeP8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mzyt1Yoyty3gGLNjAe4JO4ekMYedwKfiNvmW76diuxT95rn8ERHxwndRMz6jMw+La
	 h4K7MiqVPo8z9t/w94rg+JkPiyV/EbfyHYGNVFVEi/7cerLZFPkG7/jeE96FZt38uc
	 jsagjnGF23DhNV3tZlVtcs+7LSDElYiwhj8Lua5f24oZVf/e/EhBq+r/MqrLpUuJ3b
	 zGEioEununZPoNK5i3Hgpq6EZGy90NxapNRLv3D24NzaH86UqWt7HQM5yu4BpyhqZX
	 xWEFvtoye8FKd25jgDwgKTxmNWtOD+v+iRYLQ006kdDkWzrgVTiSy0ZKDsQ2qXWmoY
	 1YPHKY/5hXgNA==
Date: Sat, 8 Nov 2025 23:20:34 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/4] kernel: Fix off-by-one benign bugs
Message-ID: <781cce547eb29aa82571d0aaa7423fb2a1f59a8c.1762637046.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1762637046.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1762637046.git.alx@kernel.org>

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


