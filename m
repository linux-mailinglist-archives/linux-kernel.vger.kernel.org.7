Return-Path: <linux-kernel+bounces-868132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC580C04704
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972E819A7F26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1227470;
	Fri, 24 Oct 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6Z4oR+8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939DD1A9F9B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285667; cv=none; b=ocQsR2cHWwAdyIKqoy+vdNr1sIIePhIbcy3PmRTnDOCb95VPmXhDPJ//cpTMohs0WD5l7VKj5zgqK5r2H+xwvkFHhQddJYzbkZPWljE8ahSgFX9zd8w66ZxgNXJUGcBLDgnz5hfY8ixWT1R5Rh0DbqZjOjOiidqV45Y8/mQROOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285667; c=relaxed/simple;
	bh=tnnwewdZGrc/st9wVnuVrn7shye+Ir3tuaKMS7qos+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEUHDdv+2+gG8MAQlDL8zVUDl0+jhBv+f36ReknM1aTyv8Y3QCPbaTFPZl+vB9Fi6QpkUKKygYYiYK0/S3JcYagS6Molnd6YSc1tQacYrTQpMcn3geR1OJ7bBsM82F+Ysr7gItlc5nwe0yY7G/CmD4JUG003d9rQjxGNWsgt6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m6Z4oR+8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FKFQ006164
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JljS+79BkkayuCyE/UdcZ4I9
	cPPqvjjS+0ZvczbI6Tc=; b=m6Z4oR+8QNq+CUaHPQE2B6M926yCzAT5l3NMhh70
	I6QLqJBv0LJUmpq5DPaWWOAp+TPo1W7yId5+/aINIMEw+fsRA/7JomF0Oq8r0q0N
	AbmUghygkhsrndWQsXX0YgD7BcmhS0oUqQEH9MfDJJQWDOkByngWC3HKPOyawZI5
	laIKe4Tdrlzx7SBfVDPDRcCipDN0Wl+3UPlx1hccFiHTElD2oaFovo+HrnLkJZS6
	vrWGyvAxnNtXo7PyM7w9UELHxo72D3NnI/IhVBvHUrT9SiArdRC9QCwTSqpCq1s5
	8fQ90Z8B2T/OWnI5STfi3lwFNU7FJ4xOtyDqxlBvRUVm1g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344b03j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:01:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-871614ad3efso404310985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761285662; x=1761890462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JljS+79BkkayuCyE/UdcZ4I9cPPqvjjS+0ZvczbI6Tc=;
        b=HbhF9mCidcdm/7TCfkmRwdhw5iuA6HKJDeRBUT0O+yCfReKFteRCer4uFl9s1MgN9s
         z+eUEMIctb2hDeedQPiSDm8AwJJYFfDtF0gY847Y9CoV6u0bu91yzw0XqO90FWb73cGc
         m0QAHct+tudYSp7xAr30Arrbwp+cID94oMXNZmBooPqTbI06wpdkJBNAD+R0jzH0e9mV
         OuFAtqfmEJ1oKF5u4VGNDCCODwxPUp1l5CuoXVDy1V6NSaGkL4klzdyr6hn7u+byWv4X
         vZ6FMY7/xeVgNNQBC8AgVMtpPoQ3q/z0NT+jJFupn4Jb0R24NT57aFT3t/mMAyUiXUic
         HECg==
X-Forwarded-Encrypted: i=1; AJvYcCVRHKpsNO3Ns5/WQR9S2yjAYKdHCBKURgPNOAAV7hlZ6h66glwgrkc9YPqzD3ZaT4Sx1bNg68tb4yxtVK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTFti9SMpnMVURXkgMEGcg/g43u64UkAQMuzxQkzoHgEL9UjB
	7oVY/IccrvlBZhfFmSoJ801ts5c3d6qiow02ZTM2pVyS/7l9fS1VMWfGerIpoKG+BeAeduz/5BN
	yAoJ6AEM9JOMHaSWBDIIFo+gwVz7iWmSVfAV2zLtidv/zV8dSq17NDVGGHuFDRz1mEz8=
X-Gm-Gg: ASbGncuNt0Y2Ph7kgFZXQkLM2PTq1deNe4GbqH3ZJAESMLSGNKUEm91Pbl43SkrglDs
	IFfuVzxsU0vxs08y7Y4x4tByyy/XUGWtsVwL8OFqP/WgZQlreKcvCV5JbzXBEMTD3X8zSP39aEH
	6GbMa6vvCV/guzkYKpS0y+MPIBVQgxtSykYj1AaIzRj/mEfbIGQ1YbG497DXZokk+oDXOVxELp/
	WFLVJXzqjGZXzh2eYDg/PnKqCTwf0cBxWqMb5F0u0IPJe5PBr40rsZiUIvrKNuN7Fw2kMEmu3yT
	LTYclVEWpbmX/LEfNYmYv9d4ESR6AFnFMMFVB/3kmhXOWvBtGC7BbvhBxE1kImZOL4hatk3qfxO
	PZ4bdVkSg8+asX7ulO6l/l6jt7v/v1RosmyAGSqI6ESfjwqfpiU0QTFiBRJiJ
X-Received: by 2002:a05:620a:45a3:b0:891:f880:dec6 with SMTP id af79cd13be357-89c0fece440mr693961685a.33.1761285662219;
        Thu, 23 Oct 2025 23:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHduJaSPRzsh9CpSDx/crrVPNRb7TaSEXxg5lKfzwZ0BKGlQdnu0kRcGVeK/eZaccdwzHwgHQ==
X-Received: by 2002:a05:620a:45a3:b0:891:f880:dec6 with SMTP id af79cd13be357-89c0fece440mr693957485a.33.1761285661726;
        Thu, 23 Oct 2025 23:01:01 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11698b74sm319154485a.30.2025.10.23.23.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:01:01 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:00:50 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
Message-ID: <aPsWEhM7i+gDjXE0@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
 <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
X-Proofpoint-GUID: S4bT2q89HMFk8rX9u97JCfFyxvavQB7j
X-Proofpoint-ORIG-GUID: S4bT2q89HMFk8rX9u97JCfFyxvavQB7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX41xTXQ4tD63m
 WXYZO0id2+9UzpEWBQx2v/X8V8v5TtzjThahMkoEc1EvzK+Ah1xPkNaig6AsLvDPYqH+P4jb/gM
 hEXUO2okbtKA5sLbyGJIjm43SiHg/y3uJitniIne5LSozAQHv01JqhktaFt90lEW3HwPMTV0M0d
 p9JNiLu3GrLaZDBHAtr3HIrF+xBLy8w49GTeRU6Zf77PEUQtaTDbvbXBUdJkMDKV7JCJlqUppXY
 1qBTfRSpsf951eo4qagP3hDIsNdFasRyUcIRv1HpFebaB9SXtXkdHJamk8yQeTA2Cf+E7ehPXHQ
 Xlaqr+ivDFAQpgyH3GJU/Y+AqFjUrJo3fr15547Zv0MurV7rnPN4OBBpuLGoPEEcqXf+SQHFxK5
 WNmcE21WEhyy2iiu2coZYjmL0a5wBQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fb161f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=-aLJWpWAS0NDeqwcDiMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On Thu, Oct 23, 2025 at 03:14:38PM +0300, Dmitry Baryshkov wrote:
> On Thu, Oct 23, 2025 at 04:06:04PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> > VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > index d6a37d7e0cc6..7eda16e0c1f9 100644
> > --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > @@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	ret = regulator_set_voltage(ctx->supplies[0].consumer,
> > +				    1650000, 1950000);
> 
> This should be done in the DT. Limit the voltage per the user.
Two reason:
1.
I see https://patchwork.freedesktop.org/patch/354612/

panel panel-novatek-nt35510.c also use regulator_set_voltage set right voltage,
so I do the same work.

2.     Kaanapali vddio regulator:

		vreg_l12b_1p8: ldo12 {
			regulator-name = "vreg_l12b_1p8";
			regulator-min-microvolt = <1200000>;
			regulator-max-microvolt = <1800000>;

	Voltage is from 1.2~.1.8 V , So I can not set it 1.65~1.95 V from DT(1.95V is beyond the allowed range).
	So I use regulator_set_voltage to set voltage, and regulator_set_voltage will choose the appropriate voltage.


Thanks,
Yuanjie

> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >  	if (IS_ERR(ctx->reset_gpio))
> >  		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

