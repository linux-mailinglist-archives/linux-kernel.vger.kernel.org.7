Return-Path: <linux-kernel+bounces-832006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA665B9E219
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5B4C10D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116E278E7B;
	Thu, 25 Sep 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cIVJqFuO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26034277CB2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790328; cv=none; b=gXsAKISO9RAEIzDjF8/od8wQOHy2sbcd3xzQ/MK2bH6UJqGCcOL62i3qF+IsY9ry7JVfT5t4oGmaBKszG1btuzLBPQ2iasqcIQ3z9+nnprY0rEci7FXLXullfgodZ7wASKCDp6vUh5pxKt7OGiYMEs3WoXVCDaD3YmyQZlHCNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790328; c=relaxed/simple;
	bh=5CdlDKUVB9QrsAnAjhap+yjft9sOIESYZShJnxZLofw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvgvHPIofuXFY4gz9ox/vgMaKAD2RyyvyW0DI0vkG3WveZVNS1ZTNdoFua+nu04INWkDqtnuMg+32H7MMBWNaelGAmtxq7wB3plnRF78woz1S/jtCpmMr7AIc3LWyTrlFy1D2FqZQBWkwWb5fNLlpHEPguc/WT/B51meVNTfwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cIVJqFuO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0MCI3002079
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6q9KyeGlZiO6mOJ2YIcgCuXOHQCn7ZmtQY52fCnxgn8=; b=cIVJqFuOnXUcLd6l
	n86bvykbaZgQPMr6vlv5CEeqeGmR16EFmbuo5Ewo7P6AzVVOYiWTDEarsgT6EAm3
	ECJGUnoO5MQOhz14j0pee5KyhzxGEnZphUCfluVrTyVBKFoZUA0wFUA+ehLSsbKl
	NmWgLlbiRi2OvfTd32w55QjXVQNBgINCp6ERWc2o0P8GkhAzCVCo/HOWERoBWeOE
	ozGmZ2/rJEp4dH2geNFsuXaV0GtpXSoT5OwfXR0051YcZrIAVC6kBO05aIRL5lPh
	v2pa4men/Zh/rChylItKVu/DeTlVtpCUPzDiFfPo4YQE0meVsvUW6f5kyLWPdPzV
	5SafRg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98qdyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:52:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-819d2492a75so37388385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790325; x=1759395125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6q9KyeGlZiO6mOJ2YIcgCuXOHQCn7ZmtQY52fCnxgn8=;
        b=keezxOlQ51oSK3fGuQulmQH5ujOdObUMuARfif9YHTCbLl4YeC8pFxoGD14MBcIKur
         TehPukRbfx9MzofvTEFJPpqoU4hWv6FRVuuFpL32IbSkiiEkcmD0kRDlr0pBMZ8wWt4u
         7TkaLltH3k+Euc54PMqs2RPLBka8o834Stif8elI52CVFXoKDO+Ml0LH6CK+Aa5S7MpZ
         +E5eenlTboIfuh8C0+f/KJuay+aoQ71nERQweVgGuH8RjIqnUI8NdKjV1AgbD758r1Y1
         QUt5cLQRBL08/bfJzuZpx4dllWvub0l5asKLCi3nRNlR4OENK2v1C4+rusWxmsHjeE9S
         s0xA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Y/xgFWk4jjRm+oLbvOmzCSPYXIbeFI1GkZnneTHuJurPKy6DPd47rBJL+tpxlywL4Foli4t4Y1Yd7Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cVZ8dCW1T/ioAh5+taOh9bRLucwH55RKiDVmJFvm0JkDGDko
	6XJ5x8MciKT3pvabCNOXQGSVPQVZblUlYNeXygX2sZ4/N2/CnZ3+68WPktwS3uWMgXFV2mA7k16
	SsDboggy3acE6tIY7Tz4Nv2mHOs6oigY7W3ABb1DVNKjYRaP3P/UBgUTQXQShzzHXgX0=
X-Gm-Gg: ASbGncvlYKyHNQJF2ZplWPa0EPkIf/ut8iF8fLkcrmFeOE/JwXlTL/1mddFPTs4umcc
	+DTK1bkxtQ8/NlPglGT0/nxShQyN71c4xm/DMkIM2YIql7K7J9PyDOFtkm2Ghiy703NDjV7argE
	KeZ8pNX7mYaUpbt8DH8bnXJsvQDguRtmdfqFfmIgKa8kG1KznOkUfp0+kMCmwGPa42PRQXiON7G
	66WX23AVyNLL6pGlRy5NS6FxCt+jNsPIdhTcxJeT/e+im4g5G9IVT/uYhK9541C0k/B8Ia5UhF+
	Y36VNUiygQYN+B3pgNZczTHXCdg5DcmToM6BsFYRoqhhltob0CERg7gIOUsL8Fm+LySSGpbk8GD
	rnF15H1vZwOB2B9PwUdYuJw==
X-Received: by 2002:a05:620a:19a5:b0:834:bb79:1d71 with SMTP id af79cd13be357-85adeb4da12mr213159385a.2.1758790324993;
        Thu, 25 Sep 2025 01:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNp/joGufj4XiUUg2TcpZE2WBMvPXFR7485Ym+rBlkUiNYfsas6rWCqt0HnxYFW+HuQ8foyQ==
X-Received: by 2002:a05:620a:19a5:b0:834:bb79:1d71 with SMTP id af79cd13be357-85adeb4da12mr213157085a.2.1758790324466;
        Thu, 25 Sep 2025 01:52:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f586161sm123061566b.36.2025.09.25.01.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:52:03 -0700 (PDT)
Message-ID: <9b887bc5-eaa4-4271-8770-3458efb528bf@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 10:52:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: monaco-evk: Add firmware-name to
 QUPv3 nodes
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20250925042605.1388951-1-viken.dadhaniya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925042605.1388951-1-viken.dadhaniya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ppP6pG82FjqDtWd5wMH4RrFfkyxbdSRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX/kqU2AcjA/e8
 rJ6Jsbg9BZCGmv1PQoZrtFTYa7H8eMsUoZETPxJl2vSAkUt0Jk+lOobwyvR47FwFJYPyUtwBDNc
 og3qUoIfn0ku+R3mpV0+DHpBO/MtxOc9XwtwmD+KFQAm4IK1Ld+4S+IwwrPOEdIwFg5rviJNvcQ
 0V+2Ki081bF/XvZqsnq/UPmO3HCxB3TB1DFsX3bUYvVWiCwzUTeDd6MRv98TOt0Yhmy8s41PcyT
 PV/aQPZi1sw24VUyPXey2Sfg7+7z72pQ82bPuG149tbkmysSpoxO9TH2rVM3SnVhzGv8jL54bBR
 t+62m7eXZA6z2QKcwYxfr7h2Oz1RxfbR8qbsIQnrEvKlVvzUx6UbD60WqKO3CDBsZ4m2ZPn7vBD
 0ZAOH59t
X-Proofpoint-ORIG-GUID: ppP6pG82FjqDtWd5wMH4RrFfkyxbdSRd
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d502b6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B4HikTB3W-0rk1GVoTwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/25/25 6:26 AM, Viken Dadhaniya wrote:
> Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
> of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
> ensures secure SE assignment and access control, it limits flexibility for
> developers who need to enable various protocols on different SEs.
> 
> Add the firmware-name property to QUPv3 nodes in the device tree to enable
> firmware loading from the Linux environment. Handle SE assignments and
> access control permissions directly within Linux, removing the dependency
> on TrustZone.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Viken, you've posted a lot of patches like these lately for
specific boards.

Should we instead push this to the SoC DTSI, to limit the boilerplate?

If I recall correctly, you said these ELFs are not vendor-signed, so
it should be OK to have them be assigned globally

Konrad

