Return-Path: <linux-kernel+bounces-764001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD70AB21CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C742592A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F6296BB5;
	Tue, 12 Aug 2025 05:08:48 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB41F78E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975328; cv=none; b=tntt58P5idYOV2dq9tDWYbfo4MbU6/3lSRJj2uUn70VkGIJH0xx/Qvo9mHrWbHCLOVa6YWzKMNL2JS+uZYncsnp+0Br4rEZ1Md0cXnOJNxJEFj8DYexw3WBUCEe4SdBHWPSicHS4YqZYx/rSxO47zJUsCcELfWM1Hhz2hiWxaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975328; c=relaxed/simple;
	bh=0jQFebElUuzOHF6YMJVFklNc4Dl2OqtxwYzDhGEPkOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhC4sKdtw9nc3p/DFpHruEjdztJOpKlj6wSZ2JNUovl2RkzPEQ0usMrnXv4IZ7NQ52BEGTIDVIWaRSuZ39pR4TKiXZ+mGO0leKofsLjYCffFGTx5+guKjO2GQCJLdtYVC8yyX6sstHlXAWAwmduVx0i4xyMQQSXSNFG98J3GvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAAHRcs+zJpo+SUIAQ--.64152S2;
	Tue, 12 Aug 2025 13:08:14 +0800 (CST)
Received: from [192.168.43.195] (unknown [10.200.80.159])
	by gateway (Coremail) with SMTP id _____wCHj5s9zJpomrfVAQ--.51958S2;
	Tue, 12 Aug 2025 13:08:13 +0800 (CST)
Message-ID: <a32e1a36-8978-45c4-be0c-39e7ccd8f877@hust.edu.cn>
Date: Tue, 12 Aug 2025 13:08:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checktransupdate.py: fix missing f prefix in
 f-string
To: Jonathan Corbet <corbet@lwn.net>, Haoyang LIU <tttturtleruss@gmail.com>,
 Yanteng Si <si.yanteng@linux.dev>
Cc: hust-os-kernel-patches@googlegroups.com, linux-kernel@vger.kernel.org
References: <20250811170704.99420-1-tttturtleruss@gmail.com>
 <87qzxhdb65.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87qzxhdb65.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrAAHRcs+zJpo+SUIAQ--.64152S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4DWF4kKw1fuF4rGF45Jrb_yoWDCFXE9r
	Z2yw1aqF1vgrWftFs8twnxZFyrZr1kZrsYqrn5Jw4xC3WDKrZxCFnayrZ3Kw1xJFZ0gFy7
	u3yIqF9F9asIvjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
	WUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x
	8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q
	6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0X_-JUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 8/12/25 1:24 AM, Jonathan Corbet wrote:
> Haoyang LIU <tttturtleruss@gmail.com> writes:
>
>> add a f prefix for f-string
>>
>> Fixes: 63e96ce050e5 ("scripts: fix all issues reported by pylint")
>> Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
>> ---
>>   scripts/checktransupdate.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
>> index e39529e46c3d..b57fb9139f5f 100755
>> --- a/scripts/checktransupdate.py
>> +++ b/scripts/checktransupdate.py
>> @@ -131,7 +131,7 @@ def check_per_file(file_path):
>>       opath = get_origin_path(file_path)
>>   
>>       if not os.path.isfile(opath):
>> -        logging.error("Cannot find the origin path for {file_path}")
>> +        logging.error(f"Cannot find the origin path for {file_path}")
>>           return
> Ouch, good catch; I've applied this.

Wonder why pylint cannot catch this issue.

The Fixes tag is my commit - "fix all issues reported by pylint", :\

Dongliang Mu

>
> Thanks,
>
> jon


