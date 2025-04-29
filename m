Return-Path: <linux-kernel+bounces-625201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C9BAA0E26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C15841B82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BE2D29A6;
	Tue, 29 Apr 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gX5PRhX1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16D1DD0C7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935539; cv=none; b=mQhfzZ0bXFQIQKsOdHcRv1H0M5bNrnPycvLa36Js/mRAFaJxzrDAp23PiNk1wrlVm0cibTjlAn2V5d6CUJBRpw7mcjTr0AiVwWlrUs8V+vPAqU0CyW4REe+9pzHwO7OEjQQXFTgu8DDScAJyC0lYnT1usLUSFO427/7ULyIyEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935539; c=relaxed/simple;
	bh=KXkWYlsKpNS7N/qD4ZVXK0LUxaL12ArIUs7VrBlL4YE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pc1SCfZPeiWSyaTXRPEiO+eE+KKodFuOvz5FEbVoSsjgcIhfe+L3qN9BkYJEjTcLRClYabqNTJQqDjQT/bgK1wnBTUcsnnExXAyKkKpTZ5OSdf+HVKDabIGVSfWdPChrX4S3COhr8RT+93OHodQffuT48wnHeOUz5C+H3sNc7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gX5PRhX1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd27d51fso4622546b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745935537; x=1746540337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3iRogAF7jMgKnBN33JdvjDUDJ4zwxPn8g8eIzFTGjk=;
        b=gX5PRhX1YoS7a2WlhZXTf6DIeoTRjNLsiV6nrF0Wry6tcLheIt5W4tYOeqAxM+B0ob
         SNR6TfVfn9ti8GVV52OTR3gDfXgTX1scN6nhnK97vbVHSdVvhOR8po416MYxmQpqGPy3
         uVcci5Og8ERFeyblLtEn9pqr5xTf6dlp2uitBBtABEUwGfU+gcroXWenhYTUD3DNKSAU
         Mq8fhMVMMW2NA3G7S2jKlzOw42ugWUImB5y8G0qQsfpl8cklIWazJi03FNqoTe1F18IJ
         6t5EFUQLVRLtxvQmQvUvBfEcm5zOOu0JEOZikfUmfHP6ilCkIGx1mRMLe7JCmgXR4mTd
         uo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935537; x=1746540337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3iRogAF7jMgKnBN33JdvjDUDJ4zwxPn8g8eIzFTGjk=;
        b=euG6jJp0eyV+jo+hFn9KSAob8MDFy5ihS1/6KsZj9QFJUeOU4L5hQ4QCBb/GdlVpK7
         vGffkwu7DBIBkzHZ0t/o9y3+bdOGNWvLIOHIqgiEEanbiIqRSW90zZIJG7VkNrKFtnMj
         7nGREIAr1Gq4sdTnr67EcyOIMKPM+2w9ep0cXLVi0+/eyRnG3U/VQ5+IpMpGUZTo3370
         IWwImRXx/0OzfgcOmwSlvHr8AOy0iw03ofWdRYEpjzAEIxPaXVvH0VuaBzHUHrIteP2k
         Jbj4ESZ+qdupT00IyEWKlU97x+ilSeob9rcxhAiJmmwfgRjaZls7zilUVyalg7TNYoNf
         qXpw==
X-Forwarded-Encrypted: i=1; AJvYcCXxiFK92PbksXJPny2Z+PjJ1RvLI+i40pEaGnM7WZ5Xgr+bTTL8sDzcym29rsj4QxmRpVbm1O3M7W/1NAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAYdAqZWVm+yvpMzlOyMbNk5lpUkeBeIMa6X4pWK+NGuUgB50
	B9Ktv+vePuevhrjx4R6y8iuTbYjbmCMqSW77xYp1shy/b+EQS37mz9CSvG7KHCCFLa92SoyIyf+
	dKg==
X-Google-Smtp-Source: AGHT+IHPyWKc1pFYiTsLltKjh9fqoRS9IPxep5Tbp0bhwmCfOvbTbBn36Xk8y6s9Kw1UL81V/oIiaLfCk1c=
X-Received: from pfbb10.prod.google.com ([2002:a05:6a00:ac8a:b0:730:7485:6b59])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e9b:b0:736:4ebd:e5a
 with SMTP id d2e1a72fcca58-74027231530mr5583562b3a.20.1745935536957; Tue, 29
 Apr 2025 07:05:36 -0700 (PDT)
Date: Tue, 29 Apr 2025 07:05:35 -0700
In-Reply-To: <20250429100919.GH4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414111140.586315004@infradead.org> <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net> <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
 <20250416083859.GH4031@noisy.programming.kicks-ass.net> <20250426100134.GB4198@noisy.programming.kicks-ass.net>
 <aA-3OwNum9gzHLH1@google.com> <20250429100919.GH4198@noisy.programming.kicks-ass.net>
Message-ID: <aBDcr49ez9B8u9qa@google.com>
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 29, 2025, Peter Zijlstra wrote:
> On Mon, Apr 28, 2025 at 10:13:31AM -0700, Sean Christopherson wrote:
> > On Sat, Apr 26, 2025, Peter Zijlstra wrote:
> > > On Wed, Apr 16, 2025 at 10:38:59AM +0200, Peter Zijlstra wrote:
> > > 
> > > > Yeah, I finally got there. I'll go cook up something else.
> > > 
> > > Sean, Paolo, can I once again ask how best to test this fastop crud?
> > 
> > Apply the below, build KVM selftests, 
> 
> Patch applied, my own hackery applied, host kernel built and booted,
> foce_emulation_prefix set, but now I'm stuck at this seemingly simple
> step..
> 
> $ cd tools/testing/selftests/kvm/
> $ make
> ... metric ton of fail ...
> 
> Clearly I'm doing something wrong :/

Did you install headers in the top level directory?  I.e. make headers_install.
The selftests build system was change a while back to require users to manually
install headers (I forget why, but it is indeed annoying).

