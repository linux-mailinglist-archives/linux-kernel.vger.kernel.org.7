Return-Path: <linux-kernel+bounces-797034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB0B40AED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98327A961F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA5338F51;
	Tue,  2 Sep 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J4PKlm42"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B653126A0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831571; cv=none; b=RmaPMTEXJ0CuddKmzdmcWdWxODoCijQWWPWatiZ7s+JTAJnls5Nsjpusy/6CVkVXTDkFaXGEAYou2hz/dBqH5lZlLPmf7z5mIcbTSb5ptwTrEci3GdDINv8EqYNJh4uV9Kv/hR7RVTiR0Vnhjin2zGI02/W6iN/9FdIizgdtD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831571; c=relaxed/simple;
	bh=+pd5ibWIKyHRFFR0VYcPPSihlyE9oJC51HBCwcLMQas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HD7uIcKMtGsbU56oiFpHXdf30f0iB/ieDKWtDgxOqzKImDmtUu+cDfPnALwu7wwDzdWRy8x77Gi/5rQv4mFq4VcdW5qzWpVszvF7XM6h6ayfsd8tf4o205/mzsCrxKYpRqRrWv7oZhOxUdgnjg3OTPvddh23wPTPK5ZdCmApudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J4PKlm42; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqHnE004244
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 16:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/X6rGdPxT1UiWkrcEgByQOjggZJJnyxAl0XI2p+tHJw=; b=J4PKlm422wVwPu4D
	Mc2+lAOVFo9MKrDO5ujM4PiUEFzyZwkV+gGesR+qnpbJX23HOo+F2C5BU3RYQl5X
	Kr31+FJJdxeViNchZ8mMelrxvx6dK6nD5rSi5C2pHD3qkdb0Acr0LaCjmthyXqwc
	8nCX8akkRp8pTcbbAhe7UtoRxiXVf1mXKuUM+IUDliaUfnHI0J8RpEFlj/lYd1Ub
	ODmRslmztdkaHpxAq9f0nKQEAl/QcwQnLmmopveajSt4B9zCllVcv3yKcuf9qIiU
	XApT1/PdWplyo9BzjWqW+j1EkDeMew7uWYIEn2IDyWYOlLQ90imsPqs5pRJU0GcJ
	TTmGmA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjgjr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:46:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e60221fso9199282b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831568; x=1757436368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/X6rGdPxT1UiWkrcEgByQOjggZJJnyxAl0XI2p+tHJw=;
        b=K2qmFzu5/gEhEvXWzRp6TnYESYx5aF1BOSccsqyHTGZv6UkNcs+iQ8n9s7R/lZ+bV3
         YVjxADcO+lnERsZlzGMJxf6eti7BkBwKz2OMWZYuiIe56yA1V3PM67tSfQENA7pihDWM
         oJG3ODPatA+iZbnm3AZ1GAhewNvIRFMVRx4J2UlcviXROrj69CaEZ6Q0SP+cigBni3zh
         74g0I3Gp1HUHaa8hT0BuDuAD9PKaj1C0kllPqTUwAW3flI07LUJ7KxC70ifiIth0qr8p
         9UCti0rTaUfdymX9hsno9XxCiiLGhQy3qq02Pi0yJFNpdBLrInpzGZOXuvF2SmdonFew
         APHw==
X-Forwarded-Encrypted: i=1; AJvYcCULeNsNXmfik7DNmXlXFvp0CCTtgLcl32gVrtoDRVCXmCFkl5SUUbUnbr5UcV3YREyryGNsSvpPNprhwEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/XFLk8CY8XIWRglTb+8tlh1dejl9KPLgJegdLSjQKQnftjFF
	MouF18MlZkP3G3I09Ocjp7EAHKPA8sbvM8YdXAfCmGXcvcps1Avj3ntJqt13DDZH+eVBdh2hgD4
	kmitDSyRkLHcsuRl92xLgHMSnbcBuSlGqCkq2TndLG+I0EiYaRh/FHIg+RKvmasj5m6s=
X-Gm-Gg: ASbGncts3SM44juQcIQWD16oia3kQOgTY5plkSm0T3I5Vn97ELmpqmue351QKTdnmRb
	JMO77ElD6jICJ52+HMVju+JAXmo6dV517RvGIZ3bg7sQvjM4+asGXiBGuAqAfGcg0MpMxhxkk/A
	ADTcXuc5TtORyp29W1yZcF1Q+BKnkwVINSCQqlU4iBXeHzGywWPvO9YexYT2wP+VLHGIQ5KJveB
	vPnYM5nnbxDGdO5p9EYzWP9xBW4JsckAxRTMXy3Qnfrpi/+GtLEI1L8RyseKt9VVtNVZcrbgNS+
	BenbiXxx/f1Bl6a/oe8rMBfFKJ/IUDhw44+GwmnXkieJ2TBQUA4Kih4ITAvvf2PC6Q3F/+Q=
X-Received: by 2002:a05:6a20:549d:b0:243:c5c7:1126 with SMTP id adf61e73a8af0-243d6f0324fmr17153214637.30.1756831567552;
        Tue, 02 Sep 2025 09:46:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpXLMq++UENp17zgkzAVidoy/rMcBj+5w9Vi09jk3fctElIIy1kaIPr2lyaGmIxwQhJIRuaQ==
X-Received: by 2002:a05:6a20:549d:b0:243:c5c7:1126 with SMTP id adf61e73a8af0-243d6f0324fmr17153173637.30.1756831567069;
        Tue, 02 Sep 2025 09:46:07 -0700 (PDT)
Received: from [192.168.29.198] ([49.37.133.120])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd366f95asm12393842a12.51.2025.09.02.09.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:46:06 -0700 (PDT)
Message-ID: <0855853a-4b77-4bc8-9e78-bd4e8a211b65@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 22:16:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: common: Fix NULL vs IS_ERR() check in
 qcom_cc_icc_register()
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <aLaPwL2gFS85WsfD@stanley.mountain>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <aLaPwL2gFS85WsfD@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b71f50 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=+KjSowhBs1waSO1ngDLaHg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8T--ygq334zCgzS6G-IA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _sGKymhEWWq59k3_HSojZ6VwbsBuPgEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXwIevFUBillry
 sehBH7CAtr/r1AJV+nAFX7z0Aw8GACJJBuAK6YsJMLu65cnUvAW++orcTzN9N2UgFiNNt1ZUN9p
 69oP5zS1MpuvN4monQKM6cCfpe5TIdXkiyVTyYW2n7uTYn/MroIHM61MqFkw4+rYTsx9JNwXoJE
 ZIcyjL8TU3nQ2B9IZntXfYBplSX0zN9PmcTgH2hwY5aiYh0Md+FV6KI5nacLrDEQKApoOcYGKo5
 iOyQE6QJa/4W44hBsKP+KWY1NkwAOgVdSQcJ7J5I+xOaH/UUVgkgt9451NerXMzX8BfqPKR2y1Q
 Yzhpf1hlD11iqdT7L5VJ0NFgmJgdi5VO4WbSD/gopDHd7kzlgQMcLnvoYnr0bPl1ZEabxlTHdS/
 E/JQzUgB
X-Proofpoint-ORIG-GUID: _sGKymhEWWq59k3_HSojZ6VwbsBuPgEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 9/2/2025 12:03 PM, Dan Carpenter wrote:
> The devm_clk_hw_get_clk() function doesn't return NULL, it returns error
> pointers.  Update the checking to match.
> 
> Fixes: 8737ec830ee3 ("clk: qcom: common: Add interconnect clocks support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/clk/qcom/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>

Thanks,
Imran

