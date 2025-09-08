Return-Path: <linux-kernel+bounces-806177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E1B492F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F391B209DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F630CD87;
	Mon,  8 Sep 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1IkmVTD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547DE305944
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344875; cv=none; b=GIBdxhj4S1tmn1c7MvV5ifK8eqihJuvzr94ZYUPPrXastRv0x/srkTWePSX1c61OFQknvbzkdZ4WYcpfxe+l/7cxlWIOISHteQKI9f/qZ2KE1DebiZr6DSes7A+OtELTH0A+JcvVFmOHDqrOZS/lqkJA1O/z/cdgamuRv2i2+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344875; c=relaxed/simple;
	bh=PReJpi8e6c+cy8uZc9AKsgF+ro3fiy/sGgR42bM5gzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdWS9DdVK7imzgRPEt50QuxP1FZZhLWtna9yIo+vFfrSQZJhsOFZ7jeW/5luf55K8Cpn9XRBCi/F1i8gX7n0/eRBGJxu9Ibcg1mSawUCzTLtmSISh0E41H5IYjNfCnPXF0tXrPyzOoueG/lO5wV+V1lK1dBMr+t6Rv6acOg1BO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b1IkmVTD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889GSfX022590
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f6Pkzb5kg5j3jhry+0rAbxrUj/psaHYMGrHrVc/RvVE=; b=b1IkmVTDioXYCvCt
	NGOY6mesOdodrYENwnVsGxDKbMOM8N1ZDWhZnwe7KEg2T09hiYFosNFK5sNCFFID
	QQsFpfmAWTm6CK9AhopTyak4RxBI2DEFtAdDzMXr0+sMOXtDcR3JMPnnDZ2F2LXt
	ac1m6HXUzAcNiBDCbITYeeeXTnupsdBwNUQAmhSEg5qNrSLOu7oQ/jbGT47U/rBw
	ObinWYLympLe1DMcq5yZ+CigfODqgc5DUqFqVess2ieX/geqg4qvfo8mqfjuP+m5
	7Lc/CyFhxqwY+1m4ts23U2E7AbTgyZLvmydMPcHxmNFLFaX6e1tlNFyVpA3I8xzh
	YQaHTQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc20yy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:21:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72a0a533d63so3088446d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344872; x=1757949672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Pkzb5kg5j3jhry+0rAbxrUj/psaHYMGrHrVc/RvVE=;
        b=CmISjXbCxrP8dY1xqSivlu/vTs86gbOsy7cXN/53q11Z4U8Al6odvZEx1jLTBo0mK8
         Sn52xXNUzEeXPpNsOTYP4ESyk4jEcn0SKiZVBMcEP+tdv8UXf9YXnBygit6CEnC125nT
         h7z22Ve8FjS4Xb3rGJ+fhKgOMYdHQhGinNR4Odz3zDU6JpzchjLkvwj1n6fgj9KCnzHh
         CX1LF/ITHBCsJK67kuAuxKJreWPMuhw81+foKhaE4Yd17Jjl1EFJRY1SXH/gMMKw4OQ6
         dOI2ob1lLEst+XqZHzR5tv0C9wLvdnAsT2UdHm93QLWAvfJ+n/W3en+MuIUBwhClzqiU
         Gu/g==
X-Forwarded-Encrypted: i=1; AJvYcCXOa1mr2QicHgmk66Twx9pZ91XNFqRtlgDueUbUbEVYsSBHpimwdsWtLr+voJRmZe7WW5KoWf8W60grgWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7AJBF9awEeDlDwH0UOPZDiLMNAG3m6rvIqUYGCjrQy45JFtI
	rbu2UV3IwgRQ7/Szwz2StwBWWnwlD5E9bvNrDGql4E4gccXIXw7jLoBdxmdtGYKy68YuAZ+wTEo
	WQxN69eBFCQGL9Fj5gNxbw2LR5OEZBBrs2jZtoezVnqHKZGVWIs/dobktvBJRn4S9NgA=
X-Gm-Gg: ASbGncspPuCITeh187Cav+ZEl1b7UQ0Zf4b5AURA6OTGXHbIUOe+80MVZeLxz/E1LK6
	rHelY7c6+zqYYV9ZBEcqBvBIDgz9MTiRuaVTImUsJVkSbmWYoy24pFUUlDuT0xUOQTkRzndJj/m
	DKFhQe6GdLYRZqb3a5R0/gPmnqSrSPqEn8nTVeVedcJSvaxjo40asIOn6bp9kaye3g/HmlX9IF4
	l3bwRiSkcQEFPrGv/eH33/8g38wIUh3opXCYH7y6KNERnZq5VkDQGDbMYrMwWA9sdchfpN7yZk8
	uHiFb5M0bPu35lxIgED5+292VJMr5KB04dq5r5wgB861w5oMiOD/JrMPBF/2QfNk7Fefu+27JQb
	tZdqtyO4EM3mhUah8kPw3ig==
X-Received: by 2002:ac8:5787:0:b0:4b4:9d39:3432 with SMTP id d75a77b69052e-4b5f85322c4mr61314841cf.10.1757344872108;
        Mon, 08 Sep 2025 08:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsQXC64Y9u+F8HSfWVUBHFUIev7jGr7kCnI+D3oKSm/zJ4ylRrmHPoXwe05OfIypUYK6l3lA==
X-Received: by 2002:ac8:5787:0:b0:4b4:9d39:3432 with SMTP id d75a77b69052e-4b5f85322c4mr61314421cf.10.1757344871484;
        Mon, 08 Sep 2025 08:21:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0409bf055esm2249764966b.85.2025.09.08.08.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:21:11 -0700 (PDT)
Message-ID: <f034dd83-0f50-4632-94a4-ff68400dd922@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] drm/msm: a6xx: Refactor a6xx_sptprac_enable()
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
 <20250908-ifpc-support-v2-5-631b1080bf91@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-5-631b1080bf91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68bef469 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=vomQ-D7Nz7_NnwrRMiMA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: w2ytzPk3z09Y6WSHCp6tmnWxdW3wdDUF
X-Proofpoint-GUID: w2ytzPk3z09Y6WSHCp6tmnWxdW3wdDUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX2A1HBNPWd9Ac
 k6JdAHDqsxc39CYDL4HfQNzddKs+4JjKZvGqc4jEbOSLOLXNkmy9kTWH9vOSdlJbZHz+kHfOTLz
 aI6L0bfjIFk7Egi3q90Ao/sSxPmHdoWZEFHD9ly63IJC/Q7d3hteaU7w7Zei7n1XMTwgHmWlktc
 8B+Z1qLO2R9Fp8lVAlysUTCUpUzAOsIdV+C5u7hswk3RMm1YE5bL4IirjMJElS+CGN3CJ1cU9gl
 DDctIjd74IxnnpDfCnmXCbdBxlEg+pQsVIjQupdZC3orV6P7wBFa800X7XBEDrqo+qwXN59rZpQ
 Ivzn+LVY5irhmbjqHmFnptzJq4iO+FrKdFLJ9SaqVKG6plIMcTsaEPk3qiFcg3Cx5thAFT2zY0i
 6YvPiLy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

On 9/8/25 10:26 AM, Akhil P Oommen wrote:
> A minor refactor to combine the subroutines for legacy a6xx GMUs under
> a single check. This helps to avoid an unnecessary check and return
> early from the subroutine for majority of a6xx gpus.
> 
> Also, document an intermediate unknown low power state which is not
> exposed by the GMU firmware.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

