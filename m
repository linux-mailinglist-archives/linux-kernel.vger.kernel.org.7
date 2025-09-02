Return-Path: <linux-kernel+bounces-796377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1BB3FFDF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A1C17B8B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87D301030;
	Tue,  2 Sep 2025 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+/dY4wK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EA2877D5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814839; cv=none; b=Xm3WpHNHZvzL5v2E7kYvWfdAQlQQVxSQ8AjoGWTPhNXb6ZubO7sHpLJeHaDqluaOEsY5OLUEOdXxOjTaETMb8x4v1FFKj084x/l7cq9fBxubeA3blES+B4uKlQXNLC1WWZURWusg2JFPPqjhPqf4hwl8GSqzyOpVvIRHv7SWc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814839; c=relaxed/simple;
	bh=xt2M/EYFY5LLWVrahB1ctY3E6iHAceS7dO6dEG4T8u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/7io+IInDLbAJ7K5JZEdygN4BX05QLIS9ibrYDnMjYOyK5678FiOFOYumW+4Yvp/ZeXvuAkOJ4D7Cxp0zB/pxgswxXa0fpgHo1PT0V69IBbgsZT8U6NKmCQX3U1IwaGguFsb2VV0nbStU49H+QzayzD12pwVn2yte1jcTiMZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+/dY4wK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AnclM016548
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooAgjRpTHNP8kFwOiUKb9Yh/50coU4iyP/eWLaeMM00=; b=C+/dY4wK+FzU9XOb
	4osh6w2fl+WAynCdo5SXzupLhtwkiwRNhcT3l6gtaar/Z3+ZahQMR39JtpSBSuG3
	gxQuAdzeJGV+Ju501Y5mEcDtJPK/cHL3vmZ5W1RBIGUEwEbvgI88sOoXcayivoX7
	wh4Z30+NyS1+BBhYBZj/RSmJA2+02EKmu/rZ0SpnDPeaEAZoqts7cXRdEAuPVuaV
	79xq3DTGKMPsbhnCubvOers1owdLoI9touOy0qusIc1eyPTfhfIc9s1wmc0QnigM
	6G37eyGQyuE9MTejZwjgz/pE/p7uYyCAy6OS3K/x42roEsPi54Y3boGKZb17KOSx
	IROvKA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyyprs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:07:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2d1c2a205so15957671cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814836; x=1757419636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooAgjRpTHNP8kFwOiUKb9Yh/50coU4iyP/eWLaeMM00=;
        b=GHWJv58qk3zO4NeeParCXWfBqI5L4kAUqaWc07Bosz8CLBXKUMnLt/PeuA45ZZxVQM
         MrcZuq/DNp09oXh5Gn5Tes6jXc3kSQzGxiXs/fFzDW4RHYPnANcWqMfp37tPeJt8emOE
         v9zFcu64J05w/3JUIkbXwFNyj3VVoAmkAXajzBh+kx2QUIyBOvCFTw0VJgUYlIRjDYnb
         GuWkqLOf6Jwxp71xpxZrX9PcoSIosuX41sxBz4Pd7pCWg5/o3xcVLtcFa0DEiGPAu1AT
         c9Au32rtt3qJdQFvVz7h3bk3nutf2h+KCWnwZS/MnrxWcQCcrrmVZBMZMejsYInUos7N
         rKKg==
X-Forwarded-Encrypted: i=1; AJvYcCUKXwcI5fEtDBumC3+XXeb2u1MwE8QhXSv6K7/4iSm9tkGlHsWHBjdWe3kUIEOQAb/3Wd0IGzpnD1x17ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVRiE7lT9SHSTcIGOBVWB9XDxTde03JdrrOlSLGKlvaWoLZKV
	UT0Zf7+80t+fN6JrzwnWk0j0AXuBcrffr50SJ0dEtqnuinwvbqnphBTcQW00Aw4SXb2khh5M5mv
	czLpFYMNYo+zVIAUlKaVh2/jy8/yfmiOwwVwJd0FNKDxXFpAT8vha3NMeJdUfcPF6E6w=
X-Gm-Gg: ASbGncskMlp6rz5mf2au6REKB9qlt+M1msbwOsGoOR1tnSZS2s0HGNOb21LIRqO7ugm
	NUm77/ANmI1EN1A9A/sBwVdhey0QRQhnBfOsnMvuEdj2aufhBurZNKeacgru7lHP5lwhD/QzS5q
	1ama5YbhmLhC0fznfuKHf101eu87zFFPwLwqGj4MHJtlnfivNy7idUK0RYdnz/ZlA305WdYCYok
	l74bBHIVkKR8Shy+OqR3Yiez0Ql/SytvWK0kqb4Sc06tgQWGL48YO5n1pvVSRSiGUfcWbynfeCZ
	q4GBJZLDhPqOZcCeTNms1z96jk0u+WVRra2AMuKrJiZKZVKu+Se+txrRDFB/Snk9XbGzkiISCBd
	nvg7d0VukDDdr1H/pfFv7kA==
X-Received: by 2002:a05:622a:164d:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4b313e6f3aamr104880871cf.6.1756814836110;
        Tue, 02 Sep 2025 05:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi7UgyhFAah0VP0bJeUSU1wMpek7APbVlPpwHN7xSB0N6vFLNU7Pjd9+3uvDbCoDIOTsYYeg==
X-Received: by 2002:a05:622a:164d:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4b313e6f3aamr104880181cf.6.1756814835494;
        Tue, 02 Sep 2025 05:07:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm9249215a12.44.2025.09.02.05.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:07:15 -0700 (PDT)
Message-ID: <e9c70483-8538-4f9c-9dd0-b4136b34a667@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] clk: qcom: gcc-ipq5424: Correct the
 icc_first_node_id
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-1-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-1-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: w8t-UvWk_rd1sFuMdpoo05gFTJhENxUy
X-Proofpoint-ORIG-GUID: w8t-UvWk_rd1sFuMdpoo05gFTJhENxUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX7+y6bU71NOn7
 d2NPTx7+Aa4tK/N6WGKg0KDVd3CJpfNH4rB9DiOUO3icJ7IWgMTtswm0FKHCS27l/20kge62813
 GIv/MJabrqFfHck6lt8LnasUpqAhlFtmPCHlDbKsWqyJyKHbvcr9NvbGaHn8pYk0Cf/VrwD+ott
 /7ZWdOsjq/L0Jf+Q+7hrWLyozYXgFu2fSvIzftj/QGCr6efiA2GEY6aUMm6Cc+NAHLGMX80oILo
 0UQze0mNCsYvj/IwaJ5FC8+Dain7BgCGicEiycwDyg40aV8uix/sP8dRNDJ2sJgRE9hhNVjZLkx
 jQit8gbU7NP9cjr7HmDlIR3K9daNFbdLxMF15lxVak+biY06ZRLlbqDN7MocpfF/xUdBAxj40gL
 9ZVWgIKc
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b6ddf5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5e-Oaz1CA7JNmZ_uPyAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 8/28/25 12:32 PM, Luo Jie wrote:
> Update to use the expected icc_first_node_id for registering the icc
> clocks, ensuring correct association of clocks with interconnect nodes.
> 
> Fixes: 170f3d2c065e ("clk: qcom: ipq5424: Use icc-clk for enabling NoC related clocks")
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

