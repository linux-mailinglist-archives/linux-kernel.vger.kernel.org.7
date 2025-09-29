Return-Path: <linux-kernel+bounces-836044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB89BA89C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1588189E576
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72E22C2368;
	Mon, 29 Sep 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b713UB49"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0D2C21F8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137915; cv=none; b=DO4kWebLZt4vgppDRDOafDjg1yscvS3cZS5iJkWj2CfOrjXMYGJv0f0Y4ST3lWb8f6pVymXNx9LQ6JvJwW87GD9EGjnW5zKhD1bPlF0AIzEoVsx4Qr7AfkGoU7oHTzPbI6M/Ko5Qo0TPdEgrT2z3Mt12dDGdpMK6I3LgB8jAlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137915; c=relaxed/simple;
	bh=Mhiwglh83dR/SnDGLaM9PVdMb7cpWmQ01Cx2/nPr060=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEXPbYjly7EXyMWvwLvhgz5N2o0cOp8g1ATNeCIwZV6acGZfsjdmVOtzjBLxwuWDDXehjIWqKYTFMQ1+w+1+foliu1wOejClnC2oma1/XtDNNePztxHPjqEoUM/Lto3woESVEQ/5ypazuw+HSO66igr4XAJLyWUHNHUbw14WLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b713UB49; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4de60f19a57so787691cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759137911; x=1759742711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rGkigfAyqdYVUscR7ZUffIIH2bgyKFFHO2VMToDJdps=;
        b=b713UB49Jkyo1SV9oF2mDKI+w7MN/hwTvWPfVC9NEA85Az0QN0mamTj07+V7+w/Qjd
         hKyW5OBZ8YeeNxv7rRq/SljesJgu7PySMZw3DqgNQuosJ6MUexEYGL+L/vuG/R6f8foo
         np3bPiLr10JMR6TA+A1LC/bAbKETqbGLe3ZtkbWk3gXq/Qu0ez11CDSF3NjYbVA3/Lqk
         3mc1DYHGjms1Qyn0HJXzHGkSDfyOOHB79AZukMNBRnLIL/2pOYPK/USq9pDsyR5N8t5D
         Qklv6mjp8yuDVjP9Jz0Gz9aKApd6rvdd5dlxnMU65mhX3pPzy9E7ennCIEnz26Q06lOE
         1lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137911; x=1759742711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGkigfAyqdYVUscR7ZUffIIH2bgyKFFHO2VMToDJdps=;
        b=GgpwdozZZZrHU+fBSooNeV0P1EvpFojQINHT5Zz54y8AftqkTZEEHlhmkNfa8gmhcY
         UAW4lExKkc4E0gbsInNHGkAJc+Nrjz6haz084Vl2MGxx3Xy1aOGUi7a0QltDMRkFhtOB
         37+HNvyb1mYf+JNNY1jGKDMev2pRBiVMy7uU8xZWgSlqkOJR83CVNxfy6nkuJcgH2cz9
         kqAQGyA5l95vXXLvDzaItUQDys5x2ovRX2SWExtO3XEwjOZ/i/bk2YlkilXnXFOrZgG/
         cH8tEhtembg7VVLTPYiLpHNBmPQv/z5dk8IRjk6lvXmhpVE6sbLurvoZga/PXio41/uH
         9pAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq4qI1sjC3E8CNz+k0w2OPFczi9si9MS8U0D78beQ0N2+KHJ6HkyIS/dOu2KxmwdlsOZWrSDWHzDbw1+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0p7KFdovpUDAHjQS4nvVj5IBVRenaaCpo3Nunn91qqRz9gWFh
	3QV9hWaybk8uq7iQfVtHtm5CvDnLtTF+5xm9rPaA7JHwBgi4DUOOeaOZsSDZ5n8Yu2g4fvTUCaN
	9tM9c8jqot4ACL0NLTYHpwroV7xZsPoHfSGtcqDmW
X-Gm-Gg: ASbGncvU+kGRf0qqrDtZ5/35O78T/yfG/idp27eaJ/NYSoAfsCnAmd0cLPmSDPD/c8Q
	CfCj0AEGWbKkmd4GU/3/DODxGrUmTxF7a+Mw0EGx3f/W9IpknHa7yOQUABANmmjiM3PPXgMpsR/
	YkI15XGJt4jW0NrmJ6RIZcJZW4kMMWklZSv6S49YTd92Hii9i48CEoL7Mr4s/oNAuXzAUnO8qK2
	g1nCaF0ZK+1qWU=
X-Google-Smtp-Source: AGHT+IFbxIUeeYLmrN/zVl2ZddOZX/P3Bp9UTx658splbU4cSDC0XUgQmjzGs+KPfM901I9gtJY3Az5caBPz0X2fYvA=
X-Received: by 2002:ac8:5a87:0:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4e23233db7fmr1095411cf.8.1759137910878; Mon, 29 Sep 2025
 02:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-7-seanjc@google.com>
In-Reply-To: <20250926163114.2626257-7-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 29 Sep 2025 10:24:34 +0100
X-Gm-Features: AS18NWB96gb-U959oFUbLZwg6gqzQV77KikNfN25VVz26r3yCEgPbVVs4-wDqOE
Message-ID: <CA+EHjTxhyPRVbWWK6h86Wfw2oZbOVSekwAjKNxW-Ab=qaOhk3g@mail.gmail.com>
Subject: Re: [PATCH 6/6] KVM: selftests: Verify that faulting in private
 guest_memfd memory fails
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 17:31, Sean Christopherson <seanjc@google.com> wrote:
>
> Add a guest_memfd testcase to verify that faulting in private memory gets
> a SIGBUS.  For now, test only the case where memory is private by default
> since KVM doesn't yet support in-place conversion.
>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>


Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 62 ++++++++++++++-----
>  1 file changed, 46 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index 5dd40b77dc07..b5a631aca933 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -40,17 +40,26 @@ static void test_file_read_write(int fd, size_t total_size)
>                     "pwrite on a guest_mem fd should fail");
>  }
>
> -static void test_mmap_supported(int fd, size_t total_size)
> +static void *test_mmap_common(int fd, size_t size)
>  {
> -       const char val = 0xaa;
> -       char *mem;
> -       size_t i;
> -       int ret;
> +       void *mem;
>
> -       mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +       mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>         TEST_ASSERT(mem == MAP_FAILED, "Copy-on-write not allowed by guest_memfd.");
>
> -       mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> +       mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> +
> +       return mem;
> +}
> +
> +static void test_mmap_supported(int fd, size_t total_size)
> +{
> +       const char val = 0xaa;
> +       char *mem;
> +       size_t i;
> +       int ret;
> +
> +       mem = test_mmap_common(fd, total_size);
>
>         memset(mem, val, total_size);
>         for (i = 0; i < total_size; i++)
> @@ -78,31 +87,47 @@ void fault_sigbus_handler(int signum)
>         siglongjmp(jmpbuf, 1);
>  }
>
> -static void test_fault_overflow(int fd, size_t total_size)
> +static void *test_fault_sigbus(int fd, size_t size)
>  {
>         struct sigaction sa_old, sa_new = {
>                 .sa_handler = fault_sigbus_handler,
>         };
> -       size_t map_size = total_size * 4;
> -       const char val = 0xaa;
> -       char *mem;
> -       size_t i;
> +       void *mem;
>
> -       mem = kvm_mmap(map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
> +       mem = test_mmap_common(fd, size);
>
>         sigaction(SIGBUS, &sa_new, &sa_old);
>         if (sigsetjmp(jmpbuf, 1) == 0) {
> -               memset(mem, 0xaa, map_size);
> +               memset(mem, 0xaa, size);
>                 TEST_ASSERT(false, "memset() should have triggered SIGBUS.");
>         }
>         sigaction(SIGBUS, &sa_old, NULL);
>
> +       return mem;
> +}
> +
> +static void test_fault_overflow(int fd, size_t total_size)
> +{
> +       size_t map_size = total_size * 4;
> +       const char val = 0xaa;
> +       char *mem;
> +       size_t i;
> +
> +       mem = test_fault_sigbus(fd, map_size);
> +
>         for (i = 0; i < total_size; i++)
>                 TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);
>
>         kvm_munmap(mem, map_size);
>  }
>
> +static void test_fault_private(int fd, size_t total_size)
> +{
> +       void *mem = test_fault_sigbus(fd, total_size);
> +
> +       kvm_munmap(mem, total_size);
> +}
> +
>  static void test_mmap_not_supported(int fd, size_t total_size)
>  {
>         char *mem;
> @@ -274,9 +299,12 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
>
>         gmem_test(file_read_write, vm, flags);
>
> -       if (flags & GUEST_MEMFD_FLAG_MMAP) {
> +       if (flags & GUEST_MEMFD_FLAG_MMAP &&
> +           flags & GUEST_MEMFD_FLAG_DEFAULT_SHARED) {
>                 gmem_test(mmap_supported, vm, flags);
>                 gmem_test(fault_overflow, vm, flags);
> +       } else if (flags & GUEST_MEMFD_FLAG_MMAP) {
> +               gmem_test(fault_private, vm, flags);
>         } else {
>                 gmem_test(mmap_not_supported, vm, flags);
>         }
> @@ -294,9 +322,11 @@ static void test_guest_memfd(unsigned long vm_type)
>
>         __test_guest_memfd(vm, 0);
>
> -       if (vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP))
> +       if (vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP)) {
> +               __test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP);
>                 __test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
>                                        GUEST_MEMFD_FLAG_DEFAULT_SHARED);
> +       }
>
>         kvm_vm_free(vm);
>  }
> --
> 2.51.0.536.g15c5d4f767-goog
>

