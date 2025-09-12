Return-Path: <linux-kernel+bounces-814347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD7B552BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AB27BEB18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BA314A94;
	Fri, 12 Sep 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPaCglvD"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E231352B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689801; cv=none; b=VHaWrbvZEpTyztpGQWF0Z07qpbpTUqPZd8Zi6b97AVSckq/3Mx9/r4LIIc29l6FiFhmHwyujOnlgy0uwMBQPw75Y2FirWDqAV+NJN+z40CqVvEUWz0r00fGGqSYXvvvT47C24Kr053PbTk1mq79cz0QGl4cGh161c5uOKVPwJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689801; c=relaxed/simple;
	bh=NvrjHXeuAnfuPGfi6BRYd0FKeUfYwLvAE3fvW1FL450=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIVplohJ2Q2LSs8xa42JJLHds9yupuv9pe84PBfE6kM9RL2pS0qLxwVUJsz9YqN8aiWVBkHuHTfBswDxlIiACh5un2uzhmJDwm2YD+Z9zehs+fFq72lPD58gTq+NprDkuXA3qSVrfH5ihBkKh07QvCTx/d5eqqycS5Ji6xa95PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tPaCglvD; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-62adfdda606so26614d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689798; x=1758294598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH4GhObM3FT55o7hGQgrlMBMoWx9IX3m3EBVgQrzYfg=;
        b=tPaCglvD3bTER4nu4P7fUsfICDLNQl5bCR5rGVyNn1s32La91d2ru3fJmK8Kp0LfY4
         Nblqh4kSwxINAIKFKDxGEM26EBUXohgDFy3fvLKAHGsGdEOXLuI7DC7Bp0hiUhNFvB3D
         TIOCxqC0wjMfk2a86ow+KvQ2h4DD5pBTvvbU11dQLDzOjFC0gLG5/Xt7TPNUOBNlEC01
         QbPA/5MK6h0bNJ7fJaXPfbqSiWBofu2T8cJ3RwTvi1m160yjV36ii3Gx7cRYYzA55D8c
         icfkdVgezVShVx6JQaUnljWYBKXT+pZr4vJcdnMh0EV8owtTs0aeP5NdmdVtcw3SBh/U
         5VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689798; x=1758294598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RH4GhObM3FT55o7hGQgrlMBMoWx9IX3m3EBVgQrzYfg=;
        b=W3+DuLMVZDOMm1WD3tZ9rykduzj5p/6RvpQiI1JvJFO3cu9P7yv1FiI3lzR/Dpasl+
         6egX+fvVpI9Abrq3rott3HcUBTrN+6JjrgeNwSop25gOc/3d5SxPCDI+jg0TIatjs+hj
         cN7aP+tluL77HGdi6P4WQgiMZlR5BYJqluCvUw4KkmcTDaR2/23608jnIII5Oz9MU2p0
         LhKvvs5+A4W66QvbS7NeEtVnH86rFB0kbqErnDWJ9mUcVjOo6h8ezzn28c1zZf8TjW7+
         V7VybzfmY33YKiPSxbTBdJSr0U0Vdu1Do1oKcXJPPfHzMgeUPJ5WygOpOM9IGm2+ducL
         S/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUY1Ftms49lSqUon6klXDLYwL8qrCx8oeyNUCqfOdXro7T1FUBzmylJlE0YR78z+Xm0ukbXeXe5ewqgwbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NDxFkXffPXVkksOAwfUhQQRt2MeoiWyWgSjwGbYuEQFFGq+I
	MxpkwJSfKfQQakvPMTEjxb5w2mpdJLng8bFATWvhiJYsiUxpsQMS7fVRvDh4HuPgQeo=
X-Gm-Gg: ASbGnct7oNa6rBWy5+egPIC6l4B2d0DjGPykZ3HFDqIwUEokO48NFVw8ZzEkqAQ6z52
	qwzhFBcd/q5eAs+LLTjW8BFcwwStEfhx3ICid05R4VlHqb5YDjQgSeauBTmJs9ZjZ0rMqQqoHdD
	XAApRADRWkzLP7GQCh1pl9a5r/jhQXmNszR3TK8tYK1qRLtsbPjPnM/cTf/C6jxbBMa7CySdEJ3
	nUbgIXVNhwfLw7nv/qE42PsLrPCk6JPSN6HKHLJLQduC1gW3qLlZ13DLGKNp73u5gNxRvh9YYks
	vuVk6ngcRZIDAQCndzyubf3cq9C7rtf/gDHO8L6mCK1MnCGDF2U5BymQCYOpprO2dpuHXLnjYPK
	na3MdrGes6ML736lVkCV30KHvfpCgta9QFJxVldI/AH1U
X-Google-Smtp-Source: AGHT+IHDbtGqslyeLn4YFWeoqnBwKggrxCYxTs3G1b8DQvW49OjHmQw5TtCHo1C0fUHoFsODFmt/wQ==
X-Received: by 2002:a05:690c:660b:b0:721:7e7:50d with SMTP id 00721157ae682-730651d60dcmr29556217b3.42.1757689798342;
        Fri, 12 Sep 2025 08:09:58 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:09:58 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 02/16] Documentation: Add kmemdump
Date: Fri, 12 Sep 2025 18:08:41 +0300
Message-ID: <20250912150855.2901211-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new kmemdump kernel feature.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/dev-tools/index.rst    |   1 +
 Documentation/dev-tools/kmemdump.rst | 131 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 3 files changed, 133 insertions(+)
 create mode 100644 Documentation/dev-tools/kmemdump.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 65c54b27a60b..1b6674efeda0 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -28,6 +28,7 @@ Documentation/process/debugging/index.rst
    kmsan
    ubsan
    kmemleak
+   kmemdump
    kcsan
    kfence
    kselftest
diff --git a/Documentation/dev-tools/kmemdump.rst b/Documentation/dev-tools/kmemdump.rst
new file mode 100644
index 000000000000..504321de951a
--- /dev/null
+++ b/Documentation/dev-tools/kmemdump.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+kmemdump
+========
+
+This document provides information about the kmemdump feature.
+
+Overview
+========
+
+kmemdump is a mechanism that allows any driver or producer to register a
+chunk of memory into it, to be used at a later time for a specific
+purpose like debugging or memory dumping.
+
+kmemdump allows a backend to be connected, this backend interfaces a
+specific hardware that can debug or dump the memory previously registered
+into kmemdump.
+
+The reasoning for kmemdump is to minimize the required debug information
+in case of a kernel problem. A traditional debug method involves dumping
+the whole kernel memory and then inspecting it. Kmemdump allows the
+users to select which memory is of interest, in order to help this
+specific use case in production, where memory and connectivity
+are limited.
+
+Although the kernel has multiple debugging mechanisms, kmemdump fits
+a particular model which is not covered by the others.
+
+kmemdump Internals
+==================
+
+API
+---
+
+A memory region is being registered with a call to kmemdump_register() which
+takes as parameters the ID of the region, a pointer to the virtual memory
+start address and the size. If successful, this call returns an unique ID for
+the allocated zone (either the requested ID or an allocated ID).
+IDs are predefined in the kmemdump header. A second registration with the
+same ID is not allowed, the caller needs to deregister first.
+A dedicated NO_ID is defined, which has kmemdump allocate a new unique ID
+for the request and return it. This case is useful with multiple dynamic
+loop allocations where ID is not significant.
+
+The region would be registered with a call to kmemdump_unregister() which
+takes the id as a parameter.
+
+For dynamically allocated memory, kmemdump defines a variety of wrappers
+on top of allocation functions which are given as parameters.
+This makes the dynamic allocation easy to use without additional calls
+to registration functions. However kmemdump still exposes the register API
+for cases where it may be needed (e.g. size is not exactly known at allocation
+time).
+
+For static variables, a variety of annotation macros are provided. These
+macros will create an annotation struct inside a separate section.
+
+
+Backend
+-------
+
+Backend is represented by a struct kmemdump_backend which has to be filled
+in by the backend driver. Further, this struct is being passed to kmemdump
+with a backend_register() call. backend_unregister() will remove the backend
+from kmemdump.
+
+Once a backend is being registered, all previously registered regions are
+being sent to the backend for registration.
+
+When the backend is being removed, all regions are being first deregistered
+from the backend.
+
+kmemdump will request the backend to register a region with register_region()
+call, and deregister a region with unregister_region() call. These two
+functions are mandatory to be provided by a backend at registration time.
+
+Data structures
+---------------
+
+struct kmemdump_backend represents the kmemdump backend and should be
+initialized by the backend driver.
+
+The regions are being stored in a simple fixed size array. It avoids
+memory allocation overhead. This is not performance critical nor does
+allocating a few hundred entries create a memory consumption problem.
+
+The static variables registered into kmemdump are being annotated into
+a dedicated .kemdump memory section. This is then walked by kmemdump
+at a later time and each variable is registered.
+
+kmemdump Initialization
+-----------------------
+
+After system boots, kmemdump will be ready to accept region registration
+from producer drivers. Even if the backend may not be registered yet,
+there is a default no-op backend that is registered. At any time the backend
+can be changed with a real backend in which case all regions are being
+registered to the new backend.
+
+backend functionality
+---------------------
+
+kmemdump backend can keep it's own list of regions and use the specific
+hardware available to dump the memory regions or use them for debugging.
+
+kmemdump example
+================
+
+A production scenario for kmemdump is the following:
+The kernel registers the linux_banner variable into kmemdump with
+a simple call like:
+
+  kmemdump_register(linux_banner, sizeof(linux_banner));
+
+The backend will receive a call to it's register_region() callback after it
+probes and registers with kmemdump.
+The backend will then note into a specific table the address of the banner
+and the size of it.
+The specific table is then written to a shared memory area that can be
+read by upper level firmware.
+When the kernel freezes (hypothetically), the kernel will no longer feed
+the watchdog. The watchdog will trigger a higher exception level interrupt
+which will be handled by the upper level firmware. This firmware will then
+read the shared memory table and find an entry with the start and size of
+the banner. It will then copy it for debugging purpose. The upper level
+firmware will then be able to provide useful debugging information,
+like in this example, the banner.
+
+As seen here, kmemdump facilitates the interaction between the kernel
+and a specific backend.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1713cccefc91..974f43c3902b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13813,6 +13813,7 @@ F:	drivers/iio/accel/kionix-kx022a*
 KMEMDUMP
 M:	Eugen Hristev <eugen.hristev@linaro.org>
 S:	Maintained
+F:	Documentation/dev-tools/kmemdump.rst
 F:	include/linux/kmemdump.h
 F:	mm/kmemdump/kmemdump.c
 
-- 
2.43.0


