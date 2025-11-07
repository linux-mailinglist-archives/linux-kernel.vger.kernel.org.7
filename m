Return-Path: <linux-kernel+bounces-890089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1556C3F35F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB3D3B199F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2085C303A09;
	Fri,  7 Nov 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQbIUFcS"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08731B108
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508351; cv=none; b=WmYtTMYftppzpbxhnuWjWfjOUY6WjbkcMNaWADeRHwwlkzHmf9gChZUTFHJMb+v0FB15PBcFdvR1EFGPVl499K/NJOeZ1DOqKBojN31Nd1JEe6rAd0HGiwHnzth38oNjphhzDETHVn2Nh0esEn4VAeq5RPuLgfCumryiFKFK/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508351; c=relaxed/simple;
	bh=ZHgv0XyVUf17soUOjkvDCYiOOqc1mEvQ6OVYKTbRom0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNdO74Bl/JavM7EionkBWqTv8ae0QGIX2sC7IIjDotlhPseFf0263CI6r71Py3uZKZVoERVgsXESL8K41LRhMHO3c3dPJ7e67i18YH1Ds5k/jkZKySsNG40BibVfz1Vs6h4VR6MvQ1dKPKJQmtGZ75/iBvEbwosFJI0K0uWwgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQbIUFcS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429b7b46eebso430182f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508345; x=1763113145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7UYzkbDjUzYtlMfPsEM7GuX+LxgA1EETjHu3K40WFc=;
        b=PQbIUFcSAcLe5dFGPeqe1c/SSn7kXYOafC1RtaaJnM9yYGzjLJwFn1b+y0WAFkS5TI
         6ZUql9e1mYalw289ZcnAKVvyHb9oVyXi6Jj4hutGG5LL/is0jzCOp1Bia1u6gF+PV9Jc
         OVAbjtu7CkZ+VwePvFVztwTzYROmb9uCq/ZBXgf/OmIi5+AEjQZ+dNOI4R+FcykRlDcw
         Mu6+CbEr759SdPHGxzQOpeYZh6+4WFE3YoluGRKGXY91BvQCFrSTE8xyXL/8gRnLUywn
         1R9AhjUi+VVrRlthSdglKeI6XLKYCVauKXeN2H6envffIBUsTUNwwsQL3hQUCj1AZkP1
         LxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508345; x=1763113145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7UYzkbDjUzYtlMfPsEM7GuX+LxgA1EETjHu3K40WFc=;
        b=dNJ3oG3bkQ0VWWA38rMzHFzDnHO5TImpeVvqNNQcnbgpDzhrtP4ArBeWt+fe8QGB66
         GtGW0NJ/fkoBEgr1l308KpmIa9ERY8yphIZYYcQf8+d2b35NIHrVetvSgZb9lpO7PInq
         kBP35Xj9KWjca29CdxfKT63JsOHcnsWNugjUJnmoLoKwjtstLpEKg5zni4chvVcxRt5+
         0y4ItI3wh3vZXYKYInE42MDV9hC6KfprkCCbrG5gyU2TGUoa1EGKaxWsBAtmXiUCuWjk
         30iOmAeXpIemU2la+4cxtNVH/F/nBl7Ls2HifYxV6huP0w+cOF/6hSk5r8SGmepo8v5x
         A/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUQUdeEllxWAt/mwqt/8PmkX/Y1MvqDg1hDWS9SGzYO25UqSIPQSMhEf0ro30/p+//QUIIWocu56abAqZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSV049h5ejcjTyBXBa+7ZohaLDARy+N6ePCs3SE7EonbC3QKlf
	d2vSjgwD15dkqFcLVJqykixteLjApQeNJ2hqVSu4Q0yQSZvRuII6SltacE8q/DDrwJH/r1wWiVr
	7y3kjbyz6eBP9kJIDC+A9ew==
X-Google-Smtp-Source: AGHT+IF1xxIvNVjq+za+iS0+/CCqGsFriDq1UMuaYLbX3urw+8ZvGD21B5ssp613AnpHoLe+UmbdSPTlqDnoLuOO
X-Received: from wrpa10.prod.google.com ([2002:adf:eeca:0:b0:429:cb19:3f9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2210:b0:429:d437:cdd7 with SMTP id ffacd0b85a97d-42ae5aefd48mr1930446f8f.52.1762508345583;
 Fri, 07 Nov 2025 01:39:05 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:30 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-19-vdonnefort@google.com>
Subject: [PATCH v8 18/28] tracing: Check for undefined symbols in simple_ring_buffer
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
2.51.2.1041.gc1ab5b90ca-goog


