Return-Path: <linux-kernel+bounces-748847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C259FB146AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DEA1AA05B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCC21CA13;
	Tue, 29 Jul 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPz6W0iB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280A1FFC74
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758906; cv=none; b=rL4e8i8u6ikqUMJ/4KayMdv1cAkHsxhrFhTryGwaqDEIJwNPL4h+W0dR5BNvV0LTuGcwxdUAgILom4jhjafftWZhhfajyNfkTunNJ5eGBwdBffp+E3Av0zrwJ1pDlTXXVQxVqKymCd7mMyO7thAkQaU89dcSpX5VgTw3ERmWHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758906; c=relaxed/simple;
	bh=GHmdw+LZq3sxJY62O+sHbuH790EMm8iBdrTDQg+YAkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhbIej6oJyQh7TkkFPaMcx43e677B8+EA87aq8OWVM/ZPS9gQqvPL75irdPgD2/nmUAgD4Vr7xYZqAfh56aAdjUraujtSrbpGjocfgV+olZiFyKlyhIxDZui9cDvChwIKKg02yQcjdqInqcZbYox2+xwvECR7WbbQnO5aAi3k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPz6W0iB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLG7p6031277
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+KxXIkqbzjBGr5vRnRk2sdhKE3MD5Ak/KadxWElxQAI=; b=dPz6W0iBPnAWNh0X
	289xMEPISgZerETop/Q3bva5xdQODTGleBgzGdpB5Y8lIbHh2UbKy4SXYbHCNUfu
	OWXPP3T5OVTuE63q8qsloEyDTydSteFO+nNgYrrdhhwLPTldHk5Kdt5tqzklrQWp
	eou+l1tj1tk3qRfr6lX9we7eftZx8q4SOhRVds+anP4NzNBJhRTldCAvBxMie3Qj
	JFh8ZP89+w/3fHqH306nfecyr2elObnqcPuqtfBtQhTneBsRxQI5yJsBLM0tx60J
	3Zx8uDPSQK0nXktZVMsAfWPaTFhYjLoNDLM/u3wN01DdDkBUDUnyCCWTtEJNCwX1
	KLECBA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xbypy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:15:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400a932e59so23755435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753758903; x=1754363703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KxXIkqbzjBGr5vRnRk2sdhKE3MD5Ak/KadxWElxQAI=;
        b=sF8kSjEsq6gQcZ+N6JiAvSCyMX0L6/7OKBYcmxM88IuFVRj2S7p60o0xFkooxzfXMV
         sGsgv9VtAukfPD/LvCOKQeDBqhltukgg/XTX4q3Q7DwxCS+uiQwLtDnQPp+5/Dvaf00J
         EPb/EiQ/4MZUbDDr2s4b732EYErKVCZaqoHOgZFDyYFiNPcUoEAyGJvPcZuBLPWagybY
         k7laRr66a64+UwicRLvh2I36ag/UQeTm2WdZ7NHY9v5vENZkvkW82MNPY71H/4n1Y/JJ
         WHphIVYFXbPo2s56uthl8eCzxfc6ByBM0H1G0guA9trJcLqOUZRry+F7ye8yONXJbxab
         baGA==
X-Forwarded-Encrypted: i=1; AJvYcCW82VRDpK0aFe+eWacAZepr2QpkqNWIkqevrrgrytsGYrJfkewzTtU2yvIuz8cf5xNSHdi6mX41smK4WbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmhhxJ+OdJEllJ/0y5r5CYfbvxwRDqLbmzb4GD8e7Jr23loAJ
	FrCR3MxXiRl4iM8aBPLkmzPevkwwGMlhSPGPzcWqRlbHjALtBOAS1ywng6P7Ez4EWs+Ej/4ml5T
	JejkzlH7lqTFxH4N+0cCdSXeChqLRGMYou6+TlhQJphyMs4tRiABxOj0iVYoPmTRL3v0=
X-Gm-Gg: ASbGncv6bV/+iLBmWmJz9sjb0nli3rUJBlvm5+vuezONOaXcOLrzZYJ4ZP/BBgt3kZv
	1RvQvDsw/bS53O0AOEBlZIT4G6AOiIjjyYoa4ej1GKKMQZeAko59pkb683F+gp4fi0Qv/s1S7Pl
	j+wQk92ZrupQmXVukOf/WkE1x3pdLMeZYa4E8Gz/8vwd6QvC2IGzPrjPmeBWKwbV0KDbN9po3Se
	Sp3tgkGvGHMwog6Ak1abV8TjuRKSccWi07w4kn7WzA7egrsEHrIEUe6Qo0CiSbX9LUwGuZ2AXKC
	ESD6Fu/RHwkZcwSNkSC1HwBeRPDgdMlD5Rt58sRqYOtaHyAeWjF5TKrNBn39RVa70IznAuWwYw4
	B+Q==
X-Received: by 2002:a17:903:b50:b0:240:1831:eeeb with SMTP id d9443c01a7336-2401831f1f9mr77116995ad.40.1753758903595;
        Mon, 28 Jul 2025 20:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3+knxDm31O2rClWjozM3+CecgvNZoNp+cf6nrVr5Lm6XqDELyjYKUNByBB9MayBRtK3ee3Q==
X-Received: by 2002:a17:903:b50:b0:240:1831:eeeb with SMTP id d9443c01a7336-2401831f1f9mr77116615ad.40.1753758903134;
        Mon, 28 Jul 2025 20:15:03 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.228.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffdea35d1sm44404645ad.28.2025.07.28.20.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 20:15:02 -0700 (PDT)
Message-ID: <9b9c4572-9afd-f77e-07ea-ad1673feee47@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 08:44:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
 <2d672126-ca4d-411e-89cd-f40f8d8a4f5e@oss.qualcomm.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <2d672126-ca4d-411e-89cd-f40f8d8a4f5e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAyMyBTYWx0ZWRfXzHQ2QIJbwZFz
 48C5idIEYacoIlyzKxxe8bg1Y49qZO6L/rdKkvM0eeSSXbGvWQX8LQtqsmH4DMHlfnI+7F8vaiX
 U6/iOLjcRBK71BPsaiy+XxopA75xaSiXu+zhY/GpzHBVH2PdPZNCWPsPUkGBTAGp9fVCxOMsFOy
 HGIc6aF0ySAMnyu/8dncK9EoX3E0c36w4todSotXe64mpRufi8wo1f02zg/NSB9DsXgubC6E4aU
 4nO65HhUIJ9Rbcmj4eaQUZWwuwP5TaT4irwEyTqdDa6p9kqVW4kVthaZb3a5Mg9IebN7c6w+Go/
 x3xG+M+QL0GvRnorNVK7ridE6dgd2/Ak+p/E543cl0C/f2s9klVy/8Jyp7KM3JSK1ybmOQ//boL
 qA2OauNydUhgvIz10p9dIs1f+q919h2UrM0gyJ82mFwR+wnuVRt8sJhyFx8EADhPpW9Xyw/Q
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=68883cb8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=URdbDvd2+uEZUUOZgz/1Vw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=jnCx6B5Jve7-ZDeCMK0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 6grIbtlrV7E9LKCV2cKfM-vYeGL2lDa8
X-Proofpoint-GUID: 6grIbtlrV7E9LKCV2cKfM-vYeGL2lDa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=740 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290023



On 7/28/2025 11:59 PM, Dmitry Baryshkov wrote:
> On 28/07/2025 18:54, Shivendra Pratap wrote:
>>
>>
>> On 7/28/2025 5:53 PM, Krzysztof Kozlowski wrote:
>>> On 28/07/2025 14:03, Dmitry Baryshkov wrote:
>>>>>
>>>>>> and the reboot-mode is defined in the
>>>>>> previous patch. So, I'd assume, the path is defined.
>>>>>
>>>>> As I said, path is not. only psci/reboot-mode is.
>>>>
>>>> Do we have an _actual_ use case where PSCI node is not at at root node?
>>>
>>> Yes, many cases, because it belongs as well to firmware node.
>>>
>>>> If not, it's obviously a deficiency of the schema. Could you please
>>>> provide suggestions on how to describe that in DT schema?
>>>
>>> I do not see deficiency. There is no ABI that psci must be root node, so
>>> there is no issue to fix there.
>>>
>>> If you want to add such ABI, I will answer: no, don't, because we do not
>>> want paths or node names to be the ABI.
>>>
>>> Compatible is the ABI.
>> Will define a compatible for psci->reboot-mode node and use it to find the
>> node. Hope its fine to define a compatible for reboot-mode which is defined
>> as a property inside psci?
> 
> I think it was more about finding the PSCI node.
can either find for psci node using psci compatible "arm,psci-1.0". And then
look for reboot-mode node inside psci.
or can directly define a compatible for reboot-mode and find it using compatible.
Is there any other suggestion to find this node? 
> 
>>
>> thanks.
>>>
>>> Best regards,
>>> Krzysztof
> 
> 

