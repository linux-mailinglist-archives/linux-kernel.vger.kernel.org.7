Return-Path: <linux-kernel+bounces-865293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F025BFCB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E14944EEA66
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272521FF38;
	Wed, 22 Oct 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gWwrbQ1V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203B32B9A2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145050; cv=none; b=WxUh4FryOoy9xO8IwRec4nl0ZKRykCsoXzOD7n6rzu4RjkE20R4Kwte3gW2XlC+PdJNkMszGBLXksEpfzgCGhS7wKL3rORsKTq9T2BcwzQvyyFK9lo9Ml7M30e/Cw/lJ9X+kzybE0hqc7cj4ehFJcg5g1Eir7jsizcb2Q3GQGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145050; c=relaxed/simple;
	bh=Fu/xZENpvKUDCqtMVUsRDY9BZMxdH6Bd0VluzWRBRqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tw4GZ5B5hUgRSMt1K0ww9f4RiE+GYywntWq/9WvuksyUyE6VVYUoNZLpqeVv3ClDEGVN9A+WGJxDz2QiJdMa5jbrV7ffSDlcNhXRd1cPeBiiBg7meVbVFYDu3ekPBjdPwdpHb3bXyY6vcjn/gZZPGW5C8lVdr/38VqAi5tRiqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gWwrbQ1V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAQB6D005242
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XHmPuHvbq0iDWkg8ChnLVtyO9U3YUPXFEyBFJyWCxv0=; b=gWwrbQ1VD+IlmlBq
	hY5PiYCQFfIANZ07H6Qo9wpdzYwreFrr/7Og8JkvInTDEV2wq6jfRs0J9R2gOl6h
	XIpssiE2Z/qp7wYQ/u1u7KzA5oJ5rKS3P7B1ArFMFzwcVmtYsMgb3oXQpXZCibin
	DWFJzThd+udW5nusWLzWiPAOE3/DmrC6I+0mPEcdvqYBW5yWcC+qB+QkX8UjzA3r
	Sr5TxZvO7eydoNA8l6pmx7ya5zG1vKK6OPU94spFJqQItlPioJybGwQpTfm576w/
	IAmIKHZoASkXBjuN7kEsUAC9j/TbH2LCAr6adXi1h4EGfMXLB5msMhDboEs/WR9C
	PH7kAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfn0pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:57:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e887bef16aso3976231cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145047; x=1761749847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHmPuHvbq0iDWkg8ChnLVtyO9U3YUPXFEyBFJyWCxv0=;
        b=J0sAzCcUFoWPmkp5oIKu5luWHoHkN0kTAWzsNbLULKuLrRVjdMlG2Hm2aNISyJCAyc
         9OIter9n91oIwJtxDpM9xTH7AOscL2qU8CdzqhJFDKF8QyypNi4fm4y9vMBXgT2Of389
         I454Xxk7U9XGOIIqSLeuSONmgsHEqLPxdA1x9YQR14kedUQfA70bViLhgrorh9ZNI7Ww
         MyY44pYJY5KcD+55pLPzb4Z/dW06QeVdAHU7Vq80EhD3xueeQ+siiegbEwgJsR4wOqiA
         Oi/47j8HYLFLsoiuc/F2VFe/2vIPM/jlKiJYPs7c/oDXBZxNkoT5Z2h0mf0wAGzg8AtV
         24Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVqyHGnQfZpRCuLyZekLonp4TZdW+A5FQhsQ+CZurJrxbMc533fq00b1PZA1nmLfOTTi5iuCH1/tUfk1sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNCe+ZyfNyNfZ62MtVP9M99kO/o+I8Ark3fYYyrPxYUb77ChB
	SHtU8fbTLBOiPXrAtAvo0+5B6rNkVypYVi7+QGYAN1YG0y5saiQyYVFX5jUSZ3QqFTGKOEtImpb
	N+iSTD/8wEPPlZ2Gy29SeBkkOyQnkNm7MOclX5W1Ljv8CEd/0py/dr64wYBVaso0IJkc=
X-Gm-Gg: ASbGncsmGvCb7mnsCd6dt4UoeGCy3I78U3MWk+KnebNzcKtXcJgw9ZaYVJbzS7JZMra
	+FK7INmJzZd3yht+5jj7w7HdLHEhLXy90pYFvs/rv79zljRshqdE4OXGY12ueOjcgL6bIP3aInF
	OpEe3zE4Ltqh7daCuIjMYMN6EOmIM6Xo8fHipT638L2o3NhP5DOOd97A9OMHFteRombnSU9jM3p
	Kuesh1NufAhaoZZRmQP3rcdffYTd2nWntAgPSGysFaYYBrV3ppjLNv8Akv6EEiVMzzqCoW4L26k
	nXJKlCLq90AB/5/9kvYBsRYO3gR13iarph5mXUV8lrHWY1twmiwJW+cSY2Zdg+wyqRp1Mi7pHHn
	MtN6eqf6GftW++CGjreXpLBiZVwixmA3rhZ/OVgXSGoxUf7EwXG8d9XA8
X-Received: by 2002:a05:622a:199a:b0:4e8:a9f6:359 with SMTP id d75a77b69052e-4ea1178251cmr60623561cf.10.1761145046755;
        Wed, 22 Oct 2025 07:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzl5V85OA3sPbLu6H91feQiKyMJQoUwjUyJ/NoAGCjE35UPb9mS8kIWjXkh9TqTGBEiHskXQ==
X-Received: by 2002:a05:622a:199a:b0:4e8:a9f6:359 with SMTP id d75a77b69052e-4ea1178251cmr60623311cf.10.1761145046263;
        Wed, 22 Oct 2025 07:57:26 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb731fb3sm1378835766b.69.2025.10.22.07.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:57:25 -0700 (PDT)
Message-ID: <4e3d6a1f-8bb4-4232-a629-2d20ce08ac6b@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:57:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hBOW4CAsEegf9G5h9Sw_NLPPcHFn-Ced
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXyJRROfLEZxy3
 bDHCzC3hKysvlDH2hLVvYxcycq7IaSZP6jlI6LrNCtOMtknIj9/4filhh7kLdGpld7VJs0ZaaR8
 c14XeL/UbuXmb4uCTPgsp6H+qptkylLMFYxA1iYvFsyGZjteVec6RsLb6QyHAqTyn+fZFSFJiek
 mo7mXyRkSBMpH3boE117pKWZ9MYpkfevsrfHqvVoSSm+tYUgTR5BAB4B4VQCdrSblD58HQ6WqWL
 aM42lShgYR9uZiunIYwG4z97N8GIXTPtCELKYxRv9dkVWQUK8bhsKju2Q4KdrVaU23le4KYclbp
 d3kylgsxDRL6iKMupUCgWHUlCf6IDFJR/ytxccLtpmblY7+uGaRYQlwMIicUjQ5cUc/MuFFQRTk
 hZlYyFcHtVxD9474e+o5Qkh2F5KXtw==
X-Proofpoint-GUID: hBOW4CAsEegf9G5h9Sw_NLPPcHFn-Ced
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f8f0d8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0w8jFtCSA42vhe3mVSsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 10/21/25 11:08 PM, Kamal Wadhwa wrote:
> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
> is called to set bypass mode, it sends PMIC4's BOB bypass mode
> value for even if its a PMIC5 BOB.
> 
> To fix this, introduce new hw_data parameters:
>  - `bypass_supported` to check if bypass is supported.
>  - `pmic_bypass_mode` to store bypass mode value.
> 
> Use these 2 parameters to send correct PMIC bypass mode that
> corresponds to PMIC4/5 BOB regulators from the helper function.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

