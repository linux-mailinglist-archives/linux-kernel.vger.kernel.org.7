Return-Path: <linux-kernel+bounces-799627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EECB42E47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60BB3ABAEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84666199949;
	Thu,  4 Sep 2025 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SekZQ3Il"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D0502BE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946061; cv=none; b=tKXIBZIKuBjcREPAkg9pbWgsTg5EVeKdovzqJNRlVWYAt4jLU5cF6lOJccDKaPpOzF1IehHw/aT4+lzCSIGknj/x88tCmYbCRS7nmRGka1xEupkpuvSPGQsyc0Tz/XH/n5onBT5FxV8v7ca0CzJguAaYwYM7bhEyayh7CsccZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946061; c=relaxed/simple;
	bh=0sZo3zq7uZkf9+Ve/jrJfnxY0tHOn3ang3YutG87UOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyfXf7op22Pl4r5ODX4ZVENCRDGtTUkUFz78RQVO0IKI3WlL4xMnMKUiDgjFpNaGGkAbg5Tc2zX53M2rVxMXUCzVzSjs4yjrMpbwFhbRSrKSjpod6NwT0Xu8XeMcZ8fXUX2OgZR8QuZGPGTtnFsuPsgfMEOgip3QPzOeGgCCjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SekZQ3Il; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840WCi2032507
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 00:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XfrJrvdyAXmQJVa0rcNZrHND
	sz8MqqvZWVWKrBmq0R4=; b=SekZQ3IlTy8JL2eV4UuBYUfIC1IkmkZsa88yasc4
	AcXVfeKGNRrY/gJMoIbwvK0vavZ/DMTZOADrXMvbo0VnSCit8/GwiSmjPXfKeulz
	+MqF11KdC0rxEXqdieeCgy6EkMBitpjSq1dgoJ04/kTDwa5vqeAZhv6q24PRL+45
	4qQ78VEX1Cv+B7/+JXavAdpr3PbAE5vwH/e9I+SnqIUU2q6ChBsq4BfbZsxM4r8S
	871oCf6XH/3ijtgwhqSYRlQy94A/3SL2aWg9X7FLlZ5YbT5nko1bsIUwuJEe1/nL
	nNVP48/TFvgcQOpMsibrZ5rCNdLwK71UnQ3xqRsIcAqxCg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush35gwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:34:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-720408622e2so8969706d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946058; x=1757550858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfrJrvdyAXmQJVa0rcNZrHNDsz8MqqvZWVWKrBmq0R4=;
        b=F9gf5H3Mv3sBaQqFhDNR/BpuG2MMdLXT47DL5+IyIGEiszpe/g0EDYnwU3UQjzeStd
         L7Q++AukFYbLjwD0fNfx+85kPuQxoG0mxUKXrys+TJw2ofQF+zw3ehGSiBS1sMydjOEa
         823AyDF3N875sYmLH6iw9k/BJTFXLUjoffsVIuj9hD0ow3N5S1E/ZdQjgyg99Mw6WmTi
         4nytoATngme8j0jq79O5RD4eheYIT28wCSL53dpprjW4lWMH30aQ2rvl5Lwqq2HUSJaO
         ld3JA0dVICyvddZSz4PbZLeNTqbVcMzGdyAL4ZebUt5Rk6+0d/LlLa8fTLSohAm60t/P
         n+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXzXW0ZKi0omVG/ofLzG7+PT7egMfU/eLNyidRMq2GcMZAjkFGt31KqBfiUWT1k3wGnQ0eJZeqHGAauXmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJzftP8kNY9myt/gxa3DFA1KLZr020Tf0WkXt4cxDL/P6UaF3
	OjrOKN2vYtuQoRjfPsmL313z7fU/yjMK1MHkXpMExskquF6+nJo/1N4Rxk5WWgDpsqlNT4RtQeJ
	41o41Qi22ZKxNiCVGrWVKL4wVQhfKrtuzYnUM4+TPQ6RtzWJ7RTE8PbASUWbo4c3p5X4=
X-Gm-Gg: ASbGnctJJwB9QjEm+ubr4c/zqEJBJttt2k66xGnn0ha9d8S2MaaraukDjnbfASByjyW
	ThaG7xhDyCrh3q7wJsUN1PBzaDd3rQPCNVe4RabHdvItMMVD9fcUJA/quO7uCdXb5kI4gHtPsKd
	XJzYa2n7MK0cH6qU/gTZ3v2zC+57srwADQdgEzY69O4gJEluBXxziRJlxScppbvpdQPm17iytdj
	vFSGOYcr7Vf6cu2uvVskYllV15Bn9bt4KVcARHjEuOWUNecoI8CqUfo9IZs9C8fFB+W7KCFiRFn
	syMk3bmWbbsjWeZHm+QpeBWSvU+L/yMRy8aPukLGranT9Imjo0U/y4XS62cTuIXfeEVRiHudnqE
	nlh1wvAFi114GNVI2zQE0pHyDnjWVWCoY110dCsYMqfNK839/vLG5
X-Received: by 2002:a05:6214:1c83:b0:70d:843f:6b8c with SMTP id 6a1803df08f44-70fac8a7b89mr177520336d6.37.1756946058061;
        Wed, 03 Sep 2025 17:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGja7X2uK+OYgomkOzPWpjLsAEHmq25LEESvoGCpov8TlZrxYSLZ5iKF7ssAy+77a5qFU41Dg==
X-Received: by 2002:a05:6214:1c83:b0:70d:843f:6b8c with SMTP id 6a1803df08f44-70fac8a7b89mr177520176d6.37.1756946057510;
        Wed, 03 Sep 2025 17:34:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad525d1sm814295e87.139.2025.09.03.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:34:15 -0700 (PDT)
Date: Thu, 4 Sep 2025 03:34:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
Message-ID: <xurpc3mk5kksx7lfpsdqgasov5gc4dpsmz6iv2hjhsp5tewbue@dvrupbjzgxle>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX3T+ypPnDV0F+
 eN1FpPES4B0wPy9mAmbk9Ce3ttF/5CwhQ/NHk8X4UntOC2E6KkLKJDzY5TM0l3nKDuK1jY7SyL8
 S9UCnuEPUxGYBdJ2kJHGzl9gU5fIM3xyT/9iYzbIZpQUR4N/OROnkI+jMYFUV+xjI7wnrAxaKBT
 Hngs/c5D+SxhiOq5sWx3s8i/eknJcW14CYWt/FIc5eTEBHYU3nekQgEgKTp9lRflYh2OewsYEDv
 DqKE9Z5iy7Cz290l/Bo3YkW1e3PC8Ey/NGE04j4jAVpkGPNeUO6JqnyqvfyelhfzBjX4dJkZguS
 UM+xFX7tlQibkVZIvzxyVjdDNRf1aTrxc7dd6GwvyoLj3s04jS8UR5l8WXwRt9thgzkID5SL4ur
 5q3P8Mbq
X-Proofpoint-ORIG-GUID: _SdkC8DFl3Yoq9vj1-ALFJlC23w02uJO
X-Proofpoint-GUID: _SdkC8DFl3Yoq9vj1-ALFJlC23w02uJO
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b8de8b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YChNujVLCtOUS48-0VMA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_11,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
> Add DisplayPort controller for Qualcomm SM6150 SoC.
> While SM6150 currently shares the same configuration as SC7180,
> its hardware capabilities differ. Explicitly listing it ensures clarity
> and avoids potential issues if SC7180 support evolves in the future.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -27,6 +27,7 @@ properties:
>            - qcom,sc8280xp-dp
>            - qcom,sc8280xp-edp
>            - qcom,sdm845-dp
> +          - qcom,sm6150-dp

The DP MST bindings were A-b'ed and R-b'ed by Rob, so I picked them up
into msm-next-lumag. Please rebase your patchset on top of it and
resend. At this point I'm interested in DP bindings and DP driver
patches, the PHY part can come up separately.

As for the compatibilities, I think DP on SM6150 should be compatible
with either DP on SDM845 or DP on SM8350. Please choose one which suits
better.

>            - qcom,sm8350-dp
>            - qcom,sm8650-dp
>        - items:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

