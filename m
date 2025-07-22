Return-Path: <linux-kernel+bounces-741412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE3B0E3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B401C8204F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77642283FCD;
	Tue, 22 Jul 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yl4laYLO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839402798F3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210523; cv=none; b=JJN3NxnHdJiCySgfIxsyr4hXwFm6F2gQPgiufTKxyrjUaBpjsgcwVVAgOTNYYFAYATeHRRcZ+LICk7o5c1a7wTs7pujnRN44HXpZ+JsM7dHwxuJMd1GQG1lr7rcLqUcGrdHNjowhzkj2XQhU48T+t0ixB2mFIiNj2p5wVzXkJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210523; c=relaxed/simple;
	bh=5QY0ZBT0oOOO0nndZd7h0v+4kaypL91h5hBfStoNEuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVlacgiOfWWPCU3GiktTWtBzM81VaTEbIfBQRBV/xK3U9XkFTAzfRA+L6HcklFfjSQd8XQRUxXmzESk0oC05hp/lr/JKs3JEPpgDbGjE8GYtDZTL2t3A+9XyY1gjccObfbaaJDb960XH/lMKuxoo5mVWp+iuzSED417qU0BHdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yl4laYLO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MEXMMS015114
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6BKqR8929ZlHM9nTa+e8Knv7
	7GCKjeguQdgKc3ESW7k=; b=Yl4laYLOP5V48dNaAN2Dg/rXt9/yvG3zedNbt8mr
	/2JGccPEbhD2cw82gJ9PgCugnqRRnNtIk2ahHF2HMvm4gVpZXr2RvoHwXqPhZc+s
	7OmSoW0W+wzfYeJFD9oXIUwV7wEMS8iZrap6puZfdy1CVfV4ZG5Up8nfGl459b3U
	1m/oDS766ZzUY+yrv+6QdCB09EDdDqOCnsf95UfVHuQaFEX4yZ2BSLR2c0H196PL
	Q5EiDolx2RGf8zbPeFW4QsT/kQ3yEq+/zgSJnBUuENkxhk/u+T4/IJw7g6bCcz5f
	5k2fELcqZnQnVnuSlM502a2zYfk9mgsOnXcX2fMf/ff4Kw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na0y6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:55:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e207330a45so823722985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210520; x=1753815320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BKqR8929ZlHM9nTa+e8Knv77GCKjeguQdgKc3ESW7k=;
        b=MnrRsKZuIkIgW2j4XphRETri9uv4XhkoOq0v2jjIteb3xyUJQ7zhQzaYR+VhLeyNBe
         wyo3cUQSOSDoL90pVbQZxDDYdrRG+MT47iIQDQ4s6HPET8WROPbsQ+GQ8ieqAG4HopZ2
         CAj6CXOXAb9Uw0jla2xBpSy9EFY2Zdw/b42UXK/AZmhkumnahw8L+e/tBrb7P/ZIf7nC
         BqycLl/IaacotEz0vejzyL6yuOHdY9iZZTzvllL8gDHgt3zvfYmyWuZrS1xFqB2aQ1O2
         qVjyMFLbUl/jkNmwmlhIg/WEynZo7THwK6bVqc60rS6xfLNlGbO30LI1838bgIJo1wNb
         P8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWthWGRmOFNNQCxEMR47sTSGezZ5gwMnmh3cKE/0GM/i5WxhfSW2nAk3Z6FM1wSdimOoHECuSwxiu521OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54TkynyTptLgwsLoTql38VvXuV1deOSRi9Y6D92ASWLhw0FSD
	iH53Cf42oZYKzH6yy+BuGCrcgqFrlqHRrcB20mw7StD/6ziTzZKt8wt+ttPBMFoPJd1lG76Dqit
	L6EBWSZb4e71jYGaYjwNLdcLP3rjeEnhvH8dhf96/0YtgX+0Yy9irGW3xoxqoBjXWM34=
X-Gm-Gg: ASbGnctK1zluX42fIw5mEiq/UdY/VshiXJF00IsIJutgrWAaQX36blH/QCjYraKHFer
	eD2nGJWxWYqPAXxzEv4VRMOzUIzHyVKU4DqftwCFI0hMMyaB+gCGJEShjaw6FJJlI0AhR0kKHf2
	Y1mLYONcFeS4EYNZ6/QCaDb18siH+jTlHOh1cFa9MVRTEHp1VeHonsSA0yZ57f69n/EmGOjMjuA
	dgJbRhIClBd4ROYwjSsYkmchcfk6xP9DC9Gw/7dIPqicLl2QpkmxUCHT64G/yfLMiCvYvjfMQck
	rr7qh6o2HqfDQY7tQGKwvxce84/mkWSEv15P+1F6vW6VFl+J+Svy2RFTSD0ZYKSnhw0XAUIqJl1
	LOuLmuF70ORIE+nARzllerOqIfMkziA2M+uTLT88h3QdKgmDL2eRm
X-Received: by 2002:a05:620a:258d:b0:7e6:234e:8e8b with SMTP id af79cd13be357-7e62a17cbd0mr33307485a.39.1753210520186;
        Tue, 22 Jul 2025 11:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0JkKltrirF9ixXg7tHwQG49S1rE2Y01788xVR7C3PcWVSHdggi98ryTWzd0HejsZYizLvmw==
X-Received: by 2002:a05:620a:258d:b0:7e6:234e:8e8b with SMTP id af79cd13be357-7e62a17cbd0mr33303585a.39.1753210519558;
        Tue, 22 Jul 2025 11:55:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c228bsm17136171fa.62.2025.07.22.11.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:55:17 -0700 (PDT)
Date: Tue, 22 Jul 2025 21:55:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Cc: mani@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8155: Add gear and rate limit
 properties to UFS
Message-ID: <kavkq2wgtapagzcdvm3lcvy52bcgbqul6oqjaluvzi3q2a5z6g@jzrowliqets6>
References: <20250722161103.3938-1-quic_rdwivedi@quicinc.com>
 <20250722161103.3938-3-quic_rdwivedi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722161103.3938-3-quic_rdwivedi@quicinc.com>
X-Proofpoint-GUID: VLTASfrU4dFUIvuY0lWYKer2_IXXfQ9Y
X-Proofpoint-ORIG-GUID: VLTASfrU4dFUIvuY0lWYKer2_IXXfQ9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE2MSBTYWx0ZWRfX5Frj7xgwCjzo
 P36sNMLV8d8e/UY+tBZTAmUN0jLD6t0Pcd0vpCN17kKcCaZaqpNWAiLO5Oq2ZPgh8O2WHqOFTfL
 2zvjcntfxW8OIAb5fNjKB33hwCuTv9PqYDZvq5LYnxkGCA/ccNeMjaQfJy4kRgJ0RqfBqTwG7Cs
 tt6pd/2Kwm550CczrdRpyD5ogagn6c1/m/oe6JGMy8d36G7O+mQaDQE40OikEnKH+O4rjx2uziw
 TNEl/m9ftUDjo2PFUJDht/PjEANQiivqW2ao03zdBoyIat4hqN6Z/bu3FIIOtIwnq8OhxokgwQp
 NL5OoUy//aEf4JKaYNPAKNvFrKj7+4o9B2b6rRPUjuT67vrku0m40SptPcJ37kk7r1i96nsTKBN
 T5ECStNSEYF6j8OPYjfoTA361H7qj+ZJj+ewLL4g55EzrBS2yi+Yq/1uIlGF1FukjJtPKuvo
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687fde99 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=PsoIiSmMjj9FaRidGiUA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220161

On Tue, Jul 22, 2025 at 09:41:02PM +0530, Ram Kumar Dwivedi wrote:
> Add optional limit-hs-gear and limit-rate properties to the UFS node to
> support automotive use cases that require limiting the maximum Tx/Rx HS
> gear and rate due to hardware constraints.


If they are optional and they are for automotive, then why are you
adding them to the SM8150 DTSi file, enforcing them for all SM8150
targets?

> 
> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index b5494bcf5cff..87e8b60b3b2d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -2082,6 +2082,9 @@ ufs_mem_hc: ufshc@1d84000 {
>  			resets = <&gcc GCC_UFS_PHY_BCR>;
>  			reset-names = "rst";
>  
> +			limit-hs-gear = <3>;
> +			limit-rate = <1>;
> +
>  			iommus = <&apps_smmu 0x300 0>;
>  
>  			clock-names =
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

