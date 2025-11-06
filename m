Return-Path: <linux-kernel+bounces-888280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D2C3A623
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734154FDAF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0306030BF67;
	Thu,  6 Nov 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ysdwnn9I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QHAoGkia"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B82EDD7E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426210; cv=none; b=igTemZehf6bV1IEUew1L3ZizPyw2bJm+eoXuW91CEvFLmP+NeH/bmZLEEJWRs+8UugJ2F+DekANGvu0Nxjkdszr3LeCX9DZNHv6DjQWn8QeOSYUeZBpI2zk+AOloxYlavGOeC0ZIebrHwfmuWkmQQGgmOfOMPKdEgcVMAQ7SsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426210; c=relaxed/simple;
	bh=IIzlanJESUhT5HfvEWESAycEQAHaY1TGsW3q7CIXFiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KK6eoE8njLSumPjCFidchqpg1MxonfgoceG72dKRMrOtr11Azb+HCnlYNRBZHFVdgmNZfqVsnbbdSndfG0PfDPHnQaNamksUkTS1zsfxEw6euiVEYYmqZM6nkjghv2BtFRWuk6/fE8lZoO3jKDn8NzdRjFVNWFQFNpFYhL6Qifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ysdwnn9I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QHAoGkia; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A692PoB2389808
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 10:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/r5TJc2Jt6B9ezU0SWbilao6yYAovw2BCl+MHDUkVwM=; b=Ysdwnn9I0bxhlwS7
	iPQR1rxOPUlmujSnq/VV3kpTbwl1klH8Yze5iHhMd4+6MVLMGHXBWG+2DxfVrhZ6
	FMZzJHAL9a28O6XtTsn6pwHhuw994J3+WqEvJRkmmRze0oET4GmD71EU14WYt5JK
	EVIS6si0CL2Mq2qc9B5MUITgIpLG8L6KFgBshEJ/IINwfq2qbxzQ6MARpZHjx9kl
	bhYpVe0yxFQdbdo/4JEl9KQ+mTWx+wVcpunpfbJLbMIYBFqhgk6J3oMy0ZVN3KlS
	FYlPlwh3zYr+V1r2bDl/+YwPm+Jvc7g0Rt8Qfmh8xjINB1wG/D5c6+ZCgJpDX5AF
	ruJSyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9usjyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:50:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-883618130f5so6969485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762426207; x=1763031007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r5TJc2Jt6B9ezU0SWbilao6yYAovw2BCl+MHDUkVwM=;
        b=QHAoGkiac+oJ4JBHFwgaDoh66dl2dLtGp9dN+hY0xZ6teA/V9d4bdU+QcVcrSKJuuN
         OOtSmrl4DDB8CQdSY35O9wAkADN4QFb6i2kNo74KaugCIkDYV1jl0EhAtJv+uQGijIZk
         3VMI2M3f09V099d0A8Dx1J4dC1s3JCxYj3yyHSBzmxLisgONX7naAvMBMbCJSuUqi8JN
         97n/DlQp2y1K2Y537BforhiRuozOCR8Fd9LObOxmEPzOqTlqpXlg6DB6wGs0zXvpXFT+
         qWDwUCBZloGA08GmAPD5tIWIioHNkdyZUBr0uG/X0EZymUSfLie9gzUa/0bgvsJ3SQ4B
         avhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426207; x=1763031007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/r5TJc2Jt6B9ezU0SWbilao6yYAovw2BCl+MHDUkVwM=;
        b=tXhqd7JhIMrgzkkJ8e9+GH5mZACJ4XMgX3oHjvTZ9l8Y2mbMVV2V8fHsTuTXE6eGBm
         RbZZmE1ai0fB6BYff4XANM7dr0jo98+jIkwAHNr2l8fzFMvkXPXHoy4fVdkA6bFNvmgn
         Jk2Gnd1iP0NNQiCc7O2u/fc3YUqB7uhoy5nUW9gK9JFgrTuMbrY9zwIlj93TZjL/XPA3
         f+MOoGwsgFPEnj8Ov8Tkxx4+Fr+UX9ggZI92zB6PxvD44O3PUV7SMbCPIjB4+WWqiKkZ
         tncwzISiRENOls8zXpx2NQLGd6pA51evOG3ftW/Wg0IKacFxgTNXpIwZwqMeIJOD6L4t
         urJw==
X-Forwarded-Encrypted: i=1; AJvYcCU7HXZhF//duxXahsrhsYapQF1RwxTG46zIM85CWqpbf/wd8PrVskR2dXSJJUijqTfpBtGU2citdxBmvBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PDKbBsW3mRzyIHeHpcOTCqJKpFvwBm0ycHm8+NwilsdgihOe
	AzMEF9Qhj6ie4GatmATr8VOAASOzJEFNyT77OkcKQc4Oy3IIeL8WFDQMkQ2BMfbEtmoKBYvoc0K
	fRG0h3ATL3YHFv8BQ0Zjr6s9o6ig4Yoa8Y3nX7oDLUzSrJgd4JgIxTtIWTOcZcxc37eo=
X-Gm-Gg: ASbGncslTUL9H0BK6MNCAUGh3cz473r+CFBAGMq3ueI9zAjW2j1F5QQrgDMrSuaVJAn
	lBor3kqsntaNMwF83iM51mmQMy2WMVm3SpGYGL5TZ2K+3k75jr8KxRihd8k8HAYoP3rHYJrvfZ8
	tp2swnD5EyBeq9VsHUUwpXN+O9CCFrsR6R5vv0XdynEfPED6IwID/erFJf5K6dY7Vp1wznqakN7
	3flZp9SrEW3i047lgvsX3Kdj0rY+dN1N7GT/EkrA8npnjeSQcur2aXQ3pXFORsxSOkc30NudhhX
	z/mex8RxrTuzXoVur6zsGvgIkQvcpr2t+9jgbNqUN+musaIZM7ebMY77gqNPwMbY4aTDi4xC8B0
	egoPrFVo8IV5XOXdRjPqMR803NUmfkkxCz8B7++VWrZTInJMG3o1Ytey9
X-Received: by 2002:a05:622a:50:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed725b07cbmr55865781cf.9.1762426206650;
        Thu, 06 Nov 2025 02:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAqEDvEf+gqv8veBiEj9E570Xh7oP7Zo77xgq9b/IAxf+sUFMtd0HH5mOmS6G7k1cOolBRfA==
X-Received: by 2002:a05:622a:50:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed725b07cbmr55865501cf.9.1762426205989;
        Thu, 06 Nov 2025 02:50:05 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578dfsm1505891a12.24.2025.11.06.02.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:50:05 -0800 (PST)
Message-ID: <9b661c7d-6730-428e-ba24-bb35afb011ce@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 11:50:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: hamoa-iot-som: Unreserve GPIOs
 blocking SPI11 access
To: Xueyao An <xueyao.an@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251106102448.3585332-1-xueyao.an@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106102448.3585332-1-xueyao.an@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c7d5f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rx43dS7NxoJ6fGjPFHwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: tSw-Ox1lfHpe_kfibvBw-AI3Wvb5wuMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA4NCBTYWx0ZWRfX9B88Z4UNULr7
 Gsz8/WC6R4nhYjE990/F1tcYRAD1Vf/2Y7+bdJLMG2oQ/jQC0ggt3NLJa4PIK4LWjdrGhPbtE5b
 CAP9Z+7Yhz/2yzbScCExvIB/buX4+27Qiw0Llk958k0poiMcmFsD3nQgQMK9Pa0tR0ZXtW0CIYg
 W4dlUVpZBSX1B+jcOYNphulbPChRP2rz+wDuUVVplVyjwcnLy5YJxDjm0PzAeIN/ZB5eM8f+5WH
 awjXrOiAkKyRTnTNBfaX46Kgh02lnPakjGJnU/PSyTqTtu74HhG7rkBQokjLizCyejA4GMd5lnO
 kHQ84rxaQtYoAK39EbZ/1HX/D+awG4nQ9tmxl+Z01O7h6fB4Ru/ACiN9x6s3P7GRFjNVJxvfiYp
 vXEQXaeR6R0fqggSSGelVCrSg0ZCaw==
X-Proofpoint-GUID: tSw-Ox1lfHpe_kfibvBw-AI3Wvb5wuMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060084

On 11/6/25 11:24 AM, Xueyao An wrote:
> GPIOs 44-47 were previously reserved, preventing Linux from accessing
> SPI11 (qupv1_se3). Since there is no TZ use case for these pins on Linux,
> they can be safely unreserved. Removing them from the reserved list
> resolves the SPI11 access issue for Linux.
> 
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> ---

Note: you sent a v2 of the patch, it's expected that you provide
a short changelog and a link to the previous revisions.

Please switch to using the b4 tool, which help you meeting that and
other expectations - check out the internal upstreaming guide

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

