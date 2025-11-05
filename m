Return-Path: <linux-kernel+bounces-885783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57956C33E18
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3F6C4EBFA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77889243367;
	Wed,  5 Nov 2025 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Gtb+qKZ9"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0B2A1BF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314514; cv=none; b=Xzm1Q1gRKMnLc3eol2r9ec7721MnAXY5IHtgetNypy2OZ7w9sCmXs79XIPE6c5uTkFiHShFoNoeu3QgrZrIRas/Vr21AvkWq0v3Pb53VWjfNWxhNgpe2fB2W62NmifbTLcbHHqPCVyEOD+QgRk0fBiQgZsca7j2bTgdgKVh2gn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314514; c=relaxed/simple;
	bh=OwUqpiyEXR9jOmH6UTFGLAxSXjMx78ONbMnPqk3nl7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g633Akv+Lls75bkpZgp4vZtSuXQ4RN7UBhjAULHwhkCEy9othAfEVGLo4MC8ucxjIGYkCYelsAhkw8eLRUhWL7+8y89JlUIgDzkXiQqm+HT09wLA8IaungX63aBwWLVLd9toRNjssVXQKPRcml9AsR8NLfJobx8lCqBW8W+oQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Gtb+qKZ9; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762314468;
	bh=uj8Nz0JfD8slLLWQNz82y/cC4BmAzibmLr+5pvmuf3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Gtb+qKZ9Y8TplYJuKTRcYwSzwYvCubsB3xYb6Hp4KBWTF76dl26kRagdwZEpAHZq/
	 dQ7IShf1wZlzi/LyeCRIs/n/cnUhoLPLB7K8eod+a4MxUF997sXZo7TddtAZBfyati
	 smvnQ9mlgc59TfPyB0XrAV/Et7bPd+uSeoYTtINk=
X-QQ-mid: zesmtpsz9t1762314465t513ccd07
X-QQ-Originating-IP: UwD2sx5gUmoWIK0Jwk0DEJnatDYiVmhnpsekl7MKibk=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 11:47:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5895719497772845122
Message-ID: <0C92443D3E2100AF+c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
Date: Wed, 5 Nov 2025 11:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between loop
 variable types
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
 <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MQPu5pFEJFN4aBoiXeS/dENQRD61DZk1C7cnTb39ufRAgPtwA6xASws1
	2Z41/RQm8b+hQxQZZdcwn7WSw7/bCEncQVR65LsDD9U0KzZdUNX16I/FqbNK25kCm2tHoXj
	xS9827dRXff3xdNBWhrQF8DrZ1q430FR0bTBtJZmFCXvff1I8akT1dJ4G+80alvjw3Sd/0p
	OwxvjjNxYCSd4WyEFlDpNE0gS2fKQpFycHbsfDK+I/DV9nVC9svxKbri8GtPtPL3F+tvFUb
	iwuOXzoBGHdkEz3mwsL6NlkrbuXRcljFR5GiFQ+Zj+g+0xlFFW6l4Rp3KS9hoVcB6HJDJ94
	fh6gDhbAoXk7juMHbJxo4EmYu7LE07PBEQ9jlUKFMFpRwDUp1pFRb7+GQuvldw6WWIUeNQo
	b6hY1GD7ONVIuQSxelhrhgkmcOJgj2dU+ZvE4kpZfRbvcGGhHn0tVJcAb2C43d+VTiAQTs9
	bYn206xrOGKkrEE9YGvWXnh8TnF2ykE+USWtAoskLcxIDBCpPli2NTwNha1nHz0AcK6ufqO
	9lGc13fW126v2DCTsc3Qm3yXfPYP+GIjeAnMOlqglr/XMf1OhK1pXBLELjdB+YUtWoQz4ms
	+WGqeGkjFgNvAvOX5tH3GbwYLK5daZwOdmYeHAnJ6SGhl/k0fHiyr6MeUt432QFSnVa7ImN
	dv74QBYZGTL2zkGb2ic6IKZ5+k0tzLM8di+zk1oZH2b+Di7HWagLKunEHgo8SAqUb4H/x7C
	4YD6AMfFgFfAFcBiOw9xZPCZsj8wbSY888z2CmW1K2jzEYC1yCUloeoQrO6a+ctoR1Oodoz
	V9OKczGLjacxgdmCzX5+/jJRl5kA1eSD6aJfJw1OUQmJzf9EQca6hmHPxXPidYL1w2bMyid
	1ExUkFj8D0w1DNO5zgt2Qg4O0YFDAeMstxmVdQoEl2eer4xjzZqWTh5h34r8as69vDLsWSc
	vZAUS1BxTu1+IFF04IWM76pFAg9UE+wl9EqIxtyvkBF1a4BqRsErVcC3Ay7nT40DF5ZBNBj
	VVa259XtxsCHPqN4ay
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0


在 2025/11/5 11:05, Baoquan He 写道:
> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>> The type of the struct kimage member variable nr_segments is unsigned long.
>> Correct the loop variable i and the print format specifier type.
> I can't see what's meaningful with this change. nr_segments is unsigned
> long, but it's the range 'i' will loop. If so, we need change all for
> loop of the int iterator.
If image->nr_segments is large enough, 'i' overflow causes an infinite loop.
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   kernel/kexec_file.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 4a24aadbad02..7afdaa0efc50 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>   	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
>>   			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>>   	struct kimage **dest_image, *image;
>> -	int ret = 0, i;
>> +	int ret = 0;
>> +	unsigned long i;
>>   
>>   	/* We only trust the superuser with rebooting the system. */
>>   	if (!kexec_load_permitted(image_type))
>> @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>   		struct kexec_segment *ksegment;
>>   
>>   		ksegment = &image->segment[i];
>> -		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>   			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>   			      ksegment->memsz);
>>   
>> -- 
>> 2.20.1
>>
>


