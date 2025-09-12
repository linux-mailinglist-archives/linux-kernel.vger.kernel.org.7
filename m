Return-Path: <linux-kernel+bounces-814901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E81BB55A37
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EBB1D6385A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7C2E172B;
	Fri, 12 Sep 2025 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wv8Cefo3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A92DF6F5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719462; cv=none; b=EfjMrCQX0MitdDjeFRSQBAcRz2R8USN5mmDEqXc/hmaq5yZzKFivDMUuiiTodoS8fEMUYo2p3cOONlIhQv8CyOWO3ec9PJILLZ0d7782LH0ONOQ93cQ1tAtzEdQ0rArhq301o9DMyEUnq0shmx4CcYObBXSfPG8S2+gKQC1hE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719462; c=relaxed/simple;
	bh=15o9VZMft2MxcQUSFl+ZPSNTP7kKh/VfLBpA5JRopZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lwLFUFLylHw3hP8Vf2ZwX2lHESIc9HexMkFbYDo+U37qoid4PThg8WmmCkWXAfsJbOMNqY7j/cjsKcYYQcKqgkJchbORuQiDJ5DjG1q/+8vsRvXt9itpUHdUzBl+Xfv6MQvM8BXrAlZdjZRV++YyhcdkvA/VQ8gEiAqoFSzYkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wv8Cefo3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32811874948so1949990a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719460; x=1758324260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oEM1NzRArGwHRfjs11EJFtjqkFE7gqTIfGb/p5R/iqs=;
        b=wv8Cefo3eFQBjZuDCkq72j4ndqHcwD64wmf/aD5H9jSbZFyNO94focP71m72KFaQtx
         PJQCSQ3OYvqc7t6U1dHwugHccw4on2HEsA3LNevK6t52PPYTcCM5af0nzMai3OMRbvnc
         ZAqskRf9CZoq2c1De+mpQwESr1f1fB+MwzqW28uTCgCnaCc6kkPZsPM2329n+7OViXyT
         KomEcLKxc3U5WaPnindmjfjp6aL3uPThYe4IOH2Z06zgX7BKjf6okI08yRL1qJzG9pOo
         9XQaq+VAK/tXv/1AUkOwx5bmoijNN68W63FgHEUJ+DBzHB95eNAwO+a5nRVYQxdAXQJk
         QYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719460; x=1758324260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEM1NzRArGwHRfjs11EJFtjqkFE7gqTIfGb/p5R/iqs=;
        b=nIwqAzEpkNPO991MknvNgyWaD8PwxQBrO2OxJGuVelcm7BK3u0Z6sdUztVuHxasqof
         /OySAQhSuMMFy7EaoHnCUmZ8hXM/NJGTFr9+s+lXI8HfTYbPr7IvNOcUDZHg+HhwzXzV
         vm0FA+gQ1sZZc0/tX9oGtM7dxRMLB3rqLc9Wql+Z2SCLI4BL8pV0+WUPp02hhmsBJ6kA
         X7XzSEHnnK+fy/seLmN952VTnRfwU0W8aFBPHDk9b5/b9uDC0ZqufWsFqnQjHre4AkBK
         lDTDF3rSEAtADPAGjeR0fZOyUE5X3WNnfQb6mpR0+ahcSLf8s9WNtsE9Mocezid3w90p
         26vA==
X-Forwarded-Encrypted: i=1; AJvYcCW21jUUsYuQKUiiegHd6uFU4yJg1D6dt4TMK6A8wXMst8bb4ZUgegN7CeeuOUsHuo1qAiqVUGDtHwyeIfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7A9E+XX3wAfJEiEcCSMfYqqtsI/bozvU+hI9lVt7F5JFP1q2J
	X3+d3RzDXjH9wkJuMlnYi0FpNquUARTIQrRb+TQFfTA/L7ekqsvj1pHwBzaooF7/eL7yE/1NU61
	jvFYcdA==
X-Google-Smtp-Source: AGHT+IEI5JovoN5wkH2yZ6fX9zcon0aRMyJn/qFmhwPGnpNLEiLHDGb5/h9oeAOds2uQCKUVhH7aIxxB5Vw=
X-Received: from pjbqi2.prod.google.com ([2002:a17:90b:2742:b0:32d:def7:e60f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b44:b0:32d:dc09:5e83
 with SMTP id 98e67ed59e1d1-32de4f85901mr4667658a91.18.1757719459656; Fri, 12
 Sep 2025 16:24:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:08 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-31-seanjc@google.com>
Subject: [PATCH v15 30/41] KVM: SVM: Enable shadow stack virtualization for SVM
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: John Allen <john.allen@amd.com>

Remove the explicit clearing of shadow stack CPU capabilities.

Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: John Allen <john.allen@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dc4d34e6af33..f2e96cf72938 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5264,10 +5264,7 @@ static __init void svm_set_cpu_caps(void)
 	kvm_set_cpu_caps();
 
 	kvm_caps.supported_perf_cap = 0;
-	kvm_caps.supported_xss = 0;
 
-	/* KVM doesn't yet support CET virtualization for SVM. */
-	kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
 	kvm_cpu_cap_clear(X86_FEATURE_IBT);
 
 	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
-- 
2.51.0.384.g4c02a37b29-goog


