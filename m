Return-Path: <linux-kernel+bounces-833333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD5BA1B28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B95C7BF184
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B12798F3;
	Thu, 25 Sep 2025 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBGGbHfO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F525EF81
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837289; cv=none; b=bU7IfFYLcUkdXoxdtitFc+hbJ0DEq5Wmb+Cvf//xC88olgugmtFFT2uOnOD5rtb4WOF71vGUwJiHMRN/jSlM7dPZCta53bs1CgOImtdHvK+i/0u1b0CrneiFYyplSEfyLlZYzm8WNEOY+u2FE+zDet+dePlpo7popotqe3Gz+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837289; c=relaxed/simple;
	bh=PtTkvFAxmzVKWuyPXiOlHFi3dHU6l4N8I+W0hW8tJao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A023HTrZSs5M0HLH/Ofhufo0waPKs5rVkGraRIiB5WmeNcHzabZ7+zBapYGkCML3sxYn66/rTl2dncHXBQQQpCRIJq6qKgeg1jSE3zpxq4sZi80VpDQesXZg8D/4RGUtaxt1dAJgo14DbjaNmrap5zUv8PoOFSU7DeRjoBoTYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CBGGbHfO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPbKP011346
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WK8fdvESA/OTliyL4dPj+6x8
	FLgnKUZvKWjsZ9ztQ+M=; b=CBGGbHfO5GieknXvJF57m5MG499qdch7gyJUxhyb
	g3jbSoSR02NbwiuFNxMLf5vGv/cD/MCt/137RrgBTFeOzk7h7up3903PMNdBT8CD
	SsgSMsRHjCADg2+8xHMXpzHACtm/vVWrgnzKPkXTHjk3wrrkochuAkr1TclpQhoI
	/xhZWJrkdG2oQqHjnIlXzQ4nr33rf12853oHOOKnqeZbXbbtWC/1rdVzFMBika/K
	msY/i/pQEEafSDhvpN2D2ZjquiboQqH63dqGJ5heFR+P8NAkX3uQBWHiJrrWzJCz
	Sy+l575LGFGEh2laL7WHJYS8qwFSo5eXchAhuGnkazU4oA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q0gbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:54:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d77ae03937so40468451cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758837286; x=1759442086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK8fdvESA/OTliyL4dPj+6x8FLgnKUZvKWjsZ9ztQ+M=;
        b=a3inuxZrIx4Twmd/GNvDMp93nY/W6xH2H0igghblQTndtp256+YjikSSxu1VWW5O6X
         gCWCz7VFrfU3szLcTt+y9ZekitnhSYqzDaKr2vf7zDBIKFbj296t06zRDPGATD1t46IB
         XdmPtojp/sa6kmic1MQ2u1D2LCaqZx3DbOIUs58crkbXcRXXMXLUyE5CspKBFKf7wSmg
         WraQ5m/TdiORNyIJDOZ6Rins64AZ1JWkxTCU5MtD7vzAg64FISjyUOfesEbyrHmNr+2s
         KFNJbLnlZSaB8xywC4IWDCjgH7/cU6jzdyEw2FKcsWH+TBMtwqvDaY8DZspbiEqBf4ll
         9nYw==
X-Forwarded-Encrypted: i=1; AJvYcCX9GWXEW9h3skSdEMeqtFds8uS9k2P1sOHzPetFUx+8I2umFHfFdB34Hxds0kdil0OjgWMEs9EWfTN6tlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMmyL2TsEzTAwH5f5nuk6bBakmZ1p26hHI9P0aV2b4CZDs9vT
	Xgl34bHF9QuR4hIjZUYBKDjZ4723/XmQ5ociyQXxpJhW1+a+OzbVB6NYUceTapCyaYnQG4ZxEbE
	0/x+Jlvew4iKwdUPb9pKpQ9WhQNobK5R9fDlYi8QfMabxjtuOmR4it5AECEiA6Q9sCUo=
X-Gm-Gg: ASbGncsWS7pJCWaUKAuMnmxGI186hM3SzUq7QyAz38d4bFaXFCC85ymPmqDRu6s8eqn
	KQrcLSLfifDdquOnVIQ3MjZxKmN1TKDfPYrkcp9bcLekfUZwWHnjtFVyFaNWYcdzCkNIUvbjjNU
	Yjhh5A9S2Q9Vb2siW04CgdlzTtASpzI7qaBuY4SzM+ySXDzqf8si+tyrm4Payr1EX8lsi4OMymW
	/yuQ96TUTkB+z0CQX0qJn9mWFxQQA2FGT7b9/4qz3g/YaeWLwmLbxYmiDGHA92JmbAjqZ8L4wtJ
	K7sa7KnliwOZR6g2khzhWy23JHZ0WHjHn3L6dUXVAyVS6Z40ENIG1YquTU6Tuhqwr1agyDFUW0x
	hHM84Mp+gHFz4BYecdNBEx/N5WnZrAA6kjO2FAW+3ehCdO32OwlA6
X-Received: by 2002:ac8:5d02:0:b0:4c9:a975:de57 with SMTP id d75a77b69052e-4da4b8095fdmr62826041cf.40.1758837286019;
        Thu, 25 Sep 2025 14:54:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIHqvgghJCvaOUOze81nukdnXAC7zdagDIbBSgvwres3Q7gPK8kP6rfKMTox4SKyvbSZXPWQ==
X-Received: by 2002:ac8:5d02:0:b0:4c9:a975:de57 with SMTP id d75a77b69052e-4da4b8095fdmr62825681cf.40.1758837285529;
        Thu, 25 Sep 2025 14:54:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f99c1sm1117472e87.35.2025.09.25.14.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:54:43 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:54:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v6 06/14] phy: qcom: qmp-usbc: add DP link and vco_div
 clocks for DP PHY
Message-ID: <soor7srlw3hoqh2onmn4ki6d6mp6psmrbz4simwvvemcy4s5hr@pzabx7comvc2>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
 <20250925-add-displayport-support-for-qcs615-platform-v6-6-419fe5963819@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-6-419fe5963819@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: baiYjvvm9Oe_bcorKwebdDxGheyPu-xL
X-Proofpoint-GUID: baiYjvvm9Oe_bcorKwebdDxGheyPu-xL
X-Authority-Analysis: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=68d5ba27 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Ig_1WL0MwRJ8oiofZPAA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX1xpVvtvaxpwd
 JnBEHw0TshnjCdiCM658rW9FuJqlq7SnE7R4YkbkRR3jo2MqkM8zEoCwVuY28l0RnYOUXe34sNK
 ZSahVhwVzzJZ45BJcVOuf4bO1gF+nmqonJj229+i+y8kBpdh4OMRgkMueCyVweQu2TAb3FCyt4Q
 wuVSKfWz7QR12VL8ahrMljPmJEFXFlHbkdRI0w62JI9BJa5dOfR5Qsi6njeHVBcZa+ipA7R+Ci4
 RlW4eLTs/VrTji1Lvcb1z9qr5tm2Fqf727BmR3qHYtK7a3QfDYY7Cx6nWEnbsMbmydFfncd169m
 9iPZZoi922PsFiTtIpB8mShHaNjC0XSyWMv+3Mahca4OotoJP7E/D63uLPxZjOkZFBeq0TUVeOK
 SylgeibEMshlM+8spClzQjBAV4h3QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 03:04:52PM +0800, Xiangxu Yin wrote:
> USB3DP PHY requires link and vco_div clocks when operating in DP mode.
> Extend qmp_usbc_register_clocks and the clock provider logic to register
> these clocks along with the existing pipe clock, to support both USB and
> DP configurations.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 210 ++++++++++++++++++++++++++++++-
>  1 file changed, 204 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

