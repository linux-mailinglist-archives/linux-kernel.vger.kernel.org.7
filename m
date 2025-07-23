Return-Path: <linux-kernel+bounces-743243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921C6B0FC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779D41CC2F36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55112271A6A;
	Wed, 23 Jul 2025 21:56:24 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41A2586CE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307784; cv=none; b=Wg0+XSi4FvL+OrIjMJF/Y4KqrJIeNAau5sYKQYJ/G9NA8cMmQdlk7BoVadcI5psPvhtjk69+CgkHHkNAWWOXsO9aaNbcG4Y8rgxUASnTsFXrpgvL6vZdWWz3MlR2XBd07xbmcfW/X8VXPVklp9bbqyE6VjTXVmx/yzzGLp4VcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307784; c=relaxed/simple;
	bh=h5fidwheReB8jzMnJ7QDOBpG+ySuxH/txFGjLqCBjn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XtM/7lKf0C+sSfXYNru/zLzak9HmItlZbSoM4jE2ylbDh3d8hiaNS9sq+5S/fn4O6ViX+zYLDBAUOf3rSKuXaYdZsno95+R2QLLEqKoPqpMZ75V3+vpi1N2XRUW6POLUmIzev3pJT3utNayb2RQ+zFCiCIY5cJVriaNKLrjoq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.110] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowABHn19pWoFo4_WXBg--.21325S2;
	Thu, 24 Jul 2025 05:55:55 +0800 (CST)
Message-ID: <cc82c938-def3-4df6-9fc9-fc321af7d54a@iscas.ac.cn>
Date: Thu, 24 Jul 2025 05:55:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
To: Drew Fustini <fustini@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Drew Fustini <dfustini@tenstorrent.com>, Andy Chiu <andybnac@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250719033912.1313955-1-fustini@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250719033912.1313955-1-fustini@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHn19pWoFo4_WXBg--.21325S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17CF1fJr15Zr4DGr4fGrg_yoW8Ww13pF
	sFgrsIkw1rZr4fAwnIqw4xuw4rKrZ5G3y5JFy3Kw42yayUGF90yrs8JayjqFy7Jry5GrW0
	vF4ru348Cw1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 7/19/25 11:39, Drew Fustini wrote:

> From: Drew Fustini <dfustini@tenstorrent.com>
>
> Clobbering the vector registers can significantly increase system call
> latency for some implementations. To mitigate this performance impact, a
> policy mechanism is provided to administrators, distro maintainers, and
> developers to control vector state discard in the form of a sysctl knob:

So I had an idea: Is it possible to avoid repeatedly discarding the
state on every syscall by setting VS to Initial after discarding, and
avoiding discarding when VS is Initial? So:

if (VS == Clean || VS == Dirty) {
    clobber;
    VS = Initial;
}

This would avoid this problem with syscall-heavy user programs while
adding minimum overhead for everything else.

Note that I haven't checked closely on how VS = Initial is currently
used in Linux. This might require changes to vector init make the really
first-time initial state and the after-syscall initial state the same.
Or maybe I misunderstood entirely.

Vivian "dramforever" Wang

> /proc/sys/abi/riscv_v_vstate_discard
>
> Valid values are:
>
> 0: Do not discard vector state during syscall
> 1: Discard vector state during syscall
>
> The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
>
> Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  Documentation/arch/riscv/vector.rst | 15 +++++++++++++++
>  arch/riscv/Kconfig                  | 10 ++++++++++
>  arch/riscv/include/asm/vector.h     |  4 ++++
>  arch/riscv/kernel/vector.c          | 16 +++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> [...]


