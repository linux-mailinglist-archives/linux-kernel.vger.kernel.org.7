Return-Path: <linux-kernel+bounces-765038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267EB22A73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E21588032
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A92EB5A6;
	Tue, 12 Aug 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwBTCCJ8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC772D46A2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008483; cv=none; b=MKZ6TYEGfeEwXJrwlsJr/EpU0S7dinKDF3j9C/tIjUdELSPBlRU30BGaS5fl3XqOAjrXZT+hbBO+qvzcdVmhghQIkq6dL6D8TZRkfFYGd01CDJ8VmqyJLkQWUznvcdIQ3G+W2C3jc4r2szFDXdyMjBAim165+lgzXS2hoAspmIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008483; c=relaxed/simple;
	bh=gfuHTagF17Ec8Db9LA1xP5sCwdVtVM7nvbXpiYZi7SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1QKCDDRBliq5wBpx7AS62qcZ5L2u5yzhdjCsbvAGNX9+nKkFGLl2yKy12NF4cRYD4Nl+QRM83EwX0CnzwC36vri7Kc4gZYGiLl9XM0zrS8RWgexWM/Axbg4IKItYU/1utKrTIOPFX8FHCqvlXOjdDCs4COr4dTeWpFfBiTuqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwBTCCJ8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvisA021066
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n2CFaYge9d+yp8oBGPwz1QQ2VOoJSFwhIkoJHoNOR8I=; b=hwBTCCJ8Ubj/xMZ4
	iOxebIVMvJwPA1XqQP457mrT/r7lMWxIi1nFK+G1cbsW1WimYIEVq4eIZKPQzJ5U
	T3RQLKGYX6+22O/+1D72phqJvOScVB5zVo53VSEMxiwxFuJPqG0kk+yaqWkdNA8M
	fyUeamHICyhXnS+l+fg3giqYlJBCWPHHy8rT4AdZte5EDbVqxH9FnPRnSyRI0DJd
	Kvm3m4xILVNWJkkaIsPlRYGVAxT4JY5Xwsxz7woAIUzo/8/Hg1vCSgNrjj9YcLc1
	kKOSC10A2zPIz4CVODao9Qq09ArSlIABUtIJhk+u/U4sZPTzi8tElEEWmx4C4Lo6
	oioGKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6m9ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:21:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07ae72350so14398571cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008480; x=1755613280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2CFaYge9d+yp8oBGPwz1QQ2VOoJSFwhIkoJHoNOR8I=;
        b=NvTaOWcAx+Rb7TOHotkBxcQtGVVkvZ2ut6Q47bXZ56Mr+qsjY2s4O/C3XwhF9/LvrN
         qbqVqP41Ub62rh3VghX/Hfw3IJt0sE7VV+ONWUFujMIurXtFPKTCYWc+J9vAxrJsTZww
         muEbVSLW/xGZdZzHxe/epcMoAh6aSo/XeLkww1UZeDvhv7inSjRNGObClTLn0pmTTDM3
         F/fizyaIplO2Djqdu5WflJ1OqwXIjB2MfgkgiYlTnSHa7lFJ4NQbyw0BvQaPcxNr7wHc
         eKAM/mZ8SH/yfzCq7Hy2CF1h6/k6+XkUwJ9VnL/Z9/Yc07eG+VwBpG5tmass4Eactie1
         e7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCX28pZL5Y2K1bwxQSvfrOldd0p3f0LCXhWpRZ/GiUsJ0Mo5+8nyvhgN6Pr2QWx8bCSKHQvD1LMfq4pQr8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnVvEWbh/eAK/bFl8wdhc3T3ARXXX7WxKbjyUlprW0Ow/7anp
	dHk8FqC35hD4UL/yRzEm3yCGRh3O6Ec4G4Dv/HwT30PHskeOgsWAw7vzBo1UqPVV/DS7oaETL+z
	cZ0/fpxfc+gZCXKza57NHjl9X25rXtUum93Xl5sOSyVqo/Saasqvq8WPuCbqmvro6yGM=
X-Gm-Gg: ASbGncsaDGamx/lugcxc0S5YMiduWU+LMlkXP2XhOKeQ3MaTZh4j8Y5COVVxC90mujo
	Z5G6Cgfc3LzB7ge1uG4FgK5XDoCc1WXYHsZZNLLqq0bO7/1DmcdTm468aD/TDS2YlrFFWm8a+gi
	yvy169SU1gQTLyd+TtUboxWb36gwop3/IPQEQhWOulqnBbgQn6+0mDwS98Ae4A4M/HOtvCoddPA
	cq/zgx299XO5UGUOvAvcD1aa9SHkiWruhHKaP1XMbNjBx1Mo2VmveQQcj4PJV6KehN0ML1G0NYY
	sHLvb9b4jAhG2ZdxuobTvKzjaj8wuy7AjzmG73Jf4qdeWfOHtFhuYCie
X-Received: by 2002:ac8:7d46:0:b0:4a9:71b9:188a with SMTP id d75a77b69052e-4b0f6018279mr8546491cf.6.1755008480002;
        Tue, 12 Aug 2025 07:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvi0YztLn+CDmiojczoRdgEFlf1XLkiuwgJAb6OHV8JUzQolkq39ajVYiwmX7PvKoHQJys9w==
X-Received: by 2002:ac8:7d46:0:b0:4a9:71b9:188a with SMTP id d75a77b69052e-4b0f6018279mr8546111cf.6.1755008479436;
        Tue, 12 Aug 2025 07:21:19 -0700 (PDT)
Received: from [192.168.43.16] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fb8bsm2186132066b.123.2025.08.12.07.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 07:21:18 -0700 (PDT)
Message-ID: <e414163e-e171-466f-965d-afb9203d32fa@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 16:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
 <20250806-b4-sm8750-iris-dts-v2-1-2ce197525eed@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806-b4-sm8750-iris-dts-v2-1-2ce197525eed@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX1JuZ4KXd18x2
 XUtFU45jdTiAcxAidtIxO9Y6nwAJSiWFtx/rubO8bjTYpMaRHu0LloG7WTpglJ8Qgb8jfjfwC6u
 moRvJPVjWmr6F7tIgbSw0CRghjqTA7nASdC62wNbzjxMv64nVf/MfecG7N5d6Yf4ZXF5/FYDeuq
 sXNEXFu3Sz1BVMugZPmm07bJzOcHz7kdNTiSyvgDTcanx9mJHPogwGxvREqrzPupsGqOrYI96Tp
 ACxgPr/y3H4pA61qzYBjp4O1nYPQIEzkZUSkYmaZgMto4dTTkcIWtM5VRDqUtCzrXfCtehoRUlp
 Lp1XPWxweTfuf1oL4thNgGzvo4idBuEEcc6/jV4rEht9PbJ7zk/EZMmgsmZikC3bSzclZnvfcum
 sloQVGh4
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b4de1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=OjNCceoZ-5M9CiTWRqAA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VZS7J_sCSSRQzhQJTWmeaJ3oZqKj2yQ3
X-Proofpoint-ORIG-GUID: VZS7J_sCSSRQzhQJTWmeaJ3oZqKj2yQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On 8/6/25 2:38 PM, Krzysztof Kozlowski wrote:
> Add Iris video codec to SM8750 SoC, which comes with significantly
> different powering up sequence than previous SM8650, thus different
> clocks and resets.  For consistency keep existing clock and clock-names
> naming, so the list shares common part.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

[...]

> +			iris_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-240000000 {
> +					opp-hz = /bits/ 64 <240000000>;
> +					required-opps = <&rpmhpd_opp_low_svs_d1>,
> +							<&rpmhpd_opp_low_svs_d1>;
> +				};
> +
> +				opp-338000000 {
> +					opp-hz = /bits/ 64 <338000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>,
> +							<&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-420000000 {
> +					opp-hz = /bits/ 64 <420000000>;
> +					required-opps = <&rpmhpd_opp_svs>,
> +							<&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-444000000 {
> +					opp-hz = /bits/ 64 <444000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>,
> +							<&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-533333334 {
> +					opp-hz = /bits/ 64 <533333334>;
> +					required-opps = <&rpmhpd_opp_nom>,
> +							<&rpmhpd_opp_nom>;
> +				};

There's an additional OPP: 570 MHz @ NOM_L1

+Dmitry, Vikash, please make sure you're OK with the iommu entries

the other properties look OK

Konrad

