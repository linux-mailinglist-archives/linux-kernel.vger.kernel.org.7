Return-Path: <linux-kernel+bounces-885778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC47EC33DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65E33B7222
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0F326ED2F;
	Wed,  5 Nov 2025 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="p4Qfm/O8"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33726E717
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314132; cv=none; b=Jw9LRpr7cNEVeFiyI89H4v5AXWU8n+dJ0UjpreSYoCmoe5c7+Ebv15RUoj52X3ktqgYC+MxcgCgbJl6YDPjlaq7ZVitDq31Le3AmDPmwQw170/Qqp8xWT5rleXhtcQcJeAfXPnSsqwoNDhvrf8HzEHPpKBFhK9H1XVGmRAfERG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314132; c=relaxed/simple;
	bh=kfWqE0FbzBx6MxH/hSe472OX3UkouXxpSm8pkGdGFic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iH4Y68uF1Df5tRYcKQFQwl277FsvdqKD/MwnzXnIXdbFeteTdgO9AYK161oo4k9HfElKfMQee32LAADvCi5dJ5HljnhN+hT2/QroiCJoAi9fF7FRwfDiqLazbyMuDtlQ6pc9WzJ+yl7tUjCuXM931pRArxofhkVy5obp/Vv8+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=p4Qfm/O8; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762314078;
	bh=Fz1i1LUkKPABBVeGFuF+90i9fD0TWAWKRpPjxlVqDQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=p4Qfm/O8eUwmCkXyYb9QYb2gd6ZrMx9VQKIs9JVXvUr1DyYmU3EGHZarSoSBu3hy4
	 8vtQ7eU0+8XnSLN8/9qSHcsCNjerhX7tkfBjIwfy2Z3nSPnqG0VeyKnXIT42KxkvZu
	 y8OmLnt/xipiXrKigicZSrhoLlqMW1hm/HkE/AcQ=
X-QQ-mid: esmtpsz17t1762314071t04862f69
X-QQ-Originating-IP: VZ8hyRnddlbw0XyeY8Fe92+B5KFDCJfwg0xaIeEEtQg=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 11:41:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4576968291990005006
Message-ID: <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
Date: Wed, 5 Nov 2025 11:41:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-4-maqianga@uniontech.com>
 <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MAN6sKHDZ5xSrxCnFlhyBCwy/ehiSqR3NikowjD2bOoDld6ue6Uy8Xaf
	6rHdi0fmC/XUMGCb5sXYb5ugGOHCvVZ3AfojMH/LRyQ2IfcyVKN5LAfBl+MT3FNJPxavsVk
	U+wHM8A0pHk/zxojtc/m6LcPshKO0jV1zexHfq9ijIS0LLyek2n/d8B2yiE+++PDevh7+0e
	5noqa7UWvrRirb7B7hiqGB4vPephCZq+ZNbvZUFtfuBRklOZp3csPBGNpdU+sOSCXrlmhoL
	YrKjZd6LF8uBUxTwNLA+1CQHokTi2v5lfHOrrkjJ8HaZQNZtH5U1E2wweEi+sqA85vwC0OT
	UPbvNoG9PjTTwbKJ5itcokxlq05+U0fcahtSG0xPSm+mXnPmj7nGAhJYVv4O6chDvNMcQLU
	WPlUfrLRE3xRLMH5fx5Az3yPmSURCVTk8+jVhhNT8UzuC57lLfNzqlqi1gdDEfADLGBq3wq
	8DNStGIQdTJ8Lb5kiEKxKdmGHHjxvQoyZzvuaIOCi9H2mp07bvCd1aTikz0j0LuRgKc6ELr
	4H+b1KB+6E5p8t9LQq+DKdZSbDkE8w3xza8bLIEkZ1p+ltCanJoIVcufNLOTmaoBa9o98r6
	QHjZmjs812MaB4tppTnykahEo8mKj3e+2nbZ0daKR/c7PxocYv5QYHrxMmm7szOw5KDRrr7
	LP7pB9xjdpxcUSyGC2/CZiLKmb6lAACZOVJZpO9vRiB2DxV+T/QZdW564C/M0j3Ef6XEDvr
	hvLsH8nNrxFs93r2R7R8wRCHYd3eDImLbUSa/98NPs4cbfK3baaZy7spnTmnELClAEEuDuN
	/G/IlxWTQuq41fJgddNcfboBoDkQwvshM/GjMtHEe1Z1CasVyD9qU6qC+PlQ+7ZcCHJL/L0
	4S2p13z/oN5HKRRi9gsaV8F4MDdQyCZryYDnmz4XrrU7tX94+fx99y//VbH48nr9S/vmK6Q
	ut7bmaXpU+Ue1qCAY+otiD/MYoeaZBC86cquopZdlNNHmu5CuD2mUoLm8Fn4wocuhrCCBWC
	dwbmI9rR5QDxOwNa7kP5onO2C02GuyQzGexLzVKg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0


在 2025/11/5 11:01, Baoquan He 写道:
> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>
>> Especially in the RISC-V architecture, kexec_image_info() has been
>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>> message if required")). As a result, when using '-d' for the kexec_load
>> interface, print nothing in the kernel space. This might be helpful for
>> verifying the accuracy of the data passed to the kernel. Therefore,
>> refer to this commit a85ee18c7900 ("kexec_file: print out debugging
>> message if required"), debug print information has been added.
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
>> ---
>>   kernel/kexec.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index c7a869d32f87..9b433b972cc1 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
>>   	for (i = 0; i < nr_segments; i++) {
>> +		struct kexec_segment *ksegment;
>> +
>> +		ksegment = &image->segment[i];
>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>> +			      ksegment->memsz);
> There has already been a print_segments() in kexec-tools/kexec/kexec.c,
> you will get duplicated printing. That sounds not good. Have you tested
> this?
I have tested it, kexec-tools is the debug message printed
in user space, while kexec_dprintk is printed
in kernel space.

This might be helpful for verifying the accuracy of
the data passed to the kernel.
>> +
>>   		ret = kimage_load_segment(image, i);
>>   		if (ret)
>>   			goto out;
>> @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>> +		      image->type, image->start, image->head, flags);
>> +
>>   	/* Install the new kernel and uninstall the old */
>>   	image = xchg(dest_image, image);
>>   
>> -- 
>> 2.20.1
>>
>


