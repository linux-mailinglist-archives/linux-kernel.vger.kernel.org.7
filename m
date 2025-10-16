Return-Path: <linux-kernel+bounces-856774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D8BE509A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA3144E60EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88E229B12;
	Thu, 16 Oct 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mq33SfXt"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E652264C9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638912; cv=none; b=q9IqpXFsZY13q5noQ2iOl85rpR8G+iozar8nItbIQRYZj+/esguJG1Xych0BBaHlWWXjbNqCjKkcW110nSy4tExL7XyJ/d/TYoKDQfNzIRJTZ4/JKn7RMagWCg7Ycp1HjmsuqBJ8FYAjMW1gy7GFNEKUS+8KBar672CUar9kJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638912; c=relaxed/simple;
	bh=Mh+E6gl011fW54E6RYWIlpW7g7mpCeL0nCd5AXo09UY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lcm2+9F+sbg5OqMK6eP9lYBSe0M0lklzLqtTHd1Z1zgONPsHoa2qsZ9OnTRWJrSQ7lrjaII4mNc5YF/z3aH+BTdjv64/JY0fwycTcpf3cAqyjcgIhcYi1n3RdrHdj4szQMgFXM4hiRQsTDAEcwyxVsVo2YisMkQ1G391do3XcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mq33SfXt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so965369a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760638911; x=1761243711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n4oum8oQsC/oMkZG6rVTrxCa4Asppbi7rtcXvwpYnI=;
        b=mq33SfXtimYnS0Y4KiWJcraa4kgYtvcwQ474gZxB6lmFWycplQ2eKjBGbGK0rOr7l6
         wDrx4n/lVZ5VipCDIP6bfVcArnXDhDC8nkp+b5p7kqTiliYarLRE1lhNZrrbaK7nA5wj
         sygNdbA/xMsqdFnpigajwxY7ye99MJ7iYDFfuxqcaKTgcMBeT69oyMwPkzbsBMzNkP+O
         DGsr4y7m7E0eRaEHRGSgy2xavNtjnBbpKcK8eeYHVH22CN2KlE1dwKFGj7c6jiuXGQvs
         Z4pLt7jidyvrY6fs485a5xSOlFHKrq2eYuwYhu1gKwLn+oz1etY9hIEEoBr2Zgo2+Pfu
         1Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760638911; x=1761243711;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4n4oum8oQsC/oMkZG6rVTrxCa4Asppbi7rtcXvwpYnI=;
        b=U5O4toVRXpCWe9U7hqflkxRWL3ytxfBzEyUcNaIjKzDCXMv1wQsHymCq4Y8DU65Qpt
         BxrvyvO3pUjVDYnzCSy/POVxiyfmtPHVF/oMQIdEI+mP7lACWd/5dYmXlZxFTVwMyEA2
         pJz5jHpekdfsLAohG8b+kOLhiXYMifJKtXK9UP3XVtgFoRNaR7Bprt0FCueJngiJaflV
         qCwLWzoKaMm3tfUDmxrG4HOvvIA+/09j89bO3k30Fn10LfDjFJYq+oA6FpLfzPN35B5X
         f44NkXkNzn8yKDNvvofNXHIH9nAkoo2IXz3/MZRLD/t4IZixgm/qjENgmtyF6Nx5dOHV
         ZrrA==
X-Forwarded-Encrypted: i=1; AJvYcCWgoPtGBWIbCFR1cX03BrJ4X5lI0Wuzo4184J7mKCmQP1Qc9YPHHPKBAVieDMu1+hz64p9f0zOzwsozEXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsza6nOh95vT+Xb0llym8kKSha5a5hd8pTF7MRv26fUNhEqm3
	ZIAuhPnWUI2ElYa/bamvHCVvJPrFFN7VP0BbYScDpKEm4SjHKcrcGIrkICyf26MbYwaZ2FOeKdy
	KN3dCUg==
X-Google-Smtp-Source: AGHT+IFLCoX5WFUlmmHIT4Ie6C0AeGFBS2XH3ZTG/UN632Tqc/zBz1lEaUkWyKjkjgFodVUI9HmuC6chR/o=
X-Received: from pjyl20.prod.google.com ([2002:a17:90a:ec14:b0:33b:8aa1:75ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a8a:b0:33b:ae39:c297
 with SMTP id 98e67ed59e1d1-33bcf8a9ee7mr909953a91.16.1760638910678; Thu, 16
 Oct 2025 11:21:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 11:21:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016182148.69085-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: VMX: Handle SEAMCALL or TDCALL VM-Exits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add VM-Exit handlers for SEAMCALL and TDCALL as the instructions are gated
only by VMXON, and so a buggy/misbehaving guest will likely be terminated
(because KVM bails with KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON) if the
guest executes SEAMCALL or TDCALL.

v2:
 - Apply the behavior only to VMX.  KVM can't inject #UDs for TDX, and the
   TDX-Module is supposed to handle SEAMCALL. [Chao]
 - Fix nested exit handling (inverted return). [Xiaoyao]
 - WARN if the TDX-Module punts a SEAMCALL exit to KVM. [Xiaoyao]
 - Fix typos. [Binbin]

v1: https://lore.kernel.org/all/20251014231042.1399849-1-seanjc@google.com

Sean Christopherson (2):
  KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL
  KVM: TDX: WARN if a SEAMCALL VM-Exit makes its way out to KVM

 arch/x86/include/uapi/asm/vmx.h | 1 +
 arch/x86/kvm/vmx/nested.c       | 8 ++++++++
 arch/x86/kvm/vmx/tdx.c          | 3 +++
 arch/x86/kvm/vmx/vmx.c          | 8 ++++++++
 4 files changed, 20 insertions(+)


base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac
-- 
2.51.0.858.gf9c4a03a3a-goog


