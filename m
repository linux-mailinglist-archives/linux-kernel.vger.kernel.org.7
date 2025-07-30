Return-Path: <linux-kernel+bounces-751000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C1B163EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B74C567285
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF62DCF63;
	Wed, 30 Jul 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCWabnPP"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95E2264CC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890746; cv=none; b=sQ/6lecs00QZPlfj5rjOHaqRYpB1a296LlWdU9EqE6FL6mseZUVNAKU6r8qM1ShSBVz2iUsXeNYYmETS7MVUPis7ylDQyRcPzMR/5pNjHVtpUM20Z26EN9ZyZ1ZYZpseNd9l5cwTlmnO0j7/zcJ5Nf/flXmHhQ0ex7XK8jA39VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890746; c=relaxed/simple;
	bh=KaUzYMzqAKDKj1Ugou6j/Gy3Is2HqkyvG79qzuUKqs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhlznyRy1J1U3ClNn6bBBwMH5J+QnOCMj4BbHhrAiPhDVTyLXYfaxelt77S+Gr3y1bD5JBdF344+XexW1Z5gXPnKOJiCGRwmAZ1kEhbGjX8pDS5xu6gsarDJlmGkjIaYNBY8kdTxpfRgh5x8sf3uICvSgCKrFjgTv1C9BTZ8+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCWabnPP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso514571cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753890744; x=1754495544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5S/gfwjHD+oJdrQWb3m/7MfRXYBPvNIQcNwOPtzGuc=;
        b=dCWabnPPp0lAqZHAMM2DDMbLTP9xYeXNnWuoEpaaIXtEvPn3SdXzAUPhkLlpYokPlC
         RTSqP5pAmaqhgK0qsoVs0JJsful5WoOMjvZSyk2o01yVS2866xPMtOKfbhg5Ncl/IjBR
         ntHNIHoxuHT8Boe1XELkNV5t7n6xiLE3I1yMRdhiOUC/HzcDwpV310KR4vEF48h0q3zq
         13MWjECitoyQaJRtR9llJ5HbkKxBkJhGpNijMI040KpTLTWotyGQI8l7qZWGYJI+u9bE
         Yl3qCbpd7Weu605VtJ/huXkOPQOdJ6zU/PT46Q4NCUcWqsqz647VM9ygx3rRU7Dp8zG7
         uTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753890744; x=1754495544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5S/gfwjHD+oJdrQWb3m/7MfRXYBPvNIQcNwOPtzGuc=;
        b=GCQ+2pp+4Rt5BEk8eZjiyj3aEvoaDCbeTKXjzydb4cc9teNncZcSsX+Yw+MxEZyJZA
         QCLMmmAn1Fj/C7mcyC5k7xzfj8G4fWMfw4I0m7Hx3P7L3WGZB+LF7OaVchwpfBCxLam2
         BvhJLEk/T4CGvFfYY96XuVj1hP0rEyp5b7HnSfHOknjhW0MS4/w6xJIfulYXUUgpuU+V
         9TphWw9yUdhZ735hYzPt21otT56tN2kGxQ95TfK5pI4OjJ9zE/m4bnSi1enonlGiGd35
         SqQxKlEwd7xzA7RsvcahcKcWAgY6eJt0Bo7lR9SxFAr8wSm722lN+t8mIaq4y+kS3dZp
         zHPA==
X-Forwarded-Encrypted: i=1; AJvYcCWmHtyzTmtJCy5pZRkqytmbdZ9XRMf4G1zVZWKmzRJToQCbnjeml40l9+u1jwVR+2foYMsb+Z1PfAgT4kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xQuPPjhOetVxbWisNfBnFh/+4IPedsRxU3ev8II0gy4j5yRJ
	1AnYqdwdGf6N3jfsX/y8W2M+WeytX5UOX6ztFWgnJulLQQiKkUd/Xh9x2z/kVv+Q78JPsVzaNv/
	eMN0YtKiiGBpmVgs/aADlFxdii8LB3cHxcMh/+sY0
X-Gm-Gg: ASbGncvl5Qzx7A4iKWxymcW8VlNBw9iCiSVvmGfGj6y5Ns7bOxVbW55u4jjVqcszuhK
	/ZmXkfs/6Wzoa1gsTk0it8LG7bThu2emNQScFXJ/DJctU8bQBG8ziB5MpEOvTRsy/lX3yjmr2hS
	xOw59FIvXQh7t2gHCTHuu8qj5gndiBoJ/fRhnkV7+ndQXvLAetFYhGqAH2u1w/As/7NJByE2f1D
	VcDn9g=
X-Google-Smtp-Source: AGHT+IHCoggrbKuqrS/V3GqDELMmyPu68zQZy/cgUabllEs7qJ283gO9wOXP3Z6D76RtekV7nYcliE9mbdlhJ89jyUs=
X-Received: by 2002:a05:622a:b:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4aedf608f0emr3661281cf.9.1753890743755; Wed, 30 Jul 2025
 08:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-25-seanjc@google.com>
In-Reply-To: <20250729225455.670324-25-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 30 Jul 2025 16:51:47 +0100
X-Gm-Features: Ac12FXzaE318ERqLrJiYydulNyZlDipqqavrDa-QlTdUT7g8r8Yi-Dt4-p51ElI
Message-ID: <CA+EHjTx7V=bHZ3HTN+gK+MzNhwDehiqQXG2r4AYmMKDufYGOww@mail.gmail.com>
Subject: Re: [PATCH v17 24/24] KVM: selftests: Add guest_memfd testcase to
 fault-in on !mmap()'d memory
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 23:56, Sean Christopherson <seanjc@google.com> wrote:
>
> Add a guest_memfd testcase to verify that a vCPU can fault-in guest_memfd
> memory that supports mmap(), but that is not currently mapped into host
> userspace and/or has a userspace address (in the memslot) that points at
> something other than the target guest_memfd range.  Mapping guest_memfd
> memory into the guest is supposed to operate completely independently from
> any userspace mappings.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index 088053d5f0f5..b86bf89a71e0 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -13,6 +13,7 @@
>
>  #include <linux/bitmap.h>
>  #include <linux/falloc.h>
> +#include <linux/sizes.h>
>  #include <setjmp.h>
>  #include <signal.h>
>  #include <sys/mman.h>
> @@ -21,6 +22,7 @@
>
>  #include "kvm_util.h"
>  #include "test_util.h"
> +#include "ucall_common.h"
>
>  static void test_file_read_write(int fd)
>  {
> @@ -298,6 +300,66 @@ static void test_guest_memfd(unsigned long vm_type)
>         kvm_vm_free(vm);
>  }
>
> +static void guest_code(uint8_t *mem, uint64_t size)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < size; i++)
> +               __GUEST_ASSERT(mem[i] == 0xaa,
> +                              "Guest expected 0xaa at offset %lu, got 0x%x", i, mem[i]);
> +
> +       memset(mem, 0xff, size);
> +       GUEST_DONE();
> +}
> +
> +static void test_guest_memfd_guest(void)
> +{
> +       /*
> +        * Skip the first 4gb and slot0.  slot0 maps <1gb and is used to back
> +        * the guest's code, stack, and page tables, and low memory contains
> +        * the PCI hole and other MMIO regions that need to be avoided.
> +        */
> +       const uint64_t gpa = SZ_4G;
> +       const int slot = 1;
> +
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       uint8_t *mem;
> +       size_t size;
> +       int fd, i;
> +
> +       if (!kvm_has_cap(KVM_CAP_GUEST_MEMFD_MMAP))
> +               return;
> +
> +       vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, guest_code);
> +
> +       TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP),
> +                   "Default VM type should always support guest_memfd mmap()");
> +
> +       size = vm->page_size;
> +       fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP);
> +       vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
> +
> +       mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +       TEST_ASSERT(mem != MAP_FAILED, "mmap() on guest_memfd failed");
> +       memset(mem, 0xaa, size);
> +       munmap(mem, size);
> +
> +       virt_pg_map(vm, gpa, gpa);
> +       vcpu_args_set(vcpu, 2, gpa, size);
> +       vcpu_run(vcpu);
> +
> +       TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
> +
> +       mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +       TEST_ASSERT(mem != MAP_FAILED, "mmap() on guest_memfd failed");
> +       for (i = 0; i < size; i++)
> +               TEST_ASSERT_EQ(mem[i], 0xff);
> +
> +       close(fd);
> +       kvm_vm_free(vm);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         unsigned long vm_types, vm_type;
> @@ -314,4 +376,6 @@ int main(int argc, char *argv[])
>
>         for_each_set_bit(vm_type, &vm_types, BITS_PER_TYPE(vm_types))
>                 test_guest_memfd(vm_type);
> +
> +       test_guest_memfd_guest();
>  }
> --
> 2.50.1.552.g942d659e1b-goog
>

