Return-Path: <linux-kernel+bounces-798051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC9B418E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2B9681920
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A772EC0B4;
	Wed,  3 Sep 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xs6JibLe"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841052EC0AE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888895; cv=none; b=a8T08owGHW4gDy2LoGA5Y/4vGB+602cWc930iSn2vJLrqJrvOQfAjBhogf809Z8UVARqknKEATFmgfyzKzX0kb15pvSIWo/drsWmQd3e6NJ8Qbq2swMniubrYB5JckDgYqrQVXMq7ukZd06hoRF26JqyS6QozWJia1/i4XVXtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888895; c=relaxed/simple;
	bh=ORH9/GodysTSwJ1DXX9s07Oow+2mZpM8t/zerT4S4KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgwkqCYN+Npp7c4ChYhs+jxGZHaZ4tivF7wT12wA+cz1VBplytkaaDyvkpFOPb7faJeBJMzqIa6jnu3/TYG2QOYnxc56uzKVXm6+mNyNtNZ0KD8qnkM8iNyNf6l1BAq60ihbaiXKboGSvF6E9b1Zbq/15GUvP7IeLXFI6aSNfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xs6JibLe; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-72238e9f8ffso8338516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756888892; x=1757493692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q/+sjUPKzzeyDNJhhYPMVRz16X6YZ4H6NdmqB+0gdRo=;
        b=Xs6JibLepB6jyzefFGsOpuwB9+rTysDSVZ4Qe13IYjU/R7DlAaV30VKWzMHvvnJrQW
         Pq0bO0iIOXMmNfLzHgRjK8ldzMBWm9bqKJwOoKYQBryVmgYq+1YupsQd8eGogs590dlt
         2j70iA2U5t4Ac3Ilmy22ueciBy8wkxwGAs7bnAL/AZIOdCgf/05jMQQ+X57cmmHJuQd7
         XkqC81txgimLebj0qYYIPibh2nQ+Cg5xDtLDrtH7HsO42ctoE9pGgenQg3yTCy/+BcIF
         P528guhJ1kAWM0mQ/EGtU309GS5yMIrVWp/JQkSfbLyGMEasuxzvcNDh45Zcc3sSatcS
         7uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888892; x=1757493692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/+sjUPKzzeyDNJhhYPMVRz16X6YZ4H6NdmqB+0gdRo=;
        b=jVVdtWjAgK2YJQXezO2NxRy2W2ijrBcq+ug1cG69WuTI6mb3K9P5tkkO/5Y/HWkE+u
         qlmM5nwYMQTrgr9jvk0493lrX5EM1pxRdMhEM32tmNfdXsftteJ1cA5oKtWLQzueT+uk
         vz4ndTMtXSlu09SzGmAdG55yKOcatiR1LEWRwec1w1GcXAGUmNCJ3Bkk1GJrCMUKUXhc
         5RRFd3mhjXjx3KcBJNXiFbDkBX+EXTUzgl5h5X4chq0uNrom9rn+tlzPLk6jIRLYACgX
         PVc3xYxyKg7Wf56ZoGkpgnWeJZKCSjs5jWIZWsDjWpr7fsNbSigx1KEX4t8FiTzb6syO
         n2pg==
X-Forwarded-Encrypted: i=1; AJvYcCWuj4uYMCWWDld2tGkTuZWRLAsoaeGZlpr+9P5YuFR8UPBesPhZBbM6e65gXMKrhXepZL1Ew2uDm6UNuC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxhCMLzcFrsV6zy7tMWlvDdBpO9AMBq+0NRkCOJM8ul1uz+hU
	c5TsBShNI8pOLIFBUMry6aKw2YwS5GpY14IXLu+hlaiyRCrb3AlHY9oq0NstU02xqPwe6lEuEmJ
	sA1/9Ccja3cIhLZHBySaKlR9RlYwkolu7ZNwm9tkI
X-Gm-Gg: ASbGncs9rS3s/o6tzST/JHCavGm9Khr92HvERTGk2sUEpmi1Mrwgu7jDth9Q3lyA7OJ
	2d89P9asSwBbplZp6yZkMpt/RGl74+F8GPeyur0yygV8eCAsvvqYhUkGNJdMWImEh6Jghn0n+e4
	SHLjLYL7GSNYcq/xd10fXBCm3ifnOKFjPYQ4xQ6ief6Vi02Apg0S4d9/Dj+HUcY/ZWOZf3caei1
	Ttbx3p74smkqgtqHkbGL+7DydVOcza4BBkEXij80O0=
X-Google-Smtp-Source: AGHT+IF4vmfJfHqBQxZcNttdrfTYxkvTiSAKs+ul8tcs9Dnds2dX1cmh7ADC/k+xZJ11x/E266a48LBXxeBGRHRjSoc=
X-Received: by 2002:a05:6214:400c:b0:70d:fd01:992d with SMTP id
 6a1803df08f44-70fac73d452mr164331216d6.16.1756888891694; Wed, 03 Sep 2025
 01:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-3-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-3-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 3 Sep 2025 10:40:55 +0200
X-Gm-Features: Ac12FXwvjV2R_1nfj-fpPxtTM3Ef-lrf13TD6fJR0T0JxJ4IOXBIbC7rd81mwII
Message-ID: <CAG_fn=XWr1_Qvzqq3_dUm-3DjpCFxBz7SbYaW8OMZ1BohjVYDA@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 2/7] kfuzztest: add user-facing API and data structures
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -112,6 +112,26 @@ ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX
>  #else
>  #define KEXEC_RELOCATE_KERNEL
>  #endif
> +
> +#ifdef CONFIG_KFUZZTEST
> +#define KFUZZTEST_TABLE                                                        \
> +       . = ALIGN(PAGE_SIZE);                                           \
> +       __kfuzztest_targets_start = .;                                  \
> +       KEEP(*(.kfuzztest_target));                                     \
> +       __kfuzztest_targets_end = .;                                    \
> +       . = ALIGN(PAGE_SIZE);                                           \
> +       __kfuzztest_constraints_start = .;                              \
> +       KEEP(*(.kfuzztest_constraint));                                 \
> +       __kfuzztest_constraints_end = .;                                \
> +       . = ALIGN(PAGE_SIZE);                                           \
> +       __kfuzztest_annotations_start = .;                              \
> +       KEEP(*(.kfuzztest_annotation));                                 \
> +       __kfuzztest_annotations_end = .;
> +
> +#else /* CONFIG_KFUZZTEST */
> +#define KFUZZTEST_TABLE
> +#endif /* CONFIG_KFUZZTEST */

I think the definition of KFUZZTEST_TABLE should better be in
include/asm-generic/vmlinux.lds.h, so that it can be used by other
architectures.

> + * KFuzzTest receives its input from userspace as a single binary blob. This
> + * format allows for the serialization of complex, pointer-rich C structures
> + * into a flat buffer that can be safely passed into the kernel. This format
> + * requires only a single copy from userspace into a kenrel buffer, and no

Nit: kernel

> + * further kernel allocations. Pointers are patched internally using a "region"
> + * system where each region corresponds to some pointed-to data.
> + *
> + * Regions should be padded to respect alignment constraints of their underlying
> + * types, and should be followed by at least 8 bytes of padding. These padded
> + * regions are poisoned by KFuzzTest to ensure that KASAN catches OOB accesses.
> + *
> + * The format consists of a prefix and three main components:

Nit: s/prefix/header?

> + * 1. An 8-byte header: Contains KFUZZTEST_MAGIC in the first 4 bytes, and the
> + *     version number in the subsequent 4 bytes. This ensures backwards
> + *     compatibility in the event of future format changes.
> + * 2. A reloc_region_array: Defines the memory layout of the target structure
> + *     by partitioning the payload into logical regions. Each logical region
> + *     should contain the byte representation of the type that it represents,
> + *     including any necessary padding. The region descriptors should be
> + *     ordered by offset ascending.
> + * 3. A reloc_table: Provides "linking" instructions that tell the kernel how
> + *     to patch pointer fields to point to the correct regions. By design,
> + *     the first region (index 0) is passed as input into a FUZZ_TEST.
> + * 4. A Payload: The raw binary data for the structure and its associated
> + *     buffers. This should be aligned to the maximum alignment of all
> + *     regions to satisfy alignment requirements of the input types, but this
> + *     isn't checked by the parser.

Maybe also call it "target structure" here?

> + * For a detailed specification of the binary layout see the full documentation
> + * at: Documentation/dev-tools/kfuzztest.rst
> + */
> +
> +/**
> + * struct reloc_region - single contiguous memory region in the payload
> + *
> + * @offset: The byte offset of this region from the start of the payload, which
> + *     should be aligned to the alignment requirements of the region's
> + *     underlying type.
> + * @size: The size of this region in bytes.
> + */
> +struct reloc_region {
> +       uint32_t offset;
> +       uint32_t size;
> +};
> +
> +/**
> + * struct reloc_region_array - array of regions in an input

Nit: newline here for consistency.


> +#define __KFUZZTEST_DEFINE_CONSTRAINT(arg_type, field, val1, val2, tpe)                                         \
> +       static struct kfuzztest_constraint __constraint_##arg_type##_##field __section(".kfuzztest_constraint") \
> +               __used = {                                                                                      \
> +                       .input_type = "struct " #arg_type,                                                      \
> +                       .field_name = #field,                                                                   \
> +                       .value1 = (uintptr_t)val1,                                                              \
> +                       .value2 = (uintptr_t)val2,                                                              \
> +                       .type = tpe,                                                                            \
> +               }
> +
> +/**
> + * KFUZZTEST_EXPECT_EQ - constrain a field to be equal to a value
> + *
> + * @arg_type: name of the input structure, without the leading "struct ".
> + * @field: some field that is comparable
> + * @val: a value of the same type as @arg_type.@field
> + */
> +#define KFUZZTEST_EXPECT_EQ(arg_type, field, val)                                    \
> +       do {                                                                         \
> +               if (arg->field != val)                                               \
> +                       return;                                                      \
> +               __KFUZZTEST_DEFINE_CONSTRAINT(arg_type, field, val, 0x0, EXPECT_EQ); \

Doesn't the compiler complain about defining __used in the middle of the block?
Maybe move it before the if statement?

> + * KFUZZTEST_EXPECT_NE - constrain a field to be not equal to a value

Nit: you could probably save some space and extract the boilerplate
from KFUZZTEST_EXPECT_XX into a helper macro.

> +config KFUZZTEST
> +       bool "KFuzzTest - enable support for internal fuzz targets"
> +       depends on DEBUG_FS && DEBUG_KERNEL

Given that you only have the sections defined for x86, you should
probably put something like "depends on X86_64" here.
If you go for it, please mention somewhere that the framework is only
available for x86_64, and add "x86:" to the patch title.

An alternative would be to add KFUZZTEST_TABLE to vmlinux.lds.S for
every architecture.

