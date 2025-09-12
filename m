Return-Path: <linux-kernel+bounces-813798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC97B54AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B315D6835E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242B13009F4;
	Fri, 12 Sep 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1Vj+uzr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41612FF675
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675819; cv=none; b=XRdDmLDWKNN+pQzrgfUaD1PHBjLL63mYcoLh2vQkHTTEGGDyyqygTg32e5WpXFvPqsiMdG/SMWLtB80CRmF0qcmPpT243ACuT00UOYgwFv6/eaWFplZAZe3anUPuPWuF+lbag5RXvji1MqEOvZ7ki4iWoj13ZxgsUU9ajWEK5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675819; c=relaxed/simple;
	bh=rhcvNmsTzZQHkse9jgvO4F3jLJZazKY8siHVo2PUE/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzjDBCilOhrsIfWLocoJJmfL9ryxzxnpOXCfnHkdSrhBQAj9KunSzvcNcX1/cd2mwGvXtbcw99Y8B54e3Uc0eZh5pfL7R6dpu1T8YvH73Md7cz+1QmBgbiixmtPyCkLAnjv28sYw1VWNC9t4OwXAzIhp2hN87EK62Skahnlvq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1Vj+uzr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fPLW017614
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OESG3ssqWgVEsTZ/213k4+I+aFjRTeVrTfjQpSv0v24=; b=S1Vj+uzrLbUhU5Dg
	nTFCr4L9YwdCtkOrCRiT7kEw9+EMghvpwCnF6gs98wTWepW4s88YDWtPGFHxew9H
	4t7eWFFVE9jkKVN7mr2pKHpAvuN+F+2V1jUcF7U9bq5GGGvkc02ijzrMy/U4wMDz
	21TVzfZQF9tCz8cWVXZNJ2W7iOknAUgFs9SVtvimL1Iu9/h7tdbKE7Whb3eef2YN
	FXsJT6KJhtIBiwCbIZGoGLWe89Wmmj3LsOQvoXvW/8tU0WqpWMQoHc8N0d2uT+Tc
	Nb2f4GJFvXNA8nQHRN6mp8FQlOK+OJKOJIdKg2ddopSNzA7Cmg+SCwlMWfhd5uRr
	ymtF8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwskk21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:16:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f15a5f3dso1032551cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675816; x=1758280616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OESG3ssqWgVEsTZ/213k4+I+aFjRTeVrTfjQpSv0v24=;
        b=gJWD66QQn8rZXONizCXtKpPISx1tFj9r3F37AnGX5hhmLdK/oQkgJLksOsdFP5bRhV
         zBpdb9G8AtRS3O9F1nWss1fSz2RoA5zb7p0DWvIoWmO3XzlTWXYBpbZ0fFy4sufPZyET
         oKnAqx1pnae5AX6vtJEJIEqYoDhxNF6j0SiQS5eEYY3L65mzTHMsgew4JqAyDiP8BQ0t
         91W3wPB5JIgS4QQGa0Q8rqiirSIFiz51umRa1OVhJmSswxL4hesV5P96BWaHlCI5o+w/
         6Z0cg3aLMqpkCXNawxiMT9RAVmAMMNLkLo88w/liSLSz5DgfgJdTYwgL4q0oBKcPwHvp
         WeNg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2UX3TSm7TuTNa8a4ctP9w7YAq+Rshq67Rek9x7a5PH7Zae5wFYKJWd/1TmNhUmq8jUzlrdPx2CCM+hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5/sFSSB0udAN47Ntksp2gYaLC8ATSJ+63PI7zTsD2kLWX53i
	IeRhBIKiq6wgcOEX/cPSjqFQSgvDKdV7+A7ZRPBc3gpH6AVsy/4htjGZWI2lhC+ZNovTdajuaVX
	ULsye8bC6bwfiEvrnKVMJiDfdqNf0d0ZMAehQLJx0RL+NzHdAGezgkpJYIytFp/Vd+84=
X-Gm-Gg: ASbGncugLVWqomEJ9UCBUn6SkO1HACbKFMYlsBLhFvCLJZ1ySZwg/e1xMn0Tb7EGtAN
	9VgNBX5hhIB79VCFptvlsb5GSJaefp5GGAACfRfAeGzuI4JU20W0O/XEKUAQ5obgjVh7Dwf6UC2
	3VF29Ylz9HeU9xXeM9DhW7DQstYxlAbWnK1xzDnEeB880DrllGwJIJDUNQCB0J2u90jdzyNVxOr
	9x4egrsgUPRqXCfw+QmoADeGK0BsbssozLWspnd23Haf8l8QrjREkyscrOIUoFf0VUL+C8mqh/R
	BcFPuHMKL0oFqcbj0g9fN8jz3AfD4p3uZGhu39O4RRHTEFIwn9tyvwtPi71GjBy2og+qCU4JcNq
	L0bguwQ0cHbuT4O9WTTcryw==
X-Received: by 2002:ac8:58cf:0:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4b77cff3c19mr20844181cf.7.1757675815263;
        Fri, 12 Sep 2025 04:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6jtjf37Oow/lnm/s5r6GSfkEFCpnLou6DpovhAGP4DVjGD3jXbH8ADRgUAiwdIeHIEMFGwg==
X-Received: by 2002:ac8:58cf:0:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4b77cff3c19mr20843831cf.7.1757675814684;
        Fri, 12 Sep 2025 04:16:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd5bfsm343563766b.63.2025.09.12.04.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:16:54 -0700 (PDT)
Message-ID: <e06183f7-4aad-42bb-8c58-6a0d8b7b60ac@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 13:16:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for Gunyah Watchdog
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
 <20250904001014.GA3405605-robh@kernel.org>
 <a547ecce-31c7-4627-ac6f-aeeef81bd0ff@oss.qualcomm.com>
 <CAL_JsqKuoJrkActpLXVUW9e9=R1FESUbD_rwBd5NGX2_Yv2ASw@mail.gmail.com>
 <99cacf08-0fb4-4b44-9036-96ea5fe01c10@quicinc.com>
 <e7f0b014-3dec-4276-a2dd-479d4248c7e6@oss.qualcomm.com>
 <499f88af-30f5-4507-a90c-d592d0bb4657@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <499f88af-30f5-4507-a90c-d592d0bb4657@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LvXesbpimhGdAISh1D6uQX09nyHMCW2i
X-Proofpoint-GUID: LvXesbpimhGdAISh1D6uQX09nyHMCW2i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX5hrcM3wlyLRh
 rbceiNsVUd/m7Xm8CQ63QrdN0ynEJB2swOTyBjo3giRzva435Rzp5VktI1u8vECO4dutepEwgyr
 jll8UZrt6gBMfpIO2FnLEuZz55fonuDfLUF0Fze8ktwXNrCNF0MirgAS7nNi4fUPXYNjtWeR/X1
 JXqjl+e+pyiufwdAbma11kKWogf1x6H1r0Q+A7gBqblxGmiqPu6Ap558O6UPX0llFZRjMGtqvZP
 J+3VlmXua6+cbS5ZH6wICapTBIV8kSqmbYICgV3aY9YlFrGuW6cNnQYkyVGOHi1BtrNfdASaa3q
 blOSx9uruwoZ5A7dCOs/CQiZN4Sj7fObzMVOkUk70aLSwkwgtjUMCozrlk1yFTLVvscmmmduUGr
 3Tv5me9A
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c40129 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=voeTMfilsXCseR2-0McA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/8/25 7:49 AM, Pavan Kondeti wrote:
> On Fri, Sep 05, 2025 at 12:18:06PM +0200, Konrad Dybcio wrote:
>> On 9/5/25 2:00 AM, Pavan Kondeti wrote:
>>> On Thu, Sep 04, 2025 at 05:51:24PM -0500, Rob Herring wrote:
>>>>>>
>>>>>> Why can't you probe by trying to see if watchdog smc call succeeds to
>>>>>> see if there is a watchdog? Then you don't need DT for it.
>>>>>
>>>>> There apparently isn't a good way to tell from a running system whether
>>>>> Gunyah is present, unless you make a smc call (which could in theory be
>>>>> parsed by something else, say a different hypervisor..), but then this
>>>>> patch only introduces the watchdog interface, without all the cruft that
>>>>> would actually let us identify the hypervisor, get its version ID and
>>>>> perform sanity checks..
>>>>
>>>> IIRC, last time we got just a gunyah node. Now it's that plus a
>>>> watchdog. What's next? I'm not really a fan of $soc_vendor hypervisor
>>>> interfaces. I doubt anyone else is either. We have all sorts of
>>>> standard interfaces already between virtio, vfio, EFI, SCMI, PSCI,
>>>> etc. Can we please not abuse DT with $soc_vendor hypervisor devices.
>>>>
>>>
>>> We are trying to make the watchdog work with existing SoCs, so we are
>>> sticking with the existing interfaces. The newer devices will not
>>> necessarily need DT to probe hypervisor interfaces.
>>>
>>> To answer your question on why can't you probe watchdog smc call to see
>>> if there is a watchdog. Yes, we can do that. It is just that we won't be
>>> able to support pre-timeout IRQ. This IRQ is optional for watchdog
>>> functionality, so this is something we can explore.
>>
>> FWIW Rob, we moved on to SBSA watchdog on newer Gunyah releases..
>> Which is not ideal as it's still over MMIO, but there's some
>> progress
> 
> Gunyah running in Latest SoCs do support SoC watchdog emulation, so
> Linux does not need to worry about if it is running under Gunyah or bare
> metal.
> 
>>
>> I'm not a fan of including the hypervisor in the picture, but as
>> Pavan said above, we're trying to squeeze the least amount of hacks
>> necessary to get the most out of existing platforms (i.e. ones which
>> will not get newer Gunyah).
> 
> Thanks for enumerating our goal here. we plan to support watchdog (hence
> collecting dumps) on existing platform where Linux has only access to
> this SMCC interface.

I think you didn't explain it clearly - do we need the wdog to bite to
enter crashdump at all on these platforms?

> 
>>
>> Perhaps we could extend the MSM KPSS watchdog driver (which pokes at
>> the physical watchdog on the SoC and whose DT node represents
>> "reality") and have it attempt to make the SMC call early during probe,
>> making way for both physical and virt configurations without additional
>> dt alterations..
>>
> 
> We have to be careful here. I am told that SMCC interface might not fail
> even when Gunyah is emulating SoC watchdog. We can do something like
> this.

"not failling when gunyah is emulating the watchdog" is sort of what we
want, no? Unless you meant that if MMIO access is allowed, the SMC
interface may still report no errors, even though the calls don't
actually end up doing anything useful

> 
> If we don't find "qcom,kpss-wdt" compatible device, then we can add a
> fallback to Gunyah based SMCC.

Matching on "not compatible" is tricky, especially since the arm64
kernel builds must support all platforms at once

Konrad

