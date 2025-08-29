Return-Path: <linux-kernel+bounces-791504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E67B3B79F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E563AFC23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB04304BC5;
	Fri, 29 Aug 2025 09:45:18 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FC285CAB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460718; cv=none; b=Z+6tRRemI49BUfPcpU0HIYcAj9A9EfZPvzLxxvtbIXjwR0rmU+1nRqJEqc/r4+2Dn1ijnEx4aswj65j+OoEkKuvktxalcCjPP43rz+PsekhW3TDxzHxqMa/jgXaA6JOzxRVfsEphjLq3sDxajVRwCh+g3nfQQjzxM54gMx5ehR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460718; c=relaxed/simple;
	bh=90kTLjdQ5Dmkces/uCsWAArb2X21n22BDlHmzm3mHJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUH1m1DVkdqVpGDuQJuq69lITM9HhsszNoAarnixaEKtiPXBX8CqEgJkMnqa5tjVGTT9mdYNbGFe507oo1slTSePb5Iy4YRpd2ArsxHzoiY75l4TyFVj1uM+FGyAvsbsl5UgMc/OAbvvanWKK6jS1PxpcvaogxovLjW3AXJ+05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCtfd2q76zYQvtx
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:45:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E261F1A0A8B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:45:11 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgDnD5emdrFoIQK1Ag--.15325S2;
	Fri, 29 Aug 2025 17:45:11 +0800 (CST)
Message-ID: <3ee1aeb7-bd3a-4d6e-a446-2390de0ce561@huaweicloud.com>
Date: Fri, 29 Aug 2025 17:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] x86: Prevent KASAN false positive warnings in
 __show_regs()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20250818130715.2904264-1-wutengda@huaweicloud.com>
 <1cd29a46-3c17-42ca-af41-ed0a645b29c3@gmail.com>
 <2956719f-58bf-40ac-9c63-6f9a8092ae1d@huaweicloud.com>
 <r3gkmgetikfsuggva42qnfxzx3pdiy3vtl25fepfvvacvrzyjz@xmgcvxuquary>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <r3gkmgetikfsuggva42qnfxzx3pdiy3vtl25fepfvvacvrzyjz@xmgcvxuquary>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnD5emdrFoIQK1Ag--.15325S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryxGFykZF1fZryUWw45KFg_yoWfWrb_Wa
	yUAFWkurnIkFZ7X3Z8Kr1UJr9rWw4aqrs2qF95tF9rWry7JFWrAa18tF98Aa42qFsYyF9x
	uwn8ta4UK3yjvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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



On 2025/8/29 3:16, Josh Poimboeuf wrote:
> On Thu, Aug 28, 2025 at 08:06:17PM +0800, Tengda Wu wrote:
>> +++ b/arch/x86/kernel/dumpstack.c
>> @@ -189,9 +189,15 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>>         unsigned long visit_mask = 0;
>>         int graph_idx = 0;
>>         bool partial = false;
>> +       bool kasan_disabled = false;
>>  
>>         printk("%sCall Trace:\n", log_lvl);
>>  
>> +       if (task != current) {
>> +               kasan_disable_current();
>> +               kasan_disabled = true;
>> +       }
> 
> Looks reasonable to me, though note that some callers pass a NULL @task
> to indicate 'current'.
> 
> (No idea why, that subtlety should probably be removed...)
> 
> So this might need to be
> 
> 	if (task && task != current) {
> 		...
> 

Dave mentioned that there's an object_is_on_stack available, which is
essentially on_current_stack. I will try using it and send out v2.

Thanks,
Tengda


