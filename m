Return-Path: <linux-kernel+bounces-858675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35ABEB65F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCB73ADE30
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F276330B33;
	Fri, 17 Oct 2025 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ab+lJnO2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE0246783
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730047; cv=none; b=GOv4e2k9O4teBh0Ib2OI791HY3NmRlIKeXPZ03Qg7NVhWf+P50zNZXJQuJJ/w01bWRFYE950d+IFViPaiIwjyUqiZ1Vl78+ci7wzIy25n9UMgnOigi+QjO7OiRTFVYq1aB/vVYRhflJBItnwznm6Ba3IMkkw6ZP1yfKFrffeR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730047; c=relaxed/simple;
	bh=RwXvQjbt7JK3pEL6l7LHRphjooUlJVKHIFoBkWQhKQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2WNAIEYs91ZOic8PPg8CQfyLz1beQtUHEKLi1toYn8FnxUIt5Bk3kjN5WYQun1VNylCou5Lve6P7NxpkV94fqd8Qkl+R/H6UY1halJxHJBxXfQiPS8KEQWUpawx7X8GOIGiB1qawa8kSSkAJlDn68A4OrguZsBRr2Z3QTw2TzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ab+lJnO2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGc02017060
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NDFamMd0o9Y7qLZOjscAOp4r8I+m3aYXZeFPwTjn+lI=; b=ab+lJnO2WjDFcY+u
	4mf4EfvpQGaWjRovEEcZWSSzRphu0skduP7aB5wQRV36e/nVbH1tjK/Zl8duA0tY
	pGqWIoLNeFXEjanyyJ6fVjmg75ID42a12X8EF01ZSeWIlbiem49Bn4vthoh+Pb6o
	AVSSTuQT7AscEh8JZlyZYj2YtzB6Ck23A3mr+JT8AuqYcNja4pmRG+Lw/w0OrDzU
	JytgiPWKz+Iwq5LNNV59sdD60F4tNzFA+OODdp5hmCBipRhVa+79zCXeAq07KcFM
	pvOFAArsBAwm4GimPMSpRb6dsfJhFIht6ew7jsTZqKsqWM1rGFbkI2aQ86m/yTIM
	8pvjyA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkng6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:40:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so2367930a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760730043; x=1761334843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDFamMd0o9Y7qLZOjscAOp4r8I+m3aYXZeFPwTjn+lI=;
        b=KyDX8XQZbkBsBeXu/H8bEujPtSzpNLuyNaixpnJq7x8fAGnczYO9Ykwby8lPQEB+Yd
         6subcDo9G43D66UdMyOOgxwv1h6dkmvxRqN77H6Ki1l4Q75CIdKPTm6mVdHxiyDLoHkB
         Rjmcvq2Y+N9ufDKRnGAPKrnXh+rrEFCopJwQCSxlWGPFELv7fJQF40c1t0o0pwuNexkI
         IPALt34kRER/xIvbqt+0HjoPgSrAvNdlmr3h/2UKZrOPWXnJ/iH7U5lSPoDgpQ7HCGnp
         pjE5+UCZNFI0jPrQpuc88c0WLv7CQEH3wYUziCiKxtvre/YM48xf8nPCTd6XFFwkrD6J
         Av3w==
X-Forwarded-Encrypted: i=1; AJvYcCWnm95QpO4971g06l+3yeKLnh4rT7O7ycXm/4VtpvRrl9hMgw/DPiQDXE+PeB6msX3kkPctOZRQAIUe+ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPM4cMmjodroG9tUwFHJSuGKZFem6fGnt4mM2fy5EJAcE0e1Il
	ZI34Ea8sbGGKfI0nIBcHSQq3yynvR43FIorGFVz0JuVte9VJHHMH8I6SS/BqAd9TWWWoXBOFzHi
	D5zzUbbDunB9+wYxCQbRxyTH91u4QU6X6QUSEuUIEEhKylyQ1h/gDKeVQk4oCS6YjTJQ=
X-Gm-Gg: ASbGncuSmox6jzw/OXnRctxeTQ/2v+vVV84Adt+mrzDZMBg1dO4ewmt+a6DFarYBxyC
	+K65zn54YGtfxOwdbDTUD2lk6vWoyWhvZJKYwdPcBOO56WA27Lq24l4Eo3kLvFUUon5O52OcNCs
	kI4kpLxMsHhRwwNB36kG+j2xDEjpvn2q/glWeuGb5wAic247gvafv12EL5ux+36KhVCyQ4JBAHl
	1VK5HpsC18/eFO0w2vthYHI13yxtqeBEYm4ZsK8yiDix5ql+eVGVms0/MqX66loXdmEGWczPGZM
	g797oiKRRyQwZ18liq8TXAIXQ7rvjIPcOd6fDliNis5pMSzxW+YFELLmhrA1M9g5SpyQMH5Oksh
	mhGE+R+PWX7KUCCe2WLFG7c6yV0SW1as1Jg==
X-Received: by 2002:a17:90b:3f8c:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-33bcf87ab38mr6176201a91.13.1760730043199;
        Fri, 17 Oct 2025 12:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhslTnLw1d44+gxYWnp+m2GVuVioyNzi8Rgxtwtm1YnY0CsEHaMExcmSUWrki5gmUY0K4AhQ==
X-Received: by 2002:a17:90b:3f8c:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-33bcf87ab38mr6176158a91.13.1760730042699;
        Fri, 17 Oct 2025 12:40:42 -0700 (PDT)
Received: from [10.216.52.245] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de11392sm200332a91.7.2025.10.17.12.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:40:42 -0700 (PDT)
Message-ID: <8fb6e8e0-cdca-0bd5-d0fe-56b5f6d27a5c@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 01:10:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 05/14] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSetWthCcJo8v7EuUK-aDKhf5KTNG5WQQ9aTQu62B+E=DMA@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSetWthCcJo8v7EuUK-aDKhf5KTNG5WQQ9aTQu62B+E=DMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7lFL1FR1CfLys_mafaPLIWPvY-DOBHDA
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f29bbc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=C5lFK0Xs5ZTp69CiT58A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 7lFL1FR1CfLys_mafaPLIWPvY-DOBHDA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXz7cqGCBj9GSC
 XYVMIXn4MOQZ7Q47ZbmxpetL98dnWc+jk9q1z9clxoAtjxKF/BccsSSE5JPaCZIBCKYhqKxEu54
 nePZ7w3+sYzOwWnxyPW0fJjsDQFav493URqpGYwlWpx2c0zYQFBNODNTN1BCAPPKt11IqOn+yHe
 OJVFTs6XR0GTQoyEz/QDPz/pQKZyyfLIFtznKDzGV/cDYbj5DiXvWqegz8vqROF1kS3j0Hlh1Yo
 8yYxUO8xlPdnxauUWpJtqUAEu2wy89GR4G1NIgl8qeGej53gbugqSPtUGqy8JCJEqMP4LGDgUzP
 AsOVQkeAtWOSat2Jfgi+9DMhDa7sSxMC6Xhb+MLFug7kJh4g7na7uEKvTtC0Yz9yiIatMpk5RoY
 j176uEctvjZSJv5sjpCMqBcKVTGXSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/15/2025 8:17 PM, Bartosz Golaszewski wrote:
> On Wed, 15 Oct 2025 at 06:39, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> Currently, there is no standardized mechanism for userspace to
>> discover which reboot-modes are supported on a given platform.
>> This limitation forces tools and scripts to rely on hardcoded
>> assumptions about the supported reboot-modes.
>>
>> Create a class 'reboot-mode' and a device under it to expose a
>> sysfs interface to show the available reboot mode arguments to
>> userspace. Use the driver_name field of the struct
>> reboot_mode_driver to create the device. For device-based
>> drivers, configure the device driver name as driver_name.
>>
>> This results in the creation of:
>>   /sys/class/reboot-mode/<driver>/reboot_modes
>>
>> This read-only sysfs file will exposes the list of supported
>> reboot modes arguments provided by the driver, enabling userspace
>> to query the list of arguments.
>>
>> Align the clean up path to maintain backward compatibility for
>> existing reboot-mode based drivers.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> 
> [snip]
> 
>> +
>> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot)
>> +{
>> +       struct reboot_mode_driver **dr;
>> +       int ret = 0;
>> +
>> +       if (!rb_class) {
>> +               rb_class = class_create("reboot-mode");
>> +               if (IS_ERR(rb_class))
>> +                       return PTR_ERR(rb_class);
>> +       }
>> +
>> +       reboot->reboot_dev = device_create(rb_class, NULL, 0, NULL, reboot->driver_name);
>> +       if (IS_ERR(reboot->reboot_dev))
>> +               return PTR_ERR(reboot->reboot_dev);
>> +
>> +       ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
>> +       if (ret)
>> +               goto create_file_err;
>> +
>> +       dr = devres_alloc(release_reboot_mode_device, sizeof(*dr), GFP_KERNEL);
>> +       if (!dr) {
>> +               ret = -ENOMEM;
>> +               goto devres_alloc_error;
>> +       }
>> +
>> +       *dr = reboot;
>> +       devres_add(reboot->reboot_dev, dr);
> 
> If you're using devres here - at least make it obvious by adding the
> devm_ prefix to the function name and make it take an explicit struct
> device * parameter so that it's clear who owns the managed resource.
> 

sure. we can add devm_ prefix to the function name.
reboot->reboot_dev is an internal member of struct reboot_mode_driver *reboot.
The struct reboot_mode_driver *reboot is owned by the calling driver.
If we want to PASS reboot->reboot_dev to the devm_ prefixed function call, we
will need to kind of split create_reboot_mode_device into two calls - device_create
in a separate function and then call the devm_ prefix function where we add the devres_alloc.
Can you suggest a bit more on this?

thanks,
Shivendra

