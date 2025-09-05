Return-Path: <linux-kernel+bounces-803664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8422B4637C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A021898151
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80B257837;
	Fri,  5 Sep 2025 19:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554F31DE89A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100037; cv=none; b=CzNd9y0syXPJqiojj6af5Rxk3MiDkGx/1eq+5JSEmjFOV1VUTn0RGJ3LgbiMYvbjSxMe23xcfZmzKU8iNsm9XUZq4hhdEuA0vbfp6fVfQnw6P5opwEVMwRy41YcagpwRRmInlS8CUBHouGfV4Gl8YAauEWm4xEStjzaFZc+ukV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100037; c=relaxed/simple;
	bh=0G1W76nIXAOM9d0FVwSUPf4anDNG/zU2eYiNnVrExhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYnzTC0RQvNSpDuRpa7l7qETgpk1q/POVNatbOu/S5pxaM3z2IJDn3WO7C8Se4iLEf0az8f8cn+SLk00lltac+HAZ1GOA03+kaNEX2Ad36Wb+lWzrsVbydcPugbqqjCRQq//WYjlrcOmQCL3pJnfJu1TiAaijY7BWoykQ37wc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cJQx530RBz9sS7;
	Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8FPsSrEXf2k; Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cJQx51qPmz9sRy;
	Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C7B98B77A;
	Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 570O8DO0c8e4; Fri,  5 Sep 2025 21:13:29 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6312E8B773;
	Fri,  5 Sep 2025 21:13:28 +0200 (CEST)
Message-ID: <c0bd173c-c84f-41d5-8532-2afb8eca9313@csgroup.eu>
Date: Fri, 5 Sep 2025 21:13:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
To: Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, snovitoll@gmail.com, glider@google.com,
 dvyukov@google.com, elver@google.com, linux-mm@kvack.org,
 vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/09/2025 à 20:08, Andrey Konovalov a écrit :
> On Fri, Sep 5, 2025 at 7:12 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>> But have you tried running kasan=off + CONFIG_KASAN_STACK=y +
>>> CONFIG_VMAP_STACK=y (+ CONFIG_KASAN_VMALLOC=y)? I would expect this
>>> should causes crashes, as the early shadow is mapped as read-only and
>>> the inline stack instrumentation will try writing into it (or do the
>>> writes into the early shadow somehow get ignored?..).
>>>
>>
>> It's not read-only, otherwise we would crash very early before full shadow
>> setup and won't be able to boot at all. So writes still happen, and shadow
>> checked, but reports are disabled.
> 
> Hm, I thought it worked like that, but then what threw me off just now
> was seeing that zero_pte_populate()->pte_wrprotect() (on arm64) resets
> the PTE_WRITE bit and sets the PTE_RDONLY bit. So I thought the
> kasan_early_shadow_page is marked as read-only and then the
> instrumentation is disabled for all early code that might write into
> the page before the proper shadow is set up. Or am I reading this
> bit-setting code wrong?

But that zero_pte_populate() is called by kasan_init() when everything 
is ready.

kasan_init()->kasan_init_shadow()->kasan_populate_early_shadow()->zero_p4d_populate()->zero_pud_populate()->zero_pmd_populate()->zero_pte_populate()

Here we are talking about the shadow set at startup kasan_early_init(), 
aren't we ?

Christophe

