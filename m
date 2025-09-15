Return-Path: <linux-kernel+bounces-816255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFBFB57195
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9898189E0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6A82D6620;
	Mon, 15 Sep 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9hJLdQe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C502D46AF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921679; cv=none; b=MLLM8eiG8hB185TDGyA6AW6vMZC98cz619w0etoXSdQjgsiFeeJOiSwEY074Cp/+wWn5jIdZh3kbzO2QzqKyliVIIF5iu2h10OQhQAuyfXtn5JdhdvZ3CGKSMJWbV7pSde/otlxQmMNhu5W4RBaWyFAnBwRIxrGmW3E6atRp9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921679; c=relaxed/simple;
	bh=pA7xq58Fqd27paAbgr3RheVO9d78UaJb5yfTRDMvo64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtoNsDuETCN5YuVYKKw1PIC5Uy/jwAAjcEY0U6REnGNA00cZskC7kISs+Dfgz1yhgTjaERIMsIkhOZpwjxOyrkmPJuLOv0VSJhSfjqqTRWXo5kaqefoTU1WnjbsDTOZ7B+afDpv6nNQPuJpL0UqSOylrdcc48rj8ZdB1dA54ZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9hJLdQe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7I2Y2016738
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w4oCzwIzZYIKPOJu+YqMNrlbG390YP6aeKNtC8d1OOE=; b=G9hJLdQe2GulXu6n
	1EdMfPas3FfDfPhKzVmZ8TTFKddGgtSGV2ex7iy30aRrXTGbk/D5AJAGkact2jK2
	U+rYbzrrif5Tb/78i3WkTnmhqwPk1YgPTz82gl7jmyNPKYIMQLa1ASa/jM1scJMb
	MYnL4iuvpLZ2uiKIP7P1yRTGkDMMCY2981hM9HXXjgSaGshdAxfYgfmodERzV8Rq
	k0wZ5XFGOl89+Ab1QobSZAAi4/vV6f8UJ/LNAw+obdGWM7xc5FSv1XPn5g5v0W6C
	TYObtLf2VTbaSyla5NXYacyePYYTS1KiWrVNxvpOCk8ISrTEuNX/IcynjwQfdKhU
	TP7zww==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snkr47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:34:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-780e20b83b3so4049726d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921676; x=1758526476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4oCzwIzZYIKPOJu+YqMNrlbG390YP6aeKNtC8d1OOE=;
        b=EOqfTzSeOFCGc5dzi40xwsUH/kyXEIjJhRs7hpbPzEsZKbBt4QeS19ifIq4V4RzuMQ
         SNp8STx+HYSjqA/LLEHA08Y4vruB8SmaJHp37KU378GBQXOC4QbJ/xELVafBOQwr7BKr
         xUoXn3xE7WrKCptRbxPR1WUbWsYeHH1KnINXKfhe5HC9wH9e/vZ2v1cXBj0/EpLPx6WM
         s/UZvB31T5aWLjDAf1XW5CYIY4HzZ8oFXciFTdM7PkbyJGMUa1DQC0259YGoLyxSB8Bo
         Rp0YiIW5Kz42B5ZUDBogbPNzRXWLLrP+oa1mLLnzrKMrR0B53EGHgMgD/aJVLm9S3OO8
         kW7g==
X-Forwarded-Encrypted: i=1; AJvYcCWNAsiLpUKCfkuBayF0MZl7Rw1EGX4oFGbWNJNC3aIEwHJc4BY61gvSiaQwkNQuoRZMPd+a2y1WottiYQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0V5DI+JVrODrScf/GBSF2ScsOKo2Hd/4Y/02J8TJR7S/gJy+1
	Zng8nOGuVq3jrbcAEac1/gZdJrL1k4SxUi7t5sxp+QYpi4S3Gl+rVKy9HqdEuDYkkO/ETk51l1b
	VDnvkjEEOdZDYBvCILV7apAwXgnupkbDs0fGg1Wzwoab4CgL/+AihLcII7T7UkZx+VFlgom2izk
	c=
X-Gm-Gg: ASbGncv8bZrj2UOrPkE2EMes4ydKaDqbgEnmowJVn1Xth1aqfUloVbBU1C1P0+UuzOa
	k9/ZVCKg99xSEjn4LENaWX7aMgSXoBiyXvzDpGwcEpjRPNS2l+Cjg5Kbd924SJMuPpqRFR05PLC
	aA4y2bNwBLULG5AZQjhlVN7uIa5CePsmWr+EOzXxwdwAZtsryKPkzSLJTPHmBif8fWynlflcO1e
	xBnwMXTvMafN7Q6XVhpt0Qu2Nn7wZakbijwyS8m/rlbMm83z2AUGP6n38Z8NKS8G7HQnjYO5/AL
	5UrpdEqEEB7c+h2jiTF5+3JS6MYnCYGF9TLLDJGGOLlTUNEDLdU/kTbnojI763KZDlOPUw/vefi
	BgQNLVVaEp0G5NakIA8gmeA==
X-Received: by 2002:a05:622a:91:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b77cfcdec6mr106907661cf.2.1757921676136;
        Mon, 15 Sep 2025 00:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+u642mK5pX59NxQG3Z3A6Le4TijvPukrqmOimpRbxXKQNPvZpPbBJQAlASOVx2+OpCvmMaw==
X-Received: by 2002:a05:622a:91:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b77cfcdec6mr106907521cf.2.1757921675693;
        Mon, 15 Sep 2025 00:34:35 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07ce4dbedbsm611094766b.9.2025.09.15.00.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:34:35 -0700 (PDT)
Message-ID: <281701de-181e-439b-97f9-4bfd103f7977@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:34:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sdm845-starqltechn: fix slpi
 reserved mem
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250912-starqltechn_slpi-v2-0-5ca5ddbbe7b4@gmail.com>
 <20250912-starqltechn_slpi-v2-1-5ca5ddbbe7b4@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250912-starqltechn_slpi-v2-1-5ca5ddbbe7b4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c7c18d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=958_26X1zRvj7spRbiAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: p7XoN_Hvm4F1KEfs_moCT2AwM_PAR6Fo
X-Proofpoint-GUID: p7XoN_Hvm4F1KEfs_moCT2AwM_PAR6Fo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX7mHgV7FOJrTh
 Mqu8oAX8r0gzolQO7uZiAuHg2kNUfRDiENWOJ59t4p49zdbCBInm93T8zlmas56vB6QaADIU6lG
 vLAvg87SiCoFM5GqcWLDbYlb/y2qHPia64FG0BEUgE1VxSKoWc4n8J/ItwMMZyMOyYtS2JxuXqT
 W9CM4XfL8BOWG9PA2DPll9yb3Lt48B2T7KWB4dHADfUkqNnWaupJT3Mtr487hZiPpB+tETV6IO5
 prtdCcy0eckt5lpVaq+kBGBvHSZN5Aqc9nek1w5JT7SlaAFJ08nju1L0BfnV7jQGjGPrzIKbDQK
 +M8olqAT3WmymT2nPEqLP/ZmlWcWF/LpvU5j/oKSNZFcd/opk+puL3C+gMThvVwZNerlk0pCtAj
 KU/IekKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On 9/12/25 8:56 PM, Dzmitry Sankouski wrote:
> When adding adsp reserved mem, slpi reserved memory was shrunk
> according to vendor kernel log:
> 
> `Removed memory: created DMA memory pool at 0x0000000096700000, size 15 M`
> 
> However, kernel failed to load firmware with 15MiB reserved region:
> 
> `[   14.885885] qcom_q6v5_pas 5c00000.remoteproc: segment outside memory range`
> 
> Increase slpi reserved region to 16MiB.
> 
> Fixes: 58782c229e3e ("arm64: dts: qcom: sdm845-starqltechn: add initial sound support")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

