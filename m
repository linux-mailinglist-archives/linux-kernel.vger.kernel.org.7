Return-Path: <linux-kernel+bounces-779250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39577B2F0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731731BC29EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442F2ED845;
	Thu, 21 Aug 2025 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVi95W7z"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E82ECE87
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764082; cv=none; b=b7FKG9TqWSXGzGPZbNh/i7qJ+8dlcN4eWEH04lyC47WLxZgqctFCYysjcpTmnfoESGNFO2vXbftmJ+5G9rcbfGzKN1UaMsv3CfquIO6rPvxe068o46sFXqBp5eWXUrJdh7LXzV/9MWuy9AvNZImNV4NbTXJ42uGKQ4b0BqXajAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764082; c=relaxed/simple;
	bh=QTf+X2xLBmpOy4zyRAuMjGmCvLxjicUtPQoHjzlz3nE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nx6x9VLQhYsLIWOXZSYrDGHSLZXxFAksfrc0GasfOBwsbE0T8Lz3geNkLHrHKuAXAUl8YEtlE4AGFzIspUXzsQ8p6U4LCnQIVCJmFaacKkEqWsChlnUuXjSzT3MxunBJF00keg+MyIpXZUbZDSCHqAneW8g6h94Kc0n1DyP8pVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVi95W7z; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso4469455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764079; x=1756368879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1WnKbqGJMz5GKuhjASXO9eryfCuYBOVak1j8VKvvaQ=;
        b=zVi95W7z0N43mgJSkA4FexmhCNi0ROKa6/bG9br7PurabWZc+YLM7aFFJEqNATA1+4
         ACRkSS3iwMmsOAU691q4VUPuVKugD4epXNmEUdf4hJzfuGI1Q2a4QWqa22ZJ1GN5+fcT
         XsaHiOf9fpYh0AdggIe8VDhUJ0Q4zII2zRIxgy+bFaE5enEK1cJL0OFkMq5ttLaspDr3
         fMOCtn/5+WkzoZVvfafrRxCX3ygphBouZxN4S2itxKkVC4AdEAUtVb4rVUFJox3t5fKy
         UPzwvm22kBJltPtZEU2/rxbhU+iW9MW/a0Y0pxxehKOdANRD/HOk0VLVggE/G6IWogTj
         ccYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764079; x=1756368879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1WnKbqGJMz5GKuhjASXO9eryfCuYBOVak1j8VKvvaQ=;
        b=EbqlEvuj6CpZkUhSTgwI8jXbV1qPXoCnlLILivw3MaIRB/kmsoOJJn7WH1q8Bj4niC
         8IgZBon2rWYHjFvC9xgayNykU++fFUFRgW+2P2GhbRKoMYgN0DKl2ouj8LoB6O0jzZLn
         MRYR+lg/7c70LT7I5BgJWQTfgbTbHdAUb7t5oOhFqKu4u+vKd93mUqMSGgfJuNLxcayh
         6PDMMexl+KLaT0tjKCOyAzPSMrUjB+ZM2xcQRPBC6lotnUXL2ohE9YT2FAqa3VcAl0tE
         LNU2AgsLIHv8XEbS6rdQon0fV97Dxl8A12GvAu4mT0dsmaeZC+TBOxdi8g3uouf8f7Zd
         urjg==
X-Forwarded-Encrypted: i=1; AJvYcCX4yzS1Ie2jscmBHNhpsZ/G1hIuCvNqvZzCmXOPf42wdYyiE5zp8k6Dw0Oin8fl54BZ9ii7kfWhYXb11no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/LurKfeHyk1aUE7TRZ6GAczww981lL2NL2rhmWtIfdsNH18B
	nnY/6k1BiD/TYfBkJMtfaUOVsbS7e2sRzfdmv0uEsjAlV6FeHyf/Xm2vEArxaXPzbk26WCHzO1S
	OvkNYQ9k04ls9AEeoBGHpdQ==
X-Google-Smtp-Source: AGHT+IGDwbMV0G2Q6eX5Ty92Ruu8G0gWgsOI3nyPGZY41v04cwU8/dEgbGIM8RR7KNaNp8Qt7tiVh+uNmLBvDtT9
X-Received: from wmbep22.prod.google.com ([2002:a05:600c:8416:b0:459:d776:c35d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e51:b0:459:d709:e5a1 with SMTP id 5b1f17b1804b1-45b4dc74ff9mr10294255e9.6.1755764079281;
 Thu, 21 Aug 2025 01:14:39 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:02 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-15-vdonnefort@google.com>
Subject: [PATCH v6 14/24] tracing: Check for undefined symbols in simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The simple_ring_buffer implementation must remain simple enough to be
used by the pKVM hypervisor. Prevent the object build if unresolved
symbols are found.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 53534447e70b..38523ea2e19b 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -114,4 +114,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
 obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 
+#
+# simple_ring_buffer is used by the pKVM hypervisor which does not have access
+# to all kernel symbols. Fail the build if forbidden symbols are found.
+#
+UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
+UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
+UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
+
+quiet_cmd_check_undefined = NM      $<
+      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
+
+$(obj)/%.o.checked: $(obj)/%.o FORCE
+	$(call if_changed,check_undefined)
+
+always-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o.checked
+
 libftrace-y := ftrace.o
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


