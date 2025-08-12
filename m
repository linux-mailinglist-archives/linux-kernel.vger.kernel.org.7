Return-Path: <linux-kernel+bounces-765265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43980B22DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312F8189C22A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3182F8BF8;
	Tue, 12 Aug 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/aRAEt/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627F305E1C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016190; cv=none; b=iXuLRxH/5ZBqQIojKN2uiq9w2toekkkq48Z2V2jPzT3dv1MA8FSBOiYhMB7asSbyv0UQeu7cMy11Rkq7qsSewFv/vPvR2BJq984vn5E54gEo/xw+tVdVWDsrXJt9xZxaEV8Jv5UcFpRyyzRzzjrNMzKGRquSdhQl0Kuf7TOJLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016190; c=relaxed/simple;
	bh=7zd+1Q2nXxKRhSiNSR0nkmbGVXeZVbtHzoCniviHQwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WTetva31HbyQ5AMaxWtwWISLmyAkJ1Vfb8u6gSIG39pluRn9CBJs9LWOTzEyjyhDnrDi7WWG0FfCVKv/92VNTvq0LhGkWp1D5xXr2iJPd4kPNZJBFhbgwkfjD2BuXQgBmPugpLOXmUTyj9LfUyKVRK7n9w3vsetkll0CQHystxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/aRAEt/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7111ff9c057so78650627b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755016188; x=1755620988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZjXcxnVV61K5zKiboHXun1MZgLxE+8QryKh9246KOjo=;
        b=w/aRAEt/fTCUljWMxiyGymHnb/huFZWQvBTSIk0NfHofXHz8m0L80dToBYnztuLq3a
         lA5KKA+OnK5EiI9RKtOntDaq4mcOgtdle4O8bwxpQA80ZBWDaWU+9GuOPRkbJP2RvvG5
         rUJ1+mK9RA9bHkhfxPcl9JPltRX9DhD1W5PyVYRBwzT7/IQurMUn+3x/39GemPYCbbYj
         0z2c5UYSaX3Pyww2d3BvnnGMxx6nmk+UIlMxYHMPFCK8JiHi3NuVEJSig/gNXABUEOyC
         BfG4j7BoLD5mDumlvBu+ZRaqt7BHM5PFDiSGtFx0P0LVPGmYS4OyYVWnWtjJ9/ihGwa5
         BzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016188; x=1755620988;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjXcxnVV61K5zKiboHXun1MZgLxE+8QryKh9246KOjo=;
        b=nq1HYFZf4VYZVCkoU35tnWerDkMaswlFXoiY2XCAz2V2LeeJk8dxBwN2sv3392yVnw
         gYP8u3k5H9ppiXmjxhNGRNVnf8YQ9I/MO4O3V7/rEkIMEUqnLUxwujHUe7FSzGaXLN81
         JLo5U3FSUn+PPFv12LSEmbi2iUnsURdEIokcg41YVWyfIIHC5d/vP/Y+9zE8FF8h9DSq
         wCAE6SnWCpiyJfGJNetkwhMcSZFVAUmtOVpXmykJKB4t8KXzzOHt1O8n3p6jZPaQZerA
         cs0/QBobLAnPuMrLNFcCsYbS54Eq87XMsNH07cNY5SR7sWTnzWCa3sBC+CmnMczRHyEl
         gtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw6OnrU4e8W0IyJzi/tdmonNzTzH96ttU53XG+3vt2BekwkV/aFUNfwoFtsEvhxwe5tKghGkT4A4/TN9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAlD9rSZWbVgnsFDBNubmcjYVU/TOMHN2N4+gTFesZ77ArZNqp
	ZWXnPS2fLZWm2BWCSrf1X2ZgOiUPrcIYjqjfsZ47KMsyOv0KiV/ZSILdWk7fUlqt8+x0aD3pCLy
	9aOqBwoqUsv9i+Q==
X-Google-Smtp-Source: AGHT+IGwKwv5249Eya7pfM/i3ivAXTfbdYzSlggsR5jJH18s5NNyJ45xevu3PM8ULW+3cMiHRHBvv36PcDumDQ==
X-Received: from ybka13.prod.google.com ([2002:a25:bacd:0:b0:e91:771b:592b])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:610c:b0:e91:770d:439c with SMTP id 3f1490d57ef6-e930b77dbd7mr104378276.2.1755016187935;
 Tue, 12 Aug 2025 09:29:47 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:29:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812162920.2923601-1-marievic@google.com>
Subject: [PATCH] kunit: Release resource upon __kunit_add_resource() failure
 in the Resource API
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

__kunit_add_resource() currently does the following
things in order: initializes the resource refcount to 1,
initializes the resource, and adds the resource to
the test's resource list. Currently, __kunit_add_resource()
only fails if the resource initialization fails.

The kunit_alloc_and_get_resource()
and kunit_alloc_resource() functions allocate memory
for `struct kunit_resource`. However, if the subsequent
call to __kunit_add_resource() fails, the functions
return NULL without releasing the memory.

This patch adds calls to kunit_put_resource() in these
functions before returning NULL to decrease the refcount
of the resource that failed to initialize to 0. This will
trigger kunit_release_resource(), which will both call
kunit_resource->free and kfree() on the resource.

Since kunit_resource->free is user defined, comments
were added to note that kunit_resource->free()
should be able to handle any inconsistent state
that may result from the resource init failure.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 include/kunit/resource.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index 4ad69a2642a5..2585e9a5242d 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -216,7 +216,9 @@ static inline int kunit_add_named_resource(struct kunit *test,
  * kunit_alloc_and_get_resource() - Allocates and returns a *test managed resource*.
  * @test: The test context object.
  * @init: a user supplied function to initialize the resource.
- * @free: a user supplied function to free the resource (if needed).
+ * @free: a user supplied function to free the resource (if needed). Note that,
+ * if supplied, @free will run even if @init fails: Make sure it can handle any
+ * inconsistent state which may result.
  * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
  * @context: for the user to pass in arbitrary data to the init function.
  *
@@ -258,6 +260,7 @@ kunit_alloc_and_get_resource(struct kunit *test,
 		kunit_get_resource(res);
 		return res;
 	}
+	kunit_put_resource(res);
 	return NULL;
 }
 
@@ -265,7 +268,9 @@ kunit_alloc_and_get_resource(struct kunit *test,
  * kunit_alloc_resource() - Allocates a *test managed resource*.
  * @test: The test context object.
  * @init: a user supplied function to initialize the resource.
- * @free: a user supplied function to free the resource (if needed).
+ * @free: a user supplied function to free the resource (if needed). Note that,
+ * if supplied, @free will run even if @init fails: Make sure it can handle any
+ * inconsistent state which may result.
  * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
  * @context: for the user to pass in arbitrary data to the init function.
  *
@@ -293,6 +298,7 @@ static inline void *kunit_alloc_resource(struct kunit *test,
 	if (!__kunit_add_resource(test, init, free, res, context))
 		return res->data;
 
+	kunit_put_resource(res);
 	return NULL;
 }
 
-- 
2.51.0.rc0.205.g4a044479a3-goog


