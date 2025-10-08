Return-Path: <linux-kernel+bounces-845441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B19BC4ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA7C19E25D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BFE25D1F5;
	Wed,  8 Oct 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CTUylmez"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5525DD0B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927504; cv=none; b=rThtF19FQqpbGR6K0x+pjkOZkEF8H9U6g1j2Yasp7rhplIS+6AY7O2xbeEC0z2FKGvgBfXhKXKrAZ6Snitm1s1aE4J1eDra9QqxOkF09v+wEfCpvHa/h0Exg+/phZ+l5SrdBfqVJ1+DW3lKphjJ2zmBaKm8jtr6y9+LOVmGHUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927504; c=relaxed/simple;
	bh=r3H8Lglxh6g+EZJFP80aL7W2Zh4kLp0qdaNdNibtZCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/qNpcOfqa/G6CzsGvy0ILZcsQujtGidFMFMGNQELFKGu5IuhxJclHvrGTcoDnfwY3HAnmEfdJ3QimF49cfYqx4C37VUrClG6sCId+SBW6zX3W+LlMkgrWea9NnlCzVfkuOicGUe+j0NJrHLIY3BmUmqXihDv8m2LICnJNsuZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CTUylmez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890PSF028801
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4SEeZvSbrbgqu/r4DhrYahbkVZg9swdS/wxQIvKWh0=; b=CTUylmezdCRBVdxV
	6ycAzcUxgxndHMywcVRqAlaItVvxpKfoo+fovtBgSU0rgK7jA2qb8q1Q/PTIxipJ
	ra03yv+Vn5hnHQdJPgDCRqulDlCt2wfYoFwC4CzaefYpCMrmxeJym1ju9Iddmlr1
	GwaELSSVJVRFc5tk+tZRW/arH0F9v2m7aF8gMGdhqLAPB5GGPQA0ISYzb71Xf7/o
	ACx9KBZncU+HQ30b95aXo/rvMtlGQR+Kb88cVbe3/YGc87aIip/GykmQJtHft5+5
	rdWxXeyuiMaq6PWljf1eh1PDj8LHtmh3wxcyjT2yZaTuQdWHFFh/TBU53+GcMXic
	9nY2FA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgthtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:45:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4deb3bf6b2dso14235871cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927502; x=1760532302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4SEeZvSbrbgqu/r4DhrYahbkVZg9swdS/wxQIvKWh0=;
        b=US7sYohQQBiv7ZQC1QHuEpbiIh7/RO8Zu2Tn5aCuLtWx9gc4+dg/PP61rwiV+GR9xS
         SpwqUKXHntWsQEDRsXhamlZDk3a79VHJ2NbPYQzqn1+S7IR9mfgYDy/q4GURo6TVkPH1
         aWnMDCGckcU2CztNPr9ULFkSuepDrZxILsDmStHbf3RxcXN0qJ4Ec1hsRH4MntFNf9KI
         JviqPVXMB+93ecRkXTBk0+h4UOzShMPRhIjiX8QLeojEgzToairwuyEMxR1KB104dY2F
         Z7iQo9J79SxotLsjJ+7dxgwZYUwCMVyajkVI8QSxueVa/XSIESaPHjvdn1qadpQ5ag2P
         JucA==
X-Forwarded-Encrypted: i=1; AJvYcCWc1Kuh90YITehfABq5C/D1e3OsWwAfpcUdtSlS/okcZdEQSTDY0LJar/CLpu2iuM8anXRKNoynKKc9IOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwU70YYzjMyUTFgSPh8FE3yMZWVMuPhdOXwZyeGsCMT3CEIZYm
	NS5ko2oy3lpQLMtSZznBvDOHremfAiwbdUKGIWchPVJrdmJCojB6tvT/Uyx2DXJ4jKRd/umuN2R
	qX0UsgOdYEOpQH3oVuMorXDHM8VToCIAa/zUuuiRdYiez35zRTUxXZ/AqenXNpAmluyE=
X-Gm-Gg: ASbGncuNe3j80bHM0AsVwxyNAVpO1VvdAF2luSrWBgiQ62s6MdeEz9NrSyTGU5Zsc2Y
	0qNo12DLznqqcJNwvWmXP4tx+VU9rip8m9uNMaYyakFZ+pguJQHtl5RPFqdSJ+c1N+n7gcFP/3p
	zqm2ky/mRwOVMWumQCnzTGRkppRrd5r5HNKTp4QH3FmvWUDXLKZkLjZTr2uj9wKDWgUgCwjd/wO
	lB0/ZGPkGVhlCngFyvN8MblttHHZW1qgvijgE0sUxqgcgcUdnas2JBv2RpeQ/N4EHvDuLpaz+NC
	K2KWLzvuBMRDKL/4DBN7L/ndyOb1cUTqNUVzcK9H5sFFDHG/uEvXlmOlvMUFNLRWB2RB9zu5pbV
	7xXZzqDyY7cKUOaaayq+ts86TZZ4=
X-Received: by 2002:a05:622a:181e:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4e6eabd0e13mr30200151cf.0.1759927501515;
        Wed, 08 Oct 2025 05:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbnUKO/zYDB9iSF9ESa4QTwR2bSSu9bQ/d2iHEFREb9o0Vh2se/SdtDCUQBFmHWqDx3PMGHA==
X-Received: by 2002:a05:622a:181e:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4e6eabd0e13mr30199841cf.0.1759927501088;
        Wed, 08 Oct 2025 05:45:01 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a7ee4esm1637398566b.28.2025.10.08.05.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:45:00 -0700 (PDT)
Message-ID: <20cb3921-1344-4e47-864e-ea99759a1dad@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:44:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Update regulator
 settings
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        tingguo.cheng@oss.qualcomm.com
References: <20250919-b4-rb3gen2-update-regulator-v1-1-1ea9e70d01cb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250919-b4-rb3gen2-update-regulator-v1-1-1ea9e70d01cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX57JgiCI6NMtB
 OTfAF6p+3PaQKq+AKrE/krFWmk68haYCzbZl7eH9ra/DCN+yWqG544TTHHACz5qKtDUjki8Hk/f
 o9s7PVJF38i4TcSoJtrW6HfBoiXmE9D552FQ7COBKrYqP31RdmgfvIrdAQbBi0mz/TYGjjzeFCo
 edx/5BGyq4djGekJu+vmqkC59Ku1fC1tAgWGD/bxliLfyDCxyyfdZy88lEM6TBBKCHH7R0be6f3
 Kf9pcyfZjQDkWJGT8Eo8h09Nbt7I3V9nJ2bxbt3cAJoOzk4KJNL/BWwsVlRjspOHcJvcRcHIUe+
 4aMDhyPDHWrNNIwvWAXP23NFGMVzSniOMLufubEmmmPImHR5IatDMqTTE4qA2OSc4+OOZaeMvf7
 2uAhENKbhGa8c00Q5kDizlktuX/IeA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e65cce cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=slaDHjbb3bi5TH5WbwUA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: zZ6JyujMc1tGzBgY2cXr22ORjkUp_irr
X-Proofpoint-ORIG-GUID: zZ6JyujMc1tGzBgY2cXr22ORjkUp_irr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 9/19/25 12:39 PM, Rakesh Kota wrote:
> Update min/max voltage settings for regulators below to align
> with the HW specification
> vreg_l3b_0p504
> vreg_l6b_1p2
> vreg_l11b_1p504
> vreg_l14b_1p08
> vreg_l16b_1p1
> vreg_l17b_1p7
> vreg_s1c_2p19
> vreg_l8c_1p62
> vreg_l9c_2p96
> vreg_l12c_1p65.

You should rename the regulators that have now changed their
ranges.. I'm a big fan of stripping the voltage suffix entirely
fwiw

[...]

>  		vreg_l9c_2p96: ldo9 {
>  			regulator-name = "vreg_l9c_2p96";
>  			regulator-min-microvolt = <2700000>;
> -			regulator-max-microvolt = <35440000>;
> +			regulator-max-microvolt = <3544000>;

This change is funny, no one noticed that before..

Konrad

