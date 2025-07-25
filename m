Return-Path: <linux-kernel+bounces-745677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E3B11CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EE61CC79E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330F2E54B1;
	Fri, 25 Jul 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OTFs5W29"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378582E541F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441134; cv=none; b=bZA5MUbEs8OvuQZUgQQ+WbbCo7vFJetYenQDfaHhVsaM1W9LVr5Psyc/YbqbPIGU5HAHvfep/pMXyoRKBq/WCdzqw7o4x+0SJed2YNxmckDRZN+lvP9mTahvvkgJl8U2Zf6C7ksrK2kI0Kvgd2Wyh4x41FYGAbRqLl39QNF8d+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441134; c=relaxed/simple;
	bh=JSdqNAliPMTeWFGkFGa7l9KyEsQZmwUCxwW/WKeui2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtNaqkeIQ34CDPgaL1tLjyVMn/6Ly+5BufYwMTP6gNZcB0yMo2s1IHoqbdusDJnMro3IWbk1hcurIoUWnqJu4PAhb/5+iO+gh/Gkcju8pbpZzrVs6uycj3dekXDpxTK+8Kz7eZfkEiPM946cETJLlq5sZ+QSgLCTSnwQ/4gY0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OTFs5W29; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P88iYZ008699
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fc+K/K09v6Pjm1qZcv9s4rQ5
	4FX/fpzKyJJ8Ta7tUJg=; b=OTFs5W298655IRqNBfEvRrC85pWtP0sXQhL2XMkk
	uOdiFToErD/MaVJnbUdkClnMMMPJSb48o7eO20T932kWcTAShk2b/tL2rrkQzkxn
	ftsNOCGsxKeuUas8YznoMQzHxEzEzFELSmd91xspTj4pfBdYHsi89fCV+9w4fZ1p
	CSZDCa5k0JshLeXI3tasgxfUlUz0pEP5RdEuD3S9DTOYrKLPLQI4/8gfThcj27y/
	Rv0uraMOGZ7JVR8rJF7c+tkOh2bP5fRM5uGEiBlqHT+6EpdrR3gd/e7aShdIClrF
	sjCCYkNgTOq866Bk4Zvu0yLit9vS110zck4WTwbgUzXbNw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4846590f7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:58:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2c8137662so404978785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441131; x=1754045931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc+K/K09v6Pjm1qZcv9s4rQ54FX/fpzKyJJ8Ta7tUJg=;
        b=ivGyOjSMyyOcOR6sdIDzp3oEuw8316+z3lkXTy0Hru3Ogizj8qykbjjThXBfaMqc/m
         h5QTY2JYe87d/Y2bWxFcRFd4yE7cM3YGXlxOc0Sl9SAGz5x/oRbuqE/XFYWj0H5Gcrpl
         +RVdQhPr6F/tX546uqmswolxZ2UkgUlOTyuevWbCaPzffbfN3/M5TqOmG1IwzICF62kN
         j/hEyC3SIF6x+jOwoOOoc97bHTzO4RWP5B43DZ04zgkMlCRH0UC4HgCpTO3pTKj6XXkY
         PDPlIqlcV4Jtjc44jV0u+Ytz5cv0MqlLW1ArLz+ZwqfouoKBIAwCGw6J7UVupRiRUH2a
         PPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBZErXjsUcQVdEJ9BakaOHvmZ+gL4mUx0JxnYA2GbLJON/B++lnocavFp1AHFA/vwmVNvAe6HJWr6QIdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YnjbTY6+5jxu9KufGiEsRKiesLjQdRb3IFILoN8r3KpYc19w
	pZTjy3siLqOKQ+2S8f2yIU+YFo47XrHrhfu7++7Xvt+BTjOWh4B3QFFUXQB1ZvdjcM7+8Ce2zDN
	zmnTEZCe/zELiKSY7I+JExgW1k51rqS6Jidz0+O6G7NxjXLszf/7eo8pDBFy1hToI2xQ=
X-Gm-Gg: ASbGncu0ONI8ghGN7TAHMe3yhMS7M2+4lQNY12yM02f5pJgcnl8aYGphgVdE2CDnq6o
	Jpjj79ckgw4TiTit4pXknlcKVrbHaxgm8y+EpW3EnPdijkKrGCCUInBrzaG/5yIxmD/xZErvF4n
	zJ8Ox/uYfClm/WW9iMlFiTqLe5SzautA7GgnSqp+I7Fs1CL05J1/PWZlJ20pEyXQZcnUGfSTj+p
	0nrAY6Esm6ug+J7zrLSL2hcljZX3p/QwS7/YsU8lKQDtbpN8LKH9xAb+eLvP3FCxi09ZCtwDuf2
	0sOVdQ5IipkFkXNdeNToGm4mWsOSVgZhVKsZci640lizkFPmnldNBH8T7bK5jaiKXFM9gpeGw1i
	YrVSy/4CcP6QgQNAk59OIY4uDygOGZVxsrXo3ohCqVd8huE3rEnx8
X-Received: by 2002:a05:620a:d88:b0:7e3:4fcb:4f2a with SMTP id af79cd13be357-7e63bf51e5dmr124512485a.8.1753441130733;
        Fri, 25 Jul 2025 03:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2ENeOxfOJSO5X9K0+/zLWicSxsuTWZSbLuZMJbscME2E/vfnxmZs2kgSjs4iFhOgNTo3Viw==
X-Received: by 2002:a05:620a:d88:b0:7e3:4fcb:4f2a with SMTP id af79cd13be357-7e63bf51e5dmr124509885a.8.1753441130266;
        Fri, 25 Jul 2025 03:58:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c715b3sm860234e87.84.2025.07.25.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:58:49 -0700 (PDT)
Date: Fri, 25 Jul 2025 13:58:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Flatten primary usb
 controller node
Message-ID: <bqfmhif5fksohr7iichslnyocaxcz3o7fp75wuv2576pnkndhw@l2lttn4opps6>
References: <20250725050216.526327-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725050216.526327-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 9Sg3_SnlySNWhrbWdjEL-CklsO7P46Sl
X-Proofpoint-GUID: 9Sg3_SnlySNWhrbWdjEL-CklsO7P46Sl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA5MyBTYWx0ZWRfXwiJ0SbGSKB7k
 +vsr213zZMySMUvazN1RE7Sw0SMblxt4ZpqoqQjz42VbJH61+jSbQ9dE4VYrHWujx7hdY7yE4vk
 GpoimD9cmvpmoJgpU66Lo+fl99PydsxkfVMK6mHeJUi76GM98QoAeXHGy49pVAMKimiPce7WnC2
 yrCfgtKKHpknZkLmd47INetsJSBgOnddpdLExckYMDhoSDJwcHzj5l8Te9rY/40vvfzuUlOjddW
 z3u9JvIy/gMv8C6PjIpdTDwyRxtqSze511Btid7C5tj/0WKbCoooKUIiWVqpcsLscxCdTjclv+h
 Gb2Tg9RErEo0sRNJpb+CBLpJZHX+L7f9s1vijP0ym6KMzh1yKhCAge0AR96OmRkhuvtYAjvETQz
 gE3ngxQ8rm8ZHjj3iA/15jjqgnRgkWg5nIxeGfUvHQ933Dty3Z+GZgh0otV8wS74nV8WTSeq
X-Authority-Analysis: v=2.4 cv=Vo8jA/2n c=1 sm=1 tr=0 ts=6883636c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xNPlZoMqyQeERECHpiUA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=973 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250093

On Fri, Jul 25, 2025 at 10:32:16AM +0530, Krishna Kurapati wrote:
> Flatten primary usb controller node and update to using latest
> bindings and flattened driver approach.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Link to RFC:
> https://lore.kernel.org/all/20250720072125.1514823-1-krishna.kurapati@oss.qualcomm.com/
> 
> Changes in v2:
> Fixed base address.
> 
>  .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |  6 +-
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  7 +--
>  .../boot/dts/qcom/qcm6490-shift-otter.dts     |  6 +-
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  6 +-
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  6 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  6 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  6 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          | 59 ++++++++-----------
>  .../boot/dts/qcom/sm7325-nothing-spacewar.dts |  6 +-
>  9 files changed, 42 insertions(+), 66 deletions(-)
> 

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 64a2abd30100..6fd502df9c7a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4253,13 +4253,9 @@ compute-cb@14 {
>  		};
>  
>  		usb_1: usb@a6f8800 {
> -			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
> -			reg = <0 0x0a6f8800 0 0x400>;
> +			compatible = "qcom,sc7280-dwc3", "qcom,snps-dwc3";
> +			reg = <0 0x0a600000 0 0xfc100>;

This should have triggered a warning. It should be usb@a600000 now.

>  			status = "disabled";
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> -			dma-ranges;
>  
>  			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
>  				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,

-- 
With best wishes
Dmitry

