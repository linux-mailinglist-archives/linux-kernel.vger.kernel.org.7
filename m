Return-Path: <linux-kernel+bounces-825276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB5B8B7B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C27C4E2049
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8395F2DAFDA;
	Fri, 19 Sep 2025 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aG+4Qap/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78D2D97AA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321193; cv=none; b=J6D/0zDcm5MIsQ03a5WX/WxgFGrs7E5oq/AE3K4Iu0jFnKzOO8O1e4FUPzHS4g9HiLEUt9uF78DMkT+3Ren8woeVvFR5ZxNNEEJJrFv0z0HotosTF+oWmmIzsdzLa5yeqUsVwe7tYuyRuRmuv9WJ28eDWrueqFz/IFUuiq7d/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321193; c=relaxed/simple;
	bh=elf8MHZF7Tg3/6PAVVYJVH0hX7ZeQf/uQh/GyUpYdgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p90VqTasJrmLpUF53bJ8OrnnBglLH172Yq7tXzEvfhuMQQx1IZNZhYtT9JTxtjw8hfp23yQo7BR+LJQFt1TswHwL+9eDR8uTm8qwO2VQMhWVE7C5ovxO1tWzN7s133mVlIVnblRww7F3mrZ+z4YPoQBD7Jo8DnV5EmjA+55G5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aG+4Qap/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54a30515cfso2784373a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321192; x=1758925992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2sPqYAIK/orSRIg87ZffL/J8UqaK0/FYSKXDGYvA8I0=;
        b=aG+4Qap/FQV9k3Z5A6amH3AvUAHospNxhRCZrwPswciLCnSThnSDyhIsRuuAg2zAwy
         +rS98G+fy8Y9Gk0e2Uox1mHwvuiuyTabuF9QSEVEQb0f9GEXRLQsKqqdMSPv0VhFE573
         eYvntS3Pwb1+eDGCem37SrEnknMiYA2deu7L2sUe7puME9rCC0oW0TeL8kuwdjQhwLCD
         PSJJMPCpY/WO51R/ded9DnkksbQP9A7qtAv5E4yJ/BLNRe3pTD+tSlvpyqpJYEIlFUR+
         enB/U2B0LYqnENf68fyOsa7IKeNQotgAImKZy7BHAqJ4MUtge3Cjw+TX0sdx+N1eZkce
         BRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321192; x=1758925992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sPqYAIK/orSRIg87ZffL/J8UqaK0/FYSKXDGYvA8I0=;
        b=bInPuiP2Ihr0t7pFkLshsIaExWyQXCt0VPlgci7HMX6YUHwg4eZ8jJa0prS5LuJigg
         vBnwMpme83NSB5bxYC1ZpnlS9OoFEI6EMLlVRMbKeWC/F3yLrNxYs8lIrTE0ujMFcpWn
         7d4j12p2WpOeXie0ffCEZ2Ic8551gtHFTipUPmUps/9eBJ6ct6NPFsJcMBr8glDNC2mk
         YGCo/VIGTQ/k4ZeJacakbtQwnibthWIOXqf4xzRNVSKmT82/SVrAXDcW1PCNXIYImTP4
         qXplGzSofGgTSwGdfe5RXMp0YCU7j2Z+n6qFy8nFlx/9d7tNhZNw6QJINt3gjDRUN8cs
         aNPg==
X-Forwarded-Encrypted: i=1; AJvYcCW4JYmh7jLm1cWodw4Ij5LLWEx0L1VkibfTIfZsfL/24AlJ6RUQTcdvW2a5p4fnoGmkJA/ALrP5GKuePVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3515QxmMLFvkds90nIXeqtFP6bGfhXCujZmH8hPfPKuDn+fMQ
	G7n7EJAXKgTbfrrDU5cL0GXR2b/DB1+2vg9Rv25cBJRXTwCAOYb14jBOuOYJALegpFIyAPbEdMv
	MoSsBqA==
X-Google-Smtp-Source: AGHT+IEExI68ZAm9C2IX/lnJ6H2rnMi+In6Lm+EVBdt5y8dIjnCUQiSgJu4fHq6PTe+c6f1AEd/+Jb6BBQo=
X-Received: from pjh8.prod.google.com ([2002:a17:90b:3f88:b0:32e:e4e6:ecfe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3945:b0:262:af30:e3c
 with SMTP id adf61e73a8af0-2921cafa18amr7475744637.28.1758321191678; Fri, 19
 Sep 2025 15:33:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:12 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-6-seanjc@google.com>
Subject: [PATCH v16 05/51] KVM: x86: Report XSS as to-be-saved if there are
 supported features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Add MSR_IA32_XSS to list of MSRs reported to userspace if supported_xss
is non-zero, i.e. KVM supports at least one XSS based feature.

Before enabling CET virtualization series, guest IA32_MSR_XSS is
guaranteed to be 0, i.e., XSAVES/XRSTORS is executed in non-root mode
with XSS == 0, which equals to the effect of XSAVE/XRSTOR.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4ed25d33aaee..d202d9532eb2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -332,7 +332,7 @@ static const u32 msrs_to_save_base[] = {
 	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
 	MSR_IA32_UMWAIT_CONTROL,
 
-	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
+	MSR_IA32_XFD, MSR_IA32_XFD_ERR, MSR_IA32_XSS,
 };
 
 static const u32 msrs_to_save_pmu[] = {
@@ -7503,6 +7503,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
 			return;
 		break;
+	case MSR_IA32_XSS:
+		if (!kvm_caps.supported_xss)
+			return;
+		break;
 	default:
 		break;
 	}
-- 
2.51.0.470.ga7dc726c21-goog


