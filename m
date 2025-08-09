Return-Path: <linux-kernel+bounces-760925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D1BB1F204
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A34568006
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8D1DB546;
	Sat,  9 Aug 2025 03:58:51 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7519F420
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754711931; cv=none; b=YEbmmt+0UlfextZYfASWDVZA1S6i9TVMHnLkBOtY3YNZIV+9WwD67kyEFU2YMi2l77g7dQTLxaNaFntrMjEw/mSEJNWQ553v/oOqV39K4yvJUCC431bwvjSqTKTEqiaBPdw4ouk9TSzbMTMSvLp7lOGeRmhuGYPjTqLg9r1oapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754711931; c=relaxed/simple;
	bh=uifMEVT3eLXKlVpAQesLDbr2GE7SlSmswPsFi6jE0CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QHIQnTIyG9T7jMjXIRyHn2J5jCHJy/eyKEVWe5sKHWC0hU5AWO24wDq49QGfGgF4pub+aLTdlwjQqJHr9APRn9TIw9bQvV/BpOWYBjDg5hJ6FWlLLKEXNzAqqjGmyvcemF6GigmkQ7vbB00y7GwF4ukOAPZEILrlWa1BXGqScDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.97.0.146] (unknown [39.144.108.158])
	by APP-03 (Coremail) with SMTP id rQCowADHWnxgx5ZorpeACg--.36779S2;
	Sat, 09 Aug 2025 11:58:30 +0800 (CST)
Message-ID: <e4d21516-23b5-404b-a7da-cf6ebfd02dbc@iscas.ac.cn>
Date: Sat, 9 Aug 2025 11:58:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Add sysctl to control discard of vstate during
 syscall
To: Drew Fustini <fustini@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Samuel Holland <samuel.holland@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andy Chiu <andybnac@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
 <aJXvWuPKIc2lCSX3@localhost.localdomain>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <aJXvWuPKIc2lCSX3@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowADHWnxgx5ZorpeACg--.36779S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy3tr17tw18AFWxJr4UCFg_yoW5ZF47pF
	Z3Ars3Krn8Zw1fZ3sFqw4UWrWxGas3Gw15Wr15K3y8uFZ8ur9akFn5K3WrGFykJr98CrW0
	qwn5Wa48Zw4UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

My previous comment on v1 on prefering clobbering with VS = Initial
handling aside...

On 8/8/25 20:36, Darius Rad wrote:
> On Wed, Aug 06, 2025 at 07:03:28AM -0700, Drew Fustini wrote:
> [...]
>> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
>> index 3987f5f76a9deb0824e53a72df4c3bf90ac2bee1..b702c00351617165a4d8897c7df68eadcd2d562e 100644
>> --- a/Documentation/arch/riscv/vector.rst
>> +++ b/Documentation/arch/riscv/vector.rst
>> @@ -134,7 +134,25 @@ processes in form of sysctl knob:
>>  3.  Vector Register State Across System Calls
>>  ---------------------------------------------
>>  
>> -As indicated by version 1.0 of the V extension [1], vector registers are
>> -clobbered by system calls.
>> +Linux adopts the syscall ABI proposed by version 1.0 of the V extension [1],
>> +where vector registers are clobbered by system calls. Specifically:
>> +
>> +    Executing a system call causes all caller-saved vector registers
>> +    (v0-v31, vl, vtype) and vstart to become unspecied.
>> +
> Perhaps:
>
> Clobbering the vector registers may prevent leaking information to user

No... Not clobbering does not "leak" anything. If you find that it leaks
information, please report - that's a bug.

> space and aid in debugging, but can significantly increase system call
> latency for some implementations.  [...]
>
>> +However, clobbering the vector registers can significantly increase system call
>> +latency for some implementations. To mitigate this performance impact, a sysctl
>> +knob is provided that controls whether vector state is always discarded in the
>> +syscall path:
>> +
>> +* /proc/sys/abi/riscv_v_vstate_discard
>> +
>> +    Valid values are:
>> +
>> +    * 0: Vector state is not always clobbered in all syscalls
>> +    * 1: Mandatory clobbering of vector state in all syscalls
>> +
>> +    Reading this file returns the current discard behavior. The initial state is
>> +    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
>>  
>>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 36061f4732b7496a9c68a9a10f9959849dc2a95c..7bb8a8513135cbc105bd94d273012486a886f724 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -656,6 +656,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
>>  
>>  	  If you don't know what to do here, say Y.
>>  
>> +config RISCV_ISA_V_VSTATE_DISCARD
>> +	bool "Enable Vector state discard by default"
>> +	depends on RISCV_ISA_V
>> +	default n
>> +	help
> Perhaps add the following paragraph:
>
> Discarding vector state is more robust, but has negative performance
> implications in certain implementations.

"Robust" is too vague... I don't think this word is helpful for anyone
trying to understand what this does.

Vivian "dramforever" Wang

>
>> +	  Say Y here if you want to always discard vector state in syscalls.
>> +	  Otherwise, userspace has to enable it via the sysctl interface.
>> +
>> +	  If you don't know what to do here, say N.
>> +
>>  config RISCV_ISA_V_UCOPY_THRESHOLD
>>  	int "Threshold size for vectorized user copies"
>>  	depends on RISCV_ISA_V


