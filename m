Return-Path: <linux-kernel+bounces-792641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA0FB3C720
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D933B59B7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FEE1C07C4;
	Sat, 30 Aug 2025 01:35:06 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87D2C859
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756517706; cv=none; b=dduX5FAP+SctnIPdMqw3oyi/eD6GPb7TnvVm3oLMJ8GR4iJyNNyqNw+vJ/m+l4nLvX6Q2OWx7cH7wLhbXqbg0sbbglE0/6FObpsQzNjMiHEPaaYsJ1s91iinqVMWU8bb9AZIzIx6Wyq7p7OdOjX+FNMMt9rIBvTeZb00Gu10Y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756517706; c=relaxed/simple;
	bh=ijzvWh0TzEH7u5xs/tSn46YbO9xaLfMw5bheNAK5N0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxqJfP7UU6ezPU6ErzoLcfXROTmdQquvhArP/2t3rBwbo37/OluSZJpRFFWHijJlXhOUQ0h0uCtiughlNvbCYM6RJgzQK3TCXgSjKZG89dxRqstV4ZSFxXKA1yD0nA7czZsTmp7WXXuHrwXB4Pa7+bQSocAUR7iVOZpc6FwG9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cDHkZ214fzYQtvj
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:35:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C87341A1747
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:35:00 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgD3IZlDVbJojej+Ag--.6253S2;
	Sat, 30 Aug 2025 09:35:00 +0800 (CST)
Message-ID: <ac1bb376-5b16-4d06-81a2-8d15315beba2@huaweicloud.com>
Date: Sat, 30 Aug 2025 09:34:59 +0800
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
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <xlaeuraw7mupek3fp62o7ahp5viusp6uo36jadtuidpwwkmy6a@5pzmlcxtb2ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3IZlDVbJojej+Ag--.6253S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr18WFy5Xw1UZF13KFyDWrg_yoWkuFb_W3
	yvvFWqkr43AFs3Aw1DWw4UXry7Ww45Gws3JF48KFWjqrykJrWkJrZYyF93Ary7Xw1jvFnx
	Cw1Dt34ak39F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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



On 2025/8/30 5:01, Josh Poimboeuf wrote:
> On Fri, Aug 29, 2025 at 09:47:44AM +0000, Tengda Wu wrote:
>>  static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
>>  				  bool partial, const char *log_lvl)
>>  {
>> +	bool kasan_disabled = false;
>> +
>> +	/*
>> +	 * When 'regs' resides in another task's stack space, KASAN should be
>> +	 * disabled to prevent false positives during 'regs->' operation, as
>> +	 * the 'regs' contents may change concurrently with task execution.
>> +	 */
>> +	if (!object_is_on_stack(regs)) {
>> +		kasan_disable_current();
>> +		kasan_disabled = true;
>> +	}
> 
> I don't think this is right.  object_is_on_stack() only checks current's
> *task* stack.  However the regs might be on a different stack used by
> current (e.g., exception stack).  In which case there's no need to
> disable KASAN.
> 
> What really determines the KASAN-safety is whether it's the current task
> or not.
> 

I see.

Since operations walking other tasks' regs-> only occur in show_regs_if_on_stack,
to cover a more accurate range and targets, it seems we have no choice but to add
a task parameter to show_regs_if_on_stack and then perform the check, right?


