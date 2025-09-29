Return-Path: <linux-kernel+bounces-836194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70CEBA8F87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530863C2E98
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1F2FFDC9;
	Mon, 29 Sep 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYlo/FtA"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC22F0C64
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144126; cv=none; b=dY1d1xsqAXwE27wsfZ6G1kKb+3LOeWkWmLvY/YjChCUsvEU+Z6nsQLwwMpcifr5z4CDR0GWf96AybxAXGdTRBxfdLZx3iblZPUUMtFo9nQ7jvi9bsd0BZvnKocx4dqVstBJuFSAdfPGwmg2laZjf/fOHQC+B5GwclWB9bejzFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144126; c=relaxed/simple;
	bh=hdjpsqBQu61DyVagvgahThUPYRdAH4vy0QtTHyTWGxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=geOp7VoOtVR0qKoezL/b9fF/omNpWXKH0Cz4wcDtpIpdU9OUsQrLaYSZ+JNL9WZLYw1siQaFaeMiefzqFdbOFH1DoQXVDWZvYN+IhJjIVgqoM0HeRCNEbGWBCsBmY1zZqeHhjhrJMT9T/ueJnQ3JXYotxxzbP+L3rryrhy3a3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYlo/FtA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272b7bdf41fso48232135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759144124; x=1759748924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2yjbN9juVGMo8fZY1zQGvyTlUSOLdTWsAnWf7KowEQ=;
        b=zYlo/FtApOPG9ShZ4BJEghrPvew7BAyKE9OtXkWZMnRgpn2svJVSmJ8DoUltvxdR3h
         7wAy51op15KMygMMQEUzYYWuDovH5QRvOe3ii+pHPDwSCSNyTiKvW0ASXzwq9hCSsf0H
         l1/HjjkiIT8EOa88NLFRd3ecGqGnT4K6no1BO72toUlGh3Gpce84d+NUN6oNhAg8tjFr
         0DpRwzSZFdILnzFpmK3wl4173Sef6zPKElIP1FlA0yzo/pNE321EN9y2mLO2xsV6akIb
         V71booQusask4z834TkCVRbFB9khtiHwUiNhCv5ZVmyinOt2AJqARI7pZRo8HtXX1yUi
         mRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144124; x=1759748924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2yjbN9juVGMo8fZY1zQGvyTlUSOLdTWsAnWf7KowEQ=;
        b=CEn/4a/5ExVpb/0aILa+ylU2PA2Hn9jhKLPBeyeXh4T+FeD66uoQ1VEgS1oNo2GJp0
         AWIdr552qHnnx9BcUUOYNUMUEwwkouzrZ0HY8XAk74OVFhLONResRawnalrf8yQMBWMF
         q0aBS3e5bvvACe2Zb83lTUeziEVa8+GdOaCvwj75Fc42YgsYi7ZJPteqHRfx+LJCr+Vq
         Y3WoyvE+c4v9I6p1gmIXBECYK4H//jEK7GyAoE6DaHTgA4onoq8mU0pmsSvv0nNjAVBK
         KIwquTfcYT8QpRQjkFdVp1ZuAbnlBCE27QBQtcEyVbqTyUVFN1R0kpWKcZwlh2l7NW1K
         ZmTg==
X-Forwarded-Encrypted: i=1; AJvYcCXETPsogWSrkdaKPzNLgjClZhzQxmFJ2GftPAxV+1kntl1d4Crx8Yp/06RkShBTifW23DkyBxTBLMvi2MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJz3fKauKaKkZN7il9CCMUoEC6Z6vfTCLBwJjkduoCSHEPzqWg
	P5mLlsqFrLlOtJiDeepqkv5OsU7cOOwAkTIz0ELZCDtYX3rVL1YfQhjgNUenvWpCrGfkLpjH0QT
	twyFqhLmjSSYSuQ7mGEX0t4MmOQ==
X-Google-Smtp-Source: AGHT+IHuPIaRFJxDj/huyHX+uSCwuhn3swqG4HaD2/bSj8EJanq/QQwZ5pQwhOflDYNAUnm8z9sY0oB8PxnBLw/38w==
X-Received: from plsq7.prod.google.com ([2002:a17:902:bd87:b0:267:e964:bc69])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5cb:b0:25c:5bda:53a8 with SMTP id d9443c01a7336-27ed4a31173mr183493275ad.37.1759144123876;
 Mon, 29 Sep 2025 04:08:43 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:08:42 +0000
In-Reply-To: <20250926163114.2626257-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-6-seanjc@google.com>
Message-ID: <diqztt0l1pol.fsf@google.com>
Subject: Re: [PATCH 5/6] KVM: selftests: Add wrappers for mmap() and munmap()
 to assert success
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add and use wrappers for mmap() and munmap() that assert success to reduce
> a significant amount of boilerplate code, to ensure all tests assert on
> failure, and to provide consistent error messages on failure.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 21 +++------
>  .../testing/selftests/kvm/include/kvm_util.h  | 25 +++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 44 +++++++------------
>  tools/testing/selftests/kvm/mmu_stress_test.c |  5 +--
>  .../selftests/kvm/s390/ucontrol_test.c        | 16 +++----
>  .../selftests/kvm/set_memory_region_test.c    | 17 ++++---
>  6 files changed, 64 insertions(+), 64 deletions(-)
>
> 
> [...snip...]
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 23a506d7eca3..1c68ff0fb3fb 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -278,6 +278,31 @@ static inline bool kvm_has_cap(long cap)
>  #define __KVM_SYSCALL_ERROR(_name, _ret) \
>  	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
>  
> +static inline void *__kvm_mmap(size_t size, int prot, int flags, int fd,
> +			       off_t offset)

Do you have a policy/rationale for putting this in kvm_util.h as opposed
to test_util.h? I like the idea of this wrapper but I thought this is
less of a kvm thing and more of a test utility, and hence it belongs in
test_util.c and test_util.h.

Also, the name kind of associates mmap with KVM too closely IMO, but
test_mmap() is not a great name either.

No strong opinions here.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> +{
> +	void *mem;
> +
> +	mem = mmap(NULL, size, prot, flags, fd, offset);
> +	TEST_ASSERT(mem != MAP_FAILED, __KVM_SYSCALL_ERROR("mmap()",
> +		    (int)(unsigned long)MAP_FAILED));
> +
> +	return mem;
> +}
> +
> +static inline void *kvm_mmap(size_t size, int prot, int flags, int fd)
> +{
> +	return __kvm_mmap(size, prot, flags, fd, 0);
> +}
> +
> 
> [...snip...]
> 

