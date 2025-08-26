Return-Path: <linux-kernel+bounces-786616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BCAB35F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54E414E3E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628B1DE2D7;
	Tue, 26 Aug 2025 12:30:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6814B977
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211430; cv=none; b=b7VAuASF5csnIA20fKITbgGUFkRZ3n+EH/h67hRsCS+86SrdzcX1V07AEACA4gF7cr/54RaaNHXo5aV8sAgjI07pHcPDYCyBB5Wa9Vgpp9u6soda/6De4/rM/6TQYb8sdOdSMgK595N8qgIsYQBfmkq7llHulOQbWdPuoY+4tNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211430; c=relaxed/simple;
	bh=vi9HxGRPG4Osqc5VgRy7CzXqp8laDNkYadtP54HwQoM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G6LQPlQSNGI6iSN9HQd2PY2qXj40Z/5WWtsE20l2xlrC9zH0uLgnyw/afQTxJUKIr1rQK3EchkO1PsK+eyvDrndbmDlgcRuPoO7++tpJHxqRbau337yPqUolLRNld4JROJk5u7qqhGLO4cZM1husOV42eWZeEAEFnp/iT6XLRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxN9HhqK1ou1wDAA--.6573S3;
	Tue, 26 Aug 2025 20:30:25 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxT+bgqK1opP9pAA--.65380S3;
	Tue, 26 Aug 2025 20:30:24 +0800 (CST)
Subject: Re: [RFC PATCH 2/2] objtool/LoongArch: Fix unreachable instruction
 warnings about head.S
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor
 <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-3-yangtiezhu@loongson.cn>
 <CAAhV-H7NNtH-oaqMsN5=2c+EdF0-dy5mxcsO=_KFGWqb-FZj_w@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b7551efd-cb5b-7503-c455-b8f22fac81bd@loongson.cn>
Date: Tue, 26 Aug 2025 20:30:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7NNtH-oaqMsN5=2c+EdF0-dy5mxcsO=_KFGWqb-FZj_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxT+bgqK1opP9pAA--.65380S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFWkWF47Gr1kZr4UuFyrXwc_yoWkCFg_ur
	17uw48W3y8Jayqvw1DKasxuw1UZanY9F4FyrykZrZFv3WrJry5Xr47Jw1rurn8Kr4kGrZ8
	A39Ygas3Ar1UtosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_
	Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
	xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUcDDGUUUUU

On 2025/8/26 下午4:26, Huacai Chen wrote:
> On Tue, Aug 26, 2025 at 2:46 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
>> following objtool warnings after silencing all of the other warnings:

...

>>   arch/loongarch/kernel/head.S | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>> index e3865e92a917..566a1dbf5fa0 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -20,6 +20,7 @@
>>          __HEAD
>>
>>   _head:
>> +       UNWIND_HINT_UNDEFINED
>>          .word   IMAGE_DOS_SIGNATURE     /* "MZ", MS-DOS header */
>>          .org    0x8
>>          .dword  _kernel_entry           /* Kernel entry point (physical address) */
>> @@ -30,6 +31,7 @@ _head:
>>          .long   pe_header - _head       /* Offset to the PE header */
>>
>>   pe_header:
>> +       UNWIND_HINT_UNDEFINED
>>          __EFI_PE_HEADER
> The efi header is completely not code, the annotations are very strange.

Yes, I think so too, but the aim is only to not checking for objtool,
it seems no other better way.

Thanks,
Tiezhu


