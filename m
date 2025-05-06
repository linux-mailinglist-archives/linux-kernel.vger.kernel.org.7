Return-Path: <linux-kernel+bounces-636447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8739AACBA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 18:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A5D3A9478
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100528A404;
	Tue,  6 May 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LM8Hb4uU"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B928A1E6
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550146; cv=none; b=lE+iH6qkncXeOAjSv88toCzUIQ4pnkMJyuxOlCB99+9gNn0vCQ9p5GHMYme99yFPLMPdmhchWNrnOxa/e9lnCCmomPHPmSkUJscre6uNu101pmTnAsiyDTTDEXkhdsSjS+65XYX3fNWBslYwxSyYRrrxZwPt8IJwP+uqdb9qjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550146; c=relaxed/simple;
	bh=PgCe5Ig4Hz5VA3Et4j2ZYh+G8htR5m2rXa4V0St1e+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=caC3X62rXiHNodZUVmhDQ/E2CBeKOGpOJSZjeqI6JWQjeS0hPAE7zwfRZx7mqOQS40M9+tfKYu8oLR9UH/6yTmxTok1cuDgQhj4t5PyJgfvKT8uYPs6+PZDYhka9xoQM+unIbH08W4O1PTW6ph4zwkp5aaxHoTX3Z4d1Vw1YtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LM8Hb4uU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-441c122fa56so13740255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550143; x=1747154943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=njQ3TmZpiHbN0W0T2NSyLt6EnFI9+R+BtiPGKvCoesw=;
        b=LM8Hb4uURESSM4OGvSD+GBhMfl1CIrdzpU3rNWSN6xMzj583v+pGf1udRFmVOsDBTr
         RAWpdWvCYamC20pUSfAXtwcrba81ZLnsoM0Z47w0BUOtbngOC15UapWHaheVfIQxGZRc
         nqG0Z6dJBC94sB8U99SQtrnriqOgArYTHjH9eOOoSAzYM6ee08tj0qj/TYMKjtEDStr6
         OVeHdwRSALxbJTxWPRHExz3ivBoVdFCfmdam/0LNIAQtlBfh1/mAXVbSG6eFEVNVk/sh
         nspP86MKyvxA8tDQSqbQ7n8gUZ5FCNm1/Yd1wJkqHHHiTYbQHPxViXquhb69qy/qIGo3
         CIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550143; x=1747154943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njQ3TmZpiHbN0W0T2NSyLt6EnFI9+R+BtiPGKvCoesw=;
        b=FZ8pR0OIoaBOGGlFFbxuSdZcEjzuHpb2WA2Yyqf/jFsx4koJ1KWQCCGIgVDCJYRd1r
         YU6yE1BRzn6ByiGcrLEmgQUt58J/vi1uSgYLvmQR62GZHj/3nXl6kjTQIR4cVLnacxvo
         /4e6NWhR9zCAfBTBrQs3dC8plNA8DpPrOEQLTUPWHsLmtLLTzzXjKOuHaFqZPLat2Tv9
         D3XNYZK7gN086KmUP6TC4GyZNlpHKws6g3aoV2V6CuKfFCbSYiMs9dsNOrhdAXPQyiru
         K6ZoH8cXcOumzn1mPVaouqNsV8o1W5/ZFfc3l7pLpPJLlwwINFc7CqhPDusoJo+DYrhY
         F7NA==
X-Forwarded-Encrypted: i=1; AJvYcCXjvKJmgBErMlRJckeKGVob/W39zd9+68PqvBEIHosbGzjztP6z0ejQxh3wneTiJ5YubqJYY5dpH2uvoOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysHF8pCZlGreGkmSqj9WcLMkqmafAC69Dw4DElCQZvhXytiwha
	hKRkj0nbS3afzjlCdZ+KNOfVI/wS6PZDB3AotT7xNY3g+VEpN5RDGxD7keiHfyEaNkXD7LvkIb3
	cfpEjSiVRUz03VwelYw==
X-Google-Smtp-Source: AGHT+IHF02PKPiIhJbOE1ndD3uShLpPGP1nAp1HVPAQRz98xV5Rm4WeCONHAOCoe603i2rkE7H3ckkLeK9deDeKS
X-Received: from wmbay12.prod.google.com ([2002:a05:600c:1e0c:b0:43d:1dd4:37f2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154a:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-441d0fcc750mr28382805e9.8.1746550143106;
 Tue, 06 May 2025 09:49:03 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:09 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-14-vdonnefort@google.com>
Subject: [PATCH v4 13/24] tracing: Check for undefined symbols in simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The simple_ring_buffer implementation must remain simple enough to be
used by the pKVM hypervisor. Prevent the object build if unresolved
symbols are found.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 8f5e194eba71..a2f1489e11af 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -114,4 +114,19 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
 obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 
+#
+# simple_ring_buffer is used by the pKVM hypervisor which does not have access
+# to all kernel symbols. Fail the build if forbidden symbols are found.
+#
+UNDEFINED_ALLOWLIST := alt_cb_patch_nops
+UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
+
+quiet_cmd_check_undefined = NM      $<
+      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
+
+$(obj)/%.o.checked: $(obj)/%.o FORCE
+	$(call if_changed,check_undefined)
+
+always-$(CONFIG_SIMPLE_RING_BUFFER) +=  simple_ring_buffer.o.checked
+
 libftrace-y := ftrace.o
-- 
2.49.0.967.g6a0df3ecc3-goog


