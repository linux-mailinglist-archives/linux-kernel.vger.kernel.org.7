Return-Path: <linux-kernel+bounces-820539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B11B7DA34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2FC189481C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012E2DAFA5;
	Wed, 17 Sep 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2+PVpD+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA452C0282
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107674; cv=none; b=kNdYtJES2msaJngl2Ttd6PpieR7G8ejpzH5RH78yOAaNhnb+RK77nknOmPKBK52j32HPvzmeG2FHyQqnhsC1exQxaYM7KAam5VA/W7BLJGQG9OL2yeV4T8L7TQMF0zVYj1T9lC+adCHEnn7OvmkBsWktPpKePWebkhJQV0NdDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107674; c=relaxed/simple;
	bh=gr9F60Me7a60bNWj3SiJcwOQULQ8APfwa1823sZVpIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuMgZPJ3mloB3p00eQE2sjgzNLVcHpf6FNnBh/Vyq7HUHT2bmX6U6XIlzjXZFnkzilb/98ZEeE5oy2kBimB8bzjxQdO7F4fprf3IdMcyWAHhoqgqqbq3jekz+LlkQJ8AhQlJ/V1TT91SlXQNva/Zk332GC5L749wIOYROo9uLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2+PVpD+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XfG6027352
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SjIVIub8Wket+d8VfqHLW16P1fmhDt81FIBdsCC9eCk=; b=m2+PVpD+JX68xdNA
	e6xGaMzZ2V9W8QeokHqxPURe4dJtCFtGFHq+OxOmaPE4rRv1UxUwfKFmYx/A7XiQ
	cvcPvOILvHD/y1NpaWwONYtYw1bEObfadFOhPRLB0iq4eyFVmx4PYk7ONHW1uHXP
	iIdjyKxmkhqBYTpMoZNFFQwhkaAEW8SnyRrL0x/jxWEKvUl46MBd9LskkdSZbuj8
	5ro/SMmh9Rcrr+GQGChDUbLYQVvsM+U1ImXl1yrubRtPlJNHQOak0cZW3nENXU49
	xISItLnkeQzXKnixLD9usp5TqPO22lsZBIk6swlTbQjefYxhivU/nHBHI1k0zlMA
	AIL1Eg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwj3r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:14:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b77da4b375so15308711cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107671; x=1758712471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjIVIub8Wket+d8VfqHLW16P1fmhDt81FIBdsCC9eCk=;
        b=ZuoC42tNBlOb5+bf8gPi3opzk2cf7mjtt4mDT8ISWsKfE/Kp/tQG5EqB2gKUf5CQ3h
         WI2VAtrn9ATRQQxPGJ60yRChc4kH5GSncYn2/b4sOACnvrtPpdDxv0mOsMoQNOlO/jR7
         FTZpPnegKzoTkEmk3N/cqjGgRpIwUTJ7gNXE3cPHAFf3AZUyF+c1IJ0MBioqARfgD02c
         SMkPfIV8FkRylfqa9Lxf1qLKgT6bGwTSacnS3iWmTNV5MZ2KIRxCYtpCw2ex2e/SvJ59
         hsPeDO/fGe2+S3zuVld7w30+Tx9RKrLVzM4g2PenQQ1wAMOsA1Sz5xDE9IBzh4VaH66k
         F0iw==
X-Forwarded-Encrypted: i=1; AJvYcCUw57417oyOw86NABK/xHDJBrD/9Bc/6YQ5dhXO8hIcsGIGnVoaEztMJd0Lz6WIifSuNa9B+0eeUBPmmOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxatfJuB6nyuRZJbbadiEwxD6wc9dLOqahNCofvPpnDyfDFwBIk
	Fcg37j3TSYKpVQRmd+ECl9Zhas70eBMwrO09SWBpLbsKJfo4tJQPUjicZ7bGLWPPk++K0fIv8Sy
	UZjcGWXhAJUFhA1dlol1zbI1VLHBg0vH3Ml5rG3z0W8yE478Toxiam5aHBExCsbk2pz8=
X-Gm-Gg: ASbGncvrbEQ4l2/S/Uj26MO+lm5ptNHy42Ft56vlvGt0PB7GWZuOs7zmRB3F7KJYFAe
	36YoTrPKjE/RNJ62YXHWz0XcFnndK8gwHgLbKdsKfj/bt4FCBabaYUMAH/u2l3mAg2iD0jwRiYX
	UiNWTvPrAHdYlDTu70jMgyc65YIjq2R4sKePHGYtgrpTuybwHsJrLaJ4+s28hCZvVGfwTS3OoPx
	pXXS8je0zSPI92hmbVadCWVdVz2W3ZKtQYued/FJPw6e92LKQTKHJmx13/1Iv7kMKn0w33XG0x8
	WsD414ITLALU6uplOSU9bEVYC3DoW1uN5a3O4knd8b6DwJL+AvVDMf2gdYW00Uq4NghYmgBhXbi
	e/Kwr07KdCU+YvLqg9lyk2A==
X-Received: by 2002:a05:622a:342:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4ba671e5e91mr10613621cf.1.1758107670643;
        Wed, 17 Sep 2025 04:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUZWiiFXjANyc5iNlBf2sAU8oL2kw0kwLhnJKg6xlVKg4vTUbDuuDVuoJ15JMc/ewmK01gkw==
X-Received: by 2002:a05:622a:342:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4ba671e5e91mr10613251cf.1.1758107670045;
        Wed, 17 Sep 2025 04:14:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b136ee12326sm485898366b.51.2025.09.17.04.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 04:14:29 -0700 (PDT)
Message-ID: <fa258ad4-1efa-4fe8-9636-d70c5ea9c8e1@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 13:14:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] power: supply: qcom_battmgr: handle charging state
 change notifications
To: fenglin.wu@oss.qualcomm.com, Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
 <20250917-qcom_battmgr_update-v5-9-270ade9ffe13@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250917-qcom_battmgr_update-v5-9-270ade9ffe13@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5vIuEqdaGgLO
 KYHtxtSUQxv2uXFBNyS+a/7Hm7evtJ2zX0gOHMGbCFQIxy6ZrTEqEkI4Jm3KikJUDWcjvL0zR87
 96O2LUA5/XoMFoVkNMZHIzoWjf1YmRNly54g21iHpSZALUhuVHUSRkuQlMF67hwkYJQENj53vhF
 Zg+qfrF2K9ADlZ/XK0V2Ko0F/4qMr7AAB/WCeEXxaei2hCl5CIsSpbc4OQqUDQ2J1AgapL4wGye
 zvqY3kb3HzcJ+83eLHgoggiRDzOH2wtURBidykCUSaRSLsSOZxuaCSwAc1VTfyQKqnK67VA6VVd
 vu56kwn01BykwgyoPWweMewjA94Z7E6GgWl/uACgGjdeE4yN42XFEqKXfb7BT7kmKEnwIrM3bvP
 uYYyQbLk
X-Proofpoint-GUID: -U5s966oxXPAsM6OR_3SGbMg5T6XW8iM
X-Authority-Analysis: v=2.4 cv=ROezH5i+ c=1 sm=1 tr=0 ts=68ca9817 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8
 a=DHQ_eFf6vkL4qwDZSiYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: -U5s966oxXPAsM6OR_3SGbMg5T6XW8iM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 12:15 PM, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> The X1E80100 battery management firmware sends a notification with
> code 0x83 when the battery charging state changes, such as switching
> between fast charge, taper charge, end of charge, or any other error
> charging states. The same notification code is used with bit[16] set
> if charging stops due to reaching the charge control end threshold.
> Additionally, a 2-bit value is added in bit[18:17] with the same code
> and used to indicate the charging source capability: a value of 2
> represents a strong charger, 1 is a weak charger, and 0 is no charging
> source. The 3-MSB [18:16] in the notification code is not much useful
> for now, hence just ignore them and trigger a power supply change event
> whenever 0x83 notification code is received. This helps to eliminate the
> unknown notification error messages.

Thank you for explaining the technical background.

Please hit enter somewhere in your commit message, this is a very
long paragraph, making it difficult to read.


I believe this maps to:

0 -> POWER_SUPPLY_CHARGE_TYPE_NONE
1 -> POWER_SUPPLY_CHARGE_TYPE_TRICKLE
2 -> POWER_SUPPLY_CHARGE_TYPE_FAST (or _STANDARD, I see battmgr code
reports them both as 2)

However, we already set it to none/trickle/standard(taper) based on
the usual notifications, so I'm not sure if these are more common or
arrive outside the normal state changes - if so, perhaps we can take
them into account as well?

I think it also warrants a:

Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Konrad

