Return-Path: <linux-kernel+bounces-834122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B4BA3EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3414D175E91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC916F0FE;
	Fri, 26 Sep 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izW9npQS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126712557A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894402; cv=none; b=DJBlAEQUtXm5YAxrJEb3Y20NHiBts+u82DRQU41JADrkBoeWw4z9a3T7/T9GY3tG87DxcggVOOyDd1VDd2uLbhHHBTUZP/7luxIm3c/cZXhtcJ0BhbZXBSRlEbEfG+egz9ixe+U+xxtnd7z2BIrlZjNzAxpX31gZ3t2Kwcipzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894402; c=relaxed/simple;
	bh=0EOjaBswWQvC9XmPVf+lr9JjN3BYmeqPrTnFPJ0cBnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3Ao+qy/Nr+P1ie31GyZlBKgr1kz8VLcIp6TacC3R4pCN5xwLUcZk480qGJ4id6ZuCvrfqGs0tPj3XZS/8d4q9Q8YO5D4G3fwsK2XHvDsDoAtGsgZ0uUx5h6Y0Ruv3381wFULEf7d/kJLMloLhhDtEuHdeZUQXG4s86PZURLG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izW9npQS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vZqM018159
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K7AOC2kVYXtte+/8joVQrCBNjRIRBFVGaIEKx6zbQkQ=; b=izW9npQSUWtSxCLc
	pEg7K8+BzdwWdQnB8LNP7gDOLBkDqJ/NohaFqQSxHW2mEaLLiKYV5gsVspVxgKQi
	Hx2y0ZadKq7eESLbdA7bKWAinffirfliMJn6ow/F/Z7w7hOdQ2/1jscNP81Vy0c9
	exDNJW4iGXKb/6TKLQ23gxH8erIQJf2cCGUTKtu0INSjVrQQqKGyiAuQwVIkCetc
	kXh2rkyCo5qV+HvF4TLUCJPD1PeCfwugk++GlNWR2n+AMgf3ZyzM76sbLCTZ263d
	gaVR4IUTUFw4MQ/5mOed1ttHXkoQqqFmEsDxlgUIdqtmceCtzmdTrLoaVRtgc5OL
	c6XTng==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0tb1sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:46:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7f4bca2f925so5198986d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894399; x=1759499199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7AOC2kVYXtte+/8joVQrCBNjRIRBFVGaIEKx6zbQkQ=;
        b=u2oiRr/kokdDmdwRGIAwrhN5FEAWQTyLQoYJk8N9VY5FUz68bT/Jc78aHtSea1EIL7
         O65ymaPECanZND8T64CR6Od7EC9VkgtRIrvl5DoH4Yxcq3/anb+ZDHQhZvaakgbu98WF
         6tbItQLJbd9ac0HwVanorSgqXuZiUQh08fGsmmSzFoN/y77N+lfAmJRDlV9S55QXrK//
         vSnsaXHGCnmfFjbNqEokmU6S/ZAW9Cjmj4pYS+vDaKfFyjNvuBWsJ16IKyMPAJko/J/a
         Cj8KB7YuZPvsMjll2Muf8aoLo/ulGnk0Ejv7Z7TM528VJ99m4u5sbG+epayQv7vRl4F2
         IX2w==
X-Forwarded-Encrypted: i=1; AJvYcCXV69eW2gnn8v2UIFAHPmmrAAQANJkrU9IvW1vKZj5E3DoG/3VbD2Tpyz+SE+xJGqmN4Jl9hpkSNHeFhRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxciYc5Yak91vCuHsV2E/hux9BxIda3pOpFJAUMnm42ZhJzI1mh
	fw9pEAoWyFETdMTieWjUwGzS+yQL7PhxDZXDCXbmZs9WDpG3YXo1duNMAOUzV2FCIa29146dOo3
	lSW09w5DLGx5iuuYxqVsANIHZkeOaXhQMlLJyqIhCz1B67wABD6NqpVcvN9tIIVe0zK0=
X-Gm-Gg: ASbGnctdG5NXGnEB40rPc9ZkNq5vUH0IIF9G//6UGJah6JuWzK75mFHFXU1qF72HmX6
	RXuod1TLeSeIWb1bkLzi5BhND7+rXPVakZFiyvB4f0u1pq5B5sPY9ZV+mUTYUPrd0V6NEYpRCZv
	/SERjcibBYJWHdXyth+/4iVYMJdPBNLyB/rGGrFLDNZClRzREq/HEH7z9gox98UJqII1dZK+4ln
	KBTm3MYS8Rk5YP8E9YoU7RbZg3jovV64twOysQUu35uZilMgJBsl3FdBs6gOLPYRT9JlpeYi4FU
	4/vPxRJQPNQ0rmX5RiAykc6BMj4uQfxmGcemZ2rnLE2VvL/07s4bTs4PV2yoCAXVxQIvOtxE34A
	gnfsw3Xj07EjT9bfY1M6YEA==
X-Received: by 2002:a05:622a:587:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4da4b42618amr71328551cf.9.1758894398909;
        Fri, 26 Sep 2025 06:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLtYwLQK9mRezkGeVWZEARoBJCmZbLKmK1lgkPXDI8njEY2QENyEHcYysVVTxAFgAyrj2CFA==
X-Received: by 2002:a05:622a:587:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4da4b42618amr71328061cf.9.1758894398168;
        Fri, 26 Sep 2025 06:46:38 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d7351sm375666366b.7.2025.09.26.06.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:46:37 -0700 (PDT)
Message-ID: <e1427bcc-0502-4cfe-9cb2-bae5bb10208e@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] interconnect: qcom: sdx75: Drop QPIC interconnect
 and BCM nodes
To: manivannan.sadhasivam@oss.qualcomm.com, Georgi Djakov
 <djakov@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Lakshmi Sowjanya D <quic_laksd@quicinc.com>, stable@vger.kernel.org
References: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
 <20250926-sdx75-icc-v2-1-20d6820e455c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926-sdx75-icc-v2-1-20d6820e455c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HZ6Dj4QQdqFHaxKVDXXN3cazEWJfTp6y
X-Proofpoint-GUID: HZ6Dj4QQdqFHaxKVDXXN3cazEWJfTp6y
X-Authority-Analysis: v=2.4 cv=Jvz8bc4C c=1 sm=1 tr=0 ts=68d6993f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aH40uDyxLlspqTMSXGwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX+7Ydkswf/fZj
 CnSw6LP9TmeUlYWRnrk6XZAzjvZWKMyU/o60ph+Qi/+MxYvZVKNccHK1LX7FL2XWer/3225NoNv
 XAuAH0zpdmgGCQJ6Vhk1MoqMRJFIne2MtqfTyDy6J0V3uqp0r7gNuqfEGzZ3XUa3bZ8iHbTdBIs
 bP/n7gRwkVLDPKpErKEXb9XpPg+acNNAQoHDmNci4WwIT7XiH0jl52itynHtoIArhqrYxwRBOig
 EQ0Cq+5by1ZogaoGwCbC8o0M8QdVn9OKUIxLVk/rDBk4IdNdXmB3aplJzcE355tloXAv7Z1smw4
 kcI9dAltV+im1lNAdqexWTZj4Px7vno+xEE9trR4PEy5yBtVMvcm58G2Ka5Qm0TC/pciBQ2so9v
 zwHimD5C7D3xK9M8ecjlZ4xYwl3xLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/26/25 8:42 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> As like other SDX SoCs, SDX75 SoC's QPIC BCM resource was modeled as a
> RPMh clock in clk-rpmh driver. However, for SDX75, this resource was also
> described as an interconnect and BCM node mistakenly. It is incorrect to
> describe the same resource in two different providers, as it will lead to
> votes from clients overriding each other.
> 
> Hence, drop the QPIC interconnect and BCM nodes and let the clients use
> clk-rpmh driver to vote for this resource.
> 
> Without this change, the NAND driver fails to probe on SDX75, as the
> interconnect sync state disables the QPIC nodes as there were no clients
> voting for this ICC resource. However, the NAND driver had already voted
> for this BCM resource through the clk-rpmh driver. Since both votes come
> from Linux, RPMh was unable to distinguish between these two and ends up
> disabling the QPIC resource during sync state.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3642b4e5cbfe ("interconnect: qcom: Add SDX75 interconnect provider driver")
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> [mani: dropped the reference to bcm_qp0, reworded description]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Too bad no one noticed for the 2 years the platform has been upstream..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

