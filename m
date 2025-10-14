Return-Path: <linux-kernel+bounces-852184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B71BD8603
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4003019219EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2C2D47E4;
	Tue, 14 Oct 2025 09:15:12 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5EA2C11F0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433312; cv=none; b=frAp2yoB2mXh/CWM7kjqSt8y9/OcB8yO48o9dma2oKa/F91CBc3NzTfbMQu0Lbg1awsWVnGNI1sS7upR0H+95IqhmDdbOaGofmLutz+5zuUGkvMtsuPGkCo7nYV66P9KOShtDZm6bn9q5mGJDOjo+sRkPcYN4qfcVTW2H8yZ7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433312; c=relaxed/simple;
	bh=Gohhxkd3Lce4OMDsQsdrTzavIZwykgMHWtUFP063JkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be7QiK3ulSVF+6vO7p+0n6JkXFJNVilYv7LPNLwGwjeOOB858UpVD04tm3uNNz4bvYUdG7xHH7L+eLrv2IWTToLsnY5hAaX/7SNN1lQ4M2LooThPgrH3DfpNDL4PVJekn8p6RrBk3nGCo1f58GcGqO8Rpxxt5nrWWwXgV2rKFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.100] (unknown [114.241.81.247])
	by APP-01 (Coremail) with SMTP id qwCowACX76FpFO5oM4pjDg--.33359S2;
	Tue, 14 Oct 2025 17:14:17 +0800 (CST)
Message-ID: <6b7c3c90-d3bd-4d75-9cc0-74d3945fbdfd@iscas.ac.cn>
Date: Tue, 14 Oct 2025 17:14:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
To: Conor Dooley <conor@kernel.org>, Lucas Zampieri <lzampier@redhat.com>
Cc: linux-kernel@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 linux-riscv@lists.infradead.org, Zhang Xincheng <zhangxincheng@ultrarisc.com>
References: <20251013111539.2206477-1-lzampier@redhat.com>
 <20251013111539.2206477-4-lzampier@redhat.com>
 <20251013-trimness-stainless-48343053f204@spud>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20251013-trimness-stainless-48343053f204@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACX76FpFO5oM4pjDg--.33359S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4UGrWDur4xtw4xtw4xJFb_yoW8AFWxpF
	WDKa4vyF4kKFyIvw4Igay0yFyfCr4xtayYkr95Ww40k345ZF1xXrWxKa45ZF9I9r1kX3W2
	kr4Fk3srua47ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07j0fOwUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Conor,

On 10/14/25 02:30, Conor Dooley wrote:
> On Mon, Oct 13, 2025 at 12:15:38PM +0100, Lucas Zampieri wrote:
>> From: Charles Mirabile <cmirabil@redhat.com>
>>
>> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
>> work around a known hardware bug with IRQ claiming.
>>
>> When claiming an interrupt on the DP1000 PLIC all other interrupts must be
>> disabled before the claim register is accessed to prevent incorrect
>> handling of the interrupt.
>>
>> When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
>> the enable state of all interrupts is saved and then all interrupts
>> except for the first pending one are disabled before reading the claim
>> register. The interrupts are then restored before further processing of
>> the claimed interrupt continues.
>>
>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
>> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
> Why is that? I expect that you're doing that intentionally given the
> ultrarisc employee listed as a co-developer, but with only one SoC using
> this IP core it seems possible that this bug in the hardware could be
> fixed for other SoCs that are built using this IP core.
> Is there a plan to, for example, change the core version to UR-CP101
> when the bug is fixed?

I originally proposed to match on ultrarisc,cp100-plic under the
assumption that it would be the case.

Furthermore, it is my understanding that if the bug is fixed in, say,
UR-DP1001, then the PLIC node can simply be

    compatible = "ultrarisc,dp1001-plic", "sifive,plic-1.0.0";

I meant my reply that I had assumed this bug was associated with the
UR-CP100 core, but I should have stated so more clearly. 

Vivian "dramforever" Wang


