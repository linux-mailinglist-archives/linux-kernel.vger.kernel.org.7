Return-Path: <linux-kernel+bounces-873636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90015C14502
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CE34508B27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDEC304BD6;
	Tue, 28 Oct 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYXB6v26"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B9302150
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649914; cv=none; b=UCNREFDyNqSpF3bLBTX1RxQDtcykJxLO4eI5JK5oYd912yriOv2WTVXy2hb1rOdlfnh9NQdbYqMamWnC7YJzxUexDwQQpAr7YdsBT49gkARMkcxtZhopjxHQ0jThm3EMWAziRpLEeiYR7uMWpHz7MGuwt3M+Q5o0CUipCQfSEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649914; c=relaxed/simple;
	bh=tluPsZgS0AbUxys4VSNz7xRC3nOxi4aNyCC+IC+2QeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reOzdN8ObGRm1G5yhgjoCKr0lU5KN2U/sVAACDTMjmPWnow5RaDyjbY9GgxSKTnfd/o5t/zYtMSIZU8SdD/O4aeuG5r7CAz+O+0VwrfnLVivuZewpOBB9FWKKW9V5czfMN6Q1zJXoWd86BCyLoyaQN1OPUs2ixalukISTNDNvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYXB6v26; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S8jeS52881678
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	opUtdQf4QfMq9eW5ijzGVRszcOjE71sRMPdyYjws57U=; b=RYXB6v26+vYPhlCW
	KKF4VCCEITpKOLNrnI1gTw4AV5aIiQj+sirAXsZ6mD8RPXAPXPeQY4FOrCfaSD8h
	ICKkft255d0UpDS7qABN2w8koXf3skvpcuw6repqcQwO3Flc+ueYVJIwhp6O4/o2
	W2bdn2mWWlNQh/bQfAa6W3gj2NDNfLMN2jwYsJKwB+kVPXa7+HgMtjnUM/Cm3L3k
	WjHzTscfOSpnQUy9NvZIQDIzCcx7wniuBZZ0psIt8SBdmYNSkWCAq/ekd1fmUouW
	ucgzIp24JLig6RQeoy8gOK7zSChbzE9rHeIwxxOyL/ZY6PkqV1F+BlUM56/kdRUu
	NaDdVw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29uhbjut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:11:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a28ccb4c8aso2683856b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649911; x=1762254711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opUtdQf4QfMq9eW5ijzGVRszcOjE71sRMPdyYjws57U=;
        b=DM60dHozlSbyG54LxYb00KPbk7+S4uUM98+T4Fd/rRygShQ5HA/p49tfcZGeZWSDvV
         AqwNinMzDXmTvxXxXSHi/hmbcs0BolQSUQRnZw7GzlAoa+HtM7T553DUkxxjjrVmwx8T
         5rE9r9H9ILPLmnXhB22t2fk01XkNp/vjojJ5OAiVh5PvERwfoTkmRzPCFxi2JjtJ0MU6
         jw6Mz4P/cM6BY1H2jVMv2Cwro/7Pr9sWDoy0paIW3cV+xu7KFf3h/rDl+CIEtAYrMMJ5
         nMoIFn5kPI1rNBN/nZU1Bjxh/y+YLIxYQwblu2E9Pg5n3Y6HjpUqnQPecctRbyR4kAQH
         /RYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIAymG8Yp4WIHIG2LytQ0wJPbRtFDv7mm6PjbkQmhy2jgnXwPtSDqs4JpcdooKKUUJOh9bUBFfYSbTDws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zMmX/iu14xzP+JWZ3fIz5H74NZLP4oZpDbvtSKwtD9tQGU+R
	Dy0E6lTpeu+bG5LbG/ANX43z7MJDd3OmZtCbVk/cY2DM0mqBfaXfsN/UNqooV6iLomkic7ioOmk
	ORzt2cplHXNsVFL1stwwcMH1WkcNBVYNxVEpsEnb7tDrT3xxyYXxiiew7zisHzs5/qM/NuhVQ+W
	Q=
X-Gm-Gg: ASbGnct7buvHkFHsNkxpb9i20gH4UlSddYx3oKjuUD6DxE688S77ojF2gj3tFf/yLKx
	mTLstNeQ7bIS+95+DFPKIDjhggbj3NHC4CB9GU/EkzfpkFsz0tyEh/eMIYupUfTeaD+FhRDNq52
	HZiEmKwiEngCf6PCOFXkGtDY87uFf/cMzFEpJcgq+wM/g9iHrv9Tx81lM7QAiS5W/Dz+bVR/gEi
	pZAmF34k0CHQFQEaFhmka9QSruGWEKRmEdslos10crN0vkCyFC1R9VU7l5I7g2BZIA8aa9ood2B
	8OXWz3UdimjhqinkUfgCuoUCwM/zLdjrhkH/m2Q9ApoPmNCO/yKWig7+ZKbU4T8Ozd8DN0kwTqE
	FeOY29VkC5XFGmFlBmwvtr5I9K0k=
X-Received: by 2002:a05:6a20:9389:b0:334:a681:389c with SMTP id adf61e73a8af0-344d1e9d6f7mr4082416637.15.1761649911248;
        Tue, 28 Oct 2025 04:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEir10gLmpuIQM7ApflZtUrLLZhaDCqOjyulYgaRdAjRBHf/P6MEgnu6ky/ldUcH5shRkkc9A==
X-Received: by 2002:a05:6a20:9389:b0:334:a681:389c with SMTP id adf61e73a8af0-344d1e9d6f7mr4082378637.15.1761649910755;
        Tue, 28 Oct 2025 04:11:50 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712791576dsm10053265a12.12.2025.10.28.04.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:11:49 -0700 (PDT)
Message-ID: <17995927-b7fb-458a-a863-b03bd15e6073@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:41:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qualcomm: m31-eusb2: Add runtime pm ops
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251027062458.1411096-1-prashanth.k@oss.qualcomm.com>
 <daf0055b-7caf-4ace-8a06-071468273a37@oss.qualcomm.com>
 <1c52e759-15fd-462b-a9fd-ad620da099f5@oss.qualcomm.com>
 <e4f33bf0-05d9-4aad-b00e-fb7cc2c2633b@oss.qualcomm.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <e4f33bf0-05d9-4aad-b00e-fb7cc2c2633b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aQmT6uX0gJuHbMOEiwa6bJ7b2ECNwBDb
X-Proofpoint-GUID: aQmT6uX0gJuHbMOEiwa6bJ7b2ECNwBDb
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=6900a4f8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_xMILRQ3MvDrwl_WGjgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5NSBTYWx0ZWRfX+yIi+eXdcKHL
 1GtRhgkgBP5Y7Q7g4NF9+dZd4Nx+RuitUMW4vJs+SmsxDdeTRh8WU7SRFx0Mmwz9QA98eaMztj/
 18KNwWbP4nhR5+XtqC5N/q7e01n5LxNsIsw+4D7360+D/JE71B723ZpdoH4vHuAsVcx4kyhTuBT
 P57Poud1A8rs+S5RbQiN3pvfqfvs10ApKTiG0tWCd7hcLqRHyJGRB3a2VKaU2hgv/m4uKkCC415
 5/PJ1HHJKv2dsj0ULCoWP2qCvT1hAYjpbwig2zzMTngNP/PzsjYq8EF646Tl3uPH4xB0BcNKaJX
 ACRmvaWGRHlsCUbDXUaCGr0KgbsoqJbqIOWkgNGZ1erCpXhoFm71soAVM1Um9Mc2Y2yMLxpx0Kl
 k5wGQJdxSTcsfMGXWwBFWQ3Obct5Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280095



On 10/27/2025 4:41 PM, Konrad Dybcio wrote:
> On 10/27/25 12:09 PM, Prashanth K wrote:
>>
>>
>> On 10/27/2025 1:55 PM, Konrad Dybcio wrote:
>>> On 10/27/25 7:24 AM, Prashanth K wrote:
>>>> Add runtime power management operation callbacks for M31 EUSB2 PHY.
>>>> Enable/disable the clocks based on the runtime suspend/resume calls.
>>>>
>>>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>>  static int m31eusb2_phy_probe(struct platform_device *pdev)
>>>>  {
>>>>  	struct phy_provider *phy_provider;
>>>> @@ -270,6 +298,17 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
>>>>  		return dev_err_probe(dev, PTR_ERR(phy->clk),
>>>>  				     "failed to get clk\n");
>>>>  
>>>> +	dev_set_drvdata(dev, phy);
>>>> +	pm_runtime_set_active(dev);
>>>> +	pm_runtime_enable(dev);
>>>> +
>>>> +	/*
>>>> +	 * Prevent runtime pm from being ON by default. Users can enable
>>>> +	 * it using power/control in sysfs.
>>>> +	 */
>>>> +	pm_runtime_forbid(dev);
>>>
>>> This screams "this patch is broken" or "there are bad issues" which
>>> you did not describe at all.
>>>
>>> Konrad
>>
>> Hi Konrad, I was followed the same sequence from other phy drivers
>> containing pm_ops. I assume the runtime_forbid is added to control
>> runtime pm from userspace.
> 
> Other drivers call runtime_forbid() because the implementation doesn't
> work.. Or at least historically the usb3 part hasn't been able to sus/
> res properly
> 
> Konrad

Sure, I'll remove the runtime_forbid call and send v2. Let me know if
there's anything else.

Thanks in advance,
Prashanth K

