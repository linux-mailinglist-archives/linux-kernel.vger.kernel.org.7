Return-Path: <linux-kernel+bounces-748504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB2FB141FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F137A33E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AC275861;
	Mon, 28 Jul 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="op+JZmYr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8433274FEE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727389; cv=none; b=RmqgD7ek83LeajxOFC17UtVaw0sBmTiWoyhH4IJxCY3zZlpqu1Lfnh0eb8wIolhVbDGXEGsMrA+qitLi+Mj55uHRArlNzhyydqvMAl0PrG2KJPAFaGMtm1xz1XSLh6LmVJvGRBCO0rRvGtaNIBSj6yAIsg48lb7nQv0FmHpjuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727389; c=relaxed/simple;
	bh=Zgzq5fUBiscuzMXprNY3QBGKYe4UUihhhz0vOaibSdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzU8VDRgw6xleaEMCSgSu4U9jyD8D9P6Yq4PaDpIl3196bAlXMUZWJWwliGC6JaqasXXvTj+hoFHFuYYiKCgFtYu+9E+wIQ/sXKfFRhs3pxc8rb/4tbZV2xLzbdOS02QKKHEdW+L33irxDfWxAczE9bhhOK3JYOY1CBda+01Gqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=op+JZmYr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlL8L018856
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OvJzrl+/UhBa3hmO88GolGsvDJxBlDvFKg+LbxKyh0I=; b=op+JZmYrnrYaiWf9
	IGp3irs3z6UtuOaL1T6sn68k5fQnJKYOdAIy+9hLRn95GzpMzoxWoBJpLaVgL3D2
	HdNtuN2Io4BgLvzgTkem+QbYncYROwAAImE4kfdJLXGuoS5z59ykf4pF9xMf1q+0
	IDsYzA/6AtGblKj3szpW5Z+Jel4+v2WeOrWMqQ/zlilvBRc0qbRz9E+Ka8DRf8ss
	lqCyU0Sc9heQ2h/eWrnGX/CnF6Pq2m4goK17gdFfYGwoLfzmxwdo5SZiPIclM3EQ
	e+g/LprGV4KIl1YHU7d2oZjsac3UF2cc58Z6D5VDvU3kQLU7ik20uZ5Tc0jEsYpO
	K+QD8Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85wj0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:29:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e623cb763bso844634885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753727385; x=1754332185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvJzrl+/UhBa3hmO88GolGsvDJxBlDvFKg+LbxKyh0I=;
        b=xEz/JTeXv9Q99p4i7qea88tQiQ7NiIuMD+/ft5FA4D1Fvsjwmu6dGNb61uhB5rKxt+
         Ja/auurfY4vYpuSCLQGdmLaBbCcQvTtAn+Kck0Bfe5QCCN+Ms7oXL4Cll8fdp0ODjy0z
         f+q/QpxJkAf/uT3Eb4O1kQUie+xoMYF7SSDsaEZ+YuIYRrbvKehH3qnRZqMwdYRmhmSw
         mYuMkHgXMo4gwu8Uc7xkyU6wEwfxbwBP0EWUrDFNvaISAIc/r/lbtTiGNQPBzq34cOR9
         OmlbD9eYeArgE7Y7m68d/JzlfLXotqz/LizEkKhkXMjShsN08tC6n2QwexUHKVkR5yho
         hrjw==
X-Forwarded-Encrypted: i=1; AJvYcCVZa8pHhG1ZzWHr0qzRHtaSjuVCz1L3jWgw00czTjEZ4/DsWCBZyEi9tZbv3WL6l/vkWmRhyySnRd0umSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymq1vXxABtlp1Pve4UePee7rxNE5fFglszE/JTkxoN6ua9MBCF
	JTR33eBfmG92+kcPiZGVTS8zSGPN5IleAbr8zHtw8KNejm+PVRfIMpsei/6Z1/MqchTPx7m+VVG
	vDxKY9cV3MOyktvFQ2FYY05Q/WgX3wmoMsjR75feb32Z/3sQLz2+FvXS7931TG4pcIOw=
X-Gm-Gg: ASbGnctqmULA1plHL+z/g/rNZlZYA/dxKPb0pA4hcqGe0nK/A5WzIF4MWV8937o7RlV
	B3EoKHtWJ/uEZYGCyxeGOPOMGJ0MzLFjwX6wSfqCobNKMduPko4cS/Ik5/VQaHEnA6C2C3hY3Zj
	LpMievJQVvRWZVsiQG7GXWDYCZQdde1JevO7iT9CSXb3Z56SR28BnmQ1XmXeZCD0BDkjmXdG5IN
	bfxGHoFkteKWeLonSjSYW9akQSZrA/sleb+SJ65joiomIbyQyWEZiigHNX7qmlCJ9EiYG95yXDE
	rohrK5xWvzsvNFVdySxK5oUo1T1OjN60d0nLe+RtoOTA9NYR434rUfFjMbVBTcnMunkG2SxP9FR
	e0ynabDvSJVCFyFAngoyRCEdC91FOO9HcCy9oreK7t7zGAxckPcVM9jeoTxPfrTr2czT8sl+XDm
	sLxmcku+KMcJkFMZam8g==
X-Received: by 2002:a05:6214:226e:b0:707:159e:d1c9 with SMTP id 6a1803df08f44-70720658229mr164970526d6.51.1753727385169;
        Mon, 28 Jul 2025 11:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSNgPB3zFf6oPz//UBdRYzoglKZ/sN+oF3kbq9PUMHp+iEJ5arlOsVMtajvVAOtS+w9j00QA==
X-Received: by 2002:a05:6214:226e:b0:707:159e:d1c9 with SMTP id 6a1803df08f44-70720658229mr164969656d6.51.1753727384396;
        Mon, 28 Jul 2025 11:29:44 -0700 (PDT)
Received: from ?IPV6:2001:14bb:cc:47df:51b5:3653:9304:7ee7? (2001-14bb-cc-47df-51b5-3653-9304-7ee7.rev.dnainternet.fi. [2001:14bb:cc:47df:51b5:3653:9304:7ee7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b631a186csm1366470e87.78.2025.07.28.11.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:29:43 -0700 (PDT)
Message-ID: <2d672126-ca4d-411e-89cd-f40f8d8a4f5e@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 21:29:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
 <3gtlf5txxtioa5bvo6o467jupyoam4hjhm2mdiw5izv5vbl3tz@drndgp3tcrgo>
 <bcef34c3-98b4-454c-8138-c73729e17081@kernel.org>
 <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
 <2a39c0ab-edd4-402c-95a0-a6286f03102a@kernel.org>
 <1926e6e0-70a4-67fa-5e91-cd0155af1eac@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <1926e6e0-70a4-67fa-5e91-cd0155af1eac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEzNSBTYWx0ZWRfXyf3DmWb1Yfon
 ufE7s51vwFpox4Uz/iCCnfRzj13tbHAoYAr3MfYDwH5dXkwMTMXUxawUU5LZ+VwpXFPOXpOhMAS
 j5jdes6tK2sxL/pQteBw8EFwBhAiXOIHfFKGRawzBegrGaXZQD6svGySr7NtS5Hw1VTVeZEM4VL
 qeU8hHmnTe1ENMuNteMyxewYn4+Ynz/LbL09q4KaNfbf2cElTVwt5dqEoZdlif4+g6dOOkdP0oO
 r94pGMSZKtnQQTi7/zeijZV9N3R9c4BoV3xPDMnkfLyLJzagw8Cf13jE6HTZPPipr5slGZma/Yz
 eANtJvBVqYodBcW5SMalxAyJxh6mgXjxDu6Y1Pm5r4wGTcPQ2VuRHAVcI446sa/Xe1V1ZN8sGaa
 KnOXeJZWe9m7s/kCQoA3MAaVlPjVsKz+Pfeb/RuRa1F71icMsLJR21JmjmEtNww0UjIUFWGA
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6887c19a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=v3ae4HcI9OlR9PdQa4UA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: x6h8A0Ef7CQdg45LKY8_Cvf2tkxllx43
X-Proofpoint-GUID: x6h8A0Ef7CQdg45LKY8_Cvf2tkxllx43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=931 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280135

On 28/07/2025 18:54, Shivendra Pratap wrote:
> 
> 
> On 7/28/2025 5:53 PM, Krzysztof Kozlowski wrote:
>> On 28/07/2025 14:03, Dmitry Baryshkov wrote:
>>>>
>>>>> and the reboot-mode is defined in the
>>>>> previous patch. So, I'd assume, the path is defined.
>>>>
>>>> As I said, path is not. only psci/reboot-mode is.
>>>
>>> Do we have an _actual_ use case where PSCI node is not at at root node?
>>
>> Yes, many cases, because it belongs as well to firmware node.
>>
>>> If not, it's obviously a deficiency of the schema. Could you please
>>> provide suggestions on how to describe that in DT schema?
>>
>> I do not see deficiency. There is no ABI that psci must be root node, so
>> there is no issue to fix there.
>>
>> If you want to add such ABI, I will answer: no, don't, because we do not
>> want paths or node names to be the ABI.
>>
>> Compatible is the ABI.
> Will define a compatible for psci->reboot-mode node and use it to find the
> node. Hope its fine to define a compatible for reboot-mode which is defined
> as a property inside psci?

I think it was more about finding the PSCI node.

> 
> thanks.
>>
>> Best regards,
>> Krzysztof


-- 
With best wishes
Dmitry

