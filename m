Return-Path: <linux-kernel+bounces-838102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DABAE725
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B769719409AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D2287242;
	Tue, 30 Sep 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RN0XUcgX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EC19F40B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260686; cv=none; b=LgyljWDBuZUDBeEoPmjsfL+jizGKFCZ/Tc+pG1VhCkvFcPl+eAPe3LJAMKrD9xJapHE7f+UV4rQAXBMB5URZSQKGaqarC38auLHb9oP76KlUGSa9bFAwm4uGoDHu7V83ymqOmoIHp1RNyOc2Z60nj6aMVTYPrd3fCBNnuw/KmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260686; c=relaxed/simple;
	bh=Of2f6L5h6WLUp8mGYfj0H03Yo80nbEPmPnhT5Za7vqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoLZo++BFEnZSDSsDzVg5COUT214GfW0lkpRosrxjQd5Rzxb0gLzq11sTUC7ZN2ecVD4to7EXc+a1mqFAP7JiDJhlnl9e3IouU7/DBGGI4zajeWPi3okbfPCvgHlKvOKl52h1yOIm42F62yZ7uPhIrigYvmkumO7FuHlnTxQxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RN0XUcgX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBx0d9016878
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qEQhoU+0iFnQpnaZftTjoGCy
	Q7E27cWAqjV3I5TP7xw=; b=RN0XUcgXN5DcNpcwcO/eS2stoY6MTrUel/qRdfZO
	19aOsf6vOcQArlbXjcB3myybZzC2gB6TOufWrCODn6gtjsxwDEMpbVHBZP28AMEu
	2aJ+JA5jMGiK4vD7dwLBf+Dte0a4uM0N3V2Bw1f5S5NrgV5ExAAzLkXec86i32Q/
	DpZT2XNHkQ2gdMkOwOnPTOSWTrhVf8mSqE0AYs+x3W/8yMGQWeHoRLv2xEmT3Cte
	EjIZADAB4xRQTZa+cP0nu1/zcMW5iWi92XM6pnBxBwejf9uH6Q33grqei7aMBOhE
	R1xjzpbElrSwMAOOjNEnx2fnsRl84gFbHuM+N6XEU/rG2Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hhy8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:31:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d6a82099cfso160907271cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260683; x=1759865483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEQhoU+0iFnQpnaZftTjoGCyQ7E27cWAqjV3I5TP7xw=;
        b=HgnbI9V0AK5X6IFS9dDFwzSLlAL0ZlnJ2nn5/QddbuPJgDvWtBI7nVKd0t4yZDCAm1
         jYfl//sP3VuEPst4oytc2dinzYOGxe1mqkLrldXsgMWL6K6vf2VLyE/DNBRgD0+4eHHJ
         HocgOSdzxqorOGZFYPF1zZwSzy6wp0uGLUInzBj6dapvRmpO0ZSW7GiEjpYhi9EW5FcU
         Pquvrav88PanDd47IAabhjCphlNTu+0Wn7iwLpR10D58LS6aYboMeoSpiwsDWPU0+AkX
         3BCPCT4xWPOX6RgurGEptG5XrbJRaBikgH/Rz5f8mtaFLNeueNSgR8MyfuKd74J6yYD7
         QoLA==
X-Forwarded-Encrypted: i=1; AJvYcCVono3/dhozSsUIeNyoq9qr0gZwdjwLszy3i8xAbYXuM5GJ8TP6rTho9EDLL4J/b8VWDAeNsJcz1VBUE+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNK8WlKXSVpZ6UJ4d/I1ZIC1ByfSmj7Xj4QL5U27tqUJMmVC3S
	tAbue6Tlubu6XlrU+yEDBadlRZr74N0wTqlP7uJSekH1Ke0B3tnWpnq5kB044BKAG8ueSY4RCzJ
	skwn/kVHdfX0LIUi4tNqP3cYWv5nwJDXaSkBW710gHgtXCkQHdt+N1lfmKBdxrRY9Bgo=
X-Gm-Gg: ASbGncucZgOOBU6GCu/3XXoacYcs2/Fi/VSowsBS+mlvDUJmkZfbPM6soYNums2WglZ
	LcHCIz9m0st5wXguS4R9gs3/TpEbTiVs7dlms5l5RUhERCp7gnoblue82mLO/wNveogqDI7DXyF
	9N9DI4C7dJnjqOrKJrWl277tPv2hvGGfiNst7L5dxS/u5LIEMoHIYryvh0tJ1qaHB81x5yuIqXa
	xpr/75Zip3CeOzBP6pIb+J5jaYjn3w//hFWsPIz3CZyuaHbwhxDV/m2G8j9xl2xTmpzRMTShec2
	tKvjpLGx8cWIM3dJN0GFTQcot8H32pQBgSbECEUv2du1ybRQq7qVPGuc74MhJwxXjYBuAOZsh/4
	6CgHV1u3S3va6nl6RGFO7RRGIQvHETg3QP0ipqJcFDkEaZxs2//Ozx+kDuQ==
X-Received: by 2002:a05:622a:4c0a:b0:4d8:372b:e16a with SMTP id d75a77b69052e-4e41c923fb1mr10954361cf.4.1759260682656;
        Tue, 30 Sep 2025 12:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjjibGLb7dPD+kELAazeCZoqy4mtJTjmHTtorOnQOzn6lZE7AZh1Ew5Qdes84qqX8F3hfRXw==
X-Received: by 2002:a05:622a:4c0a:b0:4d8:372b:e16a with SMTP id d75a77b69052e-4e41c923fb1mr10954031cf.4.1759260682236;
        Tue, 30 Sep 2025 12:31:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-587748b15d2sm2159965e87.7.2025.09.30.12.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:31:21 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:31:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] arm64: dts: qcom: sm8250: Add MDSS_CORE reset to mdss
Message-ID: <gabbhygjn5nky5prr3k7ozuiwhzicp3yuvn6qqglqyijt4lbvw@46pdixx3nprn>
References: <20250930-sm8250-mdss-reset-v1-1-a64522d91f12@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-sm8250-mdss-reset-v1-1-a64522d91f12@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX7UV849Zi8JGs
 hsJapfuP7fxcRtkbCZo/TjHRc5ovlNcJav0oEHU0ZnZ73zlaBAINU6/pQYmYCluzNC5vYIsKKNz
 Lz5G9/47yITeN2ybW0ly08VV3mB7KIAyn3gTaupPoTfkSM0I4DzwsP5ZBWsxLfPGMhGYhftry0N
 nxJ5nNEztApXh90UzSe4noTZMxbCjd8TcmKun0jsok6trSNNPf86IcfLS6QHu2HTPx841HHIju4
 PWSdSR5VIzHhSpi9TdnwB7KiREruwlsZ9FaKKQb4MxbhQpn9gexg3G+v8PedaomaxquYOgeNVI+
 lbvfh1uDrDc5EhL9Xe0IAQ7YqopFEBy7dEGwOfN1KyuVntAgK+QU5QuaTxL+WmQGht1+y9dmEue
 sgxufwYK3CiwLvTKHqbKM3kL7dx2IA==
X-Proofpoint-GUID: eOwaupO_58j6VzhKHmuOEBEzDIYj1MsN
X-Proofpoint-ORIG-GUID: eOwaupO_58j6VzhKHmuOEBEzDIYj1MsN
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dc300c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=oWIomgx7Mzb9_gp1DSMA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Tue, Sep 30, 2025 at 09:37:22AM +0200, Luca Weiss wrote:
> Like on other platforms, if the OS does not support recovering the state
> left by the bootloader it needs access to MDSS_CORE, so that it can
> clear the MDSS configuration. Add a reference to the relevant reset.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Not tested on a device, but should be necessary on v6.17 kernel.
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # RB5


-- 
With best wishes
Dmitry

