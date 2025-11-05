Return-Path: <linux-kernel+bounces-885635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19222C3390B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E3F3AB4E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B6242D70;
	Wed,  5 Nov 2025 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I7bZM9HY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TbXTRVba"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675223D29F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304110; cv=none; b=WRmFLDJ4J9olCI+v5XmoIwiGSkFV2Vi8TnIELz/ZrcmI0gMqp6Cat/81XGF5NLUa5WD59Zkk/6McWTq8hwvxqq0Lscv93SCaaA7GQIiIJKD13vk6069hhRJE8+T9jSg9Bing5o+qKRyhvwGlbA5jemCGnkJmnemt3nC3E25vrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304110; c=relaxed/simple;
	bh=WMtxXg6HXmX8zM7j02YQAbCGdgTWB8jnjJp35wcDprg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0cFqiMUvbL/qFMm2iomkccXJiHaRg7leKL3h/e+h4cZO3h3NJc1M5+tenVvCc2Otc1s60l3p1tRlifhKcP6OV3QKiv81KRxQp3//e46Z2JfMRiOJrq0P7o17xnsGHiaT6/oHbqWyYLmD2ISqwZ4xGqkFfMmncnO1HLjS8TSNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I7bZM9HY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TbXTRVba; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KgMiK3043711
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 00:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/ADOlbA/MeXRPk9nFlkw4G84
	15r9Bnyhb0LknOuL9V0=; b=I7bZM9HY10F5/GmUHmO4M81orXypz+0HnoGDjVke
	xukl33suuLsKLPZVAhzwXstnM65gkGDZ4p/ZJOvdJZvb2UtX7fiyG1oTr93fqr/T
	/zfRT6jE0ZcvZ6uBiTa7Qc0S0HL2+wG5mxPHPHPResg6SNHhOBeFL+wqMaLiegf/
	YW5geElDoK7n1j16WtdjJK+kLIAZ8NmkRtsW42Xcc8xBmBCoLgKiHa8u3WGJ6iPi
	a9CeyLMAch9cWC/gP+deVxRE25TwEJuuyQkMbjHQLnSWoNtq1w73Ca1fiVoX+YV/
	tk72Sd0cwkiP2AGz7TTQAnaL3IWz38lt4QfdStI7ctXu2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a78equp3m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:55:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88f81cf8244so2543406685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762304107; x=1762908907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ADOlbA/MeXRPk9nFlkw4G8415r9Bnyhb0LknOuL9V0=;
        b=TbXTRVbaVUmGyrG8wUSXaOm8IcpTRjMePgvmVu3IGev1jCkOEP9kNPK7XiWC0V8oTK
         UmGJ0NarcdkX3Hs2pafGTTEdcYbw/dfqm7yM02wS2VTCjuohAuzR1mchRB/XY2rbMHii
         p88LXnHh7FX/MdJYwiDy+e1fAfZN2cqPjtiyd0ZcMEZLZicyvkicXOW3Od+R7gH1WrI4
         XdTDDzxMb6WqeRNwockmcUXE2W22xM4E/oFGa/mCBHMIRK1blYVBuVL/jlTsYtpRd5Ks
         RdgbVQMLSSPmg8Q5FcqlstptH2/U9fA9l3cgqipMAf9+qhjI4iXUHD94U1WwSX2a2IEt
         CMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762304107; x=1762908907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ADOlbA/MeXRPk9nFlkw4G8415r9Bnyhb0LknOuL9V0=;
        b=DHs0GfLfROuVa5FtSDH3uEK6+uo28X+VX7E/hk8CBFC3XR7429zIR0BaQ5owXD1INe
         8IypNaQW3HRN4Ye4rEIC6XABV/H5S4D8yfoBKltVCzkQIkwy0pE/8BuEvR0B0hY+wAYz
         /LsJUb4R5s3rUfnWKneJrOkslfypwUfc1v0J5D2rJ47aQ/WSFDnvZEG0sU2Vn3fPv6h5
         t8fOs64hRWokg5hGpSUjcQs/H+3zhiCHOc7AsD4l9WMn1Z0IWMhfnN7mmcB8nMJRovsA
         S33UYFH/WbYLFbh9pQmVXWe6WUZMbyxzduiWC9xgRk99uwsAvKoeIRaPth0IUAicIX3k
         HtlA==
X-Forwarded-Encrypted: i=1; AJvYcCVioT7M9LCjYSakWWjtBgHq95nXkqRDZ7O8zAD0qVks6vzQ11Wd4mTdA9MIv/afdgMDN8QoHCwvn9J5mGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwxfVoB14eOMHt6kECUgRLoT4g4go54ATV+9zapI7OLJ/1ky4D
	t3u8kfNcUA1XVfFsZ9IOIgKhxzXx6UGCHMk1vWQ+tJuzOTijMN/qIqJWuR79ko5Ytmqg/HK6M7V
	nARbztQjZpScRCGhKpClQx9xlA73NIk+Wn33bmb+Rdg5Wr2S3iRr1awZ0J91SVzedSBs=
X-Gm-Gg: ASbGncstR5aezEJCVgnkqV95oos9Id8QhMjuZt1HkcCeIk0H0ouK3BOaf98IkfOLR//
	KSPv3UPUWsJRWHD8jx8RmcbTU1CuNYILUYAzbpreqgcvzXrTeWwh8aR2CAw3G5gf3y0xj9wY4oJ
	kLe2ybdPAOGTtufeZrcXFVX4bFy10HnbJkZO64Yl/Ea6O1KPDZ9OzWsBh0GSBTj1Bab/T1m9Q94
	UtyPFjYqLqIi0zVhqZwl8Ts1qKix+Htc5FKYyxjT7sKl8jPjgbKB5Se04Cj81z5PM47rJOV+Z0x
	rl2RecBvthRohGruxLFQEf/UQENwveaxjiNjyrpbTOwfrCKCc6P8qhFYVBgQjLoXS0PSevZbPYa
	a424JbIQhf4xzpLRlx3UAmquE8HjR4xTqN97wd8HzW7QY/nidIqmb/1jnEULNuHZfUPvPR/NXCw
	jj8NnX2iUZXn+F
X-Received: by 2002:a05:620a:28c9:b0:8a0:8627:30b8 with SMTP id af79cd13be357-8b220b9566cmr215547885a.59.1762304106827;
        Tue, 04 Nov 2025 16:55:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl2T8MaBy02VcjmjrLLsEC09nXbRPXngYX5Uir3OVPaxk5ZvRsK2epgIV03aGzl6YxHlPzXQ==
X-Received: by 2002:a05:620a:28c9:b0:8a0:8627:30b8 with SMTP id af79cd13be357-8b220b9566cmr215541285a.59.1762304105532;
        Tue, 04 Nov 2025 16:55:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-594343911bdsm1169861e87.33.2025.11.04.16.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:55:04 -0800 (PST)
Date: Wed, 5 Nov 2025 02:55:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 02/12] arch: arm64: qcom: sdm845-enchilada: Specify panel
 name within the compatible
Message-ID: <neykh5ldiksowcyqomqlx7wwdo3jrofpn7cyndgsic5ckcemik@gngyem6bmdsy>
References: <20251104-sofef00-rebuild-v1-0-dfcfa17eb176@ixit.cz>
 <20251104-sofef00-rebuild-v1-2-dfcfa17eb176@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-sofef00-rebuild-v1-2-dfcfa17eb176@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAwNSBTYWx0ZWRfX88buWU9KMPQS
 PtS44I1bHnZetP5bP1L0ZywnxajvBAJhi2ysFw1bmejgRXgMZYnrI2xgsbi9CK5Nzd8BS0yJr8n
 jwWqWJfCK3/V4W+otO/GfQ7rlkQPktuJRbouw9FoJtIKtczX2BSX9aXlB0afNzl7z1vMvUgsFM0
 RFirkkgW7i/o6k8dsEgpCk7oAh8BxfXOvK0zAh3NFcs3OOSDqQVUBHib2nBsmtM73ThDGEdufQV
 QtU7vK3QbU+MtAG0AWHvHHDe5XriyxQ2AIXN7WjP0AxOJPVyz3oL1OYSMh6hYIz8IQXvPjiYB8K
 BXCVRDWj9GGQveHPRmjDXISopRH00jYJ+sYDZl5EkbXUgqM+SFBnBww+YD9Melnu+eT9gO1Dun5
 Mt0sp2+FZkqzGxwu9jimoL8cBOGu1w==
X-Authority-Analysis: v=2.4 cv=fofRpV4f c=1 sm=1 tr=0 ts=690aa06b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QsaZCVNBrwfq_IZkOpQA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: fRvLxb02NVQComMGcoM9hHEOcEKVdW6c
X-Proofpoint-GUID: fRvLxb02NVQComMGcoM9hHEOcEKVdW6c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050005

On Tue, Nov 04, 2025 at 11:16:10PM +0100, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> sofef00 is name of the DDIC, it doesn't contain name of the panel used.
> The DDIC is also paired with other panels, so make clear which panel is
> used.
> 
> cosmetic: sort the node.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> index a259eb9d45ae0..8aead6dc25e00 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> @@ -31,9 +31,9 @@ battery: battery {
>  };
>  
>  &display_panel {
> -	status = "okay";
> +	compatible = "samsung,sofef00-ams628nw01", "samsung,sofef00";

This breaks the ABI. Please describe, why it is sensible. Other patches
should describe whether the old DTs will continue to work or not.

>  
> -	compatible = "samsung,sofef00";
> +	status = "okay";
>  };
>  
>  &bq27441_fg {
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

