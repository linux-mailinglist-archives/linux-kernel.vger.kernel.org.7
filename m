Return-Path: <linux-kernel+bounces-795503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B4FB3F343
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E01A81ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4602E03E6;
	Tue,  2 Sep 2025 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gP/jN5XW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDD284B4F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785898; cv=none; b=tduy+h+NOabDfDw9QKAh6kll3GW/20mVRqp7tHyDgDfk/ZdEyDAuivsMuIwsTKQe3mjgTC1MxZvF1ZI/s2e/yTqv1NZjn+iaB3S9vwAq50VzFRyoFCG+ivirU6+8V6mFHCDwm6RZf2z4CD2Pw9sEWq1QihcwVF7ubaJA6I+jfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785898; c=relaxed/simple;
	bh=v/2+YAxpFamUsg/nWMPyIxlBsarZEf/G8aP+4cqfoxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+IFC2U5NIMMBbjLESBiSNYSOOX2uVYSgcTN/28mJFuJggnwfZtvfuq1VqHyAyeZao5IKYhIRrxX4S2De2DNqbU0zIUogGkkWFM3xLKhCwr1kGY1cWP0tYxynW11e1nzhumPIDZqor5VuIe+fpo6+Zjv7iwuGt+Qy/XXweIh410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gP/jN5XW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SEjg022405
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 04:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FUbG3HJcyuVo1E28CzJ/QWui
	hMmGUR1E5R08lzHdUPg=; b=gP/jN5XWvMLs2zd9d6V46MgZe3bIzErGTzU4YfNg
	vJHsTcL+yGJEajqipi0uVENLvNkmWpRFlhrXozMkKaJNpHqvV4/mF/OwqAE7pLoB
	af6ZXmmhVzQpNYhBEsy29uATObgagA0RRcsXbcyvE50tZu/bv/cGkAN4Zj36yxNT
	wAXVyg+UKOaO5FovU0mdIl7PrV17/3XrAAZdSvAdfZXG2EmHsc5OG2+iyOG+9Fvg
	PvR2WXTn0sJ56aDlJlygvovjSOrIlT+bmchpGyH0X+K64sGCEvcAUHcKF1rpU7z5
	XfYtRwnUbL1KW7HI13iAeoiAmubF7RcADqggYkHyr8yGxg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6jy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:04:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-72108a28f05so5559156d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785895; x=1757390695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUbG3HJcyuVo1E28CzJ/QWuihMmGUR1E5R08lzHdUPg=;
        b=TSSkjQYQK0YEPpzCJmAWyuPvtoE9z+kOG1BABSBqKU+tydm2Ecwr9gNda4HcJPgjjZ
         nChRqxejqPUCCOIrzaYnoYHct5GsCw378iAM2CKo235OcrwucaTZoWhGqU1NptuvjNfy
         VYrqtXbWw6PSNxMrNl3NzCU1JFFO8O9a2lxzWlfohJ5j8MwUfKDfLbm6YzKo08zt0zYW
         7hc4Exu4NvJMnbDC8QFcUkWf1CNt+YvBJpDdf71xNxHVBMmdVSJftT6hdvLOmRdjIqXx
         8yUUlNePgrYVVy+axqhHCUCYx0JfLRZrXhwaKZpdy8qAOsQAT4ICg/1gmihyFuvqGzUt
         jvEw==
X-Forwarded-Encrypted: i=1; AJvYcCUkj9v83+hWmG/nnXwGQHB3EBsrKMO3bdMNjrem6rfgo0wJE2NcIkOb276xh4hfxzB73KnpBJt6RtEe05s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fD3HgAONwzsWpkqRZ1hqqXoHIkeRB2JZVMkozFp8NE8Dr0lR
	8pIWrZ/qdHV71pGO8xb52/ZzhDzgsv2YyxYO590ek055c0slxH7+oX6ThOKwfoFrHGqeeC+2W78
	GGDxXasG+vBPpedCM8XQJQ9xa64XCemO4GEbF8CD1Fn0/jHcs4rqve23X6bwJ/kjrQrk=
X-Gm-Gg: ASbGnctVCUzYfcIMVYSlWQ0jt2QIj7EvOKoZcjqqE5oYW+kCPlBCAEWiy/Z0uDWUWyl
	yrZ28BobV4fk/mw52HQ1S9F4pfj0HZODnaujjLCazkA0IWF1QPSaDTMkjmmsYaB0b3PQ5ND3Wdq
	P8oysdPaWjTx5FmmEf1ZzLfoQiFVESHp8rdu+DgMckq1ETOp6M5sfLEuoJss+Iga/B8AZctwfu7
	cEwAxtmhw2zaARzF0CyZnPqx7VmXEh7KFaiyavJh65pq6TduGsmmhDvioS5q2ealtcyKJb7ydCf
	LqhaWUi1C0lpefEPloOLeHOqIJJx7zehDwwJ359MYVelo8CU+R82Er6Wgp9NVUriu6alpLTSg6p
	QPHnDkyMBupc7UKGL7HI+Rkbe20Jok799pgASiRTJhNxKLBtXlNWF
X-Received: by 2002:ad4:5c63:0:b0:716:856c:4a5 with SMTP id 6a1803df08f44-716856c0613mr77344156d6.43.1756785894810;
        Mon, 01 Sep 2025 21:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHprcraanQwhdW2zFPLdUXnmfkEq2gAsf7egUurUvHlfjuXEEHMuXLdIs7YBM69Sknlftw1mg==
X-Received: by 2002:ad4:5c63:0:b0:716:856c:4a5 with SMTP id 6a1803df08f44-716856c0613mr77343796d6.43.1756785894311;
        Mon, 01 Sep 2025 21:04:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032caasm1932141fa.35.2025.09.01.21.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:04:52 -0700 (PDT)
Date: Tue, 2 Sep 2025 07:04:49 +0300
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
Subject: Re: [PATCH v7 8/9] arm64: dts: qcom: sm6350: correct DP
 compatibility strings
Message-ID: <abkkn4f7uca6tzjasltyysxecuuirxxvbjz6l6re5v4z6jlmuh@ugz6jtw6vo4n>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
 <20250829-dp_mst_bindings-v7-8-2b268a43917b@oss.qualcomm.com>
 <20250901-defiant-illegal-marmot-7ce0db@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-defiant-illegal-marmot-7ce0db@kuoka>
X-Proofpoint-GUID: mVq_hbrL8t1ItoKAETUweECWoTJXf5FC
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66ce7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lkS1JMb0PDcYJWSia6EA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: mVq_hbrL8t1ItoKAETUweECWoTJXf5FC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX+7Nw8siqUaqQ
 BOYvOQxROo8cQe0PHZbnp7eaAYY9MGeFVR27is3Z2AowSz2hGSbNNetr85qPjzJUEFkiVRwvVPS
 4mq9hYcqX5KPUQkNhFN8sIkuKqdmT5fEidEOovQCH0jzvcDQyu/vZFiJx20Yhiy6HQAtGRfsudJ
 /5em26ETbtYsfE8kyn4lNB7TkG70p1PxtcAhYDIhm9ss9mA71hjb2ZwxQOZOVXWgiKKi5PaqoNx
 iEpfcd1vXUXsfZs6mFWVPb3OZPSq/K6upi5fGnQi8XxpC7R5+vzFbFPI7HG5MrFawOsf6xvcVff
 MA7+6c0jd5jeJw/kwUJ1kkT1DbYQPRfvflDLgYfIyk1/aZX7alguwg6lsyBCoGz1pjQrb3biqK2
 9S+pLkh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Mon, Sep 01, 2025 at 05:47:04AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 29, 2025 at 01:48:21AM +0300, Dmitry Baryshkov wrote:
> > SM6350 doesn't have MST support, as such in DT schema it has been
> > switched to use SC7180 as a fallback compatible. Make DT file implement
> 
> That's insufficient. You basically claim to do it only because bindings
> change. Bindings were changed only because devices differ, so that's
> your true explanation here as well.
> 
> > this change.
> > 
> > Fixes: 62f87a3cac4e ("arm64: dts: qcom: sm6350: Add DisplayPort controller")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > index 2493b9611dcb675f4c33794ecc0ee9e8823e24d4..8459b27cacc72a4827a2e289e669163ad6250059 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > @@ -2249,7 +2249,7 @@ opp-560000000 {
> >  			};
> >  
> >  			mdss_dp: displayport-controller@ae90000 {
> > -				compatible = "qcom,sm6350-dp", "qcom,sm8350-dp";
> > +				compatible = "qcom,sm6350-dp", "qcom,sc7180-dp";
> 
> No, that's breaking all the users.

WHy though? Both old and new lines are using fallbacks to bind the
driver to the device.

-- 
With best wishes
Dmitry

