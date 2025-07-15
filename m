Return-Path: <linux-kernel+bounces-730969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB3B04D16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7714A1176
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF731922C0;
	Tue, 15 Jul 2025 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKWnFbnW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99D10E3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540072; cv=none; b=DowUi2/Dq6mc6kwQoTZr0TgJQ/80kVP/YKXqCzIENGEznFotFufhDShWTyQ37CwSCTOVTk0GsUCRxHPLfhtSKfKF++raQI8ruhdOf9YrjTWXTD+0xs8wkzs6Czn3omzSeBS43tOO/6FUtqNL1wcmrQHgot5yy60pCNSCKJbBvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540072; c=relaxed/simple;
	bh=/fpeOpzdtrvMaMBvHjLFsNU8U+wmDzW4BOVzVwKT8Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJwbat8RcQ/rk0zuaiow6HemlRrQ39D0m9UGkiNyBdHDv95/2Q+vL1/F7E9n0EE/n5zRGoWpWmyLKzSb61E7rN1vh169IBLkQ/Vs+34DfoO+Sk/dibsAy2CkpvSgNcyEhE04NfrgnmMq3K4aUYP30hQ8lb0azzfdqlXoj6p8Ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKWnFbnW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGRkfi020978
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wODJleHZ+bVcBgLQTtzGXHzrVqiJgA68FlyszfYFYek=; b=FKWnFbnWGotIx8hu
	v6oXPGBfNGvBWCFQ0pFVoR8JL3g2qXR8CaoqHR8FF/guH4VNKz9xeLtxnmCjtn94
	eBG5GCYHF6lCt2IWX1rZZH7XiHBsym1PO+TLGOQEZqmXqcGNUNiBnjo4hJKVBNo8
	MQJANvaMixLhfBCf/+XEttcHmpb+dKvHUFloIi9aAAKRlDqrCGwsm5iOzaONXBWe
	+V3NWd/o4UNMuFzRh1E+R/nCI8FyRamHq2rqgEjavuAq0X3HuIPKXuvHSIqe/q9k
	TF2gyBByfsJsE+gBE/7Y7IUP3D8rAd4RkqIl4viv+7PwrH/4y/jiarkMwKkIAbk+
	m6pkEQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dw1388-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:41:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23dc7d3e708so28624945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752540069; x=1753144869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wODJleHZ+bVcBgLQTtzGXHzrVqiJgA68FlyszfYFYek=;
        b=PQBUPBnovpU5nAVa6Clbir82+s/ujyvigA7C2pOHNwHrnIQR4jDPhljlES0KSpqOP8
         jkQvFCSKhCN8MjfVkeJ8jV5q2i0NSyw3KZ/pHtmhBYmT6LbdftRVS8qSfbf15UmBrrGH
         SDstBj/scIUW+nUeTB6aDN8UqcWr43WLLhirG6K/jZu9p5zITpUM92wl05xT7IzKCcCd
         jaAFvJ6Xj/tfvu4JldYS4fGCtDN/FF1CM6MU650Ixcc3QP8vSqgKopwWlKwnRQzEM9Gd
         nbJtLzfOJ2/uaC8DjHGGjzHpVzlna5bmtIwD8EETktXCAen/xecgg9EZ3adyABGuVCRI
         SJlw==
X-Forwarded-Encrypted: i=1; AJvYcCXCXSgcKxxtXzKVHGUbtC89voOWWYz6n0EL7jomxICDhb+jNq0obzxJMWnK76prnJBwYP9p+37LOwSZa7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywei6wku3eJr99LOswu25/FPj8EUViUt34U76xJ6lnLEx1a8GkW
	1FI6+7YFzsfRlGlNE4ctFsiUY9meO6h6sFVeoiZ+wGTjhgHkORFV0dqCbNmMJUxV+NGya/XkR1u
	7V/OyIN700goSyI25jUpp0HQHB1B3NOj0f2k77Y8e+GKQymrXNpnp54OQ2EMbD0ilsa0=
X-Gm-Gg: ASbGncudoIAZxspans5aRX5qoAkdMHWF3ao+vIJ8gg+EqzHm6KWr52Kvdq1jgn1Jf+f
	052GHRx6jdogLHccPAsGwpbBToMVypB8QtI94sN/cCsPYBK0FQoq+2v7wNWC2Bw/frXSY9wWClP
	/d+xC4SZvb0myVHuNi8P7UzFgziQzwe8Rn2hLMFGITpM7ZlwPaQNZYpiOLS50fOO42wNDe30Nrx
	vadNgf1BoWi68OR2Zv5Xh4CKXfTXuHI9cgv2t7wLNjBIjsXA7IEu52FMYjECaWdn9CxxtB20duP
	+m/BPtiOniGaMLNPZxw3RTwpucdfZZL+YpWmen5XuQpUY9XHsQgNAWggKQDph2yYA8f8vutltF2
	nCugXpgeHu9keld0JFc/eYzbz
X-Received: by 2002:a17:902:ef48:b0:23d:dd04:28d4 with SMTP id d9443c01a7336-23dee2a0946mr248519805ad.43.1752540068862;
        Mon, 14 Jul 2025 17:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdmamRBVee1XJcy8VnXWvKBcAqzZnAQTh81D4R2wPJZjMPo/wxYIsxmLIYNDX5XWYHIlCWPw==
X-Received: by 2002:a17:902:ef48:b0:23d:dd04:28d4 with SMTP id d9443c01a7336-23dee2a0946mr248519485ad.43.1752540068456;
        Mon, 14 Jul 2025 17:41:08 -0700 (PDT)
Received: from [10.133.33.236] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4343e48sm98825605ad.190.2025.07.14.17.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 17:41:07 -0700 (PDT)
Message-ID: <c7cca483-f1d3-45b4-abef-ec5019ad57dd@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 08:41:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable CTCU device for QCS8300
To: Jie Gan <jie.gan@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250624095905.7609-1-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250624095905.7609-1-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _pykAnOTSJauq-2mwBhUu2yBIHAk_C9A
X-Proofpoint-ORIG-GUID: _pykAnOTSJauq-2mwBhUu2yBIHAk_C9A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAwNCBTYWx0ZWRfX1BtDy0CqLFe3
 83jC4kMUQ+zZzUtxr2mX49RCHNT4x/93BSsbFNMAo8aEdS9flKOmmzPWfir1K7q4G07yahadrTV
 bQLvfcHOvyRVUmMpjBx9y2dcWr3JOTGK1k4Z99Kpsf1mcWgG83gkyS+aFrZlTJG7Z7hPz3ZZpBN
 ZRTCxakzKLU5WfkifgirY4bbt5Oi/V2kApUTFQdBxZDFtUTtapTk17eAwDiH+n9jLYLswYvQi1J
 eRf2as1phT4DSDtxwxljduwHXpUM3m2JJr95ofAoj9yQ3ipnIT86OC3oDiZxU3iMMcPC4ACQumG
 bd+9QJlOBhd+Mg0CHZWaL5KNurJYkQ8lefto4bEoDYMvl6y66xMyzLfAewlj0Tj+fqqOmpsarPb
 GkHg3yBlbDs6Of2GAV0GCfpGJWGqJse7WgQBYc0wG/CmXAlTAzZJNrEiqPqLokIq3WanULgj
X-Authority-Analysis: v=2.4 cv=CJQqXQrD c=1 sm=1 tr=0 ts=6875a3a5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=fSwdLtKwHKkDrnzOdDIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=935 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150004



On 6/24/2025 5:59 PM, Jie Gan wrote:
> Enable CTCU device for QCS8300 platform. Add a fallback mechnasim in binding to utilize
> the compitable of the SA8775p platform becuase the CTCU for QCS8300 shares same
> configurations as SA8775p platform.

Gentle ping.

Hi Suzuki, Mike, James, Rob

Can you plz help to review the patch from Coresight view?

Thanks,
Jie

> 
> Changes in V2:
> 1. Add Krzysztof's R-B tag for dt-binding patch.
> 2. Add Konrad's Acked-by tag for dt patch.
> 3. Rebased on tag next-20250623.
> 4. Missed email addresses for coresight's maintainers in V1, loop them.
> Link to V1 - https://lore.kernel.org/all/20250327024943.3502313-1-jie.gan@oss.qualcomm.com/
> 
> Jie Gan (2):
>    dt-bindings: arm: add CTCU device for QCS8300
>    arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes
> 
>   .../bindings/arm/qcom,coresight-ctcu.yaml     |   9 +-
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 153 ++++++++++++++++++
>   2 files changed, 160 insertions(+), 2 deletions(-)
> 


