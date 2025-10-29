Return-Path: <linux-kernel+bounces-875639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E693C19784
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAF919C4C85
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F22E22BE;
	Wed, 29 Oct 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJVb5m8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V98/bUpT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE62F5A0A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731271; cv=none; b=BZiQJUbMgtXYeOMRJlfgsMMrRQy4ITVQFLhKch0SvXKEY+OqN5IssgKYdBwfT6+HucKB0V/EoAJFCx9ZS8zk/mDnvxHJEkQFYqOV4qiY5X/9S1W1sguiY2bX4cMLWHC7ktX1IBX0GqDmIQl/Ygz1HcV49MW03Y4ExslZCQQS6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731271; c=relaxed/simple;
	bh=i39ojBMoVOOXwlgR5HNEDqk1tN+HVJVkAxzx3lhkPdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsuaZ5P/AhJQVNOPsfe632GzeUHxOn96Dm4Vjft069wcSURYz5ByXugmR3j6MuE35yQ6IDEPtGqijxFyHXxYM3KtQTi6nOyg/T3ITkCbyCIzkwspMeQrvJ/rr4FJAaAiJLIMCoZR20YscsulLvESy9ScUJc7HuYZ3ie7XEGNjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJVb5m8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V98/bUpT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v3Xh3663756
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JpfcAmuJBeUQrVw8dbej9WYWTUCXHqZKpDrMkUB5wGQ=; b=JJVb5m8E9Z5Bvmzk
	KnodKTgWchMqXP9CHdY94KhCpntuT2CGYhvEaKxNVd4eIqoSo8cdpUUuRv47JCXp
	Jr+MXwhQEQgPUgVKHW5VwnsTbIOdE1fFgZUeCoiRLqTBmeLQqUqkRwdzAg2RPsKg
	HfiHPk/L057QDJoUKly0KppQUM19Kp/GsFQg3iwJJyK+wDpCkqbv3+wDAzWpDuck
	akXtIm2NP2I6SZC6NgWNXm1ImzYQkP3laGD5v7z8EMWt95u4Gf2eQ9yOCpw05WUZ
	J7oyqhZkht+zKSL9rb4AG/v/WSUAg6xbZUFZwpjbrowU+EWt652zaANG9IyqBKOQ
	7RPuPw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1t17x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:47:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c19c8393dso19467056d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761731268; x=1762336068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpfcAmuJBeUQrVw8dbej9WYWTUCXHqZKpDrMkUB5wGQ=;
        b=V98/bUpT+K1MXufoiXOZhShqwYPdwf+kRszsoydsgssaKoJ52OjzMnaLfD24E6536a
         PL6PNqruANskIrEGT9/WOGes6iqO93ilerjnHAOeOKx/ghFS/KeWCo3ZrH682SvxcRhe
         eKtRww5rOWz1x7NP8xJiKtL1VlwzByFFwuQNI4/4dy9IA+ckkeXnLKiBQABaPjNuUVn0
         bQGT+IUhB25HYOAicOxMCJudfoCniAuIVpRG/ktBFm5FikvF9RpVyxFoQWH6mBKn2zai
         IAaKdyyBxf5kpEUYUwZXtwcf+9UgazQxOnLHj9t5tZo3qHUjeLRWn7CIEecwr3qYRDot
         8gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731268; x=1762336068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpfcAmuJBeUQrVw8dbej9WYWTUCXHqZKpDrMkUB5wGQ=;
        b=hr0VaJDk2CZ96tAyX2RYNkR05g9QqoNVRgJDixJRCeVXQv1csYkwrPQLCBvBDwlTv3
         mIL/pB8Rs3KvNa6PqjzCSZIqsMifbm9mvdwI4uypv7LeIeIXj801o5KiXs1xWBCFHweN
         oR2RS+Ou+27ajUn49ealgLVuvMgZCdZeoa6HR1bPbM0wTkg5PT6flW9OqBtxMBKzYp0R
         SPmlTFzUpZ52vYHxpQSWYp865GpKXHediSCdVev9EDZVS2jTg4Uns0/C3sV+uLab9fSh
         uz/fGxytvTVm+EWnH64dc2p2ijeLjS6WMaIbbciTQdNDtqZmDh8iVamzNnXiFM97B38P
         VPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/RraM1CwAjq5gFcq+4bCEhBUek9sMwbaUHSGOnJBoqJI91IwDg3tQNzYTgw+/anaLv+eqkhrnhwLCvRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcjhpCSFkk+YUV2zYz/fwA7wlQ5Ks7hcWmpgngKSyVZ+eVOxe
	telbxiaXrjEA2BJDeD28NA3YJEqd1sTnOaI5MuZ/P9W7/pt0QxsFMy4l4y2KmJBvkGnb/r3sr1k
	vii9w/QporpeQOHjrcWnIdfKINrdoawO8Iuyg1m80jmyz2LNAEMi5fgZOaJO/KCd0dzY=
X-Gm-Gg: ASbGncvRPtx59MkElFvrYIR7K9nABHHnBvsCtf4ze9TeakGhUD0NPfQcSoC5SRgR8kj
	gLSCqJt9Nrpqgyedl6vG94jBa57UBnQLVZ8Tvv0GQT9Gvjs/W1tSy+6Wzrm+x1QxndCSOc6e/0T
	DgyAtgBBNrt/PL18Fvp7ykcPvs4weQMuUM0WA+gu4LdnIC1IpaftKUHM9sxzdIFWA98bXEE9icO
	2Dh1Dn+zO6WlyOVlwsM4OjO+ROwa6yzkML31bI/L7pxUdM+DuRbxlZegBuz/sGSUclFRpJaJm3D
	MbhydXDY7+8vK5ID8o/C/BPoC9gQzreGz300epw4balNehPdO7VK9OUJtj7U+ZoZLNJQPAS4gaD
	nLArVeibBJxVf9B4KrQl9vcQcfIqbPF9FucevX/AX8sGM0D+DOgTH8Ux8
X-Received: by 2002:a05:622a:48:b0:4eb:a0f9:628e with SMTP id d75a77b69052e-4ed15c05fddmr18585391cf.8.1761731267794;
        Wed, 29 Oct 2025 02:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJt04A9D6dUg5RLppWjcNFCeaQ6AVnQltHgwrGTU+2QjaMTswNXk0DHlEjJozyKlLBnm1Gzg==
X-Received: by 2002:a05:622a:48:b0:4eb:a0f9:628e with SMTP id d75a77b69052e-4ed15c05fddmr18585161cf.8.1761731267283;
        Wed, 29 Oct 2025 02:47:47 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b704d7a9867sm1070966b.46.2025.10.29.02.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:47:46 -0700 (PDT)
Message-ID: <c361ea17-7480-4a10-b446-5072e8edd76d@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:47:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: qcom: gcc-qcs615: Update the SDCC clock to use
 shared_floor_ops
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20251029-sdcc_rcg2_shared_ops-v3-1-ecf47d9601d1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251029-sdcc_rcg2_shared_ops-v3-1-ecf47d9601d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: M2HLxhxOaYmdsCdSzK5eyPEJLWkgwAsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MyBTYWx0ZWRfX744VrgjnynlW
 k/hvA2MGsReuQnbhKqX4AhFNTPohw5N1gblzLZtsIdi0A6j6KbmJmrumccZYWAFAFjMWSgv6QOG
 RkAy6Knn4Ts0w2q7CBNjvdJmUW4iirQMuf8yvmwd4OcSbzROVK6VfLacbFyrr2mWzGiQXAAkJTL
 erhaZvlvj0hC2ZQszYLlhJDDGTZg4HgXxXueuliqTylsyjAa++Zjbw3JONJzfmfi/OL7znlf9/X
 gMADNeBxskt+9yRjqlAg5NNCzhZyiZXePUAP3ExigRmRm8CVvVHDTmrODi9vXWNAcPbwq4SlRs8
 3eX0lD3lLNZjm4oqiyg2K9w9Cb/ZZbLpJCwISoephxIl5aYwCEJytO5jYxS3fRTCNrKMzPfcqJd
 ko5AhGZDp9L7rEdlAMrow+0N0ac/Zg==
X-Proofpoint-ORIG-GUID: M2HLxhxOaYmdsCdSzK5eyPEJLWkgwAsm
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901e2c4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vufs9Q7Sv56qtQhtIKcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290073

On 10/29/25 10:37 AM, Taniya Das wrote:
> Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
> boot. This happens due to the floor_ops tries to update the rcg
> configuration even if the clock is not enabled.
> The shared_floor_ops ensures that the RCG is safely parked and the new
> parent configuration is cached in the parked_cfg when the clock is off.
> 
> Ensure to use the ops for the other SDCC clock instances as well.
> 
> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

I noticed none of SM8[1234567]50 / hamoa / glymur uses _shared_ here.. 

I see that e.g. SM8250's downstream sets it though - should some of
these be fixed up too?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

