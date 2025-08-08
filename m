Return-Path: <linux-kernel+bounces-760614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4EB1EDCD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FBEA0253F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C7288521;
	Fri,  8 Aug 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqYy3g6H"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B2288502
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673847; cv=none; b=iUwjlf9EYfo/dUf/iMHWYzc216p5znTPAuUu8ELIHal0MMzknSlUQbsUyt0NmSUBZtTrtyu3RLP0nNtdpM7GTY/2YoAxSxJ6RCHdJylfDutxBdPFii1EMFVR05QDEFj7bjiQ70VJR3ZuRmNuSNDrCtBbXKpOq55iZ9atdzZG8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673847; c=relaxed/simple;
	bh=AIoZoTQBvo+U/jZuXtIgevAbb8gk2jUsuTnP16qMGGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KsLYp6llPMn5f4ncxZyZT9NB1zC+5CIYuuUw2TA54LuxrKoz4AZorDRfpQOJ7hyqOEppZD31RAW4CqMB5i94g+aSinOiRjpCPt/+J4xd0NJYg+oBUOeIXDucjWQHoDPp+NjK4LdGa23xtkwU5Hat8m3/FWFTpByIbZli3P6qG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqYy3g6H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bf73032abso2667599b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754673846; x=1755278646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Do9Z74XQnVZ+zUK2o/h866Hstp5qjOsflGUJBFgly1w=;
        b=UqYy3g6HVYnG4tBoWrsNe89zuDySmFA2IhJaIeOYQ+4yF2WUQ8wGgBekSgM+kNi8UE
         1qODjYr4S6rumrRi18/fxzljHOm2175Yd/GHo5HbqrvTAJ+nOriQKob6T+lveLB6SToo
         HIUClTODG8njsGdt6D6H/lRQLIJgASGaZMVO+JAk5/bgk4Wun5PHDEQGrPvo4fjefD/m
         W48oey2+i29yHoxlVB0R2PKmeTL+LFQbXj/kyh/QGmTS533D8DMDu2NA3lmlqInlQr/j
         B6kdwOXtT0jlzEQoUuSpCjS50jFTe742+hmxLqbhRTQEOmIDTjB65n7O2bc/k6mqSl0b
         o65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673846; x=1755278646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Do9Z74XQnVZ+zUK2o/h866Hstp5qjOsflGUJBFgly1w=;
        b=YzZ/EVnBkVlV8uVSJqknv3mSNNGj61LJLXDwXbzlnxuyQlshf/W2DDRmmU0PqOSgjB
         FM6EfrzSVK4fjxQi7e6sdf3bj8Li9mys019SR8CKKgifxyDmAqwxKVLKa2IZjyECxcCB
         mtKQ5E2ENzVA6a5pHwvVzo59bWsjYNaj6RMcS5upBdi+ZwgBFa26MjpZHA1UpGVll+nd
         AnlJy+ad/duIBns2RSmwfI/j7gdfHbM9JtgU4gUJsb/Y/XMbUCXlPqPNT1dBHGvMQnEm
         Okzylz6q2mcReFe5Iwh4l03mmvoPD6RArtrh4MeDc00QJYH19pB4IVFQUTAjoOVX11Td
         nb9A==
X-Gm-Message-State: AOJu0YwqhgVRdOIEXlwKjnu1+CrY4+MydtoFs7vxslBxWOeRv6J5eJm6
	1XtFneQSOfi5N4GrnxmgwM3R783Sle6fNC07EB1izHxkoOCrjlLlGMQ4cQDJqjypibXzbF4D8V1
	noe2gSg==
X-Google-Smtp-Source: AGHT+IEPrR/Qr6dcr/tCgKB4ZMEQ2fvgmBgYml8hd3rX5DJGL87csHa4LIawz2AnGrh3jU6IImE7ckUPnOc=
X-Received: from pfbkx9.prod.google.com ([2002:a05:6a00:6f09:b0:747:9faf:ed39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1826:b0:76b:fe65:71f5
 with SMTP id d2e1a72fcca58-76c46193d16mr5638933b3a.20.1754673845665; Fri, 08
 Aug 2025 10:24:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Aug 2025 10:23:58 -0700
In-Reply-To: <20250808172358.1938974-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808172358.1938974-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808172358.1938974-4-seanjc@google.com>
Subject: [PATCH 3/3] *** DO NOT MERGE *** x86/umip: Lazy person's KUnit test
 for UMIP emulation
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/umip.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index d432f3824f0c..26621d5ea308 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -194,6 +194,62 @@ static int identify_insn(struct insn *insn)
 	}
 }
 
+static __init int umip_identify_insn(const unsigned char *buf)
+{
+	struct insn insn = {
+		.addr_bytes = 8,
+		.opnd_bytes = 4,
+	};
+	int r;
+
+	insn_init(&insn, buf, MAX_INSN_SIZE, 1);
+
+	r = insn_get_length(&insn);
+	if (r) {
+		pr_warn("insn_get_length returned '%d'\n", r);
+		return r;
+	}
+
+	return identify_insn(&insn);
+}
+
+static __init int umip_insn_test(void)
+{
+	unsigned char vpalignr[MAX_INSN_SIZE] = { 0x62, 0x83, 0xc5, 0x05, 0x0f, 0x08, 0xff };
+	unsigned char insn_0f00[MAX_INSN_SIZE] = { 0x0f, 0x00 };
+	unsigned char insn_0f01[MAX_INSN_SIZE] = { 0x0f, 0x01 };
+	int r, i;
+
+	r = umip_identify_insn(vpalignr);
+	WARN_ON(r != -EINVAL);
+
+	for (i = 0; i <= 0xff; i++) {
+		insn_0f00[2] = i;
+		r = umip_identify_insn(insn_0f00);
+		if (X86_MODRM_REG(i) > 1)
+			WARN_ON(r != -EINVAL);
+		else if (X86_MODRM_REG(i) == 0)
+			WARN_ON(r != UMIP_INST_SLDT);
+		else
+			WARN_ON(r != UMIP_INST_STR);
+
+		insn_0f01[2] = i;
+		r = umip_identify_insn(insn_0f01);
+		if (X86_MODRM_REG(i) == 2 || X86_MODRM_REG(i) == 3 || X86_MODRM_REG(i) > 4)
+			WARN_ON(r != -EINVAL);
+		else if (X86_MODRM_REG(i) < 2 && i >= 0xc0)
+			WARN_ON(r != -EINVAL);
+		else if (X86_MODRM_REG(i) == 0)
+			WARN_ON(r != UMIP_INST_SGDT);
+		else if (X86_MODRM_REG(i) == 1)
+			WARN_ON(r != UMIP_INST_SIDT);
+		else
+			WARN_ON(r != UMIP_INST_SMSW);
+	}
+	return 0;
+}
+subsys_initcall(umip_insn_test);
+
 /**
  * emulate_umip_insn() - Emulate UMIP instructions and return dummy values
  * @insn:	Instruction structure with operands
-- 
2.50.1.703.g449372360f-goog


