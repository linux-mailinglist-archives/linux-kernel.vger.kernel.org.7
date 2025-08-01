Return-Path: <linux-kernel+bounces-752865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2090B17BD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8580F4E4442
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6319E81F;
	Fri,  1 Aug 2025 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XKX6tpEM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BC26ACB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022743; cv=none; b=oZk7joB7GVHIg9nuQtQ4k/DPA1L1o6J3P/79OHjliugppJdkkrYt4A6wPEsA57yBxR45OKAzYTmkEfYGZeLzw0NRcdYoEwmwVzga5s9JinH8Ni9Vy8WJ2hIJdoSuaMpCu7wG4Zw45FDNgxJOf1W2xgVFg8H4Mp1VYfO3+lcGJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022743; c=relaxed/simple;
	bh=PZsepC5GNtWag35e7sBw+U/csrG/NR/QT3fy/e+DqFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmknQzwaHdLykBmgwpQqgMsmTO5Bm5V5Z2LBrO/ojB3RQrSDxULk02522SoOe9luPSfxLCY4uKwiVmeR27i6GhiRxOgo39TJIHb0O6RvHLCESRmMUm49k9+YA+nbQOHGoBY6daB+AC6dP73VK8pW4KUWBPJPAnEWHdPIXhFUMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XKX6tpEM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VNgFPM025585
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 04:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLNJqEgg1Sd977O4ZU1RM/AYukW1berh1aTC8vgdSTk=; b=XKX6tpEMGRmJEt+C
	Yb0ngEYWNu8aWh6UUdfsCiRY92x1HMtIWMWf7TFYLvEoApCqdQ8UDJ3z34PE144b
	8aiiXA27565LWgiSDCHVsCy7mh0+SQQFQj0V+rxk7v4hC065eu+nwjTmlYj/pf8D
	pWC+IsEmQhCvPj77urRTg1Erju7LBFb5fpmSsWGdYEjh445dhsFasrFqsvla8JQH
	jvsUi3d7UWGSAep8yBo7aAdBetI6x0RO9sd/PbqbQc6B7uOp/9EUlgWGpH49uzC7
	AJZT6kLd6tbtew96Td6X4XPegkqnV+88JVoL9WpxvlfmFPQ2ZHP0KzYq0l8MkLBT
	TTkEFg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48887g2sxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:32:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74927be2ec0so939842b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754022740; x=1754627540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLNJqEgg1Sd977O4ZU1RM/AYukW1berh1aTC8vgdSTk=;
        b=KLlwlM9rfJAa/74BhmnOj6HvFvVXUeKg1rKOBOZOWuwLcsuHgJJfU874lQqODZ9KQx
         JW83D9sSy+m3ly6FV4VR+WYTe8OYUGDSVUmRXWU+/cGOT4ddBSJ0Mai0miIkwkqsZVCM
         kpnqUrGKWgtMQnFSVMnCw40otIf55gnNTAsyGZk0i5E7Fxmca1S64bHEe734D5pBq75W
         4/CByIpeNKxqXWGBvnyd/zz5bXBYqdxuqmIjZgSJ6lwtU99po3/Yzhnms64ABXdQ863i
         qzixpsW2a6Mk99khfudw0lEntcWudBzZP5tnbsDmtJUEwEP0fThZ63KoTWpolRq94CPB
         k4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWoARRuh3R31yVT19mdf5zzXfrZSosSd5gzRChXLkOEx+QZwpUCEjWlPTVRiXEevgRd/Qpl0jxEzo+BzW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HcJKrqKsdv5E0Hpl7UXqKPk+jP76CQ/FfeBKuMFYqD/SJah3
	IEEBgxCsW/GE/NtkA7Tl5LF5zseT9EUdqagmoFktVYB4FCWm0aEJ3fcPtM/23cfthyBDwZnqzD/
	/UYThCg2IBJ6pNFN73Wdd9MjqNt66dJ1XrRxGlBLhky+utZlkVFsOsJpUh2CfpsqrNBk=
X-Gm-Gg: ASbGncsTjMadKWbgSFVieGrXDwwv3D/Qh+pY534gze8mqOvAHtIZ7oM6JsqpCfaTdUL
	nM8QjOLnzgASmL2xtwS0frGmuB8BSptV5vHIkyb5zzyst34oISZHtoO9kaOprqhGaBQLKp5nBvr
	xioOpvgkQwq1nyng7mEJlEg5h/Lwds2M0E4yAOnWB6Xd7unAheLx9TpLw9wxmzZThFqAUSptezy
	QyLaHXVlOuDRuuCmfEvoxS5+KA89GNSHCrsdTVfxDhzoH/nkz4RfkEH4z097xbndIgSXjUnkgm1
	mGXEJOdLx1ADSbdrgnPgHq7I1Ox1Ol9no8SftfWaOh4aYgSi45xpjFdX21S4HlUX8u4=
X-Received: by 2002:a05:6a21:998b:b0:21a:da01:e0cf with SMTP id adf61e73a8af0-23dc0e32c0dmr19142847637.22.1754022740366;
        Thu, 31 Jul 2025 21:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyRx/Pl7BjdxFzVTQWc6hVw7LnXbmjumZvBjBAl4aA+8La5UD8cNfMne03gb7c1tgo+RC+vA==
X-Received: by 2002:a05:6a21:998b:b0:21a:da01:e0cf with SMTP id adf61e73a8af0-23dc0e32c0dmr19142810637.22.1754022739991;
        Thu, 31 Jul 2025 21:32:19 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcd00sm2994293b3a.60.2025.07.31.21.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 21:32:19 -0700 (PDT)
Message-ID: <784545d0-2173-4a8b-9d5d-bee11226351e@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 10:02:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] clk: qcom: Add TCSR clock driver for Glymur
To: Abel Vesa <abel.vesa@linaro.org>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-3-227cfe5c8ef4@oss.qualcomm.com>
 <aIoBFeo00PPZncCs@linaro.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <aIoBFeo00PPZncCs@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vdn3PEp9 c=1 sm=1 tr=0 ts=688c4355 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ai6KDVl1yJewkkMvyeoA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: _5KjaQ3oKGjcC4B9ldbIUN92xQQm8fG6
X-Proofpoint-GUID: _5KjaQ3oKGjcC4B9ldbIUN92xQQm8fG6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAyOCBTYWx0ZWRfX0J52P4as1yyy
 wIHUSfAxr7ccZAr4FRLH7UcIKhUgfnoWJHkkGMPxcykYATpuH0S7XtT5OhXdYhJ0Y8KqbbKaBMe
 ZDRrTQfrDVibIyYBmN78MkKZtLCMNs6EaCkRsVyORmPaN/URDcdPbLKK7BJQNRrp7XUuak7eVlH
 2AxwukHPwSPLJmsjU7JHMDqL2wkjEe8n3nKJOx/45C+nE7ngDxbxFoAlwclmM8b3i8DXvdj7sKE
 Ix5unuDR8lV3zc5dueSKsgblcnJrllfFlago4WSmmBQ7S9pNoD+Int4fiDhLgoGBuhnoQNdGk/C
 YCElxF2bYx//mk/zkWZsAm25C3KIjGrAKFotm+icrRIAjtcL0yn8eQmz/IIxrx8DltcoFi3nCtZ
 sW8gjFcJeyA7BIoxT4J440p64LqbP4o6O/xj9Mt4t38q5U7oN3IC35k99wgEUTTCmnj4g4wL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010028



On 7/30/2025 4:55 PM, Abel Vesa wrote:
> On 25-07-29 11:12:37, Taniya Das wrote:
>> Add a clock driver for the TCSR clock controller found on Glymur, which
>> provides refclks for PCIE, USB, and UFS.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/Kconfig         |   8 ++
>>  drivers/clk/qcom/Makefile        |   1 +
>>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 266 insertions(+)
>>
> 
> [...]
> 
>> +
>> +static struct clk_branch tcsr_edp_clkref_en = {
>> +	.halt_reg = 0x1c,
>> +	.halt_check = BRANCH_HALT_DELAY,
>> +	.clkr = {
>> +		.enable_reg = 0x1c,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "tcsr_edp_clkref_en",
>> +			.ops = &clk_branch2_ops,
> 
> As discussed off-list, these clocks need to have the bi_tcxo as parent.
> 
> Otherwise, as far as the CCF is concerned these clocks will have rate 0,
> which is obviously not the case.
> 
> Bringing this here since there is a disconnect between X Elite and
> Glymur w.r.t this now.


The ref clocks are not required to be have a parent of bi_tcxo as these
ideally can be left enabled(as a subsystem requirement) even if HLOS
(APSS) goes to suspend. With the bi_tcxo parent the ARC vote from
HLOS/APSS will not allow APSS to collapse.

If any consumers needs the clock rate, the driver should take the
BI_TCXO handle.


-- 
Thanks,
Taniya Das


