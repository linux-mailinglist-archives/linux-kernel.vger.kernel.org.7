Return-Path: <linux-kernel+bounces-748430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B6B14132
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383B43BD819
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9B25C83A;
	Mon, 28 Jul 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndKoGrrT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A62750E5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723775; cv=none; b=MoB818cq6yimzptikDfwa5zsvywJLDcY21uKZO33MXLJGk8wwHUy41zdD8pEb0W5e+/aLixpDqNZZK3pqkLyMRSwx8/0p0rYnAtv2LFQ7eWCjR8oaasQlwZifDZCiIFLRo6AK/AawhbOfaQP9BLwz1rNfKXFqeb7n8FqXO6z6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723775; c=relaxed/simple;
	bh=28otr1PWkOxwqfxwLLylhjzkns3AMN2v2kaXHqkXC2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb2EULiRt71+HW5VhnDMV2vngZ2e41krYkOqV4TfQEr3R/SE6KYMJrm6EJCeCwfxRetyY0qCmZBY5tTSpIKWjjDruTHJ++W0mKxnWRF3cJalCHukdCkuUuPgBiVMnOVwWeXiA6ShHPmMylg0t5Pg6kqL36doSgFeTKp4WJnx3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ndKoGrrT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMpv017611
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	psaO0fhsKdZfRWyiSo8tAjmdJAZtx/Aq71yeJdW+1SU=; b=ndKoGrrTK4M7C3OK
	pJsr0X1o6iGXLpLdHSJMYA3nNmPMVy8YnfWcKsI0V24n8mRJ30912LCJ68cySYTA
	hfPm65aTNTTuYz4nCCQxJOMPy0k4FFTnNO6HsayVQT0wM8jz3cNItEyY5QZXP9Aq
	m6RXERo6e5UHBvGsmQcXeDtYn9NPlo+9anT9DJ5jzbKHnkoKJEQ8f2NPA/8BQR2f
	xAQDzWymlbnEoh7tvRyoLvSiUxLZx502nms9tzSHpOCnNN01lPqwdcpUFp0HtBmv
	n0dYC7pn2qe+tMIEQFxq1nMPi8UWO7Gv61+tIiWsbqKTGaKtDGdPjeLbUWZlKkZl
	5krA8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1add59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:29:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31eec1709e7so1999605a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753723771; x=1754328571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psaO0fhsKdZfRWyiSo8tAjmdJAZtx/Aq71yeJdW+1SU=;
        b=GwUPXzJ5d8EZtFkbcsq9WWajfpcTWKws4zQri03M2T8bDMQsrLckgdwB9UO9WRrYHS
         Y2CNNsBBjEx3rbeV9PNd0S/pmG9lCcsdxkQ3/YY+va4O6nTbxD4Ku1P0Pup4S6AL6sSU
         1SNlbpR0hCBfYcW1bqewemERklZOwtXmDI4SVbtmjQuMUK82QyE43NNOLndOTkHZRib/
         YSaOySzUl6aWrRTOZ1eLaXgst1QwAt0VIt0IOWzetg60cNuHKpPGvqDJU43bSLpk2MfL
         z+fBHWCtTHB6bhH0/gRbcibj++vvXG+lOCJ1QA//k2J/EFo8BB1OxFqDx/6ukDD/1sYL
         EqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWKiqTmDrr5M5iNkdU97zPAo8Zy746IZqbeJV2hHEWAZtWTHKAjWNH86oHTXCjVFJp8QZr55wrDCcJdYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCIiC1HyAl24YI/8TTPQcJnmOa/9wR6Woezt6RMYL9kJEtl2W
	zQ+T4Ie6JkSnOI+tTCw3HEIeEAmBjq/K8TVMiwLwonaYWuKCGtf6ZefuEg1CLU+BNCswgYqjJDc
	c3vcnCA2Jb+J0ty4mQzF/uosvlIE6+cdKSyonggrPo06X423TofLR2XXfrKSbfnWHFK8=
X-Gm-Gg: ASbGnctJGTwnnlte9+7DjeBakVKK4kqkyTO583vYSNlEAbXjjisaeKIHW+v73hROF8N
	vvyp002xzdRAcl+ruu9y6s5C5b2WMq7M6GG3/K1KJ015rCbHeTD2unQS2B3/chGt7ggy32ys2Ge
	zsbStc5qJlIST/La6Hzs4KFBO6L9VlLWzX6Duh2mkLq+iHx9ZCC7laqOOxkFDYXpl/7mB1R/qhi
	sNxjO967VHEDijHzRg1zowkRF5cEfDJRPyHJjLkFMAaa5pdsFPjFlk+Csd9kzU69GjJakU4NEs2
	H7BjiU35flUuJfEJoHCGGO4EuLJLcitO//EYa156GReBCGhOTCdqsQaq4we3xXeyZSM=
X-Received: by 2002:a17:90b:5830:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-31e77a09df5mr14812089a91.3.1753723771396;
        Mon, 28 Jul 2025 10:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2TlcuOoZ/w9fSJKReXr19wg4i7BNBJ46J1r389MBi3VQRREXKv6EbL1QihQHnNxN6OtEqmw==
X-Received: by 2002:a17:90b:5830:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-31e77a09df5mr14812056a91.3.1753723770840;
        Mon, 28 Jul 2025 10:29:30 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e663a71fbsm10033869a91.35.2025.07.28.10.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 10:29:30 -0700 (PDT)
Message-ID: <713d1c82-6c48-484a-9995-2d7311cbf2fb@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 22:59:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: qcom: Document the Glymur TCSR
 Clock Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com>
 <20250724-glymur_clock_controllers-v2-2-ab95c07002b4@oss.qualcomm.com>
 <20250725-chubby-spiked-tanuki-eefcd9@kuoka>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250725-chubby-spiked-tanuki-eefcd9@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JrQRYd1ZNxQ9bSTAjN050sDy_OUcjARy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEyNyBTYWx0ZWRfXzPB6X8C+W9uz
 6zyOTFOeik/5l2SQRtpsnus3vlI+OQihUy+ewsyhUfL9GQSGh2aFSxXmoqUXbjmttyHubroOXbu
 2QKD0jrJ27Zrz5gZyH0dZrqAskNPs0QXsGN3HnAKhgRx2oOz29Vmw0CrEx75YUdOBrncFj3l5ne
 mtYBiAcNkhoPXye6TYM975KwVUwhLE2gmHoqV7a9TnHn3aaelszgNDvc8YWVNpMoRNw5XfNBxkV
 wlJkbUkPDXFwLEK1plDVy9UZPFVBbgxAAn9NcgjDhIApc+G/k4o+nIaoghV5MzomiO3fd4Zn8nm
 wVE3L8C+f3vvuvSK2pD7b9FN26PkPFm+0CcA7/62SoR0Hng+D8dWbOioegY+rAluQ4ZUJr3g8lE
 XerkPwhjF50t3tZXIPRl3rR91qPR33Ioao+DpYsL28fHd6HTev6xsyW3G/NKjM2Idizcy/Uk
X-Proofpoint-GUID: JrQRYd1ZNxQ9bSTAjN050sDy_OUcjARy
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6887b37c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6kochd2Oe038OFj2Hkel3A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=_CRzW6w8_PcMKYmKewAA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=979 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280127



On 7/25/2025 1:19 PM, Krzysztof Kozlowski wrote:
> On Thu, Jul 24, 2025 at 02:59:10PM +0530, Taniya Das wrote:
>> Add documentation to support the Glymur Clock Controller, which is
> 
> What is "Glymur Clock Controller"? GCC? But this is TCSR? Please write
> accurate commit messages.
> 
>> necessary to provide a complete description of the clock control module.
> 
> That's redundant, just describe the hardware.
> 
Sure, will fix in the next patch.

-- 
Thanks,
Taniya Das


