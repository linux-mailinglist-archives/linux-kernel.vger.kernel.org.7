Return-Path: <linux-kernel+bounces-831575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C78B9D0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BBA428234
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E501E1E12;
	Thu, 25 Sep 2025 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YPKwqz5I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F06146585
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764789; cv=none; b=fnIhuT2/cej+BLhRZbVdxsXH/VjfC0UmIeDJ5x1OrrE8eJay4JTlST9OFMIa8t0id6ZVHD71LcLsHZ1MJYXVPHlIltl+EnyPXqBkfuSUdA1PFYsZ0wU0LgUju23EDrdupeYPeqKC5FXPrhIWc59c5etnR7nFeX5vexftFsWDAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764789; c=relaxed/simple;
	bh=u49OwmKzl7uoH8qGSLjjzbww9IPB7agb2Aw94ZJcZTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccyGbdRSB4duYDt/vTm/WgFGoH6SYSjUUiPw60eLskQJptL4g4nOq7UWAvBMHBm8AkB8keHKrjvBqUOPdJlkCDPsR7TiLad4IRL0WOCi1uUudBCyLqRjkZuJr0udkkbATzOLRqTp6m+h4D846oW9USiLDAEf2MAb6yfgycjhLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YPKwqz5I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0eKfG027779
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z10OZLyPBneNQ93YhoH9EuyJNkxrj7NSBb0ueDONA9o=; b=YPKwqz5Is8V8m0Li
	ycZ6HnW5uOrnFV3/3ucxzdwRSOYy3kw90cEYCZ/WU3Oz+WQOJRaqoj7SmKdQDixH
	zOscYBeIJcCpipV7+0KhEhpoViCFId0kJPBcP5+eHyIil6Pac3OrxD7rSrGf6MIB
	VrmHDxa2lVzZS8sncR4evzL3u5s5b3NDFxJcjkVUrI35NkDhCQ/saPrEojr7mkFz
	OdH4Jkm3OyxxrVZ7p8D/XDZ1V0JVp+JkuFM4AqN7UOpskjVuuD+9LLqTtcOeZ1cP
	IZtezERVwahLGxTecBwvHqfTocJAqjMoSvDwL++oNdB+TTwXhMCUt+uzcwuL7spS
	JKH7TQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxpc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:46:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so290584a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758764785; x=1759369585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z10OZLyPBneNQ93YhoH9EuyJNkxrj7NSBb0ueDONA9o=;
        b=q94yXsnvoG6GKE9Gpn5w5V3Ypb3QDfGZfVu0VeESMX/V328qi6aqK3lnluKuZlmGqC
         c1Hry4pAnExpvxgPpa6HXWjNsVYix0l7s4ud45EFkkfZ8rwuMLK7YnmyLI90kbJJnAdO
         JHzBZ6ATQPOb1BUFt/tIsIDyoyESHX6O30DljS+9ivHFSsW+Uy5UAYE9vsJOeYXesIVX
         DNdk2VQkonOKqjWcGqP7XMA0nUFhvV1//u3zLvn8eEj9DDfsQXHpme46JlJmYN3Udj0q
         Ei6WI8GeAUPcaNh1Wjfrn18+5EXB7QHH41voM4j4KTgxj1KNsZxhlgq3KzQz0pNHqvjQ
         fylQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW66VdjVFZUJwq/IC70bv61avXMV29KY+EUzb0+73rahDS1Qsacrf+SAuzCmW4VfZ9BVUcI/bPFACYAio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvL8I2VmfFLBNVR1wuSsrWoXGiKeAghG/lgDbcMa4fGD/Nbc8Y
	elU3CzFG/B5x3iYY+bxsVhhFX2pd7BTLZ0dMN0HmJ2P8lVPTl1qeZUkFhfPhS/Q75CrYyoUx784
	0BSqYDiswmmrhoidurJDYoU18WyCCpNEKunEy8D9rWlWIRO81ePvnDPHg5DLxWEdeCA==
X-Gm-Gg: ASbGncuZo6EDyyBqot95LxL0kVcThEuMDht3HskWhWE2Lu6B/3eoJO88mO8oTAM7hxf
	OCa+6bSm5JTnUOcuy9BCvNHLOSZHqaVPydxWHW3PfhjMttDJGyKWkIo4RR5VKQTFf57GohudOk2
	qj3tW+NcodyNRUU+dfB7X3MVuqnWm6DOG0nD5fO/MibHXXpDypzlJ1GlpK+0A/SnES/0eDghY8O
	SurzMbWFnHW7Cb2227UpnA9FLfQFdIgQyTkpwG3ttSoX/nuz/L/KhYo0yA/cmdRvtrpts1TDvpz
	XH7Fk4Oku6W6qlIv9R7n2/X6UR40D5hYGKrGx/OKqt1asUUhAmJ9X5led7rGWonKt7LXDv5K3ZV
	aLeZ/xTNBqqwkoQ7eQHcuac4zdoZbJMf7d8KoAQ==
X-Received: by 2002:a17:902:d4c1:b0:26a:589b:cf11 with SMTP id d9443c01a7336-27ed4ab31e3mr21067425ad.43.1758764785452;
        Wed, 24 Sep 2025 18:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkWVGsBMaLTmduKHWETBWGp2jxTB4gwYRIKlo2+7MPdlsABDo1JV2x1OEc2s9kaTB1M7uB4A==
X-Received: by 2002:a17:902:d4c1:b0:26a:589b:cf11 with SMTP id d9443c01a7336-27ed4ab31e3mr21066865ad.43.1758764784645;
        Wed, 24 Sep 2025 18:46:24 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6adca51sm6355395ad.147.2025.09.24.18.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 18:46:24 -0700 (PDT)
Message-ID: <6a0477dc-2f4a-4a72-85b3-9de42759cdb5@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:46:19 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
 <aNOfXlG21HIBR18E@stanley.mountain>
 <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>
 <aNPAT_uf-JFvBvkV@stanley.mountain>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <aNPAT_uf-JFvBvkV@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d49ef2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=BRsQPDxWgBvOXLHaTS8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pMLGLEe7Ovn_MsXSwW_pE6pjHp4oPzLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX16y9BdvcfZqF
 ZzeEe475pYaEnIas9Mga0egg3OM0fL5211dgaXBTfPQ5r1jUA11OJKmvsU2FtlaWahfiUn5yrm8
 FSZgmpjUWKTEa6kG6ZI0b+nDHVBgmaYsWXz7yWNAxC+XdimS+SzyCEg9tAkCe2ykn5ZQJF87n8l
 l+zBXRTwLrbJSpZ3XJN4wPctRMfWSfdfPI2Z4yyCAEjOzy5zw/tTWN3XiDXGVbFgo3Cz6AIjCVh
 l6t7DDi9E6/Q0U1+1A3d6wrrf3iRERyyl7KWJVoX5auBiqBQFvQBGXV7zBV7YyXZKEedOtoPsDa
 XxfnmiDebsaG0tpWICQvh1SI5xUoA0DMsu4t9+SVexyDA74y/Zcx5Nk/iDmI/cKhdxL40UjgjJG
 S7voaYiM
X-Proofpoint-GUID: pMLGLEe7Ovn_MsXSwW_pE6pjHp4oPzLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000



On 9/24/2025 7:56 PM, Dan Carpenter wrote:
> On Wed, Sep 24, 2025 at 11:21:34AM +0200, Jens Wiklander wrote:
>> On Wed, Sep 24, 2025 at 9:36 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>>
>>> On Wed, Sep 24, 2025 at 08:58:45AM +1000, Amirreza Zarrabi wrote:
>>>>
>>>>
>>>> On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
>>>>> On 9/18/2025 7:50 PM, Dan Carpenter wrote:
>>>>>> Re-order these checks to check if "i" is a valid array index before using
>>>>>> it.  This prevents a potential off by one read access.
>>>>>>
>>>>>> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
>>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>>>> ---
>>>>>>  drivers/tee/qcomtee/call.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>>>>>> index cc17a48d0ab7..ac134452cc9c 100644
>>>>>> --- a/drivers/tee/qcomtee/call.c
>>>>>> +++ b/drivers/tee/qcomtee/call.c
>>>>>> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>>>>>>    }
>>>>>>
>>>>>>    /* Release any IO and OO objects not processed. */
>>>>>> -  for (; u[i].type && i < num_params; i++) {
>>>>>> +  for (; i < num_params && u[i].type; i++) {
>>>>>>            if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
>>>>>>                u[i].type == QCOMTEE_ARG_TYPE_IO)
>>>>>>                    qcomtee_object_put(u[i].o);
>>>>>
>>>>> This is not required, considering the sequence of clean up, this
>>>>> would never happen. `i` at least have been accessed once in the
>>>>> switch above.
>>>>>
>>>>> Regards,
>>>>> Amir
>>>>>
>>>>>
>>>>
>>>> Also, size of u is always num_params + 1 for the ending 0.
>>>> (basically means `i < num_params` can be removed).
>>>>
>>>
>>> Yes.  This is true.
>>
>> So this patch isn't needed. I'll drop it if no one objects.
> 
> The patch makes the code better though...  It never really makes sense
> to use a variable first and then check if it's valid later.  In this
> case the check isn't required.
> 
> Ideally the code would only have one limit.  We could either do:
> 
> 	for (; i < num_params; i++) {
> Or:
> 	for (; u[i].type != QCOMTEE_ARG_TYPE_INV; i++) {
> 
> Either way works...
> 
> regards,
> dan carpenter
> 

Originally, it was written as

	for (; u[i].type != QCOMTEE_ARG_TYPE_INV; i++) { ...

but changed trough out the review process.	
I do not have any preference. But if having it as

	for (; i < num_params && u[i].type; i++) { ...

is more readable, let's keep it.

Regards,
Amir


