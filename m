Return-Path: <linux-kernel+bounces-778207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E109B2E28F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E36F5C13C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393132BF4D;
	Wed, 20 Aug 2025 16:41:37 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348E72634
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708096; cv=none; b=Vqj0aLOZZe9Sz8Xr7mk8SpMV7iS9K2gTkEiZsVsHSLxZDP1nE7f0LeWosqSM/OShYQyV4AZX6wA/hZ4EhtP6JA7sxFpKjx4asKrQJGaVS0jpr9S8x0HPULLZJ/ZBSc0ZNTcQQDDZR6N7zT4v2nxCCAciTSKyyvxmYqB9rROeILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708096; c=relaxed/simple;
	bh=wf5/ZpV4LSyKjsxPfxshoKxUOYeE4xytF6nhiXxiB1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXUOQzd1sDisMlVTxAbIiEu4HAulCeAGSiHSqg5s+H4Cb8umZmzHrd6XlvcqCGUOwsZ1sQCwk0bGxDYXa/yOTddzYXkJ8qeoe7VpGgEz+EW1255o6+Qx3ienL5P7qHUO1GNuV+34tQ21HKsJVLIXww2zMtzxclyJpy3+2CvfacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.110] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAA3jl6u+qVoIkPBDQ--.13372S2;
	Thu, 21 Aug 2025 00:41:18 +0800 (CST)
Message-ID: <ac387d7f-e8a9-4870-a881-e8dcb0309355@iscas.ac.cn>
Date: Thu, 21 Aug 2025 00:41:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] riscv: Introduce use_alternative_{likely,unlikely}
To: Yury Norov <yury.norov@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ayd=C4=B1n_Mercan?=
 <aydin@mercan.dev>, Vivian Wang <uwu@dram.page>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
 <20250820-riscv-altn-helper-wip-v1-1-c3c626c1f7e6@iscas.ac.cn>
 <aKXiH1eqGliLNb8u@yury> <544577b2-6810-4bef-b588-e1c662d5be13@iscas.ac.cn>
 <aKXtBJ5Aqqmvdc1B@yury>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <aKXtBJ5Aqqmvdc1B@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3jl6u+qVoIkPBDQ--.13372S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4fCFWfZw4fCrWDtw1fZwb_yoW3CrW8pr
	1rJF1UGrWUJr18Jr1UJ3s8JryUJr1UJw1UJr1UJF18Jr1UCryjqryUXF1a9rnrJrWrtF17
	tr1DJr4UZr1DGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 8/20/25 23:43, Yury Norov wrote:
>>> This 'unlikely' version is just an negation of 'likely' one, and it
>>> looks like an attempt to save on one negation. On the other hand, the
>>> function is __always_inline, which means that compiler should normally
>>> take care of it. Can you prove with objdump that it really works as
>>> intended? I mean that 
>>>
>>>         if (use_alternative_unlikely())
>>>                 do_something();
>>>
>>> generates a better code than 
>>>         
>>>         if (!use_alternative_likely())
>>>                 do_something();
>> use_alternative_likely() and use_alternative_unlikely() are not
>> negations of each other and in fact should be functionally equivalent. I
>> also briefly explained the difference in the comment, but the difference
>> is which case is nop i.e. fallthrough, and which case requires a jump
>> instruction. The likely case should get a "nop", and the unlikely case
>> should get a "j %l[...]". This choice does work as intended [1].
>>
>> I don't think it is possible to give both options to the compiler, so at
>> least for now AIUI users have to pick one.
>>
>> The same applies to __riscv_has_extension_{likely,unlikely}.
>>
>> Vivian "dramforever" Wang
>>
>> [1]: https://godbolt.org/z/v8zTEhzTx
> I realize that likely and unlikely versions generate different code,
> I'm just not convinced that
>
> 1. it works in real kernel as intended, not only in the godbold; and
> 2. has any measurable impact.
>
> That's why I asked you to share objdump and possibly perf tests.

Ah, that makes sense. I had considered my patch to only be refactoring,
so I only sought to preserve the original logic rather than to achieve
an optimization.

I don't have concrete performance benchmark results, but since it is a
mere refactoring, the performance should not be worse than what's
already in v6.17-rc1.

Having said that, I am also fairly certain that the selection works in a
real kernel. I have put two objdump examples at the bottom of this message.

Vivian "dramforever" Wang

------------------------------

I grabbed v6.17-rc1 with this series applied, and built a defconfig then
mod2noconfig then DEBUG_INFO_DWARF5=y kernel. The compiler is
riscv64-unknown-linux-gnu-gcc (GCC) 14.3.0. Then I looked for random
uses of Zbb instructions.

Here is an example in register_pidns_sysctls(), where it
calls num_possible_cpus(), which uses hweight_long(), which can use a
cpop instruction with Zbb extension, and falls back to __sw_hweight64()
otherwise. Here's the code:

        pidns->pid_max = min(pid_max_max, max_t(int, pidns->pid_max,
ffffffff8004ee38:       892a                    mv      s2,a0
ffffffff8004ee3a:       0444aa83                lw      s5,68(s1)
ffffffff8004ee3e:       9781aa03                lw      s4,-1672(gp) # ffffffff81814258 <pid_max_max>
                return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
ffffffff8004ee42:       012ef517                auipc   a0,0x12ef
ffffffff8004ee46:       e2653503                ld      a0,-474(a0) # ffffffff8133dc68 <__cpu_possible_mask>
ffffffff8004ee4a:       05c0006f                j       ffffffff8004eea6 <register_pidns_sysctls+0xc2>
                                                ^~~~~~~~~~~~~~~~~~~~~~~~ Jump to "unlikely" non-Zbb fallback

"Has Zbb" is "likely" here, and in that case this jump gets patched into
a nop and falls through to the cpop here:

                asm (".option push\n"
ffffffff8004ee4e:       60251793                cpop    a5,a0
                                                ^~~~~~~~~~~~~ Zbb implementation

ffffffff8004ee52:       00a7979b                slliw   a5,a5,0xa
ffffffff8004ee56:       873e                    mv      a4,a5
ffffffff8004ee58:       0157d363                bge     a5,s5,ffffffff8004ee5e <register_pidns_sysctls+0x7a>
ffffffff8004ee5c:       8756                    mv      a4,s5
ffffffff8004ee5e:       2701                    sext.w  a4,a4
ffffffff8004ee60:       87ba                    mv      a5,a4
ffffffff8004ee62:       00ea5363                bge     s4,a4,ffffffff8004ee68 <register_pidns_sysctls+0x84>
ffffffff8004ee66:       87d2                    mv      a5,s4
ffffffff8004ee68:       c0fc                    sw      a5,68(s1)
                             PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
                                                ...

Later comes the fallback code that calls __sw_hweight64() and jumps back:

        return __sw_hweight64(w);
ffffffff8004eea6:       004f2097                auipc   ra,0x4f2
ffffffff8004eeaa:       006080e7                jalr    6(ra) # ffffffff80540eac <__sw_hweight64>
ffffffff8004eeae:       87aa                    mv      a5,a0
ffffffff8004eeb0:       b74d                    j       ffffffff8004ee52 <register_pidns_sysctls+0x6e>

------------------------------

Here's another example ip_fast_csum() which has a Zbb implementation and
a non-Zbb one. The asm goto line seems to have been preserved in debug
information more nicely:

static __always_inline bool use_alternative_likely(u16 vendor_id, u32 patch_id)
{
        BUILD_BUG_ON(!__builtin_constant_p(vendor_id));
        BUILD_BUG_ON(!__builtin_constant_p(patch_id));
        asm goto(ALTERNATIVE("j %l[no_alt]", "nop", %[vendor_id], %[patch_id], 1)
ffffffff8000f952:       01e0006f                j       ffffffff8000f970 <ip_fast_csum+0x40>
                                                ^~~~~~~~~~~~~~~~~~~~~~~~ Jump to "unlikely" non-Zbb fallback

                                rori    %[csum], %[csum], 16            \n\
                                sub     %[csum], %[fold_temp], %[csum]  \n\
                        .option pop"
                        : [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
                } else {
                        asm(".option push                               \n\
ffffffff8000f956:       6207d713                rori    a4,a5,0x20
ffffffff8000f95a:       97ba                    add     a5,a5,a4
ffffffff8000f95c:       9381                    srli    a5,a5,0x20
ffffffff8000f95e:       fff7c713                not     a4,a5
ffffffff8000f962:       6107d79b                roriw   a5,a5,0x10
ffffffff8000f966:       40f707bb                subw    a5,a4,a5
                                                ^~~~~~~~~~~~~~~~~~ This block is the Zbb implementation

                                roriw   %[csum], %[csum], 16            \n\
                                subw    %[csum], %[fold_temp], %[csum]  \n\
                        .option pop"
                        : [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
                }
                return (__force __sum16)(csum >> 16);
ffffffff8000f96a:       0107d51b                srliw   a0,a5,0x10
ffffffff8000f96e:       a015                    j       ffffffff8000f992 <ip_fast_csum+0x62>

... and then it jumps further to more code. Then comes the non-Zbb
implementation, which starts with a rotate operation as well but has to
use three instructions for it

 * @word: value to rotate
 * @shift: bits to roll
 */
static inline __u64 ror64(__u64 word, unsigned int shift)
{
        return (word >> (shift & 63)) | (word << ((-shift) & 63));
ffffffff8000f970:       0207d693                srli    a3,a5,0x20
ffffffff8000f974:       02079713                slli    a4,a5,0x20
ffffffff8000f978:       8f55                    or      a4,a4,a3
                                                ...

And the non-Zbb implementation goes on...



