Return-Path: <linux-kernel+bounces-757554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE698B1C37E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D01F184A23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFFB28A707;
	Wed,  6 Aug 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2HPfkB8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE728A714
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473176; cv=none; b=TC+qqqJ3b8DRRwFZJ1rgH7ifKWY/+acTzBFohJ1oXMNko17II/Mg6tiNQ2pN72JowjMF5aeYvC/Ty1lLVMSKfjKZM3V8xXvgqgYf/0k+QMAZFhtzMoOPR/x6N4c7p2H0vvUfQoUaKmivHib4xNjFpCFptvuugAFJwcCu2I1loHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473176; c=relaxed/simple;
	bh=KPUAY9yBuctZ0Z8DerzHJeY3UR0wctdNL1pgFMf9FGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSmgK1YEdOoGhiqmmhOC6lxbgqMqJ7M9jGJK29alBJF0Yq92PH89owNdVk9UrOp3gCeEyPa3lZ0jhmHGlriIJU3oz/amJnmW3k84j1yTSsVh34MABIDhHYA71VayddPCl9JPDSeSJrjPRfn117SuNEByod7kfzKCdMC5OJ7iRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X2HPfkB8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766Pg8G022277
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WCps6Q8o0qeIN9x4RG9gyH4kGs0jBz7IAdjztQ9kO94=; b=X2HPfkB8gVhHoZ6X
	UGaSFjr40YUhmfkdL4cLflWksihvaSuZuA+M+fOXSzmGxb5Dnktg6f4GCr9OHlM8
	7ebYcTFyPrD0xCcDI5jXIILKeeU4DxTzoYtBCARZpbtJUXFcdvKGb71dHTjmlAyJ
	QOmK3B5uZl2eJ0YxPQoMGBPS8ddsERKtfTuM3reV95xJIJcTOYhG7cg6x7nSrLxo
	hAULLyaMzsjTT7tnqKGNn9VvlIqu2P08tozXe6oJip1ixW5arBYeLzhF7ERYDEkE
	6FGPvZZuaPuPiQd1oXBZJ/XymdLcLFUtz59/kSgzfMyUEOFHbkCRM2GGG3xsAFBi
	tsBCnw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8a52y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:39:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3214765a5b9so4559580a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754473173; x=1755077973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCps6Q8o0qeIN9x4RG9gyH4kGs0jBz7IAdjztQ9kO94=;
        b=rdISnoiPeICYKES3T87stMXG5nzDa3fVXbNcB7mN8o5G6DPN7WH5Ab7Awy5aVZzsuV
         IecASIngNiIuYLoEQFWjcVx6vPVTAIRxNdJ46T+tJzwxdgyqcN+XPWmDg23XKFdODfzG
         ASDyNfd0RwRvholLrE3/5mVyDqDhfimWVJ8UetDliL8mjeUJNdYChNapQ2roOiiYdIn5
         j0IjmotJukBJdHpt5xU4cv6qr/1meq5BLC1qVs/f/wvLUlo4G5PKsuA2iIAYsYeek3n6
         WqlEwMkuC2wUI9nVSizbrLdUUZ3A7gAnucd1ZRyFpTwBoPmEEtYsWKECwxPms1icXJDw
         hhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1BlyYtROXrUzzu6Yijiwdx9VimLbToSqf5I99jUkWlknGlb3jyAw2AceKAFz0f7oL0JCwVPvZxaN68y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bPp+5guCjCodRUOLgaG4HLZxx7OE06QxrWXsQMjUuV4qhGKf
	YCvezO1KX7pl+sWBsvZk290PThQwzDwI4rENkXLlrRuiL6cWz+/8IhY/iqb1SV7dVyyMaP2Fpqs
	IEXBO6fVKOE22eoVkhNCDmFaVuAz11ne5a657kkmierVyHaCAOP3ZijGIt/ND4su7TwY=
X-Gm-Gg: ASbGncuo3/ICEYuTiKvd1P2MPhLTiQhr2Mpr9Fk++ZPmAaXTAarPSXIbEMBMqHqtkst
	w76sYOLHDYhg5FoG45kepf4nNQzkAjgAp8DY4oTKHbbSom14EZ3u1i0AkXTz8o70SO8C1UuTCsa
	DzhBbEDwqa6joI8fSfqRePYXSWpFhbEpNep2Hut9fjTAsMw5WbqnmDE/wrkQlUh9krHRkjnJnRN
	dYrTVz7zf8zyH4wKwwFIfhLeq9pFGjPs2qUCTnj7+ANFbnfR/qVpSufUW0KWKY9dH8gYwo4eYqH
	uShWcCKEsnkuTu3yqbDSfITFGRo8oritPoLyNwVfAsfgun+7mOxn6HzEXiDnNoJxOa0=
X-Received: by 2002:a17:90b:1c85:b0:31f:6f8c:6c92 with SMTP id 98e67ed59e1d1-32166c2b18emr2718170a91.11.1754473173338;
        Wed, 06 Aug 2025 02:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUleDTUw5OyRyFEFXLE2Lpb3eq7PVabmsgBfWwCw59gHI5xkfv+3BdVifFFhie4I/XngwJ9w==
X-Received: by 2002:a17:90b:1c85:b0:31f:6f8c:6c92 with SMTP id 98e67ed59e1d1-32166c2b18emr2718142a91.11.1754473172908;
        Wed, 06 Aug 2025 02:39:32 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f61asm15015166b3a.3.2025.08.06.02.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:39:32 -0700 (PDT)
Message-ID: <db8241b0-1ef3-439e-8d74-a3cb86b610ba@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 15:09:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
 <d6a2937f-7d63-4f17-a6fb-8632ec4d60c8@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <d6a2937f-7d63-4f17-a6fb-8632ec4d60c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TPqRxESoVRqLj7hvj8Gyj_kA905Iao__
X-Proofpoint-ORIG-GUID: TPqRxESoVRqLj7hvj8Gyj_kA905Iao__
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXwYkaro7M9zwO
 Avu+pO4SsVfPblduk9KEN1D1KfWPq/bW3cqP6zmJexrB8x6Fjc1lsCSiT5AYElDd5UREjd8jpbL
 U7EYEeARQ7gUH/btppr8EfHafpXofzoGGfF3lbj2xYhDwgc+x2AEPOpmRaHOm61Jg2lCmePYPYo
 9MN/pQXa8ZWEt4l2iZCXbDIBQusonsBGN1QtRwdo5Cft+kHa1VEA+5zYS3N1WfYE+ybLm6gIczI
 2l5xuHqZRD9rD+7hK45TZcCdGl5wmUDiOsS4IW4+Lhf/OECfUH1JrXnZ3s+lCR0EbBDeHRKCgLo
 GRXPpunKJBrHqfCsjI4/ORnrqk21mjK+jo8QKvNRr5PZM7mu6Px/34QaQ+k8MA304GxffGxacrS
 OWUiOAKJ
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=689322d6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=_mglsAVLPU-HLNVybtwA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/6/2025 3:00 PM, Konrad Dybcio wrote:
> On 8/6/25 11:27 AM, Taniya Das wrote:
>>
>>
>> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
>>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>>>> boot. This happens due to the floor_ops tries to update the rcg
>>>> configuration even if the clock is not enabled.
>>>
>>> This has been working for other platforms (I see Milos, SAR2130P,
>>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
>>> seem to use non-shared ops). What's the difference? Should we switch all
>>> platforms? Is it related to the hypervisor?
>>>
>>
>> If a set rate is called on a clock before clock enable, the
> 
> Is this something we should just fix up the drivers not to do?
> 

I do not think CCF has any such limitation where the clock should be
enabled and then a clock rate should be invoked. We should handle it
gracefully and that is what we have now when the caching capabilities
were added in the code. This has been already in our downstream drivers.

We can add the fix to do a check 'clk_hw_is_enabled(hw)' in the normal
rcg2_ops/rcg2_floor/ceil_ops as well, then we can use them.

AFAIK the eMMC framework has this code and this is not limited to drivers.

-- 
Thanks,
Taniya Das


