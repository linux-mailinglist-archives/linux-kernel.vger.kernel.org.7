Return-Path: <linux-kernel+bounces-890999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE850C418D8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A136422F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0510633C514;
	Fri,  7 Nov 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jv8uKtNc"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AE32AAAF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546329; cv=none; b=WKkYFvCLa8v4f2IRHXT/b8nB5BP0sKvcSDFR6nr9msNPrPIFl8RRaYtK+so2dQhA9FI1c5pNv1gyDT1HuPmjLi9P2O7/94y8TLDdpmT8wRF+5ONkBf/rFZ24eUBgEcUINiHFyOd65paa5qkKVMfkbcO8apRvfd2E34qkm+7SpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546329; c=relaxed/simple;
	bh=A9B2jBetxyTpijSN5qBDOVR7TSExvw4XrrMBpuNK3/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZauOx5o5324QiWSehL57n4w9F5QjlsCS/e1yHbZlFqBXgHe58p6itfUSIXx/7Z2LDD49nh8Ga8TwRLtIUK0d+4DtXNU8VCt/EtLaKiBdbN0n92ZKTFVNbGKxKryd+48KzGMsI51MbqTVZqn90in/hpu6r4UDRS7ybACbbKliyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jv8uKtNc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1051977a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762546327; x=1763151127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKeLCCM6sdWIqGdgWzNkrGSaMg8DXqAf6MQfYLasg+w=;
        b=jv8uKtNcO9dLQzlZlsjVJOnH9E+U7ebI7kqJL259fNr3iIpl8Nc2q1FfsETnVsTEnQ
         tuIuZP5Twnwd3hWOox2tNgDIdDaxfqTY+LC1sE8hjO396lvpJv238r6na8ZtErldGGV3
         nrg+qZnYQ7QIz0mJaAqhQNKRIYs/knZoLwZ6YSmF8wGreEcPLADrYuUerpdiK2d+puBo
         ZUnvjrvECJajAi6CfFKeyG7mlZz8qR4HNndWkTnuNyo/5hln5VJdMnXeuBiwJH4XSOqx
         aUgXPLzjCTRGYncXW1nlidshokBUDX/wlJTJ10lzMCaWxwpDJe8MFAV7YlxtTvolxZ6R
         X7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546327; x=1763151127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKeLCCM6sdWIqGdgWzNkrGSaMg8DXqAf6MQfYLasg+w=;
        b=I1aCkQkEy00gfNDf9UTS5IPlKbXMT/P6k4Dq0LCkdopgaJOiYRxL91Q6Ldeo2/pFDn
         zeY4RGTDQ5XhFrLSvWwxif/vh/HbRScuVciu3Q5rr+QuTWuwek0rUz9YOGnie+615jck
         QiAOvbC4XeeXiXPQrXoJkvyUBTLrI29LDTHTp6vgPdIkAOK1ANl5MSD9yke2vnnbDFzP
         b2UvTcR0EZEr7ZT7eSDJiQr1C+zJHQPa3au9uXbD+nVRW8Xv4/8obKjmVS5VYfYHd9Ax
         fB2zXJqJ+PEU/HA8Xc9UfEgYixV0HRl4QBr5kmUTVyzgAAB57ccF8qfKhZVGjZ6NbGLu
         zcJw==
X-Forwarded-Encrypted: i=1; AJvYcCX2V+3udAnQkXNoBSNm8z1EuQ/2xxuZbTBdPxStCgQLR5OJgKaRqzDbUdez9sh3F96/9cjzlB4gAp2Oo10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYvrxnAEHYvrtSbfAifFThMKb8Eclz6dbCNOcErLA9ORXI78o
	MLm4p4dzh8NdS3SNoFjDPMkYQ0SJ4XWX2JhaO40FTpdnGKggtsFKU4hfGt3dwhwu/a2p2UJp78g
	U37VtX1Tq4VeYyw==
X-Google-Smtp-Source: AGHT+IEMX81+3tMgOE6zuX67fA9qMfaXSo8kQxA665QBfG7436SzZBgAY0VnspsXWL8BWaeSJWhcyshGWiIDDA==
X-Received: from pjbgx24.prod.google.com ([2002:a17:90b:1258:b0:341:88c5:20ac])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d0a:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-3436cb22a57mr496539a91.11.1762546326716;
 Fri, 07 Nov 2025 12:12:06 -0800 (PST)
Date: Fri,  7 Nov 2025 12:11:29 -0800
In-Reply-To: <20251107201151.3303170-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107201151.3303170-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107201151.3303170-7-jmattson@google.com>
Subject: [RFC PATCH 6/6] KVM: x86: nSVM: Use cached VMCB12 g_pat in VMCB02
 when using NPT
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Alexander Graf <agraf@suse.de>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, 
	"=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When nested paging is enabled in VMCB12, copy the (cached and
validated) VMCB12 g_pat to VMCB02.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 43429399993c..21d8db10525d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -605,8 +605,10 @@ void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
 	if (!svm->nested.vmcb02.ptr)
 		return;
 
-	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
-	svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
+	if (nested_npt_enabled(svm))
+		svm->nested.vmcb02.ptr->save.g_pat = svm->nested.ctl.g_pat;
+	else
+		svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
 }
 
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12)
-- 
2.51.2.1041.gc1ab5b90ca-goog


