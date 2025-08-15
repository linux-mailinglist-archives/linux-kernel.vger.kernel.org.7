Return-Path: <linux-kernel+bounces-769768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61563B2737A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623FD1890081
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E951EEA49;
	Fri, 15 Aug 2025 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgSVV3qi"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1F1E1A3B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216751; cv=none; b=SCrjwkUDKS7K5qoq7lRF65SxqV1oRbhVbM7hSfQnxkBPFXarqRBTtSOFOTQFHVeUVmwl8G422Kytnn79VZdmE3LKQStD0vmxIKY4JOobP2URQ3WyKEWz+pJukUE0M+QdFLJJiYMOStMMr37E446pZUE/Tyu6qKOggVW2LSNZAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216751; c=relaxed/simple;
	bh=bvDp4MOWnvUg7G9Pwr/XZYkF2LA55VcOt3qLgd8IQvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fpmRDrdszHd3G2OGVp1m5ZDSpjBS+cUryP1umIlAgNcczzdkdTgjoWkjwdP9q4F1V2n8xPFh5g5ahAFaeJ6c7WMusz/Qj6MBaXiciYPprqet/M7hOp00t/PSJ9lm9ZIdOkwfLNjV7l+K5JSS0FTkeLojq/xDiBIbMLutP5BcXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgSVV3qi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458345f5dso14554725ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216750; x=1755821550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BqNFRdZp4dZOuhcg+tVI2WIxCzfFJg3qux8SRQQatZg=;
        b=ZgSVV3qiulTNeH5/itel50oP2lVOq3E3lm/pQ3Wgxy9TnNXMM22KFJXI4jjs7dYTuB
         puJYvLma2WWF+POCRCr8svbkF/l5F54wU9SOzRE+j0dRLHa3anjqztVkoMXX4dmaX6wh
         u+0e2X15Vb1cXIx3t42rvUBt1eDaeU4le4tn7hHMlD/OCibta3c+nx9eARZt9fWTB1vI
         q70MwMGl7BFWdTyMNe8cuiUWd/IlzhZkI/CqoRE3ns+MwKFniAgAa7P4z8c55o/HNBkm
         Ms/VSkCmffmJOD/z2VkRc2FJJBIkedzc7etA6FaPcCDwhZIoeT6gXAxjBB8vqKj7rckB
         QI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216750; x=1755821550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqNFRdZp4dZOuhcg+tVI2WIxCzfFJg3qux8SRQQatZg=;
        b=Dd+OzsjaiqZAhxk3LrHgoKih+Re3sBoZXTIzaXP4WVJ5NwUXHT4HRhm+MOoiGJkEn4
         mC46vPZt7x4LdmxePZyr4dR84GbDjmoGg3hcmSn7usJ7i3DQ9A07KbEzGRpNDgHXdwvX
         qY/VevblrKkEf9TpofoNI5W7NjisTnsE2S4u3nMeg328w8vRe/Adylm5HARRL9dlUnES
         lclFmCi5ovq/01n5Ys+g60E6eyB/s4ya59m9grOTriSMs1fr+xPCPOLr8J0gTokBJqP6
         /SRRw/HTUhgQkIE88VVoG2v6xQaO2zK94F6xx3AHhejnW71FzyZBA22oi7gS2PHHZJSE
         /g9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOMhK/BL4+JQ9TibUWF+HxSbZc3pPkKHLfr1zgX5IXcEatwHQBIWmNjs60Zefsx9Fkux49PUJc1T4CJ0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsUAC/kjIDmEKNpXIZtHpHhe4jluiGXnYBPaDpM8V9ylL6j9n
	SDEhLmTnSi3GIZPxy+FzvNPNEUpnkUFcvs1nj1qjE5AZHHaD+q/l5rtKm/IpsMGFH8SEdUvPajG
	pj+tFew==
X-Google-Smtp-Source: AGHT+IHsUD4IEXcOJDddmNyAVMtxzUdZNE4LwkwjB6Xni2icG5GH9wBulaAHQkFDZ2ytKoB6uP5ydyFou3Y=
X-Received: from plbkc6.prod.google.com ([2002:a17:903:33c6:b0:240:7619:64aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac6:b0:243:ead:f694
 with SMTP id d9443c01a7336-2446d6f6e46mr1645445ad.17.1755216749987; Thu, 14
 Aug 2025 17:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:54 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-11-seanjc@google.com>
Subject: [PATCH 6.1.y 10/21] KVM: VMX: Re-enter guest in fastpath for
 "spurious" preemption timer exits
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit e6b5d16bbd2d4c8259ad76aa33de80d561aba5f9 ]

Re-enter the guest in the fast path if VMX preeemption timer VM-Exit was
"spurious", i.e. if KVM "soft disabled" the timer by writing -1u and by
some miracle the timer expired before any other VM-Exit occurred.  This is
just an intermediate step to cleaning up the preemption timer handling,
optimizing these types of spurious VM-Exits is not interesting as they are
extremely rare/infrequent.

Link: https://lore.kernel.org/r/20240110012705.506918-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0b495979a02b..96bbccd9477c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5933,8 +5933,15 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (!vmx->req_immediate_exit &&
-	    !unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled)) {
+	/*
+	 * In the *extremely* unlikely scenario that this is a spurious VM-Exit
+	 * due to the timer expiring while it was "soft" disabled, just eat the
+	 * exit and re-enter the guest.
+	 */
+	if (unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled))
+		return EXIT_FASTPATH_REENTER_GUEST;
+
+	if (!vmx->req_immediate_exit) {
 		kvm_lapic_expired_hv_timer(vcpu);
 		return EXIT_FASTPATH_REENTER_GUEST;
 	}
-- 
2.51.0.rc1.163.g2494970778-goog


