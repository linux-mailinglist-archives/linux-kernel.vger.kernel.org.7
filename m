Return-Path: <linux-kernel+bounces-580140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CDBA74DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 16:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815183B0839
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF901CEE8D;
	Fri, 28 Mar 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="zhk+rTcq"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97321C84C8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176664; cv=none; b=H9mIAqBtNuFvfMeRnXhgypS56Zf2IqW4CBYB4mo0epTbYZPPvUuP2NVK8ZXvn6E5sItUmhERehY63+ssHgNeOpK5sNP1eoSj2uux3D2BCNMt3e6FkjOdGZw4b58emq12CE/2xNRnQnP3SXxJO4NJpt7njDPyM8A9PzvptBrSymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176664; c=relaxed/simple;
	bh=/EF7M/ne0ZHe5tN2adphf5d9trAXisiu4HQQtOYcggw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGpd+mp5JHq370TlUe8u2/WpioTPDpJeeI4KznT/7cq4lWtRU1p/XFrglD6bdy8sViaVH9jfQFUEaWy7Qnb/AtMncvCt3Xuh+ANVc5N7uBqCneihgioQoTLagT77XAB7bp+26gjiumm6EDfvY1pPMLLfq4c/k+NPcusz1ot2000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=zhk+rTcq; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id y9nut1C01XshwyBsatzZLh; Fri, 28 Mar 2025 15:44:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yBsZtHQ24h1REyBsZtY4pE; Fri, 28 Mar 2025 15:44:19 +0000
X-Authority-Analysis: v=2.4 cv=Su+W6uO0 c=1 sm=1 tr=0 ts=67e6c3d3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=V7wt8ISbgwpZ49mr6TgA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hkrKGGmWrRL37c0+YuwoWKAu3zAbu3jD4vnd1lNlFWI=; b=zhk+rTcqEhb7LoQFvRJRyC0G+H
	Uk7VsMfDIsF4VmWR507imUj+oMHHycuSABCiC1zHeR0V+FSS3SzF71GxiHULDcVWj0S8+YWuDLnDs
	03kNVnUC88LFxlBucWBHGz6G/LEAmyyqUzUgl2+Uyp6ZPZSlC03/o/Y/4MgNj0RDq+Nn1wJwZYVsR
	wBhl1C7z+/EC/3Hwb5PYQs8BeTkMKcsyMnO25/rGefxCaNdLdUev/qVeXoqIpCppZfqTHgAaWBLaN
	qCSvdNPCPZsunhkcjd9ynk983bV/AIcwK/ovAQtX8adX5VpBTDnBlKrIAFO65qNIPtANOf8rA3/s9
	Ar3SzyLA==;
Received: from [201.172.174.147] (port=37498 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tyBsY-00000002maz-168s;
	Fri, 28 Mar 2025 10:44:18 -0500
Message-ID: <ce82e21a-b21e-4f9b-928b-84168d4f5bbb@embeddedor.com>
Date: Fri, 28 Mar 2025 09:44:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau/outp: Avoid
 -Wflex-array-member-not-at-end warning
To: Danilo Krummrich <dakr@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z-a2DAQmcsHHlyci@kspp> <Z-a6wtoIAkDY2ERx@pollux>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z-a6wtoIAkDY2ERx@pollux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1tyBsY-00000002maz-168s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.174.147]:37498
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDDOuPKzeELHWMiQmJDhfD/s5Qq7VZySJDjfnqeRKgtSMGfIMbOmtpeZrxH5NAtKXpcIpdz0Bp1Ne81ZlsSbBnkzgbYgJ/hu81QKaaJm2G2CbGbZD78W
 E9xyXbB6wIK1VF0vgIn4+u0Dwih4Qme/vV2IlH9FgpUv/gUK452QQZCUWldH3HWbTsGpAuf2Oeo2mMxZQKfAnyqBDDZ2C7v6tKPuKaeKYHYw259eqWSqvuuz



On 28/03/25 09:05, Danilo Krummrich wrote:
> On Fri, Mar 28, 2025 at 08:45:32AM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> So, with these changes, fix the following warning:
>>
>> drivers/gpu/drm/nouveau/nvif/outp.c:199:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/gpu/drm/nouveau/nvif/outp.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
>> index 6daeb7f0b09b..403cf16d5e84 100644
>> --- a/drivers/gpu/drm/nouveau/nvif/outp.c
>> +++ b/drivers/gpu/drm/nouveau/nvif/outp.c
>> @@ -195,20 +195,18 @@ nvif_outp_dp_aux_pwr(struct nvif_outp *outp, bool enable)
>>   int
>>   nvif_outp_hda_eld(struct nvif_outp *outp, int head, void *data, u32 size)
>>   {
>> -	struct {
>> -		struct nvif_outp_hda_eld_v0 mthd;
>> -		u8 data[128];
>> -	} args;
>> +	DEFINE_RAW_FLEX(struct nvif_outp_hda_eld_v0, mthd, data, 128);
>>   	int ret;
>>   
>> -	if (WARN_ON(size > ARRAY_SIZE(args.data)))
>> +	if (WARN_ON(size > 128))
> 
> Seems a bit unfortunate that the size is duplicated here.

For now, I think we can do something like this instead:

-       if (WARN_ON(size > ARRAY_SIZE(args.data)))
+       if (WARN_ON(size > (__struct_size(mthd) - sizeof(*mthd))))

Thanks
-Gustavo

> 
> Can we have an accessor macro to derive the size for us?
> 
> 	union {
> 		u8 bytes[struct_size_t(type, member, count)];
> 		type obj;
> 	} name##_u initializer;
> 
> Maybe a macro that returns the size difference between bytes and obj?
> 
>>   		return -EINVAL;
>>   
>> -	args.mthd.version = 0;
>> -	args.mthd.head = head;
>> +	mthd->version = 0;
>> +	mthd->head = head;
>>   
>> -	memcpy(args.data, data, size);
>> -	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, &args, sizeof(args.mthd) + size);
>> +	memcpy(mthd->data, data, size);
>> +	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, mthd,
>> +			__struct_size(mthd) + size);
>>   	NVIF_ERRON(ret, &outp->object, "[HDA_ELD head:%d size:%d]", head, size);
>>   	return ret;
>>   }
>> -- 
>> 2.43.0
>>
> 


