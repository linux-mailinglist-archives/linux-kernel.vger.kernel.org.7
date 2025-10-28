Return-Path: <linux-kernel+bounces-873033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BFAC12E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B45878EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF1726CE3F;
	Tue, 28 Oct 2025 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3fhVUfP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86BC1F4C8E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761626971; cv=none; b=NB/sLnHCsWcdMd28+gluxeE1+qYCX32WffF9u8N2V22sNmp0FORmNW+8ZJq64rNDUtpG/FY+qvfcEjsgTKlrQ88xljIKeIB/dDcDdiqPfwCQnL3yiTp2cobCIgoNyo5VaxFxBtlrDbN/8EKxl1rGF4ItKVY4iEemqwAFt8kPdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761626971; c=relaxed/simple;
	bh=XV7WU5zibZsJ+ZnEyeKr2n+YJVbN5IbMnAsV95YPJu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/VvW3pkAa7t0BlF5YJ3Kz8xUXMEMyuCzq4GqtuBBdPB/i3XjsljVyA1S+C0T3LGbcuMDk815Id7pz+ZXfPndcw7c73jQKlDqm83pSdT5kcO9WH/ugAjx0TlQKvKxBXUAxFHkMDfAayNrgIzTWYtm4NNtvHaJNoCkeoVamKfmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3fhVUfP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RNSZgQ2881887
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XuTBvjuiQOVwjZgQUe9fy1G+EeVQei0mWGOYbzBeS1c=; b=B3fhVUfPCGKJ5Nt9
	z6YktbPuyDJQfGnyV+6K8bVcFjfL1ykH9Ir+r/7cdmtpF7GjPTgMaVK5XSclE3rn
	MlkAzOlk/UnzxW3OZ6s3HiRCMlkh+OjYqmyoqXI4Nsbyr08Mh1vFv6H0Bd+GffdV
	r3cynpTOd1kkeEd0cxHe867pPpIvPYhq9pH3gmNioD/P+HTIbPfhaQzQZG1fRuQo
	IjsSQedFsjUgNcy0K68CcqEOt+32Jab/UowK+ffjshpNmjzYjSowPaaBy22o+YNR
	q4JJ1BUSqnyvI3I+1FhBDmmypNAwpMartG5qqs6lk2jR11GUbnTHCeDa2mZTEYZj
	DbaiMA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29uhaefg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:49:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b60992e3b27so4087279a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761626968; x=1762231768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuTBvjuiQOVwjZgQUe9fy1G+EeVQei0mWGOYbzBeS1c=;
        b=cWEXzcdDUbBlKKwHicCFw5SFawI9eiA6iP2ZSvPvHXY7XpBIa2iFk5wYkJ9eqS8LTj
         yBdNdP7m5Oxlh31H242KH5U1/HzdQFPnr5c4gOtAtGNaur61WxJKklHDPegLMTIX+WRd
         BzV7j8ieUDtgp6RBw/LuOEf3QZAaOliMHO/dhJWJL/UxHOBpO4UcNj387OeguuHCijNa
         L1pxBdnvlbfaVfXwoF+6t0u4Dwt44wyVco3zJVRTXfZpGxXhAVXyuIyaKjAm1MoYuxlw
         SakaPcPbMyaHZrYJw4m6Gfrd4/rrw/hTf53zt2WMLC4Tvyl2HuizgZCl51E6iA32WyNT
         liRg==
X-Forwarded-Encrypted: i=1; AJvYcCUqDolzmZfLoe5f04HPGwSXMCX2S8Rb4MakuF8qwSuYbppyHIOwuOBxyIYm28ILg2o3mfuakW5P8X35nuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxap2L17bsqpBIaG2C7bnM342uKS0SDor27Jnwq4nHF+G0P+KFt
	VOMAsHxyUaHfOImMlCCJshHOH1VXRG9UrLLlqTa1PsTacwBXpjCyl4QFX2NTNG962flDpDKuyVZ
	InCwCPvxA/28YBfNgYI7OnXqXZc/zWLHd0/HIhbHzPX+q/OS6QKvn9M310XWLlo1yMQs=
X-Gm-Gg: ASbGncvVa2YFu471TCBFOCiFMnRoJ1g2lZPJV6lemezZd9d7j8A2oUAxYPrLCIqpNH3
	LhunSOzTX0ibTpjxj8bxQz6I2FPvyOvU9K9+XvA4vitPnaRTp4j7zdHbiWgjrqVl7UYbhaj+n4N
	lre4LqIfCRYvikNfmCg/oJPLkqEtIe5fqtDhOI3bbbikgOnsFCcKRwdMHrqhVN1cux5Dk1SHPXk
	O1nEaHD/KEFvJlz8eHf4Oaycb5vOvGGAmz5d1mgK7rGEDynkO6mw7npnZaea1IiH6XMRlK8JcOi
	/lBECUlH6U1vwLU43Cnb55Pyh76JHbsLuAbAdHworz3qMGm2RSBwmoh1yfjfeCEwflzHGBBFm7P
	+/GuETls+hWHV+MYJeFs8NQ==
X-Received: by 2002:a17:902:c411:b0:261:1521:17a8 with SMTP id d9443c01a7336-294cb394731mr29305925ad.16.1761626968257;
        Mon, 27 Oct 2025 21:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfBO+WViq1JrCOzNCETVspcIjJUNeP8Juh1Xcs//lqcn1/LiJjXbaM6gkuaRAJV+zXwqEkng==
X-Received: by 2002:a17:902:c411:b0:261:1521:17a8 with SMTP id d9443c01a7336-294cb394731mr29305755ad.16.1761626967781;
        Mon, 27 Oct 2025 21:49:27 -0700 (PDT)
Received: from [10.64.69.82] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0abe6sm99973325ad.34.2025.10.27.21.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 21:49:27 -0700 (PDT)
Message-ID: <305b9b6b-2003-48ab-97d0-c60226e1493b@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 12:48:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: enable pwm rgb leds
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, kernel@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
References: <20251017-add-rgb-led-for-hamoa-iot-evk-v1-1-6df8c109da57@oss.qualcomm.com>
 <cb973808-005e-4920-a35b-3f02a402a78b@oss.qualcomm.com>
 <ada950ed-7b51-4e62-93ff-550c427a73fa@oss.qualcomm.com>
 <nepbosujmpldx5exylkqjylonntj6v3p4jnnoyxstmbmilb7jc@t65dwpxzorg7>
Content-Language: en-US
From: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
In-Reply-To: <nepbosujmpldx5exylkqjylonntj6v3p4jnnoyxstmbmilb7jc@t65dwpxzorg7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2-LSeAq1Zy0ypUCc9cunyJYcmbmHmWMK
X-Proofpoint-GUID: 2-LSeAq1Zy0ypUCc9cunyJYcmbmHmWMK
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=69004b58 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-iULT8Sq9WsPgWKhyU8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAzOSBTYWx0ZWRfX87Hov+nSLVrw
 WYXU6EzEQEQuxhc4hHr28WB8hy252o9WbbU7CZt6O1GqwAgJsE2BR+iBZmD1e1WNo14sD9JsrkU
 Hvms4ncXQDrX3UvYkc4dQxs4KBq+/pruNL7fkJZVG0S2IimZTtmY6CMAzGtB+78YPY/okta2zYL
 LMTgW8ZZ0knYMs3xsFhj7wvbZ0k/eVK7z94gNiN4djqTEw6/lxwmzJbePAm6vSEdrlIpOdPMqPK
 6lZCChrL/j4WbUUwmPI/SaMMmt2cqwva5mKtJXo8ZKOQweNQNP/gjl/H1oY26U88/mL8rrWJDE+
 Qz7T01AgkEhjG7UKum202iwkNmcRz0FmqXwgYNLBZmJUquWwFUvdedrdJ9l7ROoDWaGKlh86IqQ
 Rh0kmdQzFDsw9SUG3PCGS+9ZzeFpFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280039


On 10/26/2025 11:15 AM, Bjorn Andersson wrote:
> On Tue, Oct 21, 2025 at 02:29:22PM +0800, Tingguo Cheng wrote:
>> On 10/17/2025 4:09 PM, Konrad Dybcio wrote:
>>> On 10/17/25 10:06 AM, Tingguo Cheng wrote:
>>>> Add red, green and blue LED channels for the RGB device connected to
>>>> PMC8380C PWM-LED pins.
>>>>
>>>> Signed-off-by: Tingguo Cheng<tingguo.cheng@oss.qualcomm.com>
>>>> ---
>>> Just to make sure, is this a "multicolor LED" consisting of 3 ones,
>>> and *not* three LEDs that are supposed to communicate different
>>> functions (i.e. network, power, disk i/o)?
>> Yes, it's a multicolor LED composed of three individual LEDs within a single
>> package—not three separate LEDs for different functions like network, power,
>> or disk I/O.
>> However, there's one exception worth mentioning:
>> The blue channel is connected to two sourcing signals—the EDL indicator and
>> the PMIC PWM-RGB blue LED—via two resistors. These resistors allow selection
>> between the two sources.
>> By default, the board is configured with the resistor soldered to connect
>> the blue LED to the EDL indicator.
>> To support software control, I’ve added the blue channel in the DTS,
>> enabling the capability to light the blue LED from the software side.
>> Some developers may choose to re-solder the resistor to connect the blue LED
>> to the PMIC PWM-RGB output instead, depending on their hardware setup.
> Sounds like we have a RG LED, and if the user chooses to modify their
> hardware, they have different hardware...which they can easily describe
> by updating their DeviceTree.
>
>
> It's a bit weird, but does it work to make this LED_COLOR_ID_MULTI with
> just the RED and GREEN channels described?

Yes, I tired before with enabling RED and GREEN only, it works. (What 
you said makes sense)

Let me send V2 for *only enabling RED and GREEN*

>
> Regards,
> Bjorn
>
>>> Konrad

