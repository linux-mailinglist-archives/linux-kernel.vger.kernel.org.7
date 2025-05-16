Return-Path: <linux-kernel+bounces-650956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C4AB9847
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 11:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514ED18907DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142722E3FF;
	Fri, 16 May 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZefljwAr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0522E3E9
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386114; cv=none; b=eh7OhyKv+c14E3ATQAm2YlA+R8QTOeGzr0cElpu4o7FhMFybQTkPioGeHnpfA1H0tSqZlzX5BayDpNwH38LdDndV8tppU9VSgADjXqqkUy//ApXvV3TlwsmuFzenJqMm7xHLvhslXMljEwnjVDcSLHik9k8+48uyJAbhr8Sjiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386114; c=relaxed/simple;
	bh=7bT7R25mgjoEOCenNMiog5d8jmrLGzIX7hwwnkSWCAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1FUpERPIGy600EOkMRLafIDxU5QlPxQHW7JYEzi0RHc8W7KHBhbfjyMjSy8k5uaBQFkfQtRwvF2I7KOAKDOMHOjvMszjXpSbzyWf1p4gl4nh6drxFfG4uFAo715QeChmuBYWnHUjsvE2fFO0/lpbhvmqyG/KbTU5XplECdqwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZefljwAr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G3IH8Q001035
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 09:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	crwjkXwm2Mz61rb2CTsqxEUEHdKgDUcWAhJbvyh6c70=; b=ZefljwArl0RZ+5yA
	w/twY6QCR1H5umDn0PkBv5sUhppB/T+ozvB+9nkuEo+7ucBaPG/yQloNRcXXB0CG
	Ot9UEY77w0Al8sVTW/DiG+4uvsUA5xBOeP3ZEcWigvO1FLaIJWWYrjnUmXm/96nF
	fuEVH7f8Zb038p1KfmJOiira5Kynnybz6BU730VNT2FW4RepTi1ZZ2T3loXhJ8/H
	mCe+6ziA5qwTxojmKzqjwhcB2732QPxK2D2kScXSpH6bHs201ThuwZgq5RJ6bjDh
	O9rUuvGpoqRC8cY47Ke75h8JsWRXZSg7dT07QHuUEAuxMcM7sdrtG2TcjN7zH8c0
	jm7Kdg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcp1arh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 09:01:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5ad42d6bcso53974485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 02:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747386110; x=1747990910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crwjkXwm2Mz61rb2CTsqxEUEHdKgDUcWAhJbvyh6c70=;
        b=i/2IGv9VfKOPj2FmAu2WQekm02PMs8A5WiMi0agqL7a7p3c3rofmEOH7nMVB/jTaD6
         0R4kT0vXtYlT93ISSc57SfRhAZLh52WQdS2nHfzLgUSrVQ8/eOs1qYV5c4XgCq5Z4Ci2
         mTa8+h5k7ev0E2OIn4AgktDY7xcqB07TNB4czeQ6SV8J5buqlQwFahhNmDu9v/W+gVKN
         sOrqJVYlNfGwyiGqfrilfKQ0k8F1QCWUpcDQ/8/EXFPniDyzLYOOp3nLPI5IsCMzkp5h
         rxJyYTOZEWo1/kF4/5ybqLUe7q8esckI9bqbHqK6RELBe+oedEznH5CcCEOrScJeWUkT
         AR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyk8pYH7ENow1ntQ6IogmcBjZoj6DRce4F9kNp0v0jhDVxJyJIR2JBMbp5os5TohHV4vXo5BBnpanUA0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIwvySey6PSKcdXFMJh1KYqmlkDLnMLM2dhmNgZlivK6fpaga
	EL2t2U3XvT0AA3QYIM8xrCGCBeX0MHuIFosloNlN9TFr81EDnW4nQrY8LIV6pOrmNe6OGNsxumQ
	qqtyfYWLI8zeL5fsPMmEO/LXkGOxW2MbEXFPzDBiuaGMRZ/fThujpawaWuuIDJT9ZmE0=
X-Gm-Gg: ASbGncuyPAhwoogmMm3dQvEQOlQ0eftkaMcTiVcK7aCFdXb7BUYRu8pieNNTecSDe0b
	OJtSllFsrqJ4FwJFZdjzdc/K0oXpFgifbu83xD2O0VbBY7FB+3oXtY78/IQTMyehHNBzNyq8K60
	IMZMU1brBIrq8incjuojcPTawcic/CpaSi2Lpb5n55fFX98x/XFgu+hz6bdpEsTjjsWRtkXut1V
	+PlYVmpHMT9SbMULn8HQHS/ptZFPTLdedhyBzZpGT0/6s/6i6J3nmB6hHEdsE/Zkfk/VopdG2Uk
	eweUKZ1fmDZ5yULD8zlaoj3OcFu4UFOxhzive6KPWN0Vp2Zrx/sERry9sqOVuDX6MA==
X-Received: by 2002:ac8:7c4e:0:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-494ae373c48mr13480611cf.7.1747386110135;
        Fri, 16 May 2025 02:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk5/GJR09r13nfBtnkiEoEavjVSinfCHNYuKjToVdC/aopOQxGYHzKPdlMHftGKbnMw1zIxQ==
X-Received: by 2002:ac8:7c4e:0:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-494ae373c48mr13480231cf.7.1747386109485;
        Fri, 16 May 2025 02:01:49 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005a6e745fsm1094479a12.48.2025.05.16.02.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 02:01:48 -0700 (PDT)
Message-ID: <5190dc77-3ea5-492b-ac52-8523d8188ab8@oss.qualcomm.com>
Date: Fri, 16 May 2025 11:01:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] clk: qcom: ipq5018: keep XO clock always on
To: George Moussalem <george.moussalem@outlook.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Luo Jie <quic_luoj@quicinc.com>,
        Lee Jones <lee@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250506-ipq5018-cmn-pll-v2-0-c0a9fcced114@outlook.com>
 <20250506-ipq5018-cmn-pll-v2-1-c0a9fcced114@outlook.com>
 <a3c3dbe8-b73e-40a4-b86f-ff9f371b1a46@oss.qualcomm.com>
 <DS7PR19MB888370ACC69E0A1ABC46D3BB9D91A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB888370ACC69E0A1ABC46D3BB9D91A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dyK2wfSXCgWprAGXbGj6p9flZ6yS1cAh
X-Proofpoint-ORIG-GUID: dyK2wfSXCgWprAGXbGj6p9flZ6yS1cAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA4NSBTYWx0ZWRfX/KhbhnV+QnZM
 Nk4Kyw45Da1F+Ud9O78GbKzShKUZRDOUq+ltwnLHy/mCOk4fCvOrOPjtLyoRzJlcefb07dlZrHL
 nYtzLDy0nrOJPbjqg45EV/MlY+HA3Pt8fOBHVQTB0pcYjmptr/QWltlEXEOTbtY7pwcayrvSJQM
 3r+be3EcRBCbDWxVZ3mHRFvdT0dJBb+Nbd5zmkSbgUI7yQq3YpUB3hGUWuDjqGr8z7O/KYFJvHa
 jNlPOr7uih4BNoGkqdx9k6yOmqO9V/T6EYlkGH8caSOWjLeT+DTyjca6fHyM1QH9o1ff+rVGJFl
 WdD4k00SpCBojDAMEFaPDr2dTOnp2pMLAqLOvF+UGtyYHI9h2smHuY8g5yCrM1YXMk0iVCUXvnv
 oN6XtCogrpnrmaSVHGyyNl6ETbKF5YPEHwlgsu22UrGyrhrjSPQcxkYFLYMSN29nwi3R1U3Y
X-Authority-Analysis: v=2.4 cv=Gp9C+l1C c=1 sm=1 tr=0 ts=6826feff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=UqCG9HQmAAAA:8 a=f-fEU4NQkEpfBDf4STYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=984 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160085

On 5/14/25 10:04 AM, George Moussalem wrote:
> 
> 
> On 5/10/25 01:47, Konrad Dybcio wrote:
>> On 5/6/25 7:43 AM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> The XO clock must not be disabled to avoid the kernel trying to disable
>>> the it (when parenting it under the CMN PLL reference clock), else the
>>> kernel will panic and the below message will appear in the kernel logs.
>>> So let's enable the XO and its source CLK and keep them always on.
>>>
>>> [    0.916515] ------------[ cut here ]------------
>>> [    0.918890] gcc_xo_clk_src status stuck at 'on'
>>> [    0.918944] WARNING: CPU: 0 PID: 8 at drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x114/0x124
>>> [    0.927926] Modules linked in:
>>> [    0.936945] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.74 #0
>>> [    0.939982] Hardware name: Linksys MX2000 (DT)
>>> [    0.946151] Workqueue: pm pm_runtime_work
>>> [    0.950489] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [    0.954566] pc : clk_branch_wait+0x114/0x124
>>> [    0.961335] lr : clk_branch_wait+0x114/0x124
>>> [    0.965849] sp : ffffffc08181bb50
>>> [    0.970101] x29: ffffffc08181bb50 x28: 0000000000000000 x27: 61c8864680b583eb
>>> [    0.973317] x26: ffffff801fec2168 x25: ffffff800000abc0 x24: 0000000000000002
>>> [    0.980437] x23: ffffffc0809f6fd8 x22: 0000000000000000 x21: ffffffc08044193c
>>> [    0.985276] loop: module loaded
>>> [    0.987554] x20: 0000000000000000 x19: ffffffc081749278 x18: 000000000000007c
>>> [    0.987573] x17: 0000000091706274 x16: 000000001985c4f7 x15: ffffffc0816bbdf0
>>> [    0.987587] x14: 0000000000000174 x13: 000000000000007c x12: 00000000ffffffea
>>> [    0.987601] x11: 00000000ffffefff x10: ffffffc081713df0 x9 : ffffffc0816bbd98
>>> [    0.987615] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
>>> [    1.026268] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc08181b950
>>> [    1.033385] x2 : ffffffc0816bbd30 x1 : ffffffc0816bbd30 x0 : 0000000000000023
>>> [    1.040507] Call trace:
>>> [    1.047618]  clk_branch_wait+0x114/0x124
>>> [    1.049875]  clk_branch2_disable+0x2c/0x3c
>>> [    1.054043]  clk_core_disable+0x60/0xac
>>> [    1.057948]  clk_core_disable+0x68/0xac
>>> [    1.061681]  clk_disable+0x30/0x4c
>>> [    1.065499]  pm_clk_suspend+0xd4/0xfc
>>> [    1.068971]  pm_generic_runtime_suspend+0x2c/0x44
>>> [    1.072705]  __rpm_callback+0x40/0x1bc
>>> [    1.077392]  rpm_callback+0x6c/0x78
>>> [    1.081038]  rpm_suspend+0xf0/0x5c0
>>> [    1.084423]  pm_runtime_work+0xf0/0xfc
>>> [    1.087895]  process_one_work+0x17c/0x2f8
>>> [    1.091716]  worker_thread+0x2e8/0x4d4
>>> [    1.095795]  kthread+0xdc/0xe0
>>> [    1.099440]  ret_from_fork+0x10/0x20
>>> [    1.102480] ---[ end trace 0000000000000000 ]---
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>
>> [...]
>>
>>> +    /* Keep some clocks always-on */
>>> +    qcom_branch_set_clk_en(regmap, 0x30018); /* GCC_XO_CLK_SRC */
>>
>> this clock is not a clk_branch2 - its control register is different and
>> this call is incorrect - you can drop it altogether, as if the XO source
>> clock isn't running, the system is dead
>>
>>> +    qcom_branch_set_clk_en(regmap, 0x30030); /* GCC_XO_CLK */
>>
>> This one actually is likely supposed to be always-on too - does removing
>> these two lines do any harm?
> 
> removing these lines AND the clock structs works AND updating the parents for clocks that reference the xo_clk_src works. There kernel is not complaining about anything. The other option is setting the CLK_IS_CRITICAL flag. What would your preference be?

Let's do critical after all

Konrad

