Return-Path: <linux-kernel+bounces-745927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8FB12086
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349F3588637
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D672BDC33;
	Fri, 25 Jul 2025 15:01:36 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCFA5475E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455696; cv=none; b=CGnbcdwx1qvLzzhJpOElrjaBLqjiRi0m1XF+bRwjW3pzHjag9x+ZGO3zQ9g3yjdaaoN0nYAJW8SLszmXAgpiqqlhigR02WOLtoN8cG1YproDmAbNC9EYRR+fpPrtPEmS2KzWDldZF+G9PG/vJmfxVMLdurUhpdrctqBQTSeXH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455696; c=relaxed/simple;
	bh=F+oEPgML3aBWZ2h8ARcjW3R3lKARlPBoghijCe2iBnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mqpm1IHC4ib/4kyGJJB104XGQnOLpWXc3lsUkS55MMnuZs/+4DD9WRKPjouJOcDnJwsB4kvf+fbWcwCIfmtcYP22Npj9oeVRw8q+jlteJRjO5cgRSO58aEt1jVjt7Z8DOjI5CpRHx986coQF7qaFQXmyhTteUf6LiBq6S5d8t6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.108] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowADHWHovnINokAgZBw--.10820S2;
	Fri, 25 Jul 2025 23:01:04 +0800 (CST)
Message-ID: <feb3549f-da91-4eaa-a624-b9f35db6ba3c@iscas.ac.cn>
Date: Fri, 25 Jul 2025 23:01:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 Drew Fustini <fustini@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Drew Fustini <dfustini@tenstorrent.com>, Andy Chiu <andybnac@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: linux-riscv <linux-riscv-bounces@lists.infradead.org>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <cc82c938-def3-4df6-9fc9-fc321af7d54a@iscas.ac.cn>
 <DBL2588APTCA.2XUKQCJ0DW89C@ventanamicro.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <DBL2588APTCA.2XUKQCJ0DW89C@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHWHovnINokAgZBw--.10820S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Ww48Ww17Aw4UJry7KFg_yoW5JFWxpa
	y7Kwn8tw1kAr4fuwnIvr4Iqa1Fyr9ayay5JFn5t3y2ya45GF9YqFs0gayYqFZxArsrCr1j
	qayfu347Zas8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 7/25/25 18:18, Radim Krčmář wrote:
> 2025-07-24T05:55:54+08:00, Vivian Wang <wangruikang@iscas.ac.cn>:
>> On 7/19/25 11:39, Drew Fustini wrote:
>>> From: Drew Fustini <dfustini@tenstorrent.com>
>>> Clobbering the vector registers can significantly increase system call
>>> latency for some implementations. To mitigate this performance impact, a
>>> policy mechanism is provided to administrators, distro maintainers, and
>>> developers to control vector state discard in the form of a sysctl knob:
>> So I had an idea: Is it possible to avoid repeatedly discarding the
>> state on every syscall by setting VS to Initial after discarding, and
>> avoiding discarding when VS is Initial? So:
>>
>> if (VS == Clean || VS == Dirty) {
>>     clobber;
>>     VS = Initial;
>> }
>>
>> This would avoid this problem with syscall-heavy user programs while
>> adding minimum overhead for everything else.
> I think your proposal improves the existing code, but if a userspace is
> using vectors, it's likely also restoring them after a syscall, so the
> state would immediately get dirty, and the next syscall would again
> needlessly clobber vector registers.

Without any data to back it up, I would say that my understanding is
that this should be a rare case, only happening if e.g. someone is
adding printf debugging to their vector code. Otherwise, vector loops
should not have syscalls in them.

A more reasonable worry would be programs using RVV everywhere in all
sorts of common operations. In that case, alternating syscalls and
vectors would make the discarding wasteful.

> Preserving the vector state still seems better for userspaces that use
> both vectors and syscalls.

If we can expect e.g. userspace programs to primarily repeatedly use RVV
with no syscalls between loops, *or* primarily repeatedly use syscalls
with rare occurrences of RVV between syscalls. This way, the primarily
syscall programs can benefit from slightly switching, since there's no
need to save and restore state for those most of the time. In effect,
syscalls serves as a hint that RVV is over. The primarily RVV programs
should not be switching as much - if they are, that's a sign of CPU
resources being oversubscribed. 

Having said all of that, I am actually slightly more interested in why
vmv.v.vi is *so slow* on SiFive X280. I wonder if there would be a more
microarchitectural favorable ways to just put a bunch of ones in some
vector registers? Would 0 be better?

Vivian "dramforever" Wang


