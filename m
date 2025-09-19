Return-Path: <linux-kernel+bounces-825312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 185A9B8B88A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 087774E2F07
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF0314A87;
	Fri, 19 Sep 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2ZhzMXN"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1F320391
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321261; cv=none; b=ungWfumxSG99jYj144Eg6EryN3KYr9ymAwt2rTdQS/flcmOijvUXUTI6fYT+Sp+zwuMSE5RKx1rjSb/+qb2u1VEjwXlrFznimSvGALPLssJ6bnq/YCAh6991cxhTjAxkT4QUj3gwk9bYGgVd2F3ucqTx+cmGP2BaEVPUQPFdsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321261; c=relaxed/simple;
	bh=CYruM6/nLA6BHSIVAXqcCI2n0dhqEb8nlIv2iRzLL/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RzKd+Kmekv0SMME7IbEaEalF34u5AN5VXEitU3EJ6XomBxHkR27wUd8kmN7ZZqe8Fd+X8kO5MgEfdreIoIn9vrUJHn3ofFufqAXPpNASf7wHBBM7gBoK0nX0GSjW/9Oa2EAzQBvigXI/YtevafOedAGMGDlXyOqaTYCvj8VtQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2ZhzMXN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b595so1557962a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321259; x=1758926059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v3/gIRcH16msBI7YOF0B/Y3P7fFolZGAQR2AF4CuYpQ=;
        b=m2ZhzMXNaXXOdK2+NX/JSpzmFGLN+8Uqlfv1yF9MSRs9/se4Ewft4HfPCpFx/TOo+W
         HLCJKjBtUoMPiMlpb7U2mvO7jkNNsbGmdg628kOMxfjC1ZZJFtWoNRRsAQ/ejfq+oBGJ
         PxDwKeTRi3o3GOJOdgaYsaUnSIH+xzt/U6PRtH0RVc+zktSLyyRTxlQjaPqPxTE0dmvu
         iNn6OPn0PZuW9sJyshWBNKjW2vbO/fNrUNEV6H7rfIZ4Vx0QUzHLyrHyWKgPqI5gVzB1
         uTrQy7qBejjQ6Qrj8HSeDwqSDu24HQQGzXd3LrWREOeUjPhGzblnFtO7zFsTdMM+eo4d
         9w9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321259; x=1758926059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3/gIRcH16msBI7YOF0B/Y3P7fFolZGAQR2AF4CuYpQ=;
        b=xRby9qzO3bBiQBs6euGtO0jmd4UDM5FV7QH7IhSOomObca0TtdYhSH6V7jx07IPt3O
         3tfZUH+/twosM6n90izhwHYbLLDV8Fd483u9u1DTc6HbrdayzZTXNJoHzbQ4ocpjrc+l
         nVPG5HVm4G9KqCVnLxjMcyFRg8OiAJ3Gt7xMo2brvMs8e3feKhiTuZ+eD2TkS6DF8rsh
         vHqBLiJmWMubzwyUwOy3O2t/sg3Z7vtLPugUmEHio/iNImAUotMfmWYEbSM29Q3QR1uG
         7hlEiCTYD38p4jlB/nSCRU6d0rcJpXLy1j+UyTHyRh2dZ1C4tVdw7qr4toueoh70srKw
         4P4g==
X-Forwarded-Encrypted: i=1; AJvYcCW22jHZb+70QT2VgmTzOj386RVIg/E8d4NSauV+8v5+8X7ZYLorubgGNknmFaJeCDYNNlQE1Pia7qmilHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2E8Pu1s6TsSr+VBKCZzAWp1ixWhT+Gwzq/aK1eEe67anZn3Wv
	qEq8JAnpaK3n0mMxMmwICNF6yiii0TEjr2w73uUk/e+ofTVKmPY95YU3GsdfnGQxw8gGigj45Kn
	8R8CGnA==
X-Google-Smtp-Source: AGHT+IEpSlLooVqKUswOjccVv6JWUDP6SUs5HYzHzopl1fOGKza6IACwwFb/k/4itYpqFLBy5elmXgRTGmw=
X-Received: from pjes22.prod.google.com ([2002:a17:90a:756:b0:330:acc9:302c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dc7:b0:32e:5cba:ae11
 with SMTP id 98e67ed59e1d1-3309836d2cemr5015556a91.28.1758321258948; Fri, 19
 Sep 2025 15:34:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:48 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-42-seanjc@google.com>
Subject: [PATCH v16 41/51] KVM: x86: Add human friendly formatting for #XM,
 and #VE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Add XM_VECTOR and VE_VECTOR pretty-printing for
trace_kvm_inj_exception().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 57d79fd31df0..06da19b370c5 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -461,8 +461,8 @@ TRACE_EVENT(kvm_inj_virq,
 
 #define kvm_trace_sym_exc						\
 	EXS(DE), EXS(DB), EXS(BP), EXS(OF), EXS(BR), EXS(UD), EXS(NM),	\
-	EXS(DF), EXS(TS), EXS(NP), EXS(SS), EXS(GP), EXS(PF),		\
-	EXS(MF), EXS(AC), EXS(MC)
+	EXS(DF), EXS(TS), EXS(NP), EXS(SS), EXS(GP), EXS(PF), EXS(MF),	\
+	EXS(AC), EXS(MC), EXS(XM), EXS(VE)
 
 /*
  * Tracepoint for kvm interrupt injection:
-- 
2.51.0.470.ga7dc726c21-goog


