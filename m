Return-Path: <linux-kernel+bounces-829371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17389B96E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CE83ABCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CC6273D6F;
	Tue, 23 Sep 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzgw2wD/"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E21BCA07
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646980; cv=none; b=WnVPB/jkkxzd2E1E14VPmg9h7O7ZD4NrA4t4CmzShA4C7HexGtCKp47rD4k3rSHBwhjGsCmwb7kbsV5mS9rCZjKGSCxNLP6UkRmf5OcAxT9naCx965WTuGujJkybfwX8g6UZCbR7aQVhctf20jAQARHoGjTd8N0LuBf+NCXT2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646980; c=relaxed/simple;
	bh=GIlHRf5XTE0COSH//hN6Zg+nEBdSq3ma/xn77n3FOg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T4Ov3Zcl71OVYdwt2GZe8onZZA1RUBj5AsNRfDrgy40ESIcGdFb3lFmqVZTN27+yZv4PqWr/YEk9EMfc5D0bGR6e/lJUNPafMlecsb2CVIGFA04GbUZ3aIAdiE9ltxvx83KynX6ySwSfZOtPRNYEOkGXNUDOAc4tjCdSIZyxsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzgw2wD/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54b37ba2d9so69677a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758646979; x=1759251779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXBGihq8A78t9Z1IiEI/Iicy+K3MCt/5X5iumq5Le3w=;
        b=hzgw2wD//a9/k/I5IkOntEkkSo0wdK+uUHwjWXDLDDWAWVL/k7ryYzDJGdXX8IeqUF
         BgZQ1huGbIJvF7b6KgiEahzSnN1jdRHXfX0YoLxxdBGbVRKnEe7AVE28+rFhE/0qytqA
         1Qz8beXzEqeAchj7zwJGxdOfEKepS1bGsllshxL6cQqUppU8q3bG4mYkdEV6Ggz6L6Ua
         /mfMmSXyuZoThMGZY1g/yeCvG7Oo48KhgUEugdTa/fEkCbeOM+TDaIC6ZtA2MTYRF7ID
         4Wtw/rdQFn9P8hHrrF2amaLTbh/AP7X61uPzf5PNvYjUOf1EwHvwWwGavBOfnZGNhsHC
         vxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758646979; x=1759251779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXBGihq8A78t9Z1IiEI/Iicy+K3MCt/5X5iumq5Le3w=;
        b=G2j9PbKguTqVGz5azmFPgx7IBrBT1LOxbPPb3pdob+xIWkL9WyjXPnDWTBWzwQlt0/
         JkmJG43rKKZwPSTY5EM9SGz8NGvmnMAYpWDu2XhC3Ieo+DppqIW7e7PeZigw7rBxocPo
         6CeyImD8WjezLulhzz2QJ2os8WH7VZbzUcyYe4/JNt9b7w2X/hYv8Qado5gVqrdYTSu4
         tx9T8M6vYVrE4CIA5AS71x8dK5JjVGwf5nMwpGEaViksubQjVb/jNpzr5GKzzRgEtYlK
         PIZrQLN/SoJalzA7PLMQJa803NfcNIchfdQ1iLa8hgklhAssNNg2s7STdkVRzM4amMX4
         FkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR3dHdfTtFRt8dCeukBTRf++Su3ERiG7cAiKMjQzeonTKwVdmSb5ErVaEUVOUAIYTk262ctYLC171Vd8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YznRcKZEBgWCCi0IQjza6RO5wcL0Oi9AlDlT/RYX2BIVK2ips+S
	E5n+7QaP4aNjZS5vMe5HbP46Q/RUuetBCNurNyDldqL07QVw7nYrcXSi9LR9zpwvwx4qQ1IAxRo
	K9Pm+6Q==
X-Google-Smtp-Source: AGHT+IH4Kskgmch7JegC5v+NUo5paOR/XhwhXs3EqsmT9/QyBt92yY6pX0mhWpbs9SQZBDrzTmU7nahdad8=
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:b47:34d0:d386])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a111:b0:240:1e4a:64cc
 with SMTP id adf61e73a8af0-2d10f57e829mr4372465637.12.1758646978582; Tue, 23
 Sep 2025 10:02:58 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:02:57 -0700
In-Reply-To: <aNJCNMGLIIVlyC/p@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com> <20250919223258.1604852-51-seanjc@google.com>
 <aNJCNMGLIIVlyC/p@intel.com>
Message-ID: <aNLSwWM98jzs8NZh@google.com>
Subject: Re: [PATCH v16 50/51] KVM: selftests: Verify MSRs are (not) in
 save/restore list when (un)supported
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 23, 2025, Chao Gao wrote:
> On Fri, Sep 19, 2025 at 03:32:57PM -0700, Sean Christopherson wrote:
> >Add a check in the MSRs test to verify that KVM's reported support for
> >MSRs with feature bits is consistent between KVM's MSR save/restore lists
> >and KVM's supported CPUID.
> >
> 
> >To deal with Intel's wonderful decision to bundle IBT and SHSTK under CET,
> >track the "second" feature to avoid false failures when running on a CPU
> >with only one of IBT or SHSTK.
> 
> is this paragraph related to this patch? the tracking is done in a previous
> patch instead of this patch. So maybe just drop this paragraph.
> 
> >
> >Signed-off-by: Sean Christopherson <seanjc@google.com>
> >---
> > tools/testing/selftests/kvm/x86/msrs_test.c | 22 ++++++++++++++++++++-
> > 1 file changed, 21 insertions(+), 1 deletion(-)
> >
> >diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
> >index 7c6d846e42dd..91dc66bfdac2 100644
> >--- a/tools/testing/selftests/kvm/x86/msrs_test.c
> >+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
> >@@ -437,12 +437,32 @@ static void test_msrs(void)
> > 	}
> > 
> > 	for (idx = 0; idx < ARRAY_SIZE(__msrs); idx++) {
> >-		if (msrs[idx].is_kvm_defined) {
> >+		struct kvm_msr *msr = &msrs[idx];
> >+
> >+		if (msr->is_kvm_defined) {
> > 			for (i = 0; i < NR_VCPUS; i++)
> > 				host_test_kvm_reg(vcpus[i]);
> > 			continue;
> > 		}
> > 
> >+		/*
> >+		 * Verify KVM_GET_SUPPORTED_CPUID and KVM_GET_MSR_INDEX_LIST
> >+		 * are consistent with respect to MSRs whose existence is
> >+		 * enumerated via CPUID.  Note, using LM as a dummy feature
> >+		 * is a-ok here as well, as all MSRs that abuse LM should be
> >+		 * unconditionally reported in the save/restore list (and
> 
> I am not sure why LM is mentioned here. Is it a leftover from one of your
> previous attempts?

Yeah, at one point I was using LM as the NONE feature.  I'll delete the entire
sentence.

> 
> >+		 * selftests are 64-bit only).  Note #2, skip the check for
> >+		 * FS/GS.base MSRs, as they aren't reported in the save/restore
> >+		 * list since their state is managed via SREGS.
> >+		 */
> >+		TEST_ASSERT(msr->index == MSR_FS_BASE || msr->index == MSR_GS_BASE ||
> >+			    kvm_msr_is_in_save_restore_list(msr->index) ==
> >+			    (kvm_cpu_has(msr->feature) || kvm_cpu_has(msr->feature2)),
> >+			    "%s %s save/restore list, but %s according to CPUID", msr->name,
> 
> 				  ^ an "in" is missing here.

Heh, I had added this in a local version when debugging, but forgot to push the
fix.  Added now. 

diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index c2ab75e5d9ea..40d918aedce6 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -455,17 +455,14 @@ static void test_msrs(void)
                /*
                 * Verify KVM_GET_SUPPORTED_CPUID and KVM_GET_MSR_INDEX_LIST
                 * are consistent with respect to MSRs whose existence is
-                * enumerated via CPUID.  Note, using LM as a dummy feature
-                * is a-ok here as well, as all MSRs that abuse LM should be
-                * unconditionally reported in the save/restore list (and
-                * selftests are 64-bit only).  Note #2, skip the check for
-                * FS/GS.base MSRs, as they aren't reported in the save/restore
-                * list since their state is managed via SREGS.
+                * enumerated via CPUID.  Skip the check for FS/GS.base MSRs,
+                * as they aren't reported in the save/restore list since their
+                * state is managed via SREGS.
                 */
                TEST_ASSERT(msr->index == MSR_FS_BASE || msr->index == MSR_GS_BASE ||
                            kvm_msr_is_in_save_restore_list(msr->index) ==
                            (kvm_cpu_has(msr->feature) || kvm_cpu_has(msr->feature2)),
-                           "%s %s save/restore list, but %s according to CPUID", msr->name,
+                           "%s %s in save/restore list, but %s according to CPUID", msr->name,
                            kvm_msr_is_in_save_restore_list(msr->index) ? "is" : "isn't",
                            (kvm_cpu_has(msr->feature) || kvm_cpu_has(msr->feature2)) ?
                            "supported" : "unsupported");

