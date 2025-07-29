Return-Path: <linux-kernel+bounces-749837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E8B1537B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F80016F064
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B09299AB1;
	Tue, 29 Jul 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IP91EMDy"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916B298981
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817635; cv=none; b=IW5WM3yqbSku5KqBaOa2RZKsLF+aeX4d9NfPyfMDua82KW3GkAwzIY+lIZitVCbU4GBw39C9yw/EV5E/t0kSUvO8eoM1Wi5c8/AQUgpc9OqI+DkjoDaQzdU0dCR+wllCVB32TBovcIo6Ju6yarrkv1oeqY207zv5sqeUsQdKGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817635; c=relaxed/simple;
	bh=fdpTasDFylH0aih/WYUrRlBApDM32hVkvXUFxrZnj7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWJs59+HXUPBeI/z+WSHfVFHYBz3BXv6PNx07Aap92D973ocNMXkQLKYv0Xn8KBIXkXOilZFEHOP6Db+nlx8MowFUBox2rv/u8AevHpFVvyVk2z6M+dFAtlEySzIXLY8AdNb1lk2SHixMCvVkhjprqoAggLmjBeHqAsT4vVG3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IP91EMDy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso4071718a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817634; x=1754422434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7kW936wFYM0Ary5B3+n4kBp/4+0suFDEkHTdVVXpkj4=;
        b=IP91EMDyNjw3k8Z+1ElEQJ5TP/ZpTwQv5kdxpk2JhS2i5zL4sAxu1SnQjKzj77w88i
         GtuuU03qz5x/U3wf6wPsDNc4QogKfpU4DmmaWPaqpMqfp/GHK46eiAATRhpmXAJ+HQLw
         kxFW0OC73ichLTJ+xf4va2DRjlopBxG60VGb8QlwXcFAN+iwQyR1WLLq4PNETqnhEeuy
         wSvr4Z8nmK2sIwc9zs0GWylpURovu8D97veDNPWjXO7V8lgvLgtG9yGXM2dBSDayV4iy
         8yhpzFg6zosqgoxm14OVtgF5qxk0STb9kzCQ4ZLP6qKVEmfx8LxtfFEEi9SsJUgKo4+r
         GW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817634; x=1754422434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kW936wFYM0Ary5B3+n4kBp/4+0suFDEkHTdVVXpkj4=;
        b=EIqmGYliAO412W3MB9MEssjDtxrPkwz8QjS8nAUPoRYCrul0jD4Arrv8H3bzMiP8f1
         a8cn/h4Tf0U8GAMF1TYYQ2AYIfAUyOSxJPLE0O4Queattz+lNA2sxCJiEvZrGuxevyXZ
         at9IQ64N/KDV/6h23I60FPTxXJQHz18ZHPFcCihX5vV7JFqRbCCQKUe/vutstE3tDbYO
         JqxP0zoE3PJ7IOW9pAQPFfaSQ62qRliyVlfoH1W1Wqit6cViBcaRCE0dZDdX/Ypt4ooQ
         qUtv3Ltpj3cMb/FbgztT6DJg27Zjez9dLzvX4hJw0258do0SXmGaUP6JHLJf2DBAR5Gd
         qOww==
X-Forwarded-Encrypted: i=1; AJvYcCWDnY2uq5Hz3GEkniFRveYrkk2C5yC0WkatX0MNiBhdXHnnm4y5sfJt1L8rR+fhNFz6pjDQ8Cll40oteMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkgtf9xKDHUX/gD2nb7PYQJ4WJYLyIbt2XCkJUcB2B8xSBMo3
	2icSLa652OGM5/GEfyLTN13JoX9kDQmi8Txn7nNHbQpemu8CWDx+0JQhTIZx85NMyAxTI3MbS72
	/w40c4g==
X-Google-Smtp-Source: AGHT+IELFOFWc8vYkYZRQRf3VfKYyLdceEz1T/Y/HkOfoDthT5RfeT3LHFZMzx5elvj9USSUE7rYmRIpqRk=
X-Received: from pjsc3.prod.google.com ([2002:a17:90a:bf03:b0:31f:a0:fad4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2684:b0:313:20d2:c99b
 with SMTP id 98e67ed59e1d1-31f5dd9de5emr917579a91.9.1753817633690; Tue, 29
 Jul 2025 12:33:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 12:33:39 -0700
In-Reply-To: <20250729193341.621487-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193341.621487-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193341.621487-5-seanjc@google.com>
Subject: [PATCH 4/5] KVM: selftests: Use for-loop to handle all successful SEV migrations
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

Use the main for-loop in the "SEV migrate from" testcase to handle all
successful migrations, as there is nothing inherently unique about the
original source VM beyond it needing to be created as an SEV VM.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/sev_migrate_tests.c     | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
index 0580bee5888e..b501c916edf5 100644
--- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
@@ -14,7 +14,7 @@
 #include "kselftest.h"
 
 #define NR_MIGRATE_TEST_VCPUS 4
-#define NR_MIGRATE_TEST_VMS 3
+#define NR_MIGRATE_TEST_VMS 4
 #define NR_LOCK_TESTING_THREADS 3
 #define NR_LOCK_TESTING_ITERATIONS 10000
 
@@ -72,26 +72,23 @@ static void sev_migrate_from(struct kvm_vm *dst, struct kvm_vm *src)
 
 static void test_sev_migrate_from(bool es)
 {
-	struct kvm_vm *src_vm;
-	struct kvm_vm *dst_vms[NR_MIGRATE_TEST_VMS];
-	int i, ret;
+	struct kvm_vm *vms[NR_MIGRATE_TEST_VMS];
+	int i;
 
-	src_vm = sev_vm_create(es);
-	for (i = 0; i < NR_MIGRATE_TEST_VMS; ++i)
-		dst_vms[i] = aux_vm_create(true);
-
-	/* Initial migration from the src to the first dst. */
-	sev_migrate_from(dst_vms[0], src_vm);
-
-	for (i = 1; i < NR_MIGRATE_TEST_VMS; i++)
-		sev_migrate_from(dst_vms[i], dst_vms[i - 1]);
+	vms[0] = sev_vm_create(es);
+	for (i = 1; i < NR_MIGRATE_TEST_VMS; ++i)
+		vms[i] = aux_vm_create(true);
 
-	/* Migrate the guest back to the original VM. */
-	sev_migrate_from(src_vm, dst_vms[NR_MIGRATE_TEST_VMS - 1]);
+	/*
+	 * Migrate in N times, in a chain from the initial SEV VM to each "aux"
+	 * VM, and finally back to the original SEV VM.  KVM disallows KVM_RUN
+	 * on the source after migration, but all other ioctls should succeed.
+	 */
+	for (i = 0; i < NR_MIGRATE_TEST_VMS; i++)
+		sev_migrate_from(vms[(i + 1) % NR_MIGRATE_TEST_VMS], vms[i]);
 
-	kvm_vm_free(src_vm);
 	for (i = 0; i < NR_MIGRATE_TEST_VMS; ++i)
-		kvm_vm_free(dst_vms[i]);
+		kvm_vm_free(vms[i]);
 }
 
 struct locking_thread_input {
-- 
2.50.1.552.g942d659e1b-goog


