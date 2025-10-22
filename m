Return-Path: <linux-kernel+bounces-864812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B0BFB98A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F399D4F8BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839A32ED51;
	Wed, 22 Oct 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BTXtd+nN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3193314D1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131964; cv=none; b=dyoo/FBGVlWCJJqQbVVzTfyBBDwnaxfBd1OOokSDkpbqcRqKewJiQpd8tuQVVJGu2yIOh3qMoRokaOnk/Zhv7ySdCqE0LHmn/0Z/KG+HaTHPnQ9SNcDtf0LnTcYwvsB/NA8qOtNIublWM0ms6dGYUjQarCFVwQwW6BrE/gJvRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131964; c=relaxed/simple;
	bh=/ZFit2eOHNjEEsjBju9zb4SqZsQdMWbQEVyan6gONAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwXM6ZjleVRUmrlNsKoP0YYFVTJqa8FHsol5gloeaVm34ndqFPfdDBBezVfrg+Ni5Vh43LkOK1zBG/RCGa+9noqvFmcEPV0OhhrA727RpQ3Cn1D7ia723B33txrrz3RYlREWOu2DMciPInAaokBQ0XjZiMFZGtFff7q1POIm54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BTXtd+nN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA886m024515
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/ZFit2eOHNjEEsjBju9zb4SqZsQdMWbQEVyan6gONAc=; b=BTXtd+nNVNpr1wMx
	klsf0O0myoX/Eh7pgTzydU9l6B7RNlKHy1Vv80wlAlf5KbO5TAGkUotzYZ5vIPxA
	5JkoqWydGseevMrTmvw7WZQb2zNcyxziwNa9EQwjcSoXawVJq7laeG38d/OSLP/V
	4Gz5tvrBQLRciqMMyebjJTAi4MvFOQSj07bNy4lkEQnYQ84+BEN06bFRYcmV0A9o
	heBHEHHdeF6sRbd6vJSiPYfJElyS8aP3Ba7IIMzfrpX4IdZwPa1yfkxhm1E+Xl28
	BqamLE3BBEbqUHHdFE/NOqFwTJuCLaizgifVSpljn1uxSxNSNEbqeEWXBXF1mBuu
	jXCDLA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws6tb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:19:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8afec1169so2976251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131961; x=1761736761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZFit2eOHNjEEsjBju9zb4SqZsQdMWbQEVyan6gONAc=;
        b=eVw8p8f+UK2hUjxZ2N+CGXYWIZYElKkfssC76HSrz8Yernd3/zhKv1yx/+v53gbZda
         1e153tW+8FIcS3nVGNKkAQR0rfk1rjh31cZUkvrY6Mo6hX3onhAQe6/ZOBm+wY1hs3v1
         T7asBqKyg0TdlPA9+QumDjigL9hXhJDItRkV1QTllkZG+72lhR5lSpEjdVEKCnERqHGo
         JLSyHAt6UnqnnGM+upiEHK/9rBw3IBrbx3O34GLKrpplkybK/1ijwtusxDTL+rajpymS
         qgoSUJJ2NprcVtMPsNtP8/HWH0qdPlbSLxWVOXCQpok8vBuzw9y4i/R/oNmA2q3edGmV
         GWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGZgEyPoArDJm61pHMKu1Y91t3ra3teUEBmH4D2kSVgG28MQcmYLiTe0VzArWjLDvxuFUYHKhf/IBSJrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjr2MkhcXxN9BSY6Da2Kn7ywBuA8458VvE8oGZCh1L3eQdQ3jF
	OXH/K1jbu4WsXYq23rm9Hs2SouOnswFkF6vjz+iR42/CSiBaWtik7mrnzAxfYqSZ6E8BKh2lzJS
	QaWcPCpsfvmwts4w+0qhS9ZPlcTNH+ACQ3YIYAmBANmOydjvncl6FbUi4Ic2nE/qf83Q=
X-Gm-Gg: ASbGncsl3On3LGN51Rrh2GSs5KzdpVCuYp/+WRRUGWtmVr6gjl//xXVPs4sf1Vh7aYb
	4URfGrwuYpHBuOCzT24nfcXDez27XBe6ZzG7jVVEQUUmabhKw51NGu/t4qLRdGIe/C1q8htWck9
	nZ8+pF97EkWb/jZap0VQQnNuZCjkaniGySeMmnyVYEYXpCGKmmRmKp2gxjmG7v0jwk630Jysi20
	Ta78BxDXGfm5AzJ2yWc+8qABOYLfymf7dFor1DH8emPUdBNLj+ILp0f4DpQbA1lPHuebTPmwdVh
	gh03NVxUqL60jCqKOqQvsaFnEfShHL2aWJkNC4ZICSqb+hquJO/+djpcpI5FH5BQkrjqQGh+wiR
	a8oqzc6idCm5Uoq44oqlfDgvLjoSQP0Q+TY8yJXF4T4ByOsNlWpbNe9PR
X-Received: by 2002:a05:622a:199a:b0:4e8:a9f6:359 with SMTP id d75a77b69052e-4ea1178251cmr53460901cf.10.1761131960845;
        Wed, 22 Oct 2025 04:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHazv7EpuQKVa2TE7vWJl88ysZRYLrTeTShK//8fzdheK7Yg9kZVd8M9zY6Uals8F4qoNmYwA==
X-Received: by 2002:a05:622a:199a:b0:4e8:a9f6:359 with SMTP id d75a77b69052e-4ea1178251cmr53460731cf.10.1761131960401;
        Wed, 22 Oct 2025 04:19:20 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f1ffsm11844158a12.31.2025.10.22.04.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:19:18 -0700 (PDT)
Message-ID: <06aec134-4795-4111-801a-469afdd8977d@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 13:19:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: camcc-sm6350: Fix PLL config of PLL2
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
 <20251021-agera-pll-fixups-v1-1-8c1d8aff4afc@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-agera-pll-fixups-v1-1-8c1d8aff4afc@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfX6Y3PV6Aq4kB8
 sthGqFTgHNefIy5nYR0F+d0NQOI4KFApl3YKXB64vCrWrQMiNKP0YV/9HTZ/7nYqo8NB+C7YxmC
 EPujBEwZZWu5VaQUugKxSZicq0XaaEwmgdHjMlwYfxW/QG93EhOxQcVhEhSNNscm7mkM9zJjq4L
 E9d/XFpOtJ0Yw9pSO5yD4evjKIgrng248w1hvsDOWo5iflF14O5ELloxd5n9djSEResoULTrPcL
 oLmrbQNehWDS9HNu/rrHZ8mYCXvAT1gbEMesJzNi/1A87Q69ahrqmo7tA1fE/ltyh93d75emiUI
 W2QvZKMM86bLIYwkQ4KflmkNXKxS62t8an6NGSMFxGlACxw9v3VppKrsqT2FaBrhg8r5OGGBHRS
 aWVDp4jPqy3SiHsdtK+6HVruRg8viA==
X-Proofpoint-GUID: cgvFGN1Y5grREodCMjO-MBGj5fVjFk8n
X-Proofpoint-ORIG-GUID: cgvFGN1Y5grREodCMjO-MBGj5fVjFk8n
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f8bdb9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ElG4cDhITSkplFuxWWoA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

On 10/21/25 8:08 PM, Luca Weiss wrote:
> The 'Agera' PLLs (with clk_agera_pll_configure) do not take some of the
> parameters that are provided in the vendor driver. Instead the upstream
> configuration should provide the final user_ctl value that is written to
> the USER_CTL register.

This is perhaps wishful thinking due to potential complexity, but maybe
we could add some sanity checks to make sure that putting things in
unused fields doesn't happen

Konrad

