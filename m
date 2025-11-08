Return-Path: <linux-kernel+bounces-891725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55702C43549
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3353D3B2B69
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EEA2957B6;
	Sat,  8 Nov 2025 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6Fz15xu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5C15667D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640434; cv=none; b=HWBF9OURl43XPAo0/5K454sayHCn2Govm8nBL5jBjWWC5lArNAmQnoc80tpUSv6BuJZtZD6tlXrU6nYtSbnHC/2Cpn5MUgLpe8i4/vsYaQHkqCs6RWg1SZefcNISeBpL/HZmCrpkcq3/8nI+RntXlcf5WE0Ir3POZOk5y40UgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640434; c=relaxed/simple;
	bh=Rsfmd7zbC+kSZ3iat7Z+yufKodHJKLHaalHhwgTU+L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGuw5rtA2O8RAGeGdF0VGg/UbAwz+CwFSTAU11UVR7SujlGCshWPqYZKVca/HDpZ7+dSIc8eBUzp5j3MSz4hmFnClqiKyrLEV/fMlMQ/daEF1bZNArj1sYlyY2mlcFFaB5arK5OlLGCGfKr8e7JqLaDRfc36b+pDradp3DzbmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6Fz15xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0655EC16AAE;
	Sat,  8 Nov 2025 22:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762640433;
	bh=Rsfmd7zbC+kSZ3iat7Z+yufKodHJKLHaalHhwgTU+L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6Fz15xuhvHwUBywd+OmnWfPRmW7Ft2BIkpFqHoKheumyJQKEZsFpCwzguxBXXb/p
	 QCZ2C8f9B1maillLjyZtjsG0hIpKw7ZdD0FQtKeAoziuSUY65LKmocOvBTmejF2iUM
	 eFpIVm0r1QFbUh5BKzh+YH17jVWC27gojFla578snqw4asvAoir63R/url7QMew3iP
	 q/wYUe7yGYgFq9MUTqrA/uRLiCY1hhDf4FvretMv36w/PkyqKf2U9suWFO3f12gW/g
	 vH5ZhoZUM+hLD61zXwwcOKFseyO03fEYGfi9LDQEHO2kBWn9d8ay2007wqXjD7pp7+
	 onKb0jXQLkQSA==
Date: Sat, 8 Nov 2025 23:20:29 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/4] mm: Fix benign off-by-one bugs
Message-ID: <acd8bcbb05d3a260749a1e8167a5236b88c463d4.1762637046.git.alx@kernel.org>
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


