Return-Path: <linux-kernel+bounces-823845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE54B878E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66876174034
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC924111D;
	Fri, 19 Sep 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1riA2h4"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1225A659
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243611; cv=none; b=gJtvoPn4Q1GdGKV1g2BhOWKGuvMVeD1USK6vQsqWV9iK4ESNJ5dzfVga5mBnZubklhSs2n8sYc1UfWpDafiQFEWlEJcYGxrLmNnhUBqb1NrVRTD3l2Xnojw+osv5S55z6L13yFXNoiVGs0ARnB+4iqLOLM8H1Crqt8JvyeJTzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243611; c=relaxed/simple;
	bh=auDj64V/QQf5SopFijWR/IMUAn6qtFIRsS4N0dYQj5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QWT5jeSaEsKXK+k1E2oclBt8C9JfvUwa/ZLJPOph5Drm6R1BdfQz7hR//4sKymQdOPI+IKuIcCC6f9WLXoh5epKDOHqiDnVfpFAJc4bL21kBdKUbS6givK6epnXYwo35/JS6ZwbRVfzXy2hwR4m6VUcKkh3Ixc2HF6MQZNj/zYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1riA2h4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so1362492a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758243609; x=1758848409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OH/pNnK8EA9gjbd5XB2CxKFgoHiyKEJc22tQWHZ69/k=;
        b=g1riA2h4HqLsD09hXy0INwwZDKZXuGnm0I/C89gmyFZCIHrQ+cOg9pHcte6ibY2fL0
         G4xwC+rMRJigEqcJA2kckmlPeqEN98QsYEl1mSxvXG8d/OJCB8Aw1PgojavtJG21egXx
         fjAv3iymVLUaK6yuFMp6Ty5snQsIhDa6Ou9xjwaMVQ4js8BaaFdtFPiYYYciFrMt5CeA
         Xb8z+9ZHoZIyoyveYeuptCLlmhlMMGsy8HjCsiTahpMfvCZEP9m0IEe8Ts7aVb/JxZwi
         7vF/P3gaN2DlyP3/WJANUsjEMiaBNf2dO7U6iKDU4uG9+uLHh2rQjzuqmBtQQfvvEfBU
         993A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243609; x=1758848409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OH/pNnK8EA9gjbd5XB2CxKFgoHiyKEJc22tQWHZ69/k=;
        b=aEgKRygpM48aB6orMbqCGd2PDUHfC0xiFJMEf1v7cb+eb+hcL8MbZdprpx+S3ET8rh
         3EyO6mTlvVdNyi/DmN1XL4pZilbus9dEI0HFs+USfI2QRPJKUxZM0bmWIGqsddZyEuyO
         tgQpC69BH47luzfI+AWLhMuHowoRjrKeQ2s5NLEw8wjoKY0rlk+C6aBH3FPTTKAYdLBL
         a4QCsR/Ccl9V4VNQjA310szPbHkDsu8WN1SsnKrCUo3GxFZgrG/awn0hEqS4qCHGuCYe
         5I0oTxVbZWzkha/TriLIKuwPyhlEm99Bf+RzCxWIsvo3I01mx0Facr6YBgMTIrGwX52L
         yUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU52FnZb7ZrARNmp9UIFQ8rxq9uyXPz4vTivcSrXx9pIw/hMH61XpPkv6kC0cTXpI7I5w7o2ZuT8Tak0VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSP7s9/BvsYixBRZ+mIbzGwnli7Q/zsD1YmyF2VzDEIigHsNh
	y/bT4S7OG50d6fWL2Cj6lqqfC7bvSyAIo0MMShQNz0gt/t+z8VlWEkOWWAqxFq5/UVf2N+QEBqx
	dqETPJg==
X-Google-Smtp-Source: AGHT+IHsi2EjszUT3jAjgKI3JLYJtiSogDVJ76Mn3rgKOAbzRdi9ZeWvwaxOp1oFOIYATZqbqd/20ux0O7M=
X-Received: from pjbsp8.prod.google.com ([2002:a17:90b:52c8:b0:330:6513:c709])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f08:b0:32e:2798:9064
 with SMTP id 98e67ed59e1d1-3309838e23bmr1737178a91.35.1758243609216; Thu, 18
 Sep 2025 18:00:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:59:53 -0700
In-Reply-To: <20250919005955.1366256-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919005955.1366256-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919005955.1366256-8-seanjc@google.com>
Subject: [PATCH 7/9] KVM: nVMX: Stuff vmcs02.TSC_MULTIPLIER early on for
 nested early checks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If KVM is doing "early" nested VM-Enter consistency checks and TSC scaling
is supported, stuff vmcs02's TSC Multiplier early on to avoid getting a
false positive VM-Fail due to trying to do VM-Enter with TSC_MULTIPLIER=0.
To minimize complexity around L1 vs. L2 TSC, KVM sets the actual TSC
Multiplier rather late during VM-Entry, i.e. may have '0' at the time of
early consistency checks.

If vmcs12 has TSC Scaling enabled, use the multiplier from vmcs12 so that
nested early checks actually check vmcs12 state, otherwise throw in an
arbitrary value of '1' (anything non-zero is legal).

Fixes: d041b5ea9335 ("KVM: nVMX: Enable nested TSC scaling")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index eb838ebeff0f..e3a94bf6d269 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2352,6 +2352,13 @@ static void prepare_vmcs02_early_rare(struct vcpu_vmx *vmx,
 		else
 			vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->vpid);
 	}
+
+	if (kvm_caps.has_tsc_control && nested_early_check) {
+		if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_TSC_SCALING))
+			vmcs_write64(TSC_MULTIPLIER, vmcs12->tsc_multiplier);
+		else
+			vmcs_write64(TSC_MULTIPLIER, 1);
+	}
 }
 
 static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs01,
-- 
2.51.0.470.ga7dc726c21-goog


