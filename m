Return-Path: <linux-kernel+bounces-752038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684BCB170B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550D41AA8513
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8A2C15BB;
	Thu, 31 Jul 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udvCQz1A"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D2221720
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962737; cv=none; b=akRKUtV++f9DvYyk53EMqAjQFlqqVdR0iuk6QxCYU2aU9W9PwNr2IzvHyh/C/FCOt58+bL6amgQySRvLgW7Se+/mEGNLveX0gOc3JlmfMaHtkV04Ft8CPWzaJOZX6H+yLIEDnhgcQVSu06KE4Dl5Bhg4YPyrSOUNqlI6MEATpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962737; c=relaxed/simple;
	bh=DA5Wdj0iE1bl4c20loy2DajEXRDOZaZO/CNEtIe+YJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKdBV+qR9rueJZG2Lci31O56Lkc/VpoHj72YjChS8FWRwuCr+Z4SHgLjTzcVIRYmaYweV0TYEpys1Zj34sdBHYjBAdCbesyCMsAdoCSnXJLmeI0WvCMwrsJSytnpwwowBntLd4kYsNGNB9rAJkfMPbSyZGW4ZgPTIjPrzOsgjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udvCQz1A; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b78aa2a113so385756f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962734; x=1754567534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TiC3uM7/D8NzErdvh0SxeDfKJcSB6iSbAQ3laEPvArs=;
        b=udvCQz1A2Ri/5WPeSNaPOdI+UukQeQyZBoHSTDfLlGptFZTlEyAaqiLqbXutwdQIp7
         LxH1Tu9CUfGN0ZtfGKmUaoAP/lxc4DaKdNUuJJdxcfu5Hj2H2MeVPYkq6wsHl6bfAyeY
         BTHQVsfhb2qGWCxAsJzMn4BgC6glzI+PmhjBBk6FESfrcS3x9dmcgxgpR4XplC9nR7Nx
         PSFvYWCAiFrRxq5/86YLNgpnaJf3JNzFI7GyouR7QyCsnDClqMiZF8HxfrLZF/xgCmpY
         ymb/6vPBs8kM6kK/gxP8Ag4Yz6TX+HvzsnlmMqV4xCCHlbXzjHE2jUcOznVSywUlptL5
         3p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962734; x=1754567534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiC3uM7/D8NzErdvh0SxeDfKJcSB6iSbAQ3laEPvArs=;
        b=L6xjsH1cgFEtu1uaEXVNeHzB0aiPDA9mLuzN8EiQjADkwwnZ3GYMYMAzFjyRgBEkR9
         G4powBqjbsHXXPBXqlbUBtXeBb8ky6fVHbLtOoXLCK34b8M/0nSlOy6suOZGQezM60GK
         Ys6cmdKvaYkOiQX476T54NigHFhFfHyKRdFc5sE/Wf0F3WFOKVSZ7iinYr22o0zniMsA
         dgYL+G/F7LhBKAwSq4V/BXKVi17eZr5TNl3bz06NRtk2VHRKHj9OYyn5Ww6y5Uto+aCX
         z//C7DCBq2SLa8qsfUIlSK86GB4fHv5DJNvQrygbkrWzrAGZ1B0kvbeFZrqrTkBV2vwA
         mDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/hbddLiiDCl1obEtiva6WvOe7Rsu1AOTtY/ncbOApPGV17PqNQUv6LPFjvV+OhvpKlE3GBuUtf+ElDNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLDe5v/UfdsAw4nUK1VNOozsDcy4hIKf8ibs4ulpigOLO7Rli
	wVo81JU1blXw3jY001qpQ6msT/0zjhzSisAxK4i7UD3g593jGwqaJHJttmHDTTUW7dlx4zMFYQT
	e48y5VA==
X-Google-Smtp-Source: AGHT+IE50+USTAaUlkTKFrYYFo7vGLTpJlsac/PeWm8p7/FHjOX1FZHvjV8SGAr24cM4epEeIUAvKRsDjs4=
X-Received: from wrbfm13.prod.google.com ([2002:a05:6000:280d:b0:3a4:eef1:dbc7])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:26ca:b0:3a4:ee40:715c
 with SMTP id ffacd0b85a97d-3b794fb67fbmr6412932f8f.14.1753962734272; Thu, 31
 Jul 2025 04:52:14 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:37 +0200
In-Reply-To: <20250731115139.3035888-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-9-glider@google.com>
Subject: [PATCH v4 08/10] kcov: add ioctl(KCOV_RESET_TRACE)
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Provide a mechanism to reset the coverage for the current task
without writing directly to the coverage buffer.
This is slower, but allows the fuzzers to map the coverage buffer
as read-only, making it harder to corrupt.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

---
v4:
 - Add Reviewed-by: Dmitry Vyukov

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
2.50.1.552.g942d659e1b-goog


