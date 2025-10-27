Return-Path: <linux-kernel+bounces-871381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17CEC0D13A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF543A7ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6B2F90CD;
	Mon, 27 Oct 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLQKwzDy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6982F99A3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563481; cv=none; b=TSmiq0cz6gii+TMmv0Ls83GhcWWqdEHXAEoTJtxCDKh4Lq7wFiSpC721jr26R91T1GQYwTPJF3mySorNBF6e9Q2sumLtnr+2yt28P778aPkQIv8oEXihbeBGreiVhHgZtA8l+iAbXpag8XAANy8rh/AB0gkEWlZzXF4AaLxivoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563481; c=relaxed/simple;
	bh=bosUVrTONnDS0EFFq+LVcW6EHq4uQ/rImZGCuc59Vpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtkbFY8XGK1dUN8/u8sYRWHlSz4X5g992T7rxkg1vZtLyJ2vAD8y/RmnSeAI0gDtRIivPBKtcU29ibfUnnnuVVzW5Sa/trang9AyoTRUXjM6/pWbY9Enusz2nc5iDAmnrHs1iMPo2R2tauavlNcFDkwMBMNj0F2Dd4RY4UXRhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLQKwzDy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8MYVO783388
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H8WIQT23Q8Zg1BnAz2MWS0UE2kbwz+Q6IEFFa9VNqtA=; b=mLQKwzDyym9IA/DT
	sZZ0SGXb2BUHepEZibF2ZId8fduvszNKie29iwh/sBpQV7ZWCEnCGvIcrWzJBKIM
	HzoJPzC0XIDWKCxohVolVRMjPU12qbLhaYsdxHJFLmNSG3y1XjAJ4cceVK0Eorvt
	JccgRWzlhAU2b2Pc0x3PhQWzUNuA97PJXc+tcSQwbPJfykjXBf0es83C9Tmhtppn
	r5T+VaXR1Hjt2oyR5X/7pWSNXhp+6hxatZnAUL3ZWssHJrfGo8VpSx/8CNzX/jWR
	3IccZfaHG3fgu1sAvhqjPl3JU0Z6jGoNm9aiLPCgxipJCEImU1/NuvaneqQ75d4W
	M/E4+A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g4ama-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:11:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87dfd456d01so13895616d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761563478; x=1762168278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8WIQT23Q8Zg1BnAz2MWS0UE2kbwz+Q6IEFFa9VNqtA=;
        b=s8px5x77LYmVfOZ6WE08V8ODpU+o4C3EcB+dLHGRjuhLfA8qWGFO9fhVttpnVWuQQ1
         e2kZoSkfC4QKG/ntmaOxAGrVX+TuimaJssrQLzKd+mWBZGwX99+J5ZiIZ0JMQ4nI++kJ
         uoFxaUniNpFfsaLg5k6y1AHqvnd4rLuOeEPmoWaQTM9Z4ezQqFTQWY+Pt6chVX/LEoPJ
         hvTy3sIP4hPI3yEVI8yktZbiN2hjeQ3uQ21HO7z0N1wMIR36yhIGXAmTHtZEkkOpbYW7
         9fqnSosP9VGok8N7Nzhfi6dgHUQUkRdxtm0NB3MGu9xYLK+hw1hutJ1jhVmeQ6xyrkGT
         cS2w==
X-Forwarded-Encrypted: i=1; AJvYcCWGFVZlQ4hZwvoih88kA8+NVi7EIi6QiMq5XB/Gu51wK6KnVEvx5AWyMP93SneRav6jFZJ4yu2rP9FKsTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIHGB8tcCBoBOzF1anBHJhbYNelE0uaCetAz7eopC3F0kNdk7
	N5DxcZl9fvKXyIiQ3ffVBmCWskJtr2rXQxUjlq+E7srfOqGE9eFCbij8IC3nJa0aViwHzjOoYbj
	QbZN+kY5Y/geIpXp6l/Ty5PYt4meE3CtfXnhMEbDNANSn4dwQUVRE1CY0yFkXxv3VxUJdwf2bRs
	M=
X-Gm-Gg: ASbGnct5TVq8oSP0pj4JNgVKj94e/GGLxcrmKqrq1AFnoCL9ZNb6w0razAGwpdIl6k9
	h3nB7JA9euwDmrzbmJemQmgsqAqNYpAvQxNtAk/JkCo/jajoaoXaSDh4VKSmGVl37joRcBTpIz2
	GBS1FXz12rxnM1OnG+fEmx1D0kpogyDgcqeqbA2IiTBqw2g76We6VLYz+VXs1R1Huuj1LWmDYSE
	pMg29cVPvWEWu1mFvCI87FOINKWkYTgu2hL2qOWlHE88wR9pfhzCwI/6ij9/a9Q/4msXyBsYkti
	wH9lhfbDie2WvjRXaw8KctDjaO/Ko3GtlI3Ilxcx3k2Bo2ulH6e612WLULDm/u6R6MPsKjre13L
	OLOhZ5haPWCscs4QBg3WSf1pHZ90eZRAoX8JCeG59/XzwG1/AISMP/L+U
X-Received: by 2002:ac8:5704:0:b0:4ec:eef1:52f7 with SMTP id d75a77b69052e-4eceef16c1emr45626191cf.11.1761563474254;
        Mon, 27 Oct 2025 04:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp0McDYH82cpews6krOwb1okYKKV12xKV/8IeClVI/HE450oM4Yo+OS37OfzZ2SELE5qFANQ==
X-Received: by 2002:ac8:5704:0:b0:4ec:eef1:52f7 with SMTP id d75a77b69052e-4eceef16c1emr45625791cf.11.1761563473633;
        Mon, 27 Oct 2025 04:11:13 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef833besm5896053a12.15.2025.10.27.04.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:11:13 -0700 (PDT)
Message-ID: <e4f33bf0-05d9-4aad-b00e-fb7cc2c2633b@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 12:11:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qualcomm: m31-eusb2: Add runtime pm ops
To: Prashanth K <prashanth.k@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251027062458.1411096-1-prashanth.k@oss.qualcomm.com>
 <daf0055b-7caf-4ace-8a06-071468273a37@oss.qualcomm.com>
 <1c52e759-15fd-462b-a9fd-ad620da099f5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1c52e759-15fd-462b-a9fd-ad620da099f5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ui3O713eZBWOIil4QSNzEl1ZFrCIPMSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwNCBTYWx0ZWRfX4FsJzZ4V/yI2
 O0fDLqf4Sv20WNgCYWSy3l81EdUkzn9ShojL/oEDQLeBfxz8Nlz3PWvBpraBuZIddZNEtVb/4K8
 m3zw0vu6HXhrgHDZB0zHNGmcEoUMOb3DhTrNHNOHDu//ubt8EXGa/ciZ2K0EkL/cJJhtkg53R1Y
 hwDzmW9XkudWS2NacZf9pRianqW2Z8VYSs8qko3LRV3SAJK+R99PqeRDD0GPQxKnmzFejE16PF9
 I42ziWeKfTB/VAQ/J1rQd7ZiSWMBx2tLnDwfbEz4f+8Wd+JJUUG3FV5fJEF7K+RErcyx95T64io
 AaaK1z1+FwwzqpJmgA84jojCa3k0KAz89lIQSIErPIdrkP6p1pSZNKEtJqf8/4ilEFT7MzhsCoW
 v9Xp4h289NbVeDd33fv8RjgEoEn6jw==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68ff5356 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TkFh0mFV8F8mC-raymcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: ui3O713eZBWOIil4QSNzEl1ZFrCIPMSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270104

On 10/27/25 12:09 PM, Prashanth K wrote:
> 
> 
> On 10/27/2025 1:55 PM, Konrad Dybcio wrote:
>> On 10/27/25 7:24 AM, Prashanth K wrote:
>>> Add runtime power management operation callbacks for M31 EUSB2 PHY.
>>> Enable/disable the clocks based on the runtime suspend/resume calls.
>>>
>>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>>  static int m31eusb2_phy_probe(struct platform_device *pdev)
>>>  {
>>>  	struct phy_provider *phy_provider;
>>> @@ -270,6 +298,17 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
>>>  		return dev_err_probe(dev, PTR_ERR(phy->clk),
>>>  				     "failed to get clk\n");
>>>  
>>> +	dev_set_drvdata(dev, phy);
>>> +	pm_runtime_set_active(dev);
>>> +	pm_runtime_enable(dev);
>>> +
>>> +	/*
>>> +	 * Prevent runtime pm from being ON by default. Users can enable
>>> +	 * it using power/control in sysfs.
>>> +	 */
>>> +	pm_runtime_forbid(dev);
>>
>> This screams "this patch is broken" or "there are bad issues" which
>> you did not describe at all.
>>
>> Konrad
> 
> Hi Konrad, I was followed the same sequence from other phy drivers
> containing pm_ops. I assume the runtime_forbid is added to control
> runtime pm from userspace.

Other drivers call runtime_forbid() because the implementation doesn't
work.. Or at least historically the usb3 part hasn't been able to sus/
res properly

Konrad

