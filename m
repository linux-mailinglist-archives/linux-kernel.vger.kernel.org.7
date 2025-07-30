Return-Path: <linux-kernel+bounces-750786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2FB16111
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58417A64C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F8299943;
	Wed, 30 Jul 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZFLgRwk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB72957AD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880948; cv=none; b=N9APd/XpEWsz9qhD6+fRCErsHp1dsszaInUa636rnkUZQfXAO1f1R1AqILVlw6lR+08Jyf5Bm7o+JsB0rfIpdYXP0fvQjgho7fTDri18ZALkhTT/XO8EZbYOYkcV+rEyUYvBdiwWJZKDwkqkLQSsLB3DfDfIerPqmErtvinhs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880948; c=relaxed/simple;
	bh=iuuKGIizxFYPlT/bt0zoSMj0nd3jCkg/TFY2jENqJBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYI8XnqqKITVGUH+epSWQe8Nc8Rken5i98FaQejMuQP1bmSt+kaLswikCDUiKzyMqqM/mMlq14vMhsaJpxp/NRa1yVA+m+urc/EWqqtd1dDUNcIXqG//aBaB5kotlM2wOFb38JOwwimrwRCTuO+DjgqqeA5OnlsxNvgHcPNA51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZFLgRwk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbBFs024575
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wNDjzyGP/l854i6KT01aZoOncfqe5cUyUJTb5qnC1kY=; b=hZFLgRwkVOm0twVG
	7m3CXCrAyBdRSRzunSCBpu6djgXBoZcpeLkDHNYd2NpE5xF6cyxTZA2siSVH7HIa
	Tv/nAKLx4Q4QsS6Cc3XKH8hWf4UrPm2OVZZgwaXFt7Sbucn4Kj0bBVs6BIZ32v4P
	cLGuDWHyOqn969q4Tn8BC18yfsUAZCFSsSn1CfaLgmy9caCLf93LjRZwUcpCxUrY
	35EgB+ICiKCym9XzOZ+Q/l2l34T8Ufn2hfLyhLL1NGZ1874NdY24SBQPPouQU8To
	6f8oQGEQhft2GVVqTYgUNV7QNnnUEImy3SXRfmTlU+7Gfkry2a+7Xbd1tMQfxMcA
	5JbZGw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1akrmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:09:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76b857c5be7so466435b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880944; x=1754485744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNDjzyGP/l854i6KT01aZoOncfqe5cUyUJTb5qnC1kY=;
        b=VcHaf2JQ9cBqNtn/y9pFXBw0zdZ3GbI+TtS5udQJvmik+InfCq3dyHrOJYIGgYfDTF
         j3NmLQ8tIIoqgJraMWTPoHo+FhVpg/NnPsykPf3cvn/hipB1/u4Nsm0dAFPb4uMdAfcq
         9Lxh/E7ohZL2WOmKZapSwk+J/LMTmUXjQdYRBwZX1kElIRBtH6DZMaSU1lRGM1Gp28Wt
         M4WlG900a4jV1XKGSpoGaaf944XX+EZeXfqcAxiwnVqa3Ck5jEwHgvnPiP2HSRrSHoEn
         KaqBQ3qnUKadE2Hs8gex0EvverN+iqdwf7d0GULCjn2i5FgdfdnkIa0m5B+X+NG8LeI/
         3vUw==
X-Forwarded-Encrypted: i=1; AJvYcCVsp9vLPf42RECL1scPADChKygWKOOwCvh/FbmcDVzkdpNtbGnSGm6Z40wCGKbAaT6X6BmPuN3g+SsSLNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHr7JtWvlBGUq6dpz6Aozrl2ymt50HBCWzzHvswtob5wQuZG1D
	Tu25Exz6d11fmOUkvjWbVC4m3KAhGc+20Yu1b4VH54eRdZErlPdgCNiD5PfOQaSScJGA5r4pwiD
	uvgaUANu1HRTMROXS7qTsFsoGZrDv51SB0HEAzPDS+OZ7oLqFLo9P/PorkL07HeyZTXQ=
X-Gm-Gg: ASbGncvdvhGMzYWBi2xzAfcEBKFubuOSqugreQaqcKd8IConctv5LK6snkNUgzVyGpE
	H67gjX2WjXZANJUt55l+VDsEMjEUWyro7Q5Cs4UJupmHOGtSssJvhjlk1/W5A+VyJaCZoFxoH8v
	nh4h2LoOrkVDidtsbD5JWh4b0QyvnPkUkCyGRF3mXmzjGsqp2uFsS9S7P2COaLmTaIlC4eGqzN5
	/admm75J9pPeb4OJ0qvxIjYTi1L/u0GqDFV1/vLcL4+mu4SX3UG4hqqU0hVEP0cZmLsDzWySSTw
	7ZQJR4B9nQhwEF/NwS/4ndwcSkbWy91YD8DhuJBo04tKnV6j+DUPRCB/16Hr2sk5GC0TBrLVTQ=
	=
X-Received: by 2002:a05:6a20:548d:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-23dc0d3e328mr4807709637.12.1753880943800;
        Wed, 30 Jul 2025 06:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs6wjsf0Q2uV+QjNX2+BJebA7gZlSlrORRFmXImrXs/DTnl6FWhcQ6Ay1Cko/oB0Ikr9ynZQ==
X-Received: by 2002:a05:6a20:548d:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-23dc0d3e328mr4807652637.12.1753880943335;
        Wed, 30 Jul 2025 06:09:03 -0700 (PDT)
Received: from [10.219.57.35] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f67c8fcsm7588223a12.37.2025.07.30.06.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:09:02 -0700 (PDT)
Message-ID: <2b8a2ea6-f13c-ea09-c089-f2296b887859@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 18:38:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v13 04/10] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Content-Language: en-US
To: =?UTF-8?Q?Andr=c3=a9_Draszik?= <andre.draszik@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-4-6b8d23315898@oss.qualcomm.com>
 <b1b34e31904f711e7cf82394843a9966238f2896.camel@linaro.org>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <b1b34e31904f711e7cf82394843a9966238f2896.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8BBb14ppAZLiSfkTwyne8h9cJxR62fSi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5NCBTYWx0ZWRfX7snSUbEp5mrV
 EJzGOk6YNjWEqE/uvdD3nfxH0mhtNPUQX/OrwKDsbhp1FdA9WQAAwiocj2dXhS72o4BkI4tjuT1
 T7Hn/nNm+2LZ6cNN5YNu8ZfMvncjV4NVe0W5RXb0DDb0WQkobuJ/Qas6X30orLCd5SJHkGhXnId
 u6MH1P5qK6cUSh1B+3aljxM3RfgKUeuMJ3JIOvLp1SRYPqcllm/tbizTr+vJS3eh8Hvumn7jAfD
 InnzR/J3I8LfrwXr0FOyaAnPSQbwt1CAqA5Rbf06qxUwAqDVTsRoJe9PfBjQG9mMOx6peNfR8QI
 R3SOq84PWxQ6vRaW++lxnK/MFv2zeBFULFxlopWUVx8eVQ9JW8M3029VBadCi4bLv9TRsHoaibL
 75Z+0QlCWNUyDTCjPrNKag2zGUSMAyWCaBPLhL9uTFanSGE4URwEOfqU6P2GITyEUs0fCFaS
X-Proofpoint-GUID: 8BBb14ppAZLiSfkTwyne8h9cJxR62fSi
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688a1971 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=OQUscKAIWfOqcitIQgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300094



On 7/30/2025 2:36 PM, André Draszik wrote:
> On Sun, 2025-07-27 at 21:54 +0530, Shivendra Pratap wrote:
>> Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes,
>> a read-only sysfs attribute exposing the list of supported
>> reboot-mode arguments. This file is created by reboot-mode
>> framework and provides a user-readable interface to query
>> available reboot-mode arguments.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-
>> reboot_modes
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..7147a781e5d4d11977c3a156bf4308aa13310e39
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
>> @@ -0,0 +1,39 @@
>> +What:		/sys/class/reboot-mode/<driver>/reboot_modes
>> +Date:		July 2025
>> +KernelVersion:	6.16
> 
> The version should probably be updated.

sure. will update this.

> 
>> +Contact:	linux-pm@vger.kernel.org
>> +		Description:
>> +		This interface exposes the reboot-mode arguments
>> +		registered with the reboot-mode framework. It is
>> +		a read-only interface and provides a comma
>> +		separated list of reboot-mode arguments supported
>> +		on the current platform.
>> +		Example:
>> +		 recovery,fastboot,bootloader
> 
> I'd personally find space separated like e.g. in files below /sys/power
> and many other similar files below /sys easier to read.

sure. Will make it space.

thanks.

> 
> Cheers,
> Andre'
> 
> 
>> +
>> +		The exact sysfs path may vary depending on the
>> +		name of the driver that registers the arguments.
>> +		Example:
>> +		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
>> +		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
>> +		 /sys/class/reboot-mode/qcom-pon/reboot_modes
>> +
>> +		The supported arguments can be used by userspace
>> +		to invoke device reset using the reboot() system
>> +		call, with the "argument" as string to "*arg"
>> +		parameter along with LINUX_REBOOT_CMD_RESTART2.
>> +		Example:
>> +		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
>> +		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
>> +
>> +		A driver can expose the supported arguments by
>> +		registering them with the reboot-mode framework
>> +		using the property names that follow the
>> +		mode-<argument> format.
>> +		Example:
>> +		 mode-bootloader, mode-recovery.
>> +
>> +		This attribute is useful for scripts or initramfs
>> +		logic that need to programmatically determine
>> +		which reboot-mode arguments are valid before
>> +		triggering a reboot.

