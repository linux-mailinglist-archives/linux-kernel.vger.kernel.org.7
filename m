Return-Path: <linux-kernel+bounces-848810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B4BCE9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D647C4FCC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E9E302CCA;
	Fri, 10 Oct 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1YD6n7z"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AF302CC9
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131846; cv=none; b=tV7lQCY0lUJ2VTMzTSswd0J3klLyjMMtvCspskD1KZLMhADb8Djjd1+KMmoO5L6VHms8/jpjuJxmc7z51Nt/63MFZmUm9g9leQLAoSZ3k7kuVlMfgiDENtjHWRwFY96vn/wgRHf1muBG4SqHjOWzgdVMOT2g+5+eVRaQ1QfbSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131846; c=relaxed/simple;
	bh=8zKyXaHOvmn3AJoM4OXjo5ZeZBPGV2jnNiJNSEkUuNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mGRyYncATVAYQCGEe2BGXctY/U9jxR018RjkNNuen69kIt49J89InoEgC+XAZwhSWgT3lnuR9pQnAr2qIHBNJYldzp7VjORwCzCZvs8APXsC21NFV+M42vo4nbENIFTD4TsCpv5imZPYrEaqJXQGyYwqwMfdtb+2UDRuNkAyQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1YD6n7z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee41e062cso71519605ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760131845; x=1760736645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdza0wCNfmbut06x9h8ZEcd5rkvPKD5X3a2HlIm2klA=;
        b=b1YD6n7z8250tO0RyK5usSDxcPCanuvqfYf3GlDW0R1OSoA5TMSCwwOPqfmake81E6
         q39CIo2fdTojkyl4P8nWP++/HTLMpgFBgya4EDS1GrAp+oxKtVpIHVgnjKDngaDW/yQT
         9zw8yYAvjbwuaA/4HaL9MkKIxiGa5e6SX0u3T9Yhv+TgHIiuwwP5U/gTZOk0bPjgB57F
         GLms1d/qH5A7246d7GMdOzgApWa8h/+O+qJBf1pZPj1PcHxZyUKpNdo2ngJZ4klFnyp0
         FLgYb68dYDKnn/EzbD5N6mF4eLtrcvSWyg6ihLlJUwcIpaDV/x5vp8GbXul8VRua2EW2
         RKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760131845; x=1760736645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdza0wCNfmbut06x9h8ZEcd5rkvPKD5X3a2HlIm2klA=;
        b=r32kqafraGiG2F1VptUpNzGK9iyR5VGvOyXnmewiq9pD8spVGgAoJwnxLIwB+yV8Xa
         WZRS2Qbnztd/r9XS2W4paHZ79e29OSsPqzEnQogol82LbKfjxVokrliaHg3r5A1HAOiW
         1STnomW2+PVES1nzmEewnzhHvo5i0nnzotOJ/8oWaXrn7HCLn+ev0vAkibrEwZesUyLq
         DbN0Q+eII7kFJYg1NohAfXgKjtHQFlDQvzfUIotsn8/92FTwZTA1robOENah0QA/f6t1
         pz0Jths3Gbd5UG2VxOmR3yp1yo5z92r7j2wNsXq58NaNxYh1BfMFkTnCcBSxjyP5rAQV
         cWiw==
X-Forwarded-Encrypted: i=1; AJvYcCWRI2vpxzKHDft+tKeYV3yW88KvdkwPqLcwOl8uFZOQI9PUPkUGTl5FOpSxN+wGOPvws7Zf4fAnKgWljXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2QzEhw5aTh7NCuSK4ITlh0MxpFfjPxxwOvkO4n4ayCm9t9EL
	7jOdEyxyDoZDgej1vTewX2Mc0VvCsCdlYHgwKGcwV9Qw0+Zi7QoVg29ka2+bbEX/oitFZlmvcip
	C1tdm9Q==
X-Google-Smtp-Source: AGHT+IEygGJbr/jdLmJKPXL2+VbE83XJAixGp4cjBDCbyY0/1d/YUT7lEZRif22jY2RS+Di7munkUEut4XY=
X-Received: from pjbkz1.prod.google.com ([2002:a17:90b:2101:b0:32d:e264:a78e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d11:b0:32e:7270:94a4
 with SMTP id 98e67ed59e1d1-33b5116a3c5mr19014051a91.14.1760131844583; Fri, 10
 Oct 2025 14:30:44 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:30:34 -0700
In-Reply-To: <20251003232606.4070510-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <176013139711.972957.8677531848796740648.b4-ty@google.com>
Subject: Re: [PATCH v2 00/13] KVM: guest_memfd: MMAP and related fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 03 Oct 2025 16:25:53 -0700, Sean Christopherson wrote:
> Fix several flaws in guest_memfd related to MMAP support, the big one being
> a lurking ABI mess due to MMAP implicitly inverting the initial private vs.
> shared state of a gmem instance.
> 
> To solve that, add a guest_memfd flag, INIT_SHARED, to let userspace explicitly
> state whether the underlying memory should default to private vs. shared.
> As-is, the initial state is implicitly derived from the MMAP flag: guest_memfd
> without MMAP is private, and with MMAP is shared.  That implicit behavior
> is going to create a mess of an ABI once in-place conversion support comes
> along.
> 
> [...]

Applied to kvm-x86 fixes, I'll send a pull request early next week (I've had
these in -next all of this week, though the hashes will have changed due to
rewriting history to add trailers).

Thanks for the reviews!

[01/13] KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS
        https://github.com/kvm-x86/linux/commit/d2042d8f96dd
[02/13] KVM: guest_memfd: Add INIT_SHARED flag, reject user page faults if not set
        https://github.com/kvm-x86/linux/commit/fe2bf6234e94
[03/13] KVM: guest_memfd: Invalidate SHARED GPAs if gmem supports INIT_SHARED
        https://github.com/kvm-x86/linux/commit/5d3341d684be
[04/13] KVM: Explicitly mark KVM_GUEST_MEMFD as depending on KVM_GENERIC_MMU_NOTIFIER
        https://github.com/kvm-x86/linux/commit/9aef71c892a5
[05/13] KVM: guest_memfd: Allow mmap() on guest_memfd for x86 VMs with private memory
        https://github.com/kvm-x86/linux/commit/44c6cb9fe988
[06/13] KVM: selftests: Stash the host page size in a global in the guest_memfd test
        https://github.com/kvm-x86/linux/commit/3a6c08538c74
[07/13] KVM: selftests: Create a new guest_memfd for each testcase
        https://github.com/kvm-x86/linux/commit/21d602ed616a
[08/13] KVM: selftests: Add test coverage for guest_memfd without GUEST_MEMFD_FLAG_MMAP
        https://github.com/kvm-x86/linux/commit/df0d9923f705
[09/13] KVM: selftests: Add wrappers for mmap() and munmap() to assert success
        https://github.com/kvm-x86/linux/commit/61cee97f4018
[10/13] KVM: selftests: Isolate the guest_memfd Copy-on-Write negative testcase
        https://github.com/kvm-x86/linux/commit/505c953009ec
[11/13] KVM: selftests: Add wrapper macro to handle and assert on expected SIGBUS
        https://github.com/kvm-x86/linux/commit/f91187c0ecc6
[12/13] KVM: selftests: Verify that faulting in private guest_memfd memory fails
        https://github.com/kvm-x86/linux/commit/19942d4fd9cf
[13/13] KVM: selftests: Verify that reads to inaccessible guest_memfd VMAs SIGBUS
        https://github.com/kvm-x86/linux/commit/505f5224b197

--
https://github.com/kvm-x86/linux/tree/next

