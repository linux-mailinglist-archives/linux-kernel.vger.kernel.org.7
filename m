Return-Path: <linux-kernel+bounces-822020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F8B82DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46E0627684
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEF524EA90;
	Thu, 18 Sep 2025 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiINsWvj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137C2AF0A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168989; cv=none; b=Mfu3Dwro+KOIfShxbAW168bmoRC2m5ZIGlGMSLTiTsSBJ37Q5zHSml53914QETq0PlU0o8sBZbYRAVWxyRjIZ7+rP8R0d/0+Zj3/0tATVQTNrTEsweWkUVfqtm4eX95fwEvJaSNZPyI7aB+Yyhyu6WlXblxvqWPrZEUFE8TiHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168989; c=relaxed/simple;
	bh=teUWGPDqWxk1e6QP+tLmJUjqK3FLcVCTM1xLobbYDB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5sIaE5nRrwto06Tv+zXscay07E20icLxgQ3DafobGQZ52fn0rBuriNKw3qKtPDJ26Xi8remNPvQ8Euhgru9TDjCr4V6uRj7Q6aa1M0izrItvhAQPJlUw5SLYmKK3+9SHMfJ6/MUldz7rKDXjnsmlfkLA4A2WY15laqeNtYcP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiINsWvj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3Yih0018318
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yxrKp1mMNSorjFJ+jYSIIXoD
	/DQOcY1xttowefW1mLI=; b=UiINsWvjwplPQUD3By9AqxtrIJwg3QowkaKPWgjN
	q0ViT4aq+wuyOH6C0ZbnopUIC9Yegfwo3x8/zGmnEVjB19YyStyhJnkkUbzcYoWr
	PkVIvDNfXJP+CGHr+Cvqx6X0w01xuLFUoWflFxcsKI1nixuGr/iGm1i5HbKsW4gL
	UPYh697QsGks1BmMSCc605XxapY+Zw5Rsng+2eDD6lIZHpV49LyGG2smVioXW4ZW
	XuX3OtLa5IJ/JodMhoJ8DfdJ1D0mk6E+ldmv0p8jH1WQkwGwB0iEDdjaz6qVTfK0
	OZvC0fbn5NAWYlmtWHFzZ0Qbe976au09etBgOETIUuERRg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwcuc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:16:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so11526661cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758168984; x=1758773784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxrKp1mMNSorjFJ+jYSIIXoD/DQOcY1xttowefW1mLI=;
        b=DavKcpgoHVPMgmTqyNUrwoUU0zIzF/g0OpjqBa/IR41X2v8aLxvQlVS3xHUwMWtkd0
         M90jDrui5bGQGQw9V1M1jVWMGjqlO31YES/zdYxYOvxmCQFY7lHkHabI/Ay1gM0fBCYb
         QooXx5bHT7cqriDFcSbwl9BT4W2PUBggbzU1A+TIxJgxPVvQEmEFVNFGL3qDnWEIzXMi
         HttRa9hDYU4yP+gcNJC4SAR7CV5F+UJ/++0QjKZsztCpmyH7TCJcW447u3adjR9cBcDg
         8HFKeCnv2/fssIEofqnru642Kxf/CJdMlt+A6f61nf1wOA0DQxLSSMGWGZEmoifhcI7x
         ndbg==
X-Forwarded-Encrypted: i=1; AJvYcCVR2I4OY4rOcbXXM9dKo0uYyBe40/qvBuYGq0UfRGYgxPTSFRuCjZAkVeIXawovxBVY3RE3KnB+DPAx3SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvuIhoSkGr+nZSejnMMpLni2FlFT84n3bcF8hxlD/NWxy5qLR9
	cYLiuQPHRF7LhwTiwJD8fe5mgsmHiQvVLd6nrtexglqv9C8Wm3cQtY7/cQAEiO6bqdNvKm550In
	ViO7lWBkB54o0GOWq37wXYf7G15MPmeI8Xr8l5M2Fwt9yDoyFqo2EOXEAtMuCHtgfvQI=
X-Gm-Gg: ASbGncvIrH3W2tQEK9Vnxk1oykw+b+KpF/O/gznkY2vcQrfb2uOEgUCjXMJM6BF00Dg
	m94fNnO0UoX10/R01fHcRukgh2Z+Upk+h1EP5G5kY/SfsUNt/Cx+dohl+EfunOTKzUzLayI1inu
	y4KDK5pZ4RMA2dazZ+iMBA3Uwdb4vBYIV1fbIa3l6TF1TUgB8/H/AUTvyC4OXYRLKUF3TaxV/FC
	uNELR346UTuinUz2P6UsxJj4surjtcf4xT6o+cnFVIJb18wNWAmVQrwTTHNVkI9YdkFYFQjlFG/
	g6Pg6m3tmXm8WCW6TzeHLk4U4G5fXrNJf0PrIbhqZEKuRkoc0tL+v54y9my9yk7y0uQNx81e+CX
	ALEKhUV2idnLPB1hn2peXvmD/+uLjXjpR6YD4PH8ZRbHvx6bnYGgW
X-Received: by 2002:a05:622a:5908:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4ba6ae973c3mr69912361cf.58.1758168984613;
        Wed, 17 Sep 2025 21:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8E1DrYRb0Vx7N8mwDUw8Sx3L6iWLRByHuWqoKFSHq7uW/mIRDRIhwltCpukpzhFqll6bC5g==
X-Received: by 2002:a05:622a:5908:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4ba6ae973c3mr69912091cf.58.1758168984131;
        Wed, 17 Sep 2025 21:16:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a90a20a8sm352483e87.68.2025.09.17.21.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 21:16:23 -0700 (PDT)
Date: Thu, 18 Sep 2025 07:16:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 0/4] Add PM4125 audio codec driver
Message-ID: <vi6drjvj5xrqmcx5nooavnz3fsrzjs2fmwx2wrnq25waqyjrsd@hzspir2e5utt>
References: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
 <20250918-heretic-spectral-lion-86fdfb@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-heretic-spectral-lion-86fdfb@kuoka>
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cb879a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=r_T3I_alxc_9WHogHBgA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyYEZB3AuxsEo
 0Qy3Da/EF2dn4uFG17sBP37X5D/8P3Ow8X4b+9/GVODn+18Mydh/GGp8d1V/fekHRkWUzVRPAxj
 OkP67qGEyaOqf4+jcNTU2T2nafPQjvfxRvQIxVJi7DyFHeO//6kAnXB1ldou7sSTZhtVnAXsGmD
 F9q8l/tfPKBXalefGxrQn/vVFrDUx9rZg4cARzoIXV1mesMPEWPTbjygHkDJZYJIFAB/N1CVGuw
 PC1loXlQFkl5+Fc5VcasMDYbH/QjLoHR36Z50GjHfRmbrfEBoNOjLUpSwn+jOXlrStSRtqg7Exz
 vXGX1YZaVN/6fK9W/cuxqDAOSrXmjpZtL6eJM7EVdn/oGClY2X8Y5/jQgW2IbHvm1T87RW0ivfq
 arCkDrBx
X-Proofpoint-GUID: oxD3eMD4KRgBtwD8rmblJDh8DtTTR2TT
X-Proofpoint-ORIG-GUID: oxD3eMD4KRgBtwD8rmblJDh8DtTTR2TT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Thu, Sep 18, 2025 at 11:02:30AM +0900, Krzysztof Kozlowski wrote:
> On Mon, Sep 15, 2025 at 05:27:47PM +0100, Alexey Klimov wrote:
> >  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    6 +
> >  .../bindings/sound/qcom,pm4125-codec.yaml          |  134 ++
> >  .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |   79 +
> >  MAINTAINERS                                        |    2 +
> >  sound/soc/codecs/Kconfig                           |   18 +
> >  sound/soc/codecs/Makefile                          |    8 +
> >  sound/soc/codecs/pm4125-sdw.c                      |  545 ++++++
> >  sound/soc/codecs/pm4125.c                          | 1780 ++++++++++++++++++++
> >  sound/soc/codecs/pm4125.h                          |  307 ++++
> >  9 files changed, 2879 insertions(+)
> > ---
> > base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
> 
> git co 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
> fatal: unable to read tree (590b221ed4256fd6c34d3dea77aa5bd6e741bbc1)

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250912

> 
> On latest next:
> 
> b4 diff 20250915-pm4125_audio_codec_v1-v4-1-b247b64eec52@linaro.org
> Checking for older revisions
> Grabbing search results from lore.kernel.org
>   Added from v3: 4 patches
> ---
> Analyzing 50 messages in the thread
> Preparing fake-am for v3: dt-bindings: sound: add bindings for pm4125 audio codec
>   range: 6f3a32745b2c..b40852dc84c3
> Preparing fake-am for v4: dt-bindings: sound: add bindings for pm4125 audio codec
> ERROR: Could not write fake-am tree
> ---
> Could not create fake-am range for upper series v4
> 
> I tried latest master - the same. I tried also next 20250901 - same.
> 
> You need to fix somehow the base you are using.
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

