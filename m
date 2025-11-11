Return-Path: <linux-kernel+bounces-895376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D04C4D9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B8F189931A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5F3587A2;
	Tue, 11 Nov 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aP+bf9so";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLn+Irka"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304435581C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863234; cv=none; b=ar8Jydm8bLo2zKvBXDy+qx19V8suakM4ipYoiSfGIhKSy0gYTo2jV6t71cq9OBtVXGFhoHs18vkHFSA50TnQz2UkvNPbYEs1ZrmUDvzD6UgZ8GKzReZ1Zf954sCOuF6vbKMcXMIinfNTQsQGiH+udHzKm7Miu1s/EXawQu2zYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863234; c=relaxed/simple;
	bh=xdmR3eERZWwZ05yyx09SGkEALCl2y3uliCa5xdEL3Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBpAG2zDKnYNVJdVr3A3xe7IYXRT9FccN9MIlBC9JQtQrKc7Ags6gPpFJ2MpnQe1WRWDJv+dviW5gUnxCl+To1x5saKRAt34vl9HsbJQTfFoa5q8wqdjp8XeohBp+T8ZDgyKhzS2gyRz2mTAWMe5n2MZYm2uYw/Gv+t+Y3bz2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aP+bf9so; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLn+Irka; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGCTW2250220
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wcoRpwtQ83TE2nxIPk4SaxNN
	R0hLbOYyb8v5x+ZJclE=; b=aP+bf9soyVQ65bJm3Ri/fPqq/tujPJg7Y1TLcA5b
	CVv0H/nNLCy+rBjVVlFdYyVsot0N9qc5Gry3NU3xFXDjWz8s2jSzJmbWFT1p70iu
	/ChQL41V8MiygQ0812BUsQqIPaYbuW1/rTOgeIww3sPBqmSDFHJLZsuDcffujxvm
	qjSuL+UAwRbVYfOl9TxSOfImTv6UF6wSC2gpWJ0bd3lEPwB8FNCUF9K8hBQlFQKW
	gCanA1FCICCRMeTS74ucfP7LN6rxcROQncSrnzUa5guCSIu1CLnZyOBtmSrJz7A3
	ixZPiY9rzz8cT47pvx64eu7Rv+WWEHjgh2LI9gCntSRBWA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxxu94re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:13:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso116441441cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762863231; x=1763468031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcoRpwtQ83TE2nxIPk4SaxNNR0hLbOYyb8v5x+ZJclE=;
        b=TLn+Irkakk1AngitFVYx550btTwkWk+7PS1W1qllan+TBVfbV+QuRgYN0xf6rFaleM
         uUunP4nOn4xuxBb2XUsN9JJ++ejRZMVoGQ9l4axMVpYCOKlooIbAUI/Syk+6pCi7AV5d
         zDhWMYWIDu9ThKOAU+l7PRAyNoWzeZ4qWuY+7wQQVpytTXG5HUsmfKhGnRltnDnbVonT
         npd93CUNW6Nip2WOnnIjJ4M04jsiHi/KKujfYaLxXq96O4W6cEIOVAOFYwCW97o1ocLH
         JevpDzZi5toHL45WkioYp1bI1Jj1XYdUCNyPctTCOcN570oBEQEWAVAGjAHDk5FfLBFw
         l49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762863231; x=1763468031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcoRpwtQ83TE2nxIPk4SaxNNR0hLbOYyb8v5x+ZJclE=;
        b=u65NCZjScKcf5351qLTUXi9vrx2eOAiUEMi4SxoA/vExrixnMADTbP31oTD+sbkS0g
         hWX3Myng1LEW8R9S6tzAVeu/ucOAYnG9PbkoGYMuhwMUhhzmFn7vLeuPyYDfQJbbDumF
         Z0Q01tCdeu1AuAuTL98E9duYBP6SxJiN5/pWH9C0PCSL7LKzbWc1T864quCYsipqAlMr
         Eus+EmgZw+y0Rty6XS0fEtJWTHLI8WGC+6vhXJHChQJgfj/6mu2iy6j/frFZEtGUSKUc
         6iXZV3SwzSVslIISFyVA24U3QTS1D5qq4+Fza4AGbRh2jGkXcAxheu+QehTRDuF2b9Kd
         GOeA==
X-Forwarded-Encrypted: i=1; AJvYcCVWxNv6ZfuUclM6hsSnebjQEq7ZAwdz15guZRub/rmqHO+tGiC0DttVoTaVXeRMAhNyNBuWSZjLgf35J4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDuXEaZ/W9p9DwwR7uztPEWvfqy/wjo5FCKKYv2cq275wtryVy
	wSxEVA9/IrFEfI5zojsfArT6H1P4O03fv/WWIEMeboHFAU6K6nwFw8TQQkOgWyAm0WQs4zS+Kax
	0pAkC5Em9zIAZ3Fxo+OBRR+CxOLhaFxXsxJ/NbRbG+f071HsKBQ3nlFxe5Z+1I6wKz9k=
X-Gm-Gg: ASbGncueGnT4lGKFnVEXTzULrbvVuuscXuoTFqVE0nDE45fSjz5anwhJ53EqQdZffYA
	oY7QS+43pi328wWkOkgRMPPmy7qfQduRIRSKcd9jdZiCFzVHTSVgmrksorK45eCLtnXk3cGD+DP
	RLqTJieYT3aB5MGcN0N+DwF2d6w2gU1GolR+bYQlhlGmYybV9mv8fOaDeyq/iWYI3gY3sDQQiAW
	pCJNGlV1Xfs3PuttZ/tdbaIqxkGAVyByFyesPU6hpuIH8dyK4WSR50sV3HB7FxPexYzdS7lrbQ1
	nrhz7h9A62P33nVuyX7rljAB3tK2DkmzwDZ1sntkgf2DAmiN2HWOt46TLVzwGDgeMehO+++8E5N
	sAnEwFCBeaXNdVfFyxqLFSMFc4ODcG6iROCUavm2uTH2EpmetJhNvQtDEdceXIQTTz3jcYYv1ML
	yR0AFaE4Krs9YG
X-Received: by 2002:ac8:7fd5:0:b0:4e8:8934:6df1 with SMTP id d75a77b69052e-4eda4feae5bmr143959041cf.79.1762863231032;
        Tue, 11 Nov 2025 04:13:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHspHKQ+CLNVRcypu8hhRWfYAeta+BzgOtl4xKcJcK4aas4ChOSoXpfc6iUuhi55jU0CPLDOg==
X-Received: by 2002:ac8:7fd5:0:b0:4e8:8934:6df1 with SMTP id d75a77b69052e-4eda4feae5bmr143958801cf.79.1762863230613;
        Tue, 11 Nov 2025 04:13:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b75f2sm4830694e87.54.2025.11.11.04.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:13:49 -0800 (PST)
Date: Tue, 11 Nov 2025 14:13:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: hamoa-iot-evk: Enable TPM
 (ST33) on SPI11
Message-ID: <bppszvihd4ropnwljshsbx7ppxzbh3qfza7ocf5gnyff4igeyj@g25l3mekylgz>
References: <20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-0-101a801974b6@oss.qualcomm.com>
 <20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-2-101a801974b6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-2-101a801974b6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5NyBTYWx0ZWRfX+78gjy0GUFG3
 +DbRJOnFx3VYwsC8GFl4IwZoyirmQON4U4Tc0KDudd8sEwySGSwm095cvAcHw9sTVd83Tb5acWf
 u/MOv/LGuN5ijbzk7OOLLxI3a5rWOO5/iw6zx4bPhV1CGQZI5yCuOct5a3zE4wk2wHp1ZL0Zb2k
 R0c2odKkhtAX9ocmLIr7uYfLcTNJ4zf3DrTxUBM2Jit6yvAXy3WdD9qE8mdzfbTTxClrBPkUncF
 SoXBOmtYN3ke3jpgfpla2QvkOal94jRxRoAszHiwUnYyd/4UCJ36HmBDd3N5EbUe5MRASuUKCj0
 t12PIaClgzrtOjryUtYyYxxDEU5rOLL0dsTtcjlx28wanSLzXSeHh61Oul4XowKtxAQ5XygwnWi
 Cb6zCg4G3hKm2G5euw2rgw1S3Y10lg==
X-Proofpoint-GUID: 7FrnWYGmcm3up-2ZpMC1P6qoARh2tpQ2
X-Proofpoint-ORIG-GUID: 7FrnWYGmcm3up-2ZpMC1P6qoARh2tpQ2
X-Authority-Analysis: v=2.4 cv=TfObdBQh c=1 sm=1 tr=0 ts=6913287f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pkoaJ9_ZSZekED1SlcUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110097

On Tue, Nov 11, 2025 at 05:28:56PM +0530, Khalid Faisal Ansari wrote:
> Enable ST33HTPM TPM over SPI11 on the Hamoa IoT EVK by adding the
> required SPI and TPM nodes.
> 
> Signed-off-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 08465f761e88..aecaebebcef5 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -921,7 +921,7 @@ &spi11 {
>  	status = "okay";
>  
>  	tpm@0 {
> -		compatible = "st,st33htpm-spi";
> +		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";

What prevents this patch from being squashed into the previous one?

>  		reg = <0>;
>  		spi-max-frequency = <20000000>;
>  	};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

