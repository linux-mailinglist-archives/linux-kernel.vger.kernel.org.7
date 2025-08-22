Return-Path: <linux-kernel+bounces-781649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D17B31501
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515FE1CE4384
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E032D7DCE;
	Fri, 22 Aug 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8UIYOsm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971C2D3A74
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857873; cv=none; b=kr9KhNOHslycjKQaLxckuC00iIWG8IQtWUcz9iHlMwhR+/Udwr9AUnDRou62kIJFkoizFJTzksQskrrVpd+u7naBDAkY3jLFJvwl3iemxfhamkWAIpdOsdtCVB/j125JjUlUWH7FJHci7ioxtInqN+qkEqNCU9wh9KCi3yaL0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857873; c=relaxed/simple;
	bh=dwy1mShF1PZxzzBuHTRn8TQEplDFuzWD+llts5KfLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhYMn91NEI9jxw3gudTMMb6Qgch/vWEG20ajY91BrMDP1yxkt9Hg/dVFcmixx3zv0YmKpSBToqpDjvhDA7ghTD2HaRia2XCKtvHKtbDTUCPaA1L4LgMii/ZpUz3yKwm4rEwtQ/3CjCL2VVYt1PXRYjl1W65OCydSMHgxFNPu5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8UIYOsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UKKa028630
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iBQ7WvE0H2xSgLFqIELm4rfB
	EkobKCDAjN2aokgsXOY=; b=k8UIYOsmVWWPINPoQjHFKJTHAGxOoDe3cNAYj9+b
	drfEsEEzIHMUY1Neahzhc+zSPKELpQ+0RopbuPjPrwMyQE1v3O2HpL2SgqxZ4jxy
	0+MmYQQ2Q1HXk44thJ+WfZrOk97RskqlJIk2MHgEtKxV2uQ9CSls4ijhduG/UFH4
	WA8KRvh4bqfFuOsJscNGIFckCh6t97OftvcYk00BmFgeD1pN68rxwfXojTNv+5MY
	ozHmekQGnPpgr7MFlJRz6dfj7MvdRvL8avySHJypxL5kNuhf3PBbIWdNbnp+N7bc
	4cFz4Oxxk8+/srrQAFdkcp30TeKf7V3sHLgZtm6x0rMS2A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cruru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:17:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9bc306e0so8891696d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857870; x=1756462670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBQ7WvE0H2xSgLFqIELm4rfBEkobKCDAjN2aokgsXOY=;
        b=q6p5cfwee0Xb/JDYCPLLf5SW1ND+GXJR8+/Z62dR4zBhw/2j25irOfgXJ4WnPAi+7/
         OhMIt2648KnCuPZgfe2DJYLA5msczWxw/Xz7pVlphLgZa2p9FkoXTgKPcEHc++VjuhkA
         /HfUUfHRa2neXALQG5NxxnRibl19Y4it6t/5tzXp9PQ/XAIEEmsxTmUoxfLaua5fvOOq
         z1qJUrTdPOGA57gMjhkBRFEyw6NmNr3OcI7uPwQAcYtdK3SVX37vYfipvjFipS6oX4Ab
         P2NRuAwmt8o3nUJI8yEbJv4TBSt6RUN9+cRQ9ue24BXzmWcvTQY809ArxXGJl674FIDt
         F9ww==
X-Forwarded-Encrypted: i=1; AJvYcCWKvPYxNFsTciSqMvKuWI/zsmNzT3RPhQuTUW3a6LsMAmMm27EoDbHcQcR9fUEFkycbnTdkwEf6umfWLEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd34XObUcrChlbZSV9GZ85tY+YlZlLEjT9gAuF53SxmjGU1pVj
	d55Z33cTJBoeTSAyp1AnP46+HGUlNW1snOVHymnMAsT3k3JjcTNzrCiVnWiTOLD8ikahgx4NFkX
	qJA+uEcNBDYKTnXiAJYbxinjHoZL4A9w1+8usfqTRkOpeMK8zvZQUS6Olq+XL+xZb+6o=
X-Gm-Gg: ASbGncsSr5+OxtyYaglTQ5R6Gi2Vr1mck0/UAzkuLphmwc+FMSgWgJaloCkpfRsxc96
	FXmUpwAU3TI6741zUwLv3XhWPcle1FrFXhXb0CzLKoP4yvCQxOly75OqfM42QJEd0pYWED/9V7x
	bk2YJTcOuJlymuXtjqSXJRnNWF+eap2LqEu8GA5Mm8hq+vgy6Et/FrDfWl0P9at4vI6aHN2ZlD2
	GFdsZOqsEbWbgyULdnDu7VQoXBEmjeeHrTAwyKWA2lezPKdnO8C4TBlPclivYWbp5Q4ptRyzkJR
	gHrNtjjwOi9Q5yqKUwu07VijtblE0B0KVlwpYAX/OGAGlT8vOo3P3dkJagrj+3StDEEwttieIJL
	v+GXNo/IH2ZZ8XI3CKYnIBM0FT0hhE+w48VH11uGaocAjnW9isrkN
X-Received: by 2002:a05:6214:3014:b0:70d:6df4:1b1d with SMTP id 6a1803df08f44-70d972371e4mr28644706d6.58.1755857869915;
        Fri, 22 Aug 2025 03:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH62oAsAMsiUv97NbT9YVzJguJ02slvA/bRLNpNdl+mlKb3ebFjncfo2wZhMvsCIXsDoIBaUw==
X-Received: by 2002:a05:6214:3014:b0:70d:6df4:1b1d with SMTP id 6a1803df08f44-70d972371e4mr28644476d6.58.1755857869279;
        Fri, 22 Aug 2025 03:17:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55e0281cf77sm1536535e87.135.2025.08.22.03.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:17:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:17:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] arm64: dts: qcom: sm8550-hdk: Set up 4-lane DP
Message-ID: <3dt5hkmi7trwyynutgkn5r3e3zips4vouhdp2fsxu6fiw44sef@kgxoyyih4tsk>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
 <20250822-topic-x1e80100-4lanes-v2-4-4b21372b1901@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-4-4b21372b1901@linaro.org>
X-Proofpoint-GUID: DZhEZzxQe4AKZ42DvdoN5b1q8S6kLvOY
X-Proofpoint-ORIG-GUID: DZhEZzxQe4AKZ42DvdoN5b1q8S6kLvOY
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a843cf cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=YJrRJlPzAM5hdBvFenMA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXwjoYQjcIUrPF
 Cy3HVZkEASMnbPHc5y6eXXBf/CCar7vwkUJLkoQWn7H+6kjgvrHVM7y0gIN87NSrAjmZgtSPqC+
 9+sBBTV1JDhXTLuV8v9HuZ7rlbncZSkWYzNUJGMQNEKtqOm4BnCNxR4cA8Gw86MzZL3xHAR/L5y
 ZeHzPPHa3QR/j3omGgSG096VrdDzhznUyYhed2ItMbpdXR7QtJktU1FVsSSQoNAktwP99f3COaX
 fG9BvvmljuSBbFwdXlXG1kOuXAWgy+sIdAtspsxC+psYQgLE1SHgG4CZE2L8Wpttx9/vkgtEID1
 /nC1FVw2vtQ3c85tBoHyqUsrb0DrfSzFVZ8rLG2WrNYlwNvn9EaIB/oAXnZh9CUQjEtDizMDN2W
 tkx6c/5CUdWIU+e52m1fICbLgEJyUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:39:16AM +0200, Neil Armstrong wrote:
> Allow up to 4 lanes for the DisplayPort link from the PHYs to the
> controllers now the mode-switch events can reach the QMP Combo PHYs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> index 9dfb248f9ab52b354453cf42c09d93bbee99214f..6c2c9514a7396a8b75ebe24585b47571c74ff568 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> @@ -1003,7 +1003,7 @@ &mdss_dp0 {
>  };
>  
>  &mdss_dp0_out {
> -	data-lanes = <0 1>;
> +	data-lanes = <0 1 2 3>;

On most of these platforms the data lanes between DP and combo PHY are
hardwired. I'd suggest moving the data-lanes to the SoC dtsi (at least
for USB-C-wrapped DP controllers).

>  };
>  
>  &pcie0 {
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

