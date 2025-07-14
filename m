Return-Path: <linux-kernel+bounces-730394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF6B043F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AC17B8577
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296F270EDE;
	Mon, 14 Jul 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p7U+IPM9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238F25B2FA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506779; cv=none; b=ej/XSeeY9zQNKIFWZHQrNfyOb0iHJBk6SqYlHWeYKzTdwmJYisZILH4LBlH20E5gsn4YlwNupfG5HBaxs9LllYteeMu2AgQnLoQWmwn8WFaMgnaIjz/8QG2BaPUFoHJgeu11hDiqUcpw9EC2FefNuiZsLRTdbZM8qyf0IvpwGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506779; c=relaxed/simple;
	bh=vF+3oIvR9G4hKNt5aFVVvJYF/1g2cRUpSfW7rhM775U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tISLM6ZaPD1tK94HVmp1FKkjFPUroLIxZd64+rZubFxyktrbR7WjN33g3SeB4KKW6zIesnXZyaZ4EOqtf3tl2NzeFjT9pB1bQZsR3Voq6BOskNIPmyXdPS/QqpMWAVlidqU+uIII16DjtG3/FIx2t7FWXpySGM0XNM9TcuXrMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7U+IPM9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEVGnc008347
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P0KRc7GaMj1tOTzPOduI20ILL8jxHWMuo/B1S/LPmPY=; b=p7U+IPM9yFev0Ztr
	7fs7/0q1vy3dqA4l6r/cM7wp+gal5U++3vS2iDY0/d3oK4ipsOnMvheV5Jwh6XKL
	iehvLY6jz88N79HW+sbrvn4tV2Z20MGCCcQ2VOgH5OnO+e423lm7Xt2pD9M9ZnNa
	zuz6bDDtey1v4Y8x1CDFwlta6y4+s1ZK0G7Idk+nnKe7UTpwOe7oky7Gu9yOJ+8y
	XDGCKnNq1PM0pm3lyUYRHPW5WrAsnZsOdfIWXDnSVdApEqjW3IH0dV4SxhwlDUs1
	MsDJVEUReZzX4o6qgKyPFwDkiTDnGU2gpmed3RvB2iYqO8IDzts7dD5o/71u1RwW
	XlV/Vw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vwghhdq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:26:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6facbe71504so16988066d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506775; x=1753111575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0KRc7GaMj1tOTzPOduI20ILL8jxHWMuo/B1S/LPmPY=;
        b=JUNiXcay+nWnGHvz97iuCLp60RZk7FlbfArugQ2Ynp1xjrMd9d4ff/TYkmS7Zx60kE
         Iz0VmoiJO/u7UYIWu+E/DWHn8xAnm1XHNfEHrkt1/0/gj5V5XlkMDcoQWr94MOZwQngJ
         Yqu6q63aXjdiu2abC3d2+vfjyTHU3WKbC0TcCJ9c4x8/m9TiGqwnvCWTpJpZaTv0iitf
         GVVKBnVpDlhIyb3Sf13BGDOGTQcwhAvfO7tJT9vQvU7CDce3zal0k2InmLJVsvxU4bJg
         U7CuxaGvYzv5TNjAEURfcVuYfdpHo8Bj2cV0N4yNenUMhafjBz3hYJvqouBo0wumYHmE
         fSyg==
X-Forwarded-Encrypted: i=1; AJvYcCV4xuHgi78Zkrtgicd/Mp+4zWRignNjGsb1oLiLBFyBdPT5nnxS4Hv/B9UZnJ253KkGtg9ryn8OvLn6VJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWUkZQJsJphDfv5tlhHwecGFEAeo2YeIf5lRaHnyXQ4s05eut
	C8/ccGTgqANf0T3Dbg9kAHTkP2s9W1FZRbFZNc6Qm+xmZVcPuF8G8DgITd/jMv8OA0lTKueHeFZ
	hiB/NlYfCY3PgeNvefqCdobdMtBhz0rvTrusOJqtGzQ672R4x4IIHsv4DSJGxdAlNXnw=
X-Gm-Gg: ASbGncusvTeSuxXr0yX/Mm6hGoQQaca5DbjUu6E7OLAvCNgh95aQmzFY3doBf7OtGcV
	zx7v4EVPtpN8Z1+HI/pgW+K6xhrqUEq3nHJHKCVBdP04hyEosJ6MRkbcVB6hRdmP/M8jEZRKI4V
	FrSriMKXPtP756BOZt66sFIEjA2WcUTzzVAJynZE2QS5hBM1GTZ49tYNzLkbpUCya9Ct08oKxvY
	OdKIub+yHoBZPJsNjzbUiluQv0lc8VB4BqMPxUq1QPE6LXhQkjhEn3S96vs/fc6IeuP6DJgCL9k
	hVSUwFZfkBIAv6DGbM7opecEVF/fvMrQvO37Q3zmKfgwMuLpDNBJJ2w+rMWVXdDi4pkPpP/4a1W
	GrEpAufSZntf+qDFte+se
X-Received: by 2002:a05:620a:4611:b0:7e3:3001:b055 with SMTP id af79cd13be357-7e33001b554mr110229985a.0.1752506775201;
        Mon, 14 Jul 2025 08:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX6IBsdWI9mVsEHLZqT+fwHbjjGKMDEgd6Hp1+Vyy78VGrEJC5/M7BkrDO1voksLgqSiIbnA==
X-Received: by 2002:a05:620a:4611:b0:7e3:3001:b055 with SMTP id af79cd13be357-7e33001b554mr110226885a.0.1752506774578;
        Mon, 14 Jul 2025 08:26:14 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294b7bsm838033166b.136.2025.07.14.08.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:26:14 -0700 (PDT)
Message-ID: <dd2754ee-ce89-4335-9974-6df4b612d3f7@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 17:26:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
 <08261aa4-689b-4d6b-bfd2-221c1976d254@linaro.org>
 <a7f64b31-4767-4281-b452-a2bc5351d745@mleia.com>
 <c93624bb-ee7b-45ac-8b53-b5391f11c9c9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c93624bb-ee7b-45ac-8b53-b5391f11c9c9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbLIQOmC c=1 sm=1 tr=0 ts=68752198 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=IbGhK8io7uJmbBfgTJ0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: lsFd6kV-5evi9px5AXldvcVi0LAZz6pT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MiBTYWx0ZWRfX1wthi1FnaTvj
 TT7nbhofJJeTf/c/dYVaZxmXhcjlMEtSL0Ns0SPwHQpdkiQltG+/e9K6hXY72laMlAR5ZvADRkU
 d/qe1N5F3XepK/W57QU7LIZH1FGMow24DmvIGW9fPXnR60aAGarlhOxZ/ETDQqssvA4RvrGMBi5
 Dp+whtHQrIw1CNk1PLku2RDqoZuSBMGsO4CztfkCXZt+7Z2X0ji3H81YZ7SEOhQN3xVRHj/Ak2l
 b5bWSO5KVeFTqHPIuK209wFjC3hd7r/1ZF0I20pMHw81AOIjbJGPBwsAWdxu/Yjh3VwhpOWOmpR
 XCDqtzVOmh2jDe246xXfrsqTFTDRTUJorvRbpuarZzMEtIhOsh7CK2tw3mCUJnUFaritivkZtMX
 ReGEpVSZmmbs0xWIfYbZPujP+6zSRLFfpQNwrPmzxaw8H/S5t0sqE7vE8u4xzVAx03FYjAAc
X-Proofpoint-ORIG-GUID: lsFd6kV-5evi9px5AXldvcVi0LAZz6pT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140092

On 7/14/25 5:17 PM, Bryan O'Donoghue wrote:
> On 14/07/2025 15:58, Vladimir Zapolskiy wrote:
>>
>> This proposed device node scheme does not solve the known and already
>> discussed technical issue expectedly, namely there is no given way
>> to describe a combo mode hardware configuration, when two independant
>> sensors are wired to the same CSIPHY. This is an unsolvable problem
>> with this design.
> 
> I think that is genuinely something we should handle in camss-csid.c maybe with some meta-data inside of the ports/endpoints..
> 
>>
>> Sensors are conneced to CSIPHY IP blocks, CSIPHY is connected to CSID.
> My understanding of best practice is data-endpoints go into the consumer not the PHY.

At least in the case of USB, the PHY's of_graph includes signals that go
through said PHY (so HS for HS phys, RXTX for SS PHYs)

Konrad

> 
> These are PHYs with their own SoC pins and voltage rails. They should look like other PHYs in qcom and across DT, IMO.
> 
> ---
> bod
> 

