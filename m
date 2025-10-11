Return-Path: <linux-kernel+bounces-849320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4392BCFD2C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 00:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C31A44E059B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676B223DCE;
	Sat, 11 Oct 2025 22:21:44 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F78188580
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760221303; cv=none; b=CCvnLQcVeuLfpG7gWZbMgmsQgdMKaMeFbLsDdQKESK5kzq7Q+T5/eaUgioPdhjOD7MQZZQX/w949nXy+xVzV4xf3W4aQ4aqWzrffg9phXVl0DA1xiemApfAw/0WmhOW0fJTXJzYBWDrYlLJF9L+QefTvKMVS8QxQaUL8S4eRN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760221303; c=relaxed/simple;
	bh=4+LjS1OMT/h8Rh+c/hjPk9/YtD1yGkpZtFnFNWpv6Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZN56uXND/Rvv8sV0mnKw/RmALuwZWO7vXlRf7KILvB/b71uVl4w9woNwB1QvcdLbhWCxy1gCsu+lcruwNJrL9yMQQva6ZPZXFv1P15Nx+JHogKPhTAXTZ+NbHU0T0xRoJtwjBCSvHADNzYmUVF6r8qtiuaZXam+/3QL3JDajh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [114.241.81.247])
	by APP-01 (Coremail) with SMTP id qwCowAB3zZ9c2OpoVz65DQ--.4665S2;
	Sun, 12 Oct 2025 06:21:16 +0800 (CST)
Message-ID: <60069cae-64fb-45de-8b74-e9a42a4b01b6@iscas.ac.cn>
Date: Sun, 12 Oct 2025 06:21:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] riscv: Use __riscv_has_extension_{likely,unlikely}
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Walmsley <pjw@kernel.org>,
 Charlie Jenkins <charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
 =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
 <20251011-buffing-never-4911edc10600@spud>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20251011-buffing-never-4911edc10600@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowAB3zZ9c2OpoVz65DQ--.4665S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4DKFWfJry7Xw4kZr1fJFb_yoW8WFWkpF
	ZxXas0kF1kJw42q34kZr4DXF4FqrWfGw45JrnxKry7Z390yryfKrsayayY9F1j9rZYqw4j
	vF40vwn3Zr95ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
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


On 10/11/25 19:28, Conor Dooley wrote:
> On Sat, Oct 11, 2025 at 07:35:42AM +0800, Vivian Wang wrote:
>> There are about a dozen uses of asm goto in arch/riscv just to select
>> between two code paths with the alternative mechanism. Convert them to
>> the existing helpers __riscv_has_extension_{likely,unlikely}.
>>
>> In each case, I have preserved the existing code's choice of asm goto
>> pattern while picking between "likely" and "unlikely", namely:
>>
>>   ALTERNATIVE("j %l[no]", "nop", ...)   -> "likely"
>>   ALTERNATIVE("nop", "j %l[yes]", ...)  -> "unlikely"
>>
>> Since the helpers are just implementations of these patterns, the
>> performance should be the same as before.
> Can you explain why you're opting for the __ variant, instead of the one
> without __? They should do the same thing in your cases, and resolve to
> the alternative, since the non-alternative function call will be
> unreachable and the assert is compiletime. There's currently no users of
> the __ prefixed versions outside of other extension detection helpers, and
> I think it should probably be kept that way if possible.

I agree that it's preferable to use the non-__ functions. I'll do that
in the next version.

The only real reason I had used the __ versions is so that it would be
equivalent to existing code, although as you said these should be
equivalent since the uses are already guarded behind.

The "pgtable" code currently isn't guarded behind CONFIG_ALTERNATIVE,
although now that I think about it, it should actually be preferable to
do a runtime check than to do a TLB cleaning, so that one should
probably be non-__ as well.

Thanks,
Vivian "dramforever" Wang


