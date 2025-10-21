Return-Path: <linux-kernel+bounces-862464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28CBF55D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C12A84FBC42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6379D328B7C;
	Tue, 21 Oct 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hO+9qRbk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F92609E3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036712; cv=none; b=P99uyp1ltJXr4YvRymXm1TMfY2JIGPXNTQ5wNGV160YkVAjU1+kRckFPzlE+x11rA80WlghdlFJNCAkYBr4pQ4kkIBEMTi4XNVA/2RrabzmcwpgoSTPBStT2FVP75B4P2uQoldUjZxFu7zSwa7/UWKN0QSPlVVZC2PhTENTAlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036712; c=relaxed/simple;
	bh=3Wm+qPQCGhquC1sqPqCbWcCtKdc8Ariy7FO9EDJ0/ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XC0x8YAgBiqF/MBxyhh6WE3CbeBvunXjnNedsQIPeyXGlmbgu0oqEV2qQerD2N2TIQDuE1bSAx3R7IX3txUR3w927Fy6GPUHah5OyPKP+7TU7JYNgqqqAMfAyz1XdRDR6xrGhbZrrN3m8J3+dW7s+a443C4BLuD1gEjWk2i34vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hO+9qRbk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8RKYn027828
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Cu3mLCBx8dTdYk1x4AduwRqyoGHAAaN2BS60IdnX4E=; b=hO+9qRbk+V+obYOn
	rHu3WRM36xGZHGHQPFTz52aBhWND7Yx0cUDCMo+8rB9fa215pPpgpBLiHI1yQfMl
	9CirO5aTGBFSPQEmNqN5ZEs2yfes55/mQbR7RN+vAwiKnBbWbItzuqgpcRbtW+jH
	aAJOmQ5UBLbzpCa+wDally34XZJYFaPbtF+ZBHdqKnyh5boIEctDUwy/02/H/Ovj
	aE1dttX6JgHoo15iO3TZioTT6jk6I74+JeCgBxD1R840IzHglJp05PRd4ZDL7wVs
	ohj/8TI9knQa+pd0Eo1TaQ0sRytdbT2925yDRzcE9GENSous3wcsVDS9BuEyzj8C
	C2OfgA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j00aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:51:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88fcb38d0d9so271427485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036709; x=1761641509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cu3mLCBx8dTdYk1x4AduwRqyoGHAAaN2BS60IdnX4E=;
        b=Rv6k3HJQ2jh2Yh5ZSAvlbPXgxTkYhakC2jNe6rTRI3ASG7pDc21w774wbLIpRhe8yr
         3b2LsV+nX+o5NpQi+XWW/uy4mEw4pNg5VpcxPWN+XaK7FErZgHm/00a0JNYIbYZwDgUD
         z4Uyu01JUvWTYZcTlhKDQGaveTkJ01MSoqtOMrM7z8BxdIIGkQ7RshX886AFWjEWhSh9
         EpP+jZhf8Q/0YcNtcTBqEyT6KKrmSrXsQp9NNDbA2/3sc7J3EFy2sugP/fOqHIUQ+pQW
         XNMFa9zi4v3tvprXaU4QfWyUuYQkHK5mmv2dwAF5f1UYh1g4X8aiOCXRlkVYI0x7CvWY
         Uk2w==
X-Forwarded-Encrypted: i=1; AJvYcCWCjUM8zeykfF0RyfKdYuROPbyotolhJuT1Ii3ri2B2RgtpE92y1pzRF9p7UR/ctzai4CESN8rCU/6MWkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2X7AKm8VIO0HB2/ii7nAzIOY0G/HPnum3TLOupMxTFv4fxajy
	Pektr0PlQ7/RDOtqJpBKnC4MNfQ21NZIsEV5a+YnfUS5ILo0EiSia1eAO6GYxlym0Q2OEpKYEx5
	cxbMj2KjZDokOJLivfDtlgn+Zbvq1hSAzRKVQmD+4+S+VPlL4XI5KhouTHLEc3fSIAWo=
X-Gm-Gg: ASbGncs3u99vM9jo8MXqxrlDvQC2ZXv5Yz6LbUCHkERpN/LfU27MzHm02C+Y7tGMWlZ
	zr0OUXHCekl9IWuka/PENqCylWl9oXucRJZvdlP4ddlRxum0zILx6jb2gCOFFOXIuDsc/+0Kffg
	HvckdA7kGsQPtWQu64ktGe5VFPY/nRPNqR86fHa9A4xKqS+s+ghyoF1Ry/ZiVV5lriR+Nt6J68/
	fSTfrSyUvnCJq40u1lPEF7kUBKgTjFxg4JltcAUrpgCdAgkSukCm9jMVxWkfaLxeG9hT2zW29gM
	6MTBAt9TnV+QTj/UV09PMULCvVZBQL6UuLDXNOL2CQgO0od9a/dfaZ2bKrTMmH0okPq83/p1C5j
	e9NQ7NeNsO6CzxnyZstmexBKzuIVl84UFeihE5Y4JtGoelivtKC2XjpyE
X-Received: by 2002:a05:622a:548:b0:4e8:b910:3a7f with SMTP id d75a77b69052e-4e8b9103edemr75870131cf.13.1761036709406;
        Tue, 21 Oct 2025 01:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo/ceLdhKb/3TFYDA9gwxyTc8Bl+sCozFYSPjysEgI4X636LoRjzay/S1WPzMNJ3XSR/vJZA==
X-Received: by 2002:a05:622a:548:b0:4e8:b910:3a7f with SMTP id d75a77b69052e-4e8b9103edemr75870041cf.13.1761036708945;
        Tue, 21 Oct 2025 01:51:48 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a91e86sm8907155a12.1.2025.10.21.01.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:51:48 -0700 (PDT)
Message-ID: <1b25aca6-da6a-4f83-a0d0-b1766110f83d@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 10:51:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: gsbi: fix double disable caused by devm
To: Haotian Zhang <vulab@iscas.ac.cn>, Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251020160215.523-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251020160215.523-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX5Ws7myViCSog
 YEDRl5S9GegKFH5CdSliL3RZGrj/yrksWU9ay5e89XZdiR1DVcohPLy4NR2j0AZ5uhI+7+zPocx
 adVuiiMNCxolVKveo6vVScyILGWEAwjHlfOuhDJa9XuW7Z1QjXadp8GQew+ACGlELKZcqkEPnFz
 fgROAIAmaT+DMMim1NPyrWjC8roBx14o69p8xUABo1hAna/djxLmHnBS3ssEi6XlJOUWBipnJfK
 mxrCAWViQQc/rcvF+Mjyh4XWEd/ce4BEI4Nk7F9jOytJFeM4Kkt9uSGVaRylyF2VtufR7AnBm4u
 PPv5nV9kxITCZXeWMdeSyZ43XtJjDoNKsBhHNrWwG22hXYQqi7PYbPN7XEzCW1+Quno6waYQBo9
 vDuI0BM+gyn38LXN68fqeA99pqRmfw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f749a6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=b-gHXUNBb4A4jDXHR08A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: BUOndAxGcR8PRPswprH5BuyO3BPk7qc9
X-Proofpoint-ORIG-GUID: BUOndAxGcR8PRPswprH5BuyO3BPk7qc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 10/20/25 6:02 PM, Haotian Zhang wrote:
> In the commit referenced by the Fixes tag, devm_clk_get_enabled() was
> introduced to replace devm_clk_get() and clk_prepare_enable(). While
> the clk_disable_unprepare() call in the error path was correctly
> removed, the one in the remove function was overlooked, leading to a
> double disable issue.
> 
> Remove the redundant clk_disable_unprepare() call from gsbi_remove()
> to fix this issue. Since all resources are now managed by devres
> and will be automatically released, the remove function serves no purpose
> and can be deleted entirely.
> 
> Fixes: 489d7a8cc286 ("soc: qcom: use devm_clk_get_enabled() in gsbi_probe()")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

