Return-Path: <linux-kernel+bounces-667414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E889AC8521
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 01:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF6CA21E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49D25D903;
	Thu, 29 May 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="il77Mx0x"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ADE25D1F7
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562030; cv=none; b=Wsn3AnkU+KJoudgD/Fkox1OQV4Au1SObmWOocGnjh7SIIIUIR0yN5w8xhsfuiJAXqOM50rn646uJ7wQgNJ9BEA9/YosEekhB/RW6M5aL2mEZeE02fyr3foooXRi4Wqi0z7QmHrV4w58U+6aM90GCSfDHxtc6rBnQsRwcLCKcDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562030; c=relaxed/simple;
	bh=FcU6zezhDWsB4bYilzt+T+RoNMzHFPiB4olAYBJ5o5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACioYKiXaKjhZxZj67ioDfTh+l2GRQC2rA/t0GHywhTItmQ8l6moAihNpTPAL9zwsUozC6BAoQqvZHNJK8e1rNXEJC8B5voYyzh9Vse1LlZIj+WwlR4JYrgreUiFBpYaxEaZ9jmHy3Z8T2NQll0CA/U2XvUaylQlSW3+oJBUqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=il77Mx0x; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so1124406a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748562028; x=1749166828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJVBhij4nqSGUMDZ+MUMEs9XKTobhDecpAV03Z2OeR8=;
        b=il77Mx0xHLVD/ShpwhPcoT77qAFikaB16drNn0ar47OGY7BT+jtfXVbU4l32kMi1po
         TmnAMjLqZwiIdkDPmxZUEWALPAkc2sCqh1q58g2pGQ0FMVI9M+w6QPJWaDqGh3GKa8Rz
         WfjmBcK62hcmbVGSqvssAL5xGm2vCztt0fb8uCXu7eO6Bw10Kp1oT/fFpnA+odRy2m2x
         PYrw8w6chszVyIiRlXRaajvVhFdLK4S4PV8A1iauGyMhIsG6wQA30/rpntvo0JsAI/Tx
         cZZzizdKALbqCj6LISgD3cQGq23Xjaktgg0UcXNQCSMVBoQguYOIJlBy81S9ntRFelFh
         3zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562028; x=1749166828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJVBhij4nqSGUMDZ+MUMEs9XKTobhDecpAV03Z2OeR8=;
        b=g9ACswNpamkmbj2IycQFlxCKUDE4ztuC6wI9+tQ33XFy0lOFC+VMkgvCS/Pp4sZffU
         EwjW3LrtKi5YQKz39M8xXezKBvT/SUh4Z1hg47dm0ZZ6PIDFwG85xnxZCPS5jh5MDGCe
         1GM/ew+1cIf4EW0r7AQkOJjoG4tkzhUviVWeRSB62NPzLUC8fqXLM1vt0QN/QRXaN9sx
         XUFwxHQdb+yQYXMNWCx1TVrTS+rXIgMucQNJ5yNodvDVrjZD1arkHRV2qFbBMumBRaqK
         hGV2zhKvj6BxzISOihHH6UvpjuXCv5y1/IvNw8FZxsJm4KLj6tiL9jLsuZq7T+yrkE42
         L+gw==
X-Forwarded-Encrypted: i=1; AJvYcCVmsr7B3VRtPgBGaG1eFd1Ue8vP1/lQum59qMO9KxA4pR2Wl6VogvrzMMeqpyFc9RuKJ3jSs6I1NJT7Rfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOPOlZYYMNynfk2ve6vjOK7oecC8dzevXn75fy+w1lUCQtxqC
	L9r7GMMbq5NezDGtAJKTaDs3cDiarZt4uxt33mit39GrFRau1dibkoC6PA2NRxxADj03WMHMMrD
	b3NTmrg==
X-Google-Smtp-Source: AGHT+IE9c4b7JE+2PcDfKfSpRgvjcYbRntt3fGnPxkVYR6N79d2o7XuqET/clBBK6IBD4TrdAYyLsiphQsg=
X-Received: from pjbsw15.prod.google.com ([2002:a17:90b:2c8f:b0:2fc:c98:ea47])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc6:b0:311:be51:bde8
 with SMTP id 98e67ed59e1d1-3124173be09mr1833578a91.20.1748562028593; Thu, 29
 May 2025 16:40:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 16:39:52 -0700
In-Reply-To: <20250529234013.3826933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529234013.3826933-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529234013.3826933-8-seanjc@google.com>
Subject: [PATCH 07/28] KVM: SVM: Clean up macros related to architectural
 MSRPM definitions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move SVM's MSR Permissions Map macros to svm.h in antipication of adding
helpers that are available to SVM code, and opportunistically replace a
variety of open-coded literals with (hopefully) informative macros.

Opportunistically open code ARRAY_SIZE(msrpm_ranges) instead of wrapping
it as NUM_MSR_MAPS, which is an ambiguous name even if it were qualified
with "SVM_MSRPM".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 18 +++++++++---------
 arch/x86/kvm/svm/svm.h | 17 ++++++++++++++++-
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2085259644b6..1c70293400bc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -266,24 +266,24 @@ static DEFINE_MUTEX(vmcb_dump_mutex);
  */
 static int tsc_aux_uret_slot __read_mostly = -1;
 
-static const u32 msrpm_ranges[] = {0, 0xc0000000, 0xc0010000};
-
-#define NUM_MSR_MAPS ARRAY_SIZE(msrpm_ranges)
-#define MSRS_RANGE_SIZE 2048
-#define MSRS_IN_RANGE (MSRS_RANGE_SIZE * 8 / 2)
+static const u32 msrpm_ranges[] = {
+	SVM_MSRPM_RANGE_0_BASE_MSR,
+	SVM_MSRPM_RANGE_1_BASE_MSR,
+	SVM_MSRPM_RANGE_2_BASE_MSR
+};
 
 u32 svm_msrpm_offset(u32 msr)
 {
 	u32 offset;
 	int i;
 
-	for (i = 0; i < NUM_MSR_MAPS; i++) {
+	for (i = 0; i < ARRAY_SIZE(msrpm_ranges); i++) {
 		if (msr < msrpm_ranges[i] ||
-		    msr >= msrpm_ranges[i] + MSRS_IN_RANGE)
+		    msr >= msrpm_ranges[i] + SVM_MSRS_PER_RANGE)
 			continue;
 
-		offset  = (msr - msrpm_ranges[i]) / 4; /* 4 msrs per u8 */
-		offset += (i * MSRS_RANGE_SIZE);       /* add range offset */
+		offset  = (msr - msrpm_ranges[i]) / SVM_MSRS_PER_BYTE;
+		offset += (i * SVM_MSRPM_BYTES_PER_RANGE);  /* add range offset */
 
 		/* Now we have the u8 offset - but need the u32 offset */
 		return offset / 4;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f1e466a10219..909b9af6b3c1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -613,11 +613,26 @@ static inline void svm_vmgexit_no_action(struct vcpu_svm *svm, u64 data)
 	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_NO_ACTION, data);
 }
 
-/* svm.c */
+/*
+ * The MSRPM is 8KiB in size, divided into four 2KiB ranges (the fourth range
+ * is reserved).  Each MSR within a range is covered by two bits, one each for
+ * read (bit 0) and write (bit 1), where a bit value of '1' means intercepted.
+ */
+#define SVM_MSRPM_BYTES_PER_RANGE 2048
+#define SVM_BITS_PER_MSR 2
+#define SVM_MSRS_PER_BYTE (BITS_PER_BYTE / SVM_BITS_PER_MSR)
+#define SVM_MSRS_PER_RANGE (SVM_MSRPM_BYTES_PER_RANGE * SVM_MSRS_PER_BYTE)
+static_assert(SVM_MSRS_PER_RANGE == 8192);
+
+#define SVM_MSRPM_RANGE_0_BASE_MSR	0
+#define SVM_MSRPM_RANGE_1_BASE_MSR	0xc0000000
+#define SVM_MSRPM_RANGE_2_BASE_MSR	0xc0010000
+
 #define MSR_INVALID				0xffffffffU
 
 #define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
 
+/* svm.c */
 extern bool dump_invalid_vmcb;
 
 u32 svm_msrpm_offset(u32 msr);
-- 
2.49.0.1204.g71687c7c1d-goog


