Return-Path: <linux-kernel+bounces-849948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD8BD16A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF13C189391A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DE1FE451;
	Mon, 13 Oct 2025 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PETCHEgE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC217D6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760332553; cv=none; b=X+bsOr9q6BCZAO0cnX7sg+uv3X1K3W2mWOIlvNRsPpHlHtfsZhbpk3Svk+yilAFNfAp19mE0wBOAocp7YbpKW/BSkgA1gpP7Gu7wiFlNX8qBUci+SsQ6aW8tjcd92EdECjYvLqjm6HfuPswjhyNUxfus94vRPj2NADJHAWr7pOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760332553; c=relaxed/simple;
	bh=UfEsHERR1qM/dvc8LgKC9Ca1Q7s3ktqgwF1U+I9Ak2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FD4dqIPy0FX/IU107lXtlK/TemN4ttOoG+R73YTYI3lJTHA3cBPeiVdJuTmjN5uEZExFkvOSWYAtcKxGlAnPblpQKdqVAoZWcOmjBdb3I2Sl9qDwIPZpGEpInoqJZNQNjQ6nC9sbIG1uTQBjn0FXr3fsecYEVTRvtIkiIlEX/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PETCHEgE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760332549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=COGg+i2yWCaVH5Pe+jyOQ0yVolTjfIQ8BpLZsuPuqqk=;
	b=PETCHEgE91TIX1FqkOlluMP2IMRGu50Je/168yXwiMVZzWDPUbTzN8+q3LjqQC97dHcODp
	hnebCnLz9YAI30ZJvmA4VuR6xj08JjVNtMFDf1fOuIBXi/MTOrmWeMEBjXsOBii4iAduGi
	9znswyaf86JXOXjqjri8n7z4kdxxO6I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-38PkIBy5Mqm7XcHE0vCulg-1; Mon, 13 Oct 2025 01:15:47 -0400
X-MC-Unique: 38PkIBy5Mqm7XcHE0vCulg-1
X-Mimecast-MFC-AGG-ID: 38PkIBy5Mqm7XcHE0vCulg_1760332546
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3afaf5defdso454511366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760332546; x=1760937346;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COGg+i2yWCaVH5Pe+jyOQ0yVolTjfIQ8BpLZsuPuqqk=;
        b=IL4bbwJDRHflFdhNuapqzldnzRdV0ZriCVezAAZto/Gsku+NGt0+5wAL+tvHcfsKTY
         3tOdjqg1E1Sl+6G+byoNNUxYQTe2eWoa11wGMTFX9lCxY150hCwYENYorPsovw7WcTW4
         8w8e92/V+UTw1urcROzRVJC1ON1iOv/WoJrvfGQOPZWALYPqQqKAZfY0SazGdeOw1iTK
         66RV397m+DPFFkXfveTRlBaAB2TeOqntqP+1Iuwzt8Qbnp5I+38fGzDXJMLHKamYezdi
         DZ+EcspQx33xdoWbEmFlQv6SCIWbaUi3y4zBMW76q30j7/4zX85FdD4mseuFgfnmNtDf
         0BOA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXNf/kwWsxoL+Zhk8/RdYumwDoSCJZQXVbb1MXJzlxnhXD0TVI9465bzTMM9IXBUHprL9MIG7xRSsegU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8A/yGM4kb5u6pWldabHuf6PJJKVhuhRDiXLxyv020oFctglN
	VRbFC+ZaG/zBXCSocd6ImSzv/a4+B3zTT3YQ2wYzbbKld/FNtSSEgMZJeQyOnsvhrGIBmf/Xg8k
	BGqQNn7+CNKdYqv+p7av4tAwFD++B7wV+fae8j8JZcW6+uHx8gLAenupoRBCjg6m/o+OSRfRq7Q
	==
X-Gm-Gg: ASbGncsojL9vFJ69ILk5dfL9yWR7Tz5z4G1r61gnd+F4F12Pr5fKl+gSSbwmWFKcNV4
	wIIZu5Bg3grFUQu8leuSgYU2PzUys9/se4NPZS38VeeJhDFncmKnOjKUHM0J1BCkRkoL0t/XbIp
	ccUEcqwAMtL009yFoMFOSJIWUGcePuXoMC+sBDuOaMgaUPgkEWEQ+OkRgsYlH7ZdAdKrvA84set
	2pIJ9ny8iZjelvFGojHoyiV0h13vpYEgXvUC2Fo/iUSJAPTTi/7tHqfGlLRueQgLWhe7jhr0adi
	JWb55Q/gx6f4pA54FgUSq5rtz7j3aMTOefcX+VQ14JEJgaAKIqm/rmtZnsdcHMIT3zBiQZpHMGn
	TSEvg
X-Received: by 2002:a17:907:3e26:b0:b30:c9d5:3adc with SMTP id a640c23a62f3a-b50ac0cb60emr2029699966b.49.1760332545801;
        Sun, 12 Oct 2025 22:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0BLL5ym10+7IOS/4ADPAE3xmIWwOixiOSvRuUXHeG5IWZoopu52WXdAPSV83jHZhbSNAz4Q==
X-Received: by 2002:a17:907:3e26:b0:b30:c9d5:3adc with SMTP id a640c23a62f3a-b50ac0cb60emr2029699366b.49.1760332545369;
        Sun, 12 Oct 2025 22:15:45 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net. [47.64.112.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d69d1576sm842992066b.39.2025.10.12.22.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 22:15:44 -0700 (PDT)
Message-ID: <2a5b4da0-e13f-4188-bb21-9e0afe7d40e8@redhat.com>
Date: Mon, 13 Oct 2025 07:15:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Add kprobes KUnit test
To: Paul Walmsley <pjw@kernel.org>, Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250513151631.3520793-1-namcao@linutronix.de>
 <16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com>
 <87frc9h0lo.fsf@yellow.woof> <87v7l17e8g.fsf@yellow.woof>
 <e905cf0e-3ac3-46b3-5f9e-1356f8d2a222@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e905cf0e-3ac3-46b3-5f9e-1356f8d2a222@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2025 00.03, Paul Walmsley wrote:
> On Mon, 29 Sep 2025, Nam Cao wrote:
> 
>> Nam Cao <namcao@linutronix.de> writes:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>> Could you maybe change that into "__ASSEMBLER__" instead of "__ASSEMBLY__" ?
>>>> I'm currently trying to get rid of the latter in the kernel sources, see:
>>>> https://lore.kernel.org/all/20250606070952.498274-1-thuth@redhat.com/
>>>
>>> It's been applied, it's up to riscv's maintainers how we should do this.
>>>
>>> I can send v3, or a follow-up patch.
>>>
>>> Or riscv maintainers can also squash that change into this patch, or
>>> into your patch.
>>>
>>> I'm fine with any options.
>>
>> Riscv pull request is already created. A follow-up patch it is then.
> 
> I've queued the following for v6.18-rc.

Thanks a lot!

> Thomas: have you considered updating checkpatch to scan for instances of
> __ASSEMBLY__?  Might preempt these sorts of manual fixes going forward.

I hope to get in the final patches soon ... so once that's done, 
__ASSEMBLY__ won't get defined anymore, so using it by accident will then 
cause a build error in assembly code - I hope that's obvious enough that we 
don't need a (temporary) patch for checkpatch.pl.

  Thomas


> 
> From: Paul Walmsley <pjw@kernel.org>
> Date: Fri, 10 Oct 2025 15:50:24 -0600
> Subject: [PATCH] riscv: kprobes: convert one final __ASSEMBLY__ to
>   __ASSEMBLER__
> 
> Per the reasoning in commit f811f58597ac ("riscv: Replace __ASSEMBLY__
> with __ASSEMBLER__ in non-uapi headers"), convert one last remaining
> instance of __ASSEMBLY__ in the arch/riscv kprobes code.  This entered
> the tree from patches that were sent before Thomas' changes; and when
> I reviewed the kprobes patches before queuing them, I missed this
> instance.
> 
> Cc: Nam Cao <namcao@linutronix.dev>
> Cc: Thomas Huth <thuth@redhat.com>
> Link: https://lore.kernel.org/linux-riscv/16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com/
> Link: https://lore.kernel.org/linux-riscv/20250606070952.498274-1-thuth@redhat.com/
> Signed-off-by: Paul Walmsley <pjw@kernel.org>
> ---
>   arch/riscv/kernel/tests/kprobes/test-kprobes.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> index 3886ab491ecb..537f44aa9d3f 100644
> --- a/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> @@ -11,7 +11,7 @@
>   #define KPROBE_TEST_MAGIC_LOWER    0x0000babe
>   #define KPROBE_TEST_MAGIC_UPPER    0xcafe0000
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   /* array of addresses to install kprobes */
>   extern void *test_kprobes_addresses[];
> @@ -19,6 +19,6 @@ extern void *test_kprobes_addresses[];
>   /* array of functions that return KPROBE_TEST_MAGIC */
>   extern long (*test_kprobes_functions[])(void);
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* TEST_KPROBES_H */


