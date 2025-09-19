Return-Path: <linux-kernel+bounces-825029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90612B8AC06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7833AF922
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E764A3112C9;
	Fri, 19 Sep 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Akjzzx2E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2DF251793
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302673; cv=none; b=SFCOlq21DWdNGr0G1NcNXlDQLk/9RhYuislTbF2utOCay0cDBjcG8leZRYTsMH+X7Jn6xG4s5cpy7FeObRcdjda5rL/p8SMYtIIl+QhH6SNDjyGO1fk0Ywa9DYg60OxspKRnZwpPj3O7jNesGPD+PQkN6uWGqZqR5bLPDCFEVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302673; c=relaxed/simple;
	bh=jz6EK/5R/cZ51gSyiWj0rppUrk/++V0bISlTdb7FPBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWMlRR6I7kdbxK2jQ/9EbiahYInYHEE1+U4YDhcxSewc+ndOPzUH3YYIDpsfttDWP29EsQJUnQpodtzic5W67cSU6wUSKXJMSCwLGPBHg99xb+1qaCJfRTylcILoVI4G2A7Y+gpjUx6Pkn1g7xffht5jkkqyi3QsOZmqmXFdAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Akjzzx2E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JACIHP007416
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2SmCmfA+ffYL/cc7ScaFG2SQ
	47LI5h70ggIXvRCOHEw=; b=Akjzzx2EPN6moRmflxOtitL+pQPgsWDdtWBjIDzb
	SI9gvZn4SDbKuRbRCI/W8Namjisn8Gj47i+y1yqNnNW0fWGAeWiU584myZTd5prs
	sBFkfPgTJ5061jNFFGvJTdogvEPSvgarLFocP9gB5AgIoGdMbaeu8bZr31+UCY4L
	WTp7+VdRKzvaRfr9DHQS+PAe7MyrPo1TzIWT0qVgC6JYFJ+Q1CRgNonqOWyGk2Qs
	+gxPs/0sFDZGU2olQdb1AT/yv0CqMqMB5NgveyKypKLRs13HlFsQsHeF0zUPgdJP
	7+THt5oGeOj0QyVna4exc21dD9bEF2V1AW0CPntGWCmHdw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebewr0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:24:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4bf85835856so37867451cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758302670; x=1758907470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SmCmfA+ffYL/cc7ScaFG2SQ47LI5h70ggIXvRCOHEw=;
        b=kLpNahgL9khlcQFASYvu+xQ8iMm1thid+uBbv5ooY/mVneNdp1RePwK68W1HTlb/xj
         mbo/88mIO1yCFFPPwYWvBfpv7GYTAVZ240Osl+ZInCWH9NfGHExvoISwe1jMHKy64xir
         J9SJ5k/qQzMKvVt+l281K4fXacQpAlKp4b5c0bCtT0FmseUOyP22WJ8O84WY6dqQ01Up
         IMr9LvyYaqm8eYqMxNDMw/NXcMG3qAwZiacSCa4N9uLzQGXC/vXGCIPmXiFSAOlkgGJF
         dLKuBywgTG2mB37zwSNBxtv5wfMpbcoZJEWzGvqD5Y3+R48s9ECGj+v2e/VTU47duM+k
         5AZA==
X-Forwarded-Encrypted: i=1; AJvYcCVySil1haiIv2yYm8HQZVZto4/oDev9Z84cYk3CQENFy8Tca737Hlv5FfNceFCj6QlLpxP7XrJqgFnl32I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2/4byEg6LZbURDGDdRsqbX/pqjZrV72hl0zLrozMja16gH2J
	ogdruM/zs4nCGLCR0TJdWDTPDTwMMxIh3e4z/HcRmn9npzpOv+H4HnZaGrUwTB0qKKrKL9+dcef
	7U8ofPRfewRUdvPaMj4ln1U+auU5ZMNtOKEG+6p8enEO0J3ut8L9H/M18BSaykZnoaz0=
X-Gm-Gg: ASbGnctj2aWjh1+BuuikbpPHPlmJFffBgD0chf/jiYRdc2cqYTR1RwS+HH8fHKn5P/K
	vxgLA0W3iVCTfMemt8b35AMqr3boQ+wN0JZnRY4jEn3cy6WktSzk7CL0gLobETVd8ex2Lwb0X1p
	Knsp8YOGVJK+rsr4vn9wKRLeZ+0M5sK1CeCqNTNkFKJ4Dx4NoEbudKR6gl/Ew4YfIknHCEWGCaF
	6xWtr5GZxO75LYzyUvIF7T9NkGRUFUtjvrEc2xibaMb5+7HKNdy/ckkBAqoUzuPnQulykzqBlnt
	H33ZWDiqXO4evyz7hQqEjRDmlsaqDyarbQviFj4weur9zmT4isByckluoTHRKXEvIRUgmNR5dB6
	KN9Lxv/Hbrky8TvtWBEarjE7et1z67h46E4dEC0ayraEukOjQr6xH
X-Received: by 2002:a05:622a:110f:b0:4b4:906b:d05d with SMTP id d75a77b69052e-4bdae5ac1b5mr88562201cf.29.1758302669460;
        Fri, 19 Sep 2025 10:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEowL0VkIS55e+wrnpXk8ejFGWmiVu1K7CSpGZAvwocAzm3e82EVFvLe2rVUzxckJSDcYN9iQ==
X-Received: by 2002:a05:622a:110f:b0:4b4:906b:d05d with SMTP id d75a77b69052e-4bdae5ac1b5mr88561851cf.29.1758302668930;
        Fri, 19 Sep 2025 10:24:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a8fada4fsm1524487e87.89.2025.09.19.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:24:28 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:24:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: dispcc-sm6350: Add MDSS_CORE & MDSS_RSCC
 resets
Message-ID: <cujc27qvhzblxsvkiyn2kpyl2btkeysr22amuhpfhjlsvwfuka@ukzba7jz4ftp>
References: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
 <20250919-sm6350-mdss-reset-v1-2-48dcac917c73@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-sm6350-mdss-reset-v1-2-48dcac917c73@fairphone.com>
X-Proofpoint-ORIG-GUID: _AZNOzI9DjlLWjPNPnvFDDzqFOIaeJX7
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cd91cf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=S60hzewbzrEDFSkdeIwA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: _AZNOzI9DjlLWjPNPnvFDDzqFOIaeJX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX9GJo/erMC+qj
 ZOEIpkx3hRDE9nV/Hcm8QK7C7/8R0BDcZhD2GSrwTPvF7Dm5FzfMEFFQ4jhlcq6+buYi7YU3sCH
 o+NmVNYbF+tenwdxBNAN7a3PAmGOv+msWqedOhFOQPt6hY56gqoSs7Rwuq7+I1JK6/yomHmXg3f
 2byZbSOHogDzeH2goNhcJvBIb5FF58CHmrxFvlS9j42MTRf/0Cc6Fz6DOM6k+meFU0gl75OwKwT
 KWw1AChZGiYxmJfHnVg34Pnpz4zGfpWM2cjCKf0o9iJKg+GKuy09Ri4AuLJ2hAlmGXVEq6RLUo8
 wZpuwAjg1WKGn+VDyikXPtlP8wxUwVjkwK4b3ypuR47dV1x61TbDVzLZYHPnIeFCakYkO0rB8hz
 bV2/1w3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

On Fri, Sep 19, 2025 at 11:57:24AM +0200, Luca Weiss wrote:
> Add the offsets for two resets inside the dispcc on SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/dispcc-sm6350.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
> index b0bd163a449ccd2b27751e32eb17a982facf07d8..5b1d8f86515f251d90e01a4f3cb3b5582b5db683 100644
> --- a/drivers/clk/qcom/dispcc-sm6350.c
> +++ b/drivers/clk/qcom/dispcc-sm6350.c
> @@ -679,6 +679,11 @@ static struct clk_branch disp_cc_xo_clk = {
>  	},
>  };
>  

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

