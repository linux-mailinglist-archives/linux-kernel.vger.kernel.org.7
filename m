Return-Path: <linux-kernel+bounces-748329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB4B13FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A07AC186
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BA273D92;
	Mon, 28 Jul 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IefhWrKl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD91D5145
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718897; cv=none; b=m/n+/v0g/jh4S3CV9XC4/eMJpJ7mQxbVlCBVO+VGqm0ggtM3hNNaCcCHHDGAr27BtkvTb7Y9N9K6hnD69ydW6XRRQJhCzAVjEVcAYp8kDMRPs9pQ7lxz4lr8t7VFWJvo0GE2xxa4zG9Lh+xwsmiGmmGV2Go+PcAhaFUEzf/PN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718897; c=relaxed/simple;
	bh=Zzx5ymIWUOo8rnDAmxJ0+FyVd+R0IXJxbDDNfuUz5lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKlp2bbQnbPIpYVVU99J+hPC03DIOZGi2JaiOn1N9fjq58ND1i1E75xDga/D61KPc4+bs+LjPUD1vVOJgpqzjpTFCuQl42A75qYDM5gMZEcDsc9samI3EzXgIySQZLKs0YurnsLk4Z0wsPRIpPvBvUqVMkcAq3Y+wm9sgpLGthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IefhWrKl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlNxu028203
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nn6sa08jrce+SrXB4mT8Tl+55LBGQlikiUQGmI3nyYY=; b=IefhWrKlB6nwWDNl
	TYQrgeN8mN/bUA+p8NXEabI65ZA3nD0vYV21+12VQDKlTEBxEWfuNGyxbI8YK0Z9
	vUv95DIGylToYjexSMCeGWoR2NtcMbtxL5lIQ3+v2SO792To//malVkDSuEybKxm
	9B7jkDsx4usbVsC4Zr6YLKwCWAIsCoPiYfqRB01gummBqpnuJzzgaY/QGTJQdzu6
	gs23oKaFZTWZ4xeBIXk7cf19j6Zi/qQ5vkDe/xk86tP1HYzTAhmqGG0XHI0rArD+
	O3mC6ZQvKQDeqklhejlG5dWuhgqm5MSScxDIUF7CZqu+z7ksOgP0coO0rpLZ3Zdt
	Hpm2BQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2d3ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:08:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso7856972a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718893; x=1754323693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn6sa08jrce+SrXB4mT8Tl+55LBGQlikiUQGmI3nyYY=;
        b=bFsDwzC6uh8Y3WJti3JjWeVqoGQGoG724PKloAZzUGrRLSTxUq5hp+qbcEya8ibxhx
         ozi1FtHv2keC6j7hOUebTA9gTZPEIyXy7of3zuIl3AMFGbyNSgEFQLnURG5B3aGZMm5h
         bVDUq1i4tY+aq0M9WKYrr1VGeEk9rw8ef52PZ/S1rbVhFg/SKF4Iu7B2tpZ6GbbE7k+J
         AvOJX6jtbqso71VW9ilqFxLVqqCPjgjlVCp3LGBinQ4mjbKrPAf0lV24oE6kB0Sf2qsp
         Ku1oWbBnrS9aXwkDr8kwQhY7lEMcEDWwdulx6dIvQoX19IO5nbcSaM9aimsYppbAnJLr
         R3ag==
X-Forwarded-Encrypted: i=1; AJvYcCXcGJB8gmCNp0UGdYppieAYAxJC7jaod4E6IptvGgJirSRKWKugil6vhtdstcIOuYEFxQnQQVZ/CxPZuEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9aScWXFBrcx9dQ2SfrOuUZTfr9EnrhcIG+wawMeclE1+Vg0J6
	Qhx5zejXPLJhR6oLTYhUmHKL55Y+9Kv3jU1/Ui4doKlrdl1iYVRMCF3D18eqgmkg6s/jXS0I+lT
	avLmjsN3mt/Qfzk5g4+LseuWuzaCF25BZTpKPWJ3x0UJCBX/IL4D/E4fNCdsNdmeuqwg=
X-Gm-Gg: ASbGncvteVANQmZCJMeJdFmWBn+xh81qzxYIPOpI2QoRweGOigH2yLWX109NO1AaHAj
	IjVNcDNMBJzyDCr2ENZW/2C56EEe0RyyTji69ZPxBJd29737cm7FwD6UtgX2eQReslJU+D0nxf0
	7gf14GvYB10EfcIaCj7zFdzgoL85xOpz+ApTamSwei+EpgODhFoV+BdkXlgjDHSSYEp9kY2v8bZ
	X9OaJ/V0MM9SSH8KBC+hjDgYqws575eDfp1hBC03PHt/yTXyQjOgW92OnogBGe+pyRZIM6yA4bj
	LjlVXZgFzn8BFQYbrB3Awc6i+yrfIAo8pLzzII/ed+qMXXD3lRVRGlIMqWsSvliPADyygUiRTI5
	C
X-Received: by 2002:a17:90b:58ee:b0:31e:1311:2033 with SMTP id 98e67ed59e1d1-31e77a1a541mr16647236a91.29.1753718893341;
        Mon, 28 Jul 2025 09:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdgFqQRwLc4WbeRsTRyBtIJODCU+0G/vz7UTUiQVGLbmbQjHXF2a2GFm/CzGuJHOKwTFW5Lw==
X-Received: by 2002:a17:90b:58ee:b0:31e:1311:2033 with SMTP id 98e67ed59e1d1-31e77a1a541mr16647145a91.29.1753718892672;
        Mon, 28 Jul 2025 09:08:12 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.229.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66376377sm9863788a91.28.2025.07.28.09.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 09:08:12 -0700 (PDT)
Message-ID: <46261176-199b-4f6c-ceb4-14646087c814@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 21:38:01 +0530
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
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pHIgm1htkRJcg1cSn6w8tVCl0PqnEVCH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExOCBTYWx0ZWRfXyFU53McCGQJs
 XK8zZ8gIw6b+PgQ9GZKYrSRBPp4mvbsIuu5bIluEJW+U2FBAxrPWW4i2OdOQrf0JF3Oy8wjUrVu
 oUjA0mEzYhkb9NnP9cDTVlWlzdg7nZn1db+0fB7qMoPXtGaKnZGORC6Mj0mEt57pczkfvMuWjdg
 tdJQlveRTxL7ZeKXW9rMyco/jlP+d4LQv4OMTSrKy+xoTe3RLuJ8VP/D6gP2YT1Fc4AjdYpeIdd
 UTJJhPV9NY8TdfSjzZY6nURCS3yk9jAOUngG/wFdKvSXdvAuh06UJPY73PjN8vzWBUBTq7eWaTe
 ILYbJ16JIwE0bt9xPWx/8hxhfKXI1nhFk2jr0xFn3fGuu9JsY63uotFmPuqFSYYYAB3IxdeIhyf
 UcrkX6iZwWoHZoIHzbbr30OhK8yS0TP2jxGQAFl4LGKoFJQed5ZTLynOQLCmN9VYNy/8fSSF
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6887a06e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=sFC1+cT0Mn4vjRNJ/HRkpQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=9xdhny6Toa8R1GZ1QJ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: pHIgm1htkRJcg1cSn6w8tVCl0PqnEVCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280118



On 7/28/2025 5:33 PM, Dmitry Baryshkov wrote:
> On 28/07/2025 14:52, Krzysztof Kozlowski wrote:
>> On 28/07/2025 11:44, Dmitry Baryshkov wrote:
>>> On Mon, Jul 28, 2025 at 06:53:14AM +0200, Krzysztof Kozlowski wrote:
>>>> On 27/07/2025 18:24, Shivendra Pratap wrote:
>>>>> +
>>>>> +static int __init psci_init_vendor_reset(void)
>>>>> +{
>>>>> +    struct reboot_mode_driver *reboot;
>>>>> +    struct device_node *np;
>>>>> +    int ret;
>>>>> +
>>>>> +    np = of_find_node_by_path("/psci/reboot-mode");
>>>>
>>>>
>>>> Why are you looking by full path, not by compatible? Is the ABI - above
>>>> path - expressed anywhere?
>>>
>>> PSCI node is required to have a node name of psci, it doesn't have MMIO,
>>
>> This is true
>>
>>> so it resides in the root node
>>
>> This might be or not might be true. It is not defined by ABI. Anyway,
>> you answered where the ABI would be documented, even though as I said it
>> is not (/psci is not), but does not answer to first part: why you are
>> not using compatibles which is always the preferred method?
> 
> That's a good question, I've added one from my side: why do we need an extra late_init call.
"psci" registers with reboot-mode which creates a class and a device under it for exposing
the sysfs.
psci_dt_init is called very early around setup_kernel. At that stage the class creating fails,
so psci cannot register with reboot-mode at this stage.
At early_init, the class creation is success, but the created class and the sysfs does not
enumerates under /sys/class/.
So i added explicit late_init call for this where the sysfs creation seems to work fine.
> 
>>
>>
>>> and the reboot-mode is defined in the
>>> previous patch. So, I'd assume, the path is defined.
>>
>> As I said, path is not. only psci/reboot-mode is.
> 
> Do we have an _actual_ use case where PSCI node is not at at root node? If not, it's obviously a deficiency of the schema. Could you please provide suggestions on how to describe that in DT schema?
> 
> 

