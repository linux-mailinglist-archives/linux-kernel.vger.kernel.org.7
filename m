Return-Path: <linux-kernel+bounces-893523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB7C47AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 056E64F3379
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674BE3164D7;
	Mon, 10 Nov 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEjLSv7p"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9426E706
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789141; cv=none; b=NdcqceIewuoOwKJCfN/Ci/7rUAgrRX9qQQ2tWHfhJ45U0ofz2IapOubMsKmGORXuOamGNZIbd32K1bb9VrKnSGgqFGBt21hDy/4NHmA2XcNdfkXZgQlDUOCgj9dB237MJ5cUIgU0Hm8eeyYGv3JT0ubBAddhwzrmZr52mtZ3iGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789141; c=relaxed/simple;
	bh=cDyMaHDdkuq+asAIgegu+SPgoFRi3jHo3jco+i8TKbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nJVb9bh9iOHqU05Rg+wqDsVX04CN7zmKFuP1jvvXhKCRq89fdbhsSTK1QhLPyK8TW5u2dZqHQXoQccWv03hNvf4saVwLzGqnVyF/kW1xpfyxDegSAdWZquVIlB3/x7uApi/CCqryQoO/PHmXjBb3RXamcDEmXmLF06Grkaf8rZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEjLSv7p; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340bb1bf12aso7763890a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789140; x=1763393940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=laNhRLQX0XMVmOMwAG0d7wv5H+B5etUz5b1epi6/2Eg=;
        b=nEjLSv7pjCr1TH1JMOTuH91+ZyYG8++i0Nh4ru9CKxJcKTFidSFZdgcOW0/KVFKjiR
         rCnnVELe76tb0n3pa8+gJcu5wsZf3dem7Ox+OwiLpwx+Km+HhwD+tSzRqgXLXNg4Ro1r
         VGjgIAf0MEXd3nr8rxF24cryaNNUJw2jIevAK45zR/QVa65dRXZYDeD1JVrR+daqVM9A
         4PYObrD2O1SsejqO4q/DWUQ/mznQBz+b1YHM5ewbA3pSAytl7OL+j+51mSCgZ1fclPbS
         9AK1b1PzZ/ie9AhpKfV6MAQ8JEjA055bM7lsp+LRkV7f6gdKmuH3KwqG1JYOcSOdLgJX
         mfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789140; x=1763393940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laNhRLQX0XMVmOMwAG0d7wv5H+B5etUz5b1epi6/2Eg=;
        b=Eir/D6DiWpB5uFXnfYW9vMDFbPhE1nuDgoGs4y/pCmvWzoZXD4+bNdSQX8QE7J4f7M
         yHNseU1B6domGsM0kqSDkMvDE8av0EhJiOksnv1IaHel1reCwLJWqscCMw9rM1UoKXCm
         T7tETV7HK6W1s53DQg6q4biJsycUBKbhB/K409sxU8HHouEEMp0WQx01PjPNLxL8swUu
         FBL+mlqantlKThZJvnmKAdoUg6XZGJNNUvZlDs5kE+sYw2CUCYUd6+jPRfSezP31lK0O
         cscN6NwJ+P3r6T1XfhhZEAPLnh77FHQ0CzjIi+4AfZmqobpZATh5hXAAa293QReLt703
         v+KA==
X-Forwarded-Encrypted: i=1; AJvYcCUF2Ubb8XPlgwNVbWuM+8HFmNdQ+fc4zvEA0nK1rHShfmQ+H9lVxHQkv6ndE5bWfVUZh/te4hHLLUhFhT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncO8l7tHqcCFuq2NIQo4eboUPOTX3aTQHScb6IhGX5SuFFk8Q
	utq1a7UHGIKG6NY4dYNqMqd0NkP9VKv1OCynLE+XAxh/DN3FR7TYXMEZUln8pVjRKzze3LtezvT
	w1CYJkA==
X-Google-Smtp-Source: AGHT+IHZTL6lBepPCG1wa5BSSf8eoaJ1ttmPlXua2WSmSSk5CeBLMKSmijCYjH2CcNBTA0SMfZe8CXJqtak=
X-Received: from pjtv19.prod.google.com ([2002:a17:90a:c913:b0:33e:3612:2208])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:388e:b0:343:6c71:6d31
 with SMTP id 98e67ed59e1d1-3436cb29ad3mr11615416a91.11.1762789139688; Mon, 10
 Nov 2025 07:38:59 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:21 -0800
In-Reply-To: <20251030191528.3380553-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030191528.3380553-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176278796784.917175.10578129282144167896.b4-ty@google.com>
Subject: Re: [PATCH v5 0/4] KVM: x86: User-return MSR fix+cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 30 Oct 2025 12:15:24 -0700, Sean Christopherson wrote:
> Fix a bug in TDX where KVM will incorrectly update the current user-return
> MSR values when the TDX-Module doesn't actually clobber the relevant MSRs,
> and then cleanup and harden the user-return MSR code, e.g. against forced
> reboots.
> 
> v5:
>  - Set TDX MSRs to their expected post-run value during
>    tdx_prepare_switch_to_guest() instead of trying to predict what value
>    is in hardware after the SEAMCALL. [Yan]
>  - Free user_return_msrs at kvm_x86_vendor_exit(), not kvm_x86_exit(). [Chao]
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/4] KVM: TDX: Explicitly set user-return MSRs that *may* be clobbered by the TDX-Module
      https://github.com/kvm-x86/linux/commit/c0711f8c610e
[2/4] KVM: x86: WARN if user-return MSR notifier is registered on exit
      https://github.com/kvm-x86/linux/commit/b371174d2fa6
[3/4] KVM: x86: Leave user-return notifier registered on reboot/shutdown
      https://github.com/kvm-x86/linux/commit/2baa33a8ddd6
[4/4] KVM: x86: Don't disable IRQs when unregistering user-return notifier
      https://github.com/kvm-x86/linux/commit/995d504100cf

--
https://github.com/kvm-x86/linux/tree/next

