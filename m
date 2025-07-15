Return-Path: <linux-kernel+bounces-731534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C39B055D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B7356213C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1E2D5410;
	Tue, 15 Jul 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHFOz9AI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06812D5402
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570329; cv=none; b=fNKXSS2ned3stakBLWrQKxogbdnyRWRZ7H+L9+j4d4ToPxOpuVm28fkxPW3KBFyp9sM8WPfzTOw7ExrqzOm9cEcOlKI5KRIwTpbSWAUXGwSMm5iNFG5MekWLM7Nb6M/R6ws9xkWj+qfjIh5WZG/PlG6RlMOECpgQefqFbMva1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570329; c=relaxed/simple;
	bh=5LBGdyccFs9/kSMj7gqptZEBRHBs0pXT46lCaRpnEU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ono5WQIUt5GuMIYVMekHwVFOBhYNr2UgC9yf1FL732rDy6oXqyVnDbKbpqF5b0t9TuFSzI2khycBPadNCpm66OnDLjXkSZUQBSMUJYh+ku09cMf1PVSNGbMgQXIAMP7hc19MG62DAXIg2fhxDhLusj4AwY8On2syal95hRNFXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHFOz9AI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3kQKS004463
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X81G8SbDQbSTnHA7Tq+qXCtSDHk+zyIFbzLI6vGMtbM=; b=oHFOz9AIM1QxzQ33
	ewK8BgVpjT41RVa6X5zFWaAwDO/Rjs/49yTkz4ZQNeGfIiYy19HRhgepfbXMGSjb
	NdRwV614x4I6+6FFV9v/8IfioYfJpWknS9PCpZwpgEylpHvCjBhigXd1ztrFdD4T
	KCEjKseMYNzvFjQl+aTv814m+5gmfTy2Ew0ZlsuQlk9QeaX7k+Phu/pUxub24vTk
	RYhGWXdtjt/IOirpLCjmU9JX6O/QLwJsQWkbODs6MgaK2m/D+xBimXvcfdjYlvuQ
	VAwbmaqHMafDZ9GS2jCSCrbH9okOP7lu8A4vRDRt6tLI5s4ARglxlLXw0HhV/wLk
	wRwtKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca0tsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:05:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab3ab7f74bso11861781cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570316; x=1753175116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X81G8SbDQbSTnHA7Tq+qXCtSDHk+zyIFbzLI6vGMtbM=;
        b=ZK4HueSHs6cMX9IOiIoSCWGk7LyxzMjIOuQg4KrgZGZT8ucfiZIFv1wohbDNHbil/Y
         ZyymTwn3rUbnzJQoF0IqL8NAZ+yAG2y3lnJpZgb4RdFcPmWvcKiMMwHx3r4bPaorNKfM
         DZxPfThj3tCQB93H+n20JFsLYb9T0ch8n6pFAGRj5dDHgQZ+IwBsphA+zqsyl4YDfdEw
         t7BfTpfIaFKo2zr8F04av2YExseZ1Rj36tNvt0mvlJJ2WSFTj/0i7Eo8XJ1gpeov+fsY
         53r+LQMadYb05gPduX8tDMqytSRXjNngF/T9g77+g0iYIC/LMSBkMHBo+KI4M1feRhgH
         6HUw==
X-Forwarded-Encrypted: i=1; AJvYcCUuNi7nPLKmUD4gUeDOZpud2nwgctLXIXeFoRrJ2Ww8QYYVQwyiDTEeQPJpou+S/8mWXtkdO08wZ8UtQMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfoT07tzvWfwsfsHvlQVmidYvu/1ecUUgnezUOpmfh6/KrzhF7
	VDOgfb6ugv6MvpqGOElmr57eC6UfBk3vV45h4zDMRYAHhK3JuCjPTq5ewnbVc5iJIfAe1rN45C5
	eveowFOWkkEK9qAeLC/DhthzNwHriHKT/WsOigy4WganQ5QhALykTIYPq+ShH7oDXS3c=
X-Gm-Gg: ASbGncv3+VRqUqTnCeUehLOn6HaXLP1sMOspeMxvAYCATp5JEy9HQ4tccAelltlDIMK
	6jr0Zy3Q1bLGGJUut5McgieXP8nebOIKucDfXfhHMvjldksdIJyQtn505B7GqIQGVxRiknTCFPL
	IMGyexWcceaUTmaCJGgNBQJL9S4os93EGgemTWYtzdurDIPzt7rwgv9+HUri1a580Lvlb9GBpGe
	smbpCz6RnkjtqrKSr5NDCdvbDMCR+MUry4d6r8/bJ+enwg+naGrvlfJVgnyT1PwHSr8rRgvkVDP
	lBeetng1EgSLPvI0YYo2FD5oZzUacqnqvv+aOzA2QeuCeybeJak7DZgmxSjk3lkqF7U80260zUJ
	T6FOG1DSnGLHW8fiLCGX1
X-Received: by 2002:a05:622a:1104:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4ab86ddc86cmr4932761cf.1.1752570315573;
        Tue, 15 Jul 2025 02:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRYFCf9iDFpvwNaUhwvFmnJFfLgW9Y1m4vlzwNzKWO0OxKFu/BJa6T2F1S9r+efZbKvvtpAg==
X-Received: by 2002:a05:622a:1104:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4ab86ddc86cmr4932471cf.1.1752570315140;
        Tue, 15 Jul 2025 02:05:15 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612067f7ca6sm4743760a12.55.2025.07.15.02.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:05:14 -0700 (PDT)
Message-ID: <03242c48-beb9-4ec1-8659-0cb8db9ef37d@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 11:05:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] clk: qcom: common: Add support to register rcg
 dfs in qcom_cc_really_probe
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715-sm7635-clocks-v3-0-18f9faac4984@fairphone.com>
 <20250715-sm7635-clocks-v3-1-18f9faac4984@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250715-sm7635-clocks-v3-1-18f9faac4984@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MiBTYWx0ZWRfXwi9CiUodR8hL
 YRhEiOQeQI6ADNxOUZkM6Jz0pQ3WUeKePMxC3HpNJyK2bTQQfbx5aNyukAYrcOy2pON3SQCX+Ql
 YkZiINlZzfieNti+gY+eQ1+y1qXjeLr0nJ2S22+LjWNvUBu0Ux9pvKuzmbb6ymiDbvFwXpvPHRs
 /G4hSKKwZtfauOObeaAeJ5JCS2z4rnxTbdpY/zEAsVuM92oUWcwxF0N28CZulmT4ui1IrN4UCuQ
 95Hv+GcUa7T8Q8Xx/NaoBevOOtikAfpgPzvw/XRzv+RDpEHsV1pLdGMWC12WH3jPnRYPgYiXhaf
 RaToGYjHE3zolqLMpNHF7JYipdP168iR9Jkn1QIONpHf6h+bcTUiK/HuXSceqCXE4Sgb80cp+of
 rbr8jmIDIjOO/7a2NjYcD7xcnAvTTySp1UrTWx3pLih/kYpjvnoMurbUpcaeXsWHY/Z7PGE8
X-Proofpoint-GUID: NbC3iMI7zfPENZlRudoZbIhUHz1B8LYu
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687619d4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=fWT5Z53OPIsgueDaOEIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: NbC3iMI7zfPENZlRudoZbIhUHz1B8LYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150082

On 7/15/25 9:19 AM, Luca Weiss wrote:
> Add support to register the rcg dfs in qcom_cc_really_probe(). This
> allows users to move the call from the probe function to static
> properties.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/common.c | 10 ++++++++++
>  drivers/clk/qcom/common.h |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index b3838d885db25f183979576e5c685c07dc6a7049..37c3008e6c1be1f083d0093d2659e31dd7978497 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -390,6 +390,16 @@ int qcom_cc_really_probe(struct device *dev,
>  			goto put_rpm;
>  	}
>  
> +	if (desc->driver_data &&
> +	    desc->driver_data->dfs_rcgs &&
> +	    desc->driver_data->num_dfs_rcgs) {

I suppose the last check isn't strictly necessary but it makes
sense to the reader so I'm not asking for a resend because of
that

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

> +		ret = qcom_cc_register_rcg_dfs(regmap,
> +					       desc->driver_data->dfs_rcgs,
> +					       desc->driver_data->num_dfs_rcgs);
> +		if (ret)
> +			goto put_rpm;
> +	}
> +
>  	cc->rclks = rclks;
>  	cc->num_rclks = num_clks;
>  
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 0f4b2d40c65cf94de694226f63ca30f4181d0ce5..953c91f7b14502546d8ade0dccc4790fcbb53ddb 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -30,6 +30,8 @@ struct qcom_cc_driver_data {
>  	size_t num_alpha_plls;
>  	u32 *clk_cbcrs;
>  	size_t num_clk_cbcrs;
> +	const struct clk_rcg_dfs_data *dfs_rcgs;
> +	size_t num_dfs_rcgs;
>  	void (*clk_regs_configure)(struct device *dev, struct regmap *regmap);
>  };
>  
> 

