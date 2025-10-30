Return-Path: <linux-kernel+bounces-879062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DAC222D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDEF84EEBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF81383394;
	Thu, 30 Oct 2025 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MD6FtfjT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37B383365
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855033; cv=none; b=L+DiruyOeAcysoOQaZK3FUvppT58yTjueogppDHRfvtypYcQ8f7QTQqKbESHJZzqFZN4XGo+Lplr6gWWOi50kovYDUyLHJsfFW55l96X9biTqQtiLrdmXZGp+PYg38KdkRXupdmAfwUQZblC4faF1TYYZfQG1FXvzZjWPzy/sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855033; c=relaxed/simple;
	bh=XFfT8gaTPEkUKYTdX1NH6w/tGb+C9eg2daMfkI8gFLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GVEpEqlo/mayG7qtgbhSeUsiiQq88l3eXAGzFZVRySNEHv9X4cR3WINfU0jZIgEToBUMCGM+5/lQ2O0sehQx1n8efG6BASoLpSEmfQ8P1kUFIAf57SRYoYbgZjtzhxO67kyBv+kEEWaJWjlb2BOPWEZdatMEDUOcQ8cMeQPtur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MD6FtfjT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so1407632a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855031; x=1762459831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=meKFn4T9FN95UHKOhoydSdUPWQIDJ02hjx7Eu38ytY8=;
        b=MD6FtfjTp9+yNMcS9CBvurnWUdRAFUDcW0CRCwNqk+MSPAXRR8H8yZYvNz/pLRMAfB
         DaI8SltrdDLg0FlhaN+//+KEPwvMDog6e2sjyPRt5GiAjGg6pKkjfaJEdEJJ5ajWJ9Ku
         yaDtrNkOncp1LDSkD6nOLyTBovbgX/SIqAEkdFQEwhSy8m//7E7QHUovbBfUhTbN6x41
         OJCkHi75yzC5NGofyi2WLqWSMawQ2YQ4594ucoMnkQPZBjcBLVHwY+AiEsg5RYrk36jE
         SGwPAIYPVN/+RxG5Jxjm0dyQ3GFQTEnWNr7Cx0jKI5K2DBhJ5kz0U3aaNqDGG0QePtCr
         Hdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855031; x=1762459831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meKFn4T9FN95UHKOhoydSdUPWQIDJ02hjx7Eu38ytY8=;
        b=moG6rT8UJwm/lgr6CtMOZ5wLloIkjmr2fOotzwxMbLl+lGOzPjsufyLde3kPRCTyfl
         X4ONVr1rJRsLkNaJmhgLVKNmbW4mlEjM9XUD+vcHfXY/+xxP+mfMPZGsnlF0S5z9jcya
         b6egRomVIXmiM2ktfYKWZ9TtA2f7XdBwD9LnArmRvcPOLfNNjG+CHwPU8SEv+nYFg2BU
         iZhK6U4RCe009AXs2A7L59Aghz7rgUMe+5R5aCwmvEN9TKJIGlrWHCyciuOy5d5dhzMS
         W0jcGL0bUiBmabgmbZZUyKQ0i/NAlOStJESU9ZcOdD77QD3HYLhqDOSyLUhFBmA9SxRY
         am9w==
X-Forwarded-Encrypted: i=1; AJvYcCXzwHyc60cEwrGUpsVZngSn+zPJNyvba6B5O4OTY2dhxr27MlHJitwk2yXDWHbXgvtYcL/uB4OpNGTbFVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzscQ2L9B9cG9hDPNB/AuXIbPxb2f8+6JyUMHD8VfpyJSW9UIz
	fyx2i7Ybb93Yp5OylouCDHOJxMH5Kx9uHMxDyo52ia47hr/MHkDU24ZDPCqknUZTE3T+17VY0jv
	4trQLbA==
X-Google-Smtp-Source: AGHT+IFHot6p8Ozw6sPTCEifBtpuZu56mTW8C+szZfak/MuPqOINRZqkxHegGZo0IYVURE2JpMgMqwrtO2U=
X-Received: from pjvl22.prod.google.com ([2002:a17:90a:dd96:b0:340:6aca:917f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d92:b0:340:5c38:3a56
 with SMTP id 98e67ed59e1d1-340830a3a7cmr1392650a91.37.1761855030672; Thu, 30
 Oct 2025 13:10:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 13:09:36 -0700
In-Reply-To: <20251030200951.3402865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030200951.3402865-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030200951.3402865-14-seanjc@google.com>
Subject: [PATCH v4 13/28] KVM: TDX: Avoid a double-KVM_BUG_ON() in tdx_sept_zap_private_spte()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Return -EIO immediately from tdx_sept_zap_private_spte() if the number of
to-be-added pages underflows, so that the following "KVM_BUG_ON(err, kvm)"
isn't also triggered.  Isolating the check from the "is premap error"
if-statement will also allow adding a lockdep assertion that premap errors
are encountered if and only if slots_lock is held.

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 658e0407eb21..db64a9e8c6a5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1725,8 +1725,10 @@ static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
 		err = tdh_mem_range_block(&kvm_tdx->td, gpa, tdx_level, &entry, &level_state);
 		tdx_no_vcpus_enter_stop(kvm);
 	}
-	if (tdx_is_sept_zap_err_due_to_premap(kvm_tdx, err, entry, level) &&
-	    !KVM_BUG_ON(!atomic64_read(&kvm_tdx->nr_premapped), kvm)) {
+	if (tdx_is_sept_zap_err_due_to_premap(kvm_tdx, err, entry, level)) {
+		if (KVM_BUG_ON(!atomic64_read(&kvm_tdx->nr_premapped), kvm))
+			return -EIO;
+
 		atomic64_dec(&kvm_tdx->nr_premapped);
 		return 0;
 	}
-- 
2.51.1.930.gacf6e81ea2-goog


