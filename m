Return-Path: <linux-kernel+bounces-781689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143AB31580
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EBF1895F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A12F530A;
	Fri, 22 Aug 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gt/OZnn/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B642E6121
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858865; cv=none; b=YMNogwztfr06k4LoQJpopq2OoRpQV6xzlCk5kxYCRHVODqq6PmXANKO7p0ocRBdicaZJc85iNw5bDlBhseWk5gnck1qAbBftdfvxkva//Ihn0slN8wFoNi28NgXpZlYSVbf1Qb4u9kw8QTXx17jfBQEpUnQtToK+jRU7Z0E2qM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858865; c=relaxed/simple;
	bh=AkSmYbPS0TQneMUEfmypvRL+CMZ8nBmCU0oEbBSh2HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1HBrcN6C8j/6vwWB0jm9U3GM5/JFNcmXI9hAhF98V8XD2L+mUkqmMxCjDEe7mDKPY+666X2Qk28IzK8olPR18TA5SFOyowbPfqPCR+Fs7dRLvI5tUEQjQaOp1e9YtSzLMR8suqYutovKraoH9OP+m7QwKNoKt9cb4snnJyWApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gt/OZnn/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8US5U003766
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FCN29/vu9A8ZXeY7sbANGhL8
	9+mqcLMKMMaamyrrvVE=; b=gt/OZnn/0rBmO1nh/YzOEqEAqD+OdbivSHQjcNbg
	fXxRGhJ6kz421MT4w3aJZOSc4sU1S9Ij4AA52jYAXkHJlp0p+Mbm6XIqBIfESINZ
	wztcp9eUlKvRb4wBoAl5wR/KLFXf1y8j1JzT0zym3dNIZVI7SMAwsH9ISwai6Lwg
	0IetRzTPGmq9TgoslbFMYQ5rWmkwZ24MyyYVHyuUQf+YojVeu5ZOSuOVyjOm9SRb
	lD6MUqM0T8BE+MR2kjIRtOdTs2VnaBeyZwG8hPcHo/tT/kERftofHKa2oWJiKVi1
	uYyQ9FUElk3KZZCHXPLuIkgNn4m+J9s4X1FbQEERhnzwlw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298u96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:34:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b29cdc7417so45511021cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858862; x=1756463662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCN29/vu9A8ZXeY7sbANGhL89+mqcLMKMMaamyrrvVE=;
        b=cDtsCUO+OUCA6fxA/mDPilC72Q3TlyKEi66mmDsAkamsfgZSfpvXcR29GZfDiFrkeZ
         0F/U/UdfKB6X6HpJDxtzbNUu7K5dfXHtsLw0lb5/TFpkTly/ChW+NODEKRUKUNlSqqnU
         qxu8eGd6WMd2RnyC9P1giVMmBlpbgRNT/Hs7PzWrbY0tsME8XqhZqwhPjAv2lOxn7tch
         ooDc73MPRITdy5TtWoPyM22f/ptKVd8HWvMam2Ac8QzjdSyQYrshyJtfcBebcH8y8Msv
         zartIhFD+tJ9talB+sfhYBcFWnjnhOGzFBJ+Q3iBD4JAprgzxpUMKI8eeI6BGCFkewrm
         r62w==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZuWoqQysHUfk8nibUDL+LBpa351fPbPDBtfKn0prl/JCLzFBn7HvbBCCmMFZMF6qQv8t3ehGnZwxgcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/tiWygrsKSGc+FIrKdaKG6+XlRE9MMnKnwfbj31/zmzPR67h
	q9SgMHaUFtPUqvt+7ow0WB2VXcmvFq1au949oOCAIxEykvLTml49BaP5P8nT5D956c9WtOMVT2P
	80HCpSf6XUdR1Sh27Kp3bxacfuNOpAn9BMmqAI0Nu+WjrRTDDPVf7FPZYmy4h5HaRQ9o=
X-Gm-Gg: ASbGncsm64aeDA+Je5+atfw2PcUXIO1SHU3gYslH6Z0+ZW9fcUQXwVrkkR0NnPgB4JL
	m7emRMqoW/Bly2erre+Ksxt3tWM/WCU7Fxv1/GqbFiJTQljvTqBec88ear6IqHmynnJl3I504fb
	X4yLn6zFnbGlCTFtyZqkrPPqJ5Zqpm3AvXJ65eZMk3VafAU9TJvGpTIL8+QKwc89qWF1WEwzRf1
	4LrggSl0eEKo9b+s1BWlyZjqTQmw/K2Xiv9JiFi8Tdutq6U+UNYi0sA5CGJgCs4MavmEBJ5SteM
	QedWKX5erqaYvOpBdriVjWV1c8l/Lpxnu9FJHEa4IWQoB0GameEOaZy8OhtwwdTgrcWKCMA8pdP
	xMziaOdmacQVP8Db/ydlcFETdsL4EkQ0Y9l5dqfNV9tbdJAE5eKWW
X-Received: by 2002:ac8:5701:0:b0:4b0:8ab3:2c7f with SMTP id d75a77b69052e-4b2aaa05e76mr25339361cf.11.1755858862187;
        Fri, 22 Aug 2025 03:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPnOrDbKicPm/yuh68OGc5jaYkOPRZ2c1JmpVxuzfF/z2tQgKp4Rzhw5PzXzW4Jrhl8KQDlQ==
X-Received: by 2002:ac8:5701:0:b0:4b0:8ab3:2c7f with SMTP id d75a77b69052e-4b2aaa05e76mr25339071cf.11.1755858861488;
        Fri, 22 Aug 2025 03:34:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef43448csm3436848e87.147.2025.08.22.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:34:20 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:34:18 +0300
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
Subject: Re: [PATCH v8 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Message-ID: <ftazymlvq7rtbesx4keuek4avmmjq5cx4clewwpmem6ta7qmti@bn24prgszc2j>
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
 <20250821-qcs8300_mdss-v8-2-e9be853938f9@oss.qualcomm.com>
 <3ws6xfmmrnjybn4umbbnzjdksqberzuxslz6uxpabtsz2yzyss@jwblshilyx4p>
 <b86a1759-e49f-48b1-833d-fdc37b450f5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86a1759-e49f-48b1-833d-fdc37b450f5e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a847af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mnVnZ1ScStkaolgTZ_IA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: B2OaQqGmYu_uvIsEI8NgX5tGEadsHaVL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5EHmTbiTkrOd
 pqh63nOwJTRMgIW4vIPQbA7NqK+0YQN6qQ56Fm3YtrrNdflbpW+StAEqQQ3gh4J+SMtAVU90YVp
 4ZVx8hqnOkdUi3CBVsj1XefLGfXpdG7ewjS3D9B37IG2slbLu7V2UwrvdxRfguDLemP0xhO75VE
 V8JFMqOGSLe3i/PcnUjwU5SWYCslQV1quhKRexD+/gFfNG+8UhuEulJBw6QYfM22Jakok7p62oh
 U+FKh2Y6RkA4PYcGcUmW4AU8m9DgTfc1tYnkTvS1e7vY2MMRwhMGUOjoYi6gc+PpfuzSQtRh0dL
 fEAlhP4sOpmrsyMHmYPeBcIDwkZT3SpPWfw9Ymwd6J9/U46FGjv8GcZs/PLN2ddgV1kFlNFQO3A
 yjp9En5GCFd7byxj6LEHI53eBEsHxQ==
X-Proofpoint-GUID: B2OaQqGmYu_uvIsEI8NgX5tGEadsHaVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:06:58AM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/8/21 18:28, Dmitry Baryshkov wrote:
> > On Thu, Aug 21, 2025 at 11:35:57AM +0800, Yongxing Mou wrote:
> > > Add compatible string for the DisplayPort controller found on the
> > > Qualcomm QCS8300 SoC.
> > > 
> > > The Qualcomm QCS8300 platform comes with one DisplayPort controller
> > > with same base offset as SM8650. It requires new compatible string
> > > because QCS8300 controller supports 4 MST streams. And 4 MST streams
> > > support will be enabled as part of MST feature support. Currently, using
> > > SM8650 data structure to enable SST on QCS8300 in the driver.
> > 
> > Bindings describe the hardware. There is no point in discussing the
> > driver here.
> > 
> Thanks for point it.. "The Qualcomm QCS8300 platform comes with one
> DisplayPort controller that supports 4 MST streams", do you think this
> description will more appropriate?, only discusses the DP controller, not
> referencing the driver or SM8650..

Yes

> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..ac44abfdd2853393ae199387c9ae2c37e1c48f52 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >     compatible:
> > >       oneOf:
> > >         - enum:
> > > +          - qcom,qcs8300-dp
> > >             - qcom,sa8775p-dp
> > >             - qcom,sc7180-dp
> > >             - qcom,sc7280-dp
> > > @@ -179,6 +180,7 @@ allOf:
> > >             compatible:
> > >               contains:
> > >                 enum:
> > > +                - qcom,qcs8300-dp
> > >                   - qcom,sa8775p-dp
> > >                   - qcom,x1e80100-dp
> > >         then:
> > > @@ -217,8 +219,9 @@ allOf:
> > >             compatible:
> > >               contains:
> > >                 enum:
> > > -                # some of SA8775P DP controllers support 4 streams MST,
> > > +                # SA8775P DP0 and QCS8300 DP controllers support 4 streams MST,
> > >                   # others just 2 streams MST
> > 
> > QCS8300 has only one DP. As such, it doesn't belong to this clause.
> > 
> Emm,thanks, i got this point. So here need add another clause only work for
> QCS8300(one DP controller with 4 streams), and i put codes before
> "# Default to 2 streams MST", is this the correct place?
> 
> -          # Default to 2 streams MST
> -          properties:
> -            clocks:
> -              minItems: 6
> -              maxItems: 6
> +          if:
> +            properties:
> +              compatible:
> +                contains:
> +                  enum:
> +                    # QCS8300 only have one DP controllers support 4

typo, controller.

> streams
> +                    # MST, no second DP controller.
> +                    -qcom,qcs8300-dp

Missing whitespace, drop the "second DP controller" phrase.

> +          then:
> +            properties:
> +              clocks:
> +                minItems: 8
> +                maxItems: 8
> +          else:
> +            # Default to 2 streams MST
> +            properties:
> +              clocks:
> +                minItems: 6
> +                maxItems: 6
> > > +                - qcom,qcs8300-dp
> > >                   - qcom,sa8775p-dp
> > >         then:
> > >           properties:
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

