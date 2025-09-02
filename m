Return-Path: <linux-kernel+bounces-795502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A4B3F33A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C944E1A81347
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE42E06C9;
	Tue,  2 Sep 2025 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FbK2iQxf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2F284B4F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785838; cv=none; b=gmr3+HasRRjVpjRtdpplTz4BsAk4GFt0JERLgQp8qNPzKj4caBl9DnLLHR9tAi+U3JTD/NNXKFM6Hj4CjEaiaWEqMwm3/tf4fhAV+dBV+EWhxh8nVYH7EbQ3CDMDQI8JS6iwlKFxZhL+gb1cP/LvwEp99KWN0ehNFCEnU+AVhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785838; c=relaxed/simple;
	bh=ymLPCwxFwbrJgIxnlIP+Phx2dA9of4l70QPZIV1FKRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH4pS5ch7ZKd1jzB4O0VZ0i2A8bkHAJPWNuX86G990p0SlxBlbJxmcDbZ7/1Mj1rgzGzLoLJuMi8Wdf42Sa52zLbs/aCE60CQYmuvLAlv2Mj1f4249xtxpdFHIqDMpJkwLI8cJxNNeno5Ua9jV21HV5d9KsyDGDsRuZLX/gsfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FbK2iQxf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rt5C015207
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 04:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/WALGo2JvVutG6gsRclwiFGQ
	ouibq4L+PAjX0XefD1M=; b=FbK2iQxfnOMuCc7rkHLQwVJRNsv29dc/n7Xa0Mjr
	rSk/PZGspJytwWUBRjGXTUU8KxeRA7ygvpBaUghYPjXzbIuul3HSjMKtE0HKZdSd
	if8NCoQty+xj7S4bJ7AMpvUTpqKV4DcMB4P7gcQWTiBWJbjtEy1oRh9iB4foD95j
	xkJt3cAV7YkRFL7Wfp6DKqBRj55FupmMi+0t1CmcB7FIwjlyMq5XfSMVMN/yQWpu
	IGBHbk6Cw+c85lEroHjNeN3sY43jmqud/gsUcpqK8EbD5CzOrTazxejqhEMnzbjP
	6h093TkdP/jr6J5ZwLWvKmCzTPQ2wu2Tm+UFJTeKkniRoQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxehf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:03:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b311db2c76so23685261cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785835; x=1757390635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WALGo2JvVutG6gsRclwiFGQouibq4L+PAjX0XefD1M=;
        b=ekH50jH3V147++atwsKprmKWbnUyX64Tzu+wEt8hUdcp67gijqU48FXHgSbamb6xLY
         vnK4xEiwGc3InAp7OpSx0FenLZRHHI0nU+sGmRadLnGJATYFmcrcq1kzmGoUtH4zPBH4
         6S3XUAInY1BoMWTYo33W7eQp9rTwZDdFS3X4UKge1qPx0ta3xELXutU6oRUFi6a9Iely
         dS2dyhD52G14AQBTmHiF6Mp+YavWhoQMA3MVAmJLw9iqPzQ1gMhtda3MDAEvV9jmhTq6
         49xiCTjAhWslb/ljbQ0eaoDtRQYxgFPJSxaOVLvzfJmCW9zda2Ftd7PRz7eBXcp5IAks
         eiSg==
X-Forwarded-Encrypted: i=1; AJvYcCV9sJD7bvcJboL1C64TPYZgtDTL8hdytS/TBpLElCp+SVsR0VW83G6Op3iFY3BPiJvrv4ImmDVMrFd1dG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBuqxkx34gVcqYp94wO+bwi9d+cMPqMPmc3jQSl6JpR220zow
	qFzH2JwPFKC3QwrskAQifuXvaFYhFgKzSpXVz4D09DMxMoGe6KF5zwrcv9gQjreGqOahbEerh5W
	4UiasUvmILJswaCSvZrCp/OX6I6WqMTHAXVeHRMdOmcHsP+JiR7WHcrMC/kuyztWumE8=
X-Gm-Gg: ASbGncsKZbMtS8J2n8NJGnDDbanPcmRWq5qOzSCYFDgChgZRTWN22irKgENiUBkIomy
	OEidxywYBdxPOxMdxdqe5myRlfQS1ds79i6KxkQIEC2qxVnmoPlHiWvEyY2u4kHOsJlBHFIWyaG
	oa2/HfkaH08YUWpLB8jAeejrYRbSpbxU13usyFSPBypBjQUYGihHJunbSLv1X5chZjHL0QoAYVw
	RAMDGXkatpiHaEHMfSN2bOy4wM5rA0tCmZl+2Uj90uwTsi6xpUw0c6XJ+jPbmL/gGLWPk4M0DD7
	JYbffedw/Q/tiMlhc1IfTacWtpM7uuwurjNhoFomM1yTfEEeQiOHxu/rQHo1YAmEieN6b+UvXeD
	kOxTdNDRF9pQ+OfYYGD2/EtnorAW/jSB6SKwbJR8bqk5ieu3azP58
X-Received: by 2002:ac8:5741:0:b0:4b3:196e:d10b with SMTP id d75a77b69052e-4b31d855248mr109144341cf.35.1756785834660;
        Mon, 01 Sep 2025 21:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhz3e+S9igaqklM+Nu56w7qP0qgEoNyJRpjNeMOfilH27MmdcsBcxnapYMReC1i/HfHJ18xQ==
X-Received: by 2002:ac8:5741:0:b0:4b3:196e:d10b with SMTP id d75a77b69052e-4b31d855248mr109143931cf.35.1756785834103;
        Mon, 01 Sep 2025 21:03:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826d11aasm352891e87.3.2025.09.01.21.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:03:52 -0700 (PDT)
Date: Tue, 2 Sep 2025 07:03:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] dt-bindings: display/msm: dp-controller: fix
 fallback for SM6350
Message-ID: <qy6c2gundpbz5ixqpt2hefzfb56wcrzcaclqwg2opof4zc7lep@dpc3nv6usurk>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
 <20250829-dp_mst_bindings-v7-2-2b268a43917b@oss.qualcomm.com>
 <20250901-arboreal-gay-wolf-bcaaec@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-arboreal-gay-wolf-bcaaec@kuoka>
X-Proofpoint-GUID: Wy1C5hcCR0rU0Hz0A2RO8Y5OWjliCH79
X-Proofpoint-ORIG-GUID: Wy1C5hcCR0rU0Hz0A2RO8Y5OWjliCH79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX6Ry9xg0SVg/P
 QrGg7BbJN4jXEmGF4MMWJAuA6YEgdD9BYh+C2erFXrStJJA3pm8aIAb6+AAu5O/aGCv4zTurGFz
 0N/bRB8UBRscVqXx4EmXZe+OJ8HYJCeOumVRGob1VepYhJ0Nf7B9+p4F6kBA1/Am0czh8E9Z02d
 WP1UtXqaxBO3rgRcrJMQuw7d65P/N19FQ9hHCZU8w3wENsv6AU/coKghSFb6UnbNlv+UhPm3snU
 z0/HhElco/hWzxbr305KST7AfxTXZ8R7D4D5dOLmyeQh9FGFDEkaT+iG9avo2He1oXK9ybIF0LW
 QV0GQfdXEGR326FPmtUtKp6GDFW3nuCqwlILPq7innCOf1S2NxNS662d66fDkxuWjAvjbpBTJiW
 uJBdHgye
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b66cab cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AgfzEzIlf9_PdHV74f4A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Mon, Sep 01, 2025 at 05:45:49AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 29, 2025 at 01:48:15AM +0300, Dmitry Baryshkov wrote:
> > The SM6350 doesn't have MST support, as such it is not compatible with
> > the SM8350 platform. Add new entry for SM6350 with fallback to SC7180
> > (which belongs to the same generation and also doesn't have MST
> > support).
> > 
> > Fixes: 39086151593a ("dt-bindings: display: msm: dp-controller: document SM6350 compatible")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/msm/dp-controller.yaml     | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > index aed3bafa67e3c24d2a876acd29660378b367603a..0f814aa6f51406fdbdd7386027f88dfbacb24392 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > @@ -31,13 +31,25 @@ properties:
> >            - qcom,sm8650-dp
> >        - items:
> >            - enum:
> > -              - qcom,sar2130p-dp
> >                - qcom,sm6350-dp
> > +          - const: qcom,sc7180-dp
> > +
> > +      # deprecated entry for compatibility with old DT
> > +      - items:
> > +          - enum:
> > +              - qcom,sm6350-dp
> > +          - const: qcom,sm8350-dp
> > +        deprecated: true
> 
> If it is only about bindings then there is little benefit in keeping
> this, just drop this case.  However you cannot drop it from DTS, so this
> is a bit pointless.

Our plan is:
- land updated DT bindings, describing MST clocks on MST-enabled
  platforms,
- land updated DTS, adding MST clocks where applicable,
- land driver changes, keeping legacy support for non-MST DTs on
  MST-enabled SoCs

> 
> Lack of MST support is not informative enough to claim it is not
> compatible with 8350. For example if it was working fine via fallback,
> then that statement is simply not correct.
> 
> And it HAD to work fine, because there is nothing binding to
> qcom,sm6350-dp.

It is working fine since currently we don't have MST support on the
driver side (nor do we describe MST clocks in DT). It's true that the
driver will have to handle non-MST DT for SM8350. However I definitely
don't want to describe both cases in the bindings. SM6350 is not going
to be compatible with the MST-enabled SM8350 schema.

Yes, it's again a lesson of 'describe hardware from the beginning', the
same issue as we observe with several other Qualcomm cores.

-- 
With best wishes
Dmitry

