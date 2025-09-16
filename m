Return-Path: <linux-kernel+bounces-818535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED58B592FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988911BC164E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F32F7AB5;
	Tue, 16 Sep 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClHK62Cv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C22DC76B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017429; cv=none; b=T1Vjqi7LBCpyG2+PJ/moF6kPdgjgILhWc9Ao/fnKhq0nORVPg9BVsM0GYP6LATrZ25B5zOP16O7ag7Q3/uA5p90MFjz7GQsnDGdSHPHxf1TWVyYGXSqLxMHlGeXpozUbMXCKGl8vGNMLoetNmOkUrfr27TBya07QadLQEMig2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017429; c=relaxed/simple;
	bh=XbVFcqCWViC3Ty/3Z0wTLN06tYYojOW9npjz34zaKWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxwXJGZFsgiMnihs0DLvDY8z8ta6/71PrDpOsz0kD5AuKEIlE3NOzPLVX8PKAIZSK7ygt9p3bWJJk8JTd6CQeyTGmvvuXwjRW5UIyp1ztXlv5EkqmxqY53Ovxd6H8ZU/plXxIH/IVSfk5Rdh+b34GfjLbdBKI7zQYR5tvhshF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ClHK62Cv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA6CJI013393
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wKZA8BPl5AnCLEV2joJ24RdF
	tVw9jv4aVixR67Q19MY=; b=ClHK62CvK3ZDTQyUBb8sTAip0ggbSrF2CZpplJ5x
	kO5ini0JvfXSEuOy/Lpkb+DFOFY8lTxJaIGNYgOa7plJ3Xabo/CJ6WGBFN4D2DQn
	RkYRVLah6rRN+eEVLwJsRZY6rNYvjfClgFgKNMXrlAQCdr8ECZd3z6uFXgxfHCiM
	mq03sRBzh2eBtKC6clanyxDxRY85HYJCXhJAyV2wgrrgkunjnFz0wX58aR1Phngy
	9x5aD0uyOCb2jV7GwMq9IiTDcL13t+Mw0o/SwEACbgVeuihHe4q7CXUkZCOMMqca
	udi0dvciKfes0syQg6dB6iKhND0LNku6ga7hvCS3RbhN3Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5askfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:10:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7829c46b2e4so45123356d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017425; x=1758622225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKZA8BPl5AnCLEV2joJ24RdFtVw9jv4aVixR67Q19MY=;
        b=PolvQtWFQlDOVOvcn8AMYzKVsWPYf2tu/XeWnZHDTUeqY/Q3zozuVv3+zhvrrjKmNg
         BBOrhvLd1SrfiqWlBzg0PD1jVcjlMS3fI6Bu2z10qdAQmnWRiwoMxwAnosXohGRE69MC
         mWp+lxA4Z1CyNvoB1Mrv9igbu/kZgfS/Li9AzJ2r3Z1Efq4NMzhzSdDe5Da+uuG/Iljp
         xqDMQ5Tiioc/xOQJB8dCxBwhvpgmvUZoXWTjcJ2iid1uMYWsUkmeS0a9gu1N2EPbCzWe
         L+P7xbBXPLvhiUWExAxqOSNXR0lv6qcIe08nuSJId4d2b6a8lkcUuMEg6wxoCqrVV05J
         /9qw==
X-Forwarded-Encrypted: i=1; AJvYcCWCPHqAeIUgBSytaW2FGLORdtJ2vP4ukAEtpYoQl2gs5Lndlu9NTpHYo7vdc0nyVkGQmJjK7e1w9PJl16I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFRdpsTtEsd1G6CLTyQniJvMk6AbTFxfr9rU3y5pSWQ7my/j3
	g3+UFleLa4u9HjCB2KxQRle451cC4lD5MBJr0/WyhT44WSUEYZyUvfrXRVXAZWsFJBqIVPP8hUo
	PrrWpWXQ+gf3u11F8qmA74zvBAGw9ATHdwcoBER6ozwFYb0BHKA/08ihsscH8G92bfTQYEjtR+f
	4=
X-Gm-Gg: ASbGncvGaNwH0ulmhZ8Z+RCLSKmr3HeXjjbIyAeRy4fZmAM43Ufmp3aNPHdZeHAeXkq
	q3RVSNoGK5fJmtoynOtdQqnbYRDeuBmxDf/VimEvyv3mVQEMlPthdpn1QZZ4uuYCkxLBijSbGwM
	i+II9NwYA88VvXtdg6iRMiDZJbsrVZzYm/rUO645Vgbh85HPosOtcwcijYE7p17VBBcp5k2rZf4
	25hLJnmlL0OPBV0V5xAkOCCo7s+6vTX3XYr+2dWKWFNi4tRsRpKkKLdRHy5ZwNcL66KYQKJ4Np4
	boZrZQj56tzkzmo07vZQlCclcXqs8Lm7ZPSWIvVC/9uQqo2Gvf16gAdoVdKW/8/dhYgZGNgd8/N
	jLBxtAfWZMOTGOQEq6C8bAa6UVTF7b7y3PnWqLzGG1wV3E55qzhBC
X-Received: by 2002:a05:6214:dae:b0:78d:4b58:2eca with SMTP id 6a1803df08f44-78d4b582f82mr20475136d6.26.1758017424833;
        Tue, 16 Sep 2025 03:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1ZEAVjtbKX71iAiDJ19Ofyo+pVaF7VLXJpCCJ2aZl++ji5oAc1d4XKZOcSuQMCS9y6Mh/8Q==
X-Received: by 2002:a05:6214:dae:b0:78d:4b58:2eca with SMTP id 6a1803df08f44-78d4b582f82mr20474886d6.26.1758017424433;
        Tue, 16 Sep 2025 03:10:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e651919d1sm4386662e87.126.2025.09.16.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:10:23 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:10:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm6350: Fix wrong order of
 freq-table-hz for UFS
Message-ID: <pjalx3o2lfh3g6fxsaw3beir7ufpls4j5y3f7zdsgopvpr4vuc@5vldxr6lvojs>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
X-Proofpoint-GUID: 0GvfBp5c8XnAZ4PvgOT2_ZA2n93S9Ak3
X-Proofpoint-ORIG-GUID: 0GvfBp5c8XnAZ4PvgOT2_ZA2n93S9Ak3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX2f0Jdn4rDK0n
 v0w/kpu9R0s37qqB2J9vgO7E0pxE/DU8/SSm/p2V4gHXutqmhmbL/cr+5f9UkxeQI9Q+aRqS6Vt
 DRKkCQ6FXw2VmEXTarJLEh83s74o5veqWv3fAS9ItjNShbBWY4u/NUuo7AwHNUkhaUp1pwo04HE
 T33MQEybjxWUJZmicw+9LAtx/EYs0hq4+BlRbGueS2J8OqBRdh7GmnwJtq6ZmkmPDH7hHSH0K7q
 yaZNzABTrjdK9FDTiAJyaxuX9g0BokyuHbOwYW7wGaoP2tzYYniy/dxUGxYjZuHaFrNy5dnus3m
 dWXliQBo+pt8Uu8GmUz4V2TfIa8HnGOdMOoIVoDIMcdQ1+UcIalhUCFFw48VlqHd9weDb4YBGl+
 mZHaYoZ/
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c93792 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=08tnehPgh3LRQT3fcTIA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

On Fri, Mar 14, 2025 at 10:17:02AM +0100, Luca Weiss wrote:
> During upstreaming the order of clocks was adjusted to match the
> upstream sort order, but mistakently freq-table-hz wasn't re-ordered
> with the new order.
> 
> Fix that by moving the entry for the ICE clk to the last place.
> 
> Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

