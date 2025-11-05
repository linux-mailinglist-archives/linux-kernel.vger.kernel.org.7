Return-Path: <linux-kernel+bounces-885891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1909C34286
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72F754EDD22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC42D0C79;
	Wed,  5 Nov 2025 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VYc0Njxe"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC742C324F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326469; cv=none; b=Y8TjG5FNmh9IzhfAEO4i+aVnxWUoyfclkIV7i/3XyZjiBMMy6Wti2quF7dqpA/QEMIovTA1X4zHZSiaxv0Rs/3WmXWISOOQWcZrodSUVsMJNPwys/ldqhK00x4BdcpGoQ/AeG67w9mSKMGD9CKhZ89xo5L/nOgN1SNQ4MhrEIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326469; c=relaxed/simple;
	bh=MheqkCJiK+IvFdFqNB2i2Zy0B9VOaxa8yHl3aYJYDIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+jsV6wriTnlKF5grqdbYbrI9rcs9zZatXPd23p8opVxxTmN4njMMgmXhaSJy7+RhINruNMDNW9Gek1gWob8K6eNzsDiXMcov+XufceuI9p6TY9FsxGOup+zCbfwzXui9grcRjsOWIbxQH07yc200YFlia1miPiZdEED5G8slwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VYc0Njxe; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762326413;
	bh=P/IEUU8bwmpdz3eEeNkRu3EBPrJTlvjCdOgyW7LQAoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VYc0Njxe9u6lbHZrlxDnvhtrs+EraGkeVszom7ShtHCi98MF8ok6nsHkz890uZuJu
	 bAWhBF6N+lIy+nw07YxEHj7MKiR5ZHSH0CU3IWlkuuQvjtHJmss1U85dcbMwxfvnUJ
	 bnp0WWlPjewXC5SU4BhrD0QWBtSSZEWcYUAwRRPo=
X-QQ-mid: esmtpgz16t1762326411t6bbd595a
X-QQ-Originating-IP: frkdY+kACG4+OT633H1PI1zyXz5wdWpQMA9xqgstCf8=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 15:06:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1361723058384456180
Message-ID: <DB8D55DA58E28E7A+e01fbd66-c45e-40f1-9d4e-44f18b04a716@uniontech.com>
Date: Wed, 5 Nov 2025 15:06:49 +0800
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
 <0C92443D3E2100AF+c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
 <aQr1K/+I91RhVGuo@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQr1K/+I91RhVGuo@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NBjdfkqVynM2oGVMqfIjVrxjjhWnOiLWnNnY3EB5BoBK/eUiJoz4qEn0
	SgJt8UsCHFqb2vpO34+eoJEGUjXVXINzL/J/JUEPoqfZiuPTli6EVqqS8+GmcM1REMrMbv9
	y605huBj+TL8Lg5/SlqUw98YjlSsuUrBMXATk/VQ2aEqHfwwn0LTf5tlQS3RYJb7WSHSsz+
	Z5U8/45XGDJ8w+NPM+vNqx9OfCTEXXQgT7GSTBrTC5+doloSo/R9MJpRKxO1E5i/x+6/Ht+
	bqP9LAd+JtDjw0cN/PisAJKBO4sv7VPTMVcsrB8k8Z1kT5vnW1ghoCck9RFJJZY4mpPtglf
	sp9g/sOFlLwILwRyIip51zGQFt8iiDA1GRbieA/ui+Q7s2oY/P+qriVby2bcPIzKSL+/9AB
	Yv2iR6DZa1vHhhQnlaeI161pcgyRx08TQOuZImfX2MQKfqy0MRX6eNNYnY2nnfhcb9QNZqf
	O0D2JZKYsApqkw9csknm8fzp8ggPENPl2EIds3dO0S4lqDUS71nPu/oouB63ORGIP3K3GKo
	7e3up7o0q4Ky2KEUhy3DK4awaLntwJapTh5azTqIGZDf7Nzz5s5avWkG5qhgbd8Oiu3zcJE
	bzwqjsuKp+1/TccbSfPBiRINdi6TJio728Q/Qe3PZd7kRijs/jVVPNeRzAM+0sjHMEykEwp
	2GoGj3bY2rop6RIuxt7J6Dj78yULP1ilbCAek/uTcb0gAwI7NTkGWLDu1Iq2S/3nk+Dp8xg
	cWU3SlPEF1MzhmWur9mP6n0yxaebTnNt89eCiOYQ8HPuk+c/Tkhi31+81hECvqicLOnL1RB
	lIbFCLqyiuWziUYsAbqdLRV7duXEg+RRWg5ZSPCNdCNHFN5vKuQkGZQ0R/NqmQW4TNNbr8c
	LVgmBsLbTFKvbmBvhdZC71p+TY0JgjtU1imdkB4ff0Dkv7uXANlSzbrmGe+8fNb9ZmP2Li2
	qVw0qYudnf6r46Ujd2D0bxxePPJxID6WWduTHhu2cAsQEB8MmFewCnPOZLuZg7H1aVec+K5
	tIuXllbc+ihF024vT7
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0


在 2025/11/5 14:56, Baoquan He 写道:
> On 11/05/25 at 11:47am, Qiang Ma wrote:
>> 在 2025/11/5 11:05, Baoquan He 写道:
>>> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>>>> The type of the struct kimage member variable nr_segments is unsigned long.
>>>> Correct the loop variable i and the print format specifier type.
>>> I can't see what's meaningful with this change. nr_segments is unsigned
>>> long, but it's the range 'i' will loop. If so, we need change all for
>>> loop of the int iterator.
>> If image->nr_segments is large enough, 'i' overflow causes an infinite loop.
> Please check kexec_add_buffer(), there's checking for the value which
> upper limit is restricted to 16.
>
>          if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
>                  return -EINVAL;
Oh, then this patch is really not necessary.
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> ---
>>>>    kernel/kexec_file.c | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index 4a24aadbad02..7afdaa0efc50 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>    	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
>>>>    			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>>>>    	struct kimage **dest_image, *image;
>>>> -	int ret = 0, i;
>>>> +	int ret = 0;
>>>> +	unsigned long i;
>>>>    	/* We only trust the superuser with rebooting the system. */
>>>>    	if (!kexec_load_permitted(image_type))
>>>> @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>    		struct kexec_segment *ksegment;
>>>>    		ksegment = &image->segment[i];
>>>> -		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>>    			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>>    			      ksegment->memsz);
>>>> -- 
>>>> 2.20.1
>>>>
>

