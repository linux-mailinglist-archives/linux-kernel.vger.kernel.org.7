Return-Path: <linux-kernel+bounces-893586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD1C47CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A3A424BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9C26FA77;
	Mon, 10 Nov 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZpE82+7y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PHJT7SIo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C826F2AB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790334; cv=none; b=VXHe+SMJGyejMLmuyd7aH40XvQ0/yxm424p/g+x8zRJl+xdsKKd43Dt5GuKpX8Kkpy811AqrvseexiXQk9c6I3qf6prDnQ0c+Yuwji/wcpmY3Xa1iUpybKAEpFElhhQ1oYtrPHz6bqtu6FvJpxOR4x4W7Mwx1Wt3TExf9Bcx4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790334; c=relaxed/simple;
	bh=QDDX2DA6fHm4ELtkSv88cWLg+c3haBcu7aRJJAPg5+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH+o3AxMhgEPjqOBe8iOmrvtmiDZbu2W0/zYugEyGM+hVOX44rLaiHKdgB7jaJHRMbCg5GWpQfsrYkFQEzjAG3kB/xZNGriWZE1r71V2RaEvwCNgbEU/Q6qt8W/YL9kii33jhLe/qs/MXzHzChVcOew9jnLmHHpUzHVNDSI6nBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZpE82+7y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PHJT7SIo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACNAuh3307041
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vLXvSvdzIuLRXS7nXEZVCb3O
	YqcNIx8WojewEu7d1PA=; b=ZpE82+7yefLfNP2tTB+GFaWzfkHt+pbzN0SzT+kA
	43wtNUyZgBhyPB6DMdexUUkrTLuReqOvo6LP4+qXLO+GbHtEyS4GOS/mrbRY7HlD
	NCycR/wPxeL8pPwM4VPlE9vg00Cnk/fLFVNE2kNDJ3auAPOjPIO5Mfd6mpuE8QYJ
	biSvi0sn1tnXl7mYsipsPklT7+MPLogSleDCZA1Zci48qLMhdTSsAe2nd8R4MVh7
	fMRhWyddmfE2h6Rc8uAyZHYmZEAr4wombQ6/RcGHlsij+QUQ0ZhfgutnCY3y6ebI
	iFYDZIZqNwnnK7J96d2oWsul7fiEtv00ii6J11LY3Mge1Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abg0q8ma4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:58:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88947a773so80463701cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762790331; x=1763395131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLXvSvdzIuLRXS7nXEZVCb3OYqcNIx8WojewEu7d1PA=;
        b=PHJT7SIoKa2f//8n+1SHJ2xrb1kUc2P+XnZBn4dmrGPxhBAdKJltbaboCflRyI6M63
         j+u0ivPd5tCXL+Uy4HlYiZapZTR3U7+AJpxXP8Q9Q3ZyZaxXlw2u7lns/FKl1dpM46tB
         I3Lk6Pn4b7+85jVt/CCRPZfKROPn0GMovdX5fI/1oiePYAAlaZ/kVQdwn4wAucQdwZNA
         vKYxHpR4kNq25heJFMF0dTS2Hxo5+6zGhoe/WuDcJ6U0pCFV14MTZa4iTpdizLCHZvhc
         Bj+kmXFTw01pd9qAdDyS8p/3l8NUz1x5WfYvVbKbx6AnrFh2iWptg8Db2WX33IlDuHEA
         ovQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790331; x=1763395131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLXvSvdzIuLRXS7nXEZVCb3OYqcNIx8WojewEu7d1PA=;
        b=f7stOrEHzVbV/lxcej/QtIbDlcQGF0uDP0P9s6BTFw9UB0iwYAt4MSpLBNpkT7eSMR
         D8gTI+a4dR4/ro56QZ+c2qC0jonOVkVz10heRObItKSWJ/7ed9MqWHzM/jCU3fmLCqDF
         HXLOeAumVyPBdyyFAiekf6zi3ZRAHX3iro/soacYmKr4vrSn0r/PEXsxIuAMbnlftnsT
         3GaBeRxX1/LZHCdtGCiosJ+LlZQ6DZSSalSBLf88ovG6kk7kkPxy9sTYZts/pA3WOWUT
         8C6GJR18o5KW+z8jEh869l56hPUrUhcc1ZASy1aIFuNdmA3Hf9mTWIFoN/amrK2quBGn
         zZEA==
X-Forwarded-Encrypted: i=1; AJvYcCWPOukCBzNpoThytikw9KZSehZ7Ug+S8cNKyRqtZ7RPDzDTh05HzVm0HrtwKekBCAwuwFOcx/3jDSTJbM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9W030q0tI7urHox8h08zriYzhmcn7+vCbY4lLby0Kq+CCtgyS
	4I40QdO4HfYV6BAglBKw+4X7jBED+WJRGcyfrFpYZyANR0I0cOeh0H1NlNLmHpYe+ni/i3lwQCa
	esdR5tHu+UZHLCxMBIFXouyQAcSpjSJkUs2yVAlFRQyeNtsUuD95wBb5N+yv1ZxfhXLU=
X-Gm-Gg: ASbGncukww+pf44lDQ9xf+TZNbV/k/eeXasKZ/xXCua99CaMUNU/6j9du+nci7ttw0H
	3JJJNT2QZJegTJSMkjZ/rzHLd3UFHrFuSlyQqf1bgLQHtfimp1Rg6NByHc+evFC5RakrmP56tn1
	fELraasTxE7DdsFrL+3ViiZQrpu5qWgK2/wMyCv2mGBzRT6nClGdt1YuPWUhWPD5+vshYm8oEO/
	MaBhwTHAj2A8tTTVwJChH35N63DkiD4z7jW4laABwqEUKd1yUssWtm9kpWQF8JyxN7HK/yhnYWM
	FuYtIX0OEwuyfgkd3dbUAV+GNyvyp7vB4qFrN3yqpgEGrhXgXcM7PLLTAsf2vBnDSfCS5Pw3l6p
	sydlU9krq6ZQ8QeXKTyH0rKKlvEvEVAoiPV8/K1q43RIx7fd4czF0jhYND3/ej5aVVOHg46yE7f
	AQMHeUkqzVmrMB
X-Received: by 2002:a05:622a:1446:b0:4e8:a97a:475 with SMTP id d75a77b69052e-4eda4ff22cdmr113143141cf.79.1762790331323;
        Mon, 10 Nov 2025 07:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERvz/5tzN3fzzFof150ow0CPkMngjJVvCc1HpPWCZ4P2NqMVrHjzZly5tI/ZePmcV7OvSq8g==
X-Received: by 2002:a05:622a:1446:b0:4e8:a97a:475 with SMTP id d75a77b69052e-4eda4ff22cdmr113142801cf.79.1762790330852;
        Mon, 10 Nov 2025 07:58:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a5a0d0asm4077997e87.111.2025.11.10.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:58:50 -0800 (PST)
Date: Mon, 10 Nov 2025 17:58:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Dylan Van Assche <me@dylanvanassche.be>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Add
 ath10k calibration variant
Message-ID: <bxuhdnfapc3nl5kmvvk2czwxhyrzaxunw2hmccvzoutk2xkj6d@sgfb5tgyxyy4>
References: <20251110-sdm845-calibration-variants-v1-0-2c536ada77c2@ixit.cz>
 <20251110-sdm845-calibration-variants-v1-2-2c536ada77c2@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-sdm845-calibration-variants-v1-2-2c536ada77c2@ixit.cz>
X-Authority-Analysis: v=2.4 cv=D6JK6/Rj c=1 sm=1 tr=0 ts=69120bbc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VnAOb1fkWFh9DQKIKVgA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzNSBTYWx0ZWRfX80usnKZFttFa
 RqX34ZSpdIKvvGc0CoMtVDXg8jSlIFnw649BN2RZEaTQ/a84fe6dw5RjJq8NiWuGIuA93MBIebP
 L1HWbpH7rl8Yc16TrrEP4tRpkGXNNBCci5LmMfXQIoZNq4bVBygnau3UPe0Ca7LnOfYEsz9DOjM
 MCWp7HKFhy0GcvX2Fkh0eMmL00Kzv9IbeDOWvhMU27sf3vC0q4R7aTUbWmTKcJzXWTeoFNIxuRy
 AoQJBQwOqIMmni/b7RDK05xTpxT0gYpTfwU3owbR1JpJdcbXEG0xzIvXOtUUkWWr0ViC4JT6zkR
 gi17O6+l3g3gfjpGuWTYpRxrdSbIhNvZAt028fJ54Z9xKuj3HxBMJJmNL11ljYzLJx/89/JCq1V
 tXz7us2zU2MKxWb20CQqPDX9sewuOw==
X-Proofpoint-GUID: TqRSUn-_0CVjnfVUOewSEmcgTtVsLwLE
X-Proofpoint-ORIG-GUID: TqRSUn-_0CVjnfVUOewSEmcgTtVsLwLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100135

On Mon, Nov 10, 2025 at 04:37:47PM +0100, David Heidelberg via B4 Relay wrote:
> From: Dylan Van Assche <me@dylanvanassche.be>
> 
> SDM845-based Xiaomi POCOPHONE F1 has its own calibration files
> for the WCN3990 WiFi/Bluetooth radio with the ath10k driver.
> Add the calibration variant name to the DTS to reflect this to
> allow using the calibration files from linux-firmware.
> 
> [David] Adjust the compatible as ath10k-calibration-variant is deprecated
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

