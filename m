Return-Path: <linux-kernel+bounces-744429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B2B10CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4EC5C319C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC62D836E;
	Thu, 24 Jul 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W+qSkHEo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3982405F5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365868; cv=none; b=LQqUaiXH3dw8b8x/qVbJ2eo3pXZ/NUGPwLqK8+IRfUocR6Q9JwFpJ7p9MibQNDGbSaXeB9Q8qezGp/lbWPU3RkTRcOIa2lAYg2k6hnhOo1QFOKAi8D5j+DQPKnT9gl7WbQRBbBbZMFiixzeH8j4qeYDtYwgvVGH3KymtdYxZHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365868; c=relaxed/simple;
	bh=euYDBiI52TaHhbSDj7p1OwmGXPGVNvatQPROiF44G5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6U90N5kxe3d9nBQo9RW18846/uAQqKzVcvUvbDVUObX91dvTIMqzWTuoIU84HF7NLAf08XQvniRKhGNYrfQz887G1+fxba9Wv5xsvsIgspDZSNsQVMluQrKgQtt4PkTRFMGuJHrkIdrfFjPcIc5tk+QBqIHbwadWohvNWY4DYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W+qSkHEo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9UbJ5022010
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vgq0sS9bJuE54sZn99vBn48DqF4vg0XSEVpZVyXodU0=; b=W+qSkHEoDKvJqeGa
	j9qzqsOiQGG3tf0XTfyzx7QwDXk5DI/xoPq9qJCLjDm8cOYm6hIxXufP7vtWMTwn
	+DQBkJtaSF7Ff6gBisK/c82vyKR22b+RCCW5W0rJzbnl+91lQcFvypooKOQEspdu
	YEa9IJxm97ilBHsHF7aXUfOgh6kHZ0vaJOzhW23pCRfUjyiJnY5SVz/O1vTpIt1s
	adsG7yPAg1TR5rmuwncyn1OQu8jwFx/d1EfGjJRftiJHMyANiXF3jhdLs7V//apB
	cR49Su2boGv9A8eiCQplxsEy9mvLOAMUG8n2MG2oJv/Cr0TNA5huNpqQykisxATa
	aTuhbA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044drqxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:04:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso1725609b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365864; x=1753970664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgq0sS9bJuE54sZn99vBn48DqF4vg0XSEVpZVyXodU0=;
        b=Mvdzu+Rfra6H+N8gQvS7QuQd5heENdXAMqqobtN9DQPW0q7wMQCQh15NxggTKc+zN7
         MfU4fJ2G4pWaPOmwjoxlfOFyCv5Aqf6bFeLDac0LQ+whnq/qzEABB+AUsk6RqAvSGYVf
         54u8biHujNlxdzUYxj6hjL8ua+I5giq1G9cin19/ve+M6hVItQRRJOXwYAIaox3uUSZc
         cj8/02/I7JhrzAdvTbfQBv4SuaP2MO/Kydt/OHhBEQly9h3+77cJmT5cc0j+Zv7qiQ91
         hQ5ivkWuyVBBldB8NfcJ1l6xwHw6Gyc1n1LBHBjHPaVxo6P9YOBFDu7gj7ZTQN5qt1/V
         izlg==
X-Forwarded-Encrypted: i=1; AJvYcCVc3+o6EUiC0495I4FqQoC+4eGVzFvKrAdUGIUkHxgqqJM7Fd1ch4NilXfA9VmJiR3O2lEkAGMzNzKvBi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGoySlAZUSbH+EmVUc6hM9/RgRPtJtRVACF63pG3P58MoZMXYl
	0XHbjuAirTMqknHm6eoqF8Fh5qJ4gb8ljld0EPXItJt5C0y0KVdV5vUhfAahms/Z4unfTtsE7ww
	tl2pmxcAqulgTMsT0uoCxiUucJ0tWaLxUUsEBTEaHxA2HnpUUj77JZiAMuiIufsqEeTc=
X-Gm-Gg: ASbGnctFY9S1vZUR78T9c/IaVaJ/nA1Gbrjafl8NXvJa12pFoL/HFHay3LEwwz8CM9n
	MStWQ7SLDBv9YWuKk0+2BmSNvmkrFHIZxuyuqfmLrRxMSR+uDdvSjuOnhn9mLn1IPNkbkog+qHj
	oKz6rydTagWY38I/mk1EtW8PQxCRmVjbf4O6oKm9g8YLe1ZTrbvdS4kvDM9JLpGUBIy+6P60Yu4
	lWZwxwyE/C6oZFHGrfBuAy2PAuFoSP6+ip3F27BQOchC5MF2yv0XrdLh1ADWUP8BI62cREodYEK
	qIeee+v7YyH0oTMN7L1lgJpeZ2mA5/w2QfCHTG9WuaKWtWt7Ov9Jk4IpAUivkV01eLHqq9NU3Q=
	=
X-Received: by 2002:a05:6a20:d80f:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-23d48fe0706mr11806723637.7.1753365863371;
        Thu, 24 Jul 2025 07:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAk87SufmnhCrOrsDy9MKWBmmPKhBPtYqVHhRKiYJ5DGF4kGQc3VXG7/OhXCMjUqW31MLiAw==
X-Received: by 2002:a05:6a20:d80f:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-23d48fe0706mr11806617637.7.1753365862604;
        Thu, 24 Jul 2025 07:04:22 -0700 (PDT)
Received: from [10.219.57.35] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b06158acsm1757972b3a.109.2025.07.24.07.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:04:22 -0700 (PDT)
Message-ID: <f4725f3f-1b45-ebd2-aaf4-4f986a44eb8e@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 19:34:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v12 0/8] Implement vendor resets for PSCI SYSTEM_RESET2
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
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
        Will Deacon <will@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
 <beb26682-d2e4-40e6-89ac-87f18c0401d0@broadcom.com>
 <56599da9-0200-72b5-012e-942a1fc954b2@oss.qualcomm.com>
 <a1d3264f-a46a-42c4-b518-a66c8e0b70b4@kernel.org>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <a1d3264f-a46a-42c4-b518-a66c8e0b70b4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=68823d69 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Q-fNiiVtAAAA:8 a=QDcQmLXp8I0AkLLIQucA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4QxxzdJHa5LrqArjrEY1zZirG9s-zbp6
X-Proofpoint-ORIG-GUID: 4QxxzdJHa5LrqArjrEY1zZirG9s-zbp6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwNyBTYWx0ZWRfX+ZQM8XvuhwXT
 nm0Jknc3FBuTUAeUFcsCw/wjbm6YtGAvW/G8W80DdWClTdcKC+la+ACFysyEWf7HNIQEjc9A9Zf
 lCt5q8UYZimyqWkA4qZlfZVl2FD2RoaDs+h4P9NL2yE2biTHGYJTOA6BS7uTdESWIz+tRBM3QNU
 wLPHrG7VxMnSyDA3ekF8kJ6mrZ++ADeDzq5slSwiROQ5MZvbJCrozCuq/guQC2bkYiqtEWUVTxR
 FIlKBIv+0HtwtQB3PmZJXeYPthM4k66QLtazdp+UtSi0eMKLpDGYjceZqB+RsIK6vZ/iptwXv/Y
 jy9hMgr7WXTL3vze4WN00P3JOR9eYTlZiJvpWRtM25BGJNN0Vffsl4OMFh58eeOwzw/W2XX3TWU
 Vpp/pXB6INKVvKqRn7elrIkvOjGRt27XlxnNSv62Hqb8fdPkLAeTbiznO4JE+hB8exNxEE5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240107



On 7/24/2025 6:18 PM, Krzysztof Kozlowski wrote:
> On 24/07/2025 14:24, Shivendra Pratap wrote:
>>
>>
>> On 7/24/2025 5:46 AM, Florian Fainelli wrote:
>>> On 7/21/25 11:28, Shivendra Pratap wrote:
>>>> The PSCI SYSTEM_RESET2 call allows vendor firmware to define
>>>> additional reset types which could be mapped to the reboot
>>>> argument.
>>>>
>>>> User-space should be able to reboot a device into different
>>>> operational boot-states supported by underlying bootloader and
>>>> firmware. Generally, some HW registers need to be written, based
>>>> on which the bootloader and firmware decide the next boot state
>>>> of device, after the reset. For example, a requirement on
>>>> Qualcomm platforms may state that reboot with "bootloader"
>>>> command, should reboot the device into bootloader flashing mode
>>>> and reboot with “edl” command, should reboot the device into an
>>>> Emergency flashing mode.  Setting up such reboots on Qualcomm
>>>> devices can be inconsistent across SoC platforms and may require
>>>> setting different HW registers, where some of these registers may
>>>> not be accessible to HLOS. These knobs evolve over product
>>>> generations and require more drivers.  PSCI defines a
>>>> vendor-specific reset in SYSTEM_RESET2 spec, which enables the
>>>> firmware to take care of underlying setting for any such
>>>> supported vendor-specific reboot. Qualcomm firmwares are
>>>> beginning to support and expose PSCI SYSTEM_RESET2
>>>> vendor-specific reset types to simplify driver requirements from
>>>> Linux. With such support added in the firmware, we now need a
>>>> Linux interface which can make use of the firmware calls for PSCI
>>>> vendor-specific resets. This will align such reboot requirement
>>>> across platforms and vendors.
>>>>
>>>> The current psci driver supports two types of resets –
>>>> SYSTEM_RESET2 Arch warm-reset and SYSTEM_RESET cold-reset. The
>>>> patchset introduces the PSCI SYSTEM_RESET2 vendor-specific reset
>>>> into the reset path of the psci driver and aligns it to work with
>>>> reboot system call - LINUX_REBOOT_CMD_RESTART2, when used along
>>>> with a supported string-based command in “*arg”.
>>>>
>>>> The patchset uses reboot-mode based commands, to define the
>>>> supported vendor reset-types commands in psci device tree node
>>>> and registers these commands with the reboot-mode framework.
>>>>
>>>> The PSCI vendor-specific reset takes two arguments, being,
>>>> reset_type and cookie as defined by the spec. To accommodate this
>>>> requirement, enhance the reboot-mode framework to support two
>>>> 32-bit arguments by switching to 64-bit magic values.
>>>>
>>>> Along this line, the patchset also extends the reboot-mode
>>>> framework to add a non-device-based registration function, which
>>>> will allow drivers to register using device tree node, while
>>>> keeping backward compatibility for existing users of reboot-mode.
>>>> This will enable psci driver to register for reboot-mode and
>>>> implement a write function, which will save the magic and then
>>>> use it in psci reset path to make a vendor-specific reset call
>>>> into the firmware. In addition, the patchset will expose a sysfs
>>>> entry interface within reboot-mode which can be used by userspace
>>>> to view the supported reboot-mode commands.
>>>>
>>>> The list of vendor-specific reset commands remains open due to
>>>> divergent requirements across vendors, but this can be
>>>> streamlined and standardized through dedicated device tree
>>>> bindings.
>>>>
>>>> Currently three drivers register with reboot-mode framework -
>>>> syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
>>>> list of commands currently added across various vendor DTs:
>>>>   mode-loader
>>>>   mode-normal
>>>>   mode-bootloader
>>>>   mode-charge
>>>>   mode-fastboot
>>>>   mode-reboot-ab-update
>>>>   mode-recovery
>>>>   mode-rescue
>>>>   mode-shutdown-thermal
>>>>   mode-shutdown-thermal-battery
>>>>
>>>> Detailed list of commands being used by syscon-reboot-mode:
>>>>      arm64/boot/dts/exynos/exynosautov9.dtsi:
>>>>     mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
>>>>     mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
>>>>     mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;
>>>>
>>>>      arm64/boot/dts/exynos/google/gs101.dtsi:
>>>>          mode-bootloader = <0xfc>;
>>>>          mode-charge = <0x0a>;
>>>>          mode-fastboot = <0xfa>;
>>>>          mode-reboot-ab-update = <0x52>;
>>>>          mode-recovery = <0xff>;
>>>>          mode-rescue = <0xf9>;
>>>>          mode-shutdown-thermal = <0x51>;
>>>>          mode-shutdown-thermal-battery = <0x51>;
>>>>
>>>>      arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
>>>>          mode-normal = <0x77665501>;
>>>>          mode-bootloader = <0x77665500>;
>>>>          mode-recovery = <0x77665502>;
>>>>
>>>>      arm64/boot/dts/hisilicon/hi6220-hikey.dts:
>>>>          mode-normal = <0x77665501>;
>>>>          mode-bootloader = <0x77665500>;
>>>>          mode-recovery = <0x77665502>;
>>>>
>>>>      arm64/boot/dts/rockchip/px30.dtsi:
>>>>          mode-bootloader = <BOOT_BL_DOWNLOAD>;
>>>>          mode-fastboot = <BOOT_FASTBOOT>;
>>>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>>>          mode-normal = <BOOT_NORMAL>;
>>>>          mode-recovery = <BOOT_RECOVERY>;
>>>>
>>>>      arm64/boot/dts/rockchip/rk3308.dtsi:
>>>>          mode-bootloader = <BOOT_BL_DOWNLOAD>;
>>>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>>>          mode-normal = <BOOT_NORMAL>;
>>>>          mode-recovery = <BOOT_RECOVERY>;
>>>>          mode-fastboot = <BOOT_FASTBOOT>;
>>>>
>>>>      arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
>>>>          mode-normal = <BOOT_NORMAL>;
>>>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>>>             mode-recovery = <BOOT_RECOVERY>;
>>>>             mode-bootloader = <BOOT_FASTBOOT>;
>>>>
>>>> Detailed list of commands being used by nvmem-reboot-mode:
>>>>      arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
>>>>             mode-recovery = <0x01>;
>>>>             mode-bootloader = <0x02>;
>>>>
>>>> Previous discussions around SYSTEM_RESET2:
>>>> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
>>>> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
>>>>
>>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>>
>>> On ARCH_BRCMSTB:
>>>
>>> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>
>>> For the sysfs bits, should not we be seeing "psci" instead of "reboot-mode" twice in this path:
>>>
>>> # cat /sys/class/reboot-mode/reboot-mode/reboot_modes
>>> powercycle
>> As per current patch, we create a class named - "reboot-mode".
>> /sys/class/reboot-mode
>>
>> Then comes the DT node name of the registering driver.
>> /sys/class/reboot-mode/<DT node name of the registering driver>/
> 
> This means that node name becomes part of the ABI? I am not happy about
> it. Where is such ABI documented? Because your last patch tells
> something completely else!
> 
> I strongly insist using compatible as way to find your device, not node
> names.
It will look better to switch to compatible. Will define a compatible for
psci reboot-mode binding and align the patch to use the compatible for sysfs.
Current patch defines reboot-mode as a property to psci, hope its fine to
define a compatible for this property like "psci-vendor-reset" or
"psci-reboot-modes"?

> 
> In any case you need to document such ABI in Devicetree bindings,
> because sysfs ABI is not enough.
should reboot-mode Devicetree binding document this ABI? Can you
please share some more detail on this?

thanks.
> 
> Best regards,
> Krzysztof

