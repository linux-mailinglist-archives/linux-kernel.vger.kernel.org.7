Return-Path: <linux-kernel+bounces-838633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84DBAFCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13543AC660
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74722D948F;
	Wed,  1 Oct 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LblUTOVj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E1279782
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309785; cv=none; b=YWMSHFVWnR3yAg5vUYWFHpJ6IsjktHiOvEgS9ZnJIOenlY0plWboinxYmxMRSdaS97y1yqbK4WhHZutAuD4yOZukVggtb/bE/otiVXeA6sOWoDNH/hIYBOV8UckrjNzUslNFKcLU87/E4aan2/WKyTfCn3VaWSY2HkwmjZSP8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309785; c=relaxed/simple;
	bh=+HHYGPpeXnQ0rGeEdDhox9U3tmQQlISDNk9LsTxwKAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcZm8mC1LBQHELtJeXPcv5/GQG7DEn7R82oC2wE4aTmp/mpU/rfOKEUpPBVvb3K80Rn550tBlCEQe2uCvoRbe2VulweTx9yNQQgzgHzp8+B1HFBUcbooqrg/d4Ag/ibpYoQxMCAPmsbgKwkUHyBK0Wrnnvpf6fmfpdQKC8XXMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LblUTOVj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59193i1b023782
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E82Q1fCgbKcjzYtoOPTrK6nTOyj3o0Ro+K82VDmaYY0=; b=LblUTOVjcOqLonBy
	2cQKJff40rYAeoJFSq9eJZ7YuIYVP+VM0ScLRQrw3i4Sv9vWi4Vnp0EifNVFCE2t
	rFCvItBWeOsUY8Wp6zktnHCdfPmtUrARF+XjFwyUR7zP2che1QzbTAbNzh23YWvH
	nOHOgBSeGV9taMqX7bdYlu1uqGefGQQ251T6lC/1O23gmGp+PkbtFXvDVFQTQrJT
	XBl2JWyYkFkl3lRWAy0nvfdheJxjeqzAppfx3LGSpXhoaOSKzzZselR9KywWYEFd
	FHMoSdceqnyh/NbFB+unjbbx+Ck7y6z2bGtYHZLpfusRzEj0/x9P5VvxsJJDTlNs
	wgGZ+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n4cdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:09:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-853f011da26so262536585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309781; x=1759914581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E82Q1fCgbKcjzYtoOPTrK6nTOyj3o0Ro+K82VDmaYY0=;
        b=RclV/r195mgQ6TYHhXNLslXsLHBVcEGRjXEOc/1JDU+KomT/uxmFDGq0SaR1znzpMY
         mJEIzBJIVHO8A5rVjF2weBI9B85N4hjz1w76XnlzSvL8+QabWrWaHEnql96tjm1dOJfx
         XuBUhQD7XOqTDlzkKxvgNUVJPy0OzLDfz/CFaXBNij++PksDwRDt/WR664fyVqEw08bi
         LfrqXbhZOVO/iHHNEDGHXHNYrq0KsKScWSnjb8PdjPteiCGObzyi8sdUyvrwwLbDHu6I
         gBnZTTjapOjeDKZDdMgdjDFzAT0Xo3ZG4xjwyousP9h9IuN89gEJ1RpczGBtU634Iqtj
         X8zA==
X-Forwarded-Encrypted: i=1; AJvYcCUAY+xCb/xODNaPLYcx3zn/5EK42Mg7PsjgVUdn0C/EgmXxQEVnHSB/1aygQRwU3lR2H9wtTZL78Zk+eaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwxtuMwAn9Fjn84KfPaF9dRwsJwSCspcoR7GgdFRNY+pMN4TFU
	vKVb2R6ocjbYQ++TZSrzU1Ll8quEIwvea4uga4+FmirSlk1K8Wq29D5XIzHMMH9MBf2UB3oVs2B
	2eBkC/DWEF4/JlCga+4YvSXkVrfD0pZMwohjuq/utvEdy4WNGbOpjM5E9lv+JP4Ip0zY=
X-Gm-Gg: ASbGnctHYE+UNSmGvMqDQifJcjVhOD/u4FIjE5IMCLP83JUOny/KdYtFaeE3rMTyKkS
	qdSxqUr1zJsxfYT1CA1cMax6CR/2avH9oLLATmWErS9vVWrPRHxsXhVAKfHBXzyvt1XxU93HU/Y
	fxVXpPBpauHBm5787d/qUH2nPBZS2WJSiPPYmpgjmjZqeE0XBTC+/nPcIHfupIedZ2FYhEZ4Cxt
	85MEgBUN96upflQkEpeGwBOIx98X0JHxBDWc/L8vbnRh6LfLAZKt8pCuD+8JBpdqdTaMWCt13Th
	qpNdTsZH9skFDuFAsJvYNtJ6rrSf7c3hdgN8D6sqgXwcYmhOBL9CdWycZkGEScSYIdkgE91kdfi
	UzdkO3kpq/zz7za40OpZOBaUEq48=
X-Received: by 2002:a05:620a:1a03:b0:7e8:584e:2de0 with SMTP id af79cd13be357-8737191ad41mr268179285a.4.1759309781441;
        Wed, 01 Oct 2025 02:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOW58vPwLh+tGQM7l3TzbUzpwSb/oYqYaNv7HwrefqZNqpGLSvcy5yrdvHVrhJZhiT/a20UQ==
X-Received: by 2002:a05:620a:1a03:b0:7e8:584e:2de0 with SMTP id af79cd13be357-8737191ad41mr268176885a.4.1759309780852;
        Wed, 01 Oct 2025 02:09:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f74fbsm1336674366b.51.2025.10.01.02.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:09:40 -0700 (PDT)
Message-ID: <38c70e06-f7bf-4ca6-8fe9-2a4012017cff@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:09:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] arm64: dts: qcom: sdm845-lg-judyln: Add lab/ibb
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-10-b14cf9e9a928@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250928-judyln-dts-v3-10-b14cf9e9a928@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ua2sDpbeeLz2j6t_dGtaBTEDeCH0FX2I
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68dcefd6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=Gbw9aFdXAAAA:8 a=cJ-VQTIiB2pID4zbgQMA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: Ua2sDpbeeLz2j6t_dGtaBTEDeCH0FX2I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX86RbfqHnuayq
 vTyblU0V99hT1RUudfuBdN6KkVZsg0mnrNCA2LsZjWBvJbo5sPkdb6Bqs3kREy0qdSi4snlMquh
 AOYrmNCJ1kTwXJOMMJYE1TK3Vh+lE3EEY8uPQJKT4/iQLzT+cguhf4G4bnoQ6lFWdNZMkJ3f5ET
 gwUIhupU25XpTH6pOHeOY/7U/4X0vSBU/4uWTtFKDTG4PbTVsDH1zWSxkmKt1Kwz9JNQOyXcv6g
 hO6Qp3TNQYEsZKKXDhzNAhpvic5SvTxGNiyH3pVbYQvLp6nwRe8u8fvza7w1piRJ+0KSL1pnoMO
 6Y5uJyA34CKN7fZMbOhP1ZKaxgDq2N6t9NzCWbpCrZBdUvwhJyBava74sU87s5MyG6bgo5XZxh0
 YdmL0k5Q6+R/eG5Z0Eh36ueQ++i/nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On 9/29/25 7:05 AM, Paul Sajna wrote:
> These regulators seemingly help the lcd to work better

Electronics generally work better when the required power supplies
are enabled..

> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index 3106fdc9b679bc6a43a1a490c61b73a63003f7e1..9c3662a3d93e124667474753e0f11d0e98698aa0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -48,10 +48,27 @@ zap-shader {
>  	};
>  };
>  
> +&ibb {
> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-over-current-protection;
> +	regulator-pull-down;
> +	regulator-soft-start;
> +	qcom,discharge-resistor-kohms = <300>;
> +};
> +
>  &ipa {
>  	firmware-name = "qcom/sdm845/lg/judyln/ipa_fws.mbn";
>  };
>  
> +&lab {
> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-over-current-protection;
> +	regulator-pull-down;
> +	regulator-soft-start;
> +};

This patch will allow any values between 4.6 V and 6.0 V to
be set on your phone, with the kernel defaulting to 4.6 V at
boot and staying there until (if?) any driver requests that to
change.

Your panel probably expects a *very* specific pair of voltages
and any deviation may cause unpredictable consequences, including
magic smoke if you happen to go over a certain limit.

You should most likely hardcode that specific expected voltage here

Konrad

