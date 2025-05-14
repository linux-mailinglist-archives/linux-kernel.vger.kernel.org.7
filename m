Return-Path: <linux-kernel+bounces-648274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA2AB7488
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 20:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B1F4C4FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AED288512;
	Wed, 14 May 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/nx3Z2g"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23F288510
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248115; cv=none; b=DFzQnMaldP5c6aFE6JDLXgxBRUS2eda8M/gUyPtYnLHWgVkY4djyRHsT9GvFEo53jX8R+OVo7iu2+64rmtCasMDh4IyZ0Q9S7QwTHuDBxK660kCAx4/9+o4Y888GNfiebffxh19+3Uql8RMbUBENW6K3z6uaZCkPB4nEhu3TR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248115; c=relaxed/simple;
	bh=jCrq91a6ZGUBMd0hXPZN1ZpYaiLLg06xn/FVy+YAfkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rv4veueeC5oOgWRrEpArH8kbsVKbT/Bn1L2xS13Tto7y3CpOJau8BAKuiInVJhGNnLT9JanDzVGDdum2ozKHd2MBjxfNTrPLuNldq+NjqRMsZYUjQzRqZnA6OUpkzZ2lYpBtAxWU6sGEEtxfg7KnZbr3jPGMprHD0Y70XJUh/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/nx3Z2g; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22fdf1d9fcaso896175ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747248112; x=1747852912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqs1ABBrK/SoRx/WU68XgIhBrfwY+6u36pWyXJ3N2cA=;
        b=i/nx3Z2gc393HOslsC47VZ1n0qAR8iJuF537G+3+ZnHbt/rAMrLwo4uWiltDsdyomU
         3wdklUdxOziVMCrLYuKb4Iq1kMgRET9n2C1xcbctCWRzhZ/nHmQ73Xo6W2w3ScDM2U34
         YaA4u3tyt9oipiSFclk4D0MBy0SRTbPeo41DFSL///Oejvd6165FJNQNvtsqWc8gFjnu
         jG76UW7+AquS2+aUeVd99ISqf3jO5Loa0S5rs/8tht2R22ofQwdMLuAF56LEpBbEPCW3
         YlC/G56nMpfweQuDMfYYQeoS9c2Fw524942kvQz3FJgfEfj71TIZ9IfpbgSKyC/qVC/C
         O7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747248112; x=1747852912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqs1ABBrK/SoRx/WU68XgIhBrfwY+6u36pWyXJ3N2cA=;
        b=MeOvVNeKF9yz3Tih75xWoZCNZakPeCabARvqVHUXNpQvmvCKBvZmxJ5UIgrD5Dnenc
         F3XPlfNMksThIzRnAM7s4D7HzAXPHbXFvvhAa//PU9mhxlQZbCB8RE2R3sgWbIWcNm5z
         NHLNXjrGPgR6qFqpn5brSzC3n1i9+TEZMHHQSa5dCBEQik6/ZkISSBLr8c3BaCZrctSO
         6PwtD5xmD6xwzB7NrT4921hod+ylzqBeYTDE7Pqt0LaPt0x2Fx8xCdyNFRoFuVAQht9o
         LSVL2bLMvmu2BRQxhv/IscZPe+DYexETHJp5iYfKa0F4EYP1iC0T8a2ia6d/Z5kFxtbt
         GiCw==
X-Gm-Message-State: AOJu0YyuYnCV21tgkOHYRCYqTHu2Ry7AG2M/wBP8Hq59HxdtHU/v019P
	fElEphCuVeUlzo6Hx/31aayX7zshSGxWMLlqfbDktP/X47flS5d6PxEl2LOS6mFKV3OK3UTrq72
	H32dvLz5qZyIS9226mf9BSg==
X-Google-Smtp-Source: AGHT+IEj0u063ItqXbBprVsscCCcufQDFXSgBslg6Ix6TcQKSTjaE0XjkqMYzsqDG1lkKArewjPTBhxYTeTzIsGYgg==
X-Received: from plnr13.prod.google.com ([2002:a17:903:190d:b0:227:967c:4f38])
 (user=dionnaglaze job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea0a:b0:220:e338:8d2 with SMTP id d9443c01a7336-231980fba76mr69818855ad.21.1747248112013;
 Wed, 14 May 2025 11:41:52 -0700 (PDT)
Date: Wed, 14 May 2025 18:41:34 +0000
In-Reply-To: <20250514184136.238446-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514184136.238446-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250514184136.238446-2-dionnaglaze@google.com>
Subject: [PATCH v4 1/2] kvm: sev: Add SEV-SNP guest request throttling
From: Dionna Glaze <dionnaglaze@google.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <jroedel@suse.de>, Peter Gonda <pgonda@google.com>, 
	Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The AMD-SP is a precious resource that doesn't have a scheduler other
than a mutex lock queue. To avoid customers from causing a DoS, a
mem_enc_ioctl command for rate limiting guest requests is added.

Recommended values are {.interval_ms = 1000, .burst = 1} or
{.interval_ms = 2000, .burst = 2} to average 1 request every second.
You may need to allow 2 requests back to back to allow for the guest
to query the certificate length in an extended guest request without
a pause. The 1 second average is our target for quality of service
since empirical tests show that 64 VMs can concurrently request an
attestation report with a maximum latency of 1 second. We don't
anticipate more concurrency than that for a seldom used request for
a majority well-behaved set of VMs. The majority point is decided as
>64 VMs given the assumed 128 VM count for "extreme load".

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 .../virt/kvm/x86/amd-memory-encryption.rst    | 23 ++++++++++++++
 arch/x86/include/uapi/asm/kvm.h               |  7 +++++
 arch/x86/kvm/svm/sev.c                        | 31 +++++++++++++++++++
 arch/x86/kvm/svm/svm.h                        |  2 ++
 4 files changed, 63 insertions(+)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index 1ddb6a86ce7f..1b5b4fc35aac 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -572,6 +572,29 @@ Returns: 0 on success, -negative on error
 See SNP_LAUNCH_FINISH in the SEV-SNP specification [snp-fw-abi]_ for further
 details on the input parameters in ``struct kvm_sev_snp_launch_finish``.
 
+21. KVM_SEV_SNP_SET_REQUEST_THROTTLE_RATE
+-----------------------------------------
+
+The KVM_SEV_SNP_SET_REQUEST_THROTTLE_RATE command is used to set a per-VM rate
+limit on responding to requests for AMD-SP to process a guest request.
+The AMD-SP is a global resource with limited capacity, so to avoid noisy
+neighbor effects, the host may set a request rate for guests.
+
+Parameters (in): struct kvm_sev_snp_set_request_throttle_rate
+
+Returns: 0 on success, -negative on error
+
+::
+
+	struct kvm_sev_snp_set_request_throttle_rate {
+		__u32 interval_ms;
+		__u32 burst;
+	};
+
+The interval will be translated into jiffies, so if it after transformation
+the interval is 0, the command will return ``-EINVAL``. The ``burst`` value
+must be greater than 0.
+
 Device attribute API
 ====================
 
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 460306b35a4b..d92242d9b9af 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -708,6 +708,8 @@ enum sev_cmd_id {
 	KVM_SEV_SNP_LAUNCH_UPDATE,
 	KVM_SEV_SNP_LAUNCH_FINISH,
 
+	KVM_SEV_SNP_SET_REQUEST_THROTTLE_RATE,
+
 	KVM_SEV_NR_MAX,
 };
 
@@ -877,6 +879,11 @@ struct kvm_sev_snp_launch_finish {
 	__u64 pad1[4];
 };
 
+struct kvm_sev_snp_set_request_throttle_rate {
+	__u32 interval_ms;
+	__u32 burst;
+};
+
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a7a7dc507336..febf4b45fddf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2535,6 +2535,29 @@ static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int snp_set_request_throttle_ms(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
+	struct kvm_sev_snp_set_request_throttle_rate params;
+	int ret;
+	u64 jiffies;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
+		return -EFAULT;
+
+	jiffies = (params.interval_ms * HZ) / 1000;
+
+	if (!jiffies || !params.burst)
+		return -EINVAL;
+
+	ratelimit_state_init(&sev->snp_guest_msg_rs, jiffies, params.burst);
+
+	return 0;
+}
+
 int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -2640,6 +2663,9 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_SNP_LAUNCH_FINISH:
 		r = snp_launch_finish(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SNP_SET_REQUEST_THROTTLE_RATE_MS:
+		r = snp_set_request_throttle_ms(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
@@ -4015,6 +4041,11 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 
 	mutex_lock(&sev->guest_req_mutex);
 
+	if (!__ratelimit(&sev->snp_guest_msg_rs)) {
+		rc = SNP_GUEST_VMM_ERR_BUSY;
+		goto out_unlock;
+	}
+
 	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE)) {
 		ret = -EIO;
 		goto out_unlock;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f16b068c4228..0a7c8d3a7560 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -112,6 +112,8 @@ struct kvm_sev_info {
 	void *guest_req_buf;    /* Bounce buffer for SNP Guest Request input */
 	void *guest_resp_buf;   /* Bounce buffer for SNP Guest Request output */
 	struct mutex guest_req_mutex; /* Must acquire before using bounce buffers */
+
+	struct ratelimit_state snp_guest_msg_rs; /* Limit guest requests */
 };
 
 struct kvm_svm {
-- 
2.49.0.1045.g170613ef41-goog


