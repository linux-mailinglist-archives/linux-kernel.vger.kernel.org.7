Return-Path: <linux-kernel+bounces-802102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BFBB44DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60F717E999
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF326B2C8;
	Fri,  5 Sep 2025 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKs5UCub"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F41EE7B7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051050; cv=none; b=mRS/7DU4Vi4vhWaPMyX1KP+eSrZaTBThwBKrq6zYgxu0mUn0pdNj+Z/6z/xogYkTu1AjH+t4ebqYFhN86l5++ceGfZUV87YNWZt1p2KPG4QPv89G+B4vyaNkgTrOLnnq1bqBJ/nIYVpLW8VFHtY86b2PgrJQACL4xi+6Bmv1vMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051050; c=relaxed/simple;
	bh=wcWIrNRwQk6Nsqy6HsCF9uoW5dArDRStpUeK2uhW8ZY=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References:
	 MIME-version:Content-type; b=hbzdtVywctq1ho8uCp5Fxo/c2E0eHAwtIlj5G82vQHHjWm1J0kUaEpuKMjFFeCIoHq134G6Ce8iJnhWBgEoCen4WBHS3fR0RKMN7ARQlorGv47cHbnbKy9bQ9efVwEsL1/1Xpg7EiRZN/mlhKbMzXO/v4eF0AEAKT1PZ/Kqxk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKs5UCub; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4c53892a56so1568626a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757051048; x=1757655848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79phlt9YKWJP1LdbQMpCO0EI87IvQ11v1Ke3cLVyv0I=;
        b=TKs5UCub1ZEScAuY7e/Kt2Mdo8kqa3CdWbjMBTC3e5J2Y/bGHf8Y+CsmHDJCfhYe36
         L77ILxorOyDpexzybuKeYkax2uzWgi+q5BPrlvYb6VzSPiHkVWzgme5N653D8/T7ela0
         Fjb/HRyqlG9PLmOGcs1dnAlES5d07eJJBqfzEqrjhsSPYdLggDO9TtFo8clbYx3mfxkj
         OOIP6kmzVtPKmP2aqsnzAdFqCWSOwBCGPhOBjUJtkeFdhVUTlWo1MO1dH2Zl78WgbfSA
         qySs6NQl63Gf3Sf48ugPETrxjy1n2tJKdZtOXIKnOl4f7oog8h5OLLHSPQhTLnD8fo+h
         ZPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757051048; x=1757655848;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=79phlt9YKWJP1LdbQMpCO0EI87IvQ11v1Ke3cLVyv0I=;
        b=lG2IsT6xRB9EoYBL/6ZDIITNdyh8ke2yHfnJp9VgksHJO4HYhqKv2PaJfzCZXk173s
         pjhkueusRaE0Cr/l8OPwkW9+hrGX9WJVq9jwkBPNsWGC3b3vVcID09CY0NjZ8ybw/juo
         4QvwF0EtPAhmnctvhInaBWBGELwAKv3C5V/4DFbniVIGwABbD2sEacyKgYPzT3SVAmqX
         nlRDjsDH0FmY/v8f+GYC3h/MRuutBDw0yXm8TmxTd1tRR0nKWqYSOc0KmuYEihOxyBNZ
         0/J7l9GbxzLPfAl6NEFJWNOlaQD+0CxFandKKWpmsbPw0/WjeFLR+EiN5v39wemR/uV5
         L8Qg==
X-Gm-Message-State: AOJu0YwaOqbh4pCR6nMmR4OteHokccPyzRo8fOBxE0FHfn3c13K3TA24
	TijNwTTJ0X5JHDMUSBNryUBHTDmjcefixLTXng9UKSqkis/dFIeaVEEN
X-Gm-Gg: ASbGnctWLJ3EPqHHxr8pUro1PzxFa1EOQcNnWHflUqR8zrwcbvMp0uubvxZozA0a8Dt
	l3R3ndpPFQx8DeznBsclsnCyd2QBy5LbcVVn2SN/FmrTDyzHrrYKVyg6e0KzeWxPP93d21L4/C4
	hDRz99fwSBJ01GXeDGCIkF1oqugtXP6z4mb52He6zwluj6bKWGcywpr+RpMf/tXVV5a5pSJoGEq
	U+89QCEPLVH8Ffj2HBRU6rKw3bvI9jWXLdsvEXseGOMCkOSHFX7n6/InaMLSlamTka3/RJe0TjQ
	MlFUBczuj9iGDJ9gvX/rd+LdKjpcvqQzf0QEXoQ+zWI7olCVbWMzbEVyEWLQjhywIzXMA3Jojxw
	8Qb2/ZhrXZ+aDaHgqqj6vf3PzNw==
X-Google-Smtp-Source: AGHT+IH9lLLY8qCmwDEbPCg1+l9Lsg2X6aU3JD9OZkfGn6D2tlodVc/S78BdhkhXeCIn3LZCid9ILg==
X-Received: by 2002:a17:90b:2751:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-32815412c9emr27732394a91.3.1757051047830;
        Thu, 04 Sep 2025 22:44:07 -0700 (PDT)
Received: from dw-tp ([171.76.86.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7724f079b88sm14774607b3a.40.2025.09.04.22.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 22:44:07 -0700 (PDT)
Message-ID: <68ba78a7.a70a0220.2f582b.f2d1@mx.google.com>
X-Google-Original-Message-ID: <87seh1iibr.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Donnellan <ajd@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup failure
In-Reply-To: <7b3c83c1-bdf1-4778-948f-223ef0bce2a0@csgroup.eu>
Date: Fri, 05 Sep 2025 10:53:04 +0530
References: <342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org> <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu> <68ba6bee.170a0220.3b821b.ca9d@mx.google.com> <7b3c83c1-bdf1-4778-948f-223ef0bce2a0@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 05/09/2025 à 05:55, Ritesh Harjani a écrit :
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> 
>>> PAGE_KERNEL_TEXT is an old macro that is used to tell kernel whether
>>> kernel text has to be mapped read-only or read-write based on build
>>> time options.
>>>
>>> But nowadays, with functionnalities like jump_labels, static links,
>>> etc ... more only less all kernels need to be read-write at some
>>> point, and some combinations of configs failed to work due to
>>> innacurate setting of PAGE_KERNEL_TEXT. On the other hand, today
>>> we have CONFIG_STRICT_KERNEL_RWX which implements a more controlled
>>> access to kernel modifications.
>>>
>>> Instead of trying to keep PAGE_KERNEL_TEXT accurate with all
>>> possible options that may imply kernel text modification, always
>>> set kernel text read-write at startup and rely on
>>> CONFIG_STRICT_KERNEL_RWX to provide accurate protection.
>>>
>>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>>> Closes: https://lore.kernel.org/all/342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org/
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/include/asm/pgtable.h | 12 ------------
>>>   arch/powerpc/mm/book3s32/mmu.c     |  4 ++--
>>>   arch/powerpc/mm/pgtable_32.c       |  2 +-
>>>   3 files changed, 3 insertions(+), 15 deletions(-)
>>>
>> 
>> AFAIU - mmu_mark_initmem_nx gets called during kernel_init() which is
>> way after static call initialization correct? i.e.
>> 
>> start_kernel
>>    ...
>>    jump_label_init()
>>    static_call_init()
>>    ...
>>    ...
>>    rest_init()      /* Do the rest non-__init'ed, we're now alive */
>>      kernel_init()
>>        free_initmem() -> mark_initmem_nx() -> __mark_initmem_nx -> mmu_mark_initmem_nx()
>>        mark_readonly()
>>          if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) && rodata_enabled) {
>>             jump_label_init_ro()
>>             mark_rodata_ro() -> ....
>>             ...
>>          ...
>> 
>> Then I guess we mainly only need __mapin_ram_chunk() to be PAGE_KERNEL_X (RWX)
>> instead of PAGE_KERNEL_TEXT (ROX), isn't it?
>> 
>> Let me quickly validate it...
>> ...Ok, so I was able to get just this diff to be working.
>> 
>> Thoughts?
>
> setibat() doesn't take into account whether it is RO or RW. Only X or NX 
> is taken into account, so it doesn't matter whether it is X or ROX.
>
> Then allthough you are right in principle, once the PAGE_KERNEL_TEXT is 
> removed from __mapin_ram_chunk() it becomes completely useless, so 
> better get rid of PAGE_KERNEL_TEXT completely.
>

Aah yes, I checked the function setibat() and as you mentioned, it
doesn't honour RW permission anyways. Can we please update the same in
the commit message too? That makes it more clear then. 

-ritesh


