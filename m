Return-Path: <linux-kernel+bounces-759219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43312B1DA71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B9B18C7979
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1552652A2;
	Thu,  7 Aug 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jG2J7x9K"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B825A2AE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578557; cv=none; b=Eupx+PC0anK+shPkA7dYG2pKtW0ZTQW/h76wfceueHuz7+wV5O4EAd68uwbeDlBvQ2pSLIgOBzwLsp4hv0DXmoY29nnk+siVFO1K7LkkrO4Mew0UMwnIlPxshZ5MEqTYDn/rcGIFYmVQys7XXOJepG7HJQBeARL7xZWKZ03m4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578557; c=relaxed/simple;
	bh=HzO32Yh60OHiGqCK0y0hof+JHxVfAYcSBiCl3jE4fTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sGaZGNBbKCzWRwkc4Cd0Z5mFmdYuIZ0XGGRFEG8aOIeNVNzPmks5PvdWFJy+YPCVKKERUkUUjh1Km9U18GNeW9g3AR0SB7FVoQLaOWK1KulZNN75e09cewg1osmIBGztkmxnOTQjvfi++sRWwGGAW0MLTw8ybBC1fMrw+9gJwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jG2J7x9K; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76be7fe3d65so2411945b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754578555; x=1755183355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jcPUX/VYgPTff9JpxJ+KoCMkZRni9WiIzz7CwqMYyyM=;
        b=jG2J7x9Ko6Bl9VJUiMoAP0SksmlsYMO4W4VyqhRyUj8ENEwJNkNqjpDwQet3w1cWRF
         GM1/QyhJ6dYDBy5ISo11QnmLHVJmb4bLKRclnIxdFzQOCY/Pe2dW6fapoFv4yt7U3cxg
         Kpp/o9f2DD2ZNlh/bFvzFiaaygZyzjTvVMEdexEbpoNOC1EYlN8vqlbCgbx8+D4oZr/B
         aurA73yalP+3x+nn7F3cCmdYg7pws0NRAWAv1Qxl3JMY0o5IGIATV+qLD5q+btNLwX60
         FZwnDJD+SzdTyYS/NMC1QSZzn9Qo8uWvKq25RATlaZHh41dO3EsJq9u4sT5jN7SUmIVJ
         RT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578555; x=1755183355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcPUX/VYgPTff9JpxJ+KoCMkZRni9WiIzz7CwqMYyyM=;
        b=n26QHTR1ST0y8nyg8ZcUZLXqFwSFC9sg0bcwwJFxpOPGzl/xTrwzlMt4mMUTPOptNG
         vF1xsdoxvYlMS+ADhq3+VpjzZMZK8G37j90It2T6cj6CdPD/cob4sUZXcfn1VyFTChhO
         I2Y8cd6l3LohzFzBdsTd0co7rtm9iqxJwvTGrQrnhn90Ldpta+L/G+jt2CoxxeG6L17u
         5WEn5JlSEyrEGgz1uKJDELMRRkNN2aZQLvNlVuFV4VlW71wg/MtzmdYgTiQkpobTwZEW
         8kt85A0+sZkkQotfQeIz/qy9GUlwwwPGLpoMPIunZARJfOUBN8L+USwsrQ0a+gXNhAxq
         5/YA==
X-Forwarded-Encrypted: i=1; AJvYcCU54zsI89KLXSajHF9i8ATsgumyI5tddg/lDmUqwgtROZPVPLPx7xkSppmtZ9fruG4in6WeQYW/bpcHtWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKt+oiBDCs+Rs7VUhdjZkDO9H1BN1JIlNoflwXK3OwSE302cA
	sW3cvjMPHE9q80vXLGnITSN0ibFsS6O6JjTsH5SqhOJWpCGvTesgq3UNTs+DVI5lQ8DP0xNs79h
	VBA==
X-Google-Smtp-Source: AGHT+IHc4dZo6OEZz4pfAIClf+43hYuDLq9SKAoDuZay4FDjK25R8yRQgDScapgc5Lz+rs0x/IGp+47yZw==
X-Received: from pgbcz7.prod.google.com ([2002:a05:6a02:2307:b0:b42:fe:62e2])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328c:b0:234:8b24:108d
 with SMTP id adf61e73a8af0-240313b0ec0mr12184119637.22.1754578555276; Thu, 07
 Aug 2025 07:55:55 -0700 (PDT)
Date: Thu,  7 Aug 2025 22:55:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807145550.1837846-1-wakel@google.com>
Subject: [PATCH] selftests/futex: Skip futex_waitv tests if ENOSYS
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The futex_waitv() syscall was introduced in Linux 5.16. The existing
test in futex_wait_timeout.c will fail on kernels older than 5.16
due to the syscall not being implemented.

Modify the test_timeout() function to check if the error returned
is ENOSYS. If it is, skip the test and report it as such, rather than
failing. This ensures the selftests can be run on a wider range of
kernel versions without false negatives.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/futex/functional/futex_wait_timeout.c   | 11 ++++++++---
 .../testing/selftests/futex/functional/futex_waitv.c  |  8 ++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360b..323cab339814 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -64,9 +64,14 @@ void *get_pi_lock(void *arg)
 static void test_timeout(int res, int *ret, char *test_name, int err)
 {
 	if (!res || errno != err) {
-		ksft_test_result_fail("%s returned %d\n", test_name,
-				      res < 0 ? errno : res);
-		*ret = RET_FAIL;
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("%s: %s\n",
+					      test_name, strerror(errno));
+		} else {
+			ksft_test_result_fail("%s returned %d\n", test_name,
+					      res < 0 ? errno : res);
+			*ret = RET_FAIL;
+		}
 	} else {
 		ksft_test_result_pass("%s succeeds\n", test_name);
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index 034dbfef40cb..2a86fd3ea657 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -59,6 +59,14 @@ void *waiterfn(void *arg)
 
 int main(int argc, char *argv[])
 {
+	if (!ksft_min_kernel_version(5, 16)) {
+		ksft_print_header();
+		ksft_set_plan(0);
+		ksft_print_msg("%s: FUTEX_WAITV not implemented until 5.16\n",
+			       basename(argv[0]));
+		ksft_print_cnts();
+		return KSFT_SKIP;
+	}
 	pthread_t waiter;
 	int res, ret = RET_PASS;
 	struct timespec to;
-- 
2.50.1.703.g449372360f-goog


