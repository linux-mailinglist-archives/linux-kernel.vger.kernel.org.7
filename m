Return-Path: <linux-kernel+bounces-865588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D4BFD900
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1553B5038
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63DC27FD51;
	Wed, 22 Oct 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kxIdmDez"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB51C862E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152986; cv=none; b=BMfhCFv9WU97/ok+c17zsiKX/YB3q97l/kW5cdrtx1/oWSVQnwpAyrDlb6ZfwveP1mwcM2EZG/Xh7/1b0pzCJzxA9SsywpDICSMMxcc1ag54ZZaoRKCYVEZIO0HdXMRL6oFZOxN4UBcEcudZKJ+OBpmU/p/hnRbwSjgzUdxdTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152986; c=relaxed/simple;
	bh=DzkNgsms+I6TVQ+SQgJ1gRxGxqOmUsCmMiXjDyfl1q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8tszOnQXSjpViJGxAFmmNH8j/pEBQabl0nC8+SmdXQIW1Sn8c07NzAjJOOCUh6x5sfHKIb4ZUU95s3F+EcUCRSw1FMLpzOU3pzfrNTosVc/OdUhgkKKUNDeaQdFjzghn8cMXDIBmeTuIxc6BsIxQ2peX+ZLOqnKaEoOkP+l96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kxIdmDez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAC4gE020555
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DzkNgsms+I6TVQ+SQgJ1gRxGxqOmUsCmMiXjDyfl1q4=; b=kxIdmDezDNa5INVo
	j+mZbb5VZCN0UKvJBgcY+goSYKjAAz5lh9593YTsgwAGhsjfkEwbTuvL2UmOGhSv
	8myPuqr4Aqk8ITDAXJc7A/EX8gKAnHEZ8TSEF53kZlSagfdpx6Wf51PktRdNuVtn
	/57EN/ydY4tNsHu5ajMNzayLnLOuYXQ1Y8d8xU9uqDzpGOtmz+Pv4CWll27J5Eg8
	7w+AWPKYLjZg81bLJrrVtPaZszcxg9NPFFb2R2XuwN1IDZZSypycypOwh7+iC8Wo
	VfMSt82Bb1AcuuUjg6JzBlq+v9VEsoHFnz0t1y4Op0P7Hx5G6Wcg/xBozhuUrdhb
	eVSBBw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3445gs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:09:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e890deecf6so2298181cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152983; x=1761757783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzkNgsms+I6TVQ+SQgJ1gRxGxqOmUsCmMiXjDyfl1q4=;
        b=AgXXLAscSga/CGi2ZlaQ+ydWCIFthmyDso5H1/Sn219OFySq+wHkmFLKz4POUAI0H8
         nQnDXxAQfGqCa+ii0ax7U49r1s8L6OP55yJBsz4j/r62WXZGujlQjZJpwLTVnPbRLMWT
         loqE/uc2MAEROlZpBJLq26AHlnxRUSbD1mLumxOByyNNNpJPriWpFPtER8NViiikQPJz
         WshXOa7Rv8ahgNkmUOKnD5UfbiO42oCciFQ8XkthmKoXQ8Qt1F0c9wgkM7yITaiHpxBU
         272X4lEKKh9LGXyFBehWIf0UU5iCLTGkgrXLDQyYAHcjeGVO5v2j6cjpr4nKd+tp76Oq
         Y9aw==
X-Forwarded-Encrypted: i=1; AJvYcCX9m2HcK+7X/OhIC6+a8dQtf226SOObKUu3XVaGYhxgfErRdyCweb2muA8lY44AttBcA+7t6mp5wkE7TIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxPJxaL/hUJdmrjbR+gSSBX1LmOZgWjTbEOQ32LqcKu9+a9vf
	iXVmFg6AEWF89AOI5Q/mqAyGkSqfyLOEbsICe5zadpiPmEqEMQrpRh45zkkguPRu6DxKgV8tSIv
	Y//YhCbjzwRx9cySr52HRyfIlh21TAvlUsIUYBJ/tZNYZ9TBKwHPYg2hCftpdHRcQxWI=
X-Gm-Gg: ASbGncsWK8Sb04hLUhcKFQGRnVoz5Z1zwWuM1fy50w381WJhBY2IrUNWIvagnvWEooc
	RHqfpXyYOcjAQ8niIC4n9oEuHTOm2rgzTbr9SHS/uik7NO/dFs7NVpb9ks7UGbB2V5KA3oIcl5F
	6pbwOaIllaQw4AORjH+I4mIbjO+oe11vMBKBtmV4DOSy9aGf2FKHrh8DauExHpK4KcDWDfrnifr
	KQNFn22x2Sm3fyZonMHP6qMwsjQKwFdUBj48GeTULBXGFgWj8dvKZISrt34jHBfMWqRhEt9HHBM
	FzeIk4nofkuBD7BbUXUCq15UG0cgghNTSaDEPJ1r5THTxN16QBnYS89QC0G2Nf3cq65whUBVN9J
	g3CCtySNLBFLHtUF10RNv3aXPcVgYdMF4EBKbNyWAAewR5QLd0DwRyfFO
X-Received: by 2002:ac8:7f41:0:b0:4dd:2916:7983 with SMTP id d75a77b69052e-4ea116a0a71mr62626691cf.2.1761152982639;
        Wed, 22 Oct 2025 10:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1zbTlPXlUpM5403uofnWKWimc8ISr4xjVjYpjAA4lEcZwdbtZU9LT3YujrWiqGqdomX+4jQ==
X-Received: by 2002:ac8:7f41:0:b0:4dd:2916:7983 with SMTP id d75a77b69052e-4ea116a0a71mr62626281cf.2.1761152982190;
        Wed, 22 Oct 2025 10:09:42 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2bc7sm1372236966b.16.2025.10.22.10.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:09:41 -0700 (PDT)
Message-ID: <5d6e7303-cc57-4a50-a9ad-b45d3c89d045@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:09:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RFT] drm/msm: adreno: attach the GMU device to a
 driver
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kG2fUYu1TMJjg41T8GIgaCvfrleI7y9W
X-Proofpoint-ORIG-GUID: kG2fUYu1TMJjg41T8GIgaCvfrleI7y9W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX4U4X4ChMY4V2
 dECjZlQ27IjM1KV34kU+7rOdKKAWv6U77y+v2UNqjvoBnDH6MM9+mv32NAklmBZ+ezMRL/ulwTU
 U7RvfR+5QekK+05NmbPPGUzrgPRLxIj9UZTmD7sh128i8r5H2QColXN6is792GKHF6YMwIgkFXf
 +w/m6rrEiKM8GRxqA1ukOso/wIoH/Fz0/YxFQTAUP0vEwvGMW67kUvHc66puxwV4GLKnUJ/WbmN
 KtONFHkhypSjTYHxzc7N/RaCzIF4LB+btlt2/Jbj+U2KBb1A48A5wj3KsJJ33aSY0kQBH4+V4vg
 q54CUsRxlCpeMslSqDBBVyIXsUfahTduwiOKTaFolZN4tyT6BC5VdyrQNDcnDcRxzGUCZPSq/9L
 E3/ml9Z+l0vGU1sELXp4AsKz1fFpcw==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f90fd7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PIh8tp-2QVCGfq0cSFkA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On 10/22/25 2:44 PM, Neil Armstrong wrote:
> Due to the sync_state is enabled by default in pmdomain & CCF since v6.17,
> the GCC and GPUCC sync_state would stay pending, leaving the resources in
> full performance:
> gcc-x1e80100 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
> gpucc-x1e80100 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu

Does this *actually* cause any harm, by the way?

For example on x1e, GMU refers to 2 GPU_CC GDSCs, GPU_CC refers
to a pair of GCC clocks and GCC refers to VDD_CX

and I see these prints, yet:

/sys/kernel/debug/pm_genpd/gpu_cx_gdsc/current_state:off-0
/sys/kernel/debug/pm_genpd/gpu_gx_gdsc/current_state:off-0

/sys/kernel/debug/pm_genpd/cx/current_state:on
/sys/kernel/debug/pm_genpd/cx/perf_state:256 # because of USB3 votes

I'm not super sure where that sync_state comes from either (maybe
dev_set_drv_sync_state in pmdomain/core?)

Konrad

