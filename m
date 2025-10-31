Return-Path: <linux-kernel+bounces-879409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4077BC230A8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FAB3BD4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA03081A3;
	Fri, 31 Oct 2025 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IqD/KbRS"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C311306D47
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878463; cv=none; b=ZO6azCaAezMyLdzQLsvs9XcCOX7n3AefwvlfGdGtKxjb6pWqpaJ2MUemsjwbgZdtu6DIO67xiRe9KgXl0/gpPhiadHZGBTX6sPZv2LdYRpOnhD4zg9+k5yyggLa2oRmHeULjqYFUwqsr7GFhBdxOfy5PqRT7lpfPlPa2dnAJQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878463; c=relaxed/simple;
	bh=tkoQATJLDbE5tHjebibo6j+1qG16aQZbtymL7p3lCZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoBcNvKs9kx4lLg7YEA110kcdSN6Frkp9DSExRKnBvi7E1yHXUloyZRVju57Wftm1yc5WIdBzrL2dQJ/uDCeZcw3wr+ANYsZVZ6/koXDz7OY+3HaN6wmliJDfXvQFcxcFsJ/PwuFD1C7aih2Ds4QCFBY6ZBCaeguygJ0aj8DV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IqD/KbRS; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761878411;
	bh=l4/lEo+iFPcejD1HYzXXHmJ4Wq2MvRqAfEXFOQWInZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IqD/KbRSO0wd1FlEP8dj4zGpyouFW1LhXqtO5p145K1GfBPWOf3AhZ6HH4CYUdRSN
	 i79WfmbSnXG8BPGJBWQ8hDajrLDqmzkBBvRiCKJma9uwKqR4Qi1IANccaQdTZr0q1/
	 FqnRbnBDI43fDi998HIxJGIsZ2FK8v8JdPbFzkCE=
X-QQ-mid: zesmtpsz9t1761878408t66b41fc2
X-QQ-Originating-IP: aN5SbCMpn4nq2ydWUTEjzwYfahQbWdRio1m+8vmqXrk=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 10:40:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6865774659081570964
Message-ID: <9362A6495165FCC0+d659800e-6751-4d26-a8b8-183705798e96@uniontech.com>
Date: Fri, 31 Oct 2025 10:40:07 +0800
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
 <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
 <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MShfLn39PbN2mOtH9g2M/3s94fDr9DbJUoSZlrIp2Hq+eSD77Us+HnjJ
	E97E0+LsZlQLxsg7hg7thfDTyek6gq3Rh5pEIwtjdj0s3Cgeuem5EOUebgV4robtEQWo415
	OkYwLfnUd4H1Qfbtn4+68NtlDVsPOSn7aLRRB4t5Bax8udO2S/MVHbI0PqVF5tvFPI4d44z
	WKb1WNMMNWwwsZQ3Mb7f6CwUN1K9eTJAMBpGjRL8Ex2XqUaiafsxZn90ygfmEX3Hf0r+cns
	bS4z+HZNdmSSuneHDmr9bjjrGShWYNL0QwJ1Oi+BKpy/+fMhvu0sARXo34wsvglB35/SQTl
	6+a2itCS72n5/v2BAUM2r9JwyvDfiMbcohO2aqvAg8kmRkIIQpZ5jwxRPjSEcHml0uFr11m
	eN9zfcrAfyTCVlnmWaXA6r8EiGtuFDrvPbyRlanvy9K+EZj0E+eP9mGWW+j0i1hHe7a5EPy
	TztkbGJ9VESGhG9XGTh0mXgnkrhAZ7kScvRdpic3B1TObM5MAcu1qU3YlaEtHDJIT9EsFE/
	Dg/MapYZ5oBkysv/0qBNEivesSv32dF52AKLHuXRWiGrCbCLzFrATUqdTBTr88Ynzek75Z+
	aweTdbvgg9g1YFjuYLNQAVt01LH8vtX/iRVGO9JB02gGNQGXtz6lR6zfJABC/ubYc6/xFed
	Vl01RvwSU0sj5/DUDUq4hx/Y1d6KVA9GtdpEHEtxY6OrK2q5bT6BuLksO4hSQVEYOiQoTEn
	3Oy3uHLPbnbAP5VZTtVzLq1q2NSTiYUejbiF1WjFqCotf4Ev3Jp/N5GnRCHRmxERmyJg99o
	Wr+Wpt+7ZyUbQAuHKA4G34JGa1L6iif/BtpTZBo2BjMqzR8fQZbS03g9MTRigpNoOfH6qev
	F1nNTqOVW4bp7V29F6ooDiJs23q3d2+TmwW9KdHm2vRy4UwiJm5byn8PzYt7oi8uIY2krC6
	XAv8HdpH8ivFgDoxqj1GygwfDfe7UwPN2Fp2WUDGWp+pGpAQ2cDeCbiWu8dOlLJGyhoo/vB
	lP6muhXCiQsvjH5TGpBX9i/cntOhY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0


在 2025/10/30 21:58, Baoquan He 写道:
> On 10/30/25 at 07:41pm, Qiang Ma wrote:
>> 在 2025/10/30 17:42, Baoquan He 写道:
>>> On 10/30/25 at 03:33pm, Qiang Ma wrote:
>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>> if required") has added general code printing in kexec_file_load(),
>>>> but not in kexec_load().
>>>>
>>>> Especially in the RISC-V architecture, kexec_image_info() has been
>>>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>>>> message if required")). As a result, when using '-d' for the kexec_load
>>>> interface, print nothing in the kernel space. This might be helpful for
>>>> verifying the accuracy of the data passed to the kernel. Therefore, refer to
>>>> this commit a85ee18c7900 ("kexec_file: print out debugging message
>>>> if required"), debug print information has been added.
>>> kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
>>> doesn't work when you unset CONFIG_KEXEC_FILE.
>> Yes, I just actually tested it and it really doesn't work when unset
>> CONFIG_KEXEC_FILE.
>>
>> In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.
> Hold on please, it may not need that highweight change. I will reply to
> you tomorrow if I have other idea.
Ok. My current idea is to refer to kexec_file, define a kexec_dbg_print,
initialize it in the kimage_alloc_init(), modify KEXEC_FLAGS and 
kexec_dprintk,
and add the judgment of kexec_debug.
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> ---
>>>>    kernel/kexec.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>> index 28008e3d462e..02845a7499e9 100644
>>>> --- a/kernel/kexec.c
>>>> +++ b/kernel/kexec.c
>>>> @@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	if (ret)
>>>>    		goto out;
>>>> +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>>>>    	for (i = 0; i < nr_segments; i++) {
>>>> +		struct kexec_segment *ksegment;
>>>> +
>>>> +		ksegment = &image->segment[i];
>>>> +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>> +			      ksegment->memsz);
>>>> +
>>>>    		ret = kimage_load_segment(image, i);
>>>>    		if (ret)
>>>>    			goto out;
>>>> @@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	if (ret)
>>>>    		goto out;
>>>> +	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>>>> +		      image->type, image->start, image->head, flags);
>>>> +
>>>>    	/* Install the new kernel and uninstall the old */
>>>>    	image = xchg(dest_image, image);
>>>> -- 
>>>> 2.20.1
>>>>
>>>>
>

