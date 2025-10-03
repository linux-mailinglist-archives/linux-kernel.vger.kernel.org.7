Return-Path: <linux-kernel+bounces-841340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4BBB70D2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9F1AE14E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD8283FEA;
	Fri,  3 Oct 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhCXOlXR"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893C1B6D06
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498759; cv=none; b=kwDMUxYmjs1NBAo+DD9L8q2nf00k4n3txN/iVzNGmLdMcbe7vPeZZCWV2DAdOMGxPbv9NDSlrpJuNNHymV3RuWVkeEzeRcmiGcFrZoEUSn7xa8QSHKle155z+ROQgWTBseq4pL59K7VvJHHuhLa0cla83ZQ3Zv22r1hteleen6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498759; c=relaxed/simple;
	bh=0GoKLpSdS6ldxQXPbUu3GD19jDi+5YDA57nA2CXdDXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4pDtpSjMdx+bt6pEr0i31DjzGvn88uPrfBD/D/9pD/87pTiNrv+nWmjtlvxeBeyAVc41I3JVgdpUjB1Mdr4XeV4rIsOam0yFvgYDWIwb+IaHjPb4kzKYfRGxLeRWnEptY9dr1kpizpC/xAoU9mD+MsOMGCPSwlgKRIiD2kvKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhCXOlXR; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso1041319f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498754; x=1760103554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCcr65sPLORj627Lp0bpZGMol0uaDnoIgHQtYd2TdNg=;
        b=NhCXOlXRiizWQiOP5srFfv0kvtMw2WiUZcvdnDrlX+zi7Za1RHuu9ONcv7XWfuucVp
         oEdHWjb+Dew3pyuFRuDu5BD/7ZnwcKuUvBSO/qYJWQL01f3DIh3/WLEGVA690Tkvx1xG
         YvhHyNBI3EdRCU2k6YuORbgii30NcwshUHlLaTntF2mx454qY4pfYDbrAH/w8z1lz0hh
         zNA5a/VLfBaN5Pv/OkFEHzEu8IYCTwirQ/c5H8TR9afHK9bicQlZLbyU+ZYjcb0lPey+
         h1xaGcm/dpwkwvz4YhRKOsz6QzCBU7KwiCv7Y7+uNhZRoL1wwgx7uRtSoQ7im6xuTZHL
         +8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498754; x=1760103554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCcr65sPLORj627Lp0bpZGMol0uaDnoIgHQtYd2TdNg=;
        b=BMwo8FeC9zgEjr/HEHk7uKrKEHJdJh2vcJeSl2UN5Pw8mb30mlbQHXw2WfquDLJBA7
         DpZIW/G3vL8Z4Aw18GqNZlmUTELsqXboRPhEkc/8bmq9uwWNBLDHV7WYUX96kXMNYS6N
         4wkJW7quJRYm6DXMBl1bHt1RnRjq3JfxJoeVLqEEl+vgAGmWSWLH/mk+QYIYAnrwqUb2
         7tFbQkA74qKS4FSyDgxX/DAd9M3wYBGr+RNnQ+S7PQeG8IzVEME/GusPKNKWoICRVHAM
         /pS3oV+fVHlK8OEZS4BLQ+BJqnXZ/jmdOdlTPRIYx6LS7brYlpAZ45qNWEu2oOsLdUIO
         6iNA==
X-Forwarded-Encrypted: i=1; AJvYcCVIduL1UV6wF2K9GWVVjEpZ502XY0EDhu0KKyYHCv695NS1HDeL1aSat+LFYMbaHt39ANInx+3CGIhvjIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+Hi7col26Bu+ZTvs7Z6TwRXKKThLLEH5tLDuNoGmvfg+tNjA
	V6Epz7eXjfL+cbjCxOIMZcgaJFz7YClGUUn1ueTf4yecXbxVCFg6VtEpZ3M+gG2jV4EdpDEn6aC
	kONJk9D/z/giaSEEpRYPK2Q==
X-Google-Smtp-Source: AGHT+IHQ12IlCfmMAydiKBsHPD9Q4iJr8SeYEXmAn4PmVdl5+Rxkjar+IUCHmSelDg/tdXKzfnSMs19tRFdbpfxM
X-Received: from wmdd3.prod.google.com ([2002:a05:600c:a203:b0:45c:b62f:ca0d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a9:b0:411:3c14:3aa1 with SMTP id ffacd0b85a97d-42567139debmr2038918f8f.3.1759498754083;
 Fri, 03 Oct 2025 06:39:14 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:15 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-19-vdonnefort@google.com>
Subject: [PATCH v7 18/28] tracing: Check for undefined symbols in simple_ring_buffer
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
2.51.0.618.g983fd99d29-goog


