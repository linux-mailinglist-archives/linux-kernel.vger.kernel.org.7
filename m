Return-Path: <linux-kernel+bounces-768413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420DCB260E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95971C844AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AEE2EAB8A;
	Thu, 14 Aug 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="InNM54pB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F542EA472
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163491; cv=none; b=rtx5VM2IPAF/W3fO4DeW87GTgc1iQR2ntcQLWCTrIan7foDAq8L5oBcAIqCKpPE+xA3eX37U+FIFAqYpVFKPU+YuwORSVdbZLoJyylT0OxByvvkqS28S26WcljXu6jcQ+PcfIleNJ7RWeTETFVBq13+FmMMIY74B1xZoHExc3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163491; c=relaxed/simple;
	bh=eSTBNyh5qgA1GchKDkFcLTpzfX2XNDNDhYNDNClDeVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeV+Mkwv2AQkbkk23HBWM84dA6w3sabrrIY5gWP4UIfhH69fDiFDkj4uCnOtCThrABolND9QNLXmrMeuVV74VOyoZjfDkGuYsXjPOocA2UGn8fTTyIaU0S7G2+q1rWA2hAsCrgnjoNFlnlFaUEJiWng5ewY3OWGJfYAX6CalXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=InNM54pB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMhFvK011176
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xhD76Y+LWnlDk3QMceTS29ieyClXA0Qtf1FA6Xtw2+k=; b=InNM54pBTN9QGN2P
	nxyICmv6J4Kp8T3pCQzimSHEXWX3z3/Lc3eXh3LO+nK6JS5lnTgZQCGDQFbt5W/h
	arVNfr00CsKpHTVIL3Z48f/ONEp3hgeG8P1ax17ratTLrBYK+6LvNQFtfTToCap7
	VvRkgzn/ZUo/D3gT7dMpzHWfMcZYkLWY5zQGoLZnYBbHrC4mAwlxjy99XM3QAo/F
	nhbdnuBCLzj/nrSncUM1m3nqx4he0MbT2XskBzxYeHiFp5LUkpU6FzbfiSMxtr8R
	zZye/3rN4vFiGII5PU+o+gqyJBixYejdEVe7STUX/9v8goZkwlje0Y3i02oQEeFX
	YP926g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbj9tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:24:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109af1c20so1828391cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163487; x=1755768287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhD76Y+LWnlDk3QMceTS29ieyClXA0Qtf1FA6Xtw2+k=;
        b=EA91LxjKsJk2VqELolBu6gaOaMm9CloWeH3CdEkU22q8Xxj3m6lIM01g08hVtvuTCT
         zvUZXlUYfHcZJ9v5tyE5nn5IKiJUozjRk7neL1mso6t0PdAfQjYNyNrxzLpxTQuEIgZC
         LMbi379lCvpd+6obL33cTuXw79kPGH1dh3EszbziXTHOB7XvS3USkLcEmOuUCq1iqnV4
         nW1wuWTjDmpaVs3M1u4iOPYMB77OfrMKBC/b8YC7hGbSjnAbWduOOB1ua7omA1LvGwSU
         WgE0suELODRnt03I42RoyLeLuJmOrKkVWxpmnLkOmsMO9k0Ukk12W8YxNGcEy6SMqx78
         aTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWejSSxFCM0uxKoKP1DclnTcaZTATw3fKT8q72LGKu5Pn6GgsxFu3RDbdlywVqr0PHtVtRSDlMAk6/v+U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzexvUVgOSvN8ad1xA6IPPT1pbFrxdxTaOU12UIYP7MTMdh2SVt
	mOFueMVhSi3DRfiPsXgthiOpWPEQGGj3BdjuI/qYza4c9RfTrLKF/Z4G/k6Qrcm/WIdV2uUUMyx
	MCFFgBs8PsinHBLtmVgblT1Aw41wYnKxWCiOpBnbRxJFJ4GepaPgV6ccJ9zOHY6HRJkRDY3aK+p
	c=
X-Gm-Gg: ASbGnctfFQIaYtlsJNgYPvnv9uYoaKFqiyfG++M/QfhocFwm45M/nVF5ygHgYum2HX0
	mYzXVt25Et3/9x8/KrBJUWBdS6Bwrnj8vm9oKWiZlFp304bZPPn/HM5c/PCQCrSojcvf+TV6eZN
	apT7UE/h7zHmieUbBaYessaZAutpFD7OxozDUS5MQZr59sk3E9biQr33zc2yfY6sgyGQCic27K5
	O+6iBJ+drxJpOxnVLeCXNMky+o/eWeHxkbiqN8rT5e+SqRtmy1BmZHQqSzYdpGE8kMECwtS73lx
	QCl32aXJBxBhx05HvOzmAt5aj8QN1Nq/SNVkHquVwvaJSs8BcB98jBZwJrd/V/HNrMuvpHGfPoL
	T7VjXLCTjATnSRxdGvA==
X-Received: by 2002:ac8:7f09:0:b0:4a9:7fc9:d20d with SMTP id d75a77b69052e-4b0fc6d592dmr36978591cf.5.1755163487381;
        Thu, 14 Aug 2025 02:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtaN7kx9dDlW8uOCvct21Xzo5DX7UKUDLDTUNq5zdRR5wx8V0EGb5Be6DEAFsefWEx3sg4Bg==
X-Received: by 2002:ac8:7f09:0:b0:4a9:7fc9:d20d with SMTP id d75a77b69052e-4b0fc6d592dmr36978441cf.5.1755163486865;
        Thu, 14 Aug 2025 02:24:46 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e820asm2549856366b.90.2025.08.14.02.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:24:46 -0700 (PDT)
Message-ID: <f304f8cf-54a7-44c3-b1b6-33f5dd6763d7@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:24:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] soc: qcom: add configuration for MSM8929
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
 <20250814-more-ubwc-v1-3-d520f298220d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-3-d520f298220d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689dab60 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=J6cW6M6AcIeHNtzA6f0A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX92dvYvkzGbIu
 nbIfqYyBYVg9rqdcrYZoEo4lr57bBgdqWx1XNdv7Xgh4ADBDO2EwK821PEU9TvAstjkOnnXFR/9
 dzOjRtRwXNHwJ21AJ2Wr3uPyp/nNoiWvqAToRM0qxS3GWd4H/1VV61JsLODtb+ANCCcluUqkvWl
 7SbJ60bYKIQoszH3Fpt4mpy1U9gaEdAZWlZraP/H7HPRKj8KHLNk8stWVVF2xHdwM5AEHs2p7yt
 +h6pcJMJA7UpjvAjRPcJ+lfMIliy+eXifwG0PtX2US3OG5JDAInhneX/3ilk3FgZn+YH2zmCSEz
 AgkGQvnpku9wN52P04FXOYk3K9bjP4YREogBjJj22ugepmZe3KsNbg7GOGC+mt17M8XlXC2Mw5j
 9qUcIGX5
X-Proofpoint-ORIG-GUID: QNCcvm9sSG1ef0bZ0Za8h6SKKGt6ZXrs
X-Proofpoint-GUID: QNCcvm9sSG1ef0bZ0Za8h6SKKGt6ZXrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On 8/14/25 9:22 AM, Dmitry Baryshkov wrote:
> MSM8929 is similar to MSM8939, it doesn't support UBWC. Provide no-UBWC
> config for the platform.
> 
> Fixes: 197713d0cf01 ("soc: qcom: ubwc: provide no-UBWC configuration")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

