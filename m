Return-Path: <linux-kernel+bounces-856776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2EABE50AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC18C580C72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A674B239E9B;
	Thu, 16 Oct 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDFPWLE9"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF1233711
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638917; cv=none; b=C+jUwgh78avHziQid/wLnl7RIWB7wcekSj7QST8fpG7rQxGyVLeqdQa9BcXAqOp3WbYhgsgCzqzkCKo+3PGyjYTDsR4EBrS7WkavADYc6hPgcEXvRFBLt8KA3D5DkJKyquBDdc8AeAkUpar+ZtWjspjRXMTkIGpjQcwiWzPife8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638917; c=relaxed/simple;
	bh=5E0C6i+nRm6fQLpXNiWJmnym7Onqera4NouEl8JYjVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HuFjnzSs5xGizfRQR/1u3xfx/xx/cM2gGMwQ11LWs08IQdtMXPznsn2f575f6JAIetE3tHDqkupuYcoltVaka7xBH15iI4P44QnTGyA70KCNUKRNOWMyfu6fSvE6qbaj4eJ4UtshzyCK0ghqtW/NLiwtPkBukkdaZeUqf18nY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDFPWLE9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee41e062cso15728455ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760638915; x=1761243715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dg+uTAFM7lbsn7WFz9CbnP/ajLiTUmOm0LwLzXdzdtE=;
        b=DDFPWLE9P74ecLSNE7DSPHOzLGwTdoG80kdDtSY3D5uWDVUFjkJmVnMaNg7HrF0766
         4q10AakPEociADNv0hiMCfjYN4oYbuHRVXFC/l9a87qYlq7JphgCx5a2gBkQgVQ0hLP/
         WezqzjE795hTpmlgJIMA+3SmvmqBKLmC98nkdyKusdP+Bp0MdZ3QFt++Q7AmJKNhzrni
         t3fhAI/E1TYYL4sMJwHlsVJjdhTLMK6bBbe8flDYjZUVY6sQUILdPsTkES/H061gksON
         oufwemDb0tgnchUsKY+QkmgZaHRQwf0hJ/nOw4hQe/bPmYA6orEfLzu7mrqiaLqocK4d
         U2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760638915; x=1761243715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dg+uTAFM7lbsn7WFz9CbnP/ajLiTUmOm0LwLzXdzdtE=;
        b=oq2RYsraltQj/OJsSGvicS8ocAEQiV0Jn1FEgVdeDGHXRFyXTUSZHK2Jy9oGORMFam
         EfG6hWqD1cd6DhO36IDBlv5nqIAdO3jNmCtXXcYLP0Th1riv1zTRPOCzxwsSYSTCfcJ7
         I0Xxt6hsMGqyFGc2HyA5s2/xq2NZhS1xM5EWAFi8HDlUHvP/f/nY6T2q8AarwE2ujka9
         oyPYeiDWQNRdMqZaSpNa9nWih3yv4oRU99Km40/JVm4tUN8Xyp4/3mjD+oE++gsJKz2h
         hy4wIGLaM7ZdK6cX9VmuOWAE2F0jGqOu7m+N1rJ1McyxmZ5I13aQ8hpqL7cQQVDlpLOT
         XSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg+xpqVCBglreoQO4hnpPLgS8UrfVcq8P5cf4fOzHQ6A29PjCZWrCVQ30ftv+npDP+I3mg64TDWTv+7JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8OIi9zDjD3lOuqH7eMdF40yivHWHxvBF37O2KbTf4b/8megF
	M5BGxZD95+2iGkAvISnYg9oIi19xLXeOEPivb8q9Ky87O0huYl2Ba2vF1BAQrcCLETtBhA2CVMf
	Fw6PxwQ==
X-Google-Smtp-Source: AGHT+IHLX+JIJP/xpi0UAaW6TGcXgazhRaRJEBLzAroZBMicx8wFXjI+9H930mLGqANzA7DPXew0mwyUPZE=
X-Received: from plbmo5.prod.google.com ([2002:a17:903:a85:b0:290:b136:4f08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccb:b0:276:842a:f9a7
 with SMTP id d9443c01a7336-290cba4db6emr10000875ad.57.1760638914703; Thu, 16
 Oct 2025 11:21:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 11:21:48 -0700
In-Reply-To: <20251016182148.69085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016182148.69085-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016182148.69085-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: TDX: WARN if a SEAMCALL VM-Exit makes its way out
 to KVM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM observes a SEAMCALL VM-Exit while running a TD guest, as the
TDX-Module is supposed to inject a #UD, per the "Unconditionally Blocked
Instructions" section of the TDX-Module base specification.

Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 097304bf1e1d..ffcfe95f224f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2148,6 +2148,9 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 		 * - If it's not an MSMI, no need to do anything here.
 		 */
 		return 1;
+	case EXIT_REASON_SEAMCALL:
+		WARN_ON_ONCE(1);
+		break;
 	default:
 		break;
 	}
-- 
2.51.0.858.gf9c4a03a3a-goog


