Return-Path: <linux-kernel+bounces-853415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88241BDB98D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4B61925E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488930C609;
	Tue, 14 Oct 2025 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KCrUZjem"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B12DE6F5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480158; cv=none; b=d7fVqmYV2PEzZOZ7WhXWOUeCytHvOKqOuOfEFnma1yhgYkBJ+LZES7cHgcJO//0+hwoYS+pZ7COd2GrVr4mLY5uKFRC3Oiu4Eh/fgnyVUQVIBAXlAEtFhUleC1D6y3bT62bphPLN7Qmb7KjgEcKeqdVDdYCx9F/pLY50qYN+4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480158; c=relaxed/simple;
	bh=M1j8XJ30eYUAcq6WGW4g/VpJ8uFOzrAajOSPXNfUTzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE6WfxITybTkPSsTWqwMUd3E4Dyy7wlheo8XJFvrO8Tlt7DjTKbfxmv6QsaivIbzwvPCymgAUOiocycaIIPJ9iRw+XPalMW5jLxhXiCm3QldmcT5E8NBpT6MA01EbFn0bDpOD/jK1+DlifYBqzf2T0YRNg22mhmRnUYxQ9bvyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KCrUZjem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKSS1x018419
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dO8P+KcI/d4Q8sn/1ijHLrD1
	nE6rqhU8O9CVWEaotTo=; b=KCrUZjemirsScd6We+F96ZU48x/Bqrn9hDPBGz/x
	8fJOgcczJWxMsYS/s+FaCi1AFaaDgb0Kty9Vd7r8/0RIPMThJX17tP3H5AkQBuff
	XEewIzafvzDjwIlwI1eNLy98PtsvBKnLKq+/pV+nF0XxJ/agln6Ngaoc1jV3s3Zn
	AX2WvGeEJUubf5DSRNgDDpoQKXBX1nTyLi4g7sRQoZtF7anAcdLHTDICKvdS3xFT
	we5yaqmQE6AEElwLJSy3LG8p1LOaBUp/mDLW4fR0aFssuHSHhmVQwlX3gU+vGUaX
	tSIgIO53siZ6uZw0shQAZdY9vqQojLcF/G+xt2EBo3QApg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c24hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:15:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8544316ef6aso1512101385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480155; x=1761084955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO8P+KcI/d4Q8sn/1ijHLrD1nE6rqhU8O9CVWEaotTo=;
        b=vQB5gwURJBSGgKLVqz5XWzoo3kMKppe0FzbkqotC4Q69bZ3HevjG+MGFx6LNEm+2mN
         OLIjZJVbRp/YtwL5PsmedveKpYPd2zzmSHEDJw3y8LNvWwZZfR3zzktbIPsctSQpYJHo
         yl7Xg770JfxFN+YGcvKp+kUAMw5UfJMMWFSVWmqcsAvxb2+DGYtf+Ba+DDH8P2zbljn3
         ftYxZSw9NW7jw6u78mRMkp5CRQ2KphsWCqrYbHlLuXQ6I637NPy+fBrai/2Ael0RtIfK
         2Wxg2Y36JwQmwuQIvRIBWS/BeY8dh7c1wZ1ZMCHmpCGXG58TLK7bLtRtP7F6/Y+k98VX
         4MGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyDouqohP3embAw3JmpXrgfIJM1Ri3GmfA/fDONxZ8o4FhBOTEvwOFgIyA0FSl88QClLr24/47etrvQlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+Q1n3g1awXLUdgHLEUdnnFDrGmsbGPRxMSa3WLUXztV5ScSV
	1OadzjyCm5QilGBmgynmVwK8Cc+7FJFTfMT/oUElkxfay4co4S7aaq350J4WCWCHbMJ12XD6vhE
	5dRKNKTzMgFVUqDrqg9hQ8me3bb1nBiHzERWnXhXg2QVMy6Fj6AeCpS8erl40KXnNAwc=
X-Gm-Gg: ASbGnctbkU9cpSb0zL7dDlZPDKhxBR5kdjs/6jr2wPEMj2kZHRXrMYbpd/gX5o9MKgg
	ii2c8XaP/7bgA76gZ6fPKMTqZVzXTbWRl43tW7y3GZnLmwsu4zsVi69wSJXPlR+1DPmu6D0dyuP
	caMH62x1mEJmfbMmvnGG5F7HN3vznTtarssHI3YmTK9o0qSJtauMgLiN7rBrNEy+w/KblISw/aP
	0EzTfy+6byULO8gOOAPn8YV28aBj35IeHb0nFr+OYqoM4XOgwQKkGONi/3B2vAkRKO6MbgXUvOC
	l5VQ8RDwOZQ5Fs3XZAiZFVnuPJtKej5jVXGeZpKX5/hy+5lELaEFlwcG4FsF3UeMqXFI1l3a6zw
	pIuO+gszJ6SNg158IHv8f1WBY0SeE0l+blicEO6Ydpq0jAxlOfiMD
X-Received: by 2002:a05:622a:1a20:b0:4e7:250e:bbc4 with SMTP id d75a77b69052e-4e7250ebfe2mr130807071cf.69.1760480155066;
        Tue, 14 Oct 2025 15:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs72WZFEkjmQ1dyXbFz1Ye6bDNuzPRKg6wSnnk2SHSqHCWIZhOamKGqEdqEJtiaZPNUA4MTg==
X-Received: by 2002:a05:622a:1a20:b0:4e7:250e:bbc4 with SMTP id d75a77b69052e-4e7250ebfe2mr130806721cf.69.1760480154462;
        Tue, 14 Oct 2025 15:15:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591c20253bcsm957863e87.99.2025.10.14.15.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:15:53 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:15:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add support for QCS615 talos
 evk board
Message-ID: <wbg34hghu4gl277ppitctxgs5swlchjyjk425cjf4sbojlymlj@ca62bvncptny>
References: <20251014120223.1914790-1-tessolveupstream@gmail.com>
 <20251014120223.1914790-3-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120223.1914790-3-tessolveupstream@gmail.com>
X-Proofpoint-GUID: p_oQ--gP1F18NsuYr7m4iEl9jgfs5S7r
X-Proofpoint-ORIG-GUID: p_oQ--gP1F18NsuYr7m4iEl9jgfs5S7r
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68eecb9c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=4ClYx_WmNUqONUsMR88A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXyFNue3IoIbAh
 uqxq/j94zt0/l5XcpEfzsigGR57GsbGRlE34wvbcHRaqA+xo2/s1JNp4hWQZYYYywb4HZjfdPYf
 oeCbvDVoAenXqripI5FFlXP1s4jVeRQ8zMRZLiwGCpeAI4sUF9pJm/YBeoVIg+3Eud2/gY8JHWV
 uI0Z+mZegUjiGk2xshTRqLFTMkJ3wjAh1cGldX431y9GAhNV0tmvTZhgJNC3GzlNKj4TFlQOw0o
 EikpjBQCTtGs9nmjDRq8w4bRbcdFDnAcGrbhyhQVc/O3Pr712Q+qEkMp5gyEkzTQMctGQDmXIEQ
 f/b6SCzbJgkGXjWdv1UA6ZxwDyf6dLoQZV2DwPbM8efA9q/Z/ghwS3FNlXrfAi4Ycn9PyUs/o35
 vwR+ms4I5qUQ76UA70T/Jrm5oMT39Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On Tue, Oct 14, 2025 at 05:32:23PM +0530, Sudarshan Shetty wrote:
> Introduce the device tree support for the QCS615-based talos-evk
> platform, which follows the SMARC (Smart Mobility ARChitecture)
> standard. The platform is composed of two main hardware
> components: the talos-evk-som and the talos-evk carrier board.
> 
> The talos-evk-som is a compact System on Module that integrates the
> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
> SMARC standard, which defines a modular form factor allowing the SoM
> to be paired with different carrier boards for varied applications.
> 
> The talos-evk is one such carrier board, designed for evaluation
> and development purposes. It provides additional peripherals
> such as UART, USB, and other interfaces to enable rapid
> prototyping and hardware bring-up.
> 
> This initial device tree provides the basic configuration needed
> to boot the platform to a UART shell. Further patches will extend
> support for additional peripherals and subsystems.
> 
> The initial device tree includes basic support for:
> 
> - CPU and memory
> 
> - UART
> 
> - GPIOs
> 
> - Regulators
> 
> - PMIC
> 
> - Early console
> 
> - AT24MAC602 EEPROM
> 
> - MCP2515 SPI to CAN
> 
> QCS615 talos-evk uses a Quectel AF68E WiFi/BT module (PCIe for
> WiFi and UART for Bluetooth), which is different from the RIDE
> platform. Plan to enable these in a follow-up patch series.
> 
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/talos-evk-som.dtsi | 435 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/talos-evk.dts      |  42 ++
>  3 files changed, 478 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts
> 
> +
> +	extcon_usb_1: extcon-usb-1 {
> +		compatible = "linux,extcon-usb-gpio";
> +		vbus-gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
> +		id-gpio = <&pm8150_gpios 7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb1_vbus_det_default &usb1_id_det_default>;
> +		pinctrl-names = "default";
> +	};

Given that we are trying to switch to flattened DWC3 nodes and we are
not going to support extcon in such a configuration (commit aeb0169217eb
("usb: dwc3: qcom: Remove extcon functionality from glue layer")), I
don't think this is a way to go. Please add a proper
gpio-usb-b-connector node.

Also... This is not correct if SW1 is switched to the USB-Host. The ID
is still connected to the micro-USB port and so it might generate some
unpredicted interference. Unfortunately, DT isn't well-fitting for
describing board options and SW1 is definitely an SoM option. Depending
on its position the EVK should either use this gpio-usb-b-connector or
an onboard USB hub (which ideally should also be described in DT). So,
it feels like you need two different DT files, one for each SW1
position.

> +
> +&pm8150_gpios {
> +	usb2_en: usb2-en-state {
> +		pins = "gpio10";
> +		function = "normal";
> +		output-enable;
> +		power-source = <0>;
> +	};
> +
> +	usb1_vbus_det_default: usb1-vbus-det-default-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		output-enable;
> +		power-source = <0>;
> +	};
> +
> +	usb1_id_det_default: usb1-id-det-default-state {
> +		pins = "gpio7";
> +		function = "normal";
> +		output-enable;
> +		power-source = <0>;
> +	};

Do you want to also describe gpio8 here?

> +};
> +


[...]

> +&usb_1_hsphy {
> +	vdd-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +	vdda-phy-dpdm-supply = <&vreg_l13a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_qmpphy {
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +/*
> + * USB1 port supports both host and device modes.
> + * By default, it operates in device mode.
> + * To enable host mode, set switch SW1 to 'ON' position on the SoM.

Is it device mode or is it an OTG mode? I don't have carrier board
schematics, so I don't see if it is possible to enable VBUS on the
micro-USB or not.

> + */
> +
> +&usb_1_dwc3 {
> +	dr_mode = "otg";

JFYI: it's a default and can be omitted. Only host / peripheral needs to
be specified explicitly.

> +	extcon = <&extcon_usb_1>;
> +};
> +

-- 
With best wishes
Dmitry

