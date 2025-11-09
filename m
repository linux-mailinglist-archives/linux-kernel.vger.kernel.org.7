Return-Path: <linux-kernel+bounces-892128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80794C44662
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3317345E6D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82359243954;
	Sun,  9 Nov 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb1I7HCC";
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzHcwtHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFD23AB98
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=10.30.226.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717712; cv=fail; b=Ww7gbh+hquwhV9CXyhM/bQHB5k+Le2LPck2CrSmuEHl4O0++P4UZtqIIbQUK5WvkeYzTszcY+tnTf2c/FJjaclpZRGF6K+WxWRQcpVi/Itesr93MhY+rZs2a0AeQmSJipTXUcFElGTdfHFigGvQpSUqCisiPmpZQ2/lIefXyRM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717712; c=relaxed/simple;
	bh=Rsfmd7zbC+kSZ3iat7Z+yufKodHJKLHaalHhwgTU+L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jazCVMtzSjcF9rUdsP+tMk/+5FLBfL9CwvKvqWmsLiBpci5lu2kRrAkCB91cb75Sj6AGMD81GOGpzko8kDisFmoRSr8Am1UflGnpYMEHfwAgdDhxanyho3ScF+Bf1C9mVMf/4mDYJ3fbDZGDYWN7+yWqiGms/CdpYjOD4bKj7qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb1I7HCC; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzHcwtHD; arc=fail smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8802C4CEFB;
	Sun,  9 Nov 2025 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717712;
	bh=Rsfmd7zbC+kSZ3iat7Z+yufKodHJKLHaalHhwgTU+L8=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
	 References:In-Reply-To:From;
	b=eb1I7HCCZeEl6TCepnay1U+s2KFjSh1MyvtgkYfyFuJ3HSVrTWcljHA1plfYUGj0c
	 maL7IP8wIIgBgbjDuQPKpOKNyOLra1FK6aQqTv6MRu7bmlemlXFcuEQEMYueHo/gTe
	 zHzjiUxQJaReJDZEw3oM/LAJ6NxdLBJwx+jbJz2hrlD/PiXzRIZvNvUzYvH9hoqRAG
	 2zlVOwmXqr26At0w5y4mAehBzSp8PwE+Q0OeCe34WMSeczy8Kbnvcdkr29cGOsFXdK
	 rmVrGBGemYg8g95YKZGLybpTo7DN31YaDtrukpKE27OMMUdP7jdP0+sYaoU57EPCf8
	 v3DCjrSyOHqcQ==
Resent-From: Alejandro Colomar <alx@kernel.org>
Resent-Date: Sun, 9 Nov 2025 20:48:29 +0100
Resent-Message-ID: <px2c7rrvhc6lqy577sy7us57j7h37oyclngup7ph6spua7epsk@xgcc7hyom3kc>
Resent-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Received: from mp2.migadu.com ([2001:41d0:403:4876::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by ms17.migadu.com with LMTPS
	id 4BY9NVHvEGlGGQAAe85BDQ:P1
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:22 +0100
Received: from aspmx1.migadu.com ([2001:41d0:403:4876::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by mp2.migadu.com with LMTPS
	id 4BY9NVHvEGlGGQAAe85BDQ
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:22 +0100
X-Envelope-To: foss@alejandro-colomar.es
Authentication-Results: aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=LzHcwtHD;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 172.105.4.254 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=key1; d=alejandro-colomar.es; t=1762717521; a=rsa-sha256;
	cv=none;
	b=BP8FKr6DRiFBBzpqL+zzwK54NQu64z4zhtZVdD9wmJhcczVXMlfDedQyZHfvIlYm6Ic2jg
	dO+41hRCp/uYscq7IJvCyXS4zYvcsi1hvAxI2LNepMpmrsh0JlGw1u2v8gngCFi58uDOmW
	cHZyt8SgArOvBwhWygbcjS/WnUFvKm4m7sriEH9gtovtc20JuIAlRQWkgsN/MvCaRRZCRi
	DiUoQ1YUR9McwnHnUbB03o1DmlHsSau0N7C1YInCUnw52REb0z75Lct5cDmhmHqHmCprFF
	FWcXk4YUyI1OLVLaMH/dWu/wRSrEO+qv6KPTFNHqzaVHldZm8F95fX4h5zD/MQ==
ARC-Authentication-Results: i=1;
	aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=LzHcwtHD;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 172.105.4.254 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alejandro-colomar.es; s=key1; t=1762717521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DXKtenz6DaLMGUShcrB400tfbTGBqWhLKx1FA2IPRio=;
	b=mm4jNvLfEK/8RhG/MG/mSrpZ88IsYmzSM2Tz5PWdCvCOgAO9h0M5bUoTXAq0rICFRq/XgE
	sa8vGwtASLrmaZxWR8lCW7rUVIhfiqqVopG2UTiXg4qQeYpMAFO1xOCV2NKMCb68xeLVVl
	S2NSska/YDo6wrxmBR+Rkqx1yboW1PgOEywo3XNk9gDcl7PLmcGQGGczGQH9IRsFG5dhf5
	brLFoT910GEh24AZh1pIlHkVgM2XI48jdAkXP8hOwsK48Vq5CL+UrhbZGx5lyBZu94z0T+
	uOw4fZWyBALhFHYDE6v56cRSuB8QAjkri0QP55kFjlrDdPfh30qTYkBZks8IEA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aspmx1.migadu.com (Postfix) with ESMTPS id 0F58FD7D2D
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:21 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 864A560008
	for <foss@alejandro-colomar.es>; Sun,  9 Nov 2025 19:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 49AE3C4CEF8; Sun,  9 Nov 2025 19:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A87C19425;
	Sun,  9 Nov 2025 19:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717519;
	bh=Rsfmd7zbC+kSZ3iat7Z+yufKodHJKLHaalHhwgTU+L8=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=LzHcwtHDsuLU7WJ43kChp8Y+U1WEmrxpjOY+pOb0QZbgixTyvkxjiOmTAz/8B7wB3
	 TWRbDRfB+aNdheUwVW1cfS8JWxcQiLKvrtkH02tsYcG0Z2bz3lCEcvOgNqgwsPjZyg
	 7v0kIE1uGa5DM4QMsOns7CWZi+U26E1EzKbssrZTLidqQcLb9//0yDLLp2a54Svq62
	 H2U9GnqsJzOoqYfhWKxnp+GhqcXm6A0hw8t+Sh8WOKHhvrbfdn6lMtpXx1R5jotnX/
	 4ALKg7RUgbX/WgieaY7soOYa+PMEMhjaxSHeNMIBynget4wtlxnX1cjqzuNZVJij0M
	 xtOabPQWJ8XTQ==
Date: Sun, 9 Nov 2025 20:45:14 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v4 2/4] mm: Fix benign off-by-one bugs
Message-ID: <ac55d92551e43bdb7494911babc4fef939baf12f.1762717358.git.alx@kernel.org>
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
X-Migadu-Queue-Id: 0F58FD7D2D
X-Migadu-Scanner: mx10.migadu.com
X-TUID: hEYmiNksznMd

We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
doesn't write more than $2 bytes including the null byte, so trying to
pass 'size-1' there is wasting one byte.

Acked-by: Marco Elver <elver@google.com>
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
Message-ID: <515445ae064d4b8599899bf0d8b480dadd2ff843.1752182685.git.alx@kernel.org>
---
 mm/kfence/kfence_test.c | 4 ++--
 mm/kmsan/kmsan_test.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 00034e37bc9f..5725a367246d 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -110,7 +110,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expect[0];
-	end = &expect[0][sizeof(expect[0]) - 1];
+	end = ARRAY_END(expect[0]);
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
 		cur += scnprintf(cur, end - cur, "BUG: KFENCE: out-of-bounds %s",
@@ -140,7 +140,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Access information */
 	cur = expect[1];
-	end = &expect[1][sizeof(expect[1]) - 1];
+	end = ARRAY_END(expect[1]);
 
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 902ec48b1e3e..b5ad5dfb2c00 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -105,7 +105,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expected_header;
-	end = &expected_header[sizeof(expected_header) - 1];
+	end = ARRAY_END(expected_header);
 
 	cur += scnprintf(cur, end - cur, "BUG: KMSAN: %s", r->error_type);
 
-- 
2.51.0


