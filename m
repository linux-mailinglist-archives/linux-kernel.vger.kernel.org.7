Return-Path: <linux-kernel+bounces-855003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C88FBDFE81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DA0D508960
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8C2FF676;
	Wed, 15 Oct 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gN9zCIBC"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD92FF675
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549762; cv=none; b=Bo7h5nOvmOcrf6JO+CIqlOc1LSf3TY2ZKoa8dymkwzNQMCg15YLYPy7NJnJ/Oashl5O2+W9bgypdDkWjONKuKzIVGoqH2QnVjyd5tHGOauGeCwU+OeObvldaSUnjFm9D0L/TgTpPfgH9/4pC6RaaRmTmj7D95d7is49CE+tkVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549762; c=relaxed/simple;
	bh=mbDA80snFL3oiGXs04mnQw/S40e40byfwuqq56J0Xpc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pEgs2uw7wA6ePvSOo4eJgb9xesllJL5L+cl00DVSMGah9u9N2cPs0bmlHaZT/3BkvF5i/87u3PnYwkZEPD0O44yWpsaRSHKgp92HwGauI60n3P563VXT5v+RWtd8g4teCbVS68fRxRqs4Z6gGKSwMMNzHPT0ZrBrAnq1Ns6Tb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gN9zCIBC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2681642efd9so104599685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760549760; x=1761154560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Vf7CYQLZ8T2khSs4tVHUgJfWjP0ITtqVJqnqxd/a5E=;
        b=gN9zCIBCpFhXCwNLHyUZ2wRtXvNmRiW74YqSf02K5J7YbZSJYLmDRIAtap+VX9czMu
         Za5Nn/iFWNUvhe3Yt4/IdjKrakfHse5cojbEZ4P+Ir2hEjk9Rc0w0u+huhU2JUBR51aP
         HehK8wBZitxc0FTHoKddP8RGbcFDSjKrhmTn2Cgl7qlVIHX1YTkUf3lEbs4fuaFZYZk7
         6M+8g43SLIodhNC1U3bwEqA8P4UEQG2SOa111vyy1gdkOpDQqgTC4ZMurVtINWha4KSD
         HEL76l33BVGmnLMYOIJr3cRtxrwUTBRLACn1W7ObUwl9E+2u65SQyNjOsEuShbQR0Bo4
         p5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549760; x=1761154560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Vf7CYQLZ8T2khSs4tVHUgJfWjP0ITtqVJqnqxd/a5E=;
        b=Sqo0cMFMia1k/bLiMnOEHokG0+U76J/XFHmKZmdOnt2BRsiWxzoyEg048S+bgzFvsf
         KLCbKy02qMhFVKf09Jk79Cp9MdZjvfeVCTrAMZvxQCgKoc1UR49n/NfoWPKKU0W7ybt1
         FsY0a/G63LNNpBzeGfsrsVWPGhoYLCTkaEGADvKJumcDkaWO4q7czIwkIYlCO0IGV8QF
         HosYUCiPldVtjN3oGP4b6KWiOcRyHZIF6c4onq/NeJ2SXuRr6jZDmMAk5MoVDwcDZ0yg
         oScUqiIEUqUs6bWqhtnU6XqJ1mxbr/9sX2yAOSMfjk6ouYy0rhRjDCMCUVXo1R7NnlWd
         CpeA==
X-Forwarded-Encrypted: i=1; AJvYcCUfThbiVGOFeXkfIz2gvhnPfQA4UK2S7DZ6TIIUq7AncVAhPwXvjGyI7RcQ0cap5nvAMrG74VLEyS6lQog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXCbtVN46JTuvjk0Cj6UbU4fOrREzX+qF8c146FrsndRhS6wz
	5s1gObbtSUklz0pYQjcw0pa7Pbs05ZZiOJvI989qnYifnCcaRQrmZoPZWxQeB8F9Jgd5ydW+3BS
	L+Wp4r3kb7GcYjA==
X-Google-Smtp-Source: AGHT+IGmS3fdbxk+CJsxL3zMHrZNty5uIRZn0jBvT3xaSuGIjjofy0AJaW5jDxD6rJRExzRz4BgvYksD/sHAHg==
X-Received: from plly14.prod.google.com ([2002:a17:902:7c8e:b0:248:7327:44b8])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f691:b0:259:5284:f87b with SMTP id d9443c01a7336-290272b2b34mr414257425ad.16.1760549760033;
 Wed, 15 Oct 2025 10:36:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:35:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015173556.2899646-1-cmllamas@google.com>
Subject: [PATCH] selftests/futex: add newline to ksft_exit_fail_msg()
From: Carlos Llamas <cmllamas@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

This was missed in commit e5c04d0f3ea0 ("selftests/futex: Refactor
futex_wait with kselftest_harness.h") while replacing previous perror()
calls, which automatically append the newline character.

Fixes: e5c04d0f3ea0 ("selftests/futex: Refactor futex_wait with kselftest_harness.h")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 tools/testing/selftests/futex/functional/futex_wait.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 152ca4612886..4cd87f2a3422 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -108,14 +108,14 @@ TEST(file_backed)
 	/* Testing a file backed shared memory */
 	fd = open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
 	if (fd < 0)
-		ksft_exit_fail_msg("open");
+		ksft_exit_fail_msg("open\n");
 
 	if (ftruncate(fd, sizeof(f_private)))
-		ksft_exit_fail_msg("ftruncate");
+		ksft_exit_fail_msg("ftruncate\n");
 
 	shm = mmap(NULL, sizeof(f_private), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (shm == MAP_FAILED)
-		ksft_exit_fail_msg("mmap");
+		ksft_exit_fail_msg("mmap\n");
 
 	memcpy(shm, &f_private, sizeof(f_private));
 
-- 
2.51.0.869.ge66316f041-goog


