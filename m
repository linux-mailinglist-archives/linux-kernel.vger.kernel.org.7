Return-Path: <linux-kernel+bounces-796443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB85B400CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293D07B9AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA36264A8E;
	Tue,  2 Sep 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fg0v34Qe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812CF22172D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816564; cv=none; b=aWHcBX3UILeYhOV9rQODxW71djW4Kpc999ifq5CcvxRjpSTKCfU4HoGFUR8/TTtEjnDp38BDIA+3Vyw4AONjVojwVzdiHaCWhCdX21iloJh6J8gF54wEV8MMTuRVRUYSApB1dv43AL3lYqHHTxN4JW5kNDC1OPZarpTF7phtOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816564; c=relaxed/simple;
	bh=3awv6U4/xXS9ndF1y7siUavi5LFFCkIU3jbXd69usVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLD51yPodbwN8CB+YQVASdUlK7Ce5RZGMtp6n4XzFa6tTYQPpwyBuXQOpC1UniIy7MkiFeQb46HLQDAn6nSei0yvFC+BZTKGruTfSoymCvr8+cwZbh6aPLA5FBQECSrbxHr1Ihl1N+9xeuQaLpRrCqus8bhTwW5Siju7rKy9cPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fg0v34Qe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ABFin030132
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ILiX1Kte1Zc25Jd6RLaKwW+X
	3sQ2KmSi7ISWDpWCZuk=; b=fg0v34QeKa8PlKiA8AmqgJc28GgFG57beSxyadVE
	Ouo7snmBxZhCd09165t5Guo7+2q2SlK74wL4OFgCoSP8dMpT+9kylrWKouLpe1Ed
	Aqr/9iNaXc0NB9a5p9k66CcM5bIC/9erA4LC9s6I4pzuvcBVZE4vSjIJ8v7ZH9s2
	gAH4swQn0EEEUglXDerpFaAUsqMS+3MviJn1eY939x0l4aowwrjVrgA5+BI1vK4N
	H/aEFCsu5aofmSL3ewAVf28ATrWHyv5K9lJCYfo/iwWL3XJO40lxGFqlW1M8RHW+
	1g3BxCZykbwGPNXB1q/+cHydivt3sW9jSMuVHhLZ+OKRvQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy3m0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:36:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b35083d560so5427671cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816559; x=1757421359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILiX1Kte1Zc25Jd6RLaKwW+X3sQ2KmSi7ISWDpWCZuk=;
        b=rFABYon/vrEMeeulWcs8Xil71gLrE56RIeBjVx0uKXOWFR2kiVE4ydwaBQYO0F5fGp
         rREorQBEIDF9gtRlEOpx3QnTvHqvhRwKKkpO+DJmKQ/2+LEUoJzLwfEq7/3AsqTDAh6g
         JNM4VAjN+iTGwOx8elAvMN3aAJVt4wuUdbFOhbw/bLk8Ea1+uzlI0zE1DA2lrMp70uL/
         on/A/h9iOLKDqQXprbFynqw+vxnFdFl9yGaIqT82Y8mproc2+EB2Kg+A/RmyNMO/0p5h
         cRlZrGyg1v+O0+IFqRFpI6xTCYDFAy0X9lGn3vHlbhua+BS903QTLK/CujH26pYre1r/
         VDqg==
X-Forwarded-Encrypted: i=1; AJvYcCXLAQoqvVnDwhgarkl8l1ixwsFa6ReH0J+26pYLW+B8T9h9/Fxs+tRoUPH7vLtx1UZcMYchVP85e85hZtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbr3AY4ZcBRAPXQsB7CxuIAmWCieXfehCM0ftj9u2kNG8wiLuZ
	RFvV2sRtFNeieTD6HBU6MtFsGXEXCGArPrsg5Dw88yQFESNiP+SiCFbf81NV2ADSuUqF++0xWv6
	VhJU8uZSFRkBN/NqP2O0CPPJPHp+QHC1z5CqJAnEF+UVMyNKf996WwvnWv6Z25HCyhRM=
X-Gm-Gg: ASbGncsVsuTKATUGEjjswryYtlaSUstIHSdzmkcVnoTSgCz3lLbDe+tSGHPJHedKBBX
	HUUl3pKmW1fRzy7fn6Ru0e+bk7Tqctwaf/x2nKNIyMlsL15fQmZae23PY+jP6/t/YftHj3pGY+A
	hOM6ISy30TNdtcSRnRBo4hggaHDyQaLC3G9ZMGAPPWrxTVhhOb3OqEOxwsMoqirjaGHR1MS66ik
	L7jHLO6cgyx1/mWWSnZ/r7hTHtSUZqzokuBD+DEkSChe5PkIdWKQyy/SEaUMx8fIkudan+0ue/4
	uKfNFOHdakF/v2QV9TlBwfE9KiyCgum7PJLNl6ccJ5xUxXACOYEsFsym4SEIBlqUzLGA4CfQVPh
	noxwYCJ235S7vu6H45LlEDnbvYny1WSyyrflrRWc38mcdt9q0cG8f
X-Received: by 2002:a05:622a:2cd:b0:4b3:81b:c5ac with SMTP id d75a77b69052e-4b31d85d5camr129761191cf.24.1756816559328;
        Tue, 02 Sep 2025 05:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvKP2rcrShFJTSAgCxbP+O5cx19CegSGWpv0b+ec33ky1+7ucp/wBQW9HOyyPTSs0QsJn7tw==
X-Received: by 2002:a05:622a:2cd:b0:4b3:81b:c5ac with SMTP id d75a77b69052e-4b31d85d5camr129760761cf.24.1756816558669;
        Tue, 02 Sep 2025 05:35:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56084bd2803sm317462e87.64.2025.09.02.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:35:56 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:35:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] clk: qcom: Select the intended config in QCS_DISPCC_615
Message-ID: <uhjhgutnur3qjbmqhpjgg3dnsryf6glm56szwy6iys5ffuijsv@ld23wny4s2fx>
References: <20250902121754.277452-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902121754.277452-1-lukas.bulwahn@redhat.com>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6e4b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=GxmfVdM8WKu4Uw088-MA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: WyVQm1vNOSFqoaHYZIp1NNPE1uU7MP3E
X-Proofpoint-ORIG-GUID: WyVQm1vNOSFqoaHYZIp1NNPE1uU7MP3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX9c3WklXAB6Im
 Mrh11oIY4YJE2r/19V7T+jdTI72iMDAhJxRyYCTvNHuQUZEaT7ld9DWJIRgNn0trVfqJNTcY6by
 wOxRwBcGjFdIPhCZgL2qUHBi1UciaV7l1uQz5LFWYwqgQv8tFmtr+S2qreNfTU+pW96QRZNvkXK
 ypK/mu9jnrkUrbpN90WVAnELloBcqvI6kWDsBF+l4NyM1gMFg4o8ugGT9uGN3cednYSaO6o2yuh
 uhZ8PEAh3qmcp80ufFy/yMjD/D9Oo17jhIdQLINPlEHax1PU5EaJWWQzN4CL9x5dYHuO9Ehrz2b
 qgSt6byNuh1meteUM79vfvwwTfbGZFHznFx9WWbE0DHcnGWZNrTVKbXZ4D9Idq8yoabx08Cunff
 vX4sCcL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Tue, Sep 02, 2025 at 02:17:54PM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 9b47105f5434 ("clk: qcom: dispcc-qcs615: Add QCS615 display clock
> controller driver") adds the config QCS_DISPCC_615, which selects the
> non-existing config QCM_GCC_615. Probably, this is just a three-letter
> abbreviation mix-up here, though. There is a config named QCS_GCC_615,
> and the related config QCS_CAMCC_615 selects that config.
> 
> Fix the typo and use the intended config name in the select command.
> 
> Fixes: 9b47105f5434 ("clk: qcom: dispcc-qcs615: Add QCS615 display clock controller driver")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  drivers/clk/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

