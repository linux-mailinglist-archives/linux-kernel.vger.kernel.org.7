Return-Path: <linux-kernel+bounces-727571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C8B01C39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95330173C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD992BE65E;
	Fri, 11 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+s0PLeN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE392BE7A1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237724; cv=none; b=K+St7plUnoFxU67sF5/nUEUsSjIb0Ictoee2frnikNVm/H4hr1xUdtcV2FgptDeY8pBM28isHK4yd6jHCPda0fb0QRPFYuU1AcbYBLw7SUAVQL5fA8q9anJzpBrFvF9AQgIeIw+6iHx//yi5BAeXV58UkArkc59sz9DU3dBR42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237724; c=relaxed/simple;
	bh=TTNFsZlkgF17zI4BM79hCHyp2/ZL5Cfd+zZW4/aXDEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQZ63Tw3sGJp+T1hUm9WlctOo4dMF/rekFQYjvZEH1H2mVqBGLK0+CzlFLhpbepgFHs+iNFUDKahF+9k7dYtNRp+5dI8qu6DQ93h1fE/BRI01M4paPjogXD7KlJmvdwIUec7lZwsWdVYLZ4o3k6geSOS83mc7nXff8+sHUwh9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+s0PLeN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAmQKU007998
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d5+/yBvSrPjpR3dnKIXI7WDOVLe64039N9qvOvpxNgs=; b=P+s0PLeNgC1bT+zp
	OprQSu04CbmBYWorPRnRtwuUy3UbbOugx8XFUfyVjUHg+KJX8zTXOV7+6Ip53E0j
	SWrd44hZ42sgmT1IagJAqnKbqPTtrfg3u11xElUfJb2V4zlIdEWl7JMj89zcL89d
	bZN73aY0gbjxDNMR4zKRGIhDAXpB52by1H02vdoMn752WXWo9I6x45VX0qy1/aUI
	UB3yrJaCRQTDg7SoxQwnRiEhx9lfhGgAuykb33jrdfX0QZqrAuB0DptY4xsu9UP7
	uwVpy7WSkFPdgODI28FzH+R4wL5yxUbIMqMPOtnwFWstZ8D6rb5lSdZV/FfV+yKx
	mS1Dag==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg8jk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:42:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-740774348f6so1777912b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752237720; x=1752842520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5+/yBvSrPjpR3dnKIXI7WDOVLe64039N9qvOvpxNgs=;
        b=qimfsuWgwgjL8/HjD5g0YFpdJ2i8TbjCc64CfeNPrv7aiHJuQ5yqihQfNKmvlDd33i
         hFyYXt4W+eAwmwzyEtAXhXuua5xlzS5ZWxBwPa/7YyIIGeGq/FcslUbJsLQLu+Lo/LFr
         Jg4sfdm/fTNtXGZsSY3lzd4lRvtMBJUDKXK+AxjXVqpPUgTjCyK3nkUvmVtO6XD9Yq+/
         znrZFAYvH/pCCgl2lvcB3KDBWpo81vHZlhFxodhODLVhOmRqbVNVRgDnw/qCPfhyPfg5
         n/sXcuKBIeYLFeIsH1REyvhd0mAEWcCxKbcxiSp6jnI5K+37uCjYbqSM8UI2QjshiQDq
         UWog==
X-Forwarded-Encrypted: i=1; AJvYcCW6EhZbuJT9jm/ULZjzslV/3sOms8JWTI6fTqQ83pZaiSmiSdnZu5hAfgTw+wQK9l1USIdvO/x16mX2FaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHG+5sDFSTsKnkLiVBVV0qyp307pMIz7d+sMByJu1y3WNM4HW
	jGI/IMz394dBqJxRGEFobhpVFJo9NVNRORNm9VldmfRHBZ3mwzUmDe1ph+KY+0w9IVTTXuSVd5h
	yYHiqEhSnT1AHXQtCII+Yl6rFAd9B7NgnI2youdWEeyHzdk+Ff8Qc/SJotLi5BVNt/UU=
X-Gm-Gg: ASbGncujWtqVDGcLWGzGygc/jY+5WVGQZcHY9RrIHBrxW8kVau3rNz2ecHjAr2734GT
	9F42pnY0ydmriAuXZLfZlsER/wZyVLtEtCYeqUjsr+vlYfONcgjzcyEWkHEKDoG+aaazQgCRd/1
	5T88xzXsWk1E7s2wA0KfqPUM140BCcZkvIVhXr+a45X5XU+e0/+5vWoLVm3QHPhFSmutLpqcVDF
	XRJAftia0Ew/8G59mGsxVKyrycB9JrYlnf18bBvQyf26gLaOiZJ2rUg7WzpsfOE88ztt7xkugmV
	vinekTNePTpnfMKtqXx2+w8ubZu54GEffibDq0fP4xwyD0j1iKEEsP5oaFzUL305mXm8st8=
X-Received: by 2002:a05:6a00:856:b0:748:fcfa:8bd5 with SMTP id d2e1a72fcca58-74ee0bb022amr4593275b3a.3.1752237719814;
        Fri, 11 Jul 2025 05:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdcoZQM2gGkxEIKZe0Opa+gJonI4mT7h/Xru9l1ALb4R2GQ97oy1hB7jYf00yu3cGC1pFFfA==
X-Received: by 2002:a05:6a00:856:b0:748:fcfa:8bd5 with SMTP id d2e1a72fcca58-74ee0bb022amr4593181b3a.3.1752237719048;
        Fri, 11 Jul 2025 05:41:59 -0700 (PDT)
Received: from [10.219.56.108] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4ca48sm5432801b3a.133.2025.07.11.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:41:58 -0700 (PDT)
Message-ID: <569f154d-c714-1714-b898-83a42a38771c@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 18:11:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v10 00/10] Implement vendor resets for PSCI SYSTEM_RESET2
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>,
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
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <34dde6a1-bb75-45ed-a20d-057e3f32f592@broadcom.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <34dde6a1-bb75-45ed-a20d-057e3f32f592@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=68710699 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=dz73BlOkEN4xbZ8eBY0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AZD3qx-Lasn3BHu-ViY7EdJ6hWGFF6aA
X-Proofpoint-GUID: AZD3qx-Lasn3BHu-ViY7EdJ6hWGFF6aA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5MCBTYWx0ZWRfX9kJyUqwV4BVU
 v4/UniP8jB7zzV0OLcr5VWtXS1Af8qJTG9UN3jHzkuVRFjZHOdfzumY/X+w5YZCRNcXkMK7uanA
 1/Hu9+65GN1Fi8gwaIpFQtio3D1uYcwuQ7yhw+LxF8BpGYsyvf73QO3v1nXqa73tX3BqlFKc41q
 hxEjZ2JC3ZSNogDMvlcaV70Fp+qw76PcJSFVqWh9IZh4O550paTu2BjcspKy/XYlalwlWZi4sxc
 4yUDNP4D/ozcADcg50NvfZYj5fxPa5KT9foZP/zeTP6epZOWn3UZVKAaRuNIg8+GdysfamvMTB4
 QqQWBs9ZseO6J43qvZHRd8N5zkO6y/iAi2YzPBSMIVNOBNxQViVxBcBPlO2PUTbWqoC1hW/es8h
 7J0LXj+uEg1Ps/Ei5XfiG6/RlgzGXtB/LJbYl6/TUPjWECS5hHe9YhDbVdZGioxDotmuSyO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110090



On 7/11/2025 1:50 AM, Florian Fainelli wrote:
> On 7/10/25 02:15, Shivendra Pratap wrote:
>> The PSCI SYSTEM_RESET2 call allows vendor firmware to define
>> additional reset types which could be mapped to the reboot
>> argument.
>>   User-space should be able to reboot a device into different
>> operational boot-states supported by underlying bootloader and
>> firmware. Generally, some HW registers need to be written, based
>> on which the bootloader and firmware decide the next boot state
>> of device, after the reset. For example, a requirement on
>> Qualcomm platforms may state that reboot with "bootloader"
>> command, should reboot the device into bootloader flashing mode
>> and reboot with “edl” command, should reboot the device into an
>> Emergency flashing mode.  Setting up such reboots on Qualcomm
>> devices can be inconsistent across SoC platforms and may require
>> setting different HW registers, where some of these registers may
>> not be accessible to HLOS. These knobs evolve over product
>> generations and require more drivers.  PSCI defines a
>> vendor-specific reset in SYSTEM_RESET2 spec, which enables the
>> firmware to take care of underlying setting for any such
>> supported vendor-specific reboot. Qualcomm firmwares are
>> beginning to support and expose PSCI SYSTEM_RESET2
>> vendor-specific reset types to simplify driver requirements from
>> Linux. With such support added in the firmware, we now need a
>> Linux interface which can make use of the firmware calls for PSCI
>> vendor-specific resets. This will align such reboot requirement
>> across platforms and vendors.
>>   The current psci driver supports two types of resets –
>> SYSTEM_RESET2 Arch warm-reset and SYSTEM_RESET cold-reset. The
>> patchset introduces the PSCI SYSTEM_RESET2 vendor-specific reset
>> into the reset path of the psci driver and aligns it to work with
>> reboot system call - LINUX_REBOOT_CMD_RESTART2, when used along
>> with a supported string-based command in “*arg”.
>>
>> The patchset uses reboot-mode based commands, to define the
>> supported vendor reset-types commands in psci device tree node
>> and registers these commands with the reboot-mode framework.
>>
>> The PSCI vendor-specific reset takes two arguments, being,
>> reset_type and cookie as defined by the spec. As the
>> vendor-specific reset needs two arguments reset_type and cookie
>> to be passes to the firmware, enhance the reboot-mode framework
>> to support two arguments (magic and cookie), for each reboot-mode
>> command, where cookie will be optional.
>>
>> Along this line, the patchset also extends the reboot-mode
>> framework to add a non-device-based registration function which
>> will allow drivers to register using DT node, while keeping
>> backward compatibility for existing users of reboot-mode. This
>> will enable psci driver to register for reboot-mode and implement
>> a write_with_cookie function which will save the
>> magic(reset_type) and cookie and then use it in psci reset path
>> to make a vendor-specific reset call into the firmware. In
>> addition, the patchset will expose a sysfs entry interface within
>> reboot-mode which can be used by userspace to view the supported
>> reboot-mode commands.
>>
>> The list of vendor-specific reset commands remains open due to
>> divergent requirements across vendors, but this can be
>> streamlined and standardized through dedicated device tree
>> bindings.
>>
>> Currently three drivers register with reboot-mode framework -
>> syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
>> list of commands currently added across various vendor DTs:
>>   mode-loader
>>   mode-normal
>>   mode-bootloader
>>   mode-charge
>>   mode-fastboot
>>   mode-reboot-ab-update
>>   mode-recovery
>>   mode-rescue
>>   mode-shutdown-thermal
>>   mode-shutdown-thermal-battery
>>
>> Detailed list of commands being used by syscon-reboot-mode:
>>      arm64/boot/dts/exynos/exynosautov9.dtsi:
>>     mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
>>     mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
>>     mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;
>>
>>      arm64/boot/dts/exynos/google/gs101.dtsi:
>>          mode-bootloader = <0xfc>;
>>          mode-charge = <0x0a>;
>>          mode-fastboot = <0xfa>;
>>          mode-reboot-ab-update = <0x52>;
>>          mode-recovery = <0xff>;
>>          mode-rescue = <0xf9>;
>>          mode-shutdown-thermal = <0x51>;
>>          mode-shutdown-thermal-battery = <0x51>;
>>
>>      arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
>>          mode-normal = <0x77665501>;
>>          mode-bootloader = <0x77665500>;
>>          mode-recovery = <0x77665502>;
>>
>>      arm64/boot/dts/hisilicon/hi6220-hikey.dts:
>>          mode-normal = <0x77665501>;
>>          mode-bootloader = <0x77665500>;
>>          mode-recovery = <0x77665502>;
>>
>>      arm64/boot/dts/rockchip/px30.dtsi:
>>          mode-bootloader = <BOOT_BL_DOWNLOAD>;
>>          mode-fastboot = <BOOT_FASTBOOT>;
>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>          mode-normal = <BOOT_NORMAL>;
>>          mode-recovery = <BOOT_RECOVERY>;
>>
>>      arm64/boot/dts/rockchip/rk3308.dtsi:           
>>          mode-bootloader = <BOOT_BL_DOWNLOAD>;
>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>          mode-normal = <BOOT_NORMAL>;
>>          mode-recovery = <BOOT_RECOVERY>;
>>          mode-fastboot = <BOOT_FASTBOOT>;
>>
>>      arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
>>          mode-normal = <BOOT_NORMAL>;
>>          mode-loader = <BOOT_BL_DOWNLOAD>;
>>             mode-recovery = <BOOT_RECOVERY>;
>>             mode-bootloader = <BOOT_FASTBOOT>;
>>
>> Detailed list of commands being used by nvmem-reboot-mode:
>>      arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
>>             mode-recovery = <0x01>;
>>             mode-bootloader = <0x02>;
>>
>> Previous discussions around SYSTEM_RESET2:
>> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
>> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> 
> Humm, something changed compared to the last version that I tested from Elliot which worked ok. With this patch applied and the following Device Tree snippet:
> 
>         psci {
>                 method = "smc";
>                 compatible = "arm,psci-0.2", "arm,psci";
>                 cpu_on = <0xc4000003>;
>                 cpu_suspend = <0xc4000001>;
>                 cpu_off = <0x84000002>;
> 
>                 reset-types {
>                         mode-powercycle = <0x01>;
Yes, Now passing the cookie value is mandatory, when defining your "reset-types".
So your device tree entry should be:
			mode-powercycle = <0x01 0>;

Please try by passing changing the dt entry as above.

The dt-binding document is updated and does talks about the mandatory cookie
to be passed in reset-type.
>                 };
>         };
> 
> I get the following invoking "reboot powercycle":
> 
> # reboot powercycle
> [   21.403188] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000 is not a phandle reference
> [   21.412032] Mem abort info:extended_property): /rdb/waketimer@841a840:interrupts-extended: cell 0 is not a phandle reference
> [   21.414840]   ESR = 0x0000000086000004operty): /rdb/waketimer@841a840:interrupts-extended: cell 2 is not a phandle reference
> [   21.418601]   EC = 0x21: IABT (current EL), IL = 32 bitsparent: cell 0 is not a phandle reference
> [   21.423927]   SET = 0, FnV = 0: /rdb/xhci_v2@8d00000:phys: cell 0 is not a phandle reference
> [   21.426988]   EA = 0, S1PTW = 0 /rdb/sata@8b0a000/sata-port@0:phys: cell 0 is not a phandle reference
> [   21.430138]   FSC = 0x04: level 0 translation fault:phys: cell 0 is not a phandle reference
> [   21.435054] user pgtable: 4k pages, 48-bit VAs, pgdp=000000010112c000 a phandle reference
> [   21.441508] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000handle reference
> [   21.448318] Internal error: Oops: 0000000086000004 [#1]  SMPcell 0 is not a phandle reference
> [   21.453990] Modules linked in: bdc udc_core/thermal-zones/cpu-thermal:thermal-sensors: cell 0 is not a phandle reference
> [   21.458188] CPU: 0 UID: 0 PID: 1566 Comm: reboot Not tainted 6.16.0-rc5-next-20250710-gdd78270edd5a #2 NONE 4)
> [   21.468032] Hardware name: BCX972160DV (DT)ases property name must include only lowercase and '-'
> [   21.472221] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)only lowercase and '-'
> [   21.479193] pc : 0x0s_paths): /aliases:pcie0: aliases property is not a valid node (/pcie@8b10000)
> [   21.481388] lr : reboot_mode_notify+0x64/0x80es property name must include only lowercase and '-'
> [   21.485760] sp : ffff80008344bbe0iases: aliases property name must include only lowercase and '-'
> [   21.489079] x29: ffff80008344bbe0 x28: ffff0000c3bb3d00 x27: ffff800080ab58e8ly lowercase and '-'
> [   21.496228] x26: 0000000000000000 x25: ffff0000c3bb3d00 x24: ffff800082cf9bc8ly lowercase and '-'
> [   21.503376] x23: ffff80008344bcb8 x22: 0000000000000001 x21: ffff0000c31b87b0
> [   21.510524] x20: 00000000fffffffc x19: ffff0000c31b8780 x18: 0000000000000000
> [   21.517673] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   21.524821] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   21.531969] x11: 0000000000000000 x10: 00007fffc02bb958 x9 : 0000000000000010
> [   21.539118] x8 : 0101010101010101 x7 : 0000000000000000 x6 : 000080c38080ffff
> [   21.546266] x5 : ffff0000c3000000 x4 : 0000808000800000 x3 : 0000000000000000
> [   21.553415] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffff0000c31b8780
> [   21.560565] Call trace:
> [   21.563014]  0x0 (P)
> [   21.565205]  notifier_call_chain+0x70/0x120
> [   21.569401]  blocking_notifier_call_chain+0x4c/0x78
> [   21.574288]  kernel_restart+0x30/0xc8
> [   21.577957]  __do_sys_reboot+0x1c8/0x268
> [   21.581886]  __arm64_sys_reboot+0x28/0x38
> [   21.585902]  invoke_syscall+0x4c/0x118
> [   21.589660]  el0_svc_common.constprop.0+0x44/0xe8
> [   21.594373]  do_el0_svc+0x20/0x30
> [   21.597694]  el0_svc+0x18/0x58
> [   21.600758]  el0t_64_sync_handler+0x98/0xe0
> [   21.604947]  el0t_64_sync+0x154/0x158
> [   21.608625] Code: ???????? ???????? ???????? ???????? (????????)
> [   21.614730] ---[ end trace 0000000000000000 ]---
> Segmentation fault
> #
> 
> -- 
> Florian

