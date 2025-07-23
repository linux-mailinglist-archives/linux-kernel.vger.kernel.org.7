Return-Path: <linux-kernel+bounces-743299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E70B0FD08
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAC717DC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C9122B8A9;
	Wed, 23 Jul 2025 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fpAuJ1Gp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936B19C54B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310656; cv=none; b=Y6Kg+ueT/WgouiAITIfCqSYu4smyds1mLzqTEAh7eLiWGxObZagK9tJuomfXs5FqrOeIUyYjbRNpewbd0eddYRHFl087YGrSc6d43QwfaTkT/ZbgFpA0xV8ga+AoSqcuxvsn8bl4sNqLZqMmcKPzNlTOE3OPorU15B+RNVb7NjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310656; c=relaxed/simple;
	bh=zmsK5kpPaxMffdyHZKMJno3wCYeNPInTtvSgROuzmZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTW024VryAAjVEMXrmnV1fmGKT8BJRNm4Er+e8F004TuBBzSQ0UZMklB7h5f18JW1HCm8+m+DRzYH5L9fzqRvGfs1N/X7wfvbR4rSs8ZJz2Z8UIAAVV7Wi2BP3mh/3+/DDzFXZrQ9RVZZcd1cqvfEvMPL5/cXB1MA/V/ahXOi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fpAuJ1Gp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXSUI031250
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=84AQR62nTeFa8YjzQigcwqA2
	N7YfGm34XDdirzJG4Ko=; b=fpAuJ1GproCBUYRis08OH/hsw7l+lEtiC15tjw8b
	D+Mx+mLrZLHrVQcb68fmsLB8cK2gikOXiLkE3PmFbdINnJuqImNDvP+i4ZlMvFhj
	/KqZzZHtc3FIdJWWuQha9aqKQfB5O+fOZPXt7aK6LT5UnhHCLtT3HKoh7a1BoIJw
	LBCZK9OZvp5bnD5M/cRCOuhT1CCO57QGGLjZUK35kvCGsLlDpYkAVaxTvaj5j+tx
	KI7tgWorR/RFg5oGWFZZxEXdfDQEkp+VAEv4x3AxlQSmwtMuXfGCJ5LOYOr7IrHt
	AzmDbGGIoq3bu8e1Pjcap00TBjGQ7+Lz5mLF/oaZJw7oLg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vd34x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:44:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70707168c59so3116226d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310652; x=1753915452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84AQR62nTeFa8YjzQigcwqA2N7YfGm34XDdirzJG4Ko=;
        b=pRwPNwuCAk2f2HwcZruX1DtEm6A6FnbwOLdnSU5H+ijE3GjkLJFBru9Ux/sqPFtLnV
         f2SFvVtDzdH2j3F0fJ4/OYt1akg43Zui7AFlj0SRDPitEWdPOyMecKSC/1IfNVS6LJiL
         ve+m2LEzEDcoQqLjttwU20V5zcxM9yArH8Xi0k4EdB0p+EdDEA0eUowMdRXqN+4ija75
         b3rP7IFwbzD2UNMYt3pV9tWS9xglr/Cg0U2lDqScXkiDHgOSBzuBMOOXFHRh27grZJLf
         QsXlrJsV+iRVWL4QMFMEHBg33a2nC4lDQN0IWgmJVz3ouiMczUIdXxje5vDn42NKmEN9
         APWg==
X-Forwarded-Encrypted: i=1; AJvYcCWR5p6iII/k0D6YKnweMuV9NXLPZsDFfRHQjKryRVAmzOS6OEDxd/d2y3l+Dorc5rkqj8qBumccuTAGM9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGBUzR6N08jYqAph/yABEKoQ3zoW8BBz9Wb5/nqUFHwPSNMrz
	j1Gr9xmmzjiZNRoDGz1Oxnkr9ONoXRJc4WvVYiGJ2+7k0yC2/jCFFDtbotry0i+isIREIhje7kb
	iF/ytKPReXBnn/tXyndoqp6PcUmENkKXxmEQsU6SpiOOB8/YfH0JcXJtxgQs5oIfMPuM=
X-Gm-Gg: ASbGncsv0t7+1jHvZJYa1HDah1IFKjYPz38i2b+dYw5BKvfRDUmMbTO8Rj8TKfG+El9
	cooB6PoF55Tgm5o+0zcfNfvxUDozM0CXsBizvJJ9W+zFtjhCoiULpA1wS5Ik9Xpgut6ZzB+wpS2
	vvxBllWLPCK47aTfDfAGK4zXV7LL7wvzGnWmSkopmulYC1gaPU7hJ0u1QvbLDwtOwJT8h2ClgPk
	o7MehGIV1gJnBhXnKCOgWjLj7o467SuaIOo4vHgnJPl6a1UeujNUv6KMMiiqFlZmYLoUJ/z8aXm
	i37mbAU/Yq6l9bPhl2tPfvzFRe7be35pngRHza9TLxq/wK/bGs3buN1sdSxOUC+nAUZ749Ty9lu
	Qbzb+bHign5PogRv+aqviYXCSrFMzAazjXrbw/ejWVBIm0M72yJrw
X-Received: by 2002:ad4:574e:0:b0:6fa:c66b:8928 with SMTP id 6a1803df08f44-707004a78c7mr69538656d6.2.1753310652323;
        Wed, 23 Jul 2025 15:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERPIXpYCZpF8ZaV7kckO2jIC8ZV04Td0+dZn4eAXpRrER9MWSYR8+t0Ie7ycHDFa+L8/O3wA==
X-Received: by 2002:ad4:574e:0:b0:6fa:c66b:8928 with SMTP id 6a1803df08f44-707004a78c7mr69538346d6.2.1753310651662;
        Wed, 23 Jul 2025 15:44:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c97d8csm49612e87.178.2025.07.23.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:44:10 -0700 (PDT)
Date: Thu, 24 Jul 2025 01:44:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/23] arm64: dts: qcom: sm8450: add sound prefix for wsa2
Message-ID: <g5ymyqh5soso5fj5mzdssz4ovqovecmvja4lvcgnfncnsvep3l@qsip7x3l5err>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-21-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723222737.35561-21-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-GUID: -9kMcDcx92d2Fon7iIW3N0wHYKp9DyWN
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=688165bd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lQ6Wg9WPtxumBDeFL7EA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5NSBTYWx0ZWRfX5HBHCZtz7ZQB
 Kmw9MNkd0QIUn80rszFRelAj0MTVtaZadVFViNRjaCkluRuA2OfPPgraCX15o1xqMuCHZpzeHp5
 TCzEL0Y0d4KU9wQgLYawOn1PCnbf9FYIZ7MIpP/rX2Wt5WTvdKhwPCpZpaOvU9/YFjmVlStC8OM
 4uqiEPSZnWVUTOUPqFv+rtG6Je9k6NwzYCMMaH99/ffeEBAFX5B2EHX/Ma8s5h8/i2CdK0vOg55
 sMjlK0KFYjHNq2q4AcPLXukswB2FAR6MQfMJbWjdcAkJX3WOVogasi4B1dMQecQTHl7bJ9vqkb3
 Sr/FgpkZxlnOFa/crCe1Mw8LSudn9YNiJqLSv/UDxv+pJYkjLy8HgBzdBwQgeqCuGuwGU78rwce
 xP4zv+jiwuSAQu/3l7BGcb5UkowARlxcMoJnNU7iGp6KPn546WjY54JhDulDkvO6MRAdy4hq
X-Proofpoint-ORIG-GUID: -9kMcDcx92d2Fon7iIW3N0wHYKp9DyWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=809
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230195

On Wed, Jul 23, 2025 at 11:27:34PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> WSA and WSA2 are two instances of WSA codec macro, this can lead
> dupicate dapm widgets and mixers resulting in failing to probe
> soundcard if both of these instances are part of the dai-link.
> 
> Correct way to address this is to add sound-name-prefix to WSA2
> instances to avoid such confilcting mixers and dapm widgets.

This looks like a fix for an issue. Please mark it accordinggly and move
towards the start of the series.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index fa0822c37854..d8fd01997395 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2827,6 +2827,7 @@ wsa2macro: codec@31e0000 {
>  			#clock-cells = <0>;
>  			clock-output-names = "wsa2-mclk";
>  			#sound-dai-cells = <1>;
> +			sound-name-prefix = "WSA2";
>  		};
>  
>  		swr4: soundwire@31f0000 {
> -- 
> 2.50.0
> 

-- 
With best wishes
Dmitry

