Return-Path: <linux-kernel+bounces-844116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE178BC10A9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE74E18D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D862D7DE3;
	Tue,  7 Oct 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O7bOiguQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CD2D47F4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833856; cv=none; b=Fh+jNYFwIFfsNMw7Ye7uzDUwcoceQL59G614zKCn+OzfJO1J+Ws82EUBxNzvTRWKHp9wWaHgjlVK7qPAigaC1HmQ/zO0FWzMSSaKdmfMvaU9kPtIxnyYSjXii7d6W4XAlbfEIayxlTDSyAa1SGnzPiCU0woAcWi+Iw9hjb0CZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833856; c=relaxed/simple;
	bh=tEzTFYsfmTotpGOcroEfG2QRzOXRVRs9LS7dQ7SLeaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRKHB6jmnatg7UU9jclA+Dvy3xC5xKJ+Tq0cUEmXuqVZH43IlxWMpPziyC3diYcgDmvzdmB995c2+kkB7o+4RM2ulzoWZicTDmpYsU5m7RRjGgVxYn/+hy8e+cHeGJvqhkqTeG1P1Ud68f0f8fPsbeneD1sHkCy5bx6LSN0q9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O7bOiguQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5973icjp011725
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tEzTFYsfmTotpGOcroEfG2QRzOXRVRs9LS7dQ7SLeaA=; b=O7bOiguQpSnuPcwT
	avAAPUKB/lvfpUOQ2TLKv8IPlELrvfmQwS1DhcamUu317pX13KA8bujbt0GgU3o3
	ue5Tw7uQxpuxZIyTVYHziWkkl212aN5X900YwTEGDPKjZy+ydMtm/duHyRb5yluk
	KR4WWFLrhBa4yZeUzAh2117seG4+I2tY6c/2b/njJ7u7X+8iCuBiRbbdem3uiwoL
	QPImyEimeTAcLGSY0e2Rfpx04A8Tu4HSo1QpGZhg81LE7WnS5hZHyJLW8wRPWnnR
	CehReSTJ2S6dvU89aDUCze9zMMpxBzYCV+qrtd7l4BDN6kIGksWHyHYeCpy7t/Mx
	y6E6Qw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgq046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:44:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e6d173e2a2so5678801cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759833853; x=1760438653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEzTFYsfmTotpGOcroEfG2QRzOXRVRs9LS7dQ7SLeaA=;
        b=SNRiJb2/sLrs0mTZMV1aAt2rHTMLlb5UTxwoXL/2CbUdcMih6nH5LiLLXIX1yQS+01
         42UeDDOO2Ody0/PvGxO69mep+76kmmDGbLXqYn3lhQVmxdpdg1w49+kIGqbNooOWe4iV
         OfuRU6lhlSk/mArZPYNs3L0Q2Osvu/eQXbooys8QPVd9VBK3IhvGDZBvxYR7FwGtCY4B
         fCpXWlYUkcQ4qY8rmMT6qamNDBFVYS61Ppr6yW8KZ7ZG5xLG+dDmf605s2t11PUOr3bJ
         dF9cQ/yao5NbKtLPYYzBZU3WnHiLXF7kSLQMJwpKzN3yz93zK5a+BMeOmhyzI7J5Yu7I
         /S0A==
X-Gm-Message-State: AOJu0YzCpjwloEjUd0IDujeO0XAwh+k9PzqKemKBRFXchY1cbW2IDEYt
	iBoCb/AZpTKYQGcp0DveF3dCb342utn8xnlinEOTY7NYwUAjjKevtvlRUS2tMCVmJEkMUqwr5Ri
	RB0Z3hbYExlJJQ8wtLFOEJyhuHA0DiWXHMD/HN8CnlA23zfdlpgetK/25nHxd3OAQfwU=
X-Gm-Gg: ASbGnctehRm0RL/e4cVDMZIFWqDx2FvICA4fIzWFol15zrRt3AbdpR/ukPVlbLds1Qk
	0aZKYWHOhKwOFy2xJq+4oXilWt/dW8QKqFa4g0RtD9cyrssbTNi5apU4sICBVpT0X174ipfAThl
	cYhIjRIq+dLGgFZeByod5UeT61nbokgvmabgGBta/dHTUNNJX+ikjN1Slj9hkizszNVxZr2v67c
	NORe3VJ8gXYFEaxG8dXYjfUkhqK+2soR7w2oBCl1bNR37FWIx2uEiDgjwUA0sdcxPoeR6lywtpz
	7Gqss5pcRBGsun+Vlb6BGv4JdBKHX5l2ISb47KMMDM2sGnKKPvlAN3utcktbekGQHQWKb5X6eYa
	vTdXgvlu4mRFLQ6IKIspEuTilML0=
X-Received: by 2002:a05:622a:10b:b0:4e0:3af:4e0e with SMTP id d75a77b69052e-4e576a82652mr142747751cf.5.1759833852826;
        Tue, 07 Oct 2025 03:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI56qcfMK4RSe4I5X9MhtuGJ6Iji7nF6p10dptreUulKjL5MYxLr5itidFjejQHJIj6jD+WA==
X-Received: by 2002:a05:622a:10b:b0:4e0:3af:4e0e with SMTP id d75a77b69052e-4e576a82652mr142747461cf.5.1759833852225;
        Tue, 07 Oct 2025 03:44:12 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811236csm12103474a12.42.2025.10.07.03.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:44:11 -0700 (PDT)
Message-ID: <0b7e71eb-1143-412e-a76e-b6f146cb60ed@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:44:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] media: qcom: camss: Add support for TPG common
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com>
 <20250925-camss_tpg-v4-1-d2eb099902c8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-camss_tpg-v4-1-d2eb099902c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfXzHTMllcyyyDL
 M8qodiK1zOBh6HQzE7s3ryemi05bHE42r2BA6hCMTFm+RwsdejnHz6F11Vxx1xyh7IOWHJAZKaD
 +VrEXDW8xXCuumBUiyhWqKCZt6SyWUwCAu24GLhmzOVStgRFF/lqz3yX1tjpjkMr3xllELm8LYU
 qyc4cRT+1sWWFU+cU43cnhcRgjJ/VHbZhzeDOxig3XQFXsYJFNsh7pYC2W45ozBBmm98bSe8wl0
 bzRw9Hip00UXTd1rPX21Q0TjyDt7k/7BGBRrFZyVqDJ3eZ1llnjefJ5r5fyIvxQXwZ5cawWibUX
 zwnj+X5ShYxsZd4LHV0jZqX0ggCrIhM7BeE0eb+aqo0+mwy/ZcBkISSO45jDcEJjSQ5FgM6kSj/
 rb6kU9BMdo4uNHligwRUAl6FFVzPuA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e4eefd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=IOTsWFhAVgjdDaEP6ccA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 1OF_NLK30NUl4BFC2FdmYJ7IRGZ-wdcW
X-Proofpoint-ORIG-GUID: 1OF_NLK30NUl4BFC2FdmYJ7IRGZ-wdcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 9/25/25 2:31 AM, Wenmeng Liu wrote:
> Add support for TPG common, unlike CSID TPG, this TPG can

Is "TPG common" the actual name of the IP?

Konrad

