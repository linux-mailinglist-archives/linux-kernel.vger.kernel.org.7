Return-Path: <linux-kernel+bounces-825241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A379EB8B641
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765CA1B237DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F62D4B69;
	Fri, 19 Sep 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAhRYCS0"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AC28727B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318418; cv=none; b=QH8pcyEWINWdLk0YgObkdYbfgbkehERXkmHFZGvf077opPVK0U2/W7vwm0G5z2uGrueVFk1Q/SRaaw5GHDnzKjyEdmQtEGB0IYHhzoKgFoW34QBD9MweGIP04jbxVWLXzSI24hNZFMUsLKeFgNwwZwdFgKBIErhQ5tT0AAS+syA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318418; c=relaxed/simple;
	bh=GHMlzr2FhTOv+c4T5nvr/lgKTQoMQ7IduiCxorVExs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lGrFdaDtHARvYA2m3xKnh0pf5Sf1d4nX3xKzsphf1QoMUbouoF4cKGsei5gaw9hUZZhn3kv0neuqRoZ4y6ywWwOD84w/qnnuP2qUJo7k9BocSGwF3pi/gAvkr23fi/Z8cC5c1PiMPkID53atBfRPD9/BfC3yuZRwFh+nxIS1Nbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAhRYCS0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so2278364a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758318417; x=1758923217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=R7qTTFNHE+fMvr5BObVOavYnDFvgMV9D5f5f8nLVk4s=;
        b=LAhRYCS0vE8so1Q1Ox7uRZeP+ZXLL7yyUwqmQQdBIr93jenJrkPk7xiYauOoUboF7b
         iSF3WnJ6X4bDAQ7q5tm9Y8MXfsA/M6PVLuYRv5ejYMw9gnhmGoQo2lzFx5j521ZSWI3R
         UI/iXZZvVhuo7W39B0KDvP728tWT62tYCn4caEPsQimVlGDBE+LL8K+EYft5lprHSqk3
         nypQLVnWOzg8wWaZKs7duuGj19ZwNdnS5J5q6xxGgS1ttyphn1V52LrU0Imcop/gEh62
         Hq244SZsheWMpjlGlsD3/Xfu+Vp6SRI/ZSWG2sxmhxHGM8yDTOJ1iGLNhMBSo9MJrIid
         XGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318417; x=1758923217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7qTTFNHE+fMvr5BObVOavYnDFvgMV9D5f5f8nLVk4s=;
        b=FrgbVmSZWlRIzGp3Lw/zzTC6d8a4pFBMfoHkAXOEIhviFICuFlQB39IiWqtICxG0tY
         Ppa6oEyV6vEa79W3M2+j+TuV23x+yGb5UTNHOkGXTyHlwTcAFe4xnp3mLJAUGPErnD9b
         /8ocXTynyU3TWxG8Q6fo93VJMxu7TT3m7V7D2w8XReISHp05uWsnzFbni/vFk9KP3HvG
         Ct8IyWumUz+iSAN3ne6lPF5hCsEiHasnHD2rmertL1/LtB+atFprVt8Tp/X94Nem9kar
         2LlE9Bpvu+PQhvreQbLyXfARyl6bJc52pdkWh22vmtz+7IHOc5/7YESW+Tq8ojOVqt92
         S7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZaEBF+W08hZmL2BFqh1AuPw10bH0CkXHJHlrlGl6FcCRGBAmJMGHNvbNyozVFeC0Djb/mG5AlDirq8zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLumFQw6COBPqoh5PHhaggcGQvE2aNZQpnlPOKMXtjcw9oIPnb
	RlzBM7zXGB9/CO+Qpd524hRJ3rnwySGCYuSELu428+w7rsCb0XPsaxbUjObVKUvThBxvL4iWlzQ
	/oRbMWw==
X-Google-Smtp-Source: AGHT+IEZljZOGTUraRGVdL/nj4lz0qH3PqD/86oBB8T5J7CxU479VaglC7ZnBhDO+rPG4PwvP3GFqa/EZEU=
X-Received: from pjbsl14.prod.google.com ([2002:a17:90b:2e0e:b0:32b:58d1:a610])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5586:b0:330:84c8:92d7
 with SMTP id 98e67ed59e1d1-33097feda46mr5986136a91.12.1758318416971; Fri, 19
 Sep 2025 14:46:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:46:44 -0700
In-Reply-To: <20250919214648.1585683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919214648.1585683-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919214648.1585683-2-seanjc@google.com>
Subject: [PATCH v4 1/5] KVM: selftests: Add timing_info bit support in vmx_pmu_caps_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

A new bit PERF_CAPABILITIES[17] called "PEBS_TIMING_INFO" bit is added
to indicated if PEBS supports to record timing information in a new
"Retried Latency" field.

Since KVM requires user can only set host consistent PEBS capabilities,
otherwise the PERF_CAPABILITIES setting would fail, add pebs_timing_info
into the "immutable_caps" to block host inconsistent PEBS configuration
and cause errors.

Opportunistically drop the anythread_deprecated bit.  It isn't and likely
never was a PERF_CAPABILITIES flag, the test's definition snuck in when
the union was copy+pasted from the kernel's definition.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
[sean: call out anythread_deprecated change]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
index a1f5ff45d518..f8deea220156 100644
--- a/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
@@ -29,7 +29,7 @@ static union perf_capabilities {
 		u64 pebs_baseline:1;
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
-		u64	anythread_deprecated:1;
+		u64	pebs_timing_info:1;
 	};
 	u64	capabilities;
 } host_cap;
@@ -44,6 +44,7 @@ static const union perf_capabilities immutable_caps = {
 	.pebs_arch_reg = 1,
 	.pebs_format = -1,
 	.pebs_baseline = 1,
+	.pebs_timing_info = 1,
 };
 
 static const union perf_capabilities format_caps = {
-- 
2.51.0.470.ga7dc726c21-goog


