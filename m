Return-Path: <linux-kernel+bounces-829254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7872B969DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2039F323651
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0D264A92;
	Tue, 23 Sep 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHJUA1vr"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C6263F44
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641868; cv=none; b=k2s4QeuOo9yeNyBxoLNgrTMxisTHrx+otD4PxEh/9yInbjwJcVYk2KRakx1RnBWhj32TZatU8nNf3d5FlFBFQ+iQ1O58DD19A5Rd/wPhx7NuZzxdumkNJC/jLk9lo6iJAnVcD6AXmy1OcCGLAaGX422Nn/PAiBdq8CvSNlvZE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641868; c=relaxed/simple;
	bh=4swEKEjr9ZfU+UhcssFhlBXgoat9+0rZuV4f1sVbGQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZbXJ16LiK+vegIf2u0DcRRV/ZmW8onjwk48imDh59GAHB7ukpgVrmGeXCziNvvrbbxg2KTcgOAHJAqhwmsJkWQ01ESCqSOlDuzp4scrVmj5R1UI3Y03uLgLgLiFOrktNSfCFZWLQT5OQJ5TVkxAh45fUy/X4QYV00OiCpWrpcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHJUA1vr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54df707c1cso3486795a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758641866; x=1759246666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RPQBXX/kV1DT6qccrRylEa2l6eEjE9QWLJ5e48WHMIs=;
        b=AHJUA1vrowf9iGV/k69rs8bWenM5WVB/6ero/JywlrgUES2exNT6+QZwldL3BvlTRg
         9/nbI9k79EkZbdd83irH3kV+unZHYmo+rbOrPf2iyqgjPjvgNVK979JRGs9Bf85Q6oe5
         pqp/DrZx1cBa/vWs5SUOCToh69SVbClFB9i5BADXhYipMbsO0hgJ/dt/eTognteqN5CM
         ikM6wpnkEFuz/cdOSNg1oBZ8aTGeYej80vo9OFvwRfEOkKmKSOScTXFW8qg0DI27+QtW
         7S1Kdc9Hi14bqDCml/+vNWqb8r8DGhI+eiAiebd5D4IKtmJyf/3gLdgsG764yJagLs+M
         ogGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641866; x=1759246666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPQBXX/kV1DT6qccrRylEa2l6eEjE9QWLJ5e48WHMIs=;
        b=Gb1kpDmf6691z8Od4Nml2QnJaRMHmeCnGhZ0JOcgcorjlxVI2Xb5EqTRyrkOUBk8I7
         btyx98SDYf1GpHJMy3dSCu1ScbbEGJi0fruKMXV6oBOxq9QfQb6wYt9VIXLSfz+5OI2+
         UmhGGqy3NhkxMtQYqIkt50lY29R3QBkQk7mrJvw5wv1uH5nPd7SbTky1YF0eNYUtQVRL
         NUYxCnjx5ppAQE4pFrzRBuNSE0Un3GmD2HRTVk4E5YNmYyZ2GOBlp134eeL4Jrx0OWoI
         jFoHfzHxhPiuOwWkW8HVPoAcwC6UpGjs6IkjMPZan28MVgIzyFkROhEU9CoNDkEjoTMA
         szDw==
X-Forwarded-Encrypted: i=1; AJvYcCWfk8dVmOynwolUGkswz8SUbh0GI8l5PtiZesfJHC0pGMb/PgBXYe84YygFqzYRBTBHEjmdb6Dv0J2xPoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk4VBscLtcT0D7rVdioynsdP7+xEK/2O6bWY2N2dIyiGNVwJb
	7iKBj7OyVud1ge9e48VM+5du4x2b0vi8HvbaYrnLweD0HzOT6rgDN4oWgDc6tqIVa7GZVVrkYCs
	iCJvoog==
X-Google-Smtp-Source: AGHT+IErLLqmD/PORlhyxU7jOUm4C+LioX2IifX5+KrKCfJkXml7M7iR2w0tUMSLgBWIeNxBWpYKDngkc0Y=
X-Received: from pjtt1.prod.google.com ([2002:a17:90a:1c81:b0:332:8389:c569])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2442:b0:24c:ed95:2725
 with SMTP id d9443c01a7336-27cc28bc310mr34259705ad.4.1758641866139; Tue, 23
 Sep 2025 08:37:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Sep 2025 08:37:37 -0700
In-Reply-To: <20250923153738.1875174-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923153738.1875174-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923153738.1875174-2-seanjc@google.com>
Subject: [PATCH v3 1/2] KVM: x86: Add helper to retrieve current value of user
 return MSR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

In the user return MSR support, the cached value is always the hardware
value of the specific MSR. Therefore, add a helper to retrieve the
cached value, which can replace the need for RDMSR, for example, to
allow SEV-ES guests to restore the correct host hardware value without
using RDMSR.

Cc: stable@vger.kernel.org
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: drop "cache" from the name, make it a one-liner, tag for stable]
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/x86.c              | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 17772513b9cc..14236006266b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2376,6 +2376,7 @@ int kvm_add_user_return_msr(u32 msr);
 int kvm_find_user_return_msr(u32 msr);
 int kvm_set_user_return_msr(unsigned index, u64 val, u64 mask);
 void kvm_user_return_msr_update_cache(unsigned int index, u64 val);
+u64 kvm_get_user_return_msr(unsigned int slot);
 
 static inline bool kvm_is_supported_user_return_msr(u32 msr)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e07936efacd4..801bf6172a21 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -675,6 +675,12 @@ void kvm_user_return_msr_update_cache(unsigned int slot, u64 value)
 }
 EXPORT_SYMBOL_GPL(kvm_user_return_msr_update_cache);
 
+u64 kvm_get_user_return_msr(unsigned int slot)
+{
+	return this_cpu_ptr(user_return_msrs)->values[slot].curr;
+}
+EXPORT_SYMBOL_GPL(kvm_get_user_return_msr);
+
 static void drop_user_return_notifiers(void)
 {
 	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);
-- 
2.51.0.534.gc79095c0ca-goog


