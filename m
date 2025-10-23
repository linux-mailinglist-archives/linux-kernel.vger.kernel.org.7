Return-Path: <linux-kernel+bounces-866464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C5BFFD32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28CD3A53CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77422F3605;
	Thu, 23 Oct 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PtF7rT3q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15262F1FFC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207455; cv=none; b=UGIVKRdCw8aJalOUmsArLamdpeOiJA/WYHCikHpdc39U+5eh0XuuRztWUFMLRVGkj/mQdGWyOYhLdUgx8UlakGOT4VUOHU+3AK6q66JqVDiVJUIc40OKGUKHZCQKtq/3LWjtPf48GyfqnLhg5JbjuSMkcnzdb8f+C5qVhKdupxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207455; c=relaxed/simple;
	bh=nGh7+KyfgJvVeFndN6DP8WYW7fH1A9URw0atmnYdGfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEzG5w1Q24na6voPEAXRXYPdWXSW8ZcMxDgsFu1XwfK5c1jaOYDySA+y0iFaj09do9fIg0hW2vJ48wOaXe1pQ2t/RNzbH2B3qNcEI0lVJMlmr8z3WpzCXa2q6/sDMTjtJgDSlQEuChDnLGSjSRrSmczajBU8QeeUH9EV3yHDowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PtF7rT3q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6UGpM018586
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P7jby+P/cezcampo9PoeFaJfywyvEEZmUdeXikYv1WE=; b=PtF7rT3qNo8pEb4m
	MQRs08HMOPhkNHc0aCXV1RYrSSDzCJqbLRi5OMTwQPCYNKDiIYeorDyZbTzA+fyJ
	K0ziDue66aKH4oMSGuFsnuBqJZi1U5+TeYUcJqK8hqun6v3+an3dxlDimxc6poo7
	95Qoo3JEq16CrUkkG+h3hXvrhbTv/Fkwt4By+r8A6tPJpczIQJ/nalg9UDOp/TmB
	QaMrDbNfN3y7Y1o0J4mQ9Cnm3CoU/oqLLaTqoc64LMEjkd+iypv5sJ3g8GROpdco
	90qzBS2bUyWTXyqvgHjaXSVFsJsqzBcjfMHEdzx7VEr9sBxY36bHEV2k1MLxBZK9
	ncuFxg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pqtsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:17:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e892b1c102so2156351cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207451; x=1761812251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7jby+P/cezcampo9PoeFaJfywyvEEZmUdeXikYv1WE=;
        b=WXVF6k9sJua+GNVTa5KkoYXAl4Mn8B85S55V7A2WipZDddOHiCWg/9TJ5Gy14xeYpS
         djo0v9+YncWWKvJvv6MWFPF3Xm0zCPM7p0dLwTZ/l8DwE7nyIYgTcD8nD7pr10FXGGF9
         PWsO248Gq0hk5pbDj0Mw+BW93cg9I04xXfwbePQnQAdo/WgT9CEIeJEEerznVHfYurB+
         ooIequZEtTUzEOZlEhx42KP8hL0hulGcMSlb7gMUMNUdHEsAD4HXM6elIj4rhGXsb8CD
         C+K7rvzX8al1MUafnaaQt3Yn32MPWl0pKNRsVoNmpu2r7/t1y5HlU5kvNGHJ9z22lKkl
         tKIw==
X-Forwarded-Encrypted: i=1; AJvYcCVH+QntAw4EdcFLfwUDr8T0Cc0T8pZoyjJZ+AZb+1YZr3z1RZKfdywTQ1I0cIJBW0IVx9wE7/WGNmVzpnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSBFtRjvxaZwAVRj7QspzAAqnAkqaA/dFIUpdRKxfL4nr47nX
	13odQuQPJu5Y2evcIIpYDtuZGMlPrWGx1N+8fTshrVcrbbY0qegcH+7TwTo8jGCr5M5e5Kvyb3p
	VUmAcqGHI36FEVYtTTJISyL4VzBrrU6T0GyTitUtsgCulAuXdAtnr+fwKNRCTbEiuY0s=
X-Gm-Gg: ASbGncvbZgLFukeb8cdn+iQCzSn6msA2dx9+Z1tk+ET3gXYD4fdtJrkxScAMo5zP+OV
	WPDFXoo4hODRcp2zHdzD49+tUa8K4F6+abbxhWKgcK8DSwXWcOM0lw9hcjH/WbauXsJN7kKqKOY
	SkVUhLynpt+sLhG8M9eoUgtuGAAE1rbNd79CXQKQrwxFsRhzl9Sex3A5zXgTdXNpUBV9HxT1egZ
	YRczklrKwdVDEFedasDZfbzrGF0qFA+KiDkbA3ZJtZf2Jf637/CyMhEzlh3DsywsFjgxFnBrsas
	14frqVDD4xKRcujACzimcM+msW25MIzpBERaYFqNUE34tOfQIizeSNFXnxnFdB01aL2qKkAAXkO
	JTr8T6cveEwxbBYZs0yj8he19mvZkM+o0RPGTvosiMFb5Q6/ba0XbTjwf
X-Received: by 2002:ac8:574d:0:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4e89d1fa0cemr229932661cf.3.1761207451423;
        Thu, 23 Oct 2025 01:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb0VylzRunRisW3rxhmOhizwPymbY5hIWBS4CGdW63B6rUZIyRdd8xr614joK8Z+NnMnnr7Q==
X-Received: by 2002:ac8:574d:0:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4e89d1fa0cemr229932431cf.3.1761207450986;
        Thu, 23 Oct 2025 01:17:30 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f32366csm1099380a12.30.2025.10.23.01.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:17:30 -0700 (PDT)
Message-ID: <5c0b4712-4a54-4a1a-ad73-dc3bdb21a0ff@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:17:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
 <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXxKF8wEEUSI/Z
 9duJj8ynM14eUXvQzYvvZuIVDQPUYpFSsYtdJv6jqDppubMm+wGK3PEY9Een+KMdl2nIghS7NYz
 abqedZ4Lk7uEt19M2bPTeBG6F8cmLPc1oFnC3mt3YiCMEMtIcumL1lP0nnGCSS0kNeCH/cC8AmR
 84zuwo7oiUgMhJtz3m/1/GabSe0tjFSnhr7uukHyugCIZ8TkmuenSf3orRUBoaygtPi/hHAB2fG
 sF0/w7zlxk2aCmoUA0iG+87IhktrT7uJGLQfchX2zG15+d4YF8IJrI3a6eXDLghHQ2vKUPb2USF
 BDhzO/sA7Y6HIYdeH47ZeCgMsIxgNExyK8/dszt34sX+mx9E+Clrn4MlDtzwe2NrY90WfewcXEq
 pl+wqFljqI/O3ZLF6zIJrA8DdN+evA==
X-Proofpoint-GUID: qJ0Bfr5hWgCLyoL5tN1f1fRO8_ZZELQw
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9e49c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ECcW57WI63K3aF9AT9UA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: qJ0Bfr5hWgCLyoL5tN1f1fRO8_ZZELQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On 10/23/25 6:46 AM, Maulik Shah (mkshah) wrote:
> 
> 
> On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
>> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>
>>> All rpmh_*() APIs so far have supported placing votes for various
>>> resource settings but the H/W also have option to read resource
>>> settings.
>>>
>>> This change adds a new rpmh_read() API to allow clients
>>> to read back resource setting from H/W. This will be useful for
>>> clients like regulators, which currently don't have a way to know
>>> the settings applied during bootloader stage.
>>>
>>
>> Allow me to express my disappointment over the fact that you sat on this
>> for 7 years!
> 
> This was a dead API (even in downstream) with no user since SDM845/ 7 years.
> Read support was eventually removed from downstream driver too for the same reason.
> There were early discussions to remove read support from RSC H/W, due to lack of users.
> Its not realized yet and all SoCs still supports read.

Can we read BCM states from HLOS this way too?

Konrad

