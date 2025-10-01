Return-Path: <linux-kernel+bounces-838283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626F0BAEDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88ED1C6BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2E19F12A;
	Wed,  1 Oct 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTYcjf2y"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14110186284
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759277742; cv=none; b=kM5cL0cp69Xjo+8r8H/fXlDqB+kbCCCOs0dDVmoUzX0WfN3h02YW+fT0UvalscDnXP9gqCam1gxdMlNIfqDCeKBWLPwxiKz0FaSsaQ7TtOFseBB7j3SY/cujsO8HNCJ2DJMqt7Yn0X8pEsJW0PqhGnxfmWMBGnAexNarOIVGJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759277742; c=relaxed/simple;
	bh=Kducq2ZeSjXYvGI/ghOcZsk4NUusB8RxSwzsVgzEpgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V10YsgoY6j7bzYlwfDiMRqu6EX4xIWOd+72ga1AS29QK01Syg41guIlYHNV1TB7cPj6i2SjG5QxecIM4SLxia510/iuOdT491uqCHYwsVohla28j/SXQzcPT+TIFrAaOHup3nnQpOthIF0ea0WjGipj+x3w8HtN6Vv1cslM69Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTYcjf2y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-269a2b255aaso117821455ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759277740; x=1759882540; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcYitO65fM6U+2guQlIxnINa19j5zqeVtzHxSXLQKIA=;
        b=PTYcjf2yc8QM1y2Lp+iN4nMpe+n9kNDkkffxMdzj0fPBDS6XjVpE2a9Ss3io9NFAYz
         RBLGGuRj83SfFkkprgVZyY9QiTwVxQZgxMLz/AFTB3hzHjewJSEw9xsj/2djSBm7hFCo
         jciT3hYZquFauZBWnjen4a8D7hYgZoSjK7+Cj++4qOvC1maNaYO1qw1t6fuQeF5mpUeI
         +eBmKt/pSNFm43CTAvT4FYTwaJGj9JINzZ+bHHH93bEveT07ASJOcEHT0XDiR3NyEa7c
         gqYa2cV44pAVO6HPCf4MhcVncTZRQn9+VdeLlufUeHWDlV8eXLHAKMQdtYOpajAKwtNQ
         zBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759277740; x=1759882540;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcYitO65fM6U+2guQlIxnINa19j5zqeVtzHxSXLQKIA=;
        b=FVC8WeL694zlavvtDvM7K1FjYdykwK8Ad5JSy2BeE5Dvu7LCWIhwSc6XXzue74XfLE
         Q7tW2dwEwRAoGRaFVvO4Zju5zRnnI4bl3bXsv2Wb7foZO4yaBk5h7atn0oQVHCr4ws1g
         dY8GHNPOCfFXLUNSxHier79qg+aA7m/W+13XPkKCHPb9fcfFc1VraXVfUfLLAlY3JXK8
         jBOYYBqy3L1fPBv4LePDIiY0vVo18zWAdpTKDQ6TRcDWpMMasouh+rP7fZfXaL1z/hqA
         u9qi5VMpke8M4sA1fxIHgYrmahhwpk+hX5FALCyIM2us+qqgEafqHHtsrdCBIsFKITz8
         jaCg==
X-Forwarded-Encrypted: i=1; AJvYcCWsz77R3Z/I/XK/8PRT4nfArCFnyaiZHx7X1ilWBsd4Thypj379CvNeftT3t9f8ekWW4OY0BNWro88ywrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1Smbzh3rszxModPukU6VACldoATR3wdzn7gVqL12YnJBrHAW
	T6Nq7pGKDtwmU4Y1RRUVVecRgTZZyPB1Up9aM6cCglVVzI7y8MaJOyLE6hMLcI2ty7Lhl0SlGNf
	MRhXE0YtEtO3RgA==
X-Google-Smtp-Source: AGHT+IEIIEjWwhQ/2dq2CphjZTc2Klk/2tjbWkphIg3Eyh1AwnfRMWPBkeJy4YRaqzCXcKDyOONweBtc+rC66Q==
X-Received: from plsm6.prod.google.com ([2002:a17:902:bb86:b0:267:dbc3:f98d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef02:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-28e7f2eee4amr16409815ad.30.1759277740288;
 Tue, 30 Sep 2025 17:15:40 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:14:08 -0700
In-Reply-To: <20251001001529.1119031-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001001529.1119031-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001001529.1119031-3-jmattson@google.com>
Subject: [PATCH v2 2/2] KVM: SVM: Disallow EFER.LMSLE when not supported by hardware
From: Jim Mattson <jmattson@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Jim Mattson <jmattson@google.com>, Perry Yuan <perry.yuan@amd.com>, 
	Sohil Mehta <sohil.mehta@intel.com>, "Xin Li (Intel)" <xin@zytor.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Modern AMD CPUs do not support segment limit checks in 64-bit mode
(i.e. EFER.LMSLE must be zero). Do not allow a guest to set EFER.LMSLE
on a CPU that requires the bit to be zero.

For backwards compatibility, allow EFER.LMSLE to be set on CPUs that
support segment limit checks in 64-bit mode, even though KVM's
implementation of the feature is incomplete (e.g. KVM's emulator does
not enforce segment limits in 64-bit mode).

Fixes: eec4b140c924 ("KVM: SVM: Allow EFER.LMSLE to be set with nested svm")

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1bfebe40854f..78d0fc85d0bd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5351,7 +5351,9 @@ static __init int svm_hardware_setup(void)
 
 	if (nested) {
 		pr_info("Nested Virtualization enabled\n");
-		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
+		kvm_enable_efer_bits(EFER_SVME);
+		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
+			kvm_enable_efer_bits(EFER_LMSLE);
 
 		r = nested_svm_init_msrpm_merge_offsets();
 		if (r)
-- 
2.51.0.618.g983fd99d29-goog


