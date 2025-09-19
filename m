Return-Path: <linux-kernel+bounces-824746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A518AB8A109
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BF35868F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C8242D70;
	Fri, 19 Sep 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zP2zbEWX"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBC273F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293248; cv=none; b=MZCp72cljbZWlv7WUVJGyEWfktXgblZ/dfuc6DfCZppE3tQlcp4t9oI+2x9USpi/wuJXn5Q9YZHgX0scJ3dAaDoEx+aSca3chO2vVs8+cjSECbqfq//uEDoeN5icyME1TaxtrkOhnSI0cUXm7KVgj4oEznI8Li3/jKV+YYAOkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293248; c=relaxed/simple;
	bh=2DL6uXDg+S2/vhUOkYwzs5WF945Plpqn2YxEZIBpRIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiYuIt/479Xmqoce9y4gE5yPKy3H4RkslUMuWJiBX6pgb15VqfxpCcHJrgUacKzkXONZ9Ssav0X/pHlofohw8HQcprSPaBP77l1ixi38Vnf4pe06px29vIX7GPIA06NKq607Pa5kOejj+nwIDiDijnZmj1sr7Gl6UMaHANI264Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zP2zbEWX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso1874775f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758293244; x=1758898044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=58JIz+T98xNuJ35TRUpFdQl+tGQMi+ETXxGZ5QmS7Es=;
        b=zP2zbEWX6Z5SJJjSeNHaBmL1kdD9NJhCNZJVu0OdBI2989PvJfYo2x/im5CjVyX046
         atN8uZidbfskWGLWHfX2DATNqJM/NDQVnELTp7Y9NlY6PxKvt8UaFPVC7lsSe5xf0cDL
         VvEsKJ1yTWRPJTo2e1DZ7dO8gO5a3RDUoCF60dRzvF6s8lzSY/1VOMjH+EYy93FSwSY0
         APrWw5ST+v6Ys8nK6mZp+S9CFVv6jo0tjvYe+6y7yyMG9yJ44h9XTQjxMGNaXOAoWmt3
         kF6vvJ+t5HNwPX3SPUijMeyoBlTwRQICHyJAUbRbTP+8cpjQsnjNTf+1j43pnutYwFPD
         WYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293244; x=1758898044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58JIz+T98xNuJ35TRUpFdQl+tGQMi+ETXxGZ5QmS7Es=;
        b=p0VkaQbEceFWtNhQN2xMWK9lT7IoRXUTKinogY8akyEHLR7c8vwIK5uKOYyQ2fnQM7
         pL5X7ic4W8jKnFhN80FLBCo7oX9Rp9w6oa+LhIHjid5rgSVpbVA9yh6ra6OtEai3mPjr
         41FO62m/T0J/ErTqPza2l705bmkpznFt/WNqOTD2iqq5YQ57p5kbfRGqt2SwIyfEN2pi
         fkPBtv3DsKFxRcOzaWnzhoXzIgbVfRdb519quAcKqoW/MZs8VRUSmku8yS5ULRtDGBsx
         jUrylfrilXdDvOk90yWeg8zTT1A65CmMbcy7F2Ox5MsntiFSButq7YuzmiibQ0nEAKAN
         kzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLAb5MRQvvFyLqZeEBTt9x4J6pbmcDEyPDNuG6wqwiHSBcHmKlOFe2eL/ZvIXju/JmCfuoqA1UFhs3sbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTwMyq4AOP5k039BBvSMcaRsKEJlLlSK5OYqlIt8EzKcI5zRO
	/+cF7q6Y3aUdT3/eDqo3mYzzCX+diI+cKpDmj8y1aTbPD8CuS1vthX060z+jCSbhMA==
X-Gm-Gg: ASbGncszYsHwjzopkLL5IZREciMIPXbpNDCI9DGLbWnfZTiKtxDygbfGV0Yn4VVkrht
	CyTZNneKvkB4jgQkwQ3MQFz2sK20FmKS6i0Rse0g0MAr6/YuRqRulvjgdUO5LOwLarJHDuj+4HU
	lJeQ6Dr2bDl/mpEh2PBbwtHC6UdrPpiX/oYU3T3AxYjfMGwm6XJ+ymzAVhoBBMY+ty49s4P2Ms/
	2Yq9NnjDOUrUt7bAc0QWe9j1mzB9Waq6Tgbc/ZUd+lc52yQDlSuXYjelbXQlCSl99ThxJAK9lNm
	N7sqsHWVwNU3SP228pb9oMPM1z5bo3zrZ9hLhqq+z9r2xE/qhbaD8fBe4abnmaSKpDB0/dpdfDw
	yAo5D+SzGW9pzyQBinnGVHj7VBe0Oe3QH3mrqW3uO+NjKxKC6KLqukDf1
X-Google-Smtp-Source: AGHT+IEWBbhkJpfige+suf0vsNLGPkLiHAll4OeC7ziC+CAHJCVZxl4IjAKlTlNyPUIiZscBy0gVAw==
X-Received: by 2002:a05:6000:400c:b0:3ea:9042:e682 with SMTP id ffacd0b85a97d-3ee7c55430amr2895578f8f.11.1758293244246;
        Fri, 19 Sep 2025 07:47:24 -0700 (PDT)
Received: from google.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1385adebsm6400131f8f.42.2025.09.19.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:47:23 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:47:20 +0000
From: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dylan Hatch <dylanbhatch@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arch: arm64: Fail module loading if dynamic SCS
 patching fails
Message-ID: <aM1s-I0gM_rAf5LU@google.com>
References: <20250919122321.946462-1-abarnas@google.com>
 <20250919122321.946462-2-abarnas@google.com>
 <CAMj1kXEVThBdH7H7NX+Ma8j0_85GevzczFgvvozK-TsqT2geFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEVThBdH7H7NX+Ma8j0_85GevzczFgvvozK-TsqT2geFw@mail.gmail.com>

Hi,

On Fri, Sep 19, 2025 at 03:59:21PM +0200, Ard Biesheuvel wrote:
>Hi,
>
>On Fri, 19 Sept 2025 at 14:23, Adrian Barnaś <abarnas@google.com> wrote:
>>
>> Disallow a module to load if SCS dynamic patching fails for its code. For
>> module loading, instead of running a dry-run to check for patching errors,
>> try to run patching in the first run and propagate any errors so module
>> loading will fail.
>>
>> Signed-off-by: Adrian Barnaś <abarnas@google.com>
>> ---
>>  arch/arm64/include/asm/scs.h      |  2 +-
>>  arch/arm64/kernel/module.c        |  6 ++++--
>>  arch/arm64/kernel/pi/map_kernel.c |  2 +-
>>  arch/arm64/kernel/pi/patch-scs.c  | 15 +++++++++++----
>>  arch/arm64/kernel/pi/pi.h         |  2 +-
>>  5 files changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
>> index a76f9b387a26..ffcfcda87f10 100644
>> --- a/arch/arm64/include/asm/scs.h
>> +++ b/arch/arm64/include/asm/scs.h
>> @@ -53,7 +53,7 @@ enum {
>>         EDYNSCS_INVALID_CFA_OPCODE              = 4,
>>  };
>>
>> -int __pi_scs_patch(const u8 eh_frame[], int size);
>> +int __pi_scs_patch(const u8 eh_frame[], int size, bool is_module);
>>
>
>Calling the parameter 'is_module' puts the policy in the SCS patching
>code, which now has to reason about how patching a module differs from
>patching other code.

Agreed.

>So I'd prefer to call this 'two_pass' or 'dry_run' or whatever, where
>setting it guarantees that when an error is returned, no function will
>be left in an inconsistent state.

Maybe `bool skip_dry_run`?

>
>>  #endif /* __ASSEMBLY __ */
>>
>> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
>> index 40148d2725ce..5d6d228c6156 100644
>> --- a/arch/arm64/kernel/module.c
>> +++ b/arch/arm64/kernel/module.c
>> @@ -484,10 +484,12 @@ int module_finalize(const Elf_Ehdr *hdr,
>>         if (scs_is_dynamic()) {
>>                 s = find_section(hdr, sechdrs, ".init.eh_frame");
>>                 if (s) {
>> -                       ret = __pi_scs_patch((void *)s->sh_addr, s->sh_size);
>> -                       if (ret)
>> +                       ret = __pi_scs_patch((void *)s->sh_addr, s->sh_size, true);
>> +                       if (ret) {
>>                                 pr_err("module %s: error occurred during dynamic SCS patching (%d)\n",
>>                                        me->name, ret);
>> +                               return -ENOEXEC;
>> +                       }
>>                 }
>>         }
>>
>> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
>> index 0f4bd7771859..7187eda9e8a5 100644
>> --- a/arch/arm64/kernel/pi/map_kernel.c
>> +++ b/arch/arm64/kernel/pi/map_kernel.c
>> @@ -98,7 +98,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
>>
>>                 if (enable_scs) {
>>                         scs_patch(__eh_frame_start + va_offset,
>> -                                 __eh_frame_end - __eh_frame_start);
>> +                                 __eh_frame_end - __eh_frame_start, false);
>>                         asm("ic ialluis");
>>
>>                         dynamic_scs_is_enabled = true;
>> diff --git a/arch/arm64/kernel/pi/patch-scs.c b/arch/arm64/kernel/pi/patch-scs.c
>> index 55d0cd64ef71..78266fb1fa61 100644
>> --- a/arch/arm64/kernel/pi/patch-scs.c
>> +++ b/arch/arm64/kernel/pi/patch-scs.c
>> @@ -225,7 +225,7 @@ static int scs_handle_fde_frame(const struct eh_frame *frame,
>>         return 0;
>>  }
>>
>> -int scs_patch(const u8 eh_frame[], int size)
>> +int scs_patch(const u8 eh_frame[], int size, bool is_module)
>>  {
>>         int code_alignment_factor = 1;
>>         bool fde_use_sdata8 = false;
>> @@ -276,12 +276,19 @@ int scs_patch(const u8 eh_frame[], int size)
>>                                 return EDYNSCS_INVALID_CIE_SDATA_SIZE;
>>                         }
>>                 } else {
>> +                       /*
>> +                        * For loadable module instead of running a dry run try
>> +                        * to patch scs instruction in place and trigger error
>> +                        * if failed, to prevent module loading.
>> +                        */
>
>Move this comment to the module loader, and explain why the two pass
>approach is not needed in this case.
>

Will do.

>>                         ret = scs_handle_fde_frame(frame, code_alignment_factor,
>> -                                                  fde_use_sdata8, true);
>> +                                                  fde_use_sdata8, !is_module);
>>                         if (ret)
>>                                 return ret;
>> -                       scs_handle_fde_frame(frame, code_alignment_factor,
>> -                                            fde_use_sdata8, false);
>> +
>> +                       if (!is_module)
>> +                               scs_handle_fde_frame(frame, code_alignment_factor,
>> +                                                    fde_use_sdata8, false);
>>                 }
>>
>>                 p += sizeof(frame->size) + frame->size;
>> diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
>> index 46cafee7829f..4ccbba24fadc 100644
>> --- a/arch/arm64/kernel/pi/pi.h
>> +++ b/arch/arm64/kernel/pi/pi.h
>> @@ -27,7 +27,7 @@ extern pgd_t init_pg_dir[], init_pg_end[];
>>  void init_feature_override(u64 boot_status, const void *fdt, int chosen);
>>  u64 kaslr_early_init(void *fdt, int chosen);
>>  void relocate_kernel(u64 offset);
>> -int scs_patch(const u8 eh_frame[], int size);
>> +int scs_patch(const u8 eh_frame[], int size, bool is_module);
>>
>>  void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
>>                int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
>> --
>> 2.51.0.534.gc79095c0ca-goog
>>

Thank you for a review,
Adrian


