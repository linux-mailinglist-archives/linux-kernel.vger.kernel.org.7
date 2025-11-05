Return-Path: <linux-kernel+bounces-885629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E43FFC3381E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64FF14E48A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF5523BF9F;
	Wed,  5 Nov 2025 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8qH3CG2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DCZtTfAm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1722A7E6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303624; cv=none; b=Uw29BI2mnda4AFLwAyX/xFkk7Zm9LSsr56ePznx++UHiiofrxQsYUXxYI/CZELFQavLuUXDK7mvvXN/BGlGA3v5m1ULKPPKod/Txjqwqa97Kr8hhs5WDNWmC7GHYHmmkOGfQU3CjiK44ZXza2DO8cSHFhH4zJsb5L4s1Xl6FYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303624; c=relaxed/simple;
	bh=6F8Ze2HqT338sAZLldmfyih2VX+hoXm90QpRHVpFcA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJOekmOXZBJG8W/ZQIkskBPOxdtW/pduVhm+7AfJQScQjso/lPuGxQ3LkVX8BL0cvaJmGauZMa5m5HVULSD4OzeGZqigMTEv/oRCfdzc9bk24HoAMomEMSBRDCWr+FRVS+8IBkDoBcIecnVxgj/ki97cITx/awg7SqV8na9L060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8qH3CG2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DCZtTfAm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KfeMW2927473
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 00:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=20DVmm7uuh12nXsj8hrA392r
	YXJpIcLN5xeBu9rny2Q=; b=m8qH3CG2VGn2+/23AvEF4QD+vI3GWfmZAryiX9df
	JxnDeT+IIkincnsOzjeClIbX2XV4jmqXC7K3rVmIjDAzjd23JkhNDYlvPlVBKv+r
	bfaV2o64BFn0S6DS/a4giayUnYKvoyAT3TwMz/oSXYQllG+yjuHNoWRO8+lbG3pl
	FsUR8tgRrPu0pnL/UklFxbVhBC5YWctOt3IQweTqmn7ZTmz4JQ8qkuWOoGfbhgS9
	X8woIPsicN4rHVUhiJ2/mlxEDc9kZLHLX/RH9jikOAMZxGMRLsUFHxlUTTBz/oBU
	mkWXpa6eXOYrPnmr1m1xZnAtq1EO1zTqe3lZEc8iwn1/5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7me5sg8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:47:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2217a9c60so122869185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762303621; x=1762908421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20DVmm7uuh12nXsj8hrA392rYXJpIcLN5xeBu9rny2Q=;
        b=DCZtTfAmZEBfbJhHIHblDf+akQk0PgX7GzI/STqSFvE54TrGQO5B3NgMg6WBTyShxb
         S4mKw+fIs4Xyr0IuXYEpm9D+xzUkcE4HgUKqHH3NOTKUmSaeggF4QbVh3zAil2P8ib81
         v2igHsWlrPkaJ5w4KZm0Fmfs9xO6SiGHDwp8mFu/DEdKuvyots5MvpoYa0NeHKac/kJA
         kwsfOfrwf37If6Sh13V3xP9cjpFLg/KOLVkkjvEQTTg1506ROTJhB0/xCi0eqvB5ck7S
         Rsk3dy1pgIpHsZZ0njismTbxbyb4E4J/h84RsOs6dA3xt7VNPTO9wdvC9BBdNPcusqZp
         t0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303621; x=1762908421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20DVmm7uuh12nXsj8hrA392rYXJpIcLN5xeBu9rny2Q=;
        b=mU2RcWIMX5tJun6q58C4o95ET5JaSle9caazw59IQxrMzAvRc2THJgqW8gGWxeb1sQ
         DyXuhQRoFklBlnqr6idGkG2IAGELNyfzf/u7StRnSm20lv6AHlJUPKke4v9ZYvJA5kJb
         R0FadU7b1+df95s+u9pZdtMKQUpc4W37655BzNlKIg3QcqrARH4a+q8pFNLgIN24hCjt
         O6u8a4RMhArGt91PIwxMNBZgymmtvDMSLDDvqLTT4VukrHJ+G3d0mrUxU5ga8KvyuLiN
         iuuqxBhAZiHywNaPPSErQgpx2bhqJZtrXQ7DCdSAvybLckkx7W4lYJkCouImzuTRbP/D
         OnZg==
X-Forwarded-Encrypted: i=1; AJvYcCV0aFpuQbVO9sbRejv7Stg/rpYjnM6YQeZIXKJNuHciozNTVaw2u2OlF9vQ8WQkWqNj5P8y94IZj0s77N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65t60zccs2AkrQZjKboXiOl2JN3IxFMnTZAPZ8aPv4oUIo0S0
	8gAeSkmdpWe+K/fssdyBjZnAn0V9W5g0mIdsxqrYfsL+4mBxSB+1nqrTwP7s1e12eAjJJZLaKiD
	fLxvaOXnDvyDtsWWqC/0LYqSy3p+yQ9VoeVOoSFGt9eDQum/Gzo1D9o03ihrQTZ8LXGw=
X-Gm-Gg: ASbGnctNkshYkUISsFoLPrs4tMx18bV0lCMzakZqZMy3+qUIsdmEZ+BFjWuptAxtcmV
	vChH655aTqssUpvV3tUIDMv4dNO6n3Q9fahpiHIZWC62R511YMvu5XNRmjHA/IaNKN9R1gk5W1n
	QvNfLwRLhJPdxkRWK2Bba4UDMavjS5LjbxSXNC0htEOLKDeb49m+4S7NHtKyP2XaGvGxYKUhJj8
	/PpMDOT3+DPlhsgNY3FI6cN+fTrwNFsdmWgN9ffchD8IqrW/RkMsV4Wi49cZ+T9O+S0S8gd4Km+
	Ev4cZh6NJpW5RpdsIFMswqdunuUXvcK+B8UbrA0zYJ06HhsyrkSA9jhDD0BBoruafDnfjTK+76d
	B/hycI836SA8/0rhKMyxM3Bje8e7DJMryk93ZdVCU+i+nKX53ZRIVG2RuJk+suGbTZ3OZunz8gA
	DN5XmoS18XuAFl
X-Received: by 2002:a05:620a:4044:b0:8ab:7ac3:3271 with SMTP id af79cd13be357-8b220b14872mr232600385a.36.1762303620851;
        Tue, 04 Nov 2025 16:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMkUX7jC+eXTRNJvJBEYnUpg6UwMXTsq4CChhPcvUGcohxQhFgjhegR3VopNF4Y97oL3PhWg==
X-Received: by 2002:a05:620a:4044:b0:8ab:7ac3:3271 with SMTP id af79cd13be357-8b220b14872mr232597685a.36.1762303620300;
        Tue, 04 Nov 2025 16:47:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943437ed06sm1178233e87.16.2025.11.04.16.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:46:59 -0800 (PST)
Date: Wed, 5 Nov 2025 02:46:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Piyush Raj Chouhan <pc1598@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, david@ixit.cz
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8150: Move usb-role-switch
 property to common dtsi
Message-ID: <caf3qjqs45lbmb4fb5mj7qordkh5yb37iftwro6y6jitn5fhj5@eb62whwvo5g4>
References: <20251104221657.51580-1-pc1598@mainlining.org>
 <20251104221657.51580-3-pc1598@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104221657.51580-3-pc1598@mainlining.org>
X-Proofpoint-GUID: 2YjBb-jOhGSxf7bUWtPCNwkKC92N49JB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAwNCBTYWx0ZWRfX5lB77TMk4r1k
 WJIHm+H5zLiMCvCLt1KFO5s8C/liAPlOI63qatFz7cKbS8XVKNIMDM32UrzLEzRyZgtzEA3OsLQ
 fMaVLHFYIG2eKx7Xn629zWG4L4POvXRzyu7joL8L9odMbKKjqDR0vaHoZ6pvODWx6K3Dt7lRuyj
 8kbB3/raFL37JSQN8dJlIMB9e4qZrU7owLZtob9dxwbPL68mp6oT+N5w8Rhdw0qY+2+Kfk9zbdF
 pb1WbAjKBOKTcB3AAaq22kJDBi/zoWHFEbfhD+VINaWdSDLzwjB7dRY+aSDeAEymOLzdsyzu9oM
 XVWtGTnypLeiwTDCHQzjMfdrzIIx1B4dN21ukcPBzljdqvZNEs3lAAAQiiF/IYEN0+KMQqGxZTW
 0dePAP5WFou2XNRTcKVfVdwAUG2Rag==
X-Proofpoint-ORIG-GUID: 2YjBb-jOhGSxf7bUWtPCNwkKC92N49JB
X-Authority-Analysis: v=2.4 cv=IpsTsb/g c=1 sm=1 tr=0 ts=690a9e86 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=qM2R4nZWQg-DivYOzAMA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050004

On Wed, Nov 05, 2025 at 03:46:56AM +0530, Piyush Raj Chouhan wrote:
> Signed-off-by: Piyush Raj Chouhan <pc1598@mainlining.org>

Missing commit message

> ---
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 1 -
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> index 0339a572f34d..29afee6160cd 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> @@ -693,7 +693,6 @@ &usb_2 {
>  
>  &usb_1_dwc3 {
>  	dr_mode = "otg";

You can drop this line too, it's the default.

> -	usb-role-switch;
>  };
>  
>  &usb_1_dwc3_hs {
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index acdba79612aa..cd05975dacd1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3661,6 +3661,8 @@ usb_1_dwc3: usb@a600000 {
>  				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
>  
> +				usb-role-switch;
> +
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> -- 
> 2.51.2
> 

-- 
With best wishes
Dmitry

