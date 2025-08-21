Return-Path: <linux-kernel+bounces-779260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D3B2F162
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16EC5A3F43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613982F60DA;
	Thu, 21 Aug 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM0UtY8/"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767C2F5334
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764100; cv=none; b=t9U9E94qp77zVrl9MJLmMNsZQNTDpLekqKOPp8Vh+8R8l/E3raijaXIfNUfb6tvK85PcmBDwRT3i9m5V5sAOJ8CqFQAuc59QS1pFBOP0y7Pg6NHYweP5ithJuE24YkHyB747r6v/6yyOV4bMlACWPGmnPYe7DnqgCSOyt8qD54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764100; c=relaxed/simple;
	bh=3KMoWYrKCS9iXFyZU23vQdmkGsH1bjakmfocPm6yigk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sM7p2yN0g0irgKwP1uyea5SCxzqHjK02h4zqTdvRZzE2EjtNIqMFHCUGsvjHjdx6VyRZtK4hUvz0bKMGBByEUH0kGn3wJN7vXcMksffe9eXzmTcZyBqwaoD3zXeyNEWxH/YoARTXS/m3M6zseNwytPXhihg5guJgM+/fCie1oDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM0UtY8/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so3703475e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764096; x=1756368896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXmeaJhI9e99CmL9wkkDfiednrjI4qTS7gtaFJx7Vrs=;
        b=hM0UtY8/PDxLvU684ct/gumgTLbeTeQm8/iI37L77iHdMsdCmx9css7YopzJmmniVO
         1R4pd6QNIM1fu1o1z9kyaLS5DRjS9Q/FN4oI2TPopv+2erXcwNtRpfVTOc0USIfFbGYv
         3yWqg2+c0mmPKsbEbF6wO56HneUz/I3aX8b727tmFomieVEKKGglITHu3HfRoaZV9zfR
         nXYnMNy2JPggizwZfD6yLr+skdPBeRYHSaJsZkH51cDuCCWbfPNrouze1Qb++Q23jcWT
         yXvrtWq/HV+NDArRW1sAYevoN/Qk46HEzFFCU3oNO1x5ukH5HzvjU3+TX5VNwCApSKNf
         QwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764096; x=1756368896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXmeaJhI9e99CmL9wkkDfiednrjI4qTS7gtaFJx7Vrs=;
        b=s6yGpjaELkEQgD3EBF2D8EaJB1vSIIvMD1Li7lskq7grCzUCxl23yhTZWT4mZBHlK0
         Zxr1PhTbhewV7zbD2GSCz7iGrcCPIdBskf/RhQiQz3v4HELZtJw3oaA6dug//9b7bbux
         OSTIHXl216Tx2BjK4fjVZ08GdmoKnGgBBDIr3psnBEh9uarBexad58TucHSbOjzoUfk6
         rSNS7w2OR9LcO5mt8MJCBh6Twoa08V1wqLj7EBRl1Xl34w7Lm8KznmiZR9nO33oYa0LC
         PdYfiYO0ncz3JTI4i/Geqj5w0XeKIFRteAXT4Cx2WLjrBPPNDH2mDdW2BhHaLpjHEuId
         BT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtlLuyLflkJfq5IGysEanbMj/EvVJjprKfoMRsy8SHbQtdvHsEIplW1jxRq0KFsHdiSsZfEyLqws6jU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPiJQ1nbPmSvvjN4XEpg6xeqUX1pum8i+ZK+fui0uZlHS4baz
	WgmPURdEBdL8mU+4VXCAvehd87JAqVPg7M04yvezRpYjJ20i437NG6UXXjXSFJt4pS3ye7sZuyO
	QkCnU/1UIONFxtUEClOPqcg==
X-Google-Smtp-Source: AGHT+IHVkLSbuPXaBGbeYxLB8Apzj2J/LjIQ1ACzqcVV+IhVmKpANZi8n0fKVREaY1XDOmHvrY0P+LX9S3g8rjan
X-Received: from wmcn3-n2.prod.google.com ([2002:a05:600c:c0c3:20b0:45b:4777:8063])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a46:b0:45b:47e1:ef79 with SMTP id 5b1f17b1804b1-45b4d869ceemr12017085e9.36.1755764096134;
 Thu, 21 Aug 2025 01:14:56 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:12 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-25-vdonnefort@google.com>
Subject: [PATCH v6 24/24] tracing: selftests: Add pKVM trace remote tests
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
index 000000000000..383ef7a84274
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing buffer size
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/buffer_size.tc
+
+set -e
+setup_remote "hypervisor"
+test_buffer_size
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
new file mode 100644
index 000000000000..679e31257d0b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing reset
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/reset.tc
+
+set -e
+setup_remote "hypervisor"
+test_reset
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
new file mode 100644
index 000000000000..4c77431e884f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing pipe
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace_pipe
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
new file mode 100644
index 000000000000..059c7ad1c008
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing buffer unloading
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/unloading.tc
+
+set -e
+setup_remote "hypervisor"
+test_unloading
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


