Return-Path: <linux-kernel+bounces-874616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C16C16B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30671C22D55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B5350285;
	Tue, 28 Oct 2025 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0SdCCTU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GCbFO326"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680EA339B28
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681517; cv=none; b=g3Y4KbvKyfGoEhIXCBhSPkGESK9YJjrBunFDt/QMw0U1ahgeObJjFGvJLRXkhEtweLGYPw+OuWLuxZL5tFCvlbKjf5OsELVm10026eKJgxqzJPw9IlpbRu0sz/PKTYQCadoqarpHaShh3cVhezrh9w9ABBe/6zes2I9PHUa6/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681517; c=relaxed/simple;
	bh=GLSINUkccScePhTQCHGJIDiXL+ge2JT2Ltk3bZlFwU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXPIxbMzfDUObZWudKHxo5IlBsXKR0nKZSD91GuggQADL99GcWq3T+F2rO4hXqJdRXTsNOBl3CrPhpOrzRuFNdmpsMenz8aODGHXwSvAA3JTHYS4bWtPhI8kkL0jDytjxCH/H7Eqe003b00H9BD5RbZAv7rFsMpVn/qeZ8QkFd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0SdCCTU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GCbFO326; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlOpd2539332
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HC9tpIvHIz6+9K+gz/rNc72E
	qizD+nH+1zUVfnpz0Z0=; b=V0SdCCTU36+HZCsh/6WlYGSSvqGWix3hPXJpsYgr
	+qawP9qJ9Supln5gGBRWA4Eq7MvchO+uciBGQdlAf2u2TDo9yLEj28P9S8RJ7o5Q
	QuOCnNoZs+UxolxPzd3t1KMRAhCIomS4h7aYLzjDyTAfMRpBWZqh5N/YKofNSmAx
	rN6vcGwe+VKVRQbzwaqNHZ4zSF+G0mbNn8pJ20Ju+mVsHeKtXhvKhH44SIHXu27r
	HYs0gyWsrOAX6EDsrJRkMG2rXoVY/oEQ1vaY5O2X7dl/yA3+RmD4Xg1bJWdQ0v3n
	EIbVzb1oY1hko52mTM55HuMHBHQekZ6Zdb9zTU1ubANTTw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1g0r9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:58:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecfa212e61so7019371cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761681514; x=1762286314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HC9tpIvHIz6+9K+gz/rNc72EqizD+nH+1zUVfnpz0Z0=;
        b=GCbFO326vbtF0TaRN1Xq1gL9DvZ6xaUagbFjxNiWBaD16vPBdNlMfW2M9ljILXwKIC
         3lhU6P2emC3l+nYPNWUhzcLjgLOiilKO/8fSSN68GEqD62VdNWK68m7HH4oXFRbwjWRS
         EHKqRDMj0QaTbCYLpWBpLFsEiH2b7CQdSklSk7tq7/xt0Ey7I4PFX6LvBltsdZ1F7CA+
         ribkzFWSThNfhoQhu4W7BohbRUDtg/AmOUiMDHt1NSts5t2blFjuTvMUX2ZE7or8Uyo/
         5W2bbAOtQd3tbpVOuiIUkrOaPwQdX6Ko5H8XZk8xoP+76t91688TY8xVNfcME1oLBDlL
         BKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681514; x=1762286314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC9tpIvHIz6+9K+gz/rNc72EqizD+nH+1zUVfnpz0Z0=;
        b=qBK/f33H8ANBpeOzS7CA++eJrHpiGnM0TgrY3c7Qd+oE2EEZg88S3pSGsluw5iT84E
         GbqUlzLX/CJOcgG6FoXeL/NqNd52isDgqJynuF68CF0niJqbePKaP/6qY+Fzc2og8r1u
         0mhZQMNVDiXPLWTLVRhYuyJGIc6h9qjlyaXJjINU76LZ+KIMf4FkNhWcE7QdDS7u+0qR
         xGsy3qCoPLtU8vxv73w458ALxZkhi8Bl3Et5dFncrgPUZDxHcVQwyfmEph4CznTvypNL
         shrm0SCGNCtX52XYyjnQxKCKOBG7atujH2pRPw8/jYk//mOUick2VwtFU8hKiUgRhpz8
         nCuA==
X-Forwarded-Encrypted: i=1; AJvYcCWO6RU0pGMsePMDbQ3Vusqc/mSXpKjktUGKSazV2toVFVDbNFiMj8+LfPMfE7pNRhYBwjkfVIIYoO0iu6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQf1ElcI9W8pizlNp/8ldZlpZDMTJ/Yq/uEJ/L53kcoo7CBwS
	smQQCNvit008WriGCJic8jBeSrr7dQrmBeq73dWBfcIOHONDAIiRlPCxEIDnRAT1JYcErRY2KjQ
	1RW/kk+StC1L3SRcxS30jkyZleu1TKfav453Hwc3OqXgLFDU5abdd8qBuw0XElod+8HM=
X-Gm-Gg: ASbGncvXRaEfsjWmbVso6hf6BY9qliSmJ60TL1TJj2/VU+PMuS1JIRCM1SQFEjazjlz
	MNRo801SnFN2zTY1iEgGNoN0bxp6DuJiqMydTbASbSd4reeGk7P9ikyXL8HYDGfd5yX1Sk/XiJ5
	Ozemt9qYLgqfhZ57OM453a3DHnzyJfmSNSG6Td0oKedes4X5sxYDRs7y1rFuBtKCA+frpZ76ZKz
	8HGxGLw1ql+O/fllWVSljAUtdVj27ClIxYXiihwVchEtXMYvLG/hqf5bhECyEB8lxhbxsUNcW2o
	L7P1SPIzsNGaVS22u0N4ncRBNFeCtVk/nFrdjVudB/tuLWPp1UxTuwASizllQkfZImsYb2FG6Dw
	qIxcDDscyO3LFmqKigNpPuLiRowUVp0NyXBK/1WWgO6VvpmvuS1cQmAxGbaICzNRBNKD1/rQP/a
	OOe0FWXGnno6zA
X-Received: by 2002:a05:622a:346:b0:4ec:f2a1:5c9a with SMTP id d75a77b69052e-4ed089a8095mr48571571cf.13.1761681514574;
        Tue, 28 Oct 2025 12:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaMmcLeIcEWm2PB1CZcpPJ3nfsaaOwDHDWrSPxIXsesjcRBn28xpDk5g3XqlOxBTccXdasMQ==
X-Received: by 2002:a05:622a:346:b0:4ec:f2a1:5c9a with SMTP id d75a77b69052e-4ed089a8095mr48571071cf.13.1761681513956;
        Tue, 28 Oct 2025 12:58:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-593097eb2d4sm1632173e87.66.2025.10.28.12.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:58:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:58:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: xiangxu.yin@oss.qualcomm.com, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v6 1/4] dt-bindings: display: msm: Add SM6150 DisplayPort
 controller
Message-ID: <hzmwjn6xmb3kqvbvhhvycoskor4avtuuaubda5m3vmouten7z7@bvo53uektqln>
References: <20251024-add-displayport-support-to-qcs615-devicetree-v6-0-c4316975dd0e@oss.qualcomm.com>
 <20251024-add-displayport-support-to-qcs615-devicetree-v6-1-c4316975dd0e@oss.qualcomm.com>
 <m6j3sdc4jb2jonzbpez7g3xb6cfputdz34wtydfrx736nqvrv6@o5ntg7csl7dr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m6j3sdc4jb2jonzbpez7g3xb6cfputdz34wtydfrx736nqvrv6@o5ntg7csl7dr>
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=6901206b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pr-hqIQVVoteFAb5gkcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: TOe9QCNg1lGS9IXLl7uDfGKZeJy6FmbY
X-Proofpoint-ORIG-GUID: TOe9QCNg1lGS9IXLl7uDfGKZeJy6FmbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2OCBTYWx0ZWRfX3Cd63R+QKgLZ
 I/EA+lEc+9O4duwMstQE8YXxvy4/fxDdp3UgOrqntrXzG4a7c1C8/MnsZmvp9bXh9uTGCV7mxuK
 1o3Gc1yVw1/lbc2G+c8EDTRIh1vZVF3fPsFDyBc9VDI4NWmIDD+PBhBObMQ3TJrq4ZLO6Puwb2w
 TsJSRzWmM53wpndlVhpxLcxrKxF2TCRT0uMGNihz4VVFZ2wMk9kDEH7BK+lYIu775ay+QneQw6c
 VpcihY75cSc3UPqkrXM+c6SElK58tBfHeNN8EXvt47r3ivm3OX4DF4gsupIc0vA6zHgUOTHGD67
 oFUYoFuwWuAFkWWdJWnGAXvbH6TZlZn2sQQqhxF/mEz0lALTyaviQjPQpvZotMKBrkgIeJZspfl
 8heVHWfVYAi7pn1y2TsYBVdO2kxTpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280168

On Mon, Oct 27, 2025 at 01:54:43PM -0500, Bjorn Andersson wrote:
> On Fri, Oct 24, 2025 at 01:21:01PM +0800, Xiangxu Yin via B4 Relay wrote:
> > From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> > 
> > SM6150 uses the same DisplayPort controller as SM8150, which is already
> > compatible with SM8350. Add the SM6150-specific compatible string and
> > update the binding example accordingly.
> > 
> > Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml      | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> > index 9ac24f99d3ada1c197c9654dc9babebccae972ed..ba0dea2edea98cee0826cf38b3f33361666e004a 100644
> > --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> > @@ -51,6 +51,16 @@ patternProperties:
> >        compatible:
> >          const: qcom,sm6150-dpu
> >  
> > +  "^displayport-controller@[0-9a-f]+$":
> > +    type: object
> > +    additionalProperties: true
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - const: qcom,sm6150-dp
> > +          - const: qcom,sm8150-dp
> 
> Perhaps I'm missing something, but if sm6150-dp is the same controller
> as sm8150-dp, which is the same controller as sm8350-dp...doesn't that
> imply that sm6150-dp is the same as sm8350-dp and we could not mention
> the sm8150-dp here?

sm6150-dp is the same as sm8150-dp. sm8150-dp is compatible with
sm8350-dp, but it's not the same version.

> 
> Regards,
> Bjorn
> 
> > +          - const: qcom,sm8350-dp
> > +
> >    "^dsi@[0-9a-f]+$":
> >      type: object
> >      additionalProperties: true
> > 
> > -- 
> > 2.34.1
> > 
> > 

-- 
With best wishes
Dmitry

