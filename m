Return-Path: <linux-kernel+bounces-825257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F35BB8B6F1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085455A4435
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861E2DFF13;
	Fri, 19 Sep 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPECOsGO"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C72DC784
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319191; cv=none; b=DvDVTiIlTg2PWio3l6jIhA/q4d+NhR3BDt2acFcLMwPa4E8tM18A0KfZq7af/UmXNVljd/whILgsY8UYYeSPl1GP5m/O1DMdlxnmBeuEuic+tLZJOzIoMAkWvg1S3GUfZWWiWAwq+mv4pBIn6aA7XRH7iRi2vSYIf7qgMzOqJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319191; c=relaxed/simple;
	bh=gsn2LS9MZ0/r32Bz+FAmilAqbI9lmLhCm/3NWyexLkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KOyHq1KyPmPeqsxaJu/Xlgt+X9yy1tMFZZtvAr9M4d8TtSn4TqWRXZBuro/WTcK33Lxjmw5wnOB+PX8cjyK+i1KycdNeaho+vqxA8LV+W+VTaJ7C6P8MNlEocYPUCMnUzo8C4w9BvkdBHUQQk3K+BsqIToLigPpcHW6xG9fKVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPECOsGO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54a30515cfso2772065a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319188; x=1758923988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb2CJ3cAd7NGczYuI0z0dLZESADxvuqEmD3PjMDN8y4=;
        b=JPECOsGOWfa2hEkQ7wl8nWl7uaYEgXMI03KPjTV9H3KaWUxP00UImRrYo/zMKLQj0w
         uRKcKKQ15fZtFKeaRgB9q7t54nu85HIOQmKIcK2nkTAsl4IbC4MlO/CTpQnqZDMEnzf4
         vxKVhCrRD2kKpx81AUyPJS3yu3E8J2CeSi33R7yy9YKz5QM1hJ1G5bBcwPgpvkncNqXl
         5BF2ukp7USHtyAZV9nUpt90sZYeoi+Ss00ARAHVg+07/e4TNC1x+JB5furDHwUMSZbPR
         f8IxxkjpiS84EbZYQeH2oMlUtIJsYhJ39E2KMetDCr7yUGWdAIIO/9YJyzQ6VK/svv/T
         OCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319188; x=1758923988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tb2CJ3cAd7NGczYuI0z0dLZESADxvuqEmD3PjMDN8y4=;
        b=s6DE1q/eMG3jABSEALTpyGPumUGZMH8K5L3ywUxOpoZslO6bnviWQczj2PtNpkKgbs
         c9ps/ZdI8QRM+hTEB0gxyjuE82xFAXXFMRnLMepiCZr0dhkI3GeicYryBSLHxX9hi01W
         HMJAid7Lb0CSn4x8nz9K5okJmwbmfDc4bi1kezQkFO+aknleh8WrClsGGPVXDOhFm8zm
         a+kw/yLl9Ci5RNxKfsuKmWT0GJVT6RZ1LOdV9CGUIJ4FNbF21kVIDhlpIIw90U+v9f4H
         se7XzjEVEym+E1pq6XFEroHLL7/8AxDleSJUWDn1cGk+q4p1D7HubSh81YpBujk+ChVS
         PEug==
X-Forwarded-Encrypted: i=1; AJvYcCVxO1a+QEPkLIwcypxr8KWxQ1wq6qGmwcWs/COHOeKZEiEGytPAIdDzL5AzTgnwADDTqB8UZqrYRIqfjUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BRT/Q/gKOxdleNKxhYBCBFcnsfTvAhoJ7Wl8F2D05Rc21oto
	3hRGdYLCnYhmvBk4rNFjzRSbfOvZ0ttPr8/cwvlx16xxTDvyqlb1o3PQaYAP2lWa13iWBW0RkLB
	43FX6gg==
X-Google-Smtp-Source: AGHT+IHFJR0vBTAZhUhFWYQATSw48DKFzjt9Py0RyOipJEiS7BJGMQ6J8RRVJHpyIkCK2VMmnqt8BdNygEI=
X-Received: from pjcc8.prod.google.com ([2002:a17:90b:5748:b0:32e:8ff7:495])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cc7:b0:32d:e309:8d76
 with SMTP id 98e67ed59e1d1-33093851ef6mr6452139a91.10.1758319188191; Fri, 19
 Sep 2025 14:59:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:59:34 -0700
In-Reply-To: <20250919215934.1590410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919215934.1590410-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919215934.1590410-8-seanjc@google.com>
Subject: [PATCH v4 7/7] KVM: SVM: Enable AVIC by default for Zen4+ if x2AVIC
 is support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Naveen N Rao (AMD) <naveen@kernel.org>

AVIC and x2AVIC are fully functional since Zen 4, with no known hardware
errata.  Enable AVIC and x2AVIC by default on Zen4+ so long as x2AVIC is
supported (to avoid enabling partial support for APIC virtualization by
default).

Internally, convert "avic" to an integer so that KVM can identify if the
user has asked to explicitly enable or disable AVIC, i.e. so that KVM
doesn't override an explicit 'y' from the user.  Arbitrarily use -1 to
denote auto-mode, and accept the string "auto" for the module param in
addition to standard boolean values, i.e. continue to allow the user to
configure the "avic" module parameter to explicitly enable/disable AVIC.

To again maintain backward compatibility with a standard boolean param,
set KERNEL_PARAM_OPS_FL_NOARG, which tells the params infrastructure to
allow empty values for %true, i.e. to interpret a bare "avic" as "avic=y".
Take care to check for a NULL @val when looking for "auto"!

Lastly, always print "avic" as a boolean, since auto-mode is resolved
during module initialization, i.e. the user should never see "auto" in
sysfs.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ec214062d136..f286b5706d7c 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -64,12 +64,32 @@
 
 static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_IDX_MASK) == -1u);
 
+#define AVIC_AUTO_MODE -1
+
+static int avic_param_set(const char *val, const struct kernel_param *kp)
+{
+	if (val && sysfs_streq(val, "auto")) {
+		*(int *)kp->arg = AVIC_AUTO_MODE;
+		return 0;
+	}
+
+	return param_set_bint(val, kp);
+}
+
+static const struct kernel_param_ops avic_ops = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = avic_param_set,
+	.get = param_get_bool,
+};
+
 /*
- * enable / disable AVIC.  Because the defaults differ for APICv
- * support between VMX and SVM we cannot use module_param_named.
+ * Enable / disable AVIC.  In "auto" mode (default behavior), AVIC is enabled
+ * for Zen4+ CPUs with x2AVIC (and all other criteria for enablement are met).
  */
-static bool avic;
-module_param(avic, bool, 0444);
+static int avic = AVIC_AUTO_MODE;
+module_param_cb(avic, &avic_ops, &avic, 0444);
+__MODULE_PARM_TYPE(avic, "bool");
+
 module_param(enable_ipiv, bool, 0444);
 
 static bool force_avic;
@@ -1151,6 +1171,18 @@ void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
 
 static bool __init avic_want_avic_enabled(void)
 {
+	/*
+	 * In "auto" mode, enable AVIC by default for Zen4+ if x2AVIC is
+	 * supported (to avoid enabling partial support by default, and because
+	 * x2AVIC should be supported by all Zen4+ CPUs).  Explicitly check for
+	 * family 0x19 and later (Zen5+), as the kernel's synthetic ZenX flags
+	 * aren't inclusive of previous generations, i.e. the kernel will set
+	 * at most one ZenX feature flag.
+	 */
+	if (avic == AVIC_AUTO_MODE)
+		avic = boot_cpu_has(X86_FEATURE_X2AVIC) &&
+		       (boot_cpu_data.x86 > 0x19 || cpu_feature_enabled(X86_FEATURE_ZEN4));
+
 	if (!avic || !npt_enabled)
 		return false;
 
-- 
2.51.0.470.ga7dc726c21-goog


