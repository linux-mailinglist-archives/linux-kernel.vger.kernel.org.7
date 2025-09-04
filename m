Return-Path: <linux-kernel+bounces-801252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34805B442AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913D51C857FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5F2D6E63;
	Thu,  4 Sep 2025 16:27:04 +0000 (UTC)
Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90623278D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.109.42.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003223; cv=none; b=HCyCh+fQELK0thpKTOG0h6Xi6KtO5O/swQO5TfXgJfbKrJk7ijEGKvsofbyH49y8ZpVpat7FqJNtnuLDB9nTv5G8uXC63rbdltZF/H1Wb0uhk4WQvVjcRpzdC2Fm2VB9Bx4g3Kg8jcD2a0EXUvy8HfI/A4fM9mR4nUuRxEbTYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003223; c=relaxed/simple;
	bh=VhDp1d+TPhzG/j8xz4vLYQDEVH6x1NimKSuoEPHvBa4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=itDg1HK4X7sxe4bYYqPc/9He2hFuY8q8ntsQ6z0k/lFIUonuBhvWksNw+suiTPpvicyFo2zIxsVwlpJX+vLELdSegReZIDnGfT8XrL/7LRBekd6YhA9EW/AdWjpti+QGUC3tcciIjdL8cUNJPyLPjwbk8Ey36yGBXvrU3aBP9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=192.109.42.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
X-Envelope-From: doko@debian.org
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 584GQEiD3762639
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 18:26:14 +0200
Message-ID: <b2ae9afe-b919-45a3-b6ae-37c651c57981@debian.org>
Date: Thu, 4 Sep 2025 18:26:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Don't create sframes during build
From: Matthias Klose <doko@debian.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Binutils <binutils@sourceware.org>
References: <20250904131835.sfcG19NV@linutronix.de>
 <b3db475e-e84d-4056-9420-bc0acc8b9fe5@debian.org>
Content-Language: en-US
In-Reply-To: <b3db475e-e84d-4056-9420-bc0acc8b9fe5@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 16:02, Matthias Klose wrote:
> [ CCing binutils@sourceware.org ]
> 
> On 9/4/25 15:18, Sebastian Andrzej Siewior wrote:
>> Hi,
>>
>> gcc in Debian, starting with 15.2.0-2, 14.3.0-6 enables sframe
>> generation. Unless options like -ffreestanding are passed. Since this
>> isn't done, there are a few warnings during compile
> 
> If there are other options when sframe shouldn't be enabled, please tell.
> 
> Gentoo chose another approach, enabling sframe unconditionally in gas, 
> unless disabled by --gsframe=no.
> 
>> | crypto/chacha.o: warning: objtool: .sframe+0x30: data relocation 
>> to !ENDBR: chacha_stream_xor+0x0
>> | crypto/chacha.o: warning: objtool: .sframe+0x94: data relocation 
>> to !ENDBR: crypto_xchacha_crypt+0x0
>>
>> followed by warnings at the end
>>
>> |   AR      vmlinux.a
>> |   LD      vmlinux.o
>> | vmlinux.o: warning: objtool: .sframe+0x15c: data relocation to ! 
>> ENDBR: repair_env_string+0x0
>> | vmlinux.o: warning: objtool: .sframe+0x1c0: data relocation to ! 
>> ENDBR: run_init_process+0x0
>> | vmlinux.o: warning: objtool: .sframe+0x1d4: data relocation to ! 
>> ENDBR: try_to_run_init_process+0x0
>> | vmlinux.o: warning: objtool: .sframe+0x1e8: data relocation to ! 
>> ENDBR: rcu_read_unlock+0x0
>> …
>> | vmlinux.o: warning: objtool: .sframe+0x12765c: data relocation to ! 
>> ENDBR: get_eff_addr_reg+0x0
>> | vmlinux.o: warning: objtool: .sframe+0x1276ac: data relocation to ! 
>> ENDBR: get_seg_base_limit+0x0
>> |   OBJCOPY modules.builtin.modinfo
>>
>> followed by a boom
>> |   LD      .tmp_vmlinux1
>> | ld: error: unplaced orphan section `.sframe' from `vmlinux.o'
>>
>> We could drop the sframe during the final link but this does not get rid
>> of the objtool warnings so we would have to ignore them. But we don't
>> need it. So what about the following:
>>
>> diff --git a/Makefile b/Makefile
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -886,6 +886,8 @@ ifdef CONFIG_CC_IS_GCC
>>   KBUILD_CFLAGS    += $(call cc-option,--param=allow-store-data-races=0)
>>   KBUILD_CFLAGS    += $(call cc-option,-fno-allow-store-data-races)
>>   endif
>> +# No sframe generation for kernel if enabled by default
>> +KBUILD_CFLAGS    += $(call cc-option,-Xassembler --gsframe=no)
>>   ifdef CONFIG_READABLE_ASM
>>   # Disable optimizations that make assembler listings hard to read.
> This is what I chose for package builds that need disablement of sframe.


Fyi, I will disable that again next week, until sframe v3 is ready.


