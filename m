Return-Path: <linux-kernel+bounces-878061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0FC1FB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9B41A23D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C316354AFC;
	Thu, 30 Oct 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIX6zeQg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ThQLHN9t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2A35471E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821999; cv=none; b=QBzr8S318Jil6X3q+ztaGwsTKXQxFvbWzX3cEYVZqk+eI/Wuf0ZO24LjlQnVGyJ+cpQVpivb7bywdYyjk3IPpguPDYPEfyQsyHgi0mPCwt3hVb8P1RUdM/XWiRB9rTLoF38snvRA27pR9NrnQEJVSJ2dBSg3rD5omt6ocOsip4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821999; c=relaxed/simple;
	bh=goIcOyK65O4TgDX8/vKQnKMbI1joFOw1m9UymKJdhsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCybSIIIqzIeMqALrcPV05Kxcd/mVv+OJWyGf4yPjAvEpF0lGIsEHHoQW0paaimn1Sz4Y3nbn4mPSGFTOKkNR3/gORbYr/fYDoOMcKUQEA0iVu7Efc0CgRixh8qXCVyX97iZzetVvNOHaWYXiNxJU0JTM/8G0rIRUPHksHau75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZIX6zeQg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ThQLHN9t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9MXOd3115524
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u4Li80aTvp/g1w+wUXqfMhurwLUlh+lPbBgOPzmRuh0=; b=ZIX6zeQgyJ2gorIw
	ATy/MgBGFHO/mwzXZJGzcs4CMUYAxUe9f+GPwAuT1kY5FXKBD7POXDuErLZjlInw
	+ZjLMZfm4x7GZN2p2WevCjF8LvEC09C/a3Ud2/0zgkFJ67bZul7JkKlyOfsDuEUe
	R7f3w3Nh5jm5M1xAl9u8/xNn+T/GFN0FOIAbf6YnPM+xPjDxTVXTXn8yBE2HsbPH
	8TPHaCm3eINx17J0YP2ascCUEksQ2ayt4ETLfcHkHNf5P09UOXNfr7d3/n2aa6Vt
	hp8PNvRC+n/aLoaAsnZMz8tuc5ebMtqqZ5/+XuiivnDTfqNhLAF7i2pNXGIH+gVA
	e8PXKQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b409k2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:59:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8934ae68aso2153911cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761821996; x=1762426796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4Li80aTvp/g1w+wUXqfMhurwLUlh+lPbBgOPzmRuh0=;
        b=ThQLHN9t2mKjd0/cvjD5eBb2xMTQx1Nmruif4G1Qn9GBWyMw4/Wp9Z+tec5Sgqqmy5
         bEnbGM/JGNJzQNZVk7Jp1e580sfnS8S3VHelNyAvovLC6PGpwA399sIHIIqD9R28uwvG
         rCmHiGoA105Ab9XvrxvexepCvA8KDoWLGyx/wpBRuDzokoDTdFBinFaY3Z39x8eEBlS0
         rqiNQ88c8p6b9WHeYSBEukXmdXunfOw5ZLQe5HaCS3+iFFN1nOgu2m4h25AurZK0UOJL
         6DwzIIiq4WsoOg7fpTKAtq4dlY1cvTh4WpvoenSDfpeEOzvwULWG3OFtXmbzqRGgGRL9
         wlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821996; x=1762426796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4Li80aTvp/g1w+wUXqfMhurwLUlh+lPbBgOPzmRuh0=;
        b=LAFCI2IsoYD/hppo4Fcwi9N29mMA/KFwsxmwT+5XQaOFvMoDKEQJVAdyYTuCWVtsGN
         GFHCZCkqjmlDGOZsuQRJfT8EqwELYhkjhvBxOt5tuuKJ0COhJTkgV5TcJT/kd4HXFbeP
         Kkd/H098aOiWjqI2HCZ0x/XpJE4Yqoj4r/BBdUEbGUT34E5dqtrVQ1bI5+36X2XMPLX1
         5IJ4nll4L3SJbWMDTPhLPD3CFI0TSQejRAX0VKTvB2dWw1C4QqC3fw2+EIi54NWbYk+i
         8/f5Lc66svqGOJmChadCFYB7tnotSE4+/VSazpgpdZQXZ2CkT/k0UXQST1DiTxeKqObU
         HmAw==
X-Forwarded-Encrypted: i=1; AJvYcCVng5/+K2Xxr/PLTFu7/sRhlotyh7S3F4jiS2LjZpm72CRECNTl/R2TDd78usHLaTASWtus2jUGnBMoA+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uox0PhRu8b6mBjYkE5ucco+/S315V2vev34j7/lGyyF0IkZu
	N2ERUY+qQw5RvPYoLRYrbWIug0/iQpt6OYeglXIbpjqkhjPSLk5wgVNKYN85VZOv17FzdcFMumm
	F1oj12hJ2nYToLQHdwGx8OcJvc0sFL7Vt7YIfeW4SBNWKsih/YVXAjwiuUpbKZn2zroc=
X-Gm-Gg: ASbGnct2GTSIZml8aqLK1gj5FhL2OmfmoVK2L2UnQ8NGIEPiFe0dGLpsuEYb45sLn38
	jXSS9Y/m8HFZIj95mR3QlJ/KF29TbVfbqchu6dTvaE2wrc1xgvyl0FSCUPimX4M1bSzhnM7pOdj
	ZQPQaxMKurxpa0Bt+1+hWMtmoywxVYXjTClJ85lUp8vhMtnEbviSydU2pDj5ikhwPMt8Q6cG7xH
	T2cSEeHwgP6L1JCYCAKPU99gHZ98IoD25eNDRM/o+wDcscv8llukuzaWzveC7o0FA29r6J8PLta
	yB0Pci5BTdiJH5N896pfxvEIzGXRdRW5h8hlbfsEuPdNHXgCw+eu0XgGrf8iTVSHsJ30tYGg3wc
	SJm55rrnhhAqJZOCwg64j7NNFapxG9VT6soh/GqjOffMH30clZQdDZYSm
X-Received: by 2002:a05:622a:8e:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4ed15c0e6fdmr49741611cf.8.1761821996097;
        Thu, 30 Oct 2025 03:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm09HK/SLe5Y3f9LFh1BN+NjQibrJjNIWqbjAP7w16cB/HL9cTyvykV9a0BC9Cdc9C0OuxdA==
X-Received: by 2002:a05:622a:8e:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4ed15c0e6fdmr49741411cf.8.1761821995667;
        Thu, 30 Oct 2025 03:59:55 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e8036cdd4sm14478512a12.22.2025.10.30.03.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:59:55 -0700 (PDT)
Message-ID: <7f807543-35d3-4101-8b39-fdb255b64f2f@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:59:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8250: drop duplicate
 memory-region defs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <20251028-dt-zap-shader-v1-5-7eccb823b986@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-5-7eccb823b986@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4OSBTYWx0ZWRfX+WKrGlHsd/w5
 Y8Q+AfrRvssfB6P7a+TIqAngK4tJoEZ9pAxwlkTGqBL2wNYAgB2qZG9fKRj9Pd3njuRzCrTgDyE
 yiGkiOGSwHTpBv5XwLrKrp9zA9cVrc6+Xuck6J0KfUDaodzesZ5FjaT9NR2qvr2K+gWs0KaRAgS
 hVwr+euK4HdBFyWowQbZZxrlDKGClLg5eUwTk8I1ufJaP71rdO43GCpTX4thyq4BNeDBjiD3GUM
 E92wZqHo2kBtSUU6etF66CHmwAapKO2SCwAquYopsv/65M16CIinEvB19Q9YiBHVHRVwp0Zbjdn
 R6jmlRHqGikx/p1q01hw50gQKEXBEqdEAJH1M20Zbh17hjqdSY4+craP5W9pHS1Q48hTl6SqwjS
 CxCiN2sDivph/YHBCZIVrK3tuXf4uA==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6903452c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=mq5k8ySLyEHK5IPdJK8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: QYCiju5ETwc6L6nIO7ZowFz48DX8wcem
X-Proofpoint-GUID: QYCiju5ETwc6L6nIO7ZowFz48DX8wcem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300089

On 10/28/25 10:00 PM, Dmitry Baryshkov wrote:
> The base file, sm8250.dtsi, alread includes memory-region under the
> GPU's zap-shader node. Drop duplicates from the individual board files.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

