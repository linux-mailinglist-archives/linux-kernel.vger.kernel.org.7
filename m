Return-Path: <linux-kernel+bounces-822783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E065B84AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B917BBA86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B9191F72;
	Thu, 18 Sep 2025 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="itnAxQuM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85301302146
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199740; cv=none; b=CzBtPDbXuz7QWuXYMLdba0yMMWgksTJhkGnOUoP7SHwTZomO5AlU0wKdChKvmE7S9civ8TqtWuoVGZ5PkHYdIcwbsNZ7cen1k18RoFjX5ESJ1IYzH/2GhEdfRF+lWf18KvmLI8k5nIcBeEnkAyDc4ieAt5oYV/GW890Jg+aKtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199740; c=relaxed/simple;
	bh=6wYNJUpyjOhpghFZETCWFMjXWeOfYKe9IaFUz2uGRVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGepistYRkPBBafiGCe16qtCsWp0DxgBPkliit8rYZodv0mH17CotSVfS323D3XwFjIib29OV+FISbGe9NEV3TXZSSYJ8WjycUOVNdspr2qrwjORd75uz/p4dLUFwd41ocwfXD9qk9/Q+alrE6NBfRUik6geteyd1mn6xnfbhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=itnAxQuM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I75M2r011113
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6bvtGgeiT9GdcDYImrybz3NN+DT+yOFMcizDB0PF7SU=; b=itnAxQuMu02zPsbk
	s28ZMC6WmdlWCTaIE4IjIqHrF+3PUef7suYynbSjkQsA3iFLr0B00a5GwIbr9n0V
	VXjpOOZIAglPnR4Y10MwWhuO7BHXu/WhXSyzYCapwYHEzDUcIrpSDxgukjfJxJQI
	ViYbQjCnevhizbxbjYhJQkpDTK88U4Jux+Ek2nY3J+laKwEWwbxz9dP+yp4lSBO2
	7xnx0C5SVX+PiTiqT5uEpfhnzzmdsEmN2GTPMoCDwh/8PUay6DNo5GGc01zaxisv
	7Hesv5UWgQYt9rt9MTx5ebbuXA/ijUPE0VtRbeHzDFi4iNodJA0DKYo0UQzkczsV
	m6xBig==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx2a1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:48:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78df9ea0c9fso2047446d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199736; x=1758804536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bvtGgeiT9GdcDYImrybz3NN+DT+yOFMcizDB0PF7SU=;
        b=aP6BIsnqvu9EAcdXsN5lgtNXpDK2USi2zrmBg+93yWEzML6pRaFV32wX+qVe7NGOHh
         11sCaleVun/5dhOBD3Z/1m8S74YAmy8flQwqPg8jBikXM+iG+qQdsYqlnrwib+q0QAiE
         81tRtzw7bCgLlOkSzH3rV4grMJUeL45opUKGtd3feM1LX7ZXC7WoY3anv1IM0mPA+s0H
         /Fks4ZvsrDbkBn6D/mhgqKOle6s9mESsQ7oGNcF4S1niEOBPjj6HzBTf5j0xryUX5wTY
         okXLEDBXbDxa63d52beMbzj39DILZWBQtPmQnNCqu87IJL4NiObm2wBibBED2jzaB24c
         Uu1w==
X-Forwarded-Encrypted: i=1; AJvYcCWxNkQqEbXstvG0Ez3k9PhXNbOi08TLu/kJ2EFHpu4C3+NWoNPo/0urVf2IzYigWGr0UxmyOtlXT1S4TeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31l0vGmqxL9gA6pA99vg84dhmsBsOG7v4z49JpigCvVRWQvEu
	mPM4lCnlOd4nr5Uh6PyakmpKlzXaNKzlngn7ooQodXQvXhw8eECu3l/S8v+G3qgkYon2Nkk6Mt0
	mjSmB4EGoSIFZwzbV6DmNCkEvCOIrz0JOrVxDzAUhkEk/rRTxFndDufiH5QBHFLs3IeQ=
X-Gm-Gg: ASbGncsmD6k7YiioJEJyimcfJ5JbluXRFHGHdFPR/Qwu6jhF7ri1pqbuB4mOhwQ+3GN
	6FtEWLxvLUSd4SYDyypZQc1EYau4AHaS/RYZIzAjIeaOsxqebBn8B6IMtfGaLmGwyM1iHZrU9rf
	yTEoPgwgrsYYw4/N4Bauworz823gWAXTfOBWwYBRA1gW6QJffoldGHjG+0Gg5zVX68kWbgKUeOn
	wkTw2oPpvDzSzRgsNs9XQQU6UWSAW6Iih2FTHQcOAfPklu4k/erEf+dNgoYD+Q6DH6FauMfM0ud
	fHj9Qq1uRdMiEuBb2+6rghEnjNemYOHIVdKEo8eLdeaSATVWLLyr2pGl/C9gDPHN6bV0DSWwPVd
	5nIURPCJ1h1/b6UzNdPZ0rA==
X-Received: by 2002:a05:6214:5192:b0:78d:d2a3:e170 with SMTP id 6a1803df08f44-78eced2299cmr38306126d6.5.1758199736360;
        Thu, 18 Sep 2025 05:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0/sXcCPePkMwJlzd+QPdDzDD4YufK1nMclF2i+JYFp8zsYYxHye3lguODkBPVCCYniAWurA==
X-Received: by 2002:a05:6214:5192:b0:78d:d2a3:e170 with SMTP id 6a1803df08f44-78eced2299cmr38305696d6.5.1758199735742;
        Thu, 18 Sep 2025 05:48:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa6f03008sm1317666a12.7.2025.09.18.05.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:48:55 -0700 (PDT)
Message-ID: <905d90fc-eac3-485b-bd8e-98c1e4aff29e@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:48:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] arm64: dts: qcom: ipq5424: Enable QPIC SPI NAND
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-7-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-7-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VE5lMJwqLA3rVkeREQjjuh8na7QBSDoC
X-Proofpoint-GUID: VE5lMJwqLA3rVkeREQjjuh8na7QBSDoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfXw0jlKN7X1S+8
 svsyO3dnqITmvEo7jDNRwGPykce1icKiTtEghEp+3qm0mikWnq5ThhohWo453il1zhTNKeZiaCk
 lWdKOjm6YmSJslGminhuNnfiWTs620gUAzGa6qtmkG/hcowg9PfscQcl5q+yBZnnQhttdtjEM1o
 Y3qxn4svI/8uw7M34/S5XL7v6bHlhhL9sh13OObzCrHmDGpWqs55p+wHmpHR55YcGkC5o4XdTPX
 i67VxEqCQ0RDxPam7xiz3nnB1ortBUZBNfetjlJtZ65m/IqTRoWaiGMGkxVjHAL27p3YDV91K5q
 vr6wOjp6wjEp6TxXMKcgY8+7annJP8tj4HVnjlLE36wrU8sEIgdAnTzDXzIUnrLs/gXNUmGvCnU
 orKFc8XG
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cbffb9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=t3lpBGeAFA5ev54tvH4A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> Enable QPIC SPI NAND flash controller support on the IPQ5424 RDP466
> reference design platform.
> 
> The RDP466 board features a SPI NAND flash device connected to the QPIC
> controller for primary storage. This patch enables the QPIC BAM DMA
> controller and SPI NAND interface of QPIC, and configures the necessary
> pin control settings for proper operation.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

> +&qpic_nand {
> +	pinctrl-0 = <&qpic_snand_default_state>;
> +	pinctrl-names = "default";
> +	status = "okay";

\n before 'status' is customary

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

