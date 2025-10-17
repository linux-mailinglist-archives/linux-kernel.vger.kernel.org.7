Return-Path: <linux-kernel+bounces-857455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB175BE6DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A393563539
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F18310783;
	Fri, 17 Oct 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WgTFadsG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD42FA0DB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684148; cv=none; b=u7aEN5japrnk6uw0ICT3vxAAsxBQg5LtYfyYQkcL/sde4Y/a9nQCMxV9qsM3Ia/tZ0QupyBqZLdSkwoTiPm0Xh+VDoitzWp3tqVtVVry+Hm7Ac2W+u0r6kk3eVrzIIYey4Q7ee7kah2AE55ZIUbr5sG+XDh4mCSSJzcrw+A0PB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684148; c=relaxed/simple;
	bh=1d+oU1x9vUW6ue2spoFKr4PZzm0efWoIompDGmuEOTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSikd8gH7YAN+VbwTpg57VLSO6tEW/0q0dpIuDvtkY5X0oBDuF9iPMS/kvWZXwa0xg11qN4a7Gq8r7wO/yVlI34l+dDa1yCamytb+ztQwPLI/op0KExJg90SmR7wOffWDNSXieE69WwYQSTLK1x0Lrjyzi3jPXqUiShzec1QOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WgTFadsG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLXRL022336
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kiSYgOYyxORB21Hsjal1suikR0J5W+ut2yxpevDfr4k=; b=WgTFadsGuoE0ISRb
	R6IP8bq2JghLey8v6+EmBsFhexvICq6PZDTzdy5dCDWMrWO3ufHVxTmHv8wf8E5r
	tP/IJ+Aq7aRXmLGeGRT5sGwqeTYvQNAE34hkmQVB/leI53E1Oi8ge9/S/3UgjMW1
	hwJ0Et99UAZcdXG+NddvHbfI4l75AQchr/jPi1yIFOenWMUROV7uE+c7gOSseOJZ
	pq0RIfQsoPW94BOK0ohYep6kaxOH82B78d4/9AR10HsvomdPulC23JN+fWQZocml
	dMcsDf7aEI6gDrKBmRALY2wrbeQigfuNhk3RbkOd7xaNakaHPd/rn6uS3EyiKln2
	r4XV1Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtg54a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:55:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso2538076a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760684144; x=1761288944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiSYgOYyxORB21Hsjal1suikR0J5W+ut2yxpevDfr4k=;
        b=pXDOBoCbiiAKwMIrE6HXCJhiT5Hi3J1hAEkxXtJ5Kyl++CQm6aSa/tS7nr7FdOSFty
         nXMTvUTe3rQxfTJ0SWd1M9PAUUxKyPYBW6bqoEkA7k+QhkQV6GmKuBMWeP6olbrBjt9Z
         YkajrnOZYLoSXUiCMhlNmOiT3ULpQanfrHyb+Wd4BMKJxwCPOGmPBPrbUOm0PfmxOocU
         iHjkBxAGy+craOmjd5c5VuoHgLQMYjOCLVRqPSthuo5IMHNLdj8QSW/EeuuA4k5F97wk
         Iv7nm2fsbr43qK68/Kt/cLc4mzUZ9lUKzigHcPIyhbCNpLBDKYm4KWvIwopzbv0ZOlPa
         ZFmg==
X-Forwarded-Encrypted: i=1; AJvYcCWveZEIjFRCl3hKNkAgzSOz6d3E/9NDtWtVrHGSE+vGBbsOu6JGDtrqsFsmIAY9ZC34XwNThSss4I7mS10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gxz3zcMN5omOW7yTxOsavW5E7fSrADAYSN0K5uueOGE4bBu5
	S3Ftx4jMsY7TfxgSCJH0dBE4gOgoBhmUmushTq8iaIWRh+fCU9aqfEZpVVsfHVtCDI2BRnzD2Ga
	l14jzoduqmQO4Xjybh+yS1GRMkts0F/A2upTqXwHOGSPhJqjxqcCdGlP2sVAjZg8F5D5lGZLpbj
	E=
X-Gm-Gg: ASbGnct+jZb1WeWPvZhcNKrfZJrGU0YRRrqfPckCxceMy6UPQe8G1Dd0F8ayiflsJJH
	ZQBISfoxYhISmu/YUIMoNG2/90WTB7xq/oOIeudRJ9Jtn9hWRJoskhU+/WWKnNAx6QLXdvLDEvd
	lA8RQXX7mnPdlqmxc6RXPyrwuz5xoBiG28QZmgp32WudE0g3T8KxiBatA0WjClOkZiTojuvt9uo
	6zsSoTIaP2Ntxoa8LQCp+y2Ar1FunlpATElcxGMZ43MVXae2u21Zd+mV5GSNrfPtuPunqqdIgqh
	76pUVVVBVlFtK2EYpEHw+jfyYuiRch2DA7Lc/4sji3OHszLN4YDB2WWQlu1hxjnI983iJAFQsN/
	bzJnYR6R9o4IA8L0epPqCYNbUgwA=
X-Received: by 2002:a17:90b:4f86:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-33bcf91484bmr3018985a91.27.1760684144354;
        Thu, 16 Oct 2025 23:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrVqE4VqHRm9X5wx6ye+bJw2WGJ/5rkO3f3lcbWBpW0rM4dLNgJ4WrcSqwVApIqA9T7TXt5A==
X-Received: by 2002:a17:90b:4f86:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-33bcf91484bmr3018954a91.27.1760684143928;
        Thu, 16 Oct 2025 23:55:43 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22b9af2asm4949701a12.28.2025.10.16.23.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:55:42 -0700 (PDT)
Message-ID: <c4c907cd-ac5b-4ddc-96d4-aee840d98692@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 12:25:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_SM_TCSRCC_8750 from m to
 y
To: Krzysztof Kozlowski <krzk@kernel.org>, Taniya Das
 <quic_tdas@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
References: <20251017-update_defconfig_tcsrcc_sm8750-v1-1-34b1b47a0bda@oss.qualcomm.com>
 <30390038-0f90-48a4-befe-475cf88ba1fb@kernel.org>
 <37f54b76-a274-4ce2-aaa9-88ba0eb84199@oss.qualcomm.com>
 <90c8dda3-f753-43dc-8bb9-d03a808c8704@kernel.org>
 <38b8468f-5006-46a3-a4ea-28e6692ef14a@quicinc.com>
 <03ac36fb-a227-438e-bdf6-f787e26008b3@kernel.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <03ac36fb-a227-438e-bdf6-f787e26008b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ACey2wdIroa2VzTLuicoHZKoeOXgq25K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX4+YR9G6L0RmB
 PFIKQR3iB/a6LawWxiLqL78tF0+msekrVasm/Ygj/X2eXK5kN0GJsIeDlMYoPrDnTfS0q9esPEA
 fOHOv7MADiKS92siIRL5mDHPD/cBorvDAciojjJWouQnizLZq5WqllKcjZ3oXLrrswrmdauF1mH
 d6TK+bf6YSxP8uwNt3dlHFD4ALWPZsFy0dzru6qBbXN26UW0De/rCyvrwSBLq0Medh/33nfbhis
 MIasyakphseT5H70iFpBZs7PfYwg1PBTUjDm8KnOVBOMa5t06ceNVBL1Znqsx1zvmLym5oLu7Of
 jhrheDZo6xCAdr7qYpEGZU7BAcLvP0u4lD0WY7KI0smPVqj/SfI6e4FSA/IL6ZcJQGHZQYQUUQG
 PfDldhoFl2QJ65K1lA8dcwAlIrgSig==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f1e871 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dklrOZhk_xOpRdAJBjUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: ACey2wdIroa2VzTLuicoHZKoeOXgq25K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022



On 10/17/2025 11:26 AM, Krzysztof Kozlowski wrote:
> On 17/10/2025 07:49, Taniya Das wrote:
>>
>>
>> On 10/17/2025 10:51 AM, Krzysztof Kozlowski wrote:
>>> On 17/10/2025 07:16, Taniya Das wrote:
>>>>
>>>>
>>>> On 10/17/2025 10:00 AM, Krzysztof Kozlowski wrote:
>>>>> On 16/10/2025 20:53, Taniya Das wrote:
>>>>>> The TCSR clock controller is required  during boot to provide the ref
>>>>>> clocks to the UFS controller. Setting CONFIG_SM_TCSRCC_8750 to y ensures
>>>>>> the UFS driver successfully probe and initialize the device.
>>>>>>
>>>>>> Without this change, the UFS subsystem fails to mount as a usable file
>>>>>> system during boot.
>>>>>
>>>>>
>>>>> That's not what I observed. UFS works fine, especially that it is a
>>>>> module, so no, this is not a desired change and explanation is not only
>>>>> insufficient but actually incorrect.
>>>>>
>>>>
>>>> Krzysztof, on Pakala MTP we are observing the below issue and it
>>>> requires the module of tscrcc to be loaded explicitly. This patch also
>>>> aligns to how it is on all other targets.
>>>>
>>>> /soc@0/phy@1d80000: Failed to get clk index: 2 ret: -517
>>>> [   10.496570] ufshcd-qcom 1d84000.ufs: freq-table-hz property not specified
>>>> [   10.503660] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
>>>> find vdd-hba-supply regulator, assuming enabled
>>>> [   10.514548] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
>>>> find vccq2-supply regulator, assuming enabled
>>>> [   10.565955] platform 1d80000.phy: deferred probe pending: (reason
>>>> unknown)
>>>> [   10.573078] platform 1d84000.ufs: deferred probe pending:
>>>> ufshcd-qcom: ufshcd_pltfrm_init() failed
>>>>
>>>
>>>
>>> I don't and I am testing regularly, so I assume you have incorrect
>>> config. Maybe I have incorrect one (which works), but then commit msg is
>>> incomplete - you must explain the bug and provide proof that this is the
>>> correct fix for it.
>>>
>>
>> We have tried booting up recently and and that is what we observed. The
>> patch from 'm' to 'y' helps the UFS probe is successful and the rootfs
>> is picked from ufs partitions. I will add these fail & success log
>> snippets in the commit text.
> 
> That's not enough. You need to explain why UFS fails. After explaining
> this, I guess bug in UFS would be exposed thus that one should be fixed.
> You just provided band-aid without fixing the real problem.
> 

When the kernel commandline uses is 'root=PARTLABEL=system', the  is a
dependency of the UFS driver on the TCSRCC clockref during bootup and
the TCSRCC made as a module will not provide the clocks unless we
explicitly load the modules. To meet this dependency we need to load
TCSRCC statically and move CONFIG_SM_TCSRCC_8750 from 'm' to 'y.
This will help the UFS partitions to be identified and then the rootfs
to be mounted from the partitions.

> NAK
> 
>>
>> [    0.000000] Machine model: Qualcomm Technologies, Inc. SM8750 MTP
>> ....
>> [    3.133373] ufshcd-qcom 1d84000.ufs: freq-table-hz property not specified
>> [    3.144480] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
>> find vdd-hba-supply regulator, assuming enabled
>> [    3.144585] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
>> find vccq2-supply regulator, assuming enabled
>> [    3.227770] ufshcd-qcom 1d84000.ufs: Resource ufs_mem not provided
>> [    3.238319] ufshcd-qcom 1d84000.ufs: MCQ mode is disabled, err=-19
> 
> 
> 
> Best regards,
> Krzysztof

-- 
Thanks,
Taniya Das


