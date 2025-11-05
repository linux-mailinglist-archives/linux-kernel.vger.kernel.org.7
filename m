Return-Path: <linux-kernel+bounces-886053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDABC3498B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5924E18C8690
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166752E92D6;
	Wed,  5 Nov 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LAEhZPW0"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E332DCC1F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332602; cv=none; b=m4HeDr8P2chO2P6DAUWkimpW43DVoESVIW3sJJxlKADa0tbey5Pot/G80h043hsOrzamnF2zeH5pZNmnZIfUEsvVWR83Ow/zvsHjiAJysiO4v3GQoR//m8YoR0kjP3jGa9M74b/BiQM0dnkitC3AfdXFJB17BiK7BGagad4GTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332602; c=relaxed/simple;
	bh=KYMSEi+x4Ph9Mf4/Xmg12soIZ8Q3aLVOaRJoVNCiTRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFWJDQTRsTrdYa3rh70y+AnR6D7udOFIN2b813X4xzrIJPuD9Mgz1xPWs/62n7N+SYiGruMKOmIkLmfwRhYjJYSFK59NwoS2UoUaj4uCOfb6sQHwp/gWymY8PUsMKjMFxf3PGNRUhDlz1+rKE3C2Q+P//YmN8qVrm7z06gdJ9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LAEhZPW0; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762332548;
	bh=iVqrq56E8a6It2LUC2VqfE5x0rebyt4RKFqZqMTt6mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LAEhZPW06us6lDV7UBrPRxfvKo3WTPEcWwxS+5gDesSoH+dfyw1dlQRMJmcwZ2xTs
	 vUuv0PhIE3PlKJwoFR7B7uSiLcdCsYJRtKJkpzP+nipdNBpZ20EsWCEkU9dKk4v5XN
	 ygUW17QRs8I9YhnPxulatVr/6muu+NiqsdJjQsh0=
X-QQ-mid: esmtpsz19t1762332541t9d3718e3
X-QQ-Originating-IP: iCgHtChRiGkfZ8y9WrLswYcW/+GR3Gf9Qpjbjb0GJSs=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 16:48:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6779642171559248315
Message-ID: <02A386F1B9701FED+a0b3ab16-3f23-4d69-9fb8-ab4d9f918bad@uniontech.com>
Date: Wed, 5 Nov 2025 16:48:59 +0800
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
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQsCaeTx0WduSjSz@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NV9lVvsB36OpBKK/tj+EHuOzyE/Uuh845ZW55yELg9bvMvgvjTCuSlyX
	TDNMsToGBRRO0DeLcxLKYWGkKPsB3Tbe27N4P60FK9ih5XxPQl25lVlgxuodFovCXZm+UzU
	gK6WPzri28ncTi7Q8RGP1D890tmx6uoTQd4mPHffikjtxU/s/UctCNwa8wloxIw+enFdIXI
	KYkLcsMV48ocpXNKdluKzA2za0QtK186SJCJzxHY4JFJlHTA+hvPhsKtYSD1b/RNJuwLdZd
	Ia23lRPKhnOm47++mytKBdsPEsry4+AvfGyrpNmvp2PVGKEYF+vmH0sjDOpyhozv7Tlo67o
	4ISqmwB6CQPZayZ8eJbZOV+iJGtaI80X851me9bRafJFJrSrHbaVxC5u2xuX3nVwkHr0tKr
	S9y04EtVSJuOtHtrK3rxRtwYEZHmDA9qWxFBjFm8XJfdd8RzhP7nn84jsiglXotITD87r4c
	R/x/0XqmntM/W0tSK8m9TPI7C0dESNdJiq0n9vHU5FSWn08KUTOTRSjTdhUa34oQ93IAw6P
	kaoKvZueGz/+8Z575nbMvgQcTE4PRjiWDTOLPyYedUe0Qx7ythUVSKZY/kofKD72/HADRy2
	ooV1PDxxXseZugdns1PMIQWx804itegii7m/9ax+IMiU7a4N8xu7Ggt78Ty7VKVl3rHHwcZ
	ZIMqyxXxnAUyNH9zpGk11JvAgaj026IVerOKHIkPeY/rQOllENscaGRsv2TRYan4aRQilPz
	LsrEVWrHTGKl4oeZDmGBL8ErIdMuMbh89px6xY0SPyYe3UuVGs5ZHAVGWzsSZsw35ZGh84A
	5RwC99tAV555I0AugulAa3/pefcyRIBoC0xIqMRTri9QZhmnZeJMjYZAs0nDEIrLMwtvzIe
	V8hoRzHWSSaIfRK33GD+pEla7/mWejGzens10Gwrb6hs5CQjaPcmXar+z2ZlWYAWHKIrev5
	4i6061nls3xzrgmLKCD3kW02/BVVCaybyCn2Mj1RvFT34PvAEwTW+HyOBSFDNRkp9/YDpAp
	G1VKr8q/ybduwko/Ai5ybJR7EW8mIyQcS8zEtn8G3s2jqSsCy79sCL5hb441Lwqva9sIE9i
	5T2KqCQWZqW
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0


在 2025/11/5 15:53, Baoquan He 写道:
> On 11/05/25 at 11:41am, Qiang Ma wrote:
>> 在 2025/11/5 11:01, Baoquan He 写道:
>>> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>> if required") has added general code printing in kexec_file_load(),
>>>> but not in kexec_load().
>>>>
>>>> Especially in the RISC-V architecture, kexec_image_info() has been
>>>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>>>> message if required")). As a result, when using '-d' for the kexec_load
>>>> interface, print nothing in the kernel space. This might be helpful for
>>>> verifying the accuracy of the data passed to the kernel. Therefore,
>>>> refer to this commit a85ee18c7900 ("kexec_file: print out debugging
>>>> message if required"), debug print information has been added.
>>>>
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
>>>> ---
>>>>    kernel/kexec.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>> index c7a869d32f87..9b433b972cc1 100644
>>>> --- a/kernel/kexec.c
>>>> +++ b/kernel/kexec.c
>>>> @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	if (ret)
>>>>    		goto out;
>>>> +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
>>>>    	for (i = 0; i < nr_segments; i++) {
>>>> +		struct kexec_segment *ksegment;
>>>> +
>>>> +		ksegment = &image->segment[i];
>>>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>> +			      ksegment->memsz);
>>> There has already been a print_segments() in kexec-tools/kexec/kexec.c,
>>> you will get duplicated printing. That sounds not good. Have you tested
>>> this?
>> I have tested it, kexec-tools is the debug message printed
>> in user space, while kexec_dprintk is printed
>> in kernel space.
>>
>> This might be helpful for verifying the accuracy of
>> the data passed to the kernel.
> Hmm, that's not necessary with a debug printing to verify value passed
> in kernel. We should only add debug pringing when we need but lack it.
> I didn't check it carefully, if you add the debug printing only for
> verifying accuracy, that doesn't justify the code change.
>
Also, adding these prints here is helpful for debugging the 
kimage_load_segment().
>>>> +
>>>>    		ret = kimage_load_segment(image, i);
>>>>    		if (ret)
>>>>    			goto out;
>>>> @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	if (ret)
>>>>    		goto out;
>>>> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>>>> +		      image->type, image->start, image->head, flags);
>>>> +
>>>>    	/* Install the new kernel and uninstall the old */
>>>>    	image = xchg(dest_image, image);
>>>> -- 
>>>> 2.20.1
>>>>
>


