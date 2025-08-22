Return-Path: <linux-kernel+bounces-781771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F344B31690
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FABB60CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8092E2F03;
	Fri, 22 Aug 2025 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cwgxJk7q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051E2F1FDC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862973; cv=none; b=FeN2Ixzp1Gju6Fplu+2EVW0dXSeImeX1rBESd8dzXYEXacHvXtKDfFT+URldAznCfC5AYg7R7CeNOMvql75C/ij0EAbtkf7wZLnBcnBuBJsudf6I3VngJkd3G28Rxxxd/XmTHzN+XNhihNUz7anjZZGGamyqlJH9QwDFQzTxupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862973; c=relaxed/simple;
	bh=AHqeCFwpaR+XWyG+EuC6U9h/5Qte6yk9Tr15/2zCm5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6Vp+bcxKntkHfx1gYvbsc71VMBp19crWWUXeGfu/Zvj7LYBByP1MQTqiHl/Tqfj3QKXFfnIer8W9A12MD0doucNGi1tIkCOt5pI3Yc1EYw28gASFK27ezRu8F7ONe75hJv7lMUMpNKlFQQNs3U3yrAqA436sQ+8/hvfTqNC17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cwgxJk7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UO0L020906
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5mw/UDB/7pQXVTX2eHOkG8b9
	9y464ysBkU4PLObgT+4=; b=cwgxJk7q1Je0QT4YtcE7cnsP1azGpggAmhfeZ+Mi
	cJsDgR490szXH+nqyumFgucJnIVpxN3Rl5GRNRcx0dHxNHetTF4oFROK8L4rwbmx
	Ghlv9JH7CKgqLLhdGhnUFqXB1d+e/C4Y/P7SDkWmr5Q1GqyzF0k+AK2CkWD/8kzd
	1aTmVG56ZXxbUDpLygK5Thh+HuxEqZiPP5gTI+bpblBZOBXqWu4KM19kna3wpM6t
	hjVTn1p19wU9J6IdeWM1jSY4e/s6TMRFdxppQ60M841sfXYhobUEKwZQg3ppo8xl
	SapH4849HNVdbBYuamJhIUfPmiE5Xr6r6WzTYJlTZLDOig==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n529131v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:42:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f562165so64301806d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862971; x=1756467771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mw/UDB/7pQXVTX2eHOkG8b99y464ysBkU4PLObgT+4=;
        b=qh7BQseON0Zax4B+Pucaif4iv0remeYosFZmmW/yTm90uFFturkAEucm86mV4ipsjg
         TGYy6owxVn2XE8XUAbeC0r6CIlSu1WdOLFaZFe5hYr/t5a+kQbXOhGStwRC8k/ckNH5m
         cMsAkwCIjwQlJ6utM15ebl07weYwgUlm0P6h7LeNFGv8I1GQzn/CnGcq9BkOkMmMcUJ/
         1/1rNEUfIPPAXPYZetSonhP0jovgjMt/wIuP8EKq6zc4FvJNyLu7e3xnKgK3u9tCXZRT
         /nFZ7i7FHu9LvO57hAnrL2vXaEClukmZbamU23EAi4zeIzlIoa2PYSUhqofkzN4M0SzZ
         jvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDFeRCAMpwKnyhSIJeuO1Jep4R5U3G/sOeiA+IxPyDWzGh3Zoh3WFNn/A9bz59WssERNJjrSawlUFW6hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjUTQ6+BxBODTIaU9NVWMcEAsF+dwMf59nuxIHNr5PMAJucnc
	h81PvZ5y/qgr4oWZScmP9ZBl56CgXdXB6nGYhN4IEoCRvJWUIgfhV3TA5YSsD7ncJ5Zwymtzz/9
	WyQe3wo5UmBTRCEBl7nS9J0NrNnnpcw02mm0VTq4VHmQFzRutHCzibcbknIz9g1stfxM=
X-Gm-Gg: ASbGncuIxwcixOHSWO8USdCsaFN68NNlXu6548DDkDZJs8StlGZtVpAQE1iUb25rW1V
	DUI7Dwr+SUra4jT3QLjAZlw2lwErgk/KKCp0vlgtc7ic/eZq6CXypO3/W7Q1eKjILR/VfOAIt7J
	3yXmP5c369E9uyq0rgNfJaurkaKyCRMQklkR5jElchZJ5M2qFAMiNE68YCDlcafN9GjUQ20nxB0
	GVgmSODZTti2D7kGQqIYmNsHLb83lDZPIDSUREi/S0zUPOKdW+m2VuzAaI8RVG1eGWytI/qNGDp
	QfE8jkXSRo9aL7j1xZVT8Rzmxkhjq5MxALC5OLpElD40svAhv3MPucuclMvDXQjWlyXJ6Xuu9tx
	VwzDpIiUBUoGGVQsUV/MOOy8GlbO+wMBU2umNtWIoLNIW9/MYZ4UL
X-Received: by 2002:ad4:5ccf:0:b0:70d:6df4:1af6 with SMTP id 6a1803df08f44-70d97238c31mr25038766d6.52.1755862970487;
        Fri, 22 Aug 2025 04:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0KTE4EBh/7HvpDzIMoDw2jPtywPhs513cF9E6lM3AxHNbAFd068WoyXeIrAeKelFl7dCsLg==
X-Received: by 2002:ad4:5ccf:0:b0:70d:6df4:1af6 with SMTP id 6a1803df08f44-70d97238c31mr25038536d6.52.1755862970041;
        Fri, 22 Aug 2025 04:42:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3354b208a13sm7287061fa.70.2025.08.22.04.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:42:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:42:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: lemans-evk: Enable Adreno 663
 GPU
Message-ID: <tapfkre772lrar4l6ik3houaq3ki5icqliu3tj4k34hvlha6rq@2tbmqra57bag>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-5-97d26bb2144e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-a663-gpu-support-v4-5-97d26bb2144e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a857bb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mhNRLu-bMZbuYH0aq7kA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: OFIpolO8FLFU3p3rjOc9Y_VYWyd03rIh
X-Proofpoint-ORIG-GUID: OFIpolO8FLFU3p3rjOc9Y_VYWyd03rIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6GxsPpODzkES
 7bF+JPBzTbnpC7QEbbxS9DnzkN+jC+2ySG2LQkIp+DtKKeEQMZMaz5IllFzOZUCqhK+01VBfG9v
 dELzDZQE67KdYBEBW3Wk/2wsshtM8zZX3FE1ZNNcneJf/A3/1FYXhoAMIDXaZM0FJbyFcvM392e
 9LkAatexehPRzbQKwhN1iZJW0WIWF5xIkbp2s6+wQ5NCBg+YBYQUiVNj7Q9lLEdtBy12AxCz2DE
 1bemIMviMgZXVv17wvt0pDtTNx24P8uA56MwKbU432yliYJAsTR+z3W3yeuCGHac9/Ct8M0DUoF
 dEJ07mR59opmsARTSkflptQ8UxHt/X2r0GH0yr1ZwT91sYcJ4U2gZ5zNvMkisIkwKcyOXK2mBcL
 bVTi2pq/hplx0UUriCSrHCHidi8JUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 12:25:30AM +0530, Akhil P Oommen wrote:
> Enable GPU for lemans-evk platform and provide path for zap
> shader.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

