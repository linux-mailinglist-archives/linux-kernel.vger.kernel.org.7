Return-Path: <linux-kernel+bounces-753546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1DB1845E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E25584700
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796EC2701C2;
	Fri,  1 Aug 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FnxKGBCc"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630B26FD9F;
	Fri,  1 Aug 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060349; cv=none; b=rI980kSowg1diKnV/uHk3W5utfeN3JGOXqZZXCq0C+3iMw1ahtR8InFBVEoasnUJt3CXT2DhYQcskT8vd111LcXkLYOiG22F+Rmt88d7S/Ci4YOxkKgfwjhrxbuTEeLugmBTUzbkk4ztBPyQhLKgfM6SMxQ7JiQAUx5S8TZMdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060349; c=relaxed/simple;
	bh=Lq0aIcPlnj15bFXUlVgonA6iL+BwMuJ9s+KloXqlZL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRJ5JPN2h+ptB3UiF7frQpyjNj7BtJ2krz8cpwzS33933zyzNXbXW/gsmpYdEzrD2Hl1TC7xpopmG0U8IVq7xSiCYUAMxG0OGeFcB0C9uFED8/m8B4t04r1nr6ZYHRuxHN0qJ3Fpb1A2dE1JAmx2VVDphTV1mGU+QZkSdq46Gss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FnxKGBCc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571Epg9s022019;
	Fri, 1 Aug 2025 14:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fBkqA6
	O8XFb9jrDXTfu9y4HzkdrpUu5EZ1VopDxCMsw=; b=FnxKGBCcAW/fxk6YZmeFEe
	0oJ3+dLdR1XnQZV3z6kNDqpdrClyEjKqfnMo8dGNbG/qTfc9UcH3nDrf6hBasqe8
	Tk0kHqmaw4zxL56eNHbQIs5TgFn3SDgXDnE7nPAprdSaYqBMbDIKEer42Vn2eo+L
	8EAu0m4XxBPSz8uI/3kyRajVtLDRCvThMfwpfQRl7vioLAG7j+N84rKe8WGyPO5I
	xy6iMi0ipeUceJipHJQ+A8LKrGBEIBEWGCshhXaCGIwfGNMebrirtbe02iSwMebN
	7D1nuSEaQJ/fAZoVyD9a/QVBwIv+R71MVcPSaaXH+/9OZTvEjm7LUIjYiacKrFug
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen9d8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:58:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571EfU7s018665;
	Fri, 1 Aug 2025 14:58:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abphupe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:58:44 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571Ewh1R5768312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 14:58:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 608615805A;
	Fri,  1 Aug 2025 14:58:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 160B758051;
	Fri,  1 Aug 2025 14:58:43 +0000 (GMT)
Received: from [9.61.163.64] (unknown [9.61.163.64])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 14:58:43 +0000 (GMT)
Message-ID: <5e0f216b-377c-4a1d-82a8-ead89ce8f574@linux.ibm.com>
Date: Fri, 1 Aug 2025 09:58:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ARM: dts: aspeed: Add missing "ibm,spi-fsi"
 compatibles
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
 <20250731-dt-fsi-cleanups-v1-3-e7b695a29fc3@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-3-e7b695a29fc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QeL4sFszgK3OLRjN63owadCyrhutvObI
X-Proofpoint-GUID: QeL4sFszgK3OLRjN63owadCyrhutvObI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDExMyBTYWx0ZWRfX3U+KVHfRp5r0
 WIME/XvpXG9le6ptKO5m25qZHDqlH5V+JgbdftMa7pLdlIHBbhhce3So4h9qIYhUgLPW8tugv+Y
 nj3nH7XrGkAPMoQrlD7BcnDpHyr3307zuIe70SMIchnmzy4Nh3cPS0ScchE25TAMT0KUUS7lL+s
 954CwjRYDmsT2cT2KN01UsFArYwtCMKQKnxa2zTh8sLWvPDEoTLwj/lUIPAukiB/GVNbUolQ/2/
 MuUKYsNdVGyplJmRObDOZiyKAjUB6XFu959zZJ15FpouB5tQ9jMI7A+x8cEjZT4Uk270bY4vIXA
 QiM7k1HF/Stg9ZapvQqDXihn41cEYS6S/xp6hSESBOf0HTKjsspVhpC9ATC0CajqV6fHFVpy5vU
 s4VSQ/ComJ5XLc3KMrGFk8t6TxsemE4M8HLwSWuD6EJLvScFzLVv60DQwz48jZ2O87T2aNcH
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=688cd625 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ydy9chFN_R5lqbIoMqEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010113


On 7/31/25 17:12, Rob Herring (Arm) wrote:
> The "ibm,spi-fsi" compatible is missing or incorrect in various nodes.
> The incorrect cases used the "ibm,fsi2spi" compatible by mistake which
> is the parent node of the actual SPI controller nodes.


Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts | 24 ++++++++++++++--------
>   arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     | 12 +++++++----
>   arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi     | 12 +++++++----
>   3 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> index 9961508ee872..52a044b1e454 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> @@ -2808,6 +2808,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam4_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -2824,6 +2825,7 @@ eeprom@0 {
>   			};
>   
>   			cfam4_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -2840,8 +2842,8 @@ eeprom@0 {
>   			};
>   
>   			cfam4_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -2857,8 +2859,8 @@ eeprom@0 {
>   			};
>   
>   			cfam4_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -3181,6 +3183,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam5_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -3197,6 +3200,7 @@ eeprom@0 {
>   			};
>   
>   			cfam5_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -3213,8 +3217,8 @@ eeprom@0 {
>   			};
>   
>   			cfam5_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -3230,8 +3234,8 @@ eeprom@0 {
>   			};
>   
>   			cfam5_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -3554,6 +3558,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam6_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -3570,6 +3575,7 @@ eeprom@0 {
>   			};
>   
>   			cfam6_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -3586,8 +3592,8 @@ eeprom@0 {
>   			};
>   
>   			cfam6_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -3603,8 +3609,8 @@ eeprom@0 {
>   			};
>   
>   			cfam6_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -3927,6 +3933,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam7_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -3943,6 +3950,7 @@ eeprom@0 {
>   			};
>   
>   			cfam7_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -3959,8 +3967,8 @@ eeprom@0 {
>   			};
>   
>   			cfam7_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -3976,8 +3984,8 @@ eeprom@0 {
>   			};
>   
>   			cfam7_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible = "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
> index 07ce3b2bc62a..06fac236773f 100644
> --- a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
> +++ b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
> @@ -82,6 +82,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam0_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -98,6 +99,7 @@ eeprom@0 {
>   			};
>   
>   			cfam0_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -114,8 +116,8 @@ eeprom@0 {
>   			};
>   
>   			cfam0_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -131,8 +133,8 @@ eeprom@0 {
>   			};
>   
>   			cfam0_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -249,6 +251,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam1_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -265,6 +268,7 @@ eeprom@0 {
>   			};
>   
>   			cfam1_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -281,8 +285,8 @@ eeprom@0 {
>   			};
>   
>   			cfam1_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -298,8 +302,8 @@ eeprom@0 {
>   			};
>   
>   			cfam1_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
> index 57494c744b5d..9501f66d0030 100644
> --- a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
> +++ b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
> @@ -733,6 +733,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam2_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -749,6 +750,7 @@ eeprom@0 {
>   			};
>   
>   			cfam2_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -765,8 +767,8 @@ eeprom@0 {
>   			};
>   
>   			cfam2_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -782,8 +784,8 @@ eeprom@0 {
>   			};
>   
>   			cfam2_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -1106,6 +1108,7 @@ fsi2spi@1c00 {
>   			#size-cells = <0>;
>   
>   			cfam3_spi0: spi@0 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -1122,6 +1125,7 @@ eeprom@0 {
>   			};
>   
>   			cfam3_spi1: spi@20 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x20>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> @@ -1138,8 +1142,8 @@ eeprom@0 {
>   			};
>   
>   			cfam3_spi2: spi@40 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x40>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -1155,8 +1159,8 @@ eeprom@0 {
>   			};
>   
>   			cfam3_spi3: spi@60 {
> +				compatible = "ibm,spi-fsi";
>   				reg = <0x60>;
> -				compatible =  "ibm,fsi2spi";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
>

