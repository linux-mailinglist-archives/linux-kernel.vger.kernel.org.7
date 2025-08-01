Return-Path: <linux-kernel+bounces-753686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF84B18662
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842AE7A969A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1241DFDAB;
	Fri,  1 Aug 2025 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYysjp/p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE76F2F2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068495; cv=none; b=UY+kdIeWuQhA8on6GlzMnNfHeRH/2eF3HyqEuGRWgH0Im6uBemMKOaulAGLs1pV7KpChLL5lM5EEO/S2cjcS59WzoiTADleCQeRqMTCUUfBLcHF7rRMOjvQ+JuHR2SVkNAQOUlMS7IPfn0S/sAUJ6ErJ0bRGRp1TCkoTPs93aN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068495; c=relaxed/simple;
	bh=aOijRpLMfZAU+sXieMt/YHjyo6Js0ax034/IV5JCtLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hau+yBjlpwoGEPFPas1AELXNfDklub4FLzf5EV7e55gXN7nrLOJ19ADZvVY4wLsPUGSJ7mQ9BJapj/lblfepNL9tAknYinbnaKOzBziIL2u8jEII0n9m18Cly3F3EeCkGdg9QUY14OUbvI9eAJDnCVxA5IuEcFrEhY5PEnGSgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYysjp/p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571CLsi1002445
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 17:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GjIpDMJZqcrrLx0t+DaOeXkF
	Njy3j/r+a5kooErWBOY=; b=GYysjp/p7UOydI9jf1O/41ACeaPDHfC5Xj0UjIVY
	WiwMHfFPRmHJaCda2exNe2hdckTN1gqs2Om48b2HGKPNQG1SNzcXIG6K0Hca4k3a
	jkqzeQgSxg4HNMafdszgKI9sFanuaQ9RJMltKpN8o/E/+0s3ZqKPtc/x8zJttLuw
	SMiXgnugfSBDUzY3sAuWJkpdALi1Cy/JNyENK+cHKE9okeXF/pe//nRnPPZxpJl2
	X12N3Vs/e/z5+/rNy8ODaKKNrCeabG2fUFJgPysPqfp9IKd3HJa+/rJNJ5s635Wa
	r6tZybT9EDRa8WkZoLde5G2GCFhNq6Xk011an5vGAgbgVA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488wgrrxvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 17:14:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab969af6e3so13668551cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068492; x=1754673292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjIpDMJZqcrrLx0t+DaOeXkFNjy3j/r+a5kooErWBOY=;
        b=YYn0g2ycSQF2jcsIKkHkyr8JxzweE8Ph1l0zEYXsu0D2yLYaomvkiOoRUzHdo43V+j
         dsywzespyQYh8A4vmBDeeWVBwA3Bq40i9SFJLSm2Ng0Wd7GGLIOJgjL/oYmKWPJoO/5a
         BGsHNPGyXpm1gnZlpf8OGybyB9pmwc5FHqdswBqC4Pf3v+rojv8glw8cATTYBxjfyYLR
         3V2g2tfq9UPXjOl8Q54Hfv3qkjzFqRkheExDNRtFFKXntXB3zyza98iu2AHHz38R3JBY
         Vusj7M8szjoIabMukkXg93C73WA/xrc4UlRLKPhAUhu946KPOiP7GSgom34vuXDxzDCE
         +8qA==
X-Forwarded-Encrypted: i=1; AJvYcCVI236uwyz8KBJQnk/M6l7M04K2IeFl70NT8IKXYVAwvfrjmoviT78AELHhfxbx3ySQWqjCaUelJ+1m+mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91Vu9Hd3cYQoEeB7ovIatRnL9Z/id+ZRZzZnyprR9iau9SeCk
	bxJwMM3x24bxZGiMf9taOw6AX6TWQ/utld/CL19c4GbBU+qij++gtcBdVcclgBGdu1cTz07vreT
	7WaPnEqdINC38KwGEinD1tks1zUKOvwO9IMBIoqUy5ehiXt5tDTlFNOrJ6fcIXaMT/No=
X-Gm-Gg: ASbGncshXdoIH9TqyyaGDIbVRzhECXR7CDJMH3tkpKQDfG0Qi1lriVSPX3TjiAtEUPC
	5pq4M7F9N/r+qWYh2hYlnECfNOqZTYQNj3g3UQmI3hlH6yfMAAkrpq55MSYN5cSj3kJPz4bZMOL
	k+njjbs6c5vKqApLMJnIRieMd+NyXbKv8oNhh03Ju91v0zdjuf3Nd6ok+o8VAqGr+3nRibHA8r7
	I2JD503CjizHhiIWYLJZw0D5u4wmcJyOy6g8Bfo9HsR9Ed9ihDiEKERDNAu37BhSijpTQ1qnvJh
	lNMsJjKjINfe38DCeA0bsNmyPKVY4ytEkJXsBdkTca0sQZxbV+4qvCdFuMF2VBT4/EvfNVNvEUU
	vsonqTeAZJcOUGEle4D5kTIrxTQWVHJxhrmnwSzT/6dUFof6r4HMj
X-Received: by 2002:a05:622a:1819:b0:4a6:f4ca:68e8 with SMTP id d75a77b69052e-4af10d8d43bmr6534221cf.48.1754068492163;
        Fri, 01 Aug 2025 10:14:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUZeft7UM185DJ31idsTVovKtr5SEN51ZI55OaWAMuhEXrYhTLrjzffx3vJ/vf8XKyK2sS4Q==
X-Received: by 2002:a05:622a:1819:b0:4a6:f4ca:68e8 with SMTP id d75a77b69052e-4af10d8d43bmr6533521cf.48.1754068491453;
        Fri, 01 Aug 2025 10:14:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ace49sm657841e87.71.2025.08.01.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:14:50 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:14:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Kota <quic_kotarake@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: Add Monaco evaluation kit
 initial board support
Message-ID: <4rxy4iuqy3dstfuv744gw327gf5n5g6notjpmkspjme2w4sd3j@5sbqfoumb5y7>
References: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
 <20250801163607.1464037-3-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801163607.1464037-3-umang.chheda@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fs7cZE4f c=1 sm=1 tr=0 ts=688cf60d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dzsA3FzLxQdHMSIhhz4A:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WN9eMmlxik2krUtNxfJPE6lCKdSVNeIV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzMyBTYWx0ZWRfX+DtB9hOtSYT1
 +nUQpru5CDVoH1apfeyd998cdfBpSNgv1HXxL+qSZJCPDGzlifXeFAH/QCx+VeT5SbDDvyBJ52g
 lefbOPgLpqk1+hh8CAbtxq0IF+k3mbbAvDYBcawqxY+pcKpjP8on7xiOGfh3ZY4m7WfL3ALR1xN
 QeJ7CZncVT+RQ92lNE632MeaNkNvnNkI02k90i0EmlfbS9lT3GSGF0bST1/sGcgGQdBJLabAB2s
 A+iN+kFghV+GpeqRfKRRsBO6vP5MZ6bNPTS+/FAstf1cXeZ2iEWDISdoB1PePSWO8lARok0v1H1
 gPVlr4DD7k9VCHXSLDLmn5R2bvxdXw5nJciGaKsNv0uuxuFpgo0OpyqXPJfNnpS2yFGueMz6Zjp
 pGjh21CV0tcwQxiEl34RbrUoeT5J/SHxw3lJT5s4pa9H63OIThFaZBLWf2y2UdFHvMtRQKHJ
X-Proofpoint-ORIG-GUID: WN9eMmlxik2krUtNxfJPE6lCKdSVNeIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010133

On Fri, Aug 01, 2025 at 10:06:07PM +0530, Umang Chheda wrote:
> Add initial device tree support for Monaco EVK board, based on
> Qualcomm's QCS8300 SoC.
> 
> Implement basic features like uart/ufs to enable 'boot to shell'.

"boot to shell" only makes sense if the platform is new and not all
devices are enabled in the Linux kernel. Granted by the current level of
the platform support, DT files for the EVK should have much more
features. Please submit a full DT at once.

> 
> Co-developed-by: Rakesh Kota <quic_kotarake@quicinc.com>
> Signed-off-by: Rakesh Kota <quic_kotarake@quicinc.com>
> Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 199 ++++++++++++++++++++++++
>  2 files changed, 200 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4bfa926b6a08..e78f56762b6d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> new file mode 100644
> index 000000000000..1e0635c93556
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "qcs8300.dtsi"

No qcs8300-pmics.dtsi? Why?

> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Monaco EVK";
> +	compatible = "qcom,monaco-evk", "qcom,qcs8300";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +

-- 
With best wishes
Dmitry

