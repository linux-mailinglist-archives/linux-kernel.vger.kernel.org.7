Return-Path: <linux-kernel+bounces-802599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92606B45469
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB9CA42A07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD62D542B;
	Fri,  5 Sep 2025 10:20:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A362BE02D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067638; cv=none; b=sLkRnCJx09yy+u9CckotReLawcBN2nj41Qi1HirhWqsF0DEGmPNTJXSYLoklun1OSoqcZUFZXZ5pzFXezPJ18akoUEXk/1UuN5+98r0fP/ATflIONCm88yvfr8OE3G+S8dFpR7Exl6zeBOQccRTy+u6CLz9Xe1+uNGA++MS0Jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067638; c=relaxed/simple;
	bh=Eyc8vRVUOfv7hGsGsY9AFauWZJo0WMdFBDkxG1rZnw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/iYOCrVnxZlyo1XK3tBZHvy95Zb/NT5rEQhROTKYsS4dAJ2nOgIuk/m/Y3xykXvMjUE/K742mo99aA1kXiGVLwdEA//GQqHsC6Bvj0y6bxaUyC/SyU9YaiQdoTRxblB/AHMEB3W+7khNoItJyyRNPNM/Nn8pAREo87D4AhCyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cJBH56SbMz9sSX;
	Fri,  5 Sep 2025 11:43:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T654Yx4sq1w0; Fri,  5 Sep 2025 11:43:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cJBH55WMMz9sS8;
	Fri,  5 Sep 2025 11:43:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A568B8B774;
	Fri,  5 Sep 2025 11:43:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uNL1AnKXOGoz; Fri,  5 Sep 2025 11:43:13 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3585E8B773;
	Fri,  5 Sep 2025 11:43:13 +0200 (CEST)
Message-ID: <36aabfe5-b862-404b-8175-ebe5dab59427@csgroup.eu>
Date: Fri, 5 Sep 2025 11:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup
 failure
To: Andrew Donnellan <ajd@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Erhard Furtner <erhard_f@mailbox.org>
References: <342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org>
 <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
 <977ad5eef4f8726e9d5bff31b758918f0341659d.camel@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <977ad5eef4f8726e9d5bff31b758918f0341659d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/09/2025 à 08:57, Andrew Donnellan a écrit :
> On Thu, 2025-09-04 at 18:33 +0200, Christophe Leroy wrote:
>> PAGE_KERNEL_TEXT is an old macro that is used to tell kernel whether
>> kernel text has to be mapped read-only or read-write based on build
>> time options.
>>
>> But nowadays, with functionnalities like jump_labels, static links,
>> etc ... more only less all kernels need to be read-write at some
>> point, and some combinations of configs failed to work due to
>> innacurate setting of PAGE_KERNEL_TEXT. On the other hand, today
>> we have CONFIG_STRICT_KERNEL_RWX which implements a more controlled
>> access to kernel modifications.
>>
>> Instead of trying to keep PAGE_KERNEL_TEXT accurate with all
>> possible options that may imply kernel text modification, always
>> set kernel text read-write at startup and rely on
>> CONFIG_STRICT_KERNEL_RWX to provide accurate protection.
>>
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Closes:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F342b4120-911c-4723-82ec-d8c9b03a8aef%40mailbox.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ce1df868f94284b06db0508ddec497516%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638926522413828188%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=cqhzYIshhwKJluL2U2ULuNYoQ1CR1ZP0nsl5pb3wHd4%3D&reserved=0
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> The original issue that Erhard and I were investigating was why the latest
> version of the PowerPC page table check series[0] was failing on his G4, when
> built as part of a config with many other debugging options enabled.
> 
> With further instrumentation, it turns out that this was due to a failed
> instruction patch while setting up a jump label for the
> page_table_check_disabled static key, which was being checked in
> page_table_check_pte_clear(), which was in turn inlined ultimately into
> debug_vm_pgtable().
> 
> This patch seems to fix the problem, so:
> 
> Tested-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> But I'm still curious about why I only see the issue when:
> 
>    (a) CONFIG_KFENCE=y (even when disabled using kfence.sample_interval=0) -
> noting that changing CONFIG_KFENCE doesn't change the definition of
> PAGE_KERNEL_TEXT; and
> 
>    (b) when the jump label ends up in a __init function (removing __init from
> debug_vm_pgtable() and its associated functions, or changing the code in such a
> way that the static key check doesn't get inlined, resolves the issue, and
> similarly for test_static_call_init() when CONFIG_STATIC_CALL_SELFTEST=y).
> 
> I don't understand the mm code well enough to make sense of this.

That makes sense. When CONFIG_KFENCE is selected, only text and rodata 
are mapped with BATs. Everything else including inittext is mapped with 
pages. When CONFIG_KFENCE and CONFIG_DEBUG_PAGEALLOC are not selected, 
we map as much as possible with BATs.

And as you can see below, BATs are mapped with PAGE_KERNEL_X not with 
PAGE_KERNEL_TEXT.

Everything happen here below:

static unsigned long __init __mmu_mapin_ram(unsigned long base, unsigned 
long top)
{
	int idx;

	while ((idx = find_free_bat()) != -1 && base != top) {
		unsigned int size = bat_block_size(base, top);

		if (size < 128 << 10)
			break;
		setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
		base += size;
	}

	return base;
}

unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
{
	unsigned long done;
	unsigned long border = (unsigned long)__srwx_boundary - PAGE_OFFSET;
	unsigned long size;

	size = roundup_pow_of_two((unsigned long)_einittext - PAGE_OFFSET);
	setibat(0, PAGE_OFFSET, 0, size, PAGE_KERNEL_X);

	if (debug_pagealloc_enabled_or_kfence()) {
		pr_debug_once("Read-Write memory mapped without BATs\n");
		if (base >= border)
			return base;
		if (top >= border)
			top = border;
	}

	if (!strict_kernel_rwx_enabled() || base >= border || top <= border)
		return __mmu_mapin_ram(base, top);

	done = __mmu_mapin_ram(base, border);
	if (done != border)
		return done;

	return __mmu_mapin_ram(border, top);
}


> 
> [0] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20250813062614.51759-1-ajd%40linux.ibm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ce1df868f94284b06db0508ddec497516%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638926522413849910%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=1slIkZ4krf2sWUaKJ%2FayEX8t9dKpfsrDiAxZRohKfRQ%3D&reserved=0
> 


