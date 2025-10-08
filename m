Return-Path: <linux-kernel+bounces-845468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85677BC50EB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66219188BA98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6426560D;
	Wed,  8 Oct 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioGIzFw+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA525228C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928348; cv=none; b=dcGm6rM1veIsvYkVVrpHGgAl22Oa1jNTqs4Ujk9MoE+as8S9k3QbKW1ZtT0eWUnPRJclf2fQmrqLzMkrM+bXfxiptmvvzK0u1xDc5CFoCgGSneP1PB41hX/4GdN0u491Nx7b8wOj8DWQdHOo/nzW4UlEk2swAbtekKQ5Vc65WJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928348; c=relaxed/simple;
	bh=ZJ2kKaRdwvu8VSF4BFdpI2S0DF5Knvpt16rbDWhmgBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2tnN5tT3P0jcfTdDEOw9On5xwTxZNAEBm/c9grQ6H0xxW7nY/KfdAxJOqQ+Ieiy8DU4l2bClJItOf4go/4/q+tWCWqnvGKy9fhmax3QJqgGZUcFBToVNvYxuWXYQ9QCzjfNvDI6HT8+OAh45JoDQJQClrxsHHrRtSfupqQMGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioGIzFw+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890P1S015814
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5KgYauIrBbKoQVpQqVgNQnHP
	AyVbPvahAJXvv+HqRxo=; b=ioGIzFw+qKFKX/+2hfVRuFmgaRNZNkrPgT6MZH+L
	hdqhc1x3yaMy/pPG0rPHczcaXUsWual6WvmuANcLpREzA6UNrvsavEqVhxxKrC0s
	oRjncqNyrwelRM72QTTE2nPtQoCBCwOPYs7VteuByx/qgQj8EDZd4LNsA8SFU6wP
	EoLZUvf9NgFw4sE9dR6+1XfqNieztW/GmHCyOcxkLoKftcqJ8iNHQUy+35XDO9BE
	ztbs2gYlhJfkzitOgrkB8Q114iMWJtbzXuSZiDR60TfqclKvayiNRGArAEvnvGfN
	w0tWGXrblfl63idaOVFgVa1dBSYAnv1/2Lo1EqkViAiNHQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk72k6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df10fb4a4cso275758151cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928345; x=1760533145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KgYauIrBbKoQVpQqVgNQnHPAyVbPvahAJXvv+HqRxo=;
        b=kdLnVDB4qc3MSnEkFAOdYPlgwS5sHmYBngeuqFkNBm5O5DhSNL+lZmjVMnoc2FsToz
         Cdm4GM8ele8PuLnl7i8EBShe0ZXXe2EXOKKWi8Bnp9PhKhKYXT4GGfPGCh9dDE6Tmrun
         PcuxdTXYVEynu0FJvfQPyHJuCK5xmYVkA1kMwr90vHWsYtIHbM7szITJNEK1pR9/eOdc
         zLH9BdGVq1FEEYC+xLIRwRsw6uzy+xUTr5fyXPA82zQZk0UxEaIoFihUcz/cKOoAYHfP
         KiXf/DNQXhtcprvtFVUUVYO3I6ufvWqUQNeR6S7LRwUt5ouUzPd1htxWFxgTafPUBrr6
         5r5g==
X-Forwarded-Encrypted: i=1; AJvYcCV74KPlyCDZZDTGXy5OG68MRCMeCPMuK4zwGwKsla8wPKqIH5k1Ng8Z6HE1Bpk56g8iMdwW/jYoD+WZJ5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/FXjIiqWCH8oWyo7Xf0jWmbIFx3KIKLHqEnG/3eyukSCDyMq
	4m/hZeUrkJg4TYzZs0zz0ygO7mCerZmzULM7Gb1LHNWvRLZJu6YsguGnA/5Ql+RXWjchZ3eAHeL
	UUyZWpi916YHVmGXNx6HqmvqeBfgtwqKDxWOJZfuyLsPqXO0Uy1ytTtRq8TOZMABcQtI=
X-Gm-Gg: ASbGncuAMwJMrbYLgQgLE5loGgn0m2XF32PnyS2rQ1r+AhqG9PIsqhHP2RkR9X/ckaE
	hGGcCWtXujaeVLBq1de6u/BpsihiogaUxsHb5oj36Ub6LnhoQDu3HdhI4jh7zUmoq38ZIRaWjcx
	ZVbBbAgf6R3pMuzCp/oD2nfCra0rcBJnCCVNtnH6XJbqjbGJR9aYhUIbCuEvyz72Dc18mjY0jFa
	UWlD2M0PIOOXD2IHJBRG5jMV8SQzSE1m8VQ+j7n9mccfpqE1/yhYctuHGeCrOzkdukmVov3DvC7
	CEgIuwNFtLJD4QpLK4AWHr/0QTFnuAYksapiB45nVEU6HHUPRrKZK+V6bASKF0Qdr6rQdtusxLI
	vECvZGjWaDwdlj6cXBvwbHQMfuIWXZ1ikbOkq8+neHmDd+36h5ayIMUmnRg==
X-Received: by 2002:a05:622a:54e:b0:4e4:f812:20f1 with SMTP id d75a77b69052e-4e6ead85777mr42851051cf.55.1759928345260;
        Wed, 08 Oct 2025 05:59:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/kDjU9mNrWpli4fOGqzpllZTDEPDlABYWO/CgAWgxK//4LXGijoGQVXWueGutXf69+EneuA==
X-Received: by 2002:a05:622a:54e:b0:4e4:f812:20f1 with SMTP id d75a77b69052e-4e6ead85777mr42850611cf.55.1759928344801;
        Wed, 08 Oct 2025 05:59:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011404a5sm7192234e87.55.2025.10.08.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:59:03 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:59:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        tingguo.cheng@oss.qualcomm.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Update regulator
 settings
Message-ID: <yjqg2xani47xzik4hrxcuaa4wwft4hyvf4dcjf5mosgdrrfxbc@fum65ap3zha4>
References: <20250919-b4-rb3gen2-update-regulator-v1-1-1ea9e70d01cb@oss.qualcomm.com>
 <20cb3921-1344-4e47-864e-ea99759a1dad@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20cb3921-1344-4e47-864e-ea99759a1dad@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX4xrHeKeEWoQF
 E67xc4t2LAuqNC22wMIVzD18HqwmhRr5vJ/w9VE50WmFQTxbb4adSXTajfnMceDktQ6GC8cvARu
 /j4PM5Pzj9LY1UuYMaC00R3yGH/+9K8g1vK63TjlvUcckFSD3TeVFY/+zzKKMOInpeFef4750D1
 bjXDhI4mGCx9gVTyaiNFxFf9r5SIqSwjuWMlCaZLquzVj9RWdxhglc7/CcJYqqJ0sB1V/TYsELo
 I4pfFsFpxQ4BgyxlAZUn43T3MgAio4k9ompIiV9LeInUpRhwcAcLmCCHS9wTKOY3FfW6oxim/9s
 ioQkWldWLloyGRWNvOGehqdrP87PhRsfBJfgSPGImRFEjZ4WcgG7Q448LjY3pX4RQzF0TEy/UnB
 ow/OeGdgpa1dtWbawoBfG2vey9TojA==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e6601a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=wPZmJJNrXprZb9I2VNoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: FYEqIqCv8xs0PXchwf6P64LgLIJQXH8_
X-Proofpoint-ORIG-GUID: FYEqIqCv8xs0PXchwf6P64LgLIJQXH8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On Wed, Oct 08, 2025 at 02:44:58PM +0200, Konrad Dybcio wrote:
> On 9/19/25 12:39 PM, Rakesh Kota wrote:
> > Update min/max voltage settings for regulators below to align
> > with the HW specification
> > vreg_l3b_0p504
> > vreg_l6b_1p2
> > vreg_l11b_1p504
> > vreg_l14b_1p08
> > vreg_l16b_1p1
> > vreg_l17b_1p7
> > vreg_s1c_2p19
> > vreg_l8c_1p62
> > vreg_l9c_2p96
> > vreg_l12c_1p65.
> 
> You should rename the regulators that have now changed their
> ranges.. I'm a big fan of stripping the voltage suffix entirely
> fwiw

I think it's typical to follow the net names from the schematics. Which
can include voltages. And which (unfortunately) can be incorrect and
misleading.

> 
> [...]
> 
> >  		vreg_l9c_2p96: ldo9 {
> >  			regulator-name = "vreg_l9c_2p96";
> >  			regulator-min-microvolt = <2700000>;
> > -			regulator-max-microvolt = <35440000>;
> > +			regulator-max-microvolt = <3544000>;
> 
> This change is funny, no one noticed that before..
> 
> Konrad

-- 
With best wishes
Dmitry

