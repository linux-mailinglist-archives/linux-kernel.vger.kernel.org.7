Return-Path: <linux-kernel+bounces-836041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCEDBA89AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D1316432E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912328725E;
	Mon, 29 Sep 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgTo8sms"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6F2AD16
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137894; cv=none; b=LKfyq3fQGyjXy4zs+y3EcG0juPkSFA71p1wlGyA61U02vKaNw0tMcCG0qN3KOu9y8fTcW04E9WUNb6eeHR+FkjC4ICaV7tZ2WP5NQZ/K6f91Y2LPcavdu9iYat2250KtDItflchDOaey+Keg4hNO5hCEZa+NlLmW261DHJdSEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137894; c=relaxed/simple;
	bh=wZ1kaw2tdBtKk+b1Jh3nI/IQqxx3O5Y5ZvL0E+lpP3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtK7C5y1fSUnqiEmXkFrqosz0s6QOost1eAq81K4dp80d3LbiN4LdyAidtFSEY2rj8Za3L+1l5NIZsPSyUuIluKXRI1ggyldvSFiifJDi4JoRDigySxKXYG6BXlputEmZ+uq72daz7mDN29jf1euSWgcjuToMG9AogGN7Np+dNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgTo8sms; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4de60f19a57so787591cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759137892; x=1759742692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MRVcTlJL1eQx8pGoi4WfarmtfySRYrpiJsivfm9L5qU=;
        b=lgTo8smspgitqzbBgiCWRNesvYd3jr5smSA1VW2/cUUBO65WNYKk4IQM/jlIWwYb7I
         e4mHBtSZy3hHHKbr/AUM09bteCz3+gczUZyvtFqa6SEx2bP8kYyeo6iDje7A+konpo2v
         pasRXLVIhKRqrG2Kud784di4I4PyvEa6WQ8tQSp1bfwp5RNa4+D1RimCzZsRs1DesYsU
         uisr+b/B32abGyTicamTWdqeTixJkHZj7MMGmBd1g+BnVuV+X+T/9mt1zy/HN4agS2FM
         6IIM0ai+dsaDfErlzO41PJ8C1oBih63RYch8Lfx65KEs8PNn7Vn1hqTmw6CxORddZ4cK
         FUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137892; x=1759742692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRVcTlJL1eQx8pGoi4WfarmtfySRYrpiJsivfm9L5qU=;
        b=LjzaQGuf1IQJu0GFaGWsuYNiddbHHX1Xo8CnJIEbG1Fv9g1QkXb3XVCpYh6qdWP68v
         W2rj38yfH1mq+du+vH0VgPnJl5Oaalck5nYPqjR+lreDNFnQyIzwK4EN750h17mOtAFl
         2cYXH9d7YuyvSVJJlfbL+0BdOExcbv9kFgLinIa6Y7252SpzoQt5MPxzZJEJj83lUO0c
         CxgvwzxyUz1nLCEDgXgnoHm9YxDBnhdFRbgLf4QiWytRg2P4isbOYnRBGDPdg6wqQtmy
         +CmeYIoPv6FOJqHfqtCjkPR5rIurSxFijwJ1YnHRpBtQ6muZiV9LINTzjAmFKHl0/aj5
         8H1g==
X-Forwarded-Encrypted: i=1; AJvYcCWjRl0eeQniP1RsyYzwdqknRfJminl8usTs716gGjII06iTnnSuuLi8097qnjbKWyrZ5D5v7AJlDOoiHk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1L66mty1SSXTkzj0tvKXj8KWM6ZzlqG8JL2FtfyhdEl8z4OtI
	yN8ARi+aDmjtRPfsrDG3tklRZCwnLRFevnPADsLB8eRJM69AiMwp9gYKO98doF/txx4yA0JXNbn
	+yR3d3svWNDRYTnYQ1W+D4ccYLAlKVgPBy+Rmsmwh
X-Gm-Gg: ASbGncuU23AX4k8rI+eWdmawiVnTYFkM1XJQooTNNZkEyK3KAI3hv9npIAvfznz+4Jo
	QTVF7XuxLflQuX1z9zO1AwPEo9S6C3DLr8iq0zE+58rAX5un7/35FHU1U/staxl9XqDqz/zdYvP
	ufMXE+jXf+9rD2F9NvPDihrOKvX7Y2s5VTmB8AuMYm+kkOnHGYFkBgYVD+5boZzuaxfMzryVUMI
	drhoTaZrmdE/xblU9KSXIv9nbHnoftOtKaT
X-Google-Smtp-Source: AGHT+IH2D9DphBCRuOkppVEKmXtZNZ2q7cyhsvNHxiUL5nNhvJ5tEn/ccn5PQX0Yskjtas0xW32/md3sH7RWPEtWpQs=
X-Received: by 2002:a05:622a:1a0d:b0:4cd:84db:a326 with SMTP id
 d75a77b69052e-4e232918f91mr1227031cf.16.1759137891766; Mon, 29 Sep 2025
 02:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-4-seanjc@google.com>
In-Reply-To: <20250926163114.2626257-4-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 29 Sep 2025 10:24:14 +0100
X-Gm-Features: AS18NWBe3URlgxtzfYGoowfV7IJBj4oZVMqzsvcx-Q5dGEYrAs1THHtixY02G1Y
Message-ID: <CA+EHjTyN_YTkn5k5eqY1gdbQ+SQX_0C1cDRzEhvLoRQRYcp7RQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] KVM: selftests: Create a new guest_memfd for each testcase
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

On Fri, 26 Sept 2025 at 17:31, Sean Christopherson <seanjc@google.com> wrote:
>
> Refactor the guest_memfd selftest to improve test isolation by creating a
> a new guest_memfd for each testcase.  Currently, the test reuses a single
> guest_memfd instance for all testcases, and thus creates dependencies
> between tests, e.g. not truncating folios from the guest_memfd instance
> at the end of a test could lead to unexpected results (see the PUNCH_HOLE
> purging that needs to done by in-flight the NUMA testcases[1]).
>
> Invoke each test via a macro wrapper to create and close a guest_memfd
> to cut down on the boilerplate copy+paste needed to create a test.
>
> Link: https://lore.kernel.org/all/20250827175247.83322-10-shivankg@amd.com
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index 8251d019206a..60c6dec63490 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -26,7 +26,7 @@
>
>  static size_t page_size;
>
> -static void test_file_read_write(int fd)
> +static void test_file_read_write(int fd, size_t total_size)
>  {
>         char buf[64];
>
> @@ -259,14 +259,18 @@ static void test_guest_memfd_flags(struct kvm_vm *vm, uint64_t valid_flags)
>         }
>  }
>
> +#define gmem_test(__test, __vm, __flags)                               \
> +do {                                                                   \
> +       int fd = vm_create_guest_memfd(__vm, page_size * 4, __flags);   \
> +                                                                       \
> +       test_##__test(fd, page_size * 4);                               \
> +       close(fd);                                                      \
> +} while (0)
> +

Can we have a const for total_size that sets it to `page_size * 4`
instead of hardcoding that value twice?

With that:

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad






>  static void test_guest_memfd(unsigned long vm_type)
>  {
>         uint64_t flags = 0;
>         struct kvm_vm *vm;
> -       size_t total_size;
> -       int fd;
> -
> -       total_size = page_size * 4;
>
>         vm = vm_create_barebones_type(vm_type);
>
> @@ -276,24 +280,21 @@ static void test_guest_memfd(unsigned long vm_type)
>         test_create_guest_memfd_multiple(vm);
>         test_create_guest_memfd_invalid_sizes(vm, flags);
>
> -       fd = vm_create_guest_memfd(vm, total_size, flags);
> -
> -       test_file_read_write(fd);
> +       gmem_test(file_read_write, vm, flags);
>
>         if (flags & GUEST_MEMFD_FLAG_MMAP) {
> -               test_mmap_supported(fd, total_size);
> -               test_fault_overflow(fd, total_size);
> +               gmem_test(mmap_supported, vm, flags);
> +               gmem_test(fault_overflow, vm, flags);
>         } else {
> -               test_mmap_not_supported(fd, total_size);
> +               gmem_test(mmap_not_supported, vm, flags);
>         }
>
> -       test_file_size(fd, total_size);
> -       test_fallocate(fd, total_size);
> -       test_invalid_punch_hole(fd, total_size);
> +       gmem_test(file_size, vm, flags);
> +       gmem_test(fallocate, vm, flags);
> +       gmem_test(invalid_punch_hole, vm, flags);
>
>         test_guest_memfd_flags(vm, flags);
>
> -       close(fd);
>         kvm_vm_free(vm);
>  }
>
> --
> 2.51.0.536.g15c5d4f767-goog
>

