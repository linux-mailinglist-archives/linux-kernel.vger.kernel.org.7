Return-Path: <linux-kernel+bounces-748240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C06B13E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8189B18C03F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37CE2750E5;
	Mon, 28 Jul 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbbOjAEP"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B89C27281C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716381; cv=none; b=qCJKZeOkqoL7VgKRKsSYq7U64ZM1gJpvVpzf90szQbR4a2ztmwNluwlX6KLezPi8g02WKqR3RIDwhBPjXbd9MNuEmj/UrMRb9keOkQlOb5e+l2bPa263g97Pbrf4mQb/xmwQaIXISrIpmNm2JamdOhTYJbcVrL5af8aQlXDc0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716381; c=relaxed/simple;
	bh=XPi5UctYPQ6iqqxChHrb+I2GOcd/h2cPlC/uujMzXF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s1s7zZv8h80hQa/dMedl6DSIJhr9d01IBNdKQO/IKqRM1QpBf+UUUj6lFcQ+hot6hgd37nCMKs37NLliqg4ApA0ERJt9CC6hlV8V/Q9Tx5jyi4w6Wz5e3aMC/+RVrmqdTZgDMB5IpIYHiNGIiNSo70XaR0R/qFuEoobQQVf1FBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbbOjAEP; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b780da0ab6so1100997f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716378; x=1754321178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFjnsgZ8ZjgFIrgBqo3fRpKhi5jRt02tyhhsiWaGr2M=;
        b=NbbOjAEPeEI6Rp6i5Mb2FOLLykoJD9mMPEgrg4SdKtE0Wgyiz8PPC0cjDB1tpdLcbb
         jMqfgg9zH0GMrr3CSQMI1LdmqsrvG2D2cfRn9Nt0/I0S3gDAlqHa59Eppz5meI2zq6kQ
         1jjmDbIi0PeSlhx4K+aEhbaB3MEO77qS815mZwGsGkhFVJlv2zHAPVcT9q3h+PfHjGXM
         FM5gmoBYtOkuKvb9qqJTphzHb+CAAgcLaQb4ls5D1JFXTgnyuhKSVzS1ggAB0g596cVp
         SrSUMMFzdBAZGTC9bl1otDLMYdUqXl/FChaTGYGdEmv1kdmFU4H+VUY4YQc0fzzz/Pdm
         tg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716378; x=1754321178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFjnsgZ8ZjgFIrgBqo3fRpKhi5jRt02tyhhsiWaGr2M=;
        b=vq+GHeOrEHrOZiNpRmNdh8AiURl0P8t0PSK6FoHXLsAN2NH0MFsp16gJxSlw5/8Cw/
         Wd4B4koiyHrEQVP/R+wAMulxdNGm8TaQeUpMJgu8Piz6Y6t66uus/SCyU/PohJ9yT5RT
         w6ioDoEcCerEfoYJuV8bC9JU8k2JmMTCDHSB4ID9N4F2ILblc4P4UL6RXUm3n/rZ5Mai
         +KKCCp1mNLfvrC9TQrrgR1nt88EFy/PmlUXwNPADksio1kij6XEfLnPAJ4ALlDJR6Vy4
         kKg0jeseQrUaZnzH1t1oFOS8dYSeahqMjDcXbNJ2S7GvOwd7lVjMjyd6fKqyBIGPn3LE
         oG7w==
X-Forwarded-Encrypted: i=1; AJvYcCUYxh3uMhXulknrPPM9fELU85S4itWcAf5Pm14+Ur1khAmAw28aOlLmeoILdszVyYivL7JZiYXp+OWbS58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpe4lQs4UBtND9cWUOWw13Rmy/tWtWxAsmOJxThaw2xzZdC8G8
	E7bOlqewq1EHIagHOopuhB7LKJ2P6mh+Q1epnfPVGJkDf+9phvzMrHdbVtvjlDOnHf6sAlprmy5
	bgANqxA==
X-Google-Smtp-Source: AGHT+IGq4PQHv8VDaJwxvJyLtWnkDr4Bb+g+30J9ik9jr47G58ggPtO0o8e9h7qgGXHBI52CNU+CGkItrv4=
X-Received: from wrbfk2.prod.google.com ([2002:a05:6000:2702:b0:3b7:844b:17ae])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2083:b0:3b7:662a:b835
 with SMTP id ffacd0b85a97d-3b77671d144mr8757417f8f.6.1753716377790; Mon, 28
 Jul 2025 08:26:17 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:25:46 +0200
In-Reply-To: <20250728152548.3969143-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250728152548.3969143-9-glider@google.com>
Subject: [PATCH v3 08/10] kcov: add ioctl(KCOV_RESET_TRACE)
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Provide a mechanism to reset the coverage for the current task
without writing directly to the coverage buffer.
This is slower, but allows the fuzzers to map the coverage buffer
as read-only, making it harder to corrupt.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 - Update code to match the new description of struct kcov_state

Change-Id: I8f9e6c179d93ccbfe0296b14764e88fa837cfffe
---
 Documentation/dev-tools/kcov.rst | 26 ++++++++++++++++++++++++++
 include/uapi/linux/kcov.h        |  1 +
 kernel/kcov.c                    | 15 +++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 6446887cd1c92..e215c0651e16d 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -470,3 +470,29 @@ local tasks spawned by the process and the global task that handles USB bus #1:
 		perror("close"), exit(1);
 	return 0;
     }
+
+
+Resetting coverage with an KCOV_RESET_TRACE
+-------------------------------------------
+
+The ``KCOV_RESET_TRACE`` ioctl provides a mechanism to clear collected coverage
+data for the current task. It resets the program counter (PC) trace and, if
+``KCOV_UNIQUE_ENABLE`` mode is active, also zeroes the associated bitmap.
+
+The primary use case for this ioctl is to enhance safety during fuzzing.
+Normally, a user could map the kcov buffer with ``PROT_READ | PROT_WRITE`` and
+reset the trace from the user-space program. However, when fuzzing system calls,
+the kernel itself might inadvertently write to this shared buffer, corrupting
+the coverage data.
+
+To prevent this, a fuzzer can map the buffer with ``PROT_READ`` and use
+``ioctl(fd, KCOV_RESET_TRACE, 0)`` to safely clear the buffer from the kernel
+side before each fuzzing iteration.
+
+Note that:
+
+* This ioctl is safer but slower than directly writing to the shared memory
+  buffer due to the overhead of a system call.
+* ``KCOV_RESET_TRACE`` is itself a system call, and its execution will be traced
+  by kcov. Consequently, immediately after the ioctl returns, cover[0] will be
+  greater than 0.
diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
index e743ee011eeca..8ab77cc3afa76 100644
--- a/include/uapi/linux/kcov.h
+++ b/include/uapi/linux/kcov.h
@@ -23,6 +23,7 @@ struct kcov_remote_arg {
 #define KCOV_DISABLE			_IO('c', 101)
 #define KCOV_REMOTE_ENABLE		_IOW('c', 102, struct kcov_remote_arg)
 #define KCOV_UNIQUE_ENABLE		_IOW('c', 103, unsigned long)
+#define KCOV_RESET_TRACE		_IO('c', 104)
 
 enum {
 	/*
diff --git a/kernel/kcov.c b/kernel/kcov.c
index a92c848d17bce..82ed4c6150c54 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -740,6 +740,21 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		return 0;
 	case KCOV_UNIQUE_ENABLE:
 		return kcov_handle_unique_enable(kcov, arg);
+	case KCOV_RESET_TRACE:
+		unused = arg;
+		if (unused != 0 || current->kcov != kcov)
+			return -EINVAL;
+		t = current;
+		if (WARN_ON(kcov->t != t))
+			return -EINVAL;
+		mode = kcov->mode;
+		if (mode < KCOV_MODE_TRACE_PC)
+			return -EINVAL;
+		if (kcov->state.bitmap)
+			bitmap_zero(kcov->state.bitmap,
+				    kcov->state.bitmap_size);
+		WRITE_ONCE(kcov->state.trace[0], 0);
+		return 0;
 	case KCOV_DISABLE:
 		/* Disable coverage for the current task. */
 		unused = arg;
-- 
2.50.1.470.g6ba607880d-goog


