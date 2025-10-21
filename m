Return-Path: <linux-kernel+bounces-862511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D9BF57E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647711885A49
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309D32AAA8;
	Tue, 21 Oct 2025 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXetdccY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B88328B69
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038776; cv=none; b=F7j9roy7DqmKrJ5XvWHPSOMZhx1GnbQQ9f57OPLTmACi1Qv6DMF+z4DKaN0rpDUvGs0XtWXIJBFQd4YgRcn1CVK6wCtM2nFkDJjN+xNvu+r5Kcnn6SJdxhl1JcMYI+EM7mCskzWU12gFMQaUDgnpR8glVrA5ezFsdbXz7knGK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038776; c=relaxed/simple;
	bh=2f6PNo8akMHM0ow78qncOsfP9ik2SgrATiXZ5mfN5Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngMlqXdJPVX3y97lM6wS0Nz/VlH85ovsKo2tFwAWbcVcySt1BWTHoa5ih6R8tOv/yFP2Ao1oV95B35esZ8/Sb9ffJpjZzSepp9IiDePN6zdVNWpdd5wsDFQfieMPbvb6UfgS1BqT13/ehgX9nFS02GUIdctirUpccLaCCVIfNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXetdccY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8Fphk002484
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cQ5S6LYVVpRZCjWQzqjDh+0QXNJqqNKilZF5XszBUgY=; b=XXetdccYjTQFAUBU
	pI/Ng3rBDxgZWVvyJ5/MzH8r1GnX1690GOAPRzS2De+Hz61YzXqNWURS9VjYQ07/
	C4wU2nUM2jNr3T3tAbtIgkvYOZ8gcJl48rJ6gFFkeNXkMyFfzRKSIfX73dCvq6ki
	YDZRvpcQAqihMqAqsR8SgBU5LpHTuc47wv6G8JDD/NTBzEn2mp0sFfg+lqrxTEM+
	i9jGUDnLZRh3I0DsUr8so+cVrpzN8kD8dwCoditdTRROy2Ml4wmZOt7FbF6Tjca9
	+Wll/ulhk+Xt+JtM0D9+6lsKzyctt7k1E11yY7OGXKRsJfbRcOoO20K/o1JbPNSG
	yFiSgg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w5rft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:26:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88f7d885f8dso211896285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038773; x=1761643573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQ5S6LYVVpRZCjWQzqjDh+0QXNJqqNKilZF5XszBUgY=;
        b=YttRijQ/QdlOI0vnQ9/MJz4mcQq33geOUcXKTjT6DKy2SVaaJ46tIwJCgHRBqKTafa
         V2ePfuA+xqXK51/E7AoYSB+ELmDKZSsZyFksLNueHAMkNedn1Vk8CqJ8S+tmz0KYZIIO
         5L/ee7Vnc4ZbyG5WbGP54y0MiV5xSOK33v8YLfj/w2Wij6ecuO55XNyOBYo6n09BeUL3
         aja7/4LoOnY3aAPcE04W2yHFVRoSbBv9aWqiMeS04+IYoOS61n4hINgsUzTdI0itiLwW
         UVEG2Ppclm7OzzhTTLR4CWJ8or9HvmYpdACsWV0dMIXkA4/L7fH8yPxcTjfMeTnu5zxg
         kjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsece7WvW283vBWScNg7ZIJlV1xYKil3EXNswdQyxs7CvMQuhLosmrutsb2qSpPTEHPH55sbAoVk0MMpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBa7PO0WUqxLVYvCnzZA+GJa5iwhTFNwZAZpIgV25v2lUkHoa2
	d0zhpeYW7D1C5pCqcWDIl2MD/laPsjVSA2ZYuuQghMEHAiw9cd9wbBq3Q/2HuMxs7ZDs3xkhJ3Q
	daIJKZTCd0ktuzMiTZxDeXdinasA8pV5atU/bKqG/pjbQVopHQ1GFa4ug0cvhxIlwwvc=
X-Gm-Gg: ASbGncvEsJ4CMj43YfC0H/YjEAKLJyRTsc2R00GsMVqiqpr1g98+04QOQLS7RdTMpzE
	gNRhtLpQ9pYL0lhciOHhmd0aFcBIHRmojUjhRm9Cu3lpDDy17Y/IQb20GCX3auh+1k8jtrBAqRS
	tj5XpMzpVQYB0VocsCTQNCu9K30KFJ/usv8PMvLD8Yg+CgPqT6n3OXyDffRt0igYVAXeGxzY4Gq
	IXD2p4NovLoU0HJBOWB7vDW2cQizC3cgRIV+KXwlOwErmykwxbX6CgOTCL3+n4hAOB8+sSGtbKF
	lTZR4ybcJza9T/6eXX90FwZ0/4hQcFwaWsZTE8IwxshbKNYgmhwVelHp5eZzhJDBbmFjOHvW5vA
	iW1CypEVNrt3NPyAvveBnsNGDB2sbHzbm6Prq+ZiygEw3Qna+4n76e+Sz
X-Received: by 2002:a05:620a:471e:b0:891:c59a:a9c0 with SMTP id af79cd13be357-896e1ddc72fmr204397485a.5.1761038773193;
        Tue, 21 Oct 2025 02:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEERhuwHy7Nh2HueImJqZRTj9hw0JMYU3iQfmrba1U60nisbmo+Q9582QrJk2M4uByUxCrjRQ==
X-Received: by 2002:a05:620a:471e:b0:891:c59a:a9c0 with SMTP id af79cd13be357-896e1ddc72fmr204395685a.5.1761038772716;
        Tue, 21 Oct 2025 02:26:12 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb499dasm1038843066b.73.2025.10.21.02.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:26:12 -0700 (PDT)
Message-ID: <7abcb827-4a7f-4855-811a-4212b8357333@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ASoC: qcom: q6asm: handle the responses after closing
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>
 <DDN83LOTCUIP.5O05FBN02AZB@linaro.org>
 <7c0dad34-cb4c-4912-9406-2e559b91142a@oss.qualcomm.com>
 <60a48dfb-e266-425d-8cfb-574c637f5e9d@oss.qualcomm.com>
 <97afc64d-b384-4edb-9665-a5d654c19771@oss.qualcomm.com>
 <168c9cee-5f5b-4c45-82bd-45c911da4dd4@oss.qualcomm.com>
 <f8b85e89-c546-4bcf-bc95-d109d453bfb1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f8b85e89-c546-4bcf-bc95-d109d453bfb1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JWFdnlgrjcqsJdyaX2linKXL8QvM51Ji
X-Proofpoint-GUID: JWFdnlgrjcqsJdyaX2linKXL8QvM51Ji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfXyymveE73Z8oK
 M+GMUZWktp+7QRJhe3Qsf91WfMvQXANHPETCQSpyfUfv5VmVSPoRg39gCOt6+zLgAx987B6qwAv
 aW1iJlMDtClyhWejmFX57Ajc+QeTZAIvxkbmvx3szNJFCjmmUkMTmEJVKGf47bgAm2uqrknDOL8
 F8rifdZYoy6No10cD61OhiQdRyyr3/+RGyxukRQvcX6ppIO17HOuWPy2TCeVNAPhkJa9WpphdTc
 JUIElXqgYZz00Q8NhdTzAtYVIMy+7EeYrMCJLg6YYvcrU44kiqdhdhJBgWQ0k0UW/u1wRfRNeNN
 TacKJt1++ewZIZ3GvjhLX7OqKIoxjMeHgp3KE9YTM57QCPFjnobSy1O9hxIqbgfFJt7XI5qxLvp
 XpaYF3QFGvodMFLd+/24U7wBylD19w==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f751b6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OtXjWRe8G1RkqavMlDUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/21/25 11:21 AM, Srinivas Kandagatla wrote:
> 
> 
> On 10/21/25 10:12 AM, Konrad Dybcio wrote:
>> On 10/20/25 4:42 PM, Srinivas Kandagatla wrote:
>>> On 10/20/25 3:39 PM, Konrad Dybcio wrote:
>>>> On 10/20/25 4:37 PM, Srinivas Kandagatla wrote:
>>>>> On 10/20/25 3:35 PM, Alexey Klimov wrote:
>>>>>> On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
>>>>>>> For record path, multiple read requests are queued to dsp in advance.
>>>>>>> However when data stream is closed, the pending read requests are rejected
>>>>>>> by the dsp and a response is sent to the driver, this case is not handled
>>>>>>> in the driver resulting in errors like below
>>>>>>>
>>>>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>>>>>
>>>>>>> This is same for both write and eos.
>>>>>>>
>>>>>>> Fix this by allowing ASM_DATA_CMD_READ_V2, ASM_DATA_CMD_EOS and
>>>>>>> ASM_DATA_CMD_WRITE_V2 as expected response.
>>>>>>>
>>>>>>> Reported-by: Martino Facchin <m.facchin@arduino.cc>
>>>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>>>>>
>>>>>> I was also reporting this error months ago.
>>>>>> Thanks for fixing this.
>>>>>>
>>>>>> FWIW there is also DSP timeout error on Audioreach-based platforms.
>>>>> there should be only one for SPF get state command.
>>>>>
>>>>> qcom-apm gprsvc:service:2:1: CMD timeout for [1001021] opcode
>>>>>
>>>>> This is expected as we are checking for DSP readiness and it will
>>>>> timeout if the dsp is not ready.
>>>>
>>>> Can we make the UX better by adding "bool timeout_expected" in the
>>>> path that we "want" it to fail?
>>> its not that we want it to fail, its just that we might fail, if we send
>>> the command too early.
>>
>> I came up with this to potentially work around it, but it seems a little
>> heavy-handed to avoid a single line in dmesg..
>>
> Yes it is. simple thing to do is wait for few ms before requesting for
> SPF ready status, that should do that trick.

Sounds good!

Konrad

