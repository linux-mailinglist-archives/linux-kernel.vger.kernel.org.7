Return-Path: <linux-kernel+bounces-757536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9609EB1C352
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4592118A5722
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611A28A1D3;
	Wed,  6 Aug 2025 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I0tKLwO7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138128A1CE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472483; cv=none; b=fnlyy5zTn/M7X+E8IqkVm6eMWUp99LKzF/2UMVCO70EQ+qTdoub3Urcqx7vAQ5kjKqwzTAIKZ/5bWShX8o65AcASbVP5nHM1t5DuoWRn31SjQExeiIjePyyBCk4Qtyn7P9jeQssuVzfz7UdzdyoD7aX0q8Jr8mZHKCPDEJzQwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472483; c=relaxed/simple;
	bh=MYut1GmYrZ9pGw7AeqGr62o2kp3kOej29q5WczHLC4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwjHIV9d6uuWqHSDDi3QbRChzoaQSaefmmQRGK1XZM6L1WgMXheQEnyle8lQi0FO2oPOqUHHhl12mjRimwGkF0eIud5gPiPofOjU+mVySRVh1ijkKQQo/QxV4kRhLIcrNdJxdE2Uvo8aaBmvoJV/PZqqu/YQUt6qenAoIKTe5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I0tKLwO7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765Fkmx020222
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PNaqGeAKSyJlv//PcfcZiYRz0y4fARWElDbjpanQxvs=; b=I0tKLwO7wrtDlk9h
	/cDNF8dF8+ZpcrMaqSiZn0DX10GVif/cOL4uh+ew/CnX5pz4Tvi8CkQk7g/I/Bh2
	Z1DpMTE4k5wS5aPmCyghFvkdZFTnua6TP5v8NQQpSZvuhK+fUGFc+A8VzRI1wnOg
	Y3sGubCN5l+xpj2tb8bJWuxIwZMWI+OyZ5QZI+w9B4LJY+txk+D8ITUhHHd/EyV4
	6S6bujOo+YVfzLPHvf6RlhbbVLavbrMJoed9TMztVfG2fktm/lVS2BrNwZ2WkY3X
	gjzckmWsXPSXeMUfJIWabuIxmWNT4mPg5eI4Czv3B8QS/TbGpfDo1KJCEqVuLnBx
	lzo7Kw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1a86a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:28:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so8895709a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754472479; x=1755077279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNaqGeAKSyJlv//PcfcZiYRz0y4fARWElDbjpanQxvs=;
        b=gRB9PjKcoimqsuiKAKk850INgyMiVWk2MEKWc96rW+di1WZ3FWPhrW3jq8Q1hh7vk0
         ndM8nNA7DFWihvC1YaW6NE/vQBzPNrq0kU82Uvgo+WYzJcttueXhVI/FiGw6CzI9W4Sn
         iroF1R5pKru9RVQsZMjpC+sBd+Eu3+3ZLSqMbH7AXOIOs95E9RUHizPF0tTq6jKv96Bk
         z2awY2l3GoeE8liqTP7UeJADH3o+Nn6+D4U8uDZDGYVHyA4qUg5nmOJBzVykzLCGAbMP
         t4rQy1k10UBLBORqH0rTtF0d8UlhB+GfxFpap+og31SyAyBmhPzSttw9OJZXIgh6+R1C
         3yfw==
X-Forwarded-Encrypted: i=1; AJvYcCWigTOqhxmw9DQA1ibXrJhPfttVIF+E5pNRm1prgdH2pW2uxaL21hyiFGwrjDIVQVzQSHimg0yBtMGzZ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOjfa9pcDNKXkLS1/2LVo6NDK6AvitFy6D9IVE7uLeSKDdyfv
	k66wua6yyy6yOkWm9I39xEGrRictrUCw2x6dOakektyRFHeXSbV5qXaxQ3unv/ejSpf4i2tzuyE
	pQYa4f8IjUFvGTLhCMszSHJ8sZNtDjuyNfOmjWCW4uBeAjiPd9F3QAn7VVGF2kZR12e4=
X-Gm-Gg: ASbGnctju5m6tdGz831sisREs8AsOezxXhBpJP86kVVHxabXddfQWzCpvXSv3BwgV6m
	VZmQXOoqu7uhmUUnf5R1BcC6t8P9tVTbeIr2jxCbMEt52DMn0S7U4xIPRsaY5z2A5qQ+JGFcQzM
	8wD5p76Aj3CtgRYzstX0K7GuXun1wqgkk1uyJeQi3xW/88BlMGwtiSZucA+MP1/uVVe5jur6T9M
	307bksX+GUhbeRmT/FJJGRyIAi0yuvDPCNbUehOK6mEfjDiUkOG+JmBNT3rf4aPVweVLb/Sneo+
	V35FPg1lenh9Os7KgXg6sxHEKocPkR8gESW+W9eCDTeXW4iPCF0GbjNocMYlYPZPElU=
X-Received: by 2002:a05:6300:2189:b0:23f:52dd:2d1a with SMTP id adf61e73a8af0-2403145511fmr4473209637.46.1754472479364;
        Wed, 06 Aug 2025 02:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzhMtEb/SyNlFHoanrLp8CaRrAf/5QiS39aFFc0BF9fQdyQg3b0pbGoRpmXbYkFnw+mTFqUA==
X-Received: by 2002:a05:6300:2189:b0:23f:52dd:2d1a with SMTP id adf61e73a8af0-2403145511fmr4473172637.46.1754472478954;
        Wed, 06 Aug 2025 02:27:58 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4230ecf8b7sm12841307a12.11.2025.08.06.02.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:27:58 -0700 (PDT)
Message-ID: <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 14:57:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
 <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX5hlUA5Ks/bYN
 nhdPnKYjXQeaWXT/dcNyfDiLvVC6NZtvgk6Byuo0a0aWMCZqw5USqTY7XxzLuxcvZDwLw34B3GQ
 izwlFmi81hLyn4jtTuPQlKQWJaIQY8Ysw0lVtkxZdm7MpRxV8yn4fozWOa1sKg0WntTXsUYgHp7
 E14Rgrv0P7lupLUlxIAYXuToibSqJ4+PZ+5hOaNrS7z3DbijHh6MIJjyV1uci+qgoeLTtzUs5uZ
 qt+6cvq6ZSNJuzRsyxcK3i0wid3CaUjz+Qe6IFc9CKW2VO+VIzGf/kcb+MJcs3twVM+ly7w911K
 4fC36XObpbJyjBpVDrH6q0MLcyU/6RzL0GufAkrb4tl+jaopwZyi2IIuEv6NACqRmwpY5Dnjb5L
 rdyOKmhu
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=68932020 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=h-tywKWRDzwo4R0Mf8sA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 5nlRs7AtRFidK4p3luAbfiS7F6DEloWH
X-Proofpoint-GUID: 5nlRs7AtRFidK4p3luAbfiS7F6DEloWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>> boot. This happens due to the floor_ops tries to update the rcg
>> configuration even if the clock is not enabled.
> 
> This has been working for other platforms (I see Milos, SAR2130P,
> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
> seem to use non-shared ops). What's the difference? Should we switch all
> platforms? Is it related to the hypervisor?
> 

If a set rate is called on a clock before clock enable, the
rcg2_shared_floor_ops ensures that the RCG configuration is skipped
unless the clock is ON and which is the correct behavior. Once the clock
is enabled, the parent would be taken care to be enabled. So it is
better to move to use shared_floor_ops.

Yes, I can submit to move all the shared_floor_ops.

>> The shared_floor_ops ensures that the new parent configuration is
>> cached in the parked_cfg in the case where the clock is off.
>>
>> Ensure to use the ops for the other SDCC clock instances as well.
>>
>> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/gcc-qcs615.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 

-- 
Thanks,
Taniya Das


