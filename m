Return-Path: <linux-kernel+bounces-869418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1EC07D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301153BEEFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47834845C;
	Fri, 24 Oct 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byFivHe7"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0B30DD03
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332474; cv=none; b=GgCbzwUglh0dk1CM893fE1X8IICyxUtMbC6PRI5T6c2x8Jap+5pJ5a9v+jYbsjVvkGq751TMwJ2W8sQfCYuaD066GMgsh6NXzb7eItm35+AflrsJPEWVH3Lq0bI4aoyRpXVawZEaqR+emZdgnrIjIn2QWVmBzrsoE+NLN48YORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332474; c=relaxed/simple;
	bh=HX6EQnKcolO/j1E2XrmMEXhrxKNhp5wrM2JfBRBCHIY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EUHDR07RlQMfA24bvknLTXcLnzUJkuFvVea1ZXIYlgPU5BoD0AXYYpDEEJncG6GUu2iPnQEZVjVlKcd4NrkUA2vcREXPaFrgnivuqSoMnZmznZYsC2sw0xH32XuzDbNHqERlX/Ls+Ibmg+5kJI6kXE6K1ErxbJmCJUhEoOIW/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byFivHe7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so2012648a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761332471; x=1761937271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y8waxpIQ8zGohuhfEK0FchG05acb+4DM6iQ/kzGyRAg=;
        b=byFivHe7514XbAHoCk6HePP2jOMeQQIk1Lhz4CtZnQjeRXZe866qfJysmj93QNJ85/
         uz6Ld3wS4gVBbXMEIqK2AmGouE5AazHG6TjWjNw+5PFEu4HBs/7BEF5SPnTtkp6Mnajp
         RvQHiOReNZ8P+vAhd6Kmo1V/uxEc8bhPwGAx4ai/+KdMR0+1s7KsKWQXJlw5yDUrYfZc
         xIHyu5rtMRTqbmpu0eyOXDf2yldSDpN1Fho748bdYLi81acY/vPkM0o00aSA9iSG+SSq
         7Dau4EMcEShsvkin25XD9/jVn/ByAV+0nxXrUs8Nlbf05L6ZeyHFz1k9RoKoJlduDn3/
         nWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761332471; x=1761937271;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8waxpIQ8zGohuhfEK0FchG05acb+4DM6iQ/kzGyRAg=;
        b=EnYmdgtzVDr+IVe1KlFyD17YM42et6rAnqwGSjjuE2H0x3xhQwk1RMOYVzf7V7C8Ky
         uCpOxBByGA+GxMr65/AFVH+G4SIo/wWcPNZBis8Ln3H2guyLIatGBlCR2sHjftNDJzDt
         3hFYUq1Kg95pyWLy0k9bpVtAljVLy+FW/UQeBiaddAJYEc5n8+W8qw+IBgJDaPLovLq5
         uw+xTR6ANaLg2IuZkYTwh5aWsh7bMEeC8wHndc5YhGeWAvAcwCFuHWLf23KGcP/vGTrr
         2fPZLSxZpFqDDKHi9sIPg8Uc96JlbUuTDGG5QOOMitLwEe8aEPnlIdXumlA1X76p3qGP
         aZsg==
X-Forwarded-Encrypted: i=1; AJvYcCWjjakSeqyPt2Liv0R2ZnHEnDfQ3OBlDyjbl9yXR5siD5m3IKb19fPV0NrNVnnPtI2RUVyS0qAe/6shTCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7ei9FuEJSREAPEqvoVCCPn93JtnOBdutvRcpGgkQknEvEFpv
	XtKfThj/xKr47WQfXbomo3QMeE0+yzMhnTYcwgtVZ5SUUWB4erNqDou7ij7CSyso+8CHO7Ff8ZI
	/27/PfLV6gScwgw==
X-Google-Smtp-Source: AGHT+IECkyz7QjtjqlIBCYpDRH8zhYEB/CRZQefpS4FJrV2eHd9B6iamp/NEmX8Y64PJXUVBOg33HFcIUmVKiA==
X-Received: from plbjh6.prod.google.com ([2002:a17:903:3286:b0:290:b136:4f08])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ceca:b0:292:fe19:8896 with SMTP id d9443c01a7336-2946e25e038mr94802595ad.52.1761332470917;
 Fri, 24 Oct 2025 12:01:10 -0700 (PDT)
Date: Fri, 24 Oct 2025 19:01:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024190101.2091549-1-cmllamas@google.com>
Subject: [PATCH] kunit: prevent log overwrite in param_tests
From: Carlos Llamas <cmllamas@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Marie Zhussupova <marievic@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Tiffany Yang <ynaffit@google.com>, Carlos Llamas <cmllamas@google.com>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

When running parameterized tests, each test case is initialized with
kunit_init_test(). This function takes the test_case->log as a parameter
but it clears it via string_stream_clear() on each iteration.

This results in only the log from the last parameter being preserved in
the test_case->log and the results from the previous parameters are lost
from the debugfs entry.

Fix this by manually setting the param_test.log to the test_case->log
after it has been initialized. This prevents kunit_init_test() from
clearing the log on each iteration.

Fixes: 4b59300ba4d2 ("kunit: Add parent kunit for parameterized test context")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 lib/kunit/test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index bb66ea1a3eac..62eb529824c6 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -745,7 +745,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 					.param_index = ++test.param_index,
 					.parent = &test,
 				};
-				kunit_init_test(&param_test, test_case->name, test_case->log);
+				kunit_init_test(&param_test, test_case->name, NULL);
+				param_test.log = test_case->log;
 				kunit_run_case_catch_errors(suite, test_case, &param_test);
 
 				if (param_desc[0] == '\0') {
-- 
2.51.1.821.gb6fe4d2222-goog


