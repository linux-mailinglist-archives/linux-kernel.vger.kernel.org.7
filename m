Return-Path: <linux-kernel+bounces-639878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0EAAFDB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3EFB24541
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06053278E41;
	Thu,  8 May 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nwwux9qj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8B26F478
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715653; cv=none; b=JjL3Q16QPzvN6DujOGoW9M7esaih5ewGDEQrRR+Z8s6lwZe0J5DclCZswPRX5Fap6xYNxLS0uv5Jnu4eIpbfnzkpFpAy74nmlVhozBMbcb6q7VFtKMO5KDtCDavTbcPunVFZjYwjYBeDI2CBydNcMsgosfkofoN4yBq5v6eyzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715653; c=relaxed/simple;
	bh=jR80K/QEewPWmOZTyn/9wMsnnumofKPCbkzLx0ZsB0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4oAiAr2c77/lrJ1VjvWxFzYU7vxWzr7t+jRYOsFGDWkBqsblXpDoeTWjJpoEnvkSfO7ZfcsPASSRXmDVK0CT1HzR3zKzzJDScqwDzbSBjo5JJyRrrdHUhcOKcvNB7lue/uVqJdIlLeecBPWCG8p+kGVwSYwwpTlPKwxg2h2erI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nwwux9qj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Ck9Ew025053
	for <linux-kernel@vger.kernel.org>; Thu, 8 May 2025 14:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9tZOCsJGlyFLYoLfnAHP+VSjddc9mN16QDqcdZ3mWyQ=; b=nwwux9qjSB+axDMG
	+BWniAkTKP28HEqRJBPR5hVSNv5i4HCQ0bHNBCKCNCFb7l1uYkO3+AEKXSGujFfw
	Fx2uUpOdZQKwa1xy4un4N1Y1eEtb3iRmTG4MNo4G/G0O4vA8ZjVusFd7N7+h5L+1
	wPOCEjFgc86mb/FIv5lLn2ZYZX3f86zaTkY6/I26bZY8P778V7Btajd+gnnpMC/p
	utU1lztRL/NaasJGk9RN02lUqc7ipG8nVl+nJ3MjeWZmEqRj+cIksJFZOpr7Iwa/
	bblXbMVav2pb3Igxv5pv0vA/VkxZAL7iDbKjcOglQxyho2jttx2Ylm5cy/0hwtJl
	nZi5Gw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp11pxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 14:47:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5560e0893so16671285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746715649; x=1747320449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tZOCsJGlyFLYoLfnAHP+VSjddc9mN16QDqcdZ3mWyQ=;
        b=irY4Zvta4MZoxbwH3/kb2XpQbAogRs5ZyqrRrAnbVtI1ML8FQr1ovDyqRoV7XReFxn
         2KS72E/jrZPOJUxbH/oxak5IxaxmL+nInGtQDVxPC+trCCozGgquX9u4bOOkapt0NW9K
         EGhsid4Oo+dIFkFUeq7LZs6aRmG8W9IjD3SIK0NZvex2qi0+yqE1KHMfZdVqq8n4Znzp
         o6DZHvYdr0EyBbXGZEecY6QHXX2bxTXOFokbC0d+JTDCXQmwlumW9IPwVD0/Iyr+eTp3
         3V/pIAbmTq8JPuSIGzVVaSQ/Gbj1EJg55iBDERngUGu3KV5FCG8VP9ifjEAuLZxvqJ17
         VzMw==
X-Forwarded-Encrypted: i=1; AJvYcCWI3+2+97LbQf45NNRFMsaLiMC4UO6g3Pv+iKdmI+sUIdjdszRwdheC5YXYZpWw8kpj+4P45Bf2TSY/f0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MSkpW9POB3WWFm2cssN/ia6L8l5bXWEH+5T5axmfjjnus4f4
	on3X2Bz5hI2ZKrQwiYq5OnYY6yNM4segjaiqHvdnf8qyaAu/RSIGZjQkt9PnFIAf6fBV4KwjCg6
	qdxE0Pmk1WSrB2tDlI5VSunkWxHA1/uwetn/Gpq6NLZBmijkJxSwazVWay7K606w=
X-Gm-Gg: ASbGncsGhF+U2N65ksJuDICQcJvzdeA1Q2vu9Cg0OgW4abNGVKu6oN+UhG5Bnmc1Fmq
	QGRyMl5SunGIUfz6psc4PI+ipDnf0sLIyeKszkJNNanGv+GG5rFE7dWZ8TuXkTagw6LNARPSeR1
	ug3YxReY2iRjrzbS8F4BayLrv20NX72UUVzzRUMKsw+g+/J9umcw+i9F2zDfyVeYctx/S6Ruwet
	feW3ycLxdCFpDEeqaFeLuFZB+6xVIbK/7J1eSRJQgg9n0ou4CK356RyXjE5zEmvUguWf65JaYzC
	689Fvuvk4pGtDIE4qNbquDys1/wFz60QP7UBKmQojdksjm7D0TcLVHU3fAhPeu4WNSo=
X-Received: by 2002:a05:620a:254c:b0:7c0:bb63:5375 with SMTP id af79cd13be357-7caf7385bdcmr375784485a.4.1746715648858;
        Thu, 08 May 2025 07:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbEK+0rVOs5KX20bF2OzVz+4r7xuzdh1bFzxcezKHmRZSJtEuVUnd36y5OF/bb2KQ1G70Cng==
X-Received: by 2002:a05:620a:254c:b0:7c0:bb63:5375 with SMTP id af79cd13be357-7caf7385bdcmr375782885a.4.1746715648491;
        Thu, 08 May 2025 07:47:28 -0700 (PDT)
Received: from [192.168.65.105] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbfbe5c5bfsm2220198a12.9.2025.05.08.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:47:27 -0700 (PDT)
Message-ID: <96c54162-f985-46d9-820b-48868cfb1405@oss.qualcomm.com>
Date: Thu, 8 May 2025 16:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: qcs615: enable pcie
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
 <20250507031559.4085159-4-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250507031559.4085159-4-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyNyBTYWx0ZWRfX7b+z2K9I+u9M
 9Pe8YF+0vAANAWNI2PlA2pBeRlxye0xITxghes+m4pF9NfuMXwtKAn7VdxabvPnfwOnuwfcDaAS
 9iN/mVNN5DC05i95opj0g/XzOfxeP3eqj5rUtyoGpN7jzXus+MbJxzNv/WYDISZdTtfcuGqQmXV
 c5A1B22/6c21kZ9HRT/zRMemLB1g23CvbLedx7ZfcCwIycbZAZ7tbDW/hgY6rKOa9vuriq2GhU2
 U1thqN0aaDYh0x+FBGufy931REGE0fL+IHhIbVe5OmUZoJsxs9Rq1asWniOp7BX5FI/SgXr4uBm
 l1epY54wjZ0LhzSHYkCqg8nvMtagCHcXXXBRIHqTBEG2CBkF6eC2ykLg3wio3e3977abInoB4MZ
 lXnqPAdeE8srBFeOa7l/ek09gmXqpRWqeb/bT/WtYhoBGsLJKApbYIprPNvciOhrffK5RJOU
X-Proofpoint-GUID: 8Tsov8VmOdMzRFJ4UP9lS_omDk87eBNR
X-Proofpoint-ORIG-GUID: 8Tsov8VmOdMzRFJ4UP9lS_omDk87eBNR
X-Authority-Analysis: v=2.4 cv=W4o4VQWk c=1 sm=1 tr=0 ts=681cc402 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=u-Wjf5nI4b4gXCDVDnUA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=618 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080127

On 5/7/25 5:15 AM, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add configurations in devicetree for PCIe0, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Add PCIe lane equalization preset properties for 8 GT/s.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

[...]

> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;

You added too many zeroes after &intc, this could not have worked

[...]

> +
> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
> +					  0x5555 0x5555 0x5555 0x5555>;

very odd indentation, please put the 0x's under each other

Konrad

