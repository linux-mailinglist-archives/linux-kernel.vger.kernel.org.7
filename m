Return-Path: <linux-kernel+bounces-870744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8870CC0B940
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C0A04E9CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8B236A70;
	Mon, 27 Oct 2025 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WS8vvP9B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EE236435
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527586; cv=none; b=SVbGg0IYmUdqGbpBFHaf2VtVlbeEUHEf8N2FqwsWH8hB8FFkVZQ/1ojfmqXWjk/eYDGYRzZWd80FCFgRLbjwbpoHijC0jtwWOFjq4Lbm1ToOE1/ViVY1ZYMw5GULhKkx053uXIk5AWXpS6pXEgxRT5XzuglTBeWMXSJvmWn82ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527586; c=relaxed/simple;
	bh=CTzZlH949URCUMHKj2Bx8yXAJayG9lNr8GvJaWnFk1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+PDHo+xflTHUpRgHwx4OYehFxH8JKVH2gTqDJn+qlPn/MUaivwRknLBEY14DVGQ0cXs0yn6Z0bZFsXS+VssonrTwNteIAZ/QA95xBt9T0dWC4QWPUZdiHj9dE8RkhUUxp8fFJtqGu0YXJG8MoipZ9Hlf4gWNghQ498LItU75iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WS8vvP9B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QLrqpf953449
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hl5RIz7q5cZALdMW9jc9PqJdIo41tTzsV6gVA6splpw=; b=WS8vvP9Bc1YlEqf3
	ChxwhEcWbTurg9nofOX5nQjqlZ3oaHB+bkDmruL8+TDsVYgmzh7E0XuKHjHXUgUD
	mKfs4v0VVv5hcZdy4EyqsICtyMjDSNHqz2REN3zJJreb2T7wFXaBMDSW0VI/YkZY
	wNEsDFtA2yRyL4bQ61ze3Jo2sEXDZcKwJgZ+iG/aIgyyHFCVF5F0vBA15ez/SNJ+
	HFBegEHerRW0xwLDvvJ+h0R8pb9q1O8mqhi8EG9zaEz/cTYBPZ1LhroKhv4lTczh
	SDHE27ukmHkJ4WsFcpjiVTUcuMGIxYIx/6xLLaUPPCx1V7ELN4jpPk2YXordxEV+
	MxV9fw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nkajv17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:13:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a26c0c057eso3609131b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761527583; x=1762132383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl5RIz7q5cZALdMW9jc9PqJdIo41tTzsV6gVA6splpw=;
        b=r14aYUbEsaJbvgxEYddrXL5S57WyFfJ9OgO9h5ePtqoNdDEPYHV71Wu3IQ+1LCierL
         TP1qycOh7zoRLhcqvtMBx8gmxoTMi9uXWqroLmr9l0rfNn/NzvzxPnmQsk9skmRB4Rly
         cAlnpT+74CZqN8wDTPd8EFwi0gmphcSh2bcONoRl085Q/YFVXKGH84+Xzo7FYwhNVqS0
         Ien4gLtjZ5A1BomT+Fgbzs283h9UT0koWaf+D1OiFdN+UUlh+p48tRB58CwYzVWvc5XC
         ADHqlJHTxbbchAkT0O+fbiUmIjUgoKAcjt3s/k6Y70AujssASFlngxpQXrekpeKtWW8+
         Opug==
X-Forwarded-Encrypted: i=1; AJvYcCVCZwwMFY6jAnIVsulrS9adeOIyWvEgoGugkuj4p0Rs56BUIabxRLYxWcokuQeDRsvnLK5ybhq+pIzkTxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+w+ETDT8vk9gofOObAT7uqONyup8e6aNeS1n3/Us1taAB3Sx
	chaMUaT8y0NAYCchS/2TC0zjjFOS7tvzhhN/Xk8PGtoqr5SMxUjfjVnK3XlgspAR9WRTQlUeE2i
	7owknnkbOV+FAlwCe/b2elcGBR7s3aLPvMbu7cLF7Q7TvUhh6nUeDZaCQLLu0yHPMsb0=
X-Gm-Gg: ASbGncuP51QFl014aUAwhGp3M7v6vsdV1lpdHps7P9UHlNykvEyXP2vHXm9iazXYcDe
	eHIOhxwk8Z6I/HLw7E6j8aKh19rEGWKUHnEGnsrFysJHKvpLVc7WcTeD1/i+BIqTyOuxW2Cqcty
	onbS9RfRS+RX1Pw9YHgGZq5qe0xTSXSe5tb6QNxKD1LeRmOY7Oj5G7SeN7T8aAv+KaQgA/CFgim
	fz/jytbt8yt9s5z/6AAHqyV5mI7XesiCpoEzs89cUuXuvE3T4YEfLZdloD1gUlM0xkhD7wVtJVP
	7r7vpvp+HyXL2QyZLl0onIzPrYhyN89zzXF0Rq0oC63Hv5aKVFDaeKYxSOjbuppVWdVpqLN14o2
	br/DTN2CdJy0ily8dzTvEDzUSfKudB/27r2jh6HXlP4BEU+yeX3IIojn7efxpRyLL
X-Received: by 2002:a05:6a00:2d8d:b0:77f:2efb:11d5 with SMTP id d2e1a72fcca58-7a220a0708emr39044385b3a.1.1761527583074;
        Sun, 26 Oct 2025 18:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwxHX6Hs7IIzNfXuuoyNVi+3+O+F9QhbHQR7TvPScD3PK80IKxaPMX716EmWsqNR7ZhdOo5w==
X-Received: by 2002:a05:6a00:2d8d:b0:77f:2efb:11d5 with SMTP id d2e1a72fcca58-7a220a0708emr39044351b3a.1.1761527582595;
        Sun, 26 Oct 2025 18:13:02 -0700 (PDT)
Received: from [10.133.33.212] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm6101318b3a.38.2025.10.26.18.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 18:13:02 -0700 (PDT)
Message-ID: <ea66f4a6-1918-4674-8aae-0903adf26bfd@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:12:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] coresight: add static TPDM support
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=68fec720 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lW4bRxOBufLHntc5OVMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: we9WjgLlFl7RKjAXKkJ6CTxz4x_oCrgQ
X-Proofpoint-GUID: we9WjgLlFl7RKjAXKkJ6CTxz4x_oCrgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAwOSBTYWx0ZWRfX2v730ULNoNCr
 OGX//q5h0sVmFQIWttP6V7va7DkgzVcyKuxlLC68lbKF34eGmZGl/lRzZ9BZ8z3byts1xKvc1xZ
 HKUUGynVmsBHiHXrZDQ+B+miYYgMH2uqLUm0AJKlO9r8j1LHPqCD7s4oYKVFsLYKbRgtZLXcsIn
 Wu6+D+nmjbop2yQiPhoWHniIywAWxEDSdJxoWrSHSVEyH/oa6q4yoT6So5Nh/2qhGkyeIu8bAnS
 wEJQFPWUEaOd5NdsAqDK92QNmF4vT2+GxCQ5CbEpOfCJXbz32LSJ82cm9OXD/7Xc8NbNFG4SdvT
 L1jL99DHbmTyYg0jTwmllaGnFbSKGQNRP51IjCGyjSSJo/g5fYVPq/KbauIdA5a7p2ug5jc+2cU
 WLNcwHT0oHRzh8iSQlpeOxH3fUW1fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270009



On 10/13/2025 2:11 PM, Jie Gan wrote:
> The static TPDM function as a dummy source, however, it is essential
> to enable the port connected to the TPDA and configure the element size.
> Without this, the TPDA cannot correctly receive trace data from the
> static TPDM. Since the static TPDM does not require MMIO mapping to
> access its registers, a clock controller is not mandatory for its
> operation.
> 
> Meanwhile, a function has been introduced to determine whether the
> current csdev is a static TPDM. This check enables the TPDA device
> to correctly read the element size and activate its port accordingly.
> Otherwise the TPDA cannot receive the trace data from the TPDM device.
> 

Gentle reminder.

Thanks,
Jie

> Changes in V3:
> 1. rebased on next-20251010
> Link to V2 - https://lore.kernel.org/all/20250911-add_static_tpdm_support-v2-0-608559d36f74@oss.qualcomm.com/
> 
> Changes in V2:
> 1. Remove the dependency.
> 2. Collect tags from Rob and Konard for patchset 1 and patchset 3.
> Link to V1 - https://lore.kernel.org/all/20250822103008.1029-1-jie.gan@oss.qualcomm.com/
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
> Jie Gan (3):
>        dt-bindings: arm: document the static TPDM compatible
>        coresight: tpdm: add static tpdm support
>        arm64: dts: qcom: lemans: enable static TPDM
> 
>   .../bindings/arm/qcom,coresight-tpdm.yaml          |  23 +++-
>   arch/arm64/boot/dts/qcom/lemans.dtsi               | 105 +++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.c       |   9 ++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 148 ++++++++++++++++-----
>   drivers/hwtracing/coresight/coresight-tpdm.h       |   8 ++
>   5 files changed, 256 insertions(+), 37 deletions(-)
> ---
> base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
> change-id: 20251013-add-static-tpdm-support-330b71d6d0f8
> 
> Best regards,


