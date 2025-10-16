Return-Path: <linux-kernel+bounces-856892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4076BE558D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5E1A68209
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1482DCF46;
	Thu, 16 Oct 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U6uWQEdv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71ED1C28E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645717; cv=none; b=HJdZZYpU2gM+isFIR3b7ADzhqHDdyYtuioQCnmcWyR5B054o87+DlhDgaNSgcqz8pzVzsGl820GyVrDTcUeDQLkI1acwcddSugvIdLkryj4pfkLzwLtxoX2qblqr5OuLMD++BTlK0A/DW7vuH3yJBRvBnTi55S9t5ak74lnE8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645717; c=relaxed/simple;
	bh=wPqImp611aCZjTLetms3dJbHlLAZwRO5YDLgqdiV4I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNr6ZOnRtXydHaH74HY75vcMFJdgGrqFoGvessH5iSrYPldBq/oznEIbZQklKpYcNG6kwFY2MWL3a9n9iqlbTMEK8WTq9ApYvurpzyBc6IMlStnxRPZhII3Tr3z6hluD2XVth53HrJp34Q2YKuZneqF3PisSDNnikj47YqrpeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U6uWQEdv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GElxKL004089
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9zBcpy2TVGpV6SdEbPYF0b4m
	pBJ4QckghSj4HE7U+Z0=; b=U6uWQEdvwc0Atp6F/+uCApeLSUsymXEe4pHLtXao
	i8NlEGgPilQYtDRy5RAmjrXbBMIRWy1dEEYOrvfitNOJvjF8ezUAohNAJQrIbxTT
	sGJj4JP47vIt1OZxxyPhy/baVufsqdQF9qwwPceQ0wgJOLKrL9WC+OxFPNlTW+4I
	HwnP9YgD9Yfun3o081dWWNpjw74Fa1qPOFSmckY6Qaq/wDCdgBUXJHQMmJRIjVay
	4JvNmf0BNXza2ZsheozKSGcBwzHJIjCVqhcBIcIGL4x/34q16diC0+XQ7T5Ll9Sz
	+lpQlgRhGLI4u1Ub0a5J72PhLOIozLPkYO25V0+a4S7jIw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwuysy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:15:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78f28554393so37653046d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645705; x=1761250505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zBcpy2TVGpV6SdEbPYF0b4mpBJ4QckghSj4HE7U+Z0=;
        b=ASCYx7nTeVoTJaaPoCG68LUCJeyHd65S+8+oVA0/5vX2i8D42R8AZCA3DZzDdDMcLs
         oI9Tg2CJnRH5Xy5upA8AKHBvonLpC1mtVYShouMCvtVesY9Dx1tM5Spv1ZuloAAfEbCd
         JSiKgr5GN0A3EDgh/kIKhKLpex+mkeIPwEIrYRnGLvqghtAwvfOey17Kj3PMKXv9FU6y
         +SIkk5Y6ya8zum2oNAOYJj6jtONFlY3zCPOqFKZxo/FEtZeqVPQ711//FjhttFesfEMA
         JfGmDH+tn/iT1cnsLyp/Zu3w0OlmqXATA1CHjhgtFRD9DoT4g+mQ0deCEQSnFZvlhuCC
         hWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW62dGkEOZA4MLZGEzZ6EAOzp4e2jMKl3d7K4vrwvdci+k5XCgjmCcISGHz+k2Yb0zbY1+HsMkwENQnCag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0LbUq9LB4w78uzaVzBiyfL4Covj0w3O1JUFC/FEyjEg0CcgZ
	6INxo4u7V6hTlGk+tM8uqlLrzSqglsBOCTeftuq4loMfJvJWvS4ShU+UlH+/yU2B96NSB1Z39vL
	oS9Wx+Tgqt+XZ4aMY+WSmYZWOB01QSRUiQEpLt7D8sxyIMQbtrYu5hILJaif6i+e3K+Q=
X-Gm-Gg: ASbGncteWZ0zwNeCg864w64ZcSJeULWZWwS1ZpxqmQTnUKOYBwPr6buXSYIs6pTnXfO
	mqIC350GcLZnRVWIzrPpK0J5nbRZkHrfZvVAUZ/t6/DCH4n0U4LcF67v1qratz73fim8fHvmq9n
	e27GY9teP5cbXcCohQSOayEaI+PK+UgeQ3Qr4Ky6bkJ/RkS+fcicbo/d8kKQU6xQIjcoVhPxSsP
	fH8+CPNKiq3TW06OrHW1MNKJbU0VAp4NymdTFB2zElJP4EyZ3F7E1q7gve0oeArq90SSD1GvAPw
	loRB57FRdPAiRZdP/b3gelyQNTZhPKtcGMv8ftjpKdoxxO1pTp3oZlAOl+GzCQW5YlOq0d5I6A9
	F6qgbYPnJvUsH5j1kXn+UcZ3ftteE4922JU5C2WXP6xKDlOOp01Nav9GMD9QpgfVayUUROOj8jP
	EhUyuZCTIM9wM=
X-Received: by 2002:a05:622a:1103:b0:4e8:9086:e6fc with SMTP id d75a77b69052e-4e89d273e19mr19028701cf.18.1760645705053;
        Thu, 16 Oct 2025 13:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe5fnMVrV7X7OK0iMbXtKG9SypwzE4pSZ+g5Jctt4v8KdtBGL8mmMoU8EYU/SoOlRUrLoUiw==
X-Received: by 2002:a05:622a:1103:b0:4e8:9086:e6fc with SMTP id d75a77b69052e-4e89d273e19mr19028171cf.18.1760645704394;
        Thu, 16 Oct 2025 13:15:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088580ae2sm7280651e87.117.2025.10.16.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:15:03 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:15:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sdm845-oneplus: Describe TE gpio
Message-ID: <rung7om2fvwmfyihgsnn7j2b6pak7sjt2ayzy42ovugroti4jy@wt6chj662llr>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-7-ce0f3566b903@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-s6e3fc2x01-v3-7-ce0f3566b903@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfXxdVCJlHBGK9p
 RYe0j5JD7+wsd03GKg8JiQjxFOjV+q/nqpqOqpsCUp8itnJ86x6Icde8E/iozLhYVJteAGHbPFc
 c8IL0ysbZzLDHJxiU9W0gTtuKmStqY7rilvfV6oEQWG/VJXANbtBh0y78BsnDLnCW+DTHUXhwEC
 CFuuEjo9xmO/tZTDUU9ota3kXMlr41dM2Skty5dY80fTh+vmq8oqYUo2/PahgE2oFeh5b6ffHYu
 BhI6G/KbzXqeYliewLW7TDN8zpAjS11nFFR5r/XNg7DZLYS5KecMl19jZ0GWxeCZndP9wcJO9px
 GODxFQAr6dhI2yrcqET/rY5X9ywr2tAZ549+Z+K86N91O29GDDStjCFlgZv4FVhU93Q/6unJ2iE
 3opwbvQfbOWsTf2fG9q+4q0viu2jMA==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f15253 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=HryFia7_YQCGBQHkU4YA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: ItbtRKzBLkh5nVzLw8LAv4j-zIu_SHu8
X-Proofpoint-ORIG-GUID: ItbtRKzBLkh5nVzLw8LAv4j-zIu_SHu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On Thu, Oct 16, 2025 at 06:17:02PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Describe panel Tearing Effect (TE) GPIO line.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index a8e87507d667b..b663345de0214 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -460,6 +460,7 @@ display_panel: panel@0 {
>  		vci-supply = <&panel_vci_3v3>;
>  		poc-supply = <&panel_vddi_poc_1p8>;
>  
> +		te-gpios = <&tlmm 30 GPIO_ACTIVE_HIGH>;

Isn't it GPIO 10?

>  		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
>  
>  		pinctrl-0 = <&panel_default>;
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

