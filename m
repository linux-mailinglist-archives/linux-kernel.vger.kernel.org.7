Return-Path: <linux-kernel+bounces-862350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C04BF512B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EABF4EDC73
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3CD28FFF6;
	Tue, 21 Oct 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZImhPlfL"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886327781D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032909; cv=none; b=U6bcBYyEd3lxeeNRR3K3YJRkIi92FL5z99yNo8vItCuE9MZrJd1YNEbKaBraftkIcWSjsUPYHvzi2g+EU3RU5OmiJ3jO8W9F09tjmI0JXXx+LboY3SuK1t3a0wxSh/JN7YCQWW6WIeLINN1jJlsZo+K4EmfxhcMkKnqs6LtU2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032909; c=relaxed/simple;
	bh=MtifbCAcL8U05ZhL3lsSk6V4AKS5alLo7oXyL2hRp9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efojCglMKPWfdtqP1i160osOlpck2VtEvh2hkIa1/YXxMWjZSE6C4WuWA8f+YzRT0pkC6msqvfHLbZd/t08UO6zpFCDhlZZ+SLiYB7NP7VD+fR3fN4wDO7TdMY5xicZcquOAPuV/MKx25iUEEfyMFx1Kn7h7wz5KQrs1PAyQKZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZImhPlfL; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761032903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwuNI56/YT0XrwR6EWpwHEch4X2fFRdAV4JvJVFYjTw=;
	b=ZImhPlfLuRwNGaHKZ6vM5f6mZp1/N1SzMzVQ2MUVW1uda7p6XEtLnxBOdzF38KWrmRgDYw
	MvF75zcy1bac6xtBh5LlxKWHPVfINM1osLwemkealhBbKjzbY4DNl76k7+0Eje5inuwzmc
	RiJC6TBmAViXU5Lt99xkgPF/nG31WgI=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 01/23] KVM: selftests: Minor improvements to asserts in test_vmx_nested_state()
Date: Tue, 21 Oct 2025 07:47:14 +0000
Message-ID: <20251021074736.1324328-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
References: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Display the address as hex if the asserts for the vmxon_pa and vmcs12_pa
fail, and assert that the flags are 0 as expected.

Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 .../selftests/kvm/x86/vmx_set_nested_state_test.c      | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c
index 67a62a5a88951..c4c400d2824c1 100644
--- a/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c
@@ -241,8 +241,14 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
 	TEST_ASSERT(state->size >= sizeof(*state) && state->size <= state_sz,
 		    "Size must be between %ld and %d.  The size returned was %d.",
 		    sizeof(*state), state_sz, state->size);
-	TEST_ASSERT(state->hdr.vmx.vmxon_pa == -1ull, "vmxon_pa must be -1ull.");
-	TEST_ASSERT(state->hdr.vmx.vmcs12_pa == -1ull, "vmcs_pa must be -1ull.");
+	TEST_ASSERT(state->hdr.vmx.vmxon_pa == -1ull,
+		    "vmxon_pa must be 0x%llx, but was 0x%llx",
+		    -1ull, state->hdr.vmx.vmxon_pa);
+	TEST_ASSERT(state->hdr.vmx.vmcs12_pa == -1ull,
+		    "vmcs12_pa must be 0x%llx, but was 0x%llx",
+		    -1llu, state->hdr.vmx.vmcs12_pa);
+	TEST_ASSERT(state->flags == 0,
+		    "Flags must be equal to 0, but was 0x%hx", state->flags);
 
 	free(state);
 }
-- 
2.51.0.869.ge66316f041-goog


