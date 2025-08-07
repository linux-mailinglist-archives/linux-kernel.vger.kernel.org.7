Return-Path: <linux-kernel+bounces-759155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15204B1D949
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36921585189
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CC21FF41;
	Thu,  7 Aug 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RggYHZXb"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF925CC5B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574320; cv=none; b=NDS66J0iWKfAkyBz0SIv4lSAYP54FZ2k6ORSSsddLMtqzFiP6nFC+cZORSx4oSI6ZWSCIw5KMXCBnaLTZ3xp5ADWRk5fgMrO1f45JuUaD+84q81ZxW3fm7uIiHLLQ/4TZO0Jq3UVG0483knE2x2Me50Y9Dv4r+rwy9lRgv5XGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574320; c=relaxed/simple;
	bh=pB9dB+tUtO/4LYlYlR6kWHmGOMUtI8ZY776ITXEStvc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FbfpH4yK+gpmkndPqT4+Jccr427gzeCvS9duy4ZiXJZ0l8hNYG6qjUIpWX2ipset1dreCMVjgP5lViSZi7XDpFVmmvMK6V+EMpcgFXpSOxwbEH4JzdhYRiwZYF8rsKD4tuP8svnzEvCjTfR67NPdZplYm68eZ7ntd8EQln4YIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RggYHZXb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so1162611a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754574317; x=1755179117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/fewSyHZGpfiPfOd9d5r47/z03h852fAT/gw0xzwxW0=;
        b=RggYHZXbIk0badsQFvCGntyzR495XOVhOoByxSjYZ86HSSlklv9IMAnqoSk2yOhnN2
         SvvtCUAk4BNROmSAzS7izaMZg5tUKYYhmX2EZOism18tI7dlTkT6QArFAUcd+37crYwF
         iX2JmtjQ+BAb/zW5jipxr0WAcPAz06LsRa2vudlEBfvp/wBb6aRCiNZGCTvBlbKxG7Az
         8UOy1zcl6ElrxTy4Z2EGB6YT3eZ0V6ISIU5IjpWb6rpBvx0FU4TQA6UD4P8kJEugB8or
         FipwW306FkiIuHnuyD8cAmRfj4J1Iy+Qa9/MFbXILXhXYvSDAP78ka5K0FeOzVoNzuAq
         uDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574317; x=1755179117;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fewSyHZGpfiPfOd9d5r47/z03h852fAT/gw0xzwxW0=;
        b=DJrss8l5o0c9W6uDk6lZuoCvDvFuTOYvy89BMRqGtEeKEmfbI/pCSM+3edCkf25UqP
         1I0ybsCJmDXUG0EpAQm6ZugJhBV06xbKLU/nz8V+9gVP7Sby9/23Te4fzfn06WBF9pgG
         DGUpUFPK4/2Rj0OKk56JFrKZScmpXzWL0OlLBtd8ryjuBDXqvcRrSxWMkB7x5PP90WDi
         mkm1OX1zGUV9ZLTkaXc3C7ZnLL8cU1WktPHDUcW94cGUplfZraf9YrBi8d9f9tQROMkd
         Y3tvQQGTH43kxuigdQkXN7NRjgw5TuuAPbkGX+m9R+tjhLrQt666Sci6p6zp/6EO0jnV
         gNNg==
X-Forwarded-Encrypted: i=1; AJvYcCUpq8DJZtZfUP67FvloVpL+7e/uYooyfuzqnR8VecHgBO5wPDJiWTYCALfqfFz6kO2hs7YVhS5FTUyaEi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsEP2PHmvlrIwIjKk7O/lRACGEsiqmLqpxq9uaZRsh+dnLV3y
	rhSr4/cGINssHI9rwAzRHwJYLCJ/Wed3w8Nxo8PoT+jMOcYHqJ2ar7LqcgzRWm7zAxC6pryTIkU
	XqQ==
X-Google-Smtp-Source: AGHT+IHTmZcifcgPYdTxiupks6e8yvb7k4L+nmzndnoTF3f/siVLFdHMTbDEyMEpwibyJ6wRz4yr6M62cQ==
X-Received: from pjbsk13.prod.google.com ([2002:a17:90b:2dcd:b0:321:78e7:57fb])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b2b:b0:237:f757:9ad8
 with SMTP id d9443c01a7336-242b05cbd49mr56472785ad.1.1754574316574; Thu, 07
 Aug 2025 06:45:16 -0700 (PDT)
Date: Thu,  7 Aug 2025 21:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807134510.1818025-1-wakel@google.com>
Subject: [PATCH] selftests/filesystems/binderfs: Skip tests if user namespaces
 are unavailable
From: Wake Liu <wakel@google.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The binderfs selftests, specifically `binderfs_stress` and
`binderfs_test_unprivileged`, depend on user namespaces to run.

On kernels built without user namespace support (CONFIG_USER_NS=n),
these tests will fail.

To prevent these failures, add a check for the availability of user
namespaces by testing for the existence of "/proc/self/ns/user". If
the check fails, skip the tests and print an informative message.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/filesystems/binderfs/binderfs_test.c     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..e77ed34ebd06 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -291,6 +291,11 @@ static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
 	return 0;
 }
 
+static bool has_userns(void)
+{
+	return (access("/proc/self/ns/user", F_OK) == 0);
+}
+
 static void change_userns(struct __test_metadata *_metadata, int syncfds[2])
 {
 	int ret;
@@ -378,6 +383,9 @@ static void *binder_version_thread(void *data)
  */
 TEST(binderfs_stress)
 {
+	if (!has_userns())
+		SKIP(return, "%s: user namespace not supported\n", __func__);
+
 	int fds[1000];
 	int syncfds[2];
 	pid_t pid;
@@ -502,6 +510,8 @@ TEST(binderfs_test_privileged)
 
 TEST(binderfs_test_unprivileged)
 {
+	if (!has_userns())
+		SKIP(return, "%s: user namespace not supported\n", __func__);
 	int ret;
 	int syncfds[2];
 	pid_t pid;
-- 
2.50.1.703.g449372360f-goog


