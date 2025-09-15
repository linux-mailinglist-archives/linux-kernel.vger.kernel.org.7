Return-Path: <linux-kernel+bounces-815957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041FB56D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F40189B78F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBB192D97;
	Mon, 15 Sep 2025 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I7G0htjZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8214AD0D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896472; cv=none; b=iDKzh/Qs3YJ2jOXKJ+0+K9HVhceXbksHdy8d155YV7ocx5MnK3nrdCfwET7Pi3U5FTBlSMM/fVjo721Izh4b9JE3G4fenp/LNkLXVKZVKl3otKUqaEwtwvu1QzicQMEGmeoG9aHBDoFX9sPjsMhWR/1k5GffC8z2UpIxWK5kjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896472; c=relaxed/simple;
	bh=gnpTXz1hC0YULu6XjlDdXqEaN/yyxOhWnkjpyCpHikU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQeQeLD1NrRP6uhRmM4UHW810Mybn+dmYvYoC+R30odYUUVVCP3EnFgBiWX3Kz54PJwABq2K6Xzs3Yz4Py0+UAg/WxeCdtWIFRW5cAA/zOeqSaPskZAC+u5Y8/yVswCLJvI30PVxiSTcXQD1Mj8qUbopsy91SmkLA1BYJUsfDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I7G0htjZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMP2Ni031503
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=j5ola8LeytkGQ8rZLaP2dj6T
	nr7eP4J3lVcQKMOGykg=; b=I7G0htjZJfP7+Sg2Rhzjdtk8McHddBYyEReZ9ZTm
	BBTzzrxpOzJY+s0s4VuxBuxBdk2ahdYVw7zcHJYDyvLeTW9Rq2W/iyukCanscyYM
	wHYTBeFp+4F6QZD1gl7Skuid0HwCbJU+rYX5sy7oZ72F232g8qwFGRhLfLj59Y5f
	eJHGNpL6Qruv0qI9LAQW3do7McxLtwXbUUKPwVsHeDGwfYXOEcgEFKT7v1ZCQ4i5
	kkj7zShQV4VTXOTOzBj/+KHkyL3/HmX655p3qSexDwQb5Mf1r3khi463eNgmsJD7
	IkCn62O977LJ4IySdGenNwcZk/ZB7SJ/m+KWnuQTGygRFw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yxkb0pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5fbf0388eso51708081cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757896469; x=1758501269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5ola8LeytkGQ8rZLaP2dj6Tnr7eP4J3lVcQKMOGykg=;
        b=k87Ovw9qOS38UHOZ9uPBI+SVjCDUuz3P4zkvKE+k/Cq8nFIsxKB6HXzhCEl9Upe6HP
         EMHV4Q4Tn8bdMJHWBc4oAfWynw2ihDxasktezPymEZHeuTom76NdNCeSTfEdS1qlvhXU
         lFgOA3j4gS/lX8s1uDw23Ey6v1JZA1l3+mM56wN/BaNhz1PvtLfQAlHJgkf8HZBY7r3f
         z+oGd83saleAALd2daIQ8BNcm5S0UYLcJF7DDFnt/9GtlAGaTjM8eyQN40sXw07oevTk
         OYuwasDYxChxUOflQiCDy8Tj0MC53Q/AuTzj7rIFZyJfrkxjC8LWI58+VnAEJUa+jUMv
         VmIA==
X-Forwarded-Encrypted: i=1; AJvYcCWTAyMvnbXQpHbCVCgnacl2hgVgJffFPJxyULTxmBhSyCVfdG9t6ZYzgWPjrInb4t954y0amsii1AnRmWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYE/SoPsQV6Klry2zvMmDYklGILa0TwzvXJDP/yUBYibw5faC
	wL1Orm+Tsd9KbDGfxRR/g7GLocFw6++z0gLRFWxL6arJtcUJXp5jUwlB2g5MXoezrdPThhHq0lH
	KnkL7Gz0emyX1mhMN9/Ke9iJ9gmIojeHsE0oa2fI83aLLDYXYXUHQ90grVkz9tkNvnnw=
X-Gm-Gg: ASbGncs8g62Z3n/ttuB3ALOw9iyAui/JB+/o6F9BDl5GtKAT88uK8i8S4ZxjCTcx8O4
	ZkVuVYvjI6wgFuxhhaMUsVSU+HrE93uOMsSBap/c8rARPuBMXGS4qj4w/8kSgDcLVlmjSq2b7nf
	el6XgqKRQNx33JcYfeUghvtPwi968Ny3pRjZkvr09dtmttDP1Rz5xCvKdM5jJeTBL8J9wN6+FjV
	x6I83NVOSOTxf56jJXdQdZk1vMF5AILlX7JqqqNPZ+Zm4zVa7/P3deE+YVf4LusIqPDDT5x4vlQ
	cyRuqEqn9m5JCxPESrUoeWo1vD2P2bqYhz+0farqq6E9QcE/3U6CfsUT4WyrvqICXmmLh9H6bUp
	iVARiQrDc308GmqbsKlRVFPF7B/waxpc2LtUCzj91wDdbnGg2PP+n
X-Received: by 2002:a05:622a:1355:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b77d10a730mr130971951cf.81.1757896469099;
        Sun, 14 Sep 2025 17:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFj84HG1yg0KGXTeoOZG1JsrRK4U0R+HdjmP62TNo46rgH37tgO7BjijtTa96/Q4Lf2TTy/w==
X-Received: by 2002:a05:622a:1355:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b77d10a730mr130971661cf.81.1757896468594;
        Sun, 14 Sep 2025 17:34:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f495esm23295051fa.24.2025.09.14.17.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:34:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:34:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: sdm845-lg-common: Add camera
 flash
Message-ID: <ja4oeddeirvmtqx7lmxxjwp476hskstxmvb7iaajy47zil7bqa@oubzrtrdrvw2>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-4-23b4b7790dce@postmarketos.org>
 <hzqsdhqvgw2cp4xnxocyddhz246ovicwaml2n3qqdooohscyis@3uo2qjlrapr7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hzqsdhqvgw2cp4xnxocyddhz246ovicwaml2n3qqdooohscyis@3uo2qjlrapr7>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMiBTYWx0ZWRfX6DHnQZJxP5qI
 tVV/40ca/Isofj8egaTr6wCuTmkMxhaOjy+M7jM5L90Q+462gfhrdUDBaYW2ClMeqSDdo5ZsaUZ
 0SayfC1MMvEMcmZJrT+OIEeC1dZxFjJ1ixpCyiogDlbRJutDOmymD65hQjHOyA0Rrw6hFwQfHIk
 O7xreEGEIUbtAGZLCHJglR9G6f5g7eAsobRg3SxtbBFQpanWLRdAJOOhhjDxZM1vhZraUNba6Fl
 pULclJhMxwE0zZCDOJ6FdkK2XeaXBqwsIhtkCK7qEbUROgtjHbpv5ysZIWl/mjIGdBFpVX9YXL/
 wGNdsZSb8oqVZx1V3T/3qXuogm0igAg0jsP626CDIc1MFHN5/oJvxSO4xoL/vRcbRTjucXk+w8K
 ouHVeF4u
X-Proofpoint-ORIG-GUID: rq23mDaoiX82so894r56UtDshep08I0j
X-Authority-Analysis: v=2.4 cv=KfjSsRYD c=1 sm=1 tr=0 ts=68c75f16 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=Gbw9aFdXAAAA:8 a=SBX87LE02F_xfZc4-xQA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: rq23mDaoiX82so894r56UtDshep08I0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130022

On Mon, Sep 15, 2025 at 03:25:45AM +0300, Dmitry Baryshkov wrote:
> On Sat, Sep 13, 2025 at 04:56:37PM -0700, Paul Sajna wrote:
> > Add the camera flash so it can be used as a flashlight
> > 
> > Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
> > Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> > Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > index d6129ce03f537f0c8c78c2ae5f39be6146cab7dc..df826bca2bef5e3f85cf49708020a47b8d6bd8bb 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> > @@ -604,6 +604,20 @@ vol_up_pin_a: vol-up-active-state {
> >  	};
> >  };
> >  
> > +&pmi8998_flash {
> > +	status = "okay";
> > +
> > +	led-0 {
> > +		label = "flash";
> 
> Not allowed, please drop.

Okay, allowed, but still please drop. See how it's handled for other
boards.

> 
> > +		function = LED_FUNCTION_FLASH;
> > +		color = <LED_COLOR_ID_WHITE>;
> > +		led-sources = <1>;
> > +		led-max-microamp = <850000>;
> > +		flash-max-microamp = <850000>;
> > +		flash-max-timeout-us = <500000>;
> > +	};
> > +};
> > +
> >  &pmi8998_lpg {
> >  	status = "okay";
> >  
> > 
> > -- 
> > 2.51.0
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

