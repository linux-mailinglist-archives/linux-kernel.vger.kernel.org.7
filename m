Return-Path: <linux-kernel+bounces-886370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA0C355CD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26AB54F4062
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865930FC2F;
	Wed,  5 Nov 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Av25oNfq"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A73093C8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342158; cv=none; b=k4bePQl9VucexeP8cVZeCeWT8ZX+dCZUexTT531bnhkD8aevRasJ3uuS6deygfAHjbuPbwHVF9yivHoc6XUdQXJwBVPsdqus0hhcCDdtYKfKg2AkpGu2CRxWL9rFg8LxeXMUo+AIX0qhnj7C6sdmX9Y41zrHM7y60Xxr3Mcc6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342158; c=relaxed/simple;
	bh=fg3C1fZFPscvJBIdckQPGevu/B8lJVryGbWStiTmRTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9aeRgYiw/UaqqZs8I+G2jplz3OR9omtXYZK2juM1++4zEscLbqI49eM8IViDk2QfyWEwmpH7cmMeHRc7/iJvIKd+OWLjxUWwoPXpBbuVbq0a0EkXkBovPxuwbtBC6+P0/cBq0peyBqG9XzXYKMIFfuNv4rFyuA1k25HGOwBLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Av25oNfq; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762342103;
	bh=ZDvPw/1sN+jc6bFAS8ZMd0e9pfa4L70BBOJgXxSfy7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Av25oNfqRuHIhKGE6eU2DAT8zz+oNltqWmBJy6BKs6QR8EY2Z+hbnh+qbSPQAlS9e
	 t7FsFzcmO0Yl7uTzaz+oe/7/UAe3H4xAhl90CILZ1GZZSuq1z5YGxyfgXj1twRNZqP
	 dadVYBjg7RUBxivzjBuDvzwpTlZmTeI9DTkdrW8w=
X-QQ-mid: esmtpsz11t1762342092t1d16f31f
X-QQ-Originating-IP: rZqMpThW8VnerQMch6zes0SzhKdSSjKZaIfXyMEz0LE=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 19:28:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12946816230818078420
Message-ID: <44308A6B6D8BEB61+c143d52e-03dd-48bf-aadd-8a0d9196b280@uniontech.com>
Date: Wed, 5 Nov 2025 19:28:10 +0800
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
 <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
 <aQsCaeTx0WduSjSz@MiWiFi-R3L-srv>
 <2331A9F3E09581FC+4ab7e9ba-8776-47d2-868f-cb01ca9cd909@uniontech.com>
 <aQsRADZ+pPho9pYa@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQsRADZ+pPho9pYa@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MjgZ33YqMcnTptgwu/qeIA7BdCucDn583eEXuO37YJhfng++KrljOtWN
	0omZ3r+uBKY1pA+oZmC3eiPIuzKgftOSIC/iZ3fka49cRuKs7PgQAt2Wk87CJJEXYy+xPR/
	1Us4Xv5++/wRzb4lkZ1AyM9Ef4pUxi09B3qtrrIMjVjcOOlKpEf+eCxhZ8BGRW9NjsG4P1p
	cQGnFuGzpnSH77KtYPfepWcHjOEGWKpoEW1xIjQtyBhpMM6Zrf/g28oAEfSi8+h7Buf8k9s
	MO2QZ0YB0ELbaIHxhBl/jjk9k0+fjvyP5MvVvMe23W89TAytncin1C7z2/T3lMs0tk0tw0y
	mpRFGo73I1nlep8vEumGfZYj4B3vNTjqtJwt+uvhHRDf1Dm3w7kE9LY8fo80D8R5cHKRIrU
	A3kc1xE+do2/Kr14rfOvno+FA2qID5+cUF6IxfBW7TRchw7Oq4THQ47Ace6StDDkGHE/Hev
	hLBdO29j0AyNWrDwJz0hol3FloZOAZ07Nu0CmFGSpK5+wy+16/HsxbL2s31M91dFyr3B0+g
	b25LMsGhLNUfN/yZwHyk13MhpsMYVKuXYzOtL6Mz6XG/kUwyJ+otjnilhAeYijgHOrJJS3G
	vEX7YcUNFMmHIMccixUr+xdkLxll3Mm0i0eYa9/aJl1KiTuLvxpA5krndVw3ivXxvBia+iV
	WmkF+VG1W/bBQFuxTwwEn402xvzGLJS93rCuHENzenlFQmYf4v01OyrnVzbWph+2k0tqx/R
	RnjutWwTT7vUvHIA1VTdoj2u3DD8mSe+ndwou21phb1NBwj+4gw+yrTF93m9WrSQ5xY9911
	fUi9lzjv1vW0gUXBqBar7Z95/9h3VTPtmNK11G7J1K9kWE/wbDjNh9fjarb14jq8h5kaRoK
	ZG7EW8LedZehDH9GA/Ru4zpNy8fod2jyi0EHatr6gxARPCvVm7VupqucqJRngtt4L/oyry5
	VJiH8zhSvDFbRETbVtVBy09oDfVGZ69hmcV9HS7jH/8jwuaZUp+U9yelnejgdFf4jaFHzBy
	bJWTF/9JsyvLDu1neqx0SyfBYniuZqmgmDr7Hr2ZxYBOva5RZeP0ensLi9XUkgqhXEtcdff
	T94Ee5b1sQahOYfu45sWgw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0


在 2025/11/5 16:55, Baoquan He 写道:
> On 11/05/25 at 04:35pm, Qiang Ma wrote:
>> 在 2025/11/5 15:53, Baoquan He 写道:
>>> On 11/05/25 at 11:41am, Qiang Ma wrote:
>>>> 在 2025/11/5 11:01, Baoquan He 写道:
>>>>> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>>>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>>>> if required") has added general code printing in kexec_file_load(),
>>>>>> but not in kexec_load().
>>>>>>
>>>>>> Especially in the RISC-V architecture, kexec_image_info() has been
>>>>>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>>>>>> message if required")). As a result, when using '-d' for the kexec_load
>>>>>> interface, print nothing in the kernel space. This might be helpful for
>>>>>> verifying the accuracy of the data passed to the kernel. Therefore,
>>>>>> refer to this commit a85ee18c7900 ("kexec_file: print out debugging
>>>>>> message if required"), debug print information has been added.
>>>>>>
>>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
>>>>>> ---
>>>>>>     kernel/kexec.c | 11 +++++++++++
>>>>>>     1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>>>> index c7a869d32f87..9b433b972cc1 100644
>>>>>> --- a/kernel/kexec.c
>>>>>> +++ b/kernel/kexec.c
>>>>>> @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>>>     	if (ret)
>>>>>>     		goto out;
>>>>>> +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
>>>>>>     	for (i = 0; i < nr_segments; i++) {
>>>>>> +		struct kexec_segment *ksegment;
>>>>>> +
>>>>>> +		ksegment = &image->segment[i];
>>>>>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>>>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>>>> +			      ksegment->memsz);
>>>>> There has already been a print_segments() in kexec-tools/kexec/kexec.c,
>>>>> you will get duplicated printing. That sounds not good. Have you tested
>>>>> this?
>>>> I have tested it, kexec-tools is the debug message printed
>>>> in user space, while kexec_dprintk is printed
>>>> in kernel space.
>>>>
>>>> This might be helpful for verifying the accuracy of
>>>> the data passed to the kernel.
>>> Hmm, that's not necessary with a debug printing to verify value passed
>>> in kernel. We should only add debug pringing when we need but lack it.
>>> I didn't check it carefully, if you add the debug printing only for
>>> verifying accuracy, that doesn't justify the code change.
>> It's not entirely because of it.
>>
>> Another reason is that for RISC-V, for kexec_file_load interface,
>> kexec_image_info() was deleted at that time because the content
>> has been printed out in generic code.
>>
>> However, these contents were not printed in kexec_load because
>> kexec_image_info was deleted. So now it has been added.
> print_segments() in kexec-tools/kexec/kexec.c is a generic function,
> shouldn't you make it called in kexec-tools for risc-v? I am confused by
> the purpose of this patchset.
There is a problem with what I expressed.
I don't want to add print_segments to riscv.
I want to add some debugging message(ksegment,kimage,flag) for kexec_load.

Although ksegment debugging message has been printed in kexec-tools,
it is still helpful for debugging the kernel space function.
>
>>>>>> +
>>>>>>     		ret = kimage_load_segment(image, i);
>>>>>>     		if (ret)
>>>>>>     			goto out;
>>>>>> @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>>>     	if (ret)
>>>>>>     		goto out;
>>>>>> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>>>>>> +		      image->type, image->start, image->head, flags);
>>>>>> +
>>>>>>     	/* Install the new kernel and uninstall the old */
>>>>>>     	image = xchg(dest_image, image);
>>>>>> -- 
>>>>>> 2.20.1
>>>>>>
>

