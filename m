Return-Path: <linux-kernel+bounces-889924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478AC3ED8C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511FD188DAB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DED27FD44;
	Fri,  7 Nov 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SvekIKK7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZgN1BGZU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F730E0C2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502428; cv=none; b=A3041BLtskdcRrxKuKenkYoLQex1/TCOJwS0WLjotFzAtqWIdK5Rnmh8ZAV+KJ1bFKRPDX5dSXxr1Vbx55S/dwLYrILNGrsi6QAdMXWpFgOVnaRIvOtpVPdI6emgRaX93Qt/yWSYVkycm+ZotLpuvdSEiYXpXUfTv61+FLnt1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502428; c=relaxed/simple;
	bh=E40HrpDKhbho4ulnYxOpXNRsXQ0Z5/1u1/PEpj8HCm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hk2ZGCGfaxHWr4MPqRyWz5/wC78cJwJyX12u8Pz58SLLha9oMuLKt2jSoVK8OGmF7C0rxMnm4y7NDphKX7Dvly4U8/CFG6Tp1a6NMhAqBfdaGqYm4EUqoakrSG88qdmewrXgmGIIfwetnqYUP+HYx/foYiHOZE/k0XiKXFlEMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SvekIKK7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZgN1BGZU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A744kWd2085441
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 08:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fWrTdfW+PWgpmgvJJ8GgaddfFBzqXvCHxOm4UXyViA4=; b=SvekIKK7pIlrupnq
	LGQ/pTTIJvTIDYSkk2f0UHQPuKjoum8Xpqidt/Z2SXy+janYWpTTQpXe0JbV2fWO
	ttBeZ7o1WHP4+gDsd0gY4QNXJDtSS+0I4RlBJnYay4nTJLvHn58GNYuWk5o9FSgt
	DIbE6hplEQdXnV5RIBXPgjFlLaPRqAWTduOl/tloaiVF4lT8iKm5hr3wBTlJPZcG
	9xahDwNq8/lgPtn1f0E76LrpivNbjYxt7cF24pHZwBgj4eF0hq5HFl6qkrdTAavF
	vWhnNL1jngnIpATld+wWUFTn+u7GSrP9bMoq01hSKdATu41nqFdlCgHZmLkO//pO
	mdAlhw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a99e78k1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:00:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297b35951b7so11376795ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762502423; x=1763107223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWrTdfW+PWgpmgvJJ8GgaddfFBzqXvCHxOm4UXyViA4=;
        b=ZgN1BGZUIUNwB9IMooy3kxrQK8tYEqyMRnCQmoymHBHjEkra47KffCbcD31w/f9fxk
         hJUCtsUOThHSJa+PaHXJZdWok5GM32Qqs7a7HmnE4dSNB+IYIsITCK+Y+ArgMkuDeuxN
         7rmGAfmSLnGiu6o9VmDBbDi19aQrpWn7j55f8zR8+dsZSYGnuhEdJwmfJLMIUBqCLjWX
         8FtkdhmnyIo4Q8PTE9L7rTTwuZB4V229mtys3WntRPmu6eSYAZalVW9z1IaStPj1a9Vx
         mCuMBY9ZqDrbln35m6IGW7/638to+nYmjwF1amvBnKU82GAvJCt/O38/KMuf/hV0byFC
         2UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502423; x=1763107223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWrTdfW+PWgpmgvJJ8GgaddfFBzqXvCHxOm4UXyViA4=;
        b=Ka3mssvKgKox3HWodKEMeoaS4KIiz98wfbdY/cBw6QPR0r7RzgE0HPeGVIVOOenzlb
         OX3+2GR5vo5Ua39GNVKZhaP3RdXz5Ubt3HcvdPKVNrY3/QjtsaxBhzuEitPfC3r2CK74
         K4oQ8yHyYJ7lmnsEPqx4KSIClnnXh6TwhkEMs4PGXayGHwJu1zrMmAa4AlVqVLbaG+eW
         lMGsqIZfGgm/+014JTM6Z0Qp5y9Hr5hITaCresrO5STvCRS8QFr49oQ1gUz2ihjt6pkD
         MJqLfEDf4vxJ5miTS/mi1WY4OZlnwIotbSDqTm8lxFHGMPDuXQFpYt36F01A0e/N6W9u
         NyCw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ75/bNNQhlKSjJBn0d+TN9vcj2aUGVQRpZQDwkYFOhaOxt3U+fZpQC/HXEandNBO4gcvaDkQyi6QTqqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Zw1wQbrL/aAcHKq1wKGK3iNoLXNholKEuxl+K+/fZIZhAsaC
	OS0Qc2ULK4LIBU6zsreCM+nQpkVPUgwbMO0NzXLq9QqWbdmWRjrd1yQM1ILPsA6kSejNy7oAfvk
	BAOqev6QdAsxzElpd9/v05frvPxvb27wesQp4FT6mds8QlQoCe4QUzBOS3ykFyFE4UCI=
X-Gm-Gg: ASbGnctlcyp1AxhI5r2jK6JvbRxSN9YS3Mo/d9xy9e+hqt9zHpJ1EFt8TjaVZKQ9E1C
	HbyjEKIk4X2/+xwiNZweZEs12oUP89qFBe5A0n9rQQm6gCiJ66t5nn5wTPBWoFG2f3ThPQq7Qy9
	XGbjUVvuxpzTt50vqx1HMifHNzv5ivssy/sQVrsXNREIylHWeZUy9EnlxTJy48b5tLQIPq0smQE
	WKb/tFH6URLx3TAlEnQOU8f/KEBGiH3HxXAA+c8aD78hHlt8+eE+pJMRlPDpvdg7SgA5AKg+1ux
	q3u0j3vf2uxVt+e+4Urqu15clL+70MxoH8YwToSbWcnKaim9ZlBs3PDnRRvZqolBHzKLChXIYPY
	UKYcJi/ti43pQx6k8
X-Received: by 2002:a17:902:e886:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-297c03fdac4mr29424375ad.27.1762502422704;
        Fri, 07 Nov 2025 00:00:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPvxj9FfPPQaO/RJmpjU6Pii+KFIgG7dZIdn3+8UvgnMBBzx9FelTibtwF8a2vQFn0JUZYYg==
X-Received: by 2002:a17:902:e886:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-297c03fdac4mr29423775ad.27.1762502421895;
        Fri, 07 Nov 2025 00:00:21 -0800 (PST)
Received: from [10.64.68.86] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968253sm51337415ad.20.2025.11.07.00.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:00:21 -0800 (PST)
Message-ID: <76d17604-c867-4c09-99ca-7216ce2095b9@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 16:00:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/14] Implement vendor resets for PSCI SYSTEM_RESET2
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
From: Xin Liu <xin.liu@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2MiBTYWx0ZWRfX9KyffcVgJiMZ
 hu/vbwGCnXUtxsRslwDxBRbFyVb8ZD8qxODcJx6LzAwdPAe7o8PnPSnlEqoU0yv5XTejxqrPP+0
 HIaqsVInhfioCnaBYnmS66zWRQfsy+/2+iCQcv8Yy0Hjgy7MjjVMprN6tg53bIbvmkh+DVxgusb
 qQU2f0c+g4I7veBvFDrW6brMpl+sEEbPCEvno/S/XJcHx86Tu0fBmejCaDfrwfwOfNepL9GqpXZ
 wo836VanRkHvEUPMg1k8mqNwCHjUoGuMFJZE10OWkiV4KbWigPhc+ZM5hERPXPZgnlXCYgrjwks
 PQ+wgRLlMD0T+Qgtv/nYEmoENCBetROmwPeswrKq2MTNjPKIIavaZjgUV7Ir30qwCvBgdXMQVxV
 aqDZkABkqBqfgRGHdx/AJMBO+/r9zw==
X-Proofpoint-ORIG-GUID: okJdOAktAAnUI1izppwb83JQg-SMlg4Z
X-Authority-Analysis: v=2.4 cv=A+hh/qWG c=1 sm=1 tr=0 ts=690da718 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Q-fNiiVtAAAA:8 a=v4c-l9uJr0qXoQh-ZDQA:9 a=uYG4AeN9tHKhjsCe:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: okJdOAktAAnUI1izppwb83JQg-SMlg4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070062



On 10/15/2025 12:38 PM, Shivendra Pratap wrote:
> The PSCI SYSTEM_RESET2 call allows vendor firmware to define
> additional reset types which could be mapped to the reboot
> argument.
> 
> User-space should be able to reboot a device into different
> operational boot-states supported by underlying bootloader and
> firmware. Generally, some HW registers need to be written, based
> on which the bootloader and firmware decide the next boot state
> of device, after the reset. For example, a requirement on
> Qualcomm platforms may state that reboot with "bootloader"
> command, should reboot the device into bootloader flashing mode
> and reboot with “edl” command, should reboot the device into an
> Emergency flashing mode.  Setting up such reboots on Qualcomm
> devices can be inconsistent across SoC platforms and may require
> setting different HW registers, where some of these registers may
> not be accessible to HLOS. These knobs evolve over product
> generations and require more drivers.  PSCI defines a
> vendor-specific reset in SYSTEM_RESET2 spec, which enables the
> firmware to take care of underlying setting for any such
> supported vendor-specific reboot. Qualcomm firmwares are
> beginning to support and expose PSCI SYSTEM_RESET2
> vendor-specific reset types to simplify driver requirements from
> Linux. With such support added in the firmware, we now need a
> Linux interface which can make use of the firmware calls for PSCI
> vendor-specific resets. This will align such reboot requirement
> across platforms and vendors.
> 
> The current psci driver supports two types of resets –
> SYSTEM_RESET2 Arch warm-reset and SYSTEM_RESET cold-reset. The
> patchset introduces the PSCI SYSTEM_RESET2 vendor-specific reset
> into the reset path of the psci driver and aligns it to work with
> reboot system call - LINUX_REBOOT_CMD_RESTART2, when used along
> with a supported string-based command in “*arg”.
> 
> The patchset uses reboot-mode based commands, to define the
> supported vendor reset-types commands in psci device tree node
> and registers these commands with the reboot-mode framework.
> 
> The PSCI vendor-specific reset takes two arguments, being,
> reset_type and cookie as defined by the spec. To accommodate this
> requirement, enhance the reboot-mode framework to support two
> 32-bit arguments by switching to 64-bit magic values.
> 
> Along this line, the patchset also extends the reboot-mode
> framework to add a non-device-based registration function, which
> will allow drivers to register using device tree node, while
> keeping backward compatibility for existing users of reboot-mode.
> This will enable psci driver to register for reboot-mode and
> implement a write function, which will save the magic and then
> use it in psci reset path to make a vendor-specific reset call
> into the firmware. In addition, the patchset will expose a sysfs
> entry interface within reboot-mode which can be used by userspace
> to view the supported reboot-mode commands.
> 
> The list of vendor-specific reset commands remains open due to
> divergent requirements across vendors, but this can be
> streamlined and standardized through dedicated device tree
> bindings.
> 
> Currently three drivers register with reboot-mode framework -
> syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
> list of commands currently added across various vendor DTs:
>   mode-loader
>   mode-normal
>   mode-bootloader
>   mode-charge
>   mode-fastboot
>   mode-reboot-ab-update
>   mode-recovery
>   mode-rescue
>   mode-shutdown-thermal
>   mode-shutdown-thermal-battery
> 
> On gs101 we also pass kernel-generated modes from kernel_restart()
> or panic(), specifically DM verity's 'dm-verity device corrupted':
> 	mode-dm-verity-device-corrupted = <0x50>;
> 
> - thanks Andre' for providing this.
> 
> Detailed list of commands being used by syscon-reboot-mode:
>      arm64/boot/dts/exynos/exynosautov9.dtsi:
> 	mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
> 	mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
> 	mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;
> 
>      arm64/boot/dts/exynos/google/gs101.dtsi:
>      	mode-bootloader = <0xfc>;
>      	mode-charge = <0x0a>;
>      	mode-fastboot = <0xfa>;
>      	mode-reboot-ab-update = <0x52>;
>      	mode-recovery = <0xff>;
>      	mode-rescue = <0xf9>;
>      	mode-shutdown-thermal = <0x51>;
>      	mode-shutdown-thermal-battery = <0x51>;
> 
>      arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
>      	mode-normal = <0x77665501>;
>      	mode-bootloader = <0x77665500>;
>      	mode-recovery = <0x77665502>;
> 
>      arm64/boot/dts/hisilicon/hi6220-hikey.dts:
>      	mode-normal = <0x77665501>;
>      	mode-bootloader = <0x77665500>;
>      	mode-recovery = <0x77665502>;
> 
>      arm64/boot/dts/rockchip/px30.dtsi:
>      	mode-bootloader = <BOOT_BL_DOWNLOAD>;
>      	mode-fastboot = <BOOT_FASTBOOT>;
>      	mode-loader = <BOOT_BL_DOWNLOAD>;
>      	mode-normal = <BOOT_NORMAL>;
>      	mode-recovery = <BOOT_RECOVERY>;
> 
>      arm64/boot/dts/rockchip/rk3308.dtsi:
>      	mode-bootloader = <BOOT_BL_DOWNLOAD>;
>      	mode-loader = <BOOT_BL_DOWNLOAD>;
>      	mode-normal = <BOOT_NORMAL>;
>      	mode-recovery = <BOOT_RECOVERY>;
>      	mode-fastboot = <BOOT_FASTBOOT>;
> 
>      arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
>      	mode-normal = <BOOT_NORMAL>;
>      	mode-loader = <BOOT_BL_DOWNLOAD>;
> 			mode-recovery = <BOOT_RECOVERY>;
> 			mode-bootloader = <BOOT_FASTBOOT>;
> 
> Detailed list of commands being used by nvmem-reboot-mode:
>      arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
> 			mode-recovery = <0x01>;
> 			mode-bootloader = <0x02>;
> 
> The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride.
> 
> Previous discussions around SYSTEM_RESET2:
> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> 
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com> # On ARCH_BRCMSTB
> Tested-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com> # IPQ5424-RDP466
Tested-by: Xin Liu <xin.liu@oss.qualcomm.com> # On qcs615-ride>
> Changes in v16:
>   firmware: psci: Implement vendor-specific resets as reboot-mode
>    - Use GENMASK(31, 0) instead of 0xffffffff - by Kathiravan
> - Link to v15: https://lore.kernel.org/r/20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com
> 
> Changes in v15:
> By Sebastian:
>    power: reset: reboot-mode: Synchronize list traversal
>     - Change mutex locking to scoped_guard() and a Fixes: tag
>    power: reset: reboot-mode: Add device tree node-based registration
>     - Change reboot_mode_register external call to use fwnode
>    power: reset: reboot-mode: Expose sysfs for registered reboot_modes
>     - Use sysfs_emit_at for printing sysfs entries
>     - Add driver_name to struct reboot_mode_driver instead of passing
>       as argument
>     - Update reboot_mode_register, devm_reboot_mode_register and
>       create_reboot_mode_device for same.
>    firmware: psci: Implement vendor-specific resets as reboot-mode
>     - Update psci to use updated reboot_mode_register and store driver_name
>       to struct reboot_mode_driver
> - Add DT nodes for PSCI SYSTEM_RESET2 types for lemans-evk, qcs8300-ride,
>    monaco-evk and qcs615-ride boards.
> - Link to v14: https://lore.kernel.org/r/20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com
> 
> Changes in v14:
> - mode-dm-verity-device-corrupted documented in cover letter -by André
>   ABI Documentation:
> - Updated KernelVersion in ABI documentation to reflect base commit
>    version. – by André
> - Revised ABI documentation to clarify space-separated format for
>    supported reboot-mode commands. – by André
>   power: reset: reboot-mode: Expose sysfs patch
> - Modified `show_modes` to output a space-separated list of supported
>    reboot modes – by André
> - Added error handling in `create_reboot_mode_device()` to ensure
>    proper cleanup on failure.
>   firmware: psci:
> - Locate psci/reboot-mode node using psci compatible. - by Krzysztof,
>    Dmitry, Sudeep.
> - Added error handling for additional code for compatible.
> - Converted hex values to lowercase for consistency. – by André
> - Introduced panic notifier to disable valid vendor-reset flag in
>    panic path. – by André
> - Added check for `psci_system_reset2` before registering vendor reset
>    commands.
> - Updated Commit text.
>   dts: sa8775p:
> - DT file name changed from sa8775p to lemans and commit text updated
>    accordingly. – for dt renaming in base commit (sa8775p to lemans).
> - Link to v13: https://lore.kernel.org/r/20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com
> 
> Changes in v13:
> - Split patch1 into two (Synchronize list traversal and DT node-based
>    registration) - by Dmitry.
> - Move mutex lock inside get_reboot_mode_magic - by Dmitry.
> - Reorder the patches – pull patch8 for exposing reboot-mode sysfs before
>    psci patch - to align the change in reboot-mode sysfs patch.
> - Update patch- reboot-mode: Expose sysfs for registered reboot_modes
>       - Introduce a driver_name in reboot_mode_register. This will be used
>         in sysfs creation  -  by Arnd.
>       - Update documentation and commit text for above.
>       - Fix release function to properly call delete attr file.
>       - Fix sparse warning for devres_find.
>       - Add error handling for devres_find.
> - Split ABI documentation as a separate patch and update ABI documentation
>    for usage of driver-name in sysfs - by Arnd
> - Update patch - psci: Implement vendor-specific resets as reboot-mode
>       - Fix Kconfig for CONFIG related warning.
>       - Add driver_name as "psci" in register call to reboot-mode - by Arnd
> - Link to v12: https://lore.kernel.org/r/20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com
> 
> Changes in v12:
> - Added lock for list traversals in reboot-mode - by Dmitry.
> - Added proper handling for BE and LE cases in reboot-mode - by Dmitry.
> - Removed type casting for u64 to u32 conversions. Added limit checks
>    and used bitwise operations for same - by Andrew.
> - Link to v11: https://lore.kernel.org/r/20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com
> 
> Changes in v11:
> - Remove reference of cookie in reboot-mode – Arnd/Rob
> - Introduce 64-bit magic in reboot-mode to accommodate two 32-bit
>    arguments – Arnd
> - Change reset-type to reboot-mode in psci device tree binding – Arnd
> 	- binding no more mandates two arguments as in v10.
> 	- dt changes done to support this binding.
> - Remove obvious comments in psci reset path – Konrad
> - Merge sysfs and ABI doc into single patch.
> - Fix compilation issue on X86 configs.
> - Fix warnings for pr_fmt.
> - Link to v10: https://lore.kernel.org/all/569f154d-c714-1714-b898-83a42a38771c@oss.qualcomm.com/
> 
> Changes in V10:
> - Change in reset-type binding to make cookie as a mandatory
>    argument.
> - Change reboot-mode binding to support additional argument
>    "cookie".
>   From Lorenzo:
> - Use reboot-mode framework for implementing vendor-resets.
> - Modify reboot-mode framework to support two arguments
>    (magic and cookie).
> - Expose sysfs for supported reboot-modes commands.
> - List out all existing reboot-mode commands and their users.
>     - Added this to cover letter.
>   From Dmitry:
> - Modify reboot-mode to support non-device based registration.
> - Modify reboot-mode to create a class and device to expose
>    sysfs interface.
> - Link to v9: https://lore.kernel.org/all/20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com/
> 
> Changes in v9:
> - Don't fallback to architecturally defined resets from Lorenzo.
> - Link to v8: https://lore.kernel.org/r/20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com
> 
> Changes in v8:
> - Code style nits from Stephen
> - Add rb3gen2
> - Link to v7: https://lore.kernel.org/r/20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com
> 
> Changes in v7:
> - Code style nits from Stephen
> - Dropped unnecessary hunk from the sa8775p-ride patch
> - Link to v6: https://lore.kernel.org/r/20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com
> 
> Changes in v6:
> - Rebase to v6.11 and fix trivial conflicts in qcm6490-idp
> - Add sa8775p-ride support (same as qcm6490-idp)
> - Link to v5: https://lore.kernel.org/r/20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com
> 
> Changes in v5:
> - Drop the nested "items" in prep for future dtschema tools
> - Link to v4: https://lore.kernel.org/r/20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com
> 
> Changes in v4:
> - Change mode- properties from uint32-matrix to uint32-array
> - Restructure the reset-types node so only the restriction is in the
>    if/then schemas and not the entire definition
> - Link to v3: https://lore.kernel.org/r/20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com
> 
> Changes in v3:
> - Limit outer number of items to 1 for mode-* properties
> - Move the reboot-mode for psci under a subnode "reset-types"
> - Fix the DT node in qcm6490-idp so it doesn't overwrite the one from
>    sc7820.dtsi
> - Link to v2: https://lore.kernel.org/r/20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com
> 
> Changes in v2:
> - Fixes to schema as suggested by Rob and Krzysztof
> - Add qcm6490 idp as first Qualcomm device to support
> - Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com
> 
> Changes in v1:
> - Reference reboot-mode bindings as suggeted by Rob.
> - Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com
> 
> ---
> Elliot Berman (4):
>        dt-bindings: arm: Document reboot mode magic
>        arm64: dts: qcom: qcm6490-idp: Add PSCI SYSTEM_RESET2 types
>        arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI SYSTEM_RESET2 types
>        arm64: dts: qcom: lemans-ride: Add PSCI SYSTEM_RESET2 types
> 
> Shivendra Pratap (9):
>        power: reset: reboot-mode: Synchronize list traversal
>        power: reset: reboot-mode: Add device tree node-based registration
>        power: reset: reboot-mode: Add support for 64 bit magic
>        Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
>        power: reset: reboot-mode: Expose sysfs for registered reboot_modes
>        firmware: psci: Implement vendor-specific resets as reboot-mode
>        arm64: dts: qcom: lemans-evk: Add PSCI SYSTEM_RESET2 types
>        arm64: dts: qcom: qcs8300-ride: Add PSCI SYSTEM_RESET2 types
>        arm64: dts: qcom: monaco-evk: Add PSCI SYSTEM_RESET2 types
> 
> Song Xue (1):
>        arm64: dts: qcom: qcs615-ride: Add PSCI SYSTEM_RESET2 types
> 
>   .../testing/sysfs-class-reboot-mode-reboot_modes   |  39 ++++
>   Documentation/devicetree/bindings/arm/psci.yaml    |  43 ++++
>   arch/arm64/boot/dts/qcom/lemans-evk.dts            |   7 +
>   arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi   |   7 +
>   arch/arm64/boot/dts/qcom/lemans.dtsi               |   2 +-
>   arch/arm64/boot/dts/qcom/monaco-evk.dts            |   7 +
>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |   7 +
>   arch/arm64/boot/dts/qcom/qcs615-ride.dts           |   7 +
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +
>   arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |   7 +
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi              |   2 +-
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
>   arch/arm64/boot/dts/qcom/sm6150.dtsi               |   2 +-
>   drivers/firmware/psci/Kconfig                      |   2 +
>   drivers/firmware/psci/psci.c                       |  90 ++++++++-
>   drivers/power/reset/nvmem-reboot-mode.c            |  13 +-
>   drivers/power/reset/qcom-pon.c                     |  11 +-
>   drivers/power/reset/reboot-mode.c                  | 217 ++++++++++++++++-----
>   drivers/power/reset/syscon-reboot-mode.c           |  11 +-
>   include/linux/reboot-mode.h                        |  12 +-
>   20 files changed, 427 insertions(+), 68 deletions(-)
> ---
> base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
> change-id: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf
> 
> Best regards,


