Return-Path: <linux-kernel+bounces-758839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2CB1D47B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F351627197
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACC0256C87;
	Thu,  7 Aug 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6/ZhOnm"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2BA221F13
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556649; cv=none; b=fQfhZzNLliytSUclmOJ5iglisLE/wMAshaSnKNa1b0cLTUlstjRDGvXMJME63MV/UC/tX0CovFhcW4tZVLZ8CYci+g6vvUlrp7JrtIvn0QAxK3NrDQu5/LT6j4+SN4vgvfuD4BIoxd+0DpqMaPvgIFz3EVDap18AEP+6pE6Y3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556649; c=relaxed/simple;
	bh=FwhFes50Tn7NJQfQMP0GASIlWrGFxqp9/xLR3m4889I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YpG6leVTEL4GTDHFgMah1EWCw9Cla6Ng0Tdh8jEQKqwWiSmbSzuV13PdouTLiBpRBEmUPXsUUGAd9sr7W3KEsfBcXZYDxf5Z7i/F4JSBCCmDj/i+vXhAXR/ztVg2yVSZYKJCSZ9wWeF+TK+cNCkURKq8QovaA8X73mC1ERO6XdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6/ZhOnm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400b28296fso12298855ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754556647; x=1755161447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FF2oTQU3oNxnUp2FsWYDhFwL8LdokYGJ1eqoMrwki98=;
        b=V6/ZhOnmbN8lBeNpKuPWODrNNnxff2RM6RYxKWs/w9TfdEitdMunI9ThePQChNUpuM
         iV+Tmllq6KzD/nlCKSFdzTpNwg+4dDITUJc7L9l60lb/nwjSZr99Io0k9I9tT8lVuFe5
         aWADZRYu/VcLKuXioVuuZjmA7k+eZZvg551UFy0GiOqmM8cgmzeSUR70jtd5bXhSOe69
         2caf9SrB55vLYt4dVKN3DUXPX3YJFn1Mlwg9V9U3zE1andtNSI4IPdm+BQL8yPqaSjWQ
         bzwwgBll2e9p2CFi6mr2yz6tuRC4BBaVFjlnPPvgnHbwVzt437RHwnZ7JE70V0OHsVy2
         Poaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556647; x=1755161447;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FF2oTQU3oNxnUp2FsWYDhFwL8LdokYGJ1eqoMrwki98=;
        b=nab2+m0dX14ea+D8fW9Vl+92P9rgGsonkRnIRujRHXcIT+DGLZ0lS6Xhzc2sP6Dh3S
         MglbHrm+0WH4zbA00SC68/uz89XNbE+S3THQKwt65knS50FezfLO1IrucwU2zcl0WW5Z
         SnXro+zxLpxJPSWAAVEMqdneYQhGssE/1ZxkRw6iDM3n0djd9MQguenN1IgY5JG/VBSd
         zv+3BnZJ4KOgPUtJcbZ/dVJ5FX1au6BCdPHn3382VM4yelzjCGmFtPrp3pTFKZ/Y3o6s
         adn3S93Rv5LE8+4hxYKp5ciN0RwxgIEgECaTfa8EQf118P996020PGbknBYCZxLzcz78
         Ibmg==
X-Forwarded-Encrypted: i=1; AJvYcCUprcaoPxSm0GnvdSBJ8aHSXdC3h1QSo2Hl1ccZevctnIa1ZRKeFY5tnPhL1XlWYYZHio7aIuMajmfCwzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2q/Exss4kg2H802dJbemlp4vzUBxECJ3IdR6FQuQkFCwYlvc
	sTXXzvGjLpHEQAu6D7B+J+r/hhLPWtsH1fVf/IFvchroH7AClUYqgUnlpDpsOjhUuOxGw1RWZjX
	ZtA==
X-Google-Smtp-Source: AGHT+IEh7maDHFXzzlyyjSh7c3D+bITMOC+qTmrEhkL//B6F/4b8wbqj0IR/qlWosbupwoAnhrwyx9TcBQ==
X-Received: from plha17.prod.google.com ([2002:a17:902:ecd1:b0:23f:d0e0:7e93])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32ca:b0:237:f76f:ce34
 with SMTP id d9443c01a7336-2429f329b07mr85540905ad.15.1754556647417; Thu, 07
 Aug 2025 01:50:47 -0700 (PDT)
Date: Thu,  7 Aug 2025 16:50:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807085042.1690931-1-wakel@google.com>
Subject: [PATCH] selftests/timers: Skip some posix_timers tests on kernels < 6.13
From: Wake Liu <wakel@google.com>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

Several tests in the posix_timers selftest fail on kernels older
than 6.13. These tests check for timer behavior related to SIG_IGN,
which was refactored in the 6.13 kernel cycle, notably by
commit caf77435dd8a ("signal: Handle ignored signals in
do_sigaction(action != SIG_IGN)").

To ensure the selftests pass on older, stable kernels, gate the
affected tests with a ksft_min_kernel_version(6, 13) check.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index f0eceb0faf34..f228e51f8b58 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -256,6 +256,11 @@ static void *ignore_thread(void *arg)
 
 static void check_sig_ign(int thread)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		// see caf77435dd8a
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct tmrsig tsig = { };
 	struct itimerspec its;
 	unsigned int tid = 0;
@@ -342,6 +347,10 @@ static void check_sig_ign(int thread)
 
 static void check_rearm(void)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct tmrsig tsig = { };
 	struct itimerspec its;
 	struct sigaction sa;
@@ -398,6 +407,10 @@ static void check_rearm(void)
 
 static void check_delete(void)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct tmrsig tsig = { };
 	struct itimerspec its;
 	struct sigaction sa;
@@ -455,6 +468,10 @@ static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
 
 static void check_sigev_none(int which, const char *name)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct timespec start, now;
 	struct itimerspec its;
 	struct sigevent sev;
@@ -493,6 +510,10 @@ static void check_sigev_none(int which, const char *name)
 
 static void check_gettime(int which, const char *name)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct itimerspec its, prev;
 	struct timespec start, now;
 	struct sigevent sev;
-- 
2.50.1.703.g449372360f-goog


