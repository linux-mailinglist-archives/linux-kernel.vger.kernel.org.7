Return-Path: <linux-kernel+bounces-896093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F1C4FA10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8055234AE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1479C329E6A;
	Tue, 11 Nov 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOGWTEhJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbB5gJsq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FA329E60
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890134; cv=none; b=swaY8OCbh1Tnkgp7Hst4bXcH6xaZra/0ToEwBgC07zuBMzJGoHsJNEx8U6Z+5kFUCZL0sfzwUvzluJkGvfztn/LUr4eVosf7YetGHcqRkf8ppr7FPXV4kRJAg+an7UFjWecScurH8BsI4zXJWVAJ0HzVMQBPNbnk9bpWE95Bio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890134; c=relaxed/simple;
	bh=6+fEFdBoDJ+pdMIGdNf08YV7MOBxSDXwgZvR6IbTh2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuEJ1LyAHVxaVDzzWgApz5zfIqA1+x8iHAwYoARubzLdRP7cBpizMdqoyq0DMNxWef5uXw0moszyzRTQTcsHuGVdhbCWnsjYqvNq0QGPum3PSM1RfI39hCg37A4K8B12l+um6g0lxjAteDcKkFF4ooBFbvT4PgZ1W0G12GBPGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOGWTEhJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbB5gJsq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABGId0i2763984
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqnoVw51UCIsT26Oa4weRLY+7NAvoYQK7MEQUSq3sb4=; b=dOGWTEhJr5/jhzIH
	+FhylHABGhJ9Sp9IyfG2pgavk1/MZLBJEvj5y3515gXq/7kX4axiiNLHLDTUXw9i
	k8w4tmj95DulWiWDdcoJg4bYn3VuA+hVX7JotI2Awj1PiaWwy1ZJjJv3AVbGGicP
	d00J28g0FMRh3wZgTKcYymCcqFacCSPedxEaDLGSY48LPnndwet/lu0bl1CKhWvl
	H6TwuXZZ2Sz4k32sh0Ua2vU/3yLhSKaukKwJVu+tqR2J3+oKK8szpb9yYw/iFCBP
	fVz6SfOmRDzYWP5wM2zGMufkQb0xd5hyn7aVTAxK6fuAvbFl0aQSPE37DjzI8Uw4
	2LEM5A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac8j50j0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:42:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295595cd102so1271365ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762890131; x=1763494931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqnoVw51UCIsT26Oa4weRLY+7NAvoYQK7MEQUSq3sb4=;
        b=XbB5gJsqvNAPtDpddSQr1A5Tk98kWlG+8ebLkDKbR141ax4Kmids6VexYGdKelW1IT
         o+2kKi4B4FM8QR5gPzMahAqjQx0vo1he/TgrCZihl3Wku0tx1zehq6u5dkei3mb+BUCM
         j7jYnl4HhAPSRbRtxnu+GjfEEJ6u6TGPZwzT78o5sQrXGYDdKtk10+4fFI7WZXySHm9i
         k4SUE+dknBtBRMB5lZlfVxAOnneGA1L5OLWGsCFGaTMCTsQHsWojEr9nqcB0sZIUP5AS
         2SxQ1MRQOqu0QaFfo/nq3J2EoyRxsZDmriUGMLJMk/up9K16q7rzLoJb9zcuCcjw/0jT
         Z++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890131; x=1763494931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqnoVw51UCIsT26Oa4weRLY+7NAvoYQK7MEQUSq3sb4=;
        b=vESyEA7Ns5mW4oMmOzMc0VavEUoY3HDlIUm9YtHh3VngybtMJtZ1e/A5Ge90dAN6vN
         9nglWaBA8sF9Rt89A6Ojj3TFWY4gxxhyoF0P0JXdO9VAGQj6kNer5FbgEpeIp55Mb4b/
         hYEi9LVgOWJUC18gPWd0eH3OIYiXOBJ8gxdRIIi6cb9rfs2cZAyWCfVaeFBhXAigarD0
         N+RESUbEMkoBuX5x6OPZidbZrzqcvl8CSxxBCHhCEdFz4IwxsGiodb2h4RJrs1lcHZe5
         D/7plMG0sqFEdiAYioeGv1EtQ5EeYcKR7GabYAVWhVSny//cURxtovavRTJmfo226jH8
         j0gg==
X-Forwarded-Encrypted: i=1; AJvYcCXEyWHhrEU616RdKmagiUZcWhmH2onzrz0Y796NJKcN5r0yw0cjv61lI0U6oSAnk8KM8PAnWUc4IrjfVJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWMnUQp//rFZ7fKvAFx064iuaXa1eaesJDVvYEu6u0VJDZFGL
	8yRvExdgZm/NyI5VhQczOm+Fj7WfX/jk59NnNVQfBeJrxjSaaYUBdzsUEdH4YNNJdNwmY8O0ewz
	nIMlPkmvyoOD3YO/D2aBLW8yWrwCDNKTSC5cBQ397HRw2GlalNYXLlVZptiiYjshH8Q==
X-Gm-Gg: ASbGncv5SQ6fLvMr1h83ZwwKDrEFRsF+L57ML+6dhQD8tBDkvFoz+XVY5Ats9yD8ULE
	dL5hI6W9sY6ktBwRBVEJqrO815s5l+wsCjfHq/NWl+zdwpIQ8qe3Y5BJjRLN7dvYrW2EzLidYfz
	HXFGeZbtALH2wbbJ/fMksaDnbOMwMH2BNiPx7m8IqWG9h8o+wJIpq7E0qL037Q2V34MYbbF9+gQ
	CaymlG04RAZqVAZ9HJvtKJ+nOuMyVXqYsGfqoe6oSSZcXZx60wQrKGYXGAQ/6fjqfcOGPKtNiqp
	0KD15jKJGRLL0AQvfIZBmI3NSHRUEsv/xgzQHsyD6ZMqK7T7iBjA0ttHZODH3Mfkw480oyiJMsD
	5zfpx9OaoqmT36Sn75Y4nbV7/70ULUlWdjdoo0B/n3W3m6yiKqHoRkjJVot5MsDYcdZ1cTXUr
X-Received: by 2002:a17:903:2f88:b0:298:250b:a547 with SMTP id d9443c01a7336-2984ee2c611mr5010405ad.56.1762890130946;
        Tue, 11 Nov 2025 11:42:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWfumxVDHLJVJniJ5/kUPbPPfATDyVpTigTkiqrDKAayaaoggxw+dyqtCM41ZXJhxvIUxbTA==
X-Received: by 2002:a17:903:2f88:b0:298:250b:a547 with SMTP id d9443c01a7336-2984ee2c611mr5010145ad.56.1762890130404;
        Tue, 11 Nov 2025 11:42:10 -0800 (PST)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9fc6fsm5313105ad.73.2025.11.11.11.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 11:42:09 -0800 (PST)
Message-ID: <2ec200e4-cf28-4881-837b-4455da047619@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 06:42:04 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcom: initialize result before use in release worker
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
 <aRLcO7dveqChPNb0@sumit-X1>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <aRLcO7dveqChPNb0@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OvhCCi/t c=1 sm=1 tr=0 ts=69139193 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=i4atl9h2owgdAyLMJb8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SqOb-TAS0kSbISf69IO2Vx2Luh29IuZT
X-Proofpoint-GUID: SqOb-TAS0kSbISf69IO2Vx2Luh29IuZT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE2MCBTYWx0ZWRfX86EAbx//vWhM
 bV7I1tMkzpOr7vrEDGg8Irt1uhUSXtq9Cim7SlAcLXJzd58sL+/CwR/FT2sr4MBZJIazW7EjGPd
 MjkHKKkhXU2RzT0lBorVciBA9EtovPw+kulSri1o2Z0FdzGUT7gRTYpCvX3Kx+9SAeWuDNcCmVa
 oAz0hCSypQp7CLLsImgRJK9ZV1F9BSSGXqJB/mNHI7jvmFEG9zrZcGJA0TDorW7MhOXKNHcme+4
 icwl9+DJEIyT8Hy+nrMAG7a4vrNDAaXkBMqvwtWPUJxarUMuD2ecM3dnDZroYrc4WdTSPZ/0KDD
 T2zfO6OV10SdXprMcZVkgUZaPXSZweOFRloMCNiFM4ah4/kOrD/2L6iSEuMeuMttkMFc4UNZlCz
 crce3fttivmxy13RS3TvdOmapj7Waw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110160

Hi Sumit,

On 11/11/2025 5:48 PM, Sumit Garg wrote:
> On Mon, Nov 10, 2025 at 01:28:32PM -0800, Amirreza Zarrabi wrote:
> 
> For the subject prefix lets try to follow the directory structure:
> 
> tee: qcomtee: ...
> 

I believe we previously agreed on using tee: qcom: based on the reviewer’s
comments. Currently, there’s no commit message with qcomtee:.

https://lore.kernel.org/op-tee/4rbfpubsaxgv2buksonfigbdkw6geas6l7pycxuukdymqfohga@ohd4hqzvra3w/

Best Regards,
Amir

>> Initialize result to 0 so the error path doesn't read it
>> uninitialized when the invoke fails. Fixes a Smatch warning.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/op-tee/7c1e0de2-7d42-4c6b-92fe-0e4fe5d650b5@oss.qualcomm.com/
>> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  drivers/tee/qcomtee/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
>> index b6715ada7700..ecd04403591c 100644
>> --- a/drivers/tee/qcomtee/core.c
>> +++ b/drivers/tee/qcomtee/core.c
>> @@ -82,7 +82,7 @@ static void qcomtee_do_release_qtee_object(struct work_struct *work)
>>  {
>>  	struct qcomtee_object *object;
>>  	struct qcomtee *qcomtee;
>> -	int ret, result;
>> +	int ret, result = 0;
>>  
> 
> The change looks fine to me.
> 
> -Sumit
> 
>>  	/* RELEASE does not require any argument. */
>>  	struct qcomtee_arg args[] = { { .type = QCOMTEE_ARG_TYPE_INV } };
>>
>> ---
>> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
>> change-id: 20251110-qcom-tee-fix-warning-3d58d74a22d8
>>
>> Best regards,
>> -- 
>> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>


