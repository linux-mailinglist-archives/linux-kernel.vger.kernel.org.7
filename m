Return-Path: <linux-kernel+bounces-819682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC6B5BEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABEC1BC23F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F02BEC53;
	Tue, 16 Sep 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GiEOpzmm"
Received: from mail-pl1-f231.google.com (mail-pl1-f231.google.com [209.85.214.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9A283680
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060372; cv=none; b=ebjPUmqUexfGGmCv4dcM2QuaIefXfUAHVqveSQC3wTKYHWpZbKt79DT5twWmc71cAeNnKQbhMg45P/ISQOEVvYXogk2NczGv/3JmFL18msKkbGGXOgkmXVf8mVi/YGvA7yyAZsHe3JXVaITQVpZe5vZEZPQQcfNNZRb+dC0OxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060372; c=relaxed/simple;
	bh=Dlk+Oewhzc94sbibKhlkOgC+Y4VS05JHCp7u906DoAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbBTaJFn9ILCHPGxmfgfohAgTA+qLFAj0WqL3p12yFiDmjJcIvUV47/P2FEte5LyrymOj+S54PeB20S/sjuTO9HuyZaK22j1xRLfY4+AuOakG3aApaYng6+/BYHPpUGF/fw21NRAIt1Nq2BfoXsUGXVFlh2qKXrMqWy2Daw6K+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GiEOpzmm; arc=none smtp.client-ip=209.85.214.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f231.google.com with SMTP id d9443c01a7336-2445805aa2eso53377215ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsZQAdC9OI0Rh5GwGUr4F2H2VDgxQJ1oYUQ+4QI9neI=;
        b=GiEOpzmm146jS+vUcOSY7qfUF3ppLfDs5XrQ9048hXO9D8g3ZVFYdhcDW/VGm9YNb4
         dsNilTqG0PRzVAEC6sff0cQfMaJK0NGm2U6Ci63mO7E/T1jmO59wsHCVMcz8MmHEQOIx
         U2r9aQ9x9Z72eQ3qZ5T9hYUZq47M4ooBeJwqxUFym0PXpVhcT11Kc8pk4M1QZt0KlJQI
         muQ2fJV7oFFJZxUQYvyzlRPs4NE0c/bzzxeG0Sj8k7w5w73sXiVh3hywVU/ahfUJKf5z
         GD1Cr0CRyBN17/DFpSA6u5UlT3QNR89jtE6aC4PMpr1iGKDjK2HJwoMBDhrGYlS+w1l2
         aukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsZQAdC9OI0Rh5GwGUr4F2H2VDgxQJ1oYUQ+4QI9neI=;
        b=GeJ7qDLJ0+pLcuqP6SgA+ORjGDTaxDqJXUizUkhSWt90y/GJC5Jo7p6xMpLi+TbMS2
         smGwj8TXS9IsDyykl0jZwXvTu5LhLir4ReFc595gIiaGQVTWGMBelsQqkAGSNWLA/RVO
         8TWYX3lxdjms253HvFoSMYoH4jfgmai1AS6fZjsl0mBkQcMj1RPxV9XJW/RbZwf8VHBt
         juYT9Aah0ZAI49oAbCMDHM623CVdteKtR+crFUwgegsNJHksnRCCRfXDFKY8yDUUta1l
         qpdTwhWlxo+OqW5ay1MSNsPX6tpbQOlJXJnv52gMTR9E+bru8g3gFawifGGh7olC4WO3
         kFBw==
X-Forwarded-Encrypted: i=1; AJvYcCVaceRUO+XQ75d/hHRN9Z5PaBku9vI/p1NtR95rVi+1FUl2nH0v88ZTvEcmHYj531yBWBEVkyUPSq3FXDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hmGOYGZKxA2+6aBH8v0ZeNINee+IrHoXZ1a6FP0Q1wzSU6Dh
	G3mSJEKiRUboAZam6bnppnnVzOSIn8T+qb15P8CCOtKUff+CRsY5GVklHFsqpdsdmEtNYVwCg1L
	BnkqI/PQv9Q8ea5TVyyFPvYOIY+bcWQKeImVrF7Vrki7yP9KjsqgD
X-Gm-Gg: ASbGncuVr8nurNZtcVWllqxRViZ47qyRk4SHVg63xBkk+9ybdf2rG90d6iImXSQ5wty
	wVnVG31eENyiQZWhdQIFGdEHL5Pv96NK8iLSx6S4yxI0qV3CLDxaBMO/I8NdaAN9XX8RXPeDa8d
	AW5sTl5YAIEm+5m4HOcKLAYHGuGXkbPoyC4H+D2PBoWPZHwCB6eR2JMtPLeCcVMkKb7ljalrTwy
	pIT4eLuxGZvMOerBfiFkFlgQ/AZKXfAaLdfLdCvnGh+KZiSzmaaO4bTef0DIeT07pusqCybAyEz
	N2fejnicnuLCRtVclb+MmY6Y/VR0Zcrcs2RqP/AYsqy6mIIlVLh2BAGrOQM=
X-Google-Smtp-Source: AGHT+IGiJoUhPEuZtFF4wpQYOfXhxSk41Sg03uqDc+U/rjhi5emgbi/g/GBhLda0R/YDZKF9WeQoPhy4MKQY
X-Received: by 2002:a17:903:2985:b0:266:63de:eefc with SMTP id d9443c01a7336-26663defc4fmr95694425ad.14.1758060369683;
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-265dc1db297sm8154155ad.26.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C48DA34023F;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D4C4DE41772; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 16:05:57 -0600
Subject: [PATCH 3/3] selftests: ublk: add test to verify that feat_map is
 complete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_features-v1-3-52014be9cde5@purestorage.com>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
In-Reply-To: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Add a test that verifies that the currently running kernel does not
report support for any features that are unrecognized by kublk. This
should catch cases where features are added without updating kublk's
feat_map accordingly, which has happened multiple times in the past (see
[1], [2]).

Note that this new test may fail if the test suite is older than the
kernel, and the newer kernel contains a newly introduced feature. I
believe this is not a use case we currently care about - we only care
about newer test suites passing on older kernels.

[1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@purestorage.com/t/#u
[2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/test_generic_13.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..770269efe42ab460366485ccc80abfa145a0c57b 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
+TEST_PROGS += test_generic_13.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
new file mode 100755
index 0000000000000000000000000000000000000000..ff5f22b078ddd08bc19f82aa66da6a44fa073f6f
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_13.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_13"
+ERR_CODE=0
+
+_prep_test "null" "check that feature list is complete"
+
+if ${UBLK_PROG} features | grep -q unknown; then
+        ERR_CODE=255
+fi
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE

-- 
2.34.1


