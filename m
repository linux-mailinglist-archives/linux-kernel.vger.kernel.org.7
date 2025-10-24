Return-Path: <linux-kernel+bounces-869449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34491C07E98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F4E4033F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E829C328;
	Fri, 24 Oct 2025 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gf56mI78"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C11299944
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334194; cv=none; b=FRmzzMhT2nTegua0pMU64b1nrH3E2VXbI4c9l2AP25r+L6ZtoD/ofD5pRzeCoZtM0qmNyxltRb+tf7Ki4DTQgRQogavOWihaWGnP5rWDe1dIRxklmBHd3N8/t5W8vFT4vC4jJbrZ+UdUlTj5uY6hM+4ccArFjWCJYAx5DwBa/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334194; c=relaxed/simple;
	bh=K6+rzxAr0QmCxsCJfzidaeVLSS/c5fhlUiVbT7WXwc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX00vs07wVySM6Cz3Ua5+gyRWqYV9MyFdQI2lck/Uo75SX0cQ/E5ePYtRm+I2PjtZ4gazQ+AiKCZiNLrYUes16nQZKec5zcelOie/6aKNX7zdgj2/z3ih4JL6GtKs4nHSIZFzzmv7KfG7xYKn9VaT27wPepkCbZv4giT3Tq1TwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gf56mI78; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761334191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbMin659eysjqiUPMu3Iq2L5Q2iASvKh7BgwyydP+5Q=;
	b=Gf56mI78hRso2PGHoat9lzNVHWYfBBEJu9x4lTee4Uu7Oz09lh7JcRkgnYxXICvbnGGIqr
	kVDHar1unntZX1vovidCrtDXsf4AxRJQ2cyVT82xY26hMUjZ6TEuPK2ZnGyumkvBXoxGku
	7PJ1QWLmxZBSEArhWRHubMHoreTkvJs=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 1/3] KVM: nSVM: Remove redundant cases in nested_svm_intercept()
Date: Fri, 24 Oct 2025 19:29:16 +0000
Message-ID: <20251024192918.3191141-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
References: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Both the CRx and DRx cases are doing exactly what the default case is
doing, remove them.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a6443feab2520..71272efc16609 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1436,16 +1436,6 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
 	case SVM_EXIT_IOIO:
 		vmexit = nested_svm_intercept_ioio(svm);
 		break;
-	case SVM_EXIT_READ_CR0 ... SVM_EXIT_WRITE_CR8: {
-		if (vmcb12_is_intercept(&svm->nested.ctl, exit_code))
-			vmexit = NESTED_EXIT_DONE;
-		break;
-	}
-	case SVM_EXIT_READ_DR0 ... SVM_EXIT_WRITE_DR7: {
-		if (vmcb12_is_intercept(&svm->nested.ctl, exit_code))
-			vmexit = NESTED_EXIT_DONE;
-		break;
-	}
 	case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 0x1f: {
 		/*
 		 * Host-intercepted exceptions have been checked already in
-- 
2.51.1.821.gb6fe4d2222-goog


