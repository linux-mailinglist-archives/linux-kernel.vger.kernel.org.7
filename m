Return-Path: <linux-kernel+bounces-771506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C199B2882A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733F13ADCE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE325B687;
	Fri, 15 Aug 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQbe3/TI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E27212B31
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295618; cv=none; b=KNLcRS88rT5rItdK3Wb4mjB+BvB/PSJzNN3GqDt1577Bhnl2Z8+/4JKt9WvTODlR7g5R/ZvSNF4u7YJveRX00yCGzz3kt0JC+yvzymFMBBivaowc5BmaBmH96gTtZcsefsf+qpld5J53HDBPRzpxOXdK0e/frKJE6XzIqavzt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295618; c=relaxed/simple;
	bh=uNKzVkNJFpozNWtvy1jhRUT5jNUMWuz7qE+T0XvLyk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2WIqRBu2TX57LKPziR/lSnjQZjwAnTlxSZMF+v/g/3ClnpBxlCEs6vX2mR2TkhbUpmEufR7SgSjDgT2bpGHZtywP8oK0qL4gubSAOCTfjgepusnaqphJFHiZ0y50g3+xVQ7rAtpQGFMPPoAOqq/hDZm78AjzKLTl1ZWXSPsIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQbe3/TI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FLmOEq001422
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VOBIKSyTfLYVpO5P26VZ5Tfy
	QvJf2A+s0orIIhlOTIw=; b=hQbe3/TIh+Lx92wl90eOtXPQKSM0HZOoEu4cJ4xR
	fpf8n/RoDtHl3iPO7262sn+6mMNyyJWrAju9JRRwXquA68rRhVLM4hGTy9x3IACn
	p5BGUOrJhGs7s82uXVo2hMh+8PsMKNrf47Vwmm9r0FNcSESzE7RfsNREJLu9iesa
	KpQbKBztmQDLZNuDJdwCaKpHgnrI3sX6oW4ETIHbKwe2X16d7u+njg9YlQphjDcY
	+WTPnGX+zhSySjSni3w7pcs78tkACQ3vrbBgD3CXXilaMxfKGQOlNhWyz6jsqrmN
	ajcIrilAo2hQtW69VBbWmpJCOPZkr6wPlWO0ahMo/s0JkA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vy5s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:06:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f6346f8so48414456d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755295614; x=1755900414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOBIKSyTfLYVpO5P26VZ5TfyQvJf2A+s0orIIhlOTIw=;
        b=GjV0KGh+78X+w+wfNU2cHuhEClcBvL1r9ALdEHem+Hk7iNfBzsJUEvQVfFLIu0vKt7
         ne3Ros6obiskh6kuvNAQu39Q+hMfsXKtMUU5L+AuKqGYht0qvGXzDQanASm71h5A5tkf
         UTfrAAKYNVZ9NPcctuVmrg4/uYNc2CNrX+bEzngmo9xJxWhYqlCpPuLO2ZPUkKlR400u
         TNwXZSe+gYyZFoEGuz0bkJL3OnrzFVgPC1NZHpHOCFVqziBCtho1ULp44pgpW2jDNjDN
         sTzxJhQX2iA5oMsawE1DsoQSRsriJZxMUmA5p+0AkgFSkR8dBqldTsGN2DbaZ/cV/Szm
         FHbg==
X-Forwarded-Encrypted: i=1; AJvYcCWGfMPE+xf62j5jk/xkqKpix6c6GPjq2N3eGJbnWyOcTVudSQCv0yc939MGhu0KEelkneFslzE+/jJ+vhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLAJdN9APH4Kkp9XTheL29u1ivjT1I99TxRVd1HS75BCznpPuY
	4X32pYMVsaZzeMY16ugRJbk9K3b8bZ3/8SY1PO7p+1KbkvTQEQf/IeMHzHGzX8FR9czz8rLDwSv
	1vuwnzuGpFpos+zn6k/dkzo1JybY+JYLDR6/Eb5AzG1V81jdxa1EaUzlM+UWIDHCXtTA=
X-Gm-Gg: ASbGncsvaWHltGlg1QL9zORf56KIifwNUmaNbVzCWnBG/KAwxivAnuGq+LY77erNFUv
	fTTb7hYdvMKtnYyRpVY1CpLcMKxde8CmUu9L9kFrqpxlLvgGG7kWbUT/P7AIUlG8tPOcCIhglOJ
	cWAya9GQQZIcl33HSDIifBnnjyhd+o4YegcNyj9rM//M2ehz5+T7QQZUZ+D8mxjh8g2sS2nCjG5
	X+loRyxsXk7DYnntNxhsYC5kJxD8LItT6pZdXwSY5Xdd23bR1cT0iMVmwJBBGQgAwjW6Ri6GkZZ
	m+y0+iJZoRyzK08y8SN+cLA6BARSA3zjUeoLM5V3ryLwmzKpFEb0JhlOmo1gr5gs/hnMm/oPyi/
	6gdqP343U6+HjPyEu/H2fQMv/UIxyL4tpxvoMXMugoSGXS2Y1Sr3N
X-Received: by 2002:ad4:5bca:0:b0:709:c997:a81c with SMTP id 6a1803df08f44-70ba7a9a7e9mr46893216d6.17.1755295613526;
        Fri, 15 Aug 2025 15:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9G6CXo1SoIyR7ep7jAxw2tGGksasdF1FtsJDXuZig6dOv6C+t0MATUifhC4YEo48+4WrwAA==
X-Received: by 2002:ad4:5bca:0:b0:709:c997:a81c with SMTP id 6a1803df08f44-70ba7a9a7e9mr46892696d6.17.1755295612991;
        Fri, 15 Aug 2025 15:06:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc6a3sm517416e87.102.2025.08.15.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 15:06:52 -0700 (PDT)
Date: Sat, 16 Aug 2025 01:06:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Christopher Obbard <christopher.obbard@linaro.org>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: x1-asus-zenbook-a14: Add missing
 pinctrl for eDP HPD
Message-ID: <pmhy2ogyorelllgandehtzlen64tzegp5pc6fkg7al7xzjcb2h@lq4lpaaavr6j>
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
 <20250814-x1e80100-add-edp-hpd-v1-1-a52804db53f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-x1e80100-add-edp-hpd-v1-1-a52804db53f6@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX1v7Wxhhy1DTJ
 KE1a/K2g6vZN37tRc/daLwHSme3fEwCY3O/xjhidfc43JXxrzT0T23/Y9BeIVWvNyHG87r39YWT
 tdZkeDDej++OE8lqx4iQue7HqClPN2XnJHOtcbf5hu+QBRlymOipkeqdQb7g3R6Q+1WKPIOckrS
 18uyAmghXhMVFscJWAt+NOATQAoX9n3w0fKySouTh/wBWrmZ4eXultsyGVBjMaXh0uKl4EkX3ec
 AStwadPZsoZkU+wA+xC1AEid1i267Hr9BzhSbfhlyQ3Ifajzd7XW2oaoYQ2kjp8+OHQ4IVV89H2
 csqxG7gGvsOXYsWR9FVpV7OLhXmyYkhi2DP8nhiXei5YdK5ZtBMrsRAPHx29fCJSwyIwbQa0kM/
 xVUK+2H7
X-Proofpoint-GUID: J8k5YhUlF7OEiCXgsyglM52qwfP9ub7A
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689faf80 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=18jjl7SCHLW6QrnkuXEA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: J8k5YhUlF7OEiCXgsyglM52qwfP9ub7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On Thu, Aug 14, 2025 at 03:30:28PM +0200, Stephan Gerhold wrote:
> At the moment, we indirectly rely on the boot firmware to set up the
> pinctrl for the eDP HPD line coming from the internal display. If the boot
> firmware does not configure the display (e.g. because a different display
> is selected for output in the UEFI settings), then the display fails to
> come up and there are several errors in the kernel log:
> 
>  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
>  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
>  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
>  ...
> 
> Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
> bias-disable according to the ACPI DSDT).
> 
> Fixes: 6516961352a1 ("arm64: dts: qcom: Add support for X1-based Asus Zenbook A14")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..613c675aac296f931293a1ba3d8506c6663bad21 100644
> --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> @@ -1001,6 +1001,9 @@ &mdss_dp1_out {
>  &mdss_dp3 {
>  	/delete-property/ #sound-dai-cells;
>  
> +	pinctrl-0 = <&edp_hpd_default>;
> +	pinctrl-names = "default";
> +
>  	status = "okay";
>  
>  	aux-bus {
> @@ -1236,6 +1239,12 @@ cam_indicator_en: cam-indicator-en-state {
>  		bias-disable;
>  	};
>  
> +	edp_hpd_default: edp-hpd-default-state {
> +		pins = "gpio119";
> +		function = "edp0_hot";
> +		bias-disable;
> +	};

I think this is common enough. Let's maybe push this into the SoC dtsi
instead of copying it to all devices?

> +
>  	edp_reg_en: edp-reg-en-state {
>  		pins = "gpio70";
>  		function = "gpio";
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

