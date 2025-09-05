Return-Path: <linux-kernel+bounces-803019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EABAB45983
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAEE1BC3811
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123FE352FF2;
	Fri,  5 Sep 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFNVac5W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD06352FF6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080092; cv=none; b=AHpL6dBw3914bpYt/khKabZ2VnjXSu41rxdG9vAPioExYlnckv6k+sngtxrqvds7zAmv3z3+SVoUsZazwE0WACyKG+6cqGGI0m9P0YByaZZzmBtJ52zoVwWtuXrfjNO3FDr7QYafPapJ/Qp5HGCwZIboGRr7D+bDcPGPkS6WhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080092; c=relaxed/simple;
	bh=aLoP9fVki7moFz2j7CFs1z2tkOV5HiWWcwU8+urXZQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnsLO9kYO8OBOhESehNyJ2f4nP+v6BJh4xOmipMUnFzGteoSYgfGAhyte21p/5h21Y4CW8IhQgpIGaCoOpC0ffw0yGDg9Eoey+e89NZ6G2eJhhi8sBTCMRkM8uHoTIaaoA/a+aQ/0jJjZ4GOPZNlIGmEboEbe0Y6ZhRNMZfyYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFNVac5W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857Akrt007841
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ap62K/FP1kV8FYl5nLQxsQVk
	YwLvqHfb1niQXjNYis4=; b=kFNVac5WmL+evduZmBgoD0T6kEYqwEtpzOOB7XMG
	VJsTM6cV1fa3qYXkk0UZPHxqmCUD9juJRz+N41KBPZ+hKV9Qgbxf9ksCfik8IiAm
	t69f/7Lke8FAo421AH3JiPsf5zeqJey7T5lv/5ng4VXQ5oEeuTdQHRD4nCuddDlX
	9k1omGXx2g37FaCj9ROgEiv5YpHmVr/jPp4TOilcmiFKCof/DCGwflTIkZ0fR5Yl
	KPiueD4XuMqLDqQJ1SARVhbH6eMZoVOXZZAbWBCm+iUlzLkqvkMtLBb2BcNc9F8r
	CCtfvW32rDKE6b6vOXduBr1iGwlIDc3sgTpLTiLAbDNU7w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura93698-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:48:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b49666c8b8so43898341cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080089; x=1757684889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap62K/FP1kV8FYl5nLQxsQVkYwLvqHfb1niQXjNYis4=;
        b=HqVpIhdSe0/hqqTxmr0OoGQw4XAb58rMxiLVFjx5CTq3lavQBBMVhQfe9FDcOiJCJp
         t9JtekluT/cuiwawo5YLDAQQojFTpT/V+6POIlB7/GrtBgQbadi+MWxUzcIuCRWV+2xv
         tu6ZzZibj1ECvOz4HiG/A/e08rPQTVp2dzFcx0vfqCT/IWkHmLDegwEhFpuGpxFxKYaq
         b3xNaeou8a41GZXlCZL3iaBx34M1lq7Hx8AZ5jBXDwPORPEmnTlCYMdn/GJekLbY+INl
         Rmyb1s+IxZ8hayG00T/0Xtl3H7YdfBepd04prPfG2iWxxg0p+HupKXiyRs0CO/8n4zsk
         4PIg==
X-Forwarded-Encrypted: i=1; AJvYcCUP1R4LcwYbvuF8GIWTcT2x4UrhhOFdoDKlYGytWkJmalMrRMsJVsxngXspGl023WwqZz4rhq8JQm6roA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSArLkn9iJ2lskwiSaMxmI5abYCKawThgswm2bxkt7BKsYTToX
	4x0vHE+h+6no7SvaJCprW6AodeqsCR1xUWiqRNjrEQ4XTja/gC+oGVnaQ/2Y9P8zAkoMUNCJ602
	Xg2rnNEalp9R2WbGonFJm+3owlL7y9xjDod+Fl4OvX8o4voq/n+JddmtZItt+FMjIcuE=
X-Gm-Gg: ASbGncvOgD+k6xQoh+HybamtjLXlJWhdmd8JXTmeqZzguhMLXcDhDpOwL+sYKidaJjQ
	p1T/nXD6AzzVYEezmwCQyQ201UREJPQ2y6voAGAF3sJvtWj9V1cu/DKHNEcvhVFgogKVWKWzYUl
	y/MomSE66Y9vdIDxv6cRzSHwtwn3CaFdvkYr5WeWBZvubslzDontpII2vSiu2nYFKhM6QnjdMna
	xds5UllAyprr+DtsSrX5lWi0L9dvngeRApwNie6VdGk0axNE9Dbq1KxKFSsmlymRdmwK0Tlpv5k
	2qp3ToIPkUn+wbp9x7W3wYAKSc3rDfUJeElx4oXlRR0KA+w9wNAZ84RJYk7eW4LrAA69HifMf16
	xcSo5C3g/eWQ4rJGkmpcE0ybRXzkGR4uxUIZcj3qIq8BRAcr6GAHz
X-Received: by 2002:a05:622a:38f:b0:4b4:971c:2fe4 with SMTP id d75a77b69052e-4b4971c3190mr98469281cf.62.1757080088811;
        Fri, 05 Sep 2025 06:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU1g8bwxyXF88f0bGvMVljHRg7TlISluEwFFoi/D70N/z1VXTCr/7Gek7kIvhhpDJ2WIEJ0Q==
X-Received: by 2002:a05:622a:38f:b0:4b4:971c:2fe4 with SMTP id d75a77b69052e-4b4971c3190mr98468881cf.62.1757080088273;
        Fri, 05 Sep 2025 06:48:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608abb7c74sm1792273e87.54.2025.09.05.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:48:07 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:48:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/6] dt-bindings: display/msm: dp-controller:
 document QCS8300 compatible
Message-ID: <jdbwncstextusng5boqg4v5r7krbnjts6f3zgd65cu4rrst7ay@kkod7ihbgfrp>
References: <20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com>
 <20250904-qcs8300_mdss-v11-2-bc8761964d76@oss.qualcomm.com>
 <p2okyfwfl23bip65koaqezlvhyo3z47bnugojcieuspr37xc7b@s3qwgbqmts4l>
 <d8aaff46-9e3b-4b53-a690-351253753edd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8aaff46-9e3b-4b53-a690-351253753edd@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: brWeoNRU1V_ONwzhDlrNmEqgqi6I5bY5
X-Proofpoint-GUID: brWeoNRU1V_ONwzhDlrNmEqgqi6I5bY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXyqnlvgPpKUp8
 Qi4H9gKdW7ZFfBh7vWuZqxXUkhAccY2RZtT8sHyE3nSKwLN6fgaZ5kLd4wwFBnt6rNiojR1R8m9
 A5jK7lTIiUDoB+/avat6+5bT6uuGxIQ6GIsZ7NvqUveYPSjTMsShXz7uchfFWlbdhlJONccKCWh
 nkZYd3NZ1mXcIIdlM+AgTMCxNkWyL0GmZBkmhEuMFLJaIYQmDJ7HcIT6EBx9Oko7dFBTPKzgxZk
 I/y1kaLudifrR8BgOI6zm+Sa7uupEix5Ff9axi/eHeth9weZmIqwCauIHKpwOeLmXG/+0zzoadH
 EbHMj99lfhGLtFo8Q1ajna68qLkSqpppYw15uA2nI+ePnp8QLuyIhRrj26uBPWZK7HHHl2LlbOz
 szzMQorf
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68baea19 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jiGyGyMmBADT3WBvkIIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Fri, Sep 05, 2025 at 10:50:33AM +0800, Yongxing Mou wrote:
> 
> 
> On 9/4/2025 9:43 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 04, 2025 at 03:22:37PM +0800, Yongxing Mou wrote:
> > > Add compatible string for the DisplayPort controller found on the
> > > Qualcomm QCS8300 SoC.
> > > 
> > > The Qualcomm QCS8300 platform comes with one DisplayPort controller
> > > that supports 4 MST streams.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/msm/dp-controller.yaml        | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > index aeb4e4f36044a0ff1e78ad47b867e232b21df509..ad08fd11588c45698f7e63ecc3218a749fc8ca67 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >     compatible:
> > >       oneOf:
> > >         - enum:
> > > +          - qcom,qcs8300-dp
> > 
> > Can we use fallback to qcom,sa8775p-dp instead of declaring a completely
> > new one?
> > 
> I think we can not use fallback to sa8775p, since we don't have DP1
> controller for QCS8300. SA8775P actually have 4 DP controllers (now only 2
> really used). So in the hardware, i think it is different with SA8775P and
> we need a new one.>>             - qcom,sa8775p-dp

The DP controller is the same as the one present on SA8775P.

> > >             - qcom,sc7180-dp
> > >             - qcom,sc7280-dp

-- 
With best wishes
Dmitry

