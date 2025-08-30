Return-Path: <linux-kernel+bounces-792697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED551B3C7C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63975A1030
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A012773DF;
	Sat, 30 Aug 2025 04:07:37 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47039230BF6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526857; cv=none; b=fTA+dxnAILTyxQBiHWiYwGRi/cUmTJrRTbCEO0YcJmW/7xG04Vx0C4h0T9hUh84Yn7cB4uHbr6V1waC7NJ1sRQhCWHx0Wc2SI/MGk6RQmQVcb0NM4Lw5sgznn862jY5MtlriAjG1g4oK+rggOCYqIY5K6Oa7Lmq4U3xP1AF54AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526857; c=relaxed/simple;
	bh=1LYhGoIJ+0VifjvDdy/NG+rcCr8YXjXg9PljDtzY0Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2v/pCv+RpCyr9de02ns6YcS/eXqJRHwMzTDvS7sJ6fQMzsDy4C9AIaOM3AgvW9Mj4ZC2vqDYqj3DKJqtBd49Cqq3BvxXddNy7NsUAywyGkYdrDHh+1nZWbvAPl2PxU2tuEGAiWHubguOU8OBleZx8OcPGwgriBHZctPGlKJUHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cDM6W4wgnzKHMpZ
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:07:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6F7DE1A0B61
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:07:31 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgC3dXsCebJox2IFAw--.4026S2;
	Sat, 30 Aug 2025 12:07:31 +0800 (CST)
Message-ID: <056f637f-d992-46b6-945c-bd85dde04731@huaweicloud.com>
Date: Sat, 30 Aug 2025 12:07:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] x86: Prevent KASAN false positive warnings in
 __show_regs
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Dmitry Vyukov <dvyukov@google.com>,
 Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20250829094744.3133324-1-wutengda@huaweicloud.com>
 <xlaeuraw7mupek3fp62o7ahp5viusp6uo36jadtuidpwwkmy6a@5pzmlcxtb2ro>
 <ac1bb376-5b16-4d06-81a2-8d15315beba2@huaweicloud.com>
 <372iwvlxzynnnzn42wo2kur5enrlzzcqqnx5gx6o6bnfyqqlgx@p7drg4of3sdc>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <372iwvlxzynnnzn42wo2kur5enrlzzcqqnx5gx6o6bnfyqqlgx@p7drg4of3sdc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3dXsCebJox2IFAw--.4026S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw17Zr1UKw1kZr15Kw17KFg_yoW8Zw4rpF
	Z5Kasaya18AF4IvFyqyw48Zr9IyrZ5Xr1kur1fGr4ft3Z0vr1fGrySgF429Fy5Crn7Xa42
	vF4Dtr9xAws0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/8/30 10:18, Josh Poimboeuf wrote:
> On Sat, Aug 30, 2025 at 09:34:59AM +0800, Tengda Wu wrote:
>>
>>
>> On 2025/8/30 5:01, Josh Poimboeuf wrote:
>>> On Fri, Aug 29, 2025 at 09:47:44AM +0000, Tengda Wu wrote:
>>>>  static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
>>>>  				  bool partial, const char *log_lvl)
>>>>  {
>>>> +	bool kasan_disabled = false;
>>>> +
>>>> +	/*
>>>> +	 * When 'regs' resides in another task's stack space, KASAN should be
>>>> +	 * disabled to prevent false positives during 'regs->' operation, as
>>>> +	 * the 'regs' contents may change concurrently with task execution.
>>>> +	 */
>>>> +	if (!object_is_on_stack(regs)) {
>>>> +		kasan_disable_current();
>>>> +		kasan_disabled = true;
>>>> +	}
>>>
>>> I don't think this is right.  object_is_on_stack() only checks current's
>>> *task* stack.  However the regs might be on a different stack used by
>>> current (e.g., exception stack).  In which case there's no need to
>>> disable KASAN.
>>>
>>> What really determines the KASAN-safety is whether it's the current task
>>> or not.
>>>
>>
>> I see.
>>
>> Since operations walking other tasks' regs-> only occur in show_regs_if_on_stack,
>> to cover a more accurate range and targets, it seems we have no choice but to add
>> a task parameter to show_regs_if_on_stack and then perform the check, right?
> 
> Reading another task's stack while it's running is problematic in
> general -- not only for reading saved regs, but for reading any other
> values on the stack.  So why not just do it in show_trace_log_lvl()?
> 

Theoretically, that's correct. I was too focused on the regs itself and overlooked
this fact. Additionally, I just discovered a potentially missed fix: there is also
code in show_trace_log_lvl that directly accesses regs->:

		if (regs && stack == &regs->ip)
			goto next;

Simply disabling KASAN within show_regs_if_on_stack is indeed insufficient.

Thank you very much for the reminder. I will send out a v3 to move the KASAN check
back into show_trace_log_lvl.

-- Tengda


