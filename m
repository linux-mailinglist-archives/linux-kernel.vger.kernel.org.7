Return-Path: <linux-kernel+bounces-838281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5456BAEDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB11C674E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB121662E7;
	Wed,  1 Oct 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSSH/3Ey"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2DD34BA41
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759277739; cv=none; b=CZ/TbOc3sXhc7fBdngxz9SGB3rZO5x99X4qocDMkXUm7epq86AM8zVF7zWbR9j06aBbicVg8efkoq9UKhMHsDpHFLFh54ritLmQr8pnQaeSLbQ9kzLFORxp6K48HPKSQTtes/HCq7YipgIKLGydWonY1JYmXFUL62IHGpUWKJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759277739; c=relaxed/simple;
	bh=57ATFxwrfP34L60ND1WRUscmu4NIVxMjEqJtozG1WMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LhCU97up+fyuKBMpNfdna4xjCDpRRsdelDc42GuLITbtyjd4Y43FxDb6PHVlYyLzQsvNnOwS3/wXUiGgwFddjEpQ8jdSjenSYR4ow1XPiGZyxkuIEoP+4GviH2yjN7MII6gcx5q6FDydGJHfmSwUChlMFOmU0qKK5S9cODPVsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSSH/3Ey; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so5761654a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759277738; x=1759882538; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1F9lIm+hwQ6zpx2Vlmkddr8zKECCqP++90rM5GEbtyc=;
        b=zSSH/3EyG9j8gZ8tmBoJnna0TfKfTOonVORLkjnu/ZLN31siMd1SuNq+TxGtscfVPI
         jvxa/UTaLvTKzYB2hyKPOKXrnzqwWEbcRRzJ54j4sJyZZJ9F58pnMCs8pphbczRDGqZC
         bMsGmVuFOsxQAJ9tbHRH18PFpIaOfjwcXE7cIfNXSkBAyvVhc6sFZrdYE1Td7XcBLIaA
         jM8nDIzsRz41U7ipg+DSUxNNmHkcaR+KivI8xkMiRF2RDJuuzQ/QUr6+Zro2w7cP5wyK
         Un83K8Nj432t43GgYneZlvvbddNRulfgp+HIoETjz0VmGb8hvUu6EzeR4H5P8CRTSZFl
         JEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759277738; x=1759882538;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F9lIm+hwQ6zpx2Vlmkddr8zKECCqP++90rM5GEbtyc=;
        b=EWr/NBRUKMkf0pomQLcUlmvHCsYJAz3oGu1gJwKCk+QNxJc8Q1Sw9o83BvkzvPsq+Z
         SkHS4f3VU4gb3gvGLhnaKcvRd4wBJZYDWdHIXPsiIeQ7xiHb85tZknwuMdABznqOg39x
         weFm2ZkTTInt2m8k2nBo5nKm0p54reRNBQtDk++UzGjHHiUcow7Ong83LTLNCwuBL++M
         LTZL8q9aJaLEfMuj+z03IkBG/BDT3KQG7b1oyRyNLZky8bAWRLq1ETur2L6wpxx3MEI9
         S3F7Ev/mzXEyn505jjgjJrrjcHbU7hzlAVrGVbFJ8eDPcX0TRXATvSPq5EdwZLbhbAl7
         kt+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXpJIygRsepriPX5kCVbsuVfMzhzn7Jrvv0Dv5eg1pIsmBPbAPsNuhvhdEah69dE0aze5ABct2+nYm6jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHojNun81P7GGk0VjCeAdwS5tKjKCIitCfVr/t1/NT2ApksQ04
	4OQIbqyx6ahbe6bwDXeo2i9lzE6xhRTNuCLaL3/J/wOIIlSRFSto1/XL0S8j16KBrbtsUzyeloM
	L/rQbFZUBx+tN6g==
X-Google-Smtp-Source: AGHT+IECzWXOw0pUSih1P+e508jmxKpaoxcwlzPpzcDrcMMQ+GZI0/YtT8hTGY1ft4mjHEKFiZ77bZmnYHd1nw==
X-Received: from pjbqe12.prod.google.com ([2002:a17:90b:4f8c:b0:32e:b87b:6c84])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d0d:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-339a6e9d285mr1419873a91.15.1759277737673;
 Tue, 30 Sep 2025 17:15:37 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:14:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001001529.1119031-1-jmattson@google.com>
Subject: [PATCH v2 0/2] KVM: SVM: Handle EferLmsleUnsupported
From: Jim Mattson <jmattson@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Jim Mattson <jmattson@google.com>, Perry Yuan <perry.yuan@amd.com>, 
	Sohil Mehta <sohil.mehta@intel.com>, "Xin Li (Intel)" <xin@zytor.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

It is no longer the case that EFER.LMSLE is supported by all SVM-capable
processors. AMD enumerates the absence of this feature by CPUID
Fn8000_0008_EBX[EferLmlseUnsupported](bit 20)=1.

Advertise this defeature bit to userspace via KVM_GET_SUPPORTED_CPUID,
and don't allow a guest to set EFER.LMSLE on hardware that doesn't
support the feature.

Jim Mattson (2):
  KVM: x86: Advertise EferLmsleUnsupported to userspace
  KVM: SVM: Disallow EFER.LMSLE when not supported by hardware

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kvm/cpuid.c               | 1 +
 arch/x86/kvm/svm/svm.c             | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.51.0.618.g983fd99d29-goog


