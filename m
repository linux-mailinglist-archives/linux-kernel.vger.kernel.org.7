Return-Path: <linux-kernel+bounces-730830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272CEB04A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C141A63C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87B28A41E;
	Mon, 14 Jul 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iRPQsn+D"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFBB28A1DD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531573; cv=none; b=mMxpxkXvD6TbeZV1YtX6zXDnO1EkspRNKeZY6iYbOjBDtlN42OmA8Ap1jdCbvmYCk4l17QX9uVpG1c9mBACAcOzUuUpXVwYrNytXSB5GtthGTIWYzUBv56235/Vx4m3IDylRX1Pf552qnhPDooVTdwLsypOyBEaKTljnXGHKb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531573; c=relaxed/simple;
	bh=7GCyGeK3GJDgLipc7uVxfySEqNMPPzTr1TVIlH2zcOc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YAgFma4a2TB9VS14V7ZiVr+H1mkT9sf2tO5C08UQ8OgCkJro6lgjpEq9WCzC5qhKT4ZcvIedz4dKKILLNzVyJsbOkEuehprP4RvmGSRpfx2YPUUn1t9++lodXRvHpAk8shkJ4MDc4IsNIiUwyQMb3an9i1Vx6EWEmzzgKBztosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iRPQsn+D; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-237e6963f70so73005995ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752531571; x=1753136371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbfz/7ZzL2ochzv5MAXsTSnnCzN5mMDlC6CQLEZ6rTU=;
        b=iRPQsn+DcsJvrf4zJZytn6sRFdMMm0NazNgGoxPjdYfnzowqZTnWew6/PJEtq10PCg
         +u1fFgrF/ScWPjOj3IlSS0B/toIojqLvpimoo5j2IR/5Yw40zH6yf+v0c028r1j8FMaM
         GhS8mntCtKwCChf98WlWTa54lnNZDnTdND/Mx7qhnhS0n8FRIPKUS1fBW00nZpfRn7Wp
         jfUTyJQBKD7c8bPSBpgtGPmeI9iitqDlHmuzVKa5hSJTDW/NAqy8oFLzaos396lcj5AD
         YKmPYOumvOYAh1sTyaC+FSm896LazudveayLLjfMVeSYJFhjHYPx6/Yvj2+8w7kXfy49
         BhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531571; x=1753136371;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbfz/7ZzL2ochzv5MAXsTSnnCzN5mMDlC6CQLEZ6rTU=;
        b=jcffMR2xmJjJhuU7krf2ZNgK+19ROpuvIriQNtFF6fE1DWxTx26LbUoIzKIavbhgv6
         yCXItsJ5ue28EePXDSSBqX+wOL3kU8Hdyz3aGha2lG/abxfz+OFfHqljkwPfJoXlzovm
         ioz1EcODhcwWBPwGD06XTchXBp+U92HbErJMYe4DAXn2nAeEOAUheqZtHyax9J2fgZe9
         KArVvqFTODgL+W0Zg3tEeFysZCTaOggpwESGMf3EfqKof0IlbDEA8HGeMG96me3eMIJH
         VeevXaL/C5+zJROnGDqK76GPemGHO9DCcYb/NM+5IQnz/4hp3BQ6pcxsFFS/ieMK3HTK
         7UYg==
X-Forwarded-Encrypted: i=1; AJvYcCWdsuuFQDJj1D+M1yKfxgvr+5bA5wfzeXbm7ZeG6aU8B3uC85yksOKv3FAi3XazPBzJeWdOYEfLNBpvNG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3k3e2Y1eyDBy3s9L3enoortBwahOmlND9RHQzcDWQXzuroVF0
	y2HqPEcmGYeGkKvoSiGda0DvRobRB/pnadydWm/niS3G7cR48uR69jdsDKFCLyRWsM7Q1d8Nfvc
	6ElLCzQ==
X-Google-Smtp-Source: AGHT+IGrnZQIUXQcRKwMqGgyJysUChPuwSMcdh+Eo6WAbpJZQGLn53tAPD7JZ5S1/nUxxebqZqmTSFSdmnE=
X-Received: from pjbge18.prod.google.com ([2002:a17:90b:e12:b0:312:f88d:25f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54a:b0:234:8a16:d62b
 with SMTP id d9443c01a7336-23dede38615mr221123565ad.12.1752531571602; Mon, 14
 Jul 2025 15:19:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 14 Jul 2025 15:19:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714221928.1788095-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Ensure unused kvm_tdx_capabilities fields are
 zeroed out
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Zero-allocate the kernel's kvm_tdx_capabilities structure and copy only
the number of CPUID entries from the userspace structure.  As is, KVM
doesn't ensure kernel_tdvmcallinfo_1_{r11,r12} and user_tdvmcallinfo_1_r12
are zeroed, i.e. KVM will reflect whatever happens to be in the userspace
structure back at usersepace, and thus may report garbage to userspace.

Zeroing the entire kernel structure also provides better semantics for the
reserved field.  E.g. if KVM extends kvm_tdx_capabilities to enumerate new
information by repurposing bytes from the reserved field, userspace would
be required to zero the new field in order to get useful information back
(because older KVMs without support for the repurposed field would report
garbage, a la the aforementioned tdvmcallinfo bugs).

Fixes: 61bb28279623 ("KVM: TDX: Get system-wide info about TDX module on initialization")
Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Closes: https://lore.kernel.org/all/3ef581f1-1ff1-4b99-b216-b316f6415318@intel.com
Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f31ccdeb905b..40d8c349c0e0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2271,25 +2271,26 @@ static int tdx_get_capabilities(struct kvm_tdx_cmd *cmd)
 	const struct tdx_sys_info_td_conf *td_conf = &tdx_sysinfo->td_conf;
 	struct kvm_tdx_capabilities __user *user_caps;
 	struct kvm_tdx_capabilities *caps = NULL;
+	u32 nr_user_entries;
 	int ret = 0;
 
 	/* flags is reserved for future use */
 	if (cmd->flags)
 		return -EINVAL;
 
-	caps = kmalloc(sizeof(*caps) +
+	caps = kzalloc(sizeof(*caps) +
 		       sizeof(struct kvm_cpuid_entry2) * td_conf->num_cpuid_config,
 		       GFP_KERNEL);
 	if (!caps)
 		return -ENOMEM;
 
 	user_caps = u64_to_user_ptr(cmd->data);
-	if (copy_from_user(caps, user_caps, sizeof(*caps))) {
+	if (get_user(nr_user_entries, &user_caps->cpuid.nent)) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	if (caps->cpuid.nent < td_conf->num_cpuid_config) {
+	if (nr_user_entries < td_conf->num_cpuid_config) {
 		ret = -E2BIG;
 		goto out;
 	}

base-commit: 4578a747f3c7950be3feb93c2db32eb597a3e55b
-- 
2.50.0.727.gbf7dc18ff4-goog


