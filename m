Return-Path: <linux-kernel+bounces-671150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66436ACBD77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 00:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDDF173D33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2611C5D72;
	Mon,  2 Jun 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVchAOUB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF315ECD7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904308; cv=none; b=IaAqwMoOzJOnhkr0dTE7PpqyUP37BqfO0sOXotSBuJJZU8qAegH7sVpewyE5lPtJcpkV2Dlp8y7D/Yr18w+aJ9WBqqU/X8jMBB5KXXJuMd17bfRM8qBr3Kv2hTxoCarOtMvVjUsKtgXjiulpoqzsZy+6veq+KFoNotgrb2gc+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904308; c=relaxed/simple;
	bh=wgFrKfdNqxvptwJ0dkv/Tz2GZ8THxGEKBjjrVCTNsvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O0LnTzF/MA5tI/kkIN2NF59yXVbdi1tRKM8/FYKdQMQM3Y8LS2wMFsGnoq3sYeIOJvmbtfuMonqCMD+hIMg0YomsEa0sEieVczJNZ2abGwSs9WZhtBLXbVZ2q/nGrDN6WaiqqZpl3zEtIHLb3HE3aX0umQkzyF8HHXuAeIFfRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVchAOUB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2350804a43eso69875085ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748904306; x=1749509106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uYBueFv/pVEZ7QUV21+wkLlBlHK3mqlshK0YqFmhI5s=;
        b=AVchAOUBH8ctkwJCLzTBu7K26UZkkhAQV3HLIRf7mWNu3woZPT7OltF1L0Tlh51HDg
         B3mkgt9oOiJx69pjMcFmsRWWDXAv2ubXy12QOWguQgra70vv1zC0eGVUUQmLxF4BwOTv
         ltlpqvxeKF7YtrHAnAV7lBAfy8tMrw1uiDZAhG565pMaZSDVjUFcheSnFkXdTEuelUPH
         sVDdKs/De72Gg/bt8RSOb09MRgnsUmiSKeXcPo9ec4xIZLGqSKyG2aTOBO13wbOrD/Gs
         FL/GRVIqg55mdQHHErcWHhzBp/ypTmnqT3ZrM7iLTlEDRC8cA4IWSZJcWnxccmfuNAYG
         CtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748904306; x=1749509106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYBueFv/pVEZ7QUV21+wkLlBlHK3mqlshK0YqFmhI5s=;
        b=Q+7D4btghBRReIKMUGMmWAREi7/u19CymH7A0BG1ZliRdyEWdQgj+iZbwRuYqaHGBB
         g0VJ0QD4hkG+HRNC0jcKuDwZK3P9lc8r9gHwhzvyX26kQ0y0ZNT2aeiKkGUYEML6O5B2
         HuyBXtRmZUL4Lyc+XOJX8G5Vd2iVS/qxkump5IGBk12bLzHHOqTf8hJdQtksFFe9Tx+v
         lCECSrOMh2TBfKODPcqOqDwxbOALxJxr87tCqX2+y2/vNhjxUW3+Tvx7qGksT4+Uwsu7
         ps4xD9gKTbDYMYuIzgKxNmkviGdwm935kd65b4XaQ9Hq/ad5JrDxgB9ZXZWsq18UoIql
         9Cug==
X-Forwarded-Encrypted: i=1; AJvYcCXDSmzXB9emmnKgZoUaBr4+ZHzcmec302jL1JN8WReQXNjeThEv0FXuPK7Vhkt+IiaFOyrLlfgqANnnGFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZekB3HTtK+UyCYcxKUetPElD4zqEZ5Gl/V94l4bMN6g5BKi3
	9wPMEGokXy4AnJfCG08oxWAjojM7SX6dEwvDYihnoFTx/38l8Ptsz5yKkneeO2cZ33HTbhm/Jeo
	NwjX5jQ==
X-Google-Smtp-Source: AGHT+IExJZgimPIbe4xzxtu5I+efDW8e+vVzSbLlqkjYo9jNvakiMZHwiNPe4gJj71w/WgjG5NU7oimXGs4=
X-Received: from pjbpm8.prod.google.com ([2002:a17:90b:3c48:b0:312:14e5:174b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2346:b0:235:15f5:cc30
 with SMTP id d9443c01a7336-2355f783078mr133507935ad.16.1748904306524; Mon, 02
 Jun 2025 15:45:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  2 Jun 2025 15:44:59 -0700
In-Reply-To: <20250602224459.41505-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602224459.41505-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602224459.41505-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SVM: Initialize vmsa_pa in VMCB to INVALID_PAGE if
 VMSA page is NULL
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, James Houghton <jthoughton@google.com>, 
	Peter Gonda <pgonda@google.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

When creating an SEV-ES vCPU for intra-host migration, set its vmsa_pa to
INVALID_PAGE to harden against doing VMRUN with a bogus VMSA (KVM checks
for a valid VMSA page in pre_sev_run()).

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 93d899454535..5ebb265f2075 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4471,8 +4471,12 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
 	 * the VMSA will be NULL if this vCPU is the destination for intrahost
 	 * migration, and will be copied later.
 	 */
-	if (svm->sev_es.vmsa && !svm->sev_es.snp_has_guest_vmsa)
-		svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
+	if (!svm->sev_es.snp_has_guest_vmsa) {
+		if (svm->sev_es.vmsa)
+			svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
+		else
+			svm->vmcb->control.vmsa_pa = INVALID_PAGE;
+	}
 
 	/* Can't intercept CR register access, HV can't modify CR registers */
 	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
-- 
2.49.0.1204.g71687c7c1d-goog


