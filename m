Return-Path: <linux-kernel+bounces-749212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4EB14B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A5E16AD98
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236C286D75;
	Tue, 29 Jul 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FchZL1qn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8CE27057D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782072; cv=none; b=WnCi4xAYishZizCZF80kbktDAk6GL90xFQpd0IL0fO+wz1LfxPf9lVhh3Bp1frlnymwlaaaSF2TMaWLn9HHGT7RHy3khtvpWzlDcuWGvI/BnK9PPus6/v09GH6lRYvi9tUql12fA69RVVVoGbS35s49PwD6wSTeZvuNJfZ+ej40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782072; c=relaxed/simple;
	bh=Ng4/57VyHLgUanL+G5t3NSdFXE5iz/518G3fSQH1d98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9Ef13o8uPeAygkqFV8kzZMCJ1zA3+aD6y+dueE16sEGbVETc1NOddsQdmmh8ynE5T9xCwzllULH0q1aQPJneUG9Azc7sEfXaltxqxeDw+yrYaui4YXzy7TCwYcVkWTLKxmqLb/ZDBZ916Wa14+5u9oQ2K3SScJAb+TVPvR89PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FchZL1qn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T94Lxm027617
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AUSEBgFnH1uyXh0d37hUVymh9ZhcDtPmDMq872O51+A=; b=FchZL1qn518bQuyu
	Negqn+77fM64ev9KYGdzJ1gZvyjH/ILjKtSyLsFU5HVXRbEtbQyKVyBK3/LxBSjR
	tXaHqA4e+Z/wMYi6o6eg4XMZ0ZefqSDqsOcn2LaNYFcU3etbH1mIpFTW2KXuV6ou
	4itYV0zWGFFdVA+yL6NY5Legrg1n7nHOQkt79kVr5U5SO/ehATpzYx2Tq+YVhwaI
	v41TO8nB3Ldvw4ek85NmztPD3ay7AKZIRxsXscTQ3TFRJPQVuf135dHtWDKwN+p/
	YqSQOoWZq3qmqyBxfgkhfst4gOMas3Dw3/rpwAvQ+U4xBvC37D5Sx6bg/zWstt3B
	72l95Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860envu1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:41:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23638e1605dso42767695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782068; x=1754386868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUSEBgFnH1uyXh0d37hUVymh9ZhcDtPmDMq872O51+A=;
        b=H1vrIKcrdNu8vYsbTDGdBNnEGMncs8kdKcrj/rVjtuEEmE5lcL89Fentw1MniXj3/b
         srqIDHMovhel+aNCxzKuUW7wXDgEuSJBVUXmqmqj9i8iLdKR3TstyRiX7BCp+USualAL
         GYw6zihMPekrBJCGrwi+oCaT/FMENdwUBmpqCE8E+N1da+zMLIeqDJiJRwq/AReXahxT
         KsE9w1jfzB8TjnqUs791Jsk85bHBb4/06uOG3OEPjCn4A55wtZce9HiRlSbkACtc06mE
         5S7rOUbzvhYeLKWyISAEXvbC+LN5VIHjJLsLj2hRPrJxSDFnhBfElHLB7w2nCbSIrut3
         Ffpg==
X-Forwarded-Encrypted: i=1; AJvYcCW/3FzoXxWIuX0TgoyJtzaf7/ywwxod1jDbcOqZ1QBHYSk+VdT72RfICiXGpLo43gIP9NWwJwKco5zwOqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dARmsmQSdLCtG9jqoMJ7R0jDpE4NdrIiKdLmGGKHNSTgxogA
	5V0eXXYsw2mtyFQok+9pUxGtb+DgkAIYuval6RF1kW8SiehLlNiN4RD14pfsT6zpWkKrqv60r7b
	in8gEgRWiEq61Espde/mSHu3Upry/+ZEbf/v/7v6kvfvvmeMxjMkoHmNE9uEWWi1cdr8=
X-Gm-Gg: ASbGncvD2pkstaUR+D796BwDsYr9aExTKgH2hUaYmuF7D7P5+HvDA8xhhA2822P3WGk
	eV2KAbKnAnC+Q2rn9BrGMWhY4qXC+kAPHNKcsLqGYEQ89O07bG8sVGhkImbXsdh0XZKCxtP37El
	5pFDneLfu8dRkwqwksb1NLu34FzTvORvbjLOk1D/vOuBy3ZmC+3sHuVWJPmQfkVhELVeExeBs/b
	x/pt8mtTJh8XXe6MYZcyxkH9xpQYH44aRd+EtxpLfuY+Hvo1OEKMQCv1TUKwQPT8VeUAEqrDM+0
	KLv3+iPF5SA4mA1WoRaZA1DI7fhihiTkoxDWpLFKzr34xKYS2ja+YFLsog3Q88/cnTKhsNqgtfU
	zGzTv/pUsrcuCTDZW0fjb9vWpZoAZt5E=
X-Received: by 2002:a17:902:fc4e:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-23fb31dace2mr188011175ad.53.1753782067778;
        Tue, 29 Jul 2025 02:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+MDgOxmTsh6oulqquxjkG3/EJNT8XQSWUvnXjykQx8nCReUtx9N0GY4i24ruhy68XPXeQRA==
X-Received: by 2002:a17:902:fc4e:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-23fb31dace2mr188010845ad.53.1753782067364;
        Tue, 29 Jul 2025 02:41:07 -0700 (PDT)
Received: from [10.133.33.82] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc5aac459sm69720945ad.105.2025.07.29.02.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:41:06 -0700 (PDT)
Message-ID: <1b05e823-0698-4938-9ada-260214fc856b@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 17:41:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: athk10: Poll service ready completion by default to avoid warning
 `failed to receive service ready completion, polling..`?
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        James Prestwood <prestwoj@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de>
 <3cbe13e1-a820-4804-a28c-a57e2ee7a020@oss.qualcomm.com>
 <8716a67c-6e33-4a35-8d96-33f81c07c8e0@molgen.mpg.de>
 <1e797dea-d2e1-4947-8ef3-d2ac5ea0c156@oss.qualcomm.com>
 <4e5a3a4d-9b6b-443b-b3c2-eac1b44e96e0@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <4e5a3a4d-9b6b-443b-b3c2-eac1b44e96e0@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lGqJzziFRo3uCzZSFYLd-bO7fEW7I8_Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3NSBTYWx0ZWRfXxWKTGbXL6Rfh
 LCSVS9nnUmvGGmjqVMKXvABpR+C7+xZFKF7LA4HdURnYFcrduHgN8A//fSooZG8Uvna2nWLZo5b
 svOhSzrTaQXfcNDns+GAIuAHJd2sOUYUgioNU6A9cXDVksguOBF9GVmFy6bnhapwqrpn3ussrqP
 rCryiR/Wweqv5Lip5R6oI4izQCeBJp/R/x6KZV64JMowbybvHmADsdWY3W0iYeQ2Tb1XY8Xv9Y4
 fhpuBI5duuv+aztbjOYVqLh+lIq2qBzZILN5fyDI6uks0hn4WPA2mzmQ1Z87dk3ioEh8h+eMIEu
 s5hpndinzJ2LTFr9yq+rlHwq0VDk4twGL+Rxgdb4pZYCDRBzXfYOk9jM46fv5Q68QT2tjszVb7s
 l9IE7H68BB6hiaJX85Ial4izEAgYgCYkEawKMxPw9BDlSVEZs9QHqgXasKMegiLZ7qiYPct6
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=68889734 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1H9zx1mbTHHVdCZ-GkAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: lGqJzziFRo3uCzZSFYLd-bO7fEW7I8_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290075



On 7/28/2025 3:39 PM, Paul Menzel wrote:
>>>>> Additionally I have two questions regarding the code:
>>>>>
>>>>> 1.  Is `WMI_SERVICE_READY_TIMEOUT_HZ` the right value to pass to
>>>>> `wait_for_completion_timeout(struct completion *done, unsigned long timeout)`?
>>>>>
>>>>> The macro is defined as:
>>>>>
>>>>>       drivers/net/wireless/ath/ath10k/wmi.h:#define WMI_SERVICE_READY_TIMEOUT_HZ (5 *
>>>>> HZ)
>>>>>
>>>>> `timeout` is supposed to be in jiffies, and `CONFIG_HZ_250=y` on my system. I wonder how
>>>>> that amounts to five seconds on my system.
>>>>
>>>> HZ is defined as jiffies per second, so 5 * HZ equals 5 seconds.
> 
> Sorry, I missed to comment here in my previous reply. HZ can be defined differently – like

Sorry for misleading - I was trying to say the HZ has a direct relationship with jiffies,
it equals jiffies-per-second in its value.

> 1000 HZ –, so the timeout would very, and then not match the actual timeout required by
> the hardware? `Documentation/scheduler/completion.rst` contains:

Not quite sure about what the 'timeout' actually mean here
- If you are referring it as the argument passed to wait_for_completion_timeout(): yes, of
course if could vary based on HZ value.
- But if you are talking about the actual max time wait_for_completion_timeout() will
block: the answer is NO.

> 
>> Timeouts are preferably calculated with msecs_to_jiffies() or usecs_to_jiffies(),
>> to make the code largely HZ-invariant. 

I am not quite understanding the 'HZ-invariant' here:
- Does it mean the actual max time blocked will vary if timeout argument is defined based
on HZ?
- Or it is saying the value of timeout argument itself could vary? But note the result of
msecs_to_jiffies() even varies on HZ as well.

