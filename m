Return-Path: <linux-kernel+bounces-889786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB6C3E83D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC913AD964
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32492BCF6C;
	Fri,  7 Nov 2025 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWWAAkDp"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5264296BD6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493398; cv=none; b=WWnjaCt6QpgPEMdL8nugM2CVvyYY8Cvwi4oMwkXXsEEiLM6k/Zn1VAWIKIos4T0/own6Wb24nQPz0p21i8EvfPudnzNcjBxnkMfTlDOQ/GRiVn6Qa/LCG3u4NcfrHvI9PUW+WZBK8dQ7ZL/yKUoZ9FLlsF4G5IdaJdFoiyz/Hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493398; c=relaxed/simple;
	bh=t/n21pSuJSr8MBIv4gg6nnfTGQhILI1Rm200T1DKUvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bmin6n5qVpxKaR2RLv8hch0IXPXAVMIKktF0YTHwYWd2TOP1WaQHolfgIPAU40lITpDD5TrocOujBP/XnMXk3aPchisgojA5XJQSkYmC0WvcllbtCtMt4bL4Uv/6b6sI/7qm11ZOGErH7PZU80VY94ocBDW8AoqlN3a2ZkMrpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWWAAkDp; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-79a3c16b276so9427966d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 21:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762493396; x=1763098196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WhJsbd8hQIgaMMcaCdsT9ge7ButLMZT3b1jbA5sMxQ=;
        b=IWWAAkDp0m/5FmGSvKI9SO/eJXKdJT0NuMn5MJv7uwCeTJa4FcFavHgumtYnojAVbg
         CzfMtpbsKZA+q0Z7lwcSnf5PH4cXfZh20SjqhctA0WuWPSaRyl9oDP7cmxbC2PKqdzCu
         wt0V6+vpQKdn52Q690uzhJucMdHqwlZJuSiFePZaK9c+Y8AH2YeKTeRv9fpfZ8avUUqj
         Q+lS50CuDlFAvN9f1qQloPskD7xbEgdQqn7V298uyflBjnHgvRAaWbsMJvVoxsN7GIla
         YtLxJc7ywyLilw/R63q/gB8uruiNTR80ZsdxPS8mPsEgzdbgL2MJcXZERVR50Ka+YFXh
         5NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493396; x=1763098196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WhJsbd8hQIgaMMcaCdsT9ge7ButLMZT3b1jbA5sMxQ=;
        b=OlasdF2/q1GlZhaN2UBIdWPOgp/LnxHE8rJi0y/VyFKF5fPZz7Rj9rchS+dHuORheQ
         68U88Trlp4MfRdvcHfL63LNXnPwJAcC8YhFwOP96oI8f21UdapcUPiM90r43x5647zJ8
         /BEPXoMCH4P759FTHEcgga7PC88/7WbH+pwWf7cP245INgiZTKQAneYADDwRl76ZY07S
         qhUEQ1KortyYVdLTwKy2sYyTC0cl40TQaB4AcgWnE/AzwMRi+rw0dqZfs0f8+SUAHVnu
         p4DNsLvhCewZbUWBzXk+cGu2CXWbgMonNGUk7DznAkwS8BgzF9I8gsowsS7LlqxxWiVl
         aKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp/QZzQQ55yO98wBuH476YUZRNX31k0lqewb50pDOPTkokUbu+qM5MfNIB2XcmD6VlLst8gvEf/FHBF4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnw9UK27essSoLYvPaRnIbNu6hKpdV3RrK3ylefqJaFMFa67re
	pwccOyqxmEV2mf4GKjziJ86WZ1WRzagQx46ELGhiyG6RG1K0re5Hr7rCNB5gWAKZUUEeBE+fLZf
	gIg==
X-Google-Smtp-Source: AGHT+IHYciVpqOb8pQto4TErUyowvJXcico5AhQjHPvT6LVTf1/3owC+ciDU1QPX5RZ1igpKDXNExBFvtA==
X-Received: from qvbrb8.prod.google.com ([2002:a05:6214:4e08:b0:880:6bc3:4888])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:d6c:b0:880:4982:3afe
 with SMTP id 6a1803df08f44-881765c5307mr25893326d6.25.1762493395647; Thu, 06
 Nov 2025 21:29:55 -0800 (PST)
Date: Fri,  7 Nov 2025 05:29:23 +0000
In-Reply-To: <20251107052926.3403265-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107052926.3403265-1-rmoar@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107052926.3403265-3-rmoar@google.com>
Subject: [PATCH RESEND 2/5] ktap_v2: change "version 1" to "version 2" in examples
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	raemoar63@gmail.com, Tim.Bird@sony.com, shuah@kernel.org
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frank Rowand <frank.rowand@sony.com>, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Frank Rowand <frank.rowand@sony.com>

Change the "version line" in example output from
"KTAP version 1" to "KTAP version 2".

Change version that should be used by compliant tests from 1 to 2.

Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/ktap.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 387062b96c10..21e1b80fddd7 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -41,6 +41,7 @@ version of the (K)TAP standard the result is compliant with.
 For example:
 
 - "KTAP version 1"
+- "KTAP version 2"
 - "TAP version 13"
 - "TAP version 14"
 
@@ -48,7 +49,7 @@ Note that, in KTAP, subtests also begin with a version line, which denotes the
 start of the nested test results. This differs from TAP14, which uses a
 separate "Subtest" line.
 
-While, going forward, "KTAP version 1" should be used by compliant tests, it
+While, going forward, "KTAP version 2" should be used by compliant tests, it
 is expected that most parsers and other tooling will accept the other versions
 listed here for compatibility with existing tests and frameworks.
 
@@ -204,9 +205,9 @@ An example of a test with two nested subtests:
 
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..1
-	  KTAP version 1
+	  KTAP version 2
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -217,11 +218,11 @@ An example format with multiple levels of nested testing:
 
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..2
-	  KTAP version 1
+	  KTAP version 2
 	  1..2
-	    KTAP version 1
+	    KTAP version 2
 	    1..2
 	    not ok 1 test_1
 	    ok 2 test_2
@@ -252,21 +253,21 @@ Example KTAP output
 --------------------
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..1
-	  KTAP version 1
+	  KTAP version 2
 	  1..3
-	    KTAP version 1
+	    KTAP version 2
 	    1..1
 	    # test_1: initializing test_1
 	    ok 1 test_1
 	  ok 1 example_test_1
-	    KTAP version 1
+	    KTAP version 2
 	    1..2
 	    ok 1 test_1 # SKIP test_1 skipped
 	    ok 2 test_2
 	  ok 2 example_test_2
-	    KTAP version 1
+	    KTAP version 2
 	    1..3
 	    ok 1 test_1
 	    # test_2: FAIL
-- 
2.51.2.1041.gc1ab5b90ca-goog


