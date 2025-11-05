Return-Path: <linux-kernel+bounces-886010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A2C347FF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883E218C2AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311632D640A;
	Wed,  5 Nov 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FQRhGkce"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37527456
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331768; cv=none; b=eYJYF98NKxr+MH3luHWKlWpnxMG1x5ELOgeOF9qmBPlZv9Hz9yqCPo8Wn32StF1OIPoo/Ubl1LbyERgW1Acfg/oAzp18RHQrwU2LEgukvQcx+m/E1XGcXY/Pav/wgI1AAkS3k1SJbfVtFg85tlCgn3jpvwwjDezMLBSzoE26rtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331768; c=relaxed/simple;
	bh=8cFFZXWoPUg3sDNOnvcjywuRX506c8C+ddB0c09Sxg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COHVK8c2Opty8NBh88UgSXU7sD/FvyGoTEXDaL00dBkgmcPHRgr5Qlfy3k5yvaqXGEESJMcUarzdh13YleuSyk3eBoixWgQCbrQnaxkEIi+u7hoRQGTrNjh6kqg4K715eiZKSZ1LjJrgLxSJOeLbb9KahwnaYy5336BqIA1WE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FQRhGkce; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762331715;
	bh=m94Y9ksYzXZE8YFJSwrsPQvfUvPT0Tz82Kff+yJ1W00=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FQRhGkceqqejbWPFnW45OpQSff5eMIAJR4WQaLt27gwfuOu3UwKeBtvzz+lEioI+O
	 PA7vLw70cABqST9yXnVE9WJbM+vAY9lO9OAB0MIj1kzPEyVPhVht09pSms1huK1JNN
	 ePpxdLwb9qeZuUHz0I0Db3msjBuaM5LID6WpqAKs=
X-QQ-mid: esmtpsz19t1762331708t0cbb7d10
X-QQ-Originating-IP: G8e3WuK17XzdpqgepQT24jVV2AENCWij/pG7ME9hL0c=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 16:35:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14213868428083016331
Message-ID: <2331A9F3E09581FC+4ab7e9ba-8776-47d2-868f-cb01ca9cd909@uniontech.com>
Date: Wed, 5 Nov 2025 16:35:06 +0800
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
X-QQ-XMAILINFO: MIYVF5Pddf3w+vFOMso6kcPHiW3IfNLAGURKfFmgHJLTrwo7tOEqEBOo
	hKLoztrr2Sd9dgnAAotNXu0Iziw/mX/HSCAJG2TfdtlzyFpDvOrI+hWnpPROgotSZNdtdvz
	QvlWFBoMElvBZmBXFYASl7oVLdCekD8+QRSTUdOM9+D7xDBRBXiE4zRv/fOzjmJINxSiLV0
	ICvtFypl2Wmk98I9Mn4IqRqjxOUqqDHumGF/YD4mGmN/x3OdgzaCgEAtTvi3e3/ZdYkZn9N
	gPdzMEY0b/t8Y997tQNDEC3VB7ZlL+hm9pFXPqi/R0uDlIVM9P6K+oDHckNkd+4Ib99Vp+g
	ByKXaTJk9AHncd6eTZNm2NMGTVjvRttYTitDo1bf1Rs4FL9ih6kir9Js5LpOyBYPFyxCAdz
	yMhUTNqUx7sODDtGOTKd2WNmWrSkZPm/1BV7/QIAo+3t/8b8/iNRz6Y1mOmXKVdskupz58j
	9sZtbGFoTLxA67ondG/EAmPxdrX32wAb4AMOwl+0IHJh9KKhPnBU+vfh+hzwjLp3aVp1KMC
	t3bfiS6V3uh3oAX+hBFjz56bOCCzW2mXIb7mm47O6/XfuM+csCbktJ6RTOcJ2c6yefXWwWO
	vEH8mtgTyeAoDW19SVhFqMY6uLpEJe3WQAC5PSMZr4b+WwN/zWTvhV9KgO/PjXwNG2HrXXN
	rHvdMI6OAAdm93x8sFhOYazTnJHPvbQxq0MGwocwewDj80U0QOsf2VreI8de1u1c1+7aD+N
	Hfw+r6X/W8uxKfoIV1NpOrlEqJ/sZ4dTM0MvqkWDefSCz/m96IrWc3wY6U5vxtYEyDlrwBA
	JHNdaG2Wb16JyKqJCT3OQJANXk11qa/5rXUX5Ut0BQbd2VCyIaXMukotHrd1GKPxXMTUEGX
	s6jAZbKUxMje7B7NjudSsGhoT0w6uipSVrx6QcKceCVOdxPBwTJdMCx5RMcMW4wBpYGdqHu
	BFaOLaG+yODek0fPxoyy8vhiHUW6VYJBDLqxqsGR2Msop2vvnGpoIg2ytVU6lp2B79QaFP7
	amUyy17CgMbq9eT0LCqsHv4w9tYOenPeP751gGO2/Xyys/Qz9e
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
It's not entirely because of it.

Another reason is that for RISC-V, for kexec_file_load interface,
kexec_image_info() was deleted at that time because the content
has been printed out in generic code.

However, these contents were not printed in kexec_load because
kexec_image_info was deleted. So now it has been added.
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

