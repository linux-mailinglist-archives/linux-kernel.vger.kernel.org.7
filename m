Return-Path: <linux-kernel+bounces-892129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1ABC44665
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59AB3AB25E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B64257846;
	Sun,  9 Nov 2025 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuyLJvOX";
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQbX0SYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5F25484D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=10.30.226.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717728; cv=fail; b=qdmbmQ8uAFrTwCszdR0TGB7jTjOL3YkDpbovXaf90v5+uO5rqs7raEOEnc9+Kb3T2WnZcOzxDGXU+4qqnsKBPAsoOtTjTXriYc7xkmuRpPrycZIj0SunXa4x4EbcqHSpf4RxMhoNUiGjsQqcijACMsV0IBb909KmVrqa4bxCVew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717728; c=relaxed/simple;
	bh=59w6p5OIO0ukVj/H6iWXGVoWsjSUgZ8nYZ9Xx2PeP8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu48U6RnZYINgWQd9NZkL0CdX9AfWDjSbP84qgSynulPhr+svZr3Z8TSnDYph8Nn95NAVvvBSGiXOND4nmk+iGjeO0Z5TIfF0BMxlNYKtN3ECSpR0L8tttbKxNgnC6ui4HFXHI4PHDYPjv7vLMGlnkzdePl7mayQ/Fp/E4MD5vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuyLJvOX; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQbX0SYa; arc=fail smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559BAC4CEF7;
	Sun,  9 Nov 2025 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717728;
	bh=59w6p5OIO0ukVj/H6iWXGVoWsjSUgZ8nYZ9Xx2PeP8w=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
	 References:In-Reply-To:From;
	b=cuyLJvOXPlS8IVsLWtcUaESKUNmOD+xHgATI5z3cxeb7tF2HI2eXwKjS2oc+w+7bb
	 mwSqLY6u9hsV0jvux9TTkwq3faU4TtbDQmQrP2QEvHZdyIh2zmvpXOHU9tnuKYyfa6
	 /9BqgBJ/gtRsL+ms3URRwBrKmLaLCuiDzm4jbwMhH/CeRfH5t3Q48b1xelgjiNoGlk
	 ymGyYcG7VeBi1wQVX4+Rl/bUdS8NHSctTip7sk8PBP0f21Mw93XVaecEaUZ17EAMMk
	 MNGJILuvlitZaN24ELnqCHgwuF2weUPi70bX0wZgPh7ROoQHmsT9/OdM06EV7zWcqC
	 ZlDDrLtOuCSkg==
Resent-From: Alejandro Colomar <alx@kernel.org>
Resent-Date: Sun, 9 Nov 2025 20:48:45 +0100
Resent-Message-ID: <w447wj3fennuda2oghwg7ku5dumvwbiabkw3m4ngwfjmc3wl6d@yu7ztr6ho5nq>
Resent-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Received: from mp2.migadu.com ([2001:41d0:403:4876::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by ms17.migadu.com with LMTPS
	id mMZRO1fvEGn8pwAAe85BDQ:P1
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:28 +0100
Received: from aspmx1.migadu.com ([2001:41d0:403:4876::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by mp2.migadu.com with LMTPS
	id mMZRO1fvEGn8pwAAe85BDQ
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:28 +0100
X-Envelope-To: foss@alejandro-colomar.es
Authentication-Results: aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=JQbX0SYa;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 172.105.4.254 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=key1; d=alejandro-colomar.es; t=1762717525; a=rsa-sha256;
	cv=none;
	b=t3K8+LOKIGi3fqNButK0FYaKIcyPQ3Ay4gUosmY6Ie9IhTe+n1hYuGcbj2pwX+xT0sVGW+
	EYI69jTvWfbSCt3RU3ByMT/fDlXHG/mAFRe0Mocc82s/7Zpw1/n4e0ouw9SyV9woMmuTYK
	vv+Fhg7w26l2A3ov78MpMq9mzZ0gj4ja1+ZNF6C0j/qJNvCF01Qq0KkM4LJL1nNll5iSrH
	4Bc9gg6TazobR7UbdFAvZZ21CTzwyvQiTV3lW81QCt+afmFtNyzMd5ZR8pgVBtlYkbo6kn
	AoGSOjRgisFJ/iKgKpRQ4sTyTvEoL0/j4UeBwfNQISNAb877VuLJ+WiKBxCYrQ==
ARC-Authentication-Results: i=1;
	aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=JQbX0SYa;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 172.105.4.254 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alejandro-colomar.es; s=key1; t=1762717525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SyD7wRt/mfijbblI79CRl9e76BRavXQyqr+l5ZBChP8=;
	b=Av+oC8EcVZOzEpfirMqTfjPMzjkK3do4ouaqes9SLia3y+QIMIiUnnHjm1gnMSl0JQ7+y6
	rl1Ae9CDbw72ztXFPacDZulJsQqVzgwXhw6bSImIihDDvIqotoDFEuTtgkcDiW/rTCrH6+
	W66uNroJKCF5SDzF1zQQXItNDYRzv4yPsq3m3Tbmq0B/DTiEncyr+257JrsEYVvVohCnoM
	YvLuI7DHUTQogZsRKMJKWpPULai0oaJwY1GKJM94CFjxSFNijHIJ3ZjzZQ6hO2mSIGPd4U
	KC/rPcta5l/XkjvPCz4NBNHDA7BlceoBeIpD/9/m3jkpBmcBuF79z4amtukZ2w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aspmx1.migadu.com (Postfix) with ESMTPS id 702BAD7A60
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:25 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 90F6060007
	for <foss@alejandro-colomar.es>; Sun,  9 Nov 2025 19:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 509C9C19423; Sun,  9 Nov 2025 19:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8DCC4CEF7;
	Sun,  9 Nov 2025 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717524;
	bh=59w6p5OIO0ukVj/H6iWXGVoWsjSUgZ8nYZ9Xx2PeP8w=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=JQbX0SYaltov8l0e0BerHUgvsTz54JcE1WPi6+4IiR+p1BvijSeI6ervSU80qRB+o
	 FllD2PIOOkkHC1jHSIgDYpBWYqel4+midyGZUl4R+xxrygeMdm6HSkxBJgh6rf/NEs
	 JVfor2abuR3KKFGj6Iy1HM0rPYkx5G2R1V/ojEXpRLLEyykJGBaQVFVi6eWXDR65+c
	 06zNA3/i+qvGWdyu/4nUFlEJk+/jlCC33rWbmEYSTZLTCpcsXFBJbwZfNqdUFNoX5j
	 ycmH0B9510YwmOK0QK0jb10tG6mFU0ZlmeJ6qjczeBMPAjtOGBEx1SpNHhYbpYDzip
	 gzn+IOntLahvw==
Date: Sun, 9 Nov 2025 20:45:19 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v4 3/4] kernel: Fix off-by-one benign bugs
Message-ID: <ca8dec7f5bc9e5b49693681d770231448f99df79.1762717358.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1762717358.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1758806023.git.alx@kernel.org>
X-Migadu-Flow: FLOW_IN
X-Migadu-Country: SG
X-Migadu-Spam-Score: -1.11
X-Spam-Score: -1.11
X-Migadu-Queue-Id: 702BAD7A60
X-Migadu-Scanner: mx10.migadu.com
X-TUID: yG/nyHhor1Yn

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


