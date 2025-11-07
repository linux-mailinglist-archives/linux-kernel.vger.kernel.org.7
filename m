Return-Path: <linux-kernel+bounces-889813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFCC3E988
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B627F4E6318
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396102D4B68;
	Fri,  7 Nov 2025 06:14:40 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47A17A2E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496079; cv=none; b=jcFolXmer2LGJ7j07WF8dpxTzxlS7haUDawkKJnFNEJF/xg+371IH6EbZUQLIZ8DU98NlTfjtYXNQg/VA0d4rPiRasNDDf64xCmnh59Od/IPHryc76r7z+kViZeZyUq7Ji+/7DuvSNeiOGvJ3reLXdGgW8FC/9XNfp+6V5sBvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496079; c=relaxed/simple;
	bh=ZdWsqjVruZhGrwl0hRJIdAZZQer8vjk0cSilGugNYPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8TufNOrDvoq31wFXQ7475VSIA3jeTEtdoRe1tGpaFPV6eOU3/qngRxeusM5JI1ulskOXqS7eQki2t9Vh9tiC4Ap8Qtl4jPgew62yNI4pB7OOCsBYJeTCFhDIrUSXWHrb1PEkRAsMGTR3JrX/9SGiwxBTiAgXRlTl5r+s99CiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 04a739dabba111f0a38c85956e01ac42-20251107
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:717e5da2-3c3b-4bab-b8af-984e191e9646,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:a46f60b23166b366801f7e82fd989115,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 04a739dabba111f0a38c85956e01ac42-20251107
X-User: yangzhao@kylinos.cn
Received: from [10.42.8.181] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yangzhao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1200331251; Fri, 07 Nov 2025 14:14:29 +0800
Message-ID: <900f69d4-6ef9-fe1e-d664-e248e41da752@kylinos.cn>
Date: Fri, 7 Nov 2025 14:14:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
Content-Language: en-US
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@kernel.org>
References: <20251106102008.1310234-1-yangzhao@kylinos.cn>
 <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
From: yangzhao <yangzhao@kylinos.cn>
In-Reply-To: <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi，

This issue is indeed caused by the mismatch between the TEE version and 
the kernel version. Currently, this patch is only designed to address 
the problem of ensuring that the kernel does not panic when the TEE 
version is incorrect.

The virt_addr_valid() is used to check the validity of the pointer 
address, because during the test, it did occur that the shm->ctx pointer 
address is the address between the user space and the kernel space. At 
this point, using IS_ERR_OR_NULL cannot detect the legitimacy of the 
pointer address.

The problem can be viewed at the link: 
https://github.com/OP-TEE/optee_os/issues/7575

Thanks.

On 2025/11/6 19:31, Jens Wiklander wrote:
> Hi,
>
> On Thu, Nov 6, 2025 at 11:20 AM yangzhao <yangzhao@kylinos.cn> wrote:
>> In tee_shm_put(), there is not only the NULL pointer dereference,
>> but also the illegal pointer dereference.
>>
>> shutdown() --->
>>      __optee_disable_shm_cache -->
>>          shm = reg_pair_to_ptr(...);
>>          tee_shm_free(shm); -->
>>              tee_shm_put(shm); //crash: shm->ctx maybe NULL pointer or illegal pointer
>>
>> Check whether the pointer is NULL and whether the pointer address is valid.
>>
>> This issue occurs when rich world uses the 6.x version of the kernel and
>> optee secure world uses a lower version (such as version 3.2), and it is
>> highly likely to trigger a kernel panic when conducting hibernate tests.
> It sounds like the root of the problem is in the TEE rather than in
> the kernel. How about fixing the TEE to avoid supplying garbage
> pointers?
>
>> Fixes: e4a718a3a47e ("tee: fix NULL pointer dereference in tee_shm_put")
>> Signed-off-by: yangzhao <yangzhao@kylinos.cn>
>> ---
>>   drivers/tee/tee_shm.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 4a47de4bb2e5..de01d16409c1 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -722,7 +722,14 @@ void tee_shm_put(struct tee_shm *shm)
>>          struct tee_device *teedev;
>>          bool do_release = false;
>>
>> -       if (!shm || !shm->ctx || !shm->ctx->teedev)
>> +       /* checking pointer */
>> +       if (IS_ERR_OR_NULL(shm) || !virt_addr_valid(shm))
> The IS_ERR_OR_NULL() check might make sense, but the virt_addr_valid()
> does not. virt_addr_valid() might catch a few garbage pointers, but
> the real problem is that someone is supplying garbage pointers.
>
>> +               return;
>> +
>> +       if (IS_ERR_OR_NULL(shm->ctx) || !virt_addr_valid(shm->ctx))
>> +               return;
>> +
>> +       if (IS_ERR_OR_NULL(shm->ctx->teedev) || !virt_addr_valid(shm->ctx->teedev))
>>                  return;
> shm->ctx or shm->ctx->teedev should never be an ERR pointer. The
> virt_addr_valid() test doesn't make sense.
>
> Cheers,
> Jens
>
>>          teedev = shm->ctx->teedev;
>> --
>> 2.25.1
>>

