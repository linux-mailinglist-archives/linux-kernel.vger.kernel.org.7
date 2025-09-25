Return-Path: <linux-kernel+bounces-832514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82DCB9F8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AA0324110
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913CA265CA8;
	Thu, 25 Sep 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4nLUWL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4023909C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806459; cv=none; b=hpnJTskbrvoylC0XieHmX6+608Z35hbNqdaQqs6cJvwsSjVghSo/v6hAfQHWbYmr5QFi+YWoZcLSTU4b2Ce9dzA70vpN6WAe61MxPkCRtYXpAQWBm8eH6r90fGx9smaWlxzJf6Fusz6h1NdnkeMQ5XK1172QkAhVkUthKkFdOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806459; c=relaxed/simple;
	bh=YDDEpU1bcy05koezpIh2vlp6eVzNiz9AaW8llrtCap0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWRPSL+8IbyTx0IuSWsDm88z+ImlOAzHKtr6Ml7ArBcUysQcMi6N0z9ej8ZPlFZiAHn6ASk2OQ7SKkXYLMdbAhNorKQYHvh8Me25QKM06vmdps2JfblJgNIfs4irHrItcUuxLJSnkdBLFO49APs4f+Hevetd3SbSunSG6Mwk/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4nLUWL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CFAC4CEF0;
	Thu, 25 Sep 2025 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758806458;
	bh=YDDEpU1bcy05koezpIh2vlp6eVzNiz9AaW8llrtCap0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4nLUWL2A+zzUCo6d9H59e2guNgttVusX1whLsHfzD0901R3uhhgUZVNCWE9J98jk
	 nzCbIalJ5wuUQrgeE8HSwYwgCHasKLd9rbUugh6SSO2+5AktQnwQGOGodSSDfjfBud
	 wgWhlJBNFlKPFJhk7QreZKRCFPX54oyvRBYLPDEtG02aa2piAQlfItygjqw2fKtZh7
	 q17FiZ1Xq4m44sHyQCss2j6JelDA4KSnl10SjRk9xoGlkooJdLXf/nocOMGbtCKBzd
	 n46TUrJsg3qVm8OK+rsORt5QrF/EbOo3GJPaKpAPjjJj3RrSA6oOqwUf8j/IO8x/GA
	 m0zFjsj47Xvfg==
Date: Thu, 25 Sep 2025 15:20:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Marco Elver <elver@google.com>, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v1 3/3] kernel: Fix off-by-one benign bugs
Message-ID: <f03b6e802662b437468d25b32bf9699875dc210f.1758806023.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1758806023.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1758806023.git.alx@kernel.org>

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
index c2871180edcc..621a60a86b39 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -176,7 +176,7 @@ static bool __report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expect[0];
-	end = &expect[0][sizeof(expect[0]) - 1];
+	end = ENDOF(expect[0]);
 	cur += scnprintf(cur, end - cur, "BUG: KCSAN: %s in ",
 			 is_assert ? "assert: race" : "data-race");
 	if (r->access[1].fn) {
@@ -200,7 +200,7 @@ static bool __report_matches(const struct expect_report *r)
 
 	/* Access 1 */
 	cur = expect[1];
-	end = &expect[1][sizeof(expect[1]) - 1];
+	end = ENDOF(expect[1]);
 	if (!r->access[1].fn)
 		cur += scnprintf(cur, end - cur, "race at unknown origin, with ");
 
-- 
2.51.0


