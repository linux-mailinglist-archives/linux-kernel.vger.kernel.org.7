Return-Path: <linux-kernel+bounces-658525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC656AC0399
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 06:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DB74E4318
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 04:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288F26AE4;
	Thu, 22 May 2025 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cO+IVJE2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F733985
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747889658; cv=none; b=aYi1ZQoNg23G3wwMm0XiyKEA0aWWvbaRetI+WTJ0NX9I8/0n2bEl9cBFvn/BuhN389G9ACIlHbs/iloeeuYCMqVLc5yJUio+HN3IQduJc4ogyO+Ik2PT0vc8E4KWe3ZzcsNlyGlqiX9Nke9PyuUfSX/fZVksAuMCZwaZCJnDKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747889658; c=relaxed/simple;
	bh=l6FkrG6k+W3zvxIqBxpSgV4iSEkIee+9ZdOjiXIup3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ffa14fGX4tfoBOdcOwqaP0wt0Om+IVOXFg6q3iZM0UrdHwtyVMEl159s2j/59Usoep5/z38Vy+9hQ/jHeIoOlUV2VakNg+YOZDhzXSljy5zJc5QpoBaMV5eOOT015HKBwMKe3rTVstv8W9rnmX4rbQDIFtL7eXl5M3nu+lFoK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cO+IVJE2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHp0PH020601
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 04:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l6FkrG6k+W3zvxIqBxpSgV4iSEkIee+9ZdOjiXIup3Q=; b=cO+IVJE2MSI/Wo1U
	32RInUR/RfurUJstEi482umF9c/vx0ttvQnRI1eSLCaLVFdu5wyY2GLuG5+6FPLL
	u+uFpCekfXDY7ZYhO1YZ6kg0A0vH2x3HMEVU7h4QfdVQwAcGHM+j3jqYRw241wHF
	8wboaCmz2Qky0RNNUZ5GGJTDGtGrZusmquf6+NPt54GjFixVYKYiWTgt1nhQU8d6
	sEqGQZYoXCnyfLcyP1LGA7y0HJR7LgHEkSSe57fmCvQ8VEeL9lL/00lRSfDkNVpY
	Y7Fa6Vzf5iY223z+cIF5C/R/JxrEWqut29DnDj8BzDV3LSjSlbUBh14+rFRgVb4Q
	kX91BA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s9pb3bun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 04:54:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742c03c0272so6268003b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 21:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747889655; x=1748494455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6FkrG6k+W3zvxIqBxpSgV4iSEkIee+9ZdOjiXIup3Q=;
        b=OA8YBOPbKKv5mA+q+9eN4jscyAgWGVyyxAY4kMALER+npmrwOLm0FuodYbh/T/hg1g
         HVqgfI5D2pJ1INaJRuZY7q1mtH4U40PjfHRH2YtCj/WHgD/Fft9YKDO7wsfNqZAUEJdm
         RM133SDTKSRmcouUG3b200qUd1QcJoRlmIU7IBknPdWVpcwtDzyelTUwt2Yxm8I+1u/w
         eJD35mI0RmuVXdMSEUhj6uMlQWUY+fTnwnzRk6qIGG1zUuI6euxM/LsR7PCUNLRyWdxS
         swszOrbjii4Cco5qlprxtNX6ljYTnLg6VQl1LFyRIF4A4HOrd7Wyc9vkz/QeNb8zbLjD
         lVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvtnRNNDoGbDJBzWUbMW90fz/zPZZ7ZBaDE+B/WPNMVHIDrk0JW7wEZ1av/aqWQ469IJA7I0j8IbBX3mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjoCKoHQqEpMRbJYuKDXtPrCB8AOVzxGInBmJciTrOlvNIXCok
	PI5+k/wJWOsI0DJdHKCK+f+VFmxZ49W51tAz+2qeIrRKyqN+SLq65kaFmYYaanRyFBkZEQoKjWx
	VKRwkYGQBhIXbhqYynXYx7Zi6sdfUNS2ScOym8ZsEd5DtSt1B/mixj2tkYXYPrePLtnI=
X-Gm-Gg: ASbGncu1DpgJ4LupqPTjklWxPmpdsbpCs2HxEJ76pmvxsl52PVJ8ij3hkoNtbasgCo1
	ogo+HXRcb12bLJs/nLD5YvKSlf+uiYBmGZVhSQnn+eM/0Gvja4gkcOCCjYQ9/mt2CGImzWfKdmR
	QNNTdk+86yAExnnvdQIkShxGocvWw/1higQuZ4MjT5JaaXmz5J/DgPlPH1PMT8k5bTLlWiROABw
	wEvxAQsymF0JzCybawXvj5VBI4/yKiLz3OOl85G5C1lFPPrqZEbHhthPD9FmJy4kt5uW+9MSpy9
	RW0wVbRwi0MxmjezNZVs92Tk7hYiCXQ/hYqfY9c=
X-Received: by 2002:a05:6a00:6f57:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-742a98abbecmr32297540b3a.18.1747889655259;
        Wed, 21 May 2025 21:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNsAtOqnn/3MNLht/RQCO5hiIii6DVVYiv8/dJ7UbVtfGi7DlO2EHF+VK4i/Xwj9WHK8z73A==
X-Received: by 2002:a05:6a00:6f57:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-742a98abbecmr32297502b3a.18.1747889654846;
        Wed, 21 May 2025 21:54:14 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96defa1sm10754798b3a.12.2025.05.21.21.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 21:54:14 -0700 (PDT)
Message-ID: <999d2ca0-b3d3-4fa2-b131-092bef4951c8@oss.qualcomm.com>
Date: Thu, 22 May 2025 10:24:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] misc: fastrpc: Move all remote heap allocations to
 a new list
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srinivas.kandagatla@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@kernel.org,
        Alexey Klimov <alexey.klimov@linaro.org>
References: <20250513042825.2147985-1-ekansh.gupta@oss.qualcomm.com>
 <20250513042825.2147985-3-ekansh.gupta@oss.qualcomm.com>
 <sgfcaujjpbvirwx7cwebgj46uwlcvgr4cgcnav5fmwmjsf4uku@iytanuqqiwxo>
 <71eb4b35-51a3-411c-838d-4af19631325a@oss.qualcomm.com>
 <tdae3jb7zbkbzvk546j5jnxnfkeux2bwrbz3i5gsehecj65n7v@2hseuptlk2a2>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <tdae3jb7zbkbzvk546j5jnxnfkeux2bwrbz3i5gsehecj65n7v@2hseuptlk2a2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WJl/XmsR c=1 sm=1 tr=0 ts=682eadf8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=QGv7k4z_AMq7-X7-KaQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: BB0Ib3cUUq3vThWs_Uq1GrkPiASAmhoT
X-Proofpoint-GUID: BB0Ib3cUUq3vThWs_Uq1GrkPiASAmhoT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA0NSBTYWx0ZWRfX1vja7n8Aw9fk
 tn8VgJzrAEj9NRo7HzlLcsvkx2hxtIrPKDWnNdb4T/5oRDInNOhDH+DnPpvToxQAgujIS+mle/s
 OLnPixw83IB5AasEBTlqPCHEcbHoO63D0mourOAjzWUMGGi6FlEGHEoyVJG+pWjtOB3jlY/wMmK
 dxn9S9U3eAPmP+BqjYY4SZGS3xoUPcuCWP06GkFx6NkfYjRJ+nSfzCiiowlE+Ez2IGg6jAcswXJ
 d+A+uJOd+0oIz6h1vnYFidK9ILtExZDj8MDxHnaLG0EbWQxYov8CpmKILDAKY7TYPxBCnWa8LW1
 pWNzpETkoTILjOvlVzlhM86VGWkentaoqCf125gN6kRQSMuldSt9PYOLX42vSWlGsPL24BzqnxU
 Prnw71t8L7xh1BTSKYFFHpnqNBYPe902BJzguUkHxg4+fTw3mLzJXeeOkmVFKiBBC8CNHXbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=898 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220045



On 5/19/2025 6:59 PM, Dmitry Baryshkov wrote:
> On Mon, May 19, 2025 at 04:36:13PM +0530, Ekansh Gupta wrote:
>>
>> On 5/19/2025 3:46 PM, Dmitry Baryshkov wrote:
>>> On Tue, May 13, 2025 at 09:58:22AM +0530, Ekansh Gupta wrote:
>>>> Remote heap allocations are not organized in a maintainable manner,
>>>> leading to potential issues with memory management. As the remote
>>> Which issues? I think I have been asking this question previously.
>>> Please expand the commit message here.
>> This is mostly related to the memory clean-up and the other patch where
>> unmap request was added, I'll try to pull more details about the issue
>> scenario.
> Thanks.
>
>>>> heap allocations are maintained in fl mmaps list, the allocations
>>>> will go away if the audio daemon process is killed but there are
>>> What is audio daemon process?
>> As audio PD on DSP is static, there is HLOS process(audio daemon) required to
>> attach to audio PD to fulfill it's memory and file operation requirements.
>>
>> This daemon can be thought of to be somewhat similar to rootPD(adsprpcd) or
>> sensorsPD(sscrpcd) daemons. Although, there is a slight difference in case of audio
>> daemon as it is required to take additional information and resources to audio PD
>> while attaching.
> I find it a little bit strange to see 'required' here, while we have
> working audio setup on all up platforms up to and including SM8750
> without any additional daemons. This is the primary reason for my
> question: what is it, why is it necessary, when is it necessary, etc.

This daemon is critical to facilitate dynamic loading and memory
requirement for audio PD(running on DSP for audio processing). Even
for audio testing on SM8750, I believe Alexey was enabling this daemon.

What is it?
- HLOS process to attached to audio PD to fulfill the requirements that
cannot be met by DSP alone(like file operations, memory etc.)

Why is it necessary?
- There are limitation on DSP for which the PD requirements needs to be
taken to HLOS. For example, DSP does not have it's own file system, so
any file operation request it PD(say for dynamic loading) needs to be
taken to HLOS(using listener/reverse calls) and is fulfilled there.
Similarly memory requirement is another example.

When is it necessary?
- When audio PD needs to perform any task that requires HLOS relying
operations like dynamic loading etc.

>


