Return-Path: <linux-kernel+bounces-796181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0E3B3FCEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591464E0C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F3F2F3618;
	Tue,  2 Sep 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5FGj8Bc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A052ECE8C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809774; cv=none; b=rvTkXp9O6kPFpIAkIggG87WJx0lu1Ujc/GcfG0c4XRMQ4UFFvVB6szrnVmKgcfj4a8B9Wddy12r0aSoX2ge7e8O6GR201W9YmhuX3lJjMRXLxBY+20MFIULhc9LZPNJlp7H9mV25WjeWSMnKPCI6NQkbGuHgzznMkY7AI8ER+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809774; c=relaxed/simple;
	bh=viLzRs0dgFeJqxdC5nltzyGMmAHmpEp54dKYBCEvJyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6fwQmAuboXmr6Hs/g2t8ni+/4oc1HXm/XbjD+S4cGuvSdhD2EbuTf0kaPAvdEmWUzOGEDYOcIv8eCucvwTmPEUHIUDtWcXOxWRmqzFKCf7kza8eaTP5eWa2Sx0eWaVTKu8Y7TneJVMRztztXhC+RivFZCVkNDTY3FlImk0wpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5FGj8Bc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rm44020623
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 10:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8HGSFKsLXaVM0YQCxvDcTSEB0RtFGcIdJeQwMuf7cA0=; b=k5FGj8BcmA1eiPhp
	bQChXRO2Bur6Fh3Abwsc5WbKS43zZtdYjhR+gVXcxZ8iE6izst9b4mEIr4tocXqH
	gpM64rn8Tk2zuPKnVTwj2T+KwYHN2nWSJWvVBjBXxJ7v16hMdMGDa0Iag5jZFcML
	nWKtyXfjdbGGxEcxHVW5kkIMiVnJ86XEXqEO0z0ptexxMh0JMah1q0PFDaPzfGM0
	RQhtKehrck1xSC95qAtKUxdiPuJUr5Pr1uf7K1Y4pZyGaEkPuQlemMsoFhhtIZmw
	XhoULg+Uj0XEpri08k9zaukT3nCuBlgHzFsTzMFezCjVacu7UbRzYUDBXp364Y5e
	atzo+g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8ryjt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:42:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b32216a52cso9862061cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809771; x=1757414571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HGSFKsLXaVM0YQCxvDcTSEB0RtFGcIdJeQwMuf7cA0=;
        b=Hs9SHppU68e7C9hfMWnelAP9ns9jwVd/rDHl2ugDFR2oqHbjIPUvGkfxxd64P2fvbX
         RbKL43QLtWY3tT9ro4XuXY9yr8R4tJNryp7r4ZoYW9s5Y7+87324CwwVXZbLfgOozuAZ
         /zbvDjSt0+S7TjluE7AfATmj+RjgzikXxezjY6aK/Dc7Xc0H0ncCkH//NPSeDJakGsYv
         uhy1cWlO/03HQCxyQU9n7B+WPwJFkWpTZbM/P1v5Rfqx++GPeQW3h5EkfFeJFW6DK0XX
         oDcOmDMPyQ6FyzBehPIovIYsHru/86pNYT9pbumuo1lJARme9FhsomvFIuhXqZufvElk
         gNqA==
X-Forwarded-Encrypted: i=1; AJvYcCW2hryyDU7gVO0nDU6UeFF+nsJVRnKiMca7X+JrRW0ozL77CvynVN8wAwpSa1/CToHgZVoNk3r2/ferXx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgOaoIC59M/PYVepC+OakC8VQ0WijZrs7DUXmEOkFlTcGD1kk
	IfjoxkgY9+KYLGoXv3EqbK4xpqozJi7bDPykY5v6pnc7ekGaafzndZxebpYA6qPO71kPksRU85e
	bw5M5D0wV3Hf5z3t0Gg8NPKJ+C1sBEyJ5NpvzIh8aytJYkkVnZ+GUSE5v5XhcofxxXME=
X-Gm-Gg: ASbGncsjfZzrLLZKKLXpnyr18/NPIA7a9yZ4m4q28V4LOeMJYPcbS6RgsHh57VU11bf
	GKCOQZdNsbRhajMD2bJMXagAtZyTYceeQ3d3vRNjbMSC/0TrMXnqXjS7MW/NFDiQBi9SZAAHDu3
	zLDk7u0rSvmZ7khPWOzXSKBJdldw4+AY1hcoTSBNQmtZ5N8bRWmIUrFadbF9I8UIJDZGHW+WDpK
	5JMLQF83AKq/RfcD0n9ldlbQcISxnHNzUK0L6zZpyx0tK4ztkaLjm3Xu0A9//iYYWB+/zpx3wOS
	0e8gYxRXNDS15Jac5H1473PA949WFN6iDBLZGQ2SkCsTnag3NgO/gYj5bl2svIlAlIZV9eWIf6w
	O6mnq/JdEWKtNMorFrH5DJg==
X-Received: by 2002:ac8:58ca:0:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b30e90634emr127554371cf.3.1756809770623;
        Tue, 02 Sep 2025 03:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIa+zdu/DvCI2hhATthcW4/zvfigbUW8Sknvl3mmHIrbuZ2hMWV/w4jclDKRuy1HZUPW0xbA==
X-Received: by 2002:ac8:58ca:0:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b30e90634emr127554151cf.3.1756809769909;
        Tue, 02 Sep 2025 03:42:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbc6bsm9385161a12.29.2025.09.02.03.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:42:49 -0700 (PDT)
Message-ID: <f49b34be-89d3-498d-8b85-ff6b0be01acf@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 12:42:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
 <75ra2ofecqu6tid6kr4hnyuztpl6jjaq2ksyquafyajhq2sa4d@4tkggrdqky7y>
 <8918feef-219e-4e69-8901-367189f5066d@oss.qualcomm.com>
 <28b33851-24eb-428f-b046-b145342fd982@oss.qualcomm.com>
 <75f8789d-9d97-49d9-97b0-908a5692c325@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <75f8789d-9d97-49d9-97b0-908a5692c325@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX/gl9wCNsxEHd
 6lAigVqY8QQxxVeqJ/uxQKTJln48v6La38mksgdINPXoGvZslI18Ih4Knlp7huhJXe9zIagKaVG
 ETishA+EOWWQi3rNf8m9erf/JN508Y9Hf/I6EShn64/RjbRe7g1a+boVhofX9/yNZIScnCmtg0G
 IV84xN4OGRyL1QF+j3twWGViIglB6dKGNknFCT8m6TSB/rr6GyjLexG5CUok9YzAqXqNmIYhdMe
 VqZeOA3G+DrX55nhSDUryh4k4P6N4OIRYnFeuBbLl9IUIveMiewCwok8O6iIEjWWkD/L4kiBWTl
 T68YrTGym1fhgSJycfAVit178tkBvlVryq04oV0noVvHAtyEnbyQ/fGlJ0+Eh7tlROFIumAkyLA
 I0CDnHhK
X-Proofpoint-GUID: ZmdJIU5wUtc3MBmb_9-xuJyq2kO6g9hX
X-Proofpoint-ORIG-GUID: ZmdJIU5wUtc3MBmb_9-xuJyq2kO6g9hX
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b6ca2c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=zKpf_v0BVtz8pCFJhw8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/1/25 2:32 PM, Xiangxu Yin wrote:
> 
> On 8/28/2025 7:05 PM, Dmitry Baryshkov wrote:
>> On 28/08/2025 07:51, Xiangxu Yin wrote:
>>>
>>> On 8/20/2025 6:18 PM, Dmitry Baryshkov wrote:
>>>> On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
>>>>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>>>>> While SM6150 currently shares the same configuration as SC7180,
>>>>> its hardware capabilities differ. Explicitly listing it ensures clarity
>>>>> and avoids potential issues if SC7180 support evolves in the future.
>>>> I assume, it has no MST support. Am I right?
>>>
>>>
>>>  From sm6150 ipcat, I found MST-related registers and pixel1 clk definition.
>>
>> Then please describe MST as the main difference between SM6150 and SC7180 (which doesn't have MST).
>>
>> Also this needs to be rebased on top of the MST bindings. I've picked up the latest posted revision, but basing on the on-list discussion I might need to drop it and post another iteration. 
>>
> 
> Would you prefer I keep the current patch and update the description of the
> MST capability difference with SC7180 in the commit message, or rebase on
> your series and update the dt-binding accordingly?
> https://lore.kernel.org/all/20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com
> 
> Since MST support is not yet mainlined in the DP driver, even if I rebase
> now, the final implementation may require redefining msm_dp_desc for
> SM6150 in both the dt-binding and the driver once MST lands.

dt-bindings must describe the hardware regardless of the current driver
functionality (which is unfortunately something we've not paid sufficient
attention to before and we're now untangling some messy files..)

Konrad

