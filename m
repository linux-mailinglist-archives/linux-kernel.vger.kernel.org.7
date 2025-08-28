Return-Path: <linux-kernel+bounces-789792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A2B39AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500EE1C218A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE030E0D0;
	Thu, 28 Aug 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ap71NfQ5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527330DEA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378792; cv=none; b=fcsDvaMnTri8i7GKvZn1A1MssGtKChOmIEZzOuaOda1BWR7BQ0DSoAqFh8a+u4q3udLM8/7qpw6vhnOoQE/7EhXD7Ep9b0Bm0qh/wuc9kTtO41etWN+zJefkpjQJXCfFP3nSuCtIUWMObWVXDf5zQDiMA4IMvDPzvbIcCZ+ef3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378792; c=relaxed/simple;
	bh=YFpBQDAPplpbmlEZuRqtJgd9SqJ5vf93R9PVYxaJRmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irZSbAD6Urju5FqH5AKbwYu492jBsFTW94F2B+tC/BD2D/4QdHxie+rnTS6GHPELIB5piQQzLZBuunr1Hzl4ddMwYv86cqGmIfLz/IJ7dDt0i/BSdFIXKnrFRk7NVLrEpLGBCmdItgtGfhDz5eRubVd133ulUkVkhjMrfThbCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ap71NfQ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5YJkk031273
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=09leXTKVtloMTscnxlYkAl4E
	C4Rzi1g0wwL1WchT0Sk=; b=ap71NfQ5K5jUDAfi+bXDcK/qtsgDg/YT/SZQC3gA
	/KmdePO0gMNFf0DYCXDBlZ01Q4r3/BNnxqwvJVYQ+29iMRJxb/z/3gD+tHMF403f
	kUb6+RzXWlObGjItyKH0d5umGHD2g8dTHyWC290dsrpIBCd5JUlXIETQpIgy7ZmO
	1ZRlal1ZwMyQQfvteSoPx0Z3MiU/nNh5MtDR88tZlco9Z+VxSxgAvST3rlUNTDtP
	rqRVR59XSbo78R7HHHiV4FYczqvkJSjT9BD4UFdvuQWkDhHWrAVFNLZcMW/Kp/QP
	8JBjIcKbqL4ylLT+L2qZu8DNsfM+D6eJdurDhpTYcrkyhA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615qvbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:59:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70de1a3cec7so17179936d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378787; x=1756983587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09leXTKVtloMTscnxlYkAl4EC4Rzi1g0wwL1WchT0Sk=;
        b=in2l+ecMp0QXkTiGX/XVssI98TJXVAZnJP8pZOk3EiTp90dasPcXq0otAZ5qSvhecY
         Lrh5HabWkcTLI2+tYb1IDX6VQMHq5ItdtLkEdiPTFJ1XLWbfSPyeTEDh8WGuQxVEhf61
         Z9/DiSWscQx+2NwECCFIvnC82R4lO4ZD/ZWhhtkSiKx4cqupROMVtsTtmcMg2oGJTL44
         rV3pqiKjWFe7nNQQ7qfrZtONzAIlmqiPNGDRtL+ZIY5jfDzJihbYjVILGPULHztABtWl
         ifwE74DMD4XmzOqLFWcVsrlFAVmlhOg2KXdnFFxCasYPPJqBGR5qAteIdSlZdgJ62niB
         IUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQmAwtTKcdsF2HKjOTKnMlaiie1OGvBS1jF9ZNrQQmGl8p/d1Fo5kgzn1zFWuvOo/hIpyRXtp7XA2HCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dL7CB5ytaQjlin8QrHWbDbhTr+br/GDC6GOdY85owz/6cb1A
	Eebqyo25WGzbb1BNJwNwwCaZaPQ/ILCWQudBHCIkB08kfQP8NoWWIudlPoT5O0H5Qdk0Jly/M2t
	WZBD9y53STRCTM8GkC6iNTzrilFgVxWv6BSJ8fxdESjuL+ErWdcGRUzghH7uyi8KWcjs=
X-Gm-Gg: ASbGnct5D6krIYEu8PsqVHfaZPA4oIKoyJjO0M6sL3+kUW3COD47/NnrIUpo85Yp0t2
	Cb5usgkyxCuK3PEcG4Jt+P3bGPBR7r/fH9ISXF2/AqJ/92Q1IaAmMf8OaVyMH8iBB5iGu2jML9q
	cuCvu7l1cLfI5AJRoHxiOjLu/ArXNrUmLJYxO2/eGdCpU/bVScnt9uvOB1++jiT4EB+eyCjaut3
	7tB8gAqaBSm+LUGvCJNWOpfOCrFwpuC/CPTe3BaxoWJoAmyGxQSchc8Sr12kRfkzSyVkvnyTGdV
	3uWvXWekpZ8Unz100F/foiPn36xdYBj9khibJbrFU5A1/hvAKTfsb4d+KlrAplHmRUs8FwDBwkM
	16gy1TTpVL27T+uFnjdCN9WAcrVGK0d7aWynUE5fBUTUacuCLvdvM
X-Received: by 2002:a05:6214:765:b0:70d:dd5b:34bc with SMTP id 6a1803df08f44-70ddd5b378bmr79863816d6.37.1756378787437;
        Thu, 28 Aug 2025 03:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFIterP9dImItBjYAqD1Xx4x9yddy09PGUubw4yf9+Su69Wqk2KWb9HrBNMXk2uDDsgEepg==
X-Received: by 2002:a05:6214:765:b0:70d:dd5b:34bc with SMTP id 6a1803df08f44-70ddd5b378bmr79863606d6.37.1756378786978;
        Thu, 28 Aug 2025 03:59:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5aa917sm30826041fa.41.2025.08.28.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:59:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
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
Subject: Re: [PATCH v9 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Message-ID: <vp4shoc6nok6byyrkq34772ag5axnfcugbr6jbdxglazvneurx@u7j36gjp5vna>
References: <20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com>
 <20250825-qcs8300_mdss-v9-2-ebda1de80ca0@oss.qualcomm.com>
 <20250828-kind-crocodile-of-progress-6cbbb0@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-kind-crocodile-of-progress-6cbbb0@kuoka>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX6DAByBq0Th1H
 1CchzgwTeFVCBQUMd3mtjlCGLEap5WZB6DIxZh1T+B1SIvBJMhufxfQWbJqa/3xw89WLAHyAP+j
 vxN2GEv4qIQI/2KytZYBU6vaG/F+DsxM03Wz+Kzf77G2qJw7iwnQB2er1uKK2Iy9qms+WtLw7p6
 nSeBLw4A/iN7eY2gQ5CI4bOPQ5ex1qxqo+nqQb8hbI/LmEBwhizS00CZD132Ho/wrVv+x8d/BcO
 90POh8s0lTU7P5zahMqSUu93OO9H1xFhDZ2KMcqoXsh7SNrSl94WSYoqUjMgb0eixqwwDNZeBqu
 97glsYOfrs5DfHP95M9pb5uVro9WiQOJ0kaXGGOcgf0ZtaMw0fpF7vBWBiIEdVFyYwaDb7LSUxM
 oYWfUBz5
X-Proofpoint-GUID: U0MiboKjjZHjLO8-aE7YzK2ECr2CKLeT
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b036a4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Rb9tGRSG334u1UeLp2EA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: U0MiboKjjZHjLO8-aE7YzK2ECr2CKLeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Thu, Aug 28, 2025 at 09:36:24AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 25, 2025 at 11:34:21AM +0800, Yongxing Mou wrote:
> > Add compatible string for the DisplayPort controller found on the
> > Qualcomm QCS8300 SoC.
> > 
> > The Qualcomm QCS8300 platform comes with one DisplayPort controller
> > that supports 4 MST streams.
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > ---
> >  .../bindings/display/msm/dp-controller.yaml        | 26 +++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..4da22a211442b7abe2dc18e769d8fd14d224eb40 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > @@ -18,6 +18,7 @@ properties:
> >    compatible:
> >      oneOf:
> >        - enum:
> > +          - qcom,qcs8300-dp
> >            - qcom,sa8775p-dp
> >            - qcom,sc7180-dp
> >            - qcom,sc7280-dp
> > @@ -179,6 +180,7 @@ allOf:
> >            compatible:
> >              contains:
> >                enum:
> > +                - qcom,qcs8300-dp
> >                  - qcom,sa8775p-dp
> >                  - qcom,x1e80100-dp
> >        then:
> > @@ -241,11 +243,25 @@ allOf:
> >                minItems: 5
> >                maxItems: 6
> >          else:
> > -          # Default to 2 streams MST
> > -          properties:
> > -            clocks:
> > -              minItems: 6
> > -              maxItems: 6
> > +          if:
> 
> Please do not nest if:then:if:then. It gets unreadable very fast.
> 
> I don't even understand why you need this. The code does not exist in
> the next, either. That does not help.

I picked up the MST bindings patchset, so the code should be in linux-next
soon. It already contains nested if-then-else which defines the number
of MST streams available on the platform (R-B'ed by RobH). If you think
that we should remove the nested if's I'd repost the bindings series
first.

-- 
With best wishes
Dmitry

