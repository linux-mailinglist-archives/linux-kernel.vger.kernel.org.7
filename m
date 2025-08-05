Return-Path: <linux-kernel+bounces-756448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC65B1B41B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD30C182114
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7EA273814;
	Tue,  5 Aug 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RNFfABln"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27F26C39F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399294; cv=none; b=n5L7YTLPB2eovMBVKw0zW/P95CJ9481Moca+r+ER3jY2Eh3vLHBPMNRmd3DaGmI5snCmcSXkh3iBq1EeZ/y7IKScwZuckuIzAglfMt20VDvXAT/hVCBenSP794O5sdWLOqT5IPvuGBd9jOQeo7CKgI/2Iw163Ooiy8WmHyyK0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399294; c=relaxed/simple;
	bh=XMQ/CjpHTQ625oN346Fj4oJVA2n+W7fLJLcl8OfHgdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tenTmEAZOSM9GzGKmxERrogGHn9MO5OF6LpRvqexNuAFJT9K29RNpsw7aaw24hNvWDThnBAk9agBuv2pmqeCw29e2lH7Gn69xJX7lrO7JvhcrEdeJtwoEcuA7W7e9+FycZ6B/UTedYSrD1Ok79EEq/dlAU1LUEOpUB3ffDIJ8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RNFfABln; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57578FFb027566
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 13:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V1RinYJ//EKx/XDr4zrnDSZd6gtIJfrzcdr6MQbb4o8=; b=RNFfABln/8ZBwmeo
	YpNeLxPvSeiJYW8CKNyoetOA57j/scU5Z6xZZn06OC7ht/+oH31RtOlYcJwK6ZfU
	TLROl26OBvFQ5IJQy9e6uBexblAfSZvfSsCMNVWSnF6AQnGOcWV9eT78PQdAuIou
	OLCmNVo3H26WhY0ehdIVh40ErOemT0tOpLK8DFDNFsiK6sqlqdxAmDvatsrtTcl2
	WgKy8QkPZgJqJC40eFC3J3lWIP6wVCBqitFJzfX8NYY4L9CuUWfLTix9vIzQAb24
	p31E3hFfemkLV4wbMCru+C6bICAercOjuJhb0eOsUOT9kG0LA5ZhMzsZGrQgyzi/
	XQn+Hw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bd9w8yf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:08:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e800094c82so45164485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399291; x=1755004091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1RinYJ//EKx/XDr4zrnDSZd6gtIJfrzcdr6MQbb4o8=;
        b=c+XkZdHthg3bDTo275g2y1c6RCfxm9s2uGh6JKH7OQ+HKvtg355vs/s91ZEPZOgL+U
         e2D4qzckXGD05mlPuG11UAJWzQ10Lqj49dneAeHsrGRuCBzkRIHGE2S5RQOix7HdzfT+
         Aw9doTCvR18jNh5dIWAmW2zif4tPm7uJSjmhj+1n1HFvssCk8bKS8yC7nQlxevo6lcYw
         G0HcpkICoAecSDxuXczQzQbnB9R7SZzUsNyVwNdQHp8Ag1g8+T4U/qpuY+dfmfWW2v1j
         /vbEPSxLwhr/tvP6V4S6LtpK1BzOv+YVs9FHiFZyopyDu35Ga4BTTP4A81EDCS1xnMMY
         anUw==
X-Forwarded-Encrypted: i=1; AJvYcCW/+wfNh21R0LzpQXz89gcJggri0GDx9lspXUWgsbY4ySERXN+osdlLKl6g9lWexZ3HXaK0Y/9m5Ze1+cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitYZfokN7wh3BtsAxUMVBDmHUuKhXc68uUxdiZpiX/JHQAsiz
	JmTtLljQtq8JTJJyIB/X9b3oYFNtUxWohLptrORcDfDgF+h1qu9SbR42OOyZu3GutyVWe0nq/jE
	fFjiWEKFviTzHGsxkC+/q3Y9pWKq186hvyhGwg79U3lxhWT2sR2e71bEcydz0SvX/wZ8=
X-Gm-Gg: ASbGncvn7MCAtYHHdeygbxNiHUF4B68w8sVZOb0ahsUPx4GR+wsUDPJQ09n7pIIRJBv
	cnstsGbTXx9+CBehqCKmzCPLuVspmxhUJpPDfcWZ/zMmkXxQDOYj6BziHmBjPxXpibbejpj/W8Y
	+xITCaTsRjugRq0BCdtdV62kRCTyPlcwAOhCq4VfG2+oV1zEv8XvzgeUumi39mUgCVvd4i9eFde
	P908Ns2uZYoUQrpFrGJGn3lt5aglS9GLR0MQ53EqrTPzxvSEVMupeDL4OClBpnJfVYHf22qaldc
	CAihrHW5RLKoxlzm9oss8ooQt0hwRJUy+IIGa/dtoHzZuBVdVaaOc52NYX1D3QubbOfaep+8ZJQ
	s5fZDM3OwJGUfslLXHw==
X-Received: by 2002:a05:620a:3703:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e69627a8ffmr993277985a.1.1754399290896;
        Tue, 05 Aug 2025 06:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzNz3BICSPsbshnHOdcR51KGwLa6oOSI7DAskcW2OrM/K4xCPKDoMD/yMxAl4j9/+41ZoXKw==
X-Received: by 2002:a05:620a:3703:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e69627a8ffmr993273085a.1.1754399290302;
        Tue, 05 Aug 2025 06:08:10 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8306sm911353866b.83.2025.08.05.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:08:09 -0700 (PDT)
Message-ID: <5d5820c5-463a-4fa0-8ad9-21b75797aaf9@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 15:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: sm8550: Remove SDR104/SDR50
 broken capabilities
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20250801084518.2259767-1-quic_sartgarg@quicinc.com>
 <20250801084518.2259767-5-quic_sartgarg@quicinc.com>
 <69f2807c-9a28-4b31-97cc-2756f0ab9fd4@kernel.org>
 <c7e36755-9255-4209-9d53-20077bd1d3ba@quicinc.com>
 <lkjp2353athoi76h3j3bgkcxdwfn6akcyyweipt4g774ztmmer@vcw7ru5red3n>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <lkjp2353athoi76h3j3bgkcxdwfn6akcyyweipt4g774ztmmer@vcw7ru5red3n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=6892023c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=36rLTHuftK6yE2Nq2w8A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MPuotZXs-wpAl8acCf2g_h03G-DkbB2a
X-Proofpoint-ORIG-GUID: MPuotZXs-wpAl8acCf2g_h03G-DkbB2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5NSBTYWx0ZWRfX5RG8kT8W9zUg
 xJ8osfKpD+1kBfbVgTh8PACFQ30XZMoFtfckgNOPUawl73AaiCL0T8qz1yk+gD8S9tloxUmCDC1
 5IN1fxIzmNqbpGYoSIDv/OL1mZqbkJceRNwcEr7rRxDk2T2Fz2DPZ8tXzkGns37w87TxqbIr5vT
 Dg231qlMr6+sppYPhub7HH70JiuvpppDfacGKD8hfII/4pHLAvFAhQnz/xnKndHfrcct3lDBJpG
 SQlaoDmjpqNU0RdY6UBDDLeVdzIJWYV4MVlXj79dBPO/lKjBIoCDaY+lzI4Onyx1b6YEcWk1CIw
 zUzzT7l1QiIQJXZqQQ8dSWQg/wZYH/UwS4wiQhYheuxPAoLNSLNLglc6Kp/u2auG/6z4MpWMLGQ
 LukQ9/lOiNsah2A4ed24Z4gMwtbQjiS4bQbgq6fgkcrjGE8HfnUgQY3X9ZjmltBD0XyHcoG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=787
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050095

On 8/5/25 11:59 AM, Dmitry Baryshkov wrote:
> On Tue, Aug 05, 2025 at 02:49:29PM +0530, Sarthak Garg wrote:
>>
>>
>> On 8/1/2025 2:32 PM, Krzysztof Kozlowski wrote:
>>> On 01/08/2025 10:45, Sarthak Garg wrote:
>>>> The kernel now handles level shifter limitations affecting SD card
>>>> modes, making it unnecessary to explicitly disable SDR104 and SDR50
>>>> capabilities in the device tree.
>>>>
>>>> However, due to board-specific hardware constraints particularly related
>>>> to level shifter in this case the maximum frequency for SD High-Speed
>>>> (HS) mode must be limited to 37.5 MHz to ensure reliable operation of SD
>>>> card in HS mode. This is achieved using the max-sd-hs-frequency property
>>>> in the board DTS.
>>>>
>>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 1 +
>>>>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 1 +
>>>>   arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 +
>>>>   arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 3 ---
> 
> You missed several devices which use SM8550. Please fix that.

I would be in favor of making this addition in the SoC dtsi and removing/
altering it on a case by case basis, since as I explained in the threads
of previous revisions, the fix for the limitation is additional on-board
hardware

Konrad

