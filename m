Return-Path: <linux-kernel+bounces-893215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D5C46CED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F41889600
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7D1311944;
	Mon, 10 Nov 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnIKMiJ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7/DrDrT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA13112B0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780426; cv=none; b=uTeRp9hjHfwG6VVp+ggtCox+YtLEl/uG1LWvOjeRzWzllpVmgV5+4yNIBlZqC3DshLqGxdrNNUVN+0X99Uhd5l4fB4Fx81N+j3Sup15dQUOOdZA6TukMvofXQGY9hjLH0veS1oAvkvdtCrUMkvk5oTvKGEx4BYJkx8+rf6FDB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780426; c=relaxed/simple;
	bh=sAyJEnQpOE+CyoPsEVV52oBcegXRqpcGw3Hj73SO1gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYbJSN1fyan8BETrYUc4aXcsXYEphx8VOIywWO+eXJWxq72ErKamx2ejynWxDT8L4cXakHhrKzKSnkn3UE3ybxRX1Cis6J7dtM+a3pyMUcFqeu/K7ctPRRtYD0g708xlewMPiabTqW1irpNaiNRilTTbLPGL1N/o3vtyx8RgLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnIKMiJ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F7/DrDrT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7hSAB2861647
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zf5by7v/g7p+dvGHpfj+j+RRTgR0OJ9Fd2rr/ysTKL4=; b=FnIKMiJ6Agw8Bw7d
	D5l7XFqGN2+lHQ5BEbn0Fv4yo5kBF3fGxUt2j7XPo1HEj7tPwE0dJdcVtcFMsTqR
	nB5DTif6JbwYoEPpvCgCRdhnA66hmCfwRCmYKd4ww+ToVJmDCyFipto/RkoVRccF
	lYgdeyKMb7HCLa2kjMF/jzv9vtmKR772GjPLCZStXjLIoc1lJh9N0clrNKtRUtYI
	R+/6O1HIJaS94oRRCigXi8mfz/Jf5oDKU9qWfrYGwaaU7WgxKPATGra8H1kqx+51
	ZqATOwjTJi/hsTm+beLsCseKwe2j784oW8mFVWUqZ1VyschZpGpcUw9VTYUN1Oev
	9AhXGw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abbwe128p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:13:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so2927219a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762780423; x=1763385223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zf5by7v/g7p+dvGHpfj+j+RRTgR0OJ9Fd2rr/ysTKL4=;
        b=F7/DrDrTohOcSHx8oxMgWQV7l0XZ7Svv1IGwC0DJDJgAb+qdunIhWtq5qLQC05sYGY
         GgdNoHyr36DyWyWAmhnw9BKxXThjvE3MuHnEOYA7ht+iAVAMaNN+Pc60scfGKz4Lf3h5
         N3xBZH8ZSTaAvz56Y2/4SHi+UbMf2L3TcjC3IycIGHhNmIYXHM+JutlUj6IVL+Iwuibn
         jVoEE7yoLRAABLybOHFoKuU7sMJ4hDYb2y/HHOFmAYEPa7RA5v4GZQyc6pHb+kYA/16H
         8qW7ySCSHqBMRq/KnTPNjYqZO2vyydeO+K8EVt3oDAV83uWGhWs9rMSSDhHssJPogXoS
         zYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780423; x=1763385223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zf5by7v/g7p+dvGHpfj+j+RRTgR0OJ9Fd2rr/ysTKL4=;
        b=jDUVmBV+Ld9uzQfLXTPCzsk3doa8txm+HRZeQ7RRRzy+JQ1DntAH1LgO3hMMFJH7pY
         907PUiNbfdnxAlKCz4yGnN4vDtJNix8REA31zngOoAuKei/D57i507fR6eEwMoZnoSe8
         rCupGW6jmk7B30hMHT4zDUfBobuSeS7Ajrcks32gADIKbTJrsGlG4sINacBpORQwpbl1
         uCBvTzQE3FOn71yEO8D8nfozxOyTt/qvUkULmG7lX1/bJDj1sHCyYd15dywq4a3mF7/D
         rry+vSYdKv7CpqiOJu2ik6t6dGX4KRLNm4bC+w6S/dbPLgU1p8k5ZQZyCReMHHbga/QD
         9kGw==
X-Forwarded-Encrypted: i=1; AJvYcCU9HQHJxK0KWz0t9uhyFgMTYLsrc+kq3Jt5ZFX/h8eenfCFeJ301qUGMfhFYsmiMBaiAt//zzLPiXI1AK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSiwLCzOAGPWaCoso7JHgMjyZeiM7dUZXYm2CxiUWvV1bL3ni
	kKEXoWEBBkmbsa0v1eNVUhXHko0+e+p/slBIm4m601tGkkjlHM8/DUtDmlk4JiKlcwYhThsrOs6
	SjNgwk+luy6An8llFd3lvipvv3Klj8SkeuGx2YAHVXdB8knTjcBh72+7cjn9F1Vn4F9ho3xbrJm
	8=
X-Gm-Gg: ASbGncuiLa3QwWVeI1QI6TgLa6PzmYjru0H0LFGnsO40oUU9xLJgtmD4Vajb+pBCT9K
	9SeFrWN6yNNTaNG6hdPbUSdgdf4f6WI5wGDSTV2bIvKfQVlEOo0iBeMgjR6k13lNsyRh9RpI4Nk
	0ejKeY15CYci5gpUgYUynkpUFeh2d6az4iZB1VOytU9C+hgGuphhIPpktO+lzG8Ss+kbNoZfjBY
	88U2Y0Q0K1W5+CpP+beB9W5YcG4MHsbM8xErhO6VmJs4I/9ViV1+luIQg53rDdxbmkP/Wc+Gzgr
	WuTrNf6hVU/0LzQ9BEHxFNthKDPgrIC6uRD7MtB1T7Sj/bde0NiTrs39WEX4VJSjG6mdDPr/Ts+
	9Mza7SXjYWaNIfbNBGXQLNsJrRJFaPAY=
X-Received: by 2002:a17:90a:e710:b0:340:ec3b:b587 with SMTP id 98e67ed59e1d1-3436cb7a93amr9070692a91.1.1762780422765;
        Mon, 10 Nov 2025 05:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpxzKYemCJDBtZNVtT/gk1VWfrU0u+FC6zzifoWeyFyq0P4Hf5egp7j8ghzn6uNZubwpXZ1w==
X-Received: by 2002:a17:90a:e710:b0:340:ec3b:b587 with SMTP id 98e67ed59e1d1-3436cb7a93amr9070654a91.1.1762780422139;
        Mon, 10 Nov 2025 05:13:42 -0800 (PST)
Received: from [192.168.29.63] ([49.43.224.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm12007008b3a.40.2025.11.10.05.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:13:41 -0800 (PST)
Message-ID: <511ebf46-63ed-45af-9d66-ccd1d944763a@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:43:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] schemas: pci: Document PCIe T_POWER_ON
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
References: <20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DPtVY9i8j4A6dgjNdtWwKSebsyRp7GBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNSBTYWx0ZWRfX/st9eemHERdr
 G+Ak7N+XPYLVSP7GfrgCpooWNcT6cjUVeh19TrrRKOZ3c5EmNEs728U9KypP8mqJY28pyzCIbe3
 cYZHrtYIqV//L6wYGfB5o26LTHf60jO89Jfhm3Ia4slsWtwR2ILzLztzSE23Lw45a458GxsqHgf
 3pamMLauZLJvtie1aOFyrDZOXWlibmvOjYJoAl4CywC6nbSTFDc9SKzgHWEG2G7+TsZlO26D2cH
 EWNmFfaByrWpwo2o9q9U2K0VWNUTg4U7NjAsd80riLgrZJ24EEJAj9qmJedCwETJvbvWLy4HdnA
 7eX0LKEVRDSJyExpGyC2PBxaC0gC5JSfTyx9Bnu3pO6lXA4PjOzkJPdAEnKZL88EdJ7FmHWdNRN
 p2VK3giWtNrRyBMkyIOvqDZCxhfNEg==
X-Authority-Analysis: v=2.4 cv=GbEaXAXL c=1 sm=1 tr=0 ts=6911e508 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=08Rv9HEMxtlCNW7Dos5SIA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SpA6wshyjLPcRYPzmHsA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: DPtVY9i8j4A6dgjNdtWwKSebsyRp7GBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100115

Please ignore this patch, it has some mistakes which I have sent 
accidentally.

- Krishna Chaitanya.

On 11/10/2025 4:55 PM, Krishna Chaitanya Chundru wrote:
>  From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> minimum amount of time(in us) that each component must wait in L1.2.Exit
> after sampling CLKREQ# asserted before actively driving the interface to
> ensure no device is ever actively driving into an unpowered component and
> these values are based on the components and AC coupling capacitors used
> in the connection linking the two components.
>
> This property should be used to indicate the T_POWER_ON for each Root Port.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in V1:
> - Updated the commit text (Mani).
>
>   dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index 5257339..bbe5510 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -152,6 +152,15 @@ properties:
>         This property is invalid in host bridge nodes.
>       maxItems: 1
>   
> +  t-power-on-us:
> +    description:
> +      The minimum amount of time that each component must wait in
> +      L1.2.Exit after sampling CLKREQ# asserted before actively driving
> +      the interface to ensure no device is ever actively driving into an
> +      unpowered component. This value is based on the components and AC
> +      coupling capacitors used in the connection linking the two
> +      components(PCIe r6.0, sec 5.5.4).
> +
>     supports-clkreq:
>       description:
>         If present this property specifies that CLKREQ signal routing exists from

