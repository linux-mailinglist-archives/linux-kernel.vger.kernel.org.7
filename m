Return-Path: <linux-kernel+bounces-858782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FAABEBD45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B425435739E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BD62D0631;
	Fri, 17 Oct 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fzLZ7AIS"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B423184A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737224; cv=none; b=hxstxwr7OunIMu9fJqmapqYtml8QD+HiknwXLIO0HtDaCuTD50kvp/E7oK5TRjNrgRKg+CSPdcqqZYNJgqfL4ZYK8JqAFFxY36Ptc/sG5VeUsorWtWgqzj0xOZLSNfuZwJ0mXx0Msd4ZGHuFSTfskNCv28pca2lVYr5Vy5a7bg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737224; c=relaxed/simple;
	bh=xec44dz02vCzqSvijFwW8T2pHLkXyzKFGftXYWemhVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rr9OKRsbTfDEcEKlhc8Qm6NheoUkvt1agW86GOgDnlxvKyIboP5EkuzOcHi20AW+OhHDncUGz4VYw6ATdqY/2V2uyFuMILJliP/ZDVhTR7DUCxM0EvbX6cLU6aJL+PMvlKLX425+BFeiPYrAaZxGHjK8OSWTu1bSvrTJ0bSCYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fzLZ7AIS; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760737209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hqHjkEGF/llF28r0KVHF88JX9zjukAmNil/u6FvmQxs=;
	b=fzLZ7AISgoCCLOzUnu8Ze+zJBMVwV4g50CzFM0nk2VGdJYWih62y9aeUZInyTEYO+WKK28
	lgsks1RFgkRvY7BkniSUbQkpo/JwXM/49dNmuJiABrl511+ZL/Pje5qSVYC5motBTNpCAy
	dbq0I46MOCfHUeGpCj0mNJx/pHGWm5k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH] KVM: TDX: Use struct_size and simplify tdx_get_capabilities
Date: Fri, 17 Oct 2025 23:39:14 +0200
Message-ID: <20251017213914.167301-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Retrieve the number of user entries with get_user() first and return
-E2BIG early if 'user_caps' is too small to fit 'caps'.

Allocate memory for 'caps' only after checking the user buffer's number
of entries, thus removing two gotos and the need for premature freeing.

Use struct_size() instead of manually calculating the number of bytes to
allocate for 'caps', including the nested flexible array.

Finally, copy 'caps' to user space with a single copy_to_user() call.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.
---
 arch/x86/kvm/vmx/tdx.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 0a49c863c811..23d638b4a003 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2282,37 +2282,29 @@ static int tdx_get_capabilities(struct kvm_tdx_cmd *cmd)
 	if (cmd->flags)
 		return -EINVAL;
 
-	caps = kzalloc(sizeof(*caps) +
-		       sizeof(struct kvm_cpuid_entry2) * td_conf->num_cpuid_config,
-		       GFP_KERNEL);
-	if (!caps)
-		return -ENOMEM;
-
 	user_caps = u64_to_user_ptr(cmd->data);
-	if (get_user(nr_user_entries, &user_caps->cpuid.nent)) {
-		ret = -EFAULT;
-		goto out;
-	}
+	ret = get_user(nr_user_entries, &user_caps->cpuid.nent);
+	if (ret)
+		return ret;
 
-	if (nr_user_entries < td_conf->num_cpuid_config) {
-		ret = -E2BIG;
-		goto out;
-	}
+	if (nr_user_entries < td_conf->num_cpuid_config)
+		return -E2BIG;
+
+	caps = kzalloc(struct_size(caps, cpuid.entries,
+				   td_conf->num_cpuid_config), GFP_KERNEL);
+	if (!caps)
+		return -ENOMEM;
 
 	ret = init_kvm_tdx_caps(td_conf, caps);
 	if (ret)
 		goto out;
 
-	if (copy_to_user(user_caps, caps, sizeof(*caps))) {
+	if (copy_to_user(user_caps, caps, struct_size(caps, cpuid.entries,
+						      caps->cpuid.nent))) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	if (copy_to_user(user_caps->cpuid.entries, caps->cpuid.entries,
-			 caps->cpuid.nent *
-			 sizeof(caps->cpuid.entries[0])))
-		ret = -EFAULT;
-
 out:
 	/* kfree() accepts NULL. */
 	kfree(caps);
-- 
2.51.0


