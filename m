Return-Path: <linux-kernel+bounces-775065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9396AB2BAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D93F188F189
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE930F7FC;
	Tue, 19 Aug 2025 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maoj+BJh"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DBF2EB5DA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588998; cv=none; b=XAumcEoHLtVQz0idgfkP/xwxtOitB8yEA+pvVX5TeXt5dk6qYbDcctG0lTTLWd/MmQlOwEHK3jM3avDGhBo1g1S3k8bin/s3He/hLe10aMdZB0VbEzMr4uvy7QmCNHmkXDp+J6i12ehYWS7JyDtl5iJFzKEI4iodO1rLa6lMYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588998; c=relaxed/simple;
	bh=GkLSvdY41yUuby86O5+BvOcphZ93ugVw0bEnopcPEPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R2nOuwsE3rWT1ZorQ4X7cGA7X/UzyZ9GXbH67vApQIawHji7W94nl06+zYoQt4FKyYMqtSNyC6OhzH6ZxFihE5i9d8Zcdryn3heKvl9LIBjtovPPFAG77ent2U8bT5+i5h10adID7JtOI3hl39zyBvEmsF3x0I5qIXz0mangRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maoj+BJh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2ea91aa9so8392550b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755588996; x=1756193796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KSbimSnv0XBPGJ9MxTD7jYQER3c+CloUdhjhKYZFuw=;
        b=maoj+BJhHMEqJbLCSzb43d7CK2TEvWT76dpx2blpZ7CvLAS6QkODcFNx6b8xmixE9/
         MjRv9kGTV8oRzAq+Jp28b264yypoeyNGoYOzArpesaeHJ0A05yPFJxoh3sUWQSTzDQSw
         /eVUlW8IKMIpsgw8b0OG4+/a7boedo3KLCuwMrtPmzPkr92oKtjxLKx7IKmd4V7Shz4O
         bW3tyJZs8oSwA5vmmXOvE2Sh3keZJDZXixqdOp+v04r/iS4coZNEeeUMKKtpmqSjYZWr
         9nKpkfC5Ae4g13E3KPdW4Z1zggVzrBlF2P1Kn5rrwDNVTWhBnRVNqDzo2d36glBluECM
         V4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588996; x=1756193796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KSbimSnv0XBPGJ9MxTD7jYQER3c+CloUdhjhKYZFuw=;
        b=fvLNOuz8On4GcHZi7ChhTG6K/xt5fpKa+rN48JFx03VdcJIveqWd1Ui+V1lj6wP6L6
         qaarBTTBcI8mKwQbpeWS+VV25n41BhIx6HwOB04GXT5sWsGmv98czWlYP+pGjSuw7Q5M
         hbXNVLsXVVEtqHJhml8yhi9FcLx4TBKzjAorFis8bMQMFLw96p1KfRsrk3QY7vLW5seg
         VHnJK1lYtiX7fjKD7eudENBzY/lvblJ8f1CqMycLkcB2we5aXV63JZeqKfDNZvsZpIvg
         XP1H/3X7CQEu9uWNV5zL97cXmeEaBxJVZdmRlD6TiLDYc/iSIa/YUMdQjHtinkqDdTua
         rEyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzPj7eUx0fwyZ6WN9C6dMNOCnWTvClcuV5/cgrgFqzR5s20O4rxLkMdQQPLjsJllJBR/OnQbdSr1kctCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgiGO2m+p+rRA7r2vrPQjBZP5rVXUH/kPUWpBoHpT24vLI0HAi
	c9ahYLbuq5rCCysb15HZHd20S56ZG8iKYIa+wWYRt3vVnkTks5nMaFZULa0ko7Die2rHGtAuz5+
	RtrIgboTci5/+qA==
X-Google-Smtp-Source: AGHT+IFVitRB2pYP30mQyIezEFbnNHtlcuT+1BqFK4GSPkogm0Fg1JqC4rE6PsNNNd1LADkKo8O8s6mLcTxctw==
X-Received: from pfij13.prod.google.com ([2002:aa7:800d:0:b0:765:6e59:d7fe])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2290:b0:748:e38d:fed4 with SMTP id d2e1a72fcca58-76e80eb456cmr2204859b3a.6.1755588995886;
 Tue, 19 Aug 2025 00:36:35 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:34:33 +0800
In-Reply-To: <20250819073434.1411114-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819073434.1411114-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819073434.1411114-2-davidgow@google.com>
Subject: [PATCH 2/2] kunit: Only output a test plan if we're using kunit_array_gen_params
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, intel-xe@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In 6a2a027e254b ("kunit: Enable direct registration of parameter arrays to a KUnit test"),
we now output a test plan for parameterised tests which use parameter
arrays. This uses the size of the array (via the ARRAY_SIZE macro) to
determine the number of subtests, which otherwise was indeterminate.

However some tests (particularly xe_pci.check_platform_gt_count) use
their own gen_params function which further filters the array, resulting
in the test plan being inaccurate (and hence kunit.py failing).

For now, only print the test plan line if the gen_params function is the
provided kunit_array_gen_params. Unfortunately, this catches a lot of
tests which would work, but at least makes sure we don't regress
anything until we can rework how some of these macros function.

Fixes: 6a2a027e254b ("kunit: Enable direct registration of parameter arrays to a KUnit test")
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b661407ad0a3..bb66ea1a3eac 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -732,10 +732,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "# Subtest: %s", test_case->name);
-			if (test.params_array.params)
+			if (test.params_array.params &&
+			    test_case->generate_params == kunit_array_gen_params) {
 				kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT
 					  KUNIT_SUBTEST_INDENT "1..%zd\n",
 					  test.params_array.num_params);
+			}
 
 			while (curr_param) {
 				struct kunit param_test = {
-- 
2.51.0.rc1.167.g924127e9c0-goog


