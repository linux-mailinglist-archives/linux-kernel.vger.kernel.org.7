Return-Path: <linux-kernel+bounces-880064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB983C24C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402591A6382A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FE346791;
	Fri, 31 Oct 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O56zN/Rr"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDBD33B96F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910258; cv=none; b=cLs3TTSBtf7BO+bPwenT38qTnNDOdJTY1H41DqFuKFkC2/dFzZiqJxFxOYDFe4nGIGKvCuJKh18xMe687+U9/1eQSHOW5q+zImt6P8P/3d+iYZTdYzR7K4tegCZ8xyyQ0yCdeoQPPCVm0Z7+WqZWxtYJ1hXvY0zJA3o68XShUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910258; c=relaxed/simple;
	bh=xb3z6RRv9FWBgbpoNB+f0HdOZ7ja5DXI4nWbdCPpE58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ERAuwIVkNiL5jzEbVFX/lt/oxE0gj+azQiGCxTE8Nb2leazE2eJvs7jMUosqXtb5nPynU76qN/dU4GV/XPiTU1+HbH/voGmuG0Z4LWxX97YF5OChDFzOsmypL18BoLMHQNHVGQONUSJFTWkhr0tX+dFLrm6wL2lDc2mpe6tyFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O56zN/Rr; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475e032d81bso18644185e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761910255; x=1762515055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5LhUGa1olQ3GKY/+89Hs0L3mppFiQpo0PHzSoy/D1E=;
        b=O56zN/RrFQWbNCswqdl5WyNgUtp5F1+s379ohxy8R/H3q809kGRuH4Odd72qIfIaPb
         IaIifsjToig37mI6syZAoPgag81dihlMNod644lxpB7OST92lkExroM9XxXMXzj1hbBI
         /KbE4LHR2/KTFYP8YTjt5ayNj1s3fJ+EBM/vEJtI5aJpnMKwR+gdQThiu/wT/L+SU7uj
         N7Nm7EuT/td25i87+4e/1ihWjak2eprN/Xq1WohoXr+w1Zq96xZaMgg2+n4PBQfgbR9O
         GTvp+lEVa4V4bBWw1z4QkOumeRM0EelNWOILER+ApTq+owi7z3rqcGFXKpMUyCnZOYY1
         bcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910255; x=1762515055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5LhUGa1olQ3GKY/+89Hs0L3mppFiQpo0PHzSoy/D1E=;
        b=KbV8xmu04RcUvLBGOtjflY9aPqRVipGxZfxCj5UF+NVDXYbfm2vshCI1qrMWGhBnxn
         Lk3wXHmpPE5HEqSsaZ3o7SLC82Adb6GKax8pMU22dxSpaiPPt6J1A9EXtwWI2zJHFYo0
         VngTHhs5Gk+fiMFmHkeBEgYo7nKLksONUzk5CGiA6zCbM5ld6TIU00JWYVdqIC9odfu5
         fQfza5Gpj9sufTCfz/7I4/N5hxfgSurq5hqXccExKa+U7Zff6Afd91JvQYmD5Wnnexo0
         8YkEJiK73HWpamDIhj0zIVQgH0zidl4E24Z32QIa40gMLt8wJHpnxJUMEFJNBSuz4wdA
         WjXw==
X-Forwarded-Encrypted: i=1; AJvYcCV8KWFFyhB7s7QwhS+tu60r+5Y3+nZ881YBifbw7sSqRe6MEWJlChQbv9syn/2NhSldkAQa8XuZ9dAeVmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uSrP6gLAzPHU4IYBG/5gqXDSr9EkdpTnZoAuCGVbAjA/j5OL
	V6k0TQF/610EoWCa47ehUO4pGUsU3SM5UzkTeXpiLTNmDjjbvVngL3tO9gXbLyr75Iu4oy2ADjN
	2uNT3dmy6w7EIUw==
X-Google-Smtp-Source: AGHT+IGsaBJIkQ/y8I03wvIhCvj64lg46pEHivGFWKZTeovvbi13vTifrl6UEKclPzTqf3k83Nt11P3xJ27+8A==
X-Received: from wmvz2.prod.google.com ([2002:a05:600d:6282:b0:477:d21:4a92])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41d2:b0:429:b21e:49b2 with SMTP id ffacd0b85a97d-429bd6ac0a0mr2563121f8f.51.1761910255127;
 Fri, 31 Oct 2025 04:30:55 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:30:54 +0000
In-Reply-To: <20251031003040.3491385-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <20251031003040.3491385-2-seanjc@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDWH24WOQG3F.1VS7MT0SKPWIL@google.com>
Subject: Re: [PATCH v4 1/8] x86/bugs: Use VM_CLEAR_CPU_BUFFERS in VMX as well
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewording my comments from:
https://lore.kernel.org/all/20251029-verw-vm-v1-1-babf9b961519@linux.intel.com/

On Fri Oct 31, 2025 at 12:30 AM UTC, Sean Christopherson wrote:
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>
> TSA mitigation:
>
>   d8010d4ba43e ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
>
> introduced VM_CLEAR_CPU_BUFFERS for guests on AMD CPUs. Currently on Intel
> CLEAR_CPU_BUFFERS is being used for guests which has a much broader scope
> (kernel->user also).
>
> Make mitigations on Intel consistent with TSA. This would help handling the
> guest-only mitigations better in future.
>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> [sean: make CLEAR_CPU_BUF_VM mutually exclusive with the MMIO mitigation]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

I think this is a clear improvement. Now that X86_FEATURE_CLEAR_CPU_BUF
has a clear scope, can we also update the comment on its definition in
cpufeatures.h? I.e. say that it's specifically about exit to user.

This also seems like a good moment to update the comment on
verw_clear_cpu_buf_mitigation_selected to mention the _VM flag too.

Also, where we set vmx->disable_fb_clear in vmx_update_fb_clear_dis(),
it still refers to X86_FEATURE_CLEAR_CPU_BUF, is that wrong?

