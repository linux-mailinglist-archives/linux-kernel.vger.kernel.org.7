Return-Path: <linux-kernel+bounces-729807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADECB03BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB05B3A918E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63623A6;
	Mon, 14 Jul 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SV2NH9S3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A124061F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488791; cv=none; b=an9w+r+jKCfozQ43ZvwsJLN1ZapZSUJw2CGlFiscwlC88ovptxfnqzW2+cbawm08BRmMYld1JzrJkvC9jc8GDIxvvXO/nOi4cIDts/4hVoLvRPNmmcLRAGd9pIcHDMwfXESt35Om5RE9McYPSbNMXZZwu2ud8tdSz9grONPwqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488791; c=relaxed/simple;
	bh=3WgJKsJNXm6nkCQk25rfynsk5InHOlPiGe+VoI8VjoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enRChU90kOFYKbgnlKtn1wyxaYPJp0xO4humSzSS/3Cls3Jxb/UmJMiK+tc0NmVP6gPlH+RPI3gTWzxWnuC2cQAiHWl/EGQwRG4f60hIe6pI1kw3pXPMUzUPJvUcQyYs4OJo27hqt84yWM3CWsJENlncDOwbTaYhFg3fiP3cQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SV2NH9S3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9MblM013581
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	egAELupiCZx06w7wEK2KFv4UsZXmQJRYPb1g2z2YVqY=; b=SV2NH9S3KyTAlgcK
	40EZ36lyqXFJ1HVoZwyB43XOXkIu/ldTZXodxZ6bC0y/XckneTlzgE+yFYlWffGf
	udJcJT8CmQfddyxX+vsvS+Frevh0IqP93p8ajTOG+Ymk2dGVvWOIFNow3kCjZCGo
	5jXDUahHQ+M66zDYi/f/vYf6V/bzDDaFKLEt20AVX36dQpUqcM1cuqA7qvXW2AG0
	fF5Yg0ez6bVk7x9UbM2TYItKccB/dwFUtrXHQ4G1/GdnOZUM8vQ3+pfn9mHwBry8
	fjPwD8Q0Tw6UbWr4HB1julg/Mqnt1dZYBhvGh/uSOCs2Xwv5ztg4+eh5LuBKGnij
	LP5w1g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmv9f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:26:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a9bcdc73c0so6974861cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752488788; x=1753093588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egAELupiCZx06w7wEK2KFv4UsZXmQJRYPb1g2z2YVqY=;
        b=OJQ/OywO4JIaYCu0bic+ubeesLvT+wYETRm72FXhR8kPHOSm8CUvjAR+CsIAJ4Foyj
         6sAnAQ/V+SfLJX4E7APeSAwuAohiV8zdulwuGxOuehnv110UlMJEHgNHuAVhm81hdS1e
         4wrPZZfeFwRtoVWwJlvO3LyBOVO1Fliav5jB0YTEWhIXcEZGqni82XPgBBL1a12Oqhog
         8Urw37a2xcK6bXGls7SBbjiFLuNmFh9x5vdVxn+k/4O4xnk5OzgBty/yzdGT48oUsyHf
         XApkKg21Bzx6YBQnJFXGTQ12kq67gD7NSuzvtujv1MG2hC0zcc19Tt0P+modE+yM9LiR
         Ousw==
X-Forwarded-Encrypted: i=1; AJvYcCWQy/7KM+oPkr5hi4Y9J2WMzAhVXwzl6q9ByXOUhuPsQQiYSWstaE6gGhadAzoF6VSJPXJhKLduPmhYeCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16Cn6izNZZ4NGW37r9HTtcNk0acnueeU/G4eUuYvWS0McIB+7
	jHyRPSq8JTsmeD3RL3YO04XHYn7iXZuS6AJkgMn+N3/ei2BXYJqmYzDNTVi5wtO5XCTGGPQ65sU
	tvo/5mnEyiw4zZbphR9SvAdoCK52q205ku4rAONvw+wXhSRBAfS1tX3y+H9OaQMWU/Io=
X-Gm-Gg: ASbGnct0m0Eh64BG7xGxCNXDSa0741ml4xNMODchqukuAjIwmF4UbpRPZEfdnX95xuV
	0ROwCkHTzYFAF0sx9hJKgZITxdPLFJwPXA5TjwMoC1xlS8t/3G3rJ3khVoB3aR4K4AEsr7+ja5p
	iy/bu0bb0ZDruEuisY2AjVdKuK2MLFXQy/0I88/N8iRjfTy9ak7/al3YDnBOgSfmYsdQ8xPclEY
	p1n6u5OeEl+He8Lgo7xc1clwg5p4xPDy5v8soqCe9b1VfklmenuVNF224N3LKaCD3OAXG75whSM
	PsJdFrrb5qVPxE/Qg9PPUfd9IdJCfXnke4tgJAZJAl8eRdjZiVVYQZ+9bJwpBY8bK/9ii5BAdZG
	G/bsVYvg31m05ET7VyFRk
X-Received: by 2002:a05:620a:3194:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dea52c0555mr554053385a.11.1752488788013;
        Mon, 14 Jul 2025 03:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDL1NLrtu1vBkvJOxO8syOjdbhxl5epP7yC4DT9HmFC8zYh1BXgqTPIUl4qDv2CMgF8y+JcA==
X-Received: by 2002:a05:620a:3194:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7dea52c0555mr554051585a.11.1752488787599;
        Mon, 14 Jul 2025 03:26:27 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7f292d2sm801836866b.72.2025.07.14.03.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:26:27 -0700 (PDT)
Message-ID: <e0e08139-6231-40c3-8153-5a1acebadf3c@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource
 mapping
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
 <20250712-ecam_v4-v6-3-d820f912e354@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-3-d820f912e354@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X9B7le0ddJ1F11KyBQN_OW2cC3Ybeaxs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MSBTYWx0ZWRfXxqXKRG+FCn9z
 feXNrD5DZQofKVFRMsKU5WfiN/IbvUsRsyADFWxA+mUAsvSUQnpAygnUq1CBzdoceNwwmMLlbLs
 AB0KAReCXbKT3nPn9uucJSOlnMN84c0im0qi2gPAaiK20K553Of02v/YseBoLm2WIfDEIYLkc91
 jIAviVH5jg2tpu9TpmC8RYkO9KGITMVEuYENkh8oCZi+32mfDv7IHI26E5LBwYXzD7SPmFIOyUl
 BYmJtbllxMJ6xRFQN6vSwxpweVzaxNyNdKsObuKh1IEKZPwCe8tfeFKoAurgw6OZBw8Ui5HVNag
 ZNww4qVTa7C2ITYEGBOwgpE9dTuQavp4fb+hXAhbgpxxZgGm0ZXCLXCHLyoRx+TP0V1sre1NbEC
 KjVURoiIG6lbycqvU3CrzDzDqm48J8LiGGMz829YztdtRKSjBSuZ6G96kYtntgNO20Xe8fum
X-Proofpoint-ORIG-GUID: X9B7le0ddJ1F11KyBQN_OW2cC3Ybeaxs
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6874db55 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=828 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140061

On 7/12/25 1:42 AM, Krishna Chaitanya Chundru wrote:
> Instead of using qcom ELBI resources mapping let the DWC core map it
> ELBI is DWC specific.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I see this can also improve:

pci-exynos.c
pcie-histb.c
pci-meson.c
pcie-qcom-ep.c
pcie-kirin.c

but this is ok to put in another series

Konrad

