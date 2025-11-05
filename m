Return-Path: <linux-kernel+bounces-886672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 368CAC363B1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0E4F337B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F0315D48;
	Wed,  5 Nov 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JkLSaKfc"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B432E14C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355175; cv=none; b=aL2iLdzzwZw5n0j1w/vLKjaMYSYW7M80SIxX4GPywTWdI3UIB65BKBpNJmADkY8NvJOYudGjWJ6jkizliO4m9BF2zl8doCPV2257lmHn0GLDuCqaMHOcFrEy9lh86cR7EB1Ee/h83DZveynL513iCdywv5KfavbcAUS6Pm0t5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355175; c=relaxed/simple;
	bh=3CcvkYLksqUpZkjKNlV5EoYuMTc1RYxQAEVVHqD+jU8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WLvZLyhkcphbC0cXXHaDyReMo6acnKJCD6tY/GGT79kePy8Sk6a/AEd4pem9xbvWoFtr0LKkfQLMPCYkSRwWevnqC8ZkVqjgixTzyNyqyZLAEDm3+qcG5v0ukNSPZDcEODlFCsAcuYjpy3B8WEemktzSnaltJfMxa61/IWsg9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JkLSaKfc; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762355112;
	bh=A+ChnVt+FBJp4iytGmAJheIuFypppdt2s3zywMDMXYM=;
	h=Subject:To:From:Message-ID:Date:MIME-Version;
	b=JkLSaKfcXWtK5dH3yYQawOU1nQ/xOjkaWF2U8LGacFK0LzFFT3HY6xEWER/dXjbGx
	 tVael6dFVyTV+aBDPoDQkaaAIOqdTlNUQllgXfMCXlbrfGdrOdBkXArsOdCjDwH9ZK
	 6RL8LQTshJDmjf3oW9dGJgNwlY0gwCCLXmGsra0Y=
X-QQ-mid: zesmtpip2t1762355105t1dc560dc
X-QQ-Originating-IP: uLk8JsAEsmzInxV4x73oTWX7tUmvk6eBLTptYDLaM5w=
Received: from [IPv6:2409:8900:8683:1129:8a90: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 23:05:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4721291873598464723
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
 <44308A6B6D8BEB61+c143d52e-03dd-48bf-aadd-8a0d9196b280@uniontech.com>
 <aQtKmP1W+k2+Gjdq@MiWiFi-R3L-srv>
From: Qiang Ma <maqianga@uniontech.com>
Message-ID: <1E51DC0D8C72320F+8ad85e3e-1f03-4ca9-ba29-f2ff8a4cb831@uniontech.com>
Date: Wed, 5 Nov 2025 23:05:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aQtKmP1W+k2+Gjdq@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M0mNcQTrro1WmpLn6mrucPL6KieEWv0cnLvbUp67Up68cap7GnOhRUQ/
	Tb1a29tZOwyCbMmMGiA+KmGR/Slx7LYfF8a1701na6gIvghr3MBgZVptSXCHlkjL3jWfRa2
	AprMBd5bxK2oST+32Wq9qfIOwP//oIWozp/CB+5tbR351ydv0Cv22gjmdq5hEAd9tOw/d6e
	oM7+mYbSu3Dy4cz/Z3wIz7Hscbbkr+tzQd4AL9Y/Xp8n4qSYuCiBttCLNsDHxSpIAMGp1G1
	7kJ0hK2m2XE7RV1up5PKbkqI0d+PnBJbXSInCzi5ssJvzKk5fe2wkRSkn0+PLbJpEDM1/FM
	GX3XFJdIKbrLO0uegP/V+6rwmlswv7lyquDhpJGOUPXLQKhB7in0DBq68vQnKiTsasx0Gx6
	JhpDENMYPB0RrQRoQV4zlpyIIa/QqADKhN2gigGiPybu3vAbnF8BEBNbxX+BXjrzfpocR/e
	QgPW363MUWikdUzip9Blqjicxq899UM3WRv1/XVntiorTf8lCODly+C61GjHuAXwo0UIdmI
	l8rdoIRtMbrBUXwdCSJZUUUVv/pjLj/5muDhZBWuXmdBoVJiw65Cai84y7kkf5oGIwCAiSv
	D65OvflhB/aCWdTiapWUJLO2aq5TazYlBHNTN4PLyWEwaygTfnmfkT7kWTwq84Ps4boLBEp
	6g3DLuEaqDq6+fAGa8su9c4vQ1geadfhlu19bqy4jGUlv6I5A969ou9o0cUWIsOWnX2ZLTF
	FcVPCsKKten3kfC6VfZO4U/fTsrqNs8JzU6l+TuJvf88qtdEcv0fU6Xsu08YnlHifitByEr
	Z44nRYbUzWlL419SubyL3P7Yg5D0R0OSmdLCDkj2jn95v2dcHtV7pNpRM73XpcLlyGY3yLu
	cGiybkL6e9Tj4M+E2WsrUBw8WXyCBEqPE3Q63sv+RgD2zhaP4+FMV99FWL+YrOwcd3s3lwL
	D8PDADqJqXuEcyccBEhAZzVrmhmbYXI+y68avl81LXE2DkFk6xFwl2m7LQ0ORoO00bDbPn2
	sGeQcbFinjUNj5JAhTAXC78NFWYa1tuluIS9l4a1Kgv6ODKRMBRPDVXa5BdSxjGeoFHXU1h
	t19EwSyJBs6kVBOxk0CCx80GvzoXQ7dAMvkClmqQ7vz
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0


On 2025/11/5 下午9:01, Baoquan He wrote:
> On 11/05/25 at 07:28pm, Qiang Ma wrote:
>> 在 2025/11/5 16:55, Baoquan He 写道:
>>> On 11/05/25 at 04:35pm, Qiang Ma wrote:
>>>> 在 2025/11/5 15:53, Baoquan He 写道:
>>>>> On 11/05/25 at 11:41am, Qiang Ma wrote:
>>>>>> 在 2025/11/5 11:01, Baoquan He 写道:
>>>>>>> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>>>>>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>>>>>> if required") has added general code printing in kexec_file_load(),
>>>>>>>> but not in kexec_load().
>>>>>>>>
>>>>>>>> Especially in the RISC-V architecture, kexec_image_info() has been
>>>>>>>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>>>>>>>> message if required")). As a result, when using '-d' for the kexec_load
>>>>>>>> interface, print nothing in the kernel space. This might be helpful for
>>>>>>>> verifying the accuracy of the data passed to the kernel. Therefore,
>>>>>>>> refer to this commit a85ee18c7900 ("kexec_file: print out debugging
>>>>>>>> message if required"), debug print information has been added.
>>>>>>>>
>>>>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
>>>>>>>> ---
>>>>>>>>      kernel/kexec.c | 11 +++++++++++
>>>>>>>>      1 file changed, 11 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>>>>>> index c7a869d32f87..9b433b972cc1 100644
>>>>>>>> --- a/kernel/kexec.c
>>>>>>>> +++ b/kernel/kexec.c
>>>>>>>> @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>>>>>      	if (ret)
>>>>>>>>      		goto out;
>>>>>>>> +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
>>>>>>>>      	for (i = 0; i < nr_segments; i++) {
>>>>>>>> +		struct kexec_segment *ksegment;
>>>>>>>> +
>>>>>>>> +		ksegment = &image->segment[i];
>>>>>>>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>>>>>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>>>>>> +			      ksegment->memsz);
>>>>>>> There has already been a print_segments() in kexec-tools/kexec/kexec.c,
>>>>>>> you will get duplicated printing. That sounds not good. Have you tested
>>>>>>> this?
>>>>>> I have tested it, kexec-tools is the debug message printed
>>>>>> in user space, while kexec_dprintk is printed
>>>>>> in kernel space.
>>>>>>
>>>>>> This might be helpful for verifying the accuracy of
>>>>>> the data passed to the kernel.
>>>>> Hmm, that's not necessary with a debug printing to verify value passed
>>>>> in kernel. We should only add debug pringing when we need but lack it.
>>>>> I didn't check it carefully, if you add the debug printing only for
>>>>> verifying accuracy, that doesn't justify the code change.
>>>> It's not entirely because of it.
>>>>
>>>> Another reason is that for RISC-V, for kexec_file_load interface,
>>>> kexec_image_info() was deleted at that time because the content
>>>> has been printed out in generic code.
>>>>
>>>> However, these contents were not printed in kexec_load because
>>>> kexec_image_info was deleted. So now it has been added.
>>> print_segments() in kexec-tools/kexec/kexec.c is a generic function,
>>> shouldn't you make it called in kexec-tools for risc-v? I am confused by
>>> the purpose of this patchset.
>> There is a problem with what I expressed.
>> I don't want to add print_segments to riscv.
>> I want to add some debugging message(ksegment,kimage,flag) for kexec_load.
>>
>> Although ksegment debugging message has been printed in kexec-tools,
>> it is still helpful for debugging the kernel space function.
> Sorry, I can't support that. We all prepare the loading segments for the
> future jumping in kexec_tools if it's kexec_load interface. And calling
> print_segments() to print those loading information is natural. Why do we
> need print them two times for verifying if the printing is accuracy?
Is it necessary to verify the user-space data after it is passed to the 
kernel space?

> Could you explain why risc-v is special?
At first, when I saw that in the RISC-V architecture,
after kexec_image_info was removed from this commit eb7622d908a0
("kexec_file, riscv: print out debugging message if required"),
I thought only kexec_file_load was taken into consideration.
However, without considering that kexec_load would call
kexec_image_info to print segment and other debugging message,
I think that since it has been deleted.

Then, I referred to kexec_file_load and added these debugging message
to the general code of kexec_load. In this way, all architectures can
print these general debugging message.

Then I can add these debugging message to the general code,
so that all architectures can print these general debugging message.
>>>>>>>> +
>>>>>>>>      		ret = kimage_load_segment(image, i);
>>>>>>>>      		if (ret)
>>>>>>>>      			goto out;
>>>>>>>> @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>>>>>      	if (ret)
>>>>>>>>      		goto out;
>>>>>>>> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>>>>>>>> +		      image->type, image->start, image->head, flags);
>>>>>>>> +
>>>>>>>>      	/* Install the new kernel and uninstall the old */
>>>>>>>>      	image = xchg(dest_image, image);
>>>>>>>> -- 
>>>>>>>> 2.20.1
>>>>>>>>
>

