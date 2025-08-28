Return-Path: <linux-kernel+bounces-789482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18231B39627
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6E368818E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA42D7394;
	Thu, 28 Aug 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqBtRgNb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4132D6E5A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368351; cv=none; b=bXFfQnzqLcTxlfU9hcAkppLGYpeFSIxrrS5ydWBLh/RQ5Iz5tvT5hcnLijyRpKp+VIIkohm9+vfiQ+6QXiL4u/CJ+HVF7gG22kNusX/EXh+38XpAYa1ukbyu4hS3pJqlxXPbifm5WKbLtvmZTfB8ORzbALH/R8ioRx0lfrp6/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368351; c=relaxed/simple;
	bh=0v3VTSDnoKSJ11aMKmMrmANPBeZqszSRoleoKqFZowM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1aq1UjIiPtJiWy1L5gf7R0XR1nqSq6dQjuudWkweSa7U131AmdRiQV8TbM7UXhbFq+PVtXphi+fRMeHrcxaj1GnNzk7eZgphnwrzBtUJ68LDGwvJb/QvH7rMIEmrEWI04l1jZ3r24NDr9vyTuVFQ4HiUiJRrzSW13Mr7NKD+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqBtRgNb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5i8ei030526
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vY1V0UwZ8s0vX29+NR8gyAX4j41CCT/In5zMDAylqeI=; b=bqBtRgNbYkRka2Fq
	k0XVKjGHYQc6rqp3e06EaJvNitZZhwSCeMMVubZ8hX2LttTGNC4njobZ08q57XgD
	fU8PozMPtE2b4qsd8xrju+oJSHPFr6zS+fIkzAR8feiTdvbVDXedEmvwEnhEbDPm
	WCHWAAqxW9v0/UZOgN9umCLP9nyZ5mKP4sxfInch8BHQOLATGE24bLkk8zTOHzn2
	CSObKgF2FCzRLUhSvk+OI5ZYlWnDdqI9upCRMs3Lj0ZIsD4gAQ7qzq7IevdRFl7U
	LxN0bacd5fG176iVasZ1o3wLkUMwAo4OgXC8tHKV7e4ESHfO1MLBsfjpjvw1kPsp
	lCOUaQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5uny95j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:05:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b49da0156bdso1044444a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756368347; x=1756973147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY1V0UwZ8s0vX29+NR8gyAX4j41CCT/In5zMDAylqeI=;
        b=JqgEoVJT0ZhAO7kp8XT2WZnnSjTy5+Mu3jM0fwe1pQuY35oYl3oSixxJGZIG70SkX1
         n9K8lvpyeDyNohN0QLGadhlpSC+aEH0R/vnk3+KX75NZnUJM9yMaRsjAq3NkIF/cCses
         XsvZ6EtOHRS3ImrnEeMSwJ76pXaH+3k0vhH6fqcASCcEkniqoViG4tCMFWdObYoUgdAa
         Touk3dAgwvU769ioNqLU3YrfsTOXO85JSknYZdsElqezhi3vTHQoRWEyhbpg2SkQrvZb
         TfDUv9HxnrnG4NYzay15Qh7Jva4ChBC+PV5thG6eWhlJKy4ykwrxfLDLsK7LP/re/QgD
         ER1A==
X-Forwarded-Encrypted: i=1; AJvYcCXeHIYBcEfojO76waH9SECCc+M38MWLqTT/sbOSz1nq6LR1WIenkkOjuDQnk0d2+cRvXH6K+GjXuRhMnyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARkCo1YXdcO+rK0oQQdszcRjXJ8MuqSYqIRfo0ycARXcX8b+/
	wYUUXsUa36DGeFqio0QNSl0BMFIRuoaoqWtdbyadhcJiaDfHePdDtJv0qJJONmg6GE0RZepkfxo
	7WXHca9XO5rzV3lwbc9Ck1NyOyBxoT203SYwKbfV6J4CducaIfIRVSYsnNOmwo2++8r4=
X-Gm-Gg: ASbGncvxo9p7fb6k+roZvdAKNmAfM5Jeb/DygIqvsr6I2h6bqkKRcI8sZ0lB323Iw96
	hlwbzFMLlLMTIJQrYo+bkBiwtRihF+9774IviY7OHnPhaI7yh4V9RR1N+LfFOJjdd6ZBgSNoeKE
	FMiiaT17Ct8FwzGR/8m1aHrLlgkLmfGKR4GztPfZ+LsZDovorm/hx8BlLi6Ero1sWsyx46cr1qa
	7uDojOy9PN7yXnGMA3ijWiJkF5zpKPWQIQg09YvNRiV44OWTVZ4KvUR4gFITSINInhxYSnTH7z8
	l+S+hOZ1E5x7S36OghpEgqvPLCkTtXm+ABsMFE6pZvZIoyhFb1haH1wtE0W/P7uLxpXS+jiI9P/
	i5jxkINP9
X-Received: by 2002:a05:6a20:6a28:b0:23f:fec8:9ab0 with SMTP id adf61e73a8af0-24340b59c44mr32754331637.25.1756368347073;
        Thu, 28 Aug 2025 01:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyRlqZnSkO2dMdTgeoV1jxASU3ZmYnT0g0dq+toleinjjWrSpO9LT86flFSlKz/iy9C2rMrw==
X-Received: by 2002:a05:6a20:6a28:b0:23f:fec8:9ab0 with SMTP id adf61e73a8af0-24340b59c44mr32754293637.25.1756368346509;
        Thu, 28 Aug 2025 01:05:46 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327ab0f20c7sm1600294a91.26.2025.08.28.01.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 01:05:45 -0700 (PDT)
Message-ID: <b08aa8f4-7283-40d5-9f5e-ed8697f882a9@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:35:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/10] Implement vendor resets for PSCI SYSTEM_RESET2
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
        Florian Fainelli <florian.fainelli@broadcom.com>
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
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DQDbbfNvg3CeD6n5sUse6I0L4lfEtMxC
X-Proofpoint-ORIG-GUID: DQDbbfNvg3CeD6n5sUse6I0L4lfEtMxC
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b00ddc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=YvEvsVr50XASBo1Q0dIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX09OlOkOuZRD3
 XKRA7pCTJIeiZ+g6Cgbg1iLhYcNDc5thkMWtYm2awIQ8dOdPIDaELxq9LC48g1RZzvRedz5xA1C
 8z78NsJvFdTHRrx0fzTN9JhQ70oZbkVjfnCj+djOYDVGVBTlm6Mm/kS8qh56b/+ah8R/ft4vD0q
 /2gus+FBbchLzxyVZLZALq+YrZ1fKQ1F38aQQibqQRB7bcLbVYoPOpffp9skWLNM0Ut4c2W5+0b
 ey7blbxD7lXgUFA2tgOprhmC+7Zk+aRjFiSB734oV0sDgMhAR8jNpsbkOexlIjQstgfEV5EC36V
 I7xkvtyvKq+lIMLQwPq4O2Z2q7gAi2D0cNg/rI90GvOUqxsiESJPGNSfLVcMtioit8q4Km1ULIR
 y+victsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031


On 8/15/2025 8:05 PM, Shivendra Pratap wrote:
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
> Previous discussions around SYSTEM_RESET2:
> -https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
> -https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
>
> Signed-off-by: Elliot Berman<quic_eberman@quicinc.com>
> Signed-off-by: Shivendra Pratap<shivendra.pratap@oss.qualcomm.com>


With this series, 'edl' mode is working fine in QCOM's IPQ5424 SoC. So

Tested-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com> # IPQ5424-RDP466


