Return-Path: <linux-kernel+bounces-847526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB7BCB19D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B53574F4606
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A372877D3;
	Thu,  9 Oct 2025 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjxrYPYz"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE31286D6D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049173; cv=none; b=H2C2FWiHFVZvnVjtDfSVnx2PjULbyqr13LjZk84P7QfqiEz9wma9AXWBmGnL6QGNbb720E2srWhraZR/3sMkNsjbDFRhSNs72L8bm3GAIQxoSXp+Qm69fa2fK60GwNQ+4n3gDOHD/B/cp3emkCaarh8NTynFy+hc7Y+S9+tV1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049173; c=relaxed/simple;
	bh=vO3VcY4Mey2uMctJTZMoPagF4nx4IJ2GM52UySZ8Zf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A9VA96DyPxKe5UrWVpjuGvvegCTqcp1ucjCJsT+N8P30GCELtV0Q0F+aN9OZ7dKUYSdSyWnI5a4RQGa4TSc0S5MIrFpsJXTXBwe1lM/Dg8IpySzrbb9lkSO3bUeZoHwevCLsvR/ly1/evFqTaS4a8+SgsMMCUmbbl7hPqfhwXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjxrYPYz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso2756053a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760049171; x=1760653971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzxaen3LvmXKcFizl4LeLbe+SVxImNGo859qacf3xPU=;
        b=gjxrYPYzh7RZsZw49TEDdjllO1KI2RJAs+nW8A1IzxhME+xBIIjYX76aXMDPI67qOu
         ZHkjU/O+ytU3BSvDrvKT0W28b9PxbVsYNHYwsAh3mC3Dit9y+aFQqfss7X7ih7HcqLK4
         dqQIYjDt37m0zR0sUsnvyiruqUpu5jVHXLR711++hsJU671IITSv5a2yF7xzK2uTD2wT
         wDa8xvmqEh+yRqhZZlkCRQxHKI23huLAXl2NnjgSi1qZIXpgeVr0cCOXAUDaXRD3GeU1
         umoZ+uLHDOoFzAOaSohoQqFY/o8XWUKf31pD3urwjG2MWZLJOb8GlufljLIvi9EI7Qp+
         83Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049171; x=1760653971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzxaen3LvmXKcFizl4LeLbe+SVxImNGo859qacf3xPU=;
        b=BpLRRy4tcYfbxqssYR3iueh0Yek6O47YhHbqUpqXaYs07pmntB9Cpa8zQPUobDr+gn
         0sZLFM5MY2qmrI+HWa6ekmDsSBMBoMyLwFixTWv8LZxBeat1dwOZRyB7msz4dqhVy3Pn
         qRQnpOS8z24dSS7x7g4/Keuc12G8H0G2b1PjUWpWQxeYHnhijkdQHYvGs2zemiisLnFw
         1iir4ZanQXJvcHjPR37c+ymoew1XUZ/Xg/UkrdQwutMks8Pm4kUbIwcV8RgB+yy+5Ofh
         IfX1jolq7edEmWsb6FmyZfJhY9H0jiezoPscLAbU9swnSX1JmZBokkWJO9ZRT/Hysguf
         4cFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVroumgWsZHi/aS/l+ge6KnE2KbNymXjAF7AhhR9FlFnco1/QbJ93oFuvrmmXTIlMXnBIZUxaUMPQjbu/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aE9LZgkSN/ltd0TZQA2EqVsdKjYoiyNHW9njmD179CLMu//f
	yXhw4iETXSy4oZH3YgudQyM9fZzsG66m/Zs1byDIh8ttbidVV11J313y+LjwFmPh8bovJn7snIz
	nNngOylr8e8iEjA==
X-Google-Smtp-Source: AGHT+IHk1hBTwXGvc/IYeBTX/VTIxFTOQhBx2eiOsk6iO5H066u3cdjiSUsOMOWCu4n3mGnCr+SkijXapbWNtg==
X-Received: from pjblt3.prod.google.com ([2002:a17:90b:3543:b0:33b:51fe:1a7e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4ac9:b0:336:b563:993f with SMTP id 98e67ed59e1d1-33b513a2456mr10758336a91.34.1760049171392;
 Thu, 09 Oct 2025 15:32:51 -0700 (PDT)
Date: Thu,  9 Oct 2025 15:31:34 -0700
In-Reply-To: <20251009223153.3344555-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251009223153.3344555-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251009223153.3344555-3-jmattson@google.com>
Subject: [PATCH v2 2/2] KVM: SVM: Don't set GIF when clearing EFER.SVME
From: Jim Mattson <jmattson@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Clearing EFER.SVME is not architected to set GIF. Don't set GIF when
emulating a change to EFER that clears EFER.SVME.

Fixes: c513f484c558 ("KVM: nSVM: leave guest mode when clearing EFER.SVME")
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 153c12dbf3eb..96177758d778 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -215,7 +215,6 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if ((old_efer & EFER_SVME) != (efer & EFER_SVME)) {
 		if (!(efer & EFER_SVME)) {
 			svm_leave_nested(vcpu);
-			svm_set_gif(svm, true);
 			/* #GP intercept is still needed for vmware backdoor */
 			if (!enable_vmware_backdoor)
 				clr_exception_intercept(svm, GP_VECTOR);
-- 
2.51.0.740.g6adb054d12-goog


