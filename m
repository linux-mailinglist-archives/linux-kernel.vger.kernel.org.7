Return-Path: <linux-kernel+bounces-813943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E0B54D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C528F1885509
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A3305977;
	Fri, 12 Sep 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N4qudoHJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C4309DC1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678970; cv=none; b=iMepfUR8v5O89AVKM8M+zPqSiXU4mFqyVtWMe0ZygV3QNuStUKDP8zAamU7TrKdwYksQ+xEJWIN7ugWMevYJh6COGt2DB93hNHpc3EdjW6lC24N0H4dZZTCtDqpAWO0gLo45Mpj447r7J5CIghSdG+BkYIpWl3KePfOplkzi1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678970; c=relaxed/simple;
	bh=fts+Hs5q4CqZXfPujRbJyGAxy42t96v29pQ9JjRsBII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnPuritUGxWtK6oeRV/QikuDzFXELDynftfHHabfb0cGWy2nb434+KQAII+HmRVZum3FYEo9lgEMxQFq0zc0nQ60A/TxI5IB1ohCU4bqrbRKlunahNuY5ldkzch3h9kDcrE67ya8Do0WKKk5Mgr9xLKuUHLkNMINOAUv66P7v/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N4qudoHJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fKmM014053
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AWecxXQ1HoSKQokJLzYb6tbb
	rzkT4uWaDcoy5VKKVeg=; b=N4qudoHJb3LgJAVQziaNCtZl0F7NfM5kABN0udgc
	AwnPkhRGctPPhNtrEqLj1TzlUOG7nqOcWGSmqBVNjTg6DCl2lMUA2s0tfzfC0MZc
	Fxi2T88hQ9TmuN2Ii1EiknR4CbDaDKab5CbHdp4w/UTqpA+DLbERlyEL6wN4Q68/
	9mBcuHp2OYC0JTRzDzirqGh0PLA2h1x8mt2KCFlWij0Wi3AQPDBYO0lKID6iXfw+
	BCDg27FiO+Fc+Uej1F+ZvbLM7+d8T92gEbNwOmwMQZ7uN2y8hE1PqR4BgFYIG/jP
	qf9YitCAwwqbtQ4uQqbX3SL1vs7PQMsE2V1rqc6ePsawUg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphw9n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:09:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f112dafeso49047991cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678965; x=1758283765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWecxXQ1HoSKQokJLzYb6tbbrzkT4uWaDcoy5VKKVeg=;
        b=Eu5+0UTBs50R/oeSRI92GLz4yHjEodHfiSBnX9g1iKet8zt6XV96RnDCfP+Tui1fwf
         lEjWh6I9iBCWBN3da3O8QKpSG6R+lZ6Ba9lFbr0tYZyielCkbbR8My+QZqLliLUCb1Le
         9DFUwBXCKMXPvtj4f2DK05EsiZ/BKwSfNLB9cine6dZw1ePi2oEuSnfc4snvJXyGnj/E
         ZCqQwVRKBLMbvcECmGJwK6mMGReWlVowxSSrszqiYCSxsSOFIi+JfUvqCNvKOZHn0EW7
         frGEqt3JVoUstH2RSsn6fNycBjm4aOJPb5WBQKnDL8wEnCwOna6O8N2qUmIquwqK2GyS
         frlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGD5z9XkO9A98s0ilB2rlek4BJuNPzGYpp6pNWG2ivxNGLCzH8FkNYD8Kih6QUm2j8+Gua/JQcikZw5D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcDPWIaSKMDRGcZA1xqdI5jTIXyDnEmhx0trlmo2LlW1LKzIA
	mCR1RI6ulU2DpHQVA3bF3zGDRsh6RrgXOYKW+sPSRYZ9PoCyg10LzHGTvnlND+81J4//MFWyLGW
	KDGmidKMuzjjk1hknqeomDim7pUfnN8fhFkHEdYcFt8UjFtcsterueEjJZ/gJr7P+Kx8=
X-Gm-Gg: ASbGncvUz/HMOExynO7uzMZnbvwvKQ/ktnu4rl7myWq0oVYO9MEYZy5mViYFokvV3CV
	kVWjU6IQtcJ8EJCaEDArKt4KFhsg2NBgQdbDCX4LcPuvlojt2fI3Me+j/0qmoeQ7aNMlwdGn9/K
	TU3ZYKuzfTf1smN12+ZHnPQaNUdSc8GdeNOXQSYNKNrzArxQzgmCxzqck62SgR0pon7d8BBqbeP
	73443cX/UVAVxRj+6zjQ1htfnaKEj3QUE4FoSgyOKjUN4aPSTXB3RJ18/CKHvMUGx4oUZaP0bcw
	Hl0UC/iVP8w2bOF2Gl3u9+fQvcu5nmV7vgluPoTBNpI9PefHnHetUmMhp388lPoPGY9vk82ar96
	TFYG5qdIssS/+C2sHOQU/hWg/SmJv19CYHlidr3DDuPExauQz403f
X-Received: by 2002:a05:622a:2b45:b0:4b3:12f7:8baa with SMTP id d75a77b69052e-4b77d044455mr32335911cf.51.1757678965239;
        Fri, 12 Sep 2025 05:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBlHDLz23zA5O+/vEKCN91ortJnwiUYeDorqJurL/VJ4hd/jMETJMt2eSQJiBv4Cvs1e54jQ==
X-Received: by 2002:a05:622a:2b45:b0:4b3:12f7:8baa with SMTP id d75a77b69052e-4b77d044455mr32330571cf.51.1757678959880;
        Fri, 12 Sep 2025 05:09:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-35062c8da78sm5874761fa.0.2025.09.12.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:09:19 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:09:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 11/13] phy: qcom: qmp-usbc: Add USB/DP mutex handling
Message-ID: <q4dplt6fq3cneludcuhxevklaj6omeio3cjxw2owt4h3wistd6@arv23ri4cl75>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-11-2702bdda14ed@oss.qualcomm.com>
 <nfugwwknnlxls75yo5rex6ggu5nzpq6enyx6e6nfnfei3icxjg@t7dnzcfcjw4o>
 <cf6c2c2f-9878-4181-a3c8-9692423308bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6c2c2f-9878-4181-a3c8-9692423308bd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c40d76 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=h6lld2rfrDIzuLPEmGQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: wJr9rMVtNvJqpNKn8cbjhQ79R_0zaSeY
X-Proofpoint-ORIG-GUID: wJr9rMVtNvJqpNKn8cbjhQ79R_0zaSeY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX5zSKXRrji9Kr
 Q79Ct5MylzqusA6UIV9Nsiq9SWx/wF+wkcqzmWGqugWtJlFCtt07SB9NDWVy8IFn0FRZBl9JCTY
 MbbRh0mSd5gB4Q3lrHU1SDWscnu0hBBYocSn/C1jYgJhDNoAydxnH51CNmsuNIV+kBgOGcDLdLD
 CAcLjwmxfWWY8RJbcmsVZAGfEQgpRphCPjJHG/+hiR2d9fDaODudFThcJvRrj1WsbJ5IFTp4nzj
 NhNbFr3ZZFjRu96XT7Sjy5zrqM989XhxC82hmGtewwsPaISsUvS9ubcz4CrwnPqHakocj3ZE/01
 zVQK3vTddWjkEO4rpsTQiP6lbbsGKEDWO9vvKRJ+z2Z9Je0b6Co7ciRt4HorbWzPnk3Dyh/Df9g
 4SJglrpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On Fri, Sep 12, 2025 at 08:03:01PM +0800, Xiangxu Yin wrote:
> 
> On 9/12/2025 6:32 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 11, 2025 at 10:55:08PM +0800, Xiangxu Yin wrote:
> >> Introduce mutual exclusion between USB and DP PHY modes to prevent
> >> simultaneous activation.
> > Describe the problem that you are trying to solve first.
> 
> 
> Ok.
> 
> 
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> >> index 613239d15a6a3bba47a647db4e663713f127c93e..866277036089c588cf0c63204efb91bbec5430ae 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> >> @@ -1061,6 +1061,19 @@ static int qmp_usbc_usb_power_off(struct phy *phy)
> >>  	return 0;
> >>  }
> >>  
> >> +static int qmp_check_mutex_phy(struct qmp_usbc *qmp, bool is_dp)
> > mutex has a very well defined use case - a sleeping lock. Please find
> > some ofther name.
> 
> 
> Then how about 'qmp_check_exclude_phy'?


qmp_usbc_check_phy_status()?

> 
> 
> >> +{
> >> +	if ((is_dp && qmp->usb_init_count) ||
> >> +	    (!is_dp && qmp->dp_init_count)) {
> >> +		dev_err(qmp->dev,
> >> +			"PHY is configured for %s, can not enable %s\n",
> >> +			is_dp ? "USB" : "DP", is_dp ? "DP" : "USB");
> >> +		return -EBUSY;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int qmp_usbc_usb_enable(struct phy *phy)
> >>  {
> >>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);

-- 
With best wishes
Dmitry

