Return-Path: <linux-kernel+bounces-878134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E1C1FDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A292188EDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D546333DEC4;
	Thu, 30 Oct 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jNlULWf8"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B62E0418
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824558; cv=none; b=J1FqHIlMG1TBlzhJtA0L50lFQtq+reDAYEWmnixCdboOMHN3ZnirFE9CQpChdSLnOqBvjy57cUYwK/rzoJTU42mqGKSwx1Xc6AL1R7pdh6IXvtf0Hh5qQdgTfEuHvMC+t+RiExMLE1+DBK4jgQeQGpSqQEYmm2zodqDiiGjefe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824558; c=relaxed/simple;
	bh=xM2z0+7QTLL6PUozQ01LvcYcbApsIcaCqpNpg+dKg6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eW2GHRa1LqPYl0RkFxtRSHBt6scZcqDCrxNYiMxvXPffqymekzrlbMDHIST6nQoYfJxK7lDnzciLA3SZRnh47jWxWermgrVYKSBjMbTNmeKWNwTNssCFrjrM8kqhmA4f5779CcazURYOrBPvtoebitM3sVi+IZi9s14udMc1m+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jNlULWf8; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761824497;
	bh=ik0Dn6yoIaOsn0IBZHf2Z40Y5QF2XOwk9Yc8uDtsDqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jNlULWf8s3rVMsXUtMVjqfY3V/r6moayXcXzV8n8bmIzeh+SIhnaD3rzhspYg5Wh+
	 mfognda4c8anoziMnfTjou+BtMh728k3QJdpxGg2xuzEUgx8Os9uyogWZn5ODMynj2
	 yWfCScHy4KeY/1JSHpz+heI0ViFQPGumtJE/ZStw=
X-QQ-mid: zesmtpsz6t1761824494tf6ab64b2
X-QQ-Originating-IP: QXnFLkcs8cNnZkKau4C6E+YnpRJf3CGmtKZQ0dBfhww=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 19:41:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10291608667741570973
Message-ID: <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
Date: Thu, 30 Oct 2025 19:41:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MmGwrenOE7FGs/rAUmOa2nkG4+s0TV4xml3w6J0CRi7e5DdnD4qXg2ZH
	6N+TEiz939magCHvZyvrwZuVSoCByVm6hVRo4UsbNG8x100kNzSJRbU3euLMWQMprL/WjOg
	t0mdG5gQa57BfZni7gdxZmUp4O+dRIH6yzeZoHhAZYQwriC2Cns6nvd7beyr77kzlLAdUB9
	7bcYe7OSyDayyz0lMCqqZZkxx/MTP2R+O11TY+WepY8EIMycEHWEm029jms15YgbgUXJ0M/
	Wv/2dDhdoNw/z76Tnggn/jU3wE5b0EH6QQpDCaVjuxRRmCCN98UrtCRShQfkHruvLQVEoyD
	XjQy1H02aENA8j4fhRPHtJcjjyBG5oonvNMa4w3LwugHogboqdTb1MD8FAI5USm6jTiUOnn
	uhC73Lmsvqa8mSG9NlYOcQt86uWNvwfxw7IKb1wmPJ/LYmZALxPtEcLjV4PFGcMXH5cm5RJ
	tarRCdxzoMxqLhMDVCvQitK/dFI7xVrfnZyMnOA66nE0H7S0WarwhF6jXTn1CY1FeIrHZpz
	e9yVoKwWn3Zslizvri5y/O5yf34XpFl9PEkoYlsudpOl4DSmtEgQ9YaSgkBOa0JMTnJxOiA
	tH4tPEMbH1qIbnDDknuRiu8jGvNxUeeusC9SPyIoVgBUoNxHmGcaOMRhzBmF0qBn8EPgWHz
	ktveVZDV8ozE1mUq4WOaNIoqHn6x8NMZdAedR5D7d1kK3WqMy302IfUXMOsMZSKe7mBENYr
	2JcqyXHIDQjyq1D0Gc7mMjClpIJlD/tqKL7ndV8FxmBlwCgBrTONe+ej3W93v/9LAV19Q3t
	SPTYD5r/SbqcPf5xH09X4VR6z3r3M2b+CPbVkg1H+kz/IGdmY/FFRhrdn1TIg5a8ahdFLbE
	WnCI5I913qesJhtwYJwzQmzHh9eD+LdMCD2JZYBxBbF/DfMirickCDcPq3VLpDV2EdYAZR3
	ArRI+w+6WmeXACWv0EXAofrbCN84X7gycjgRDLQHqYYyF9L1B1eSwMsffXw0P8CxkLnkqPY
	q7Cm0YVi2Zbpb1eMRC
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0


在 2025/10/30 17:42, Baoquan He 写道:
> On 10/30/25 at 03:33pm, Qiang Ma wrote:
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>
>> Especially in the RISC-V architecture, kexec_image_info() has been
>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>> message if required")). As a result, when using '-d' for the kexec_load
>> interface, print nothing in the kernel space. This might be helpful for
>> verifying the accuracy of the data passed to the kernel. Therefore, refer to
>> this commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required"), debug print information has been added.
> kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
> doesn't work when you unset CONFIG_KEXEC_FILE.

Yes, I just actually tested it and it really doesn't work when unset 
CONFIG_KEXEC_FILE.

In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.

>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   kernel/kexec.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index 28008e3d462e..02845a7499e9 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>>   	for (i = 0; i < nr_segments; i++) {
>> +		struct kexec_segment *ksegment;
>> +
>> +		ksegment = &image->segment[i];
>> +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>> +			      ksegment->memsz);
>> +
>>   		ret = kimage_load_segment(image, i);
>>   		if (ret)
>>   			goto out;
>> @@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>> +		      image->type, image->start, image->head, flags);
>> +
>>   	/* Install the new kernel and uninstall the old */
>>   	image = xchg(dest_image, image);
>>   
>> -- 
>> 2.20.1
>>
>>
>

