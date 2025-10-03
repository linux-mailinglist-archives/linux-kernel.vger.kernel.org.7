Return-Path: <linux-kernel+bounces-841351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A755BB70ED
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C4319E3252
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA82F39B7;
	Fri,  3 Oct 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgeU7H9s"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F42F1FC1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498768; cv=none; b=nDdRhcaXiT4eQxvDhmXrviBKRyuRV0HEP17ooHdhlDC/RsJPApMUj3+bZynbS+lhrb6QhaO84qnm0MUEkUpfm+H+yufTqZxJwlvJgoxguVBpuE5qQl2jlpN51U5MGLq5KkZukrkpEphvTWGC3d7PZKol7K0OCADbarWkwhARu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498768; c=relaxed/simple;
	bh=EhJlCtUGcSeWQktaiM83P9YNtXVSdRR4pDoNVCpu5bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPnP6ny7XNMYWWDvPnnBUubQOo3fmZOUdhaLiYgMrM8x08r5EkMEvFZ7VSo1RFGqMuOy4WKmVK83XJIRqSoD2zG5wg97+oh2W0jgEuospJU3ZuMpjWZ9PZwiS4b8P81ISbHh2L7rF6rs8XdY1gDBZDiECBDf6vhFD+6BIrQwPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgeU7H9s; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso11959725e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498763; x=1760103563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UM3bjOGfRXsiIqNoVQZ3XTLMtvfmMCHhcAES2xrn08=;
        b=wgeU7H9sSbsrjdJ3kHLO/aKVcmAegzUy/xfLFaWHfe+rLIfmkIkDxnh3nar4ajBVA9
         AjjZgt+gIq+P18hFGbDKF4YchbyAShj5kMOBTQESUQRrjI410WQp9Osdm7tnUniCFruL
         /CtpA97GZHe5EBtY89CaJKEH0s9dm3gdunWjQQmRg2lvtqCwClkT6LSSOAsR9upS5+yW
         EecikaBye/FAYxcB8CcYPpVwBv7NNOKfXQqlqBDzxsXSo+Nwta4gfSy1JHV1O8D3EL5e
         KEb6NtBsTDKpc+4A5egb8wWIofq126Qn54RHpWa3FhngkZt4vlxJeG+vocDTX9VFb3da
         miAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498763; x=1760103563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UM3bjOGfRXsiIqNoVQZ3XTLMtvfmMCHhcAES2xrn08=;
        b=I8Y5ke4J2cHFW5OhdhTBRYqR5YCFEhZAYdBTRtWR3+5Q8hS1TYGyYnWiwMbdkMDDEA
         nZdwSS6Zz+UDoRNT6Z4piYK9jn3ZLnz2aAzlHWNZuxlpVto5R7Kx1NnC/+gfjphzI8zO
         LsQw6oPf+q5BZP75ZLDxSU045QCBS59JhBGtkHA5tkbVgd78ADLMy2j+i8IxoD9shXz/
         DbYOnhuB/ddweIYn/ZF4PBkmo8mPhdUjTTK+VX6OMCRI7Q05pTAr1sVX4gkLfoYJoLJt
         teNwc7VgNm6DFzhGf9xID/t2wzQfRTw9e/7mOjOQgzIR8x76TD4WIcpmzjMurBDHUJ55
         hSuw==
X-Forwarded-Encrypted: i=1; AJvYcCU6X1eh2Fu3CKfmki/8IiP+7p6xHa2ccbi+83XMMPkazTPo9oUF4z5bxrPGrFklGIn2lDaunywqhbpQp0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8/UGHEoRs7KnwhTfKDjmWeWHR9KAs+Myb+NtO/sxGesFTrgU
	rHsozQsrpiYs1ZS39R3SqKmwguNxN4zLu3S4771e/KzjQTFCxq5vjh4x7qIAGLXuWzfampm7uGy
	o2B+J/iuqVWZEyR6KrhylEQ==
X-Google-Smtp-Source: AGHT+IH69tFTi6ZXKv+400BRPyLOvUgxD9vIa5eZfePSc6PtEn5y2PQMqER0DyOBvI5qOTvfVEhXP1sn9nPiGRc7
X-Received: from wmco6.prod.google.com ([2002:a05:600c:a306:b0:45d:cfa4:ce0d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4447:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46e7113ceddmr26045525e9.17.1759498763415;
 Fri, 03 Oct 2025 06:39:23 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:25 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-29-vdonnefort@google.com>
Subject: [PATCH v7 28/28] tracing: selftests: Add pKVM trace remote tests
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Run the trace remote selftests with the pKVM trace remote "hypervisor".

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
new file mode 100644
index 000000000000..2de07e4d72fe
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer size
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/buffer_size.tc
+
+set -e
+setup_remote "hypervisor"
+test_buffer_size
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
new file mode 100644
index 000000000000..48afc51627e8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer reset
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/reset.tc
+
+set -e
+setup_remote "hypervisor"
+test_reset
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
index 49dca7c3861a..00aed1c2e650 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
@@ -1,9 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: Test pkvm hypervisor tracing pipe
+# description: Test pkvm hypervisor non-consuming trace read
+# requires: remotes/hypervisor/write_event
 
 SOURCE_REMOTE_TEST=1
-. $TEST_DIR/remotes/trace_pipe.tc
+. $TEST_DIR/remotes/trace.tc
 
 set -e
 setup_remote "hypervisor"
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
new file mode 100644
index 000000000000..b63339aca380
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor consuming trace read
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace_pipe
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
new file mode 100644
index 000000000000..eb1640a927cc
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer unloading
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/unloading.tc
+
+set -e
+setup_remote "hypervisor"
+test_unloading
-- 
2.51.0.618.g983fd99d29-goog


