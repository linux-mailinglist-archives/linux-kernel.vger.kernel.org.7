Return-Path: <linux-kernel+bounces-892450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B0C451EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654683B1739
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9F724111D;
	Mon, 10 Nov 2025 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJcAHol5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ig82u5ez"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FE34D393
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757281; cv=none; b=bb0IQY7SlRqBaUKD2VMXQCtCIxkwy/dcxUqh737poQ7CWYupdMCkDnfLXoy1t2Xq11anM7sKa38zHna25bk6ukro3PYHwmaEuESeJzkIdmw9zMjp2YA3tz1iLGaFHdl3obk2hXRMpMcbZEjy4knu6iLFj+tOOjnIre0mmqlKxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757281; c=relaxed/simple;
	bh=Colp3J1CtUUxtYunOSxTe/q94oFmsL/+dkEwvdrbzqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXHu46i9srBzmHyL+eiOWy1qMdgWOmi3mi8vyVIwALGuK3EAcxypZAJvtxnG+GA4UoK6yhGRleB+P1wyRTPRl+1x3Q0b3Iz7Il7Roq+TXCoYdGkDZ3oqjPFNreu5fm+kY5z/zUDOxWmoLWYg4Ng3PAeZD91eKWLf5EV6h9jsCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJcAHol5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ig82u5ez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9KZwI01278568
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hKUnVQ3iHT+UcmDjXNspHD8cD61G/kra1wg6N9IeAe8=; b=jJcAHol5IkPm5dZo
	JTbrrcz+LRU7LqYdjjjCg2MRokDcsDmnvVJrRQ2XtMBYPMXrN4AycxPYpUsRMaCY
	J2l8qwywE1sRRm+6+vt8x9RxLSFCQI4mbQZ4ucJ/XvlTL727tkl8xSN/+BYhDftX
	xqkz+oSM4kVjYFbkjq5LqXz6zWdlNjeSlP1Tvj2XqoVAsup31d1tkSO/ZGGlCxeK
	wLS6/q8dma/ls15p5q/KrnSlzgh4DVxR/2rs+Jrfbpn3aNQuhKxyqo5g2MPyEaQa
	yZFBou+EaKf+x7NNC9xD+N7d4LkHCqSg4BWzBsvQmcNYXLzKQ4K+UBnd0g5X070v
	SiUNvQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs7bp9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:47:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7811aa16c6bso313851b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757279; x=1763362079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKUnVQ3iHT+UcmDjXNspHD8cD61G/kra1wg6N9IeAe8=;
        b=Ig82u5ez/pYfn83Vrp+oQDZgeimyr0V/U6aGsXh6LFWKILDFTjZR79BRdF7oN8ot3g
         seua50LZthO9qRSR/A9rlGIX+EIv9vyYXt7Sk2ofCApOQ77+jyxEORw3Xs+8QDLcncjX
         IjuW4mrmRs3Cp+ciHtJuA3WoAJF/LoS3hjT93fLc6NeoSiLeZB97YQucWddAz60TLvPD
         CGN0FoM6BrTKOpLM7hv9xfvM3rd1rOMwiNtD1VmQH6QVb7l1jl/nNQ+nKEIn0+3cSvfn
         qWIOXNrqHD8X8S7g/9euqVTwOoUx30rdC6R+h58VqAXR14hVrlCC/oGum6SXBf/RayD9
         Q6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757279; x=1763362079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKUnVQ3iHT+UcmDjXNspHD8cD61G/kra1wg6N9IeAe8=;
        b=kvIQeCIbEkHmXijQMUtO5aBJwje0yz4e1yISxnP6jLRreP0qaduzNNZUYs5QBAtCsg
         BfFX0gd55oVeCfhr0m9o9u/8pOg2txigv1ClKK2WTQtKBLAlVk4V9E2A3t22Exz70ZfX
         gDSL0mNEUwcq9Uoo1/hI2HfF6Ip4SrgASiAt2LoX7m8+YnOLOzZnleyWQISNxNid4Stm
         ljo8137HlFpRf/RkJq/Wl/Gr5iIl+CjpJfse51NNuzUhzxa1kzI0YxPMx+l9P6+CMyYg
         Tvmj3tOrX2YjkFC7Svq+Vcg0AR0w7O0ksVopRDiHkzjVMBeN8hZhqIN+Lm0nBDZWXW8b
         ilIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8IqDSFOu+soYm9blh1dy0cMFazxqByJqj0HAM6Olgw584fAqHdMnp7Jf6JYI6o7uOTnHcbmmfvpIGDH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Ho2tupF+GspAS32+3iZISxiizn1VJOZjFdnK9LmEZwy7HPtF
	UUX4F9CyBScYqjaQPHnTolT6gH/67X54h9+qa4mxfvHFYUNYjI+rhLHh9muuLURS181wtsREpSw
	UFKri0eGRYz6sHhELN5SRb+h74sZFg2XL1PR0BN7Mg4epGI2BKBi/ny+WAF8F468pSw==
X-Gm-Gg: ASbGncuo1zjeYSKlq3oZHnqa/rJyp61FIKNIawddAlzqJfEMzdO2sbJWGD0TWKX58Wv
	I1mm16JzXpxDodhUS4o3KrzcJKXUi+E0oQToin0jyOsAo0unhugOFefkPGgtBxDg6+KRushFy1k
	ZdDissJFHxjiQ8if0bYe8v9CFtRBWUNmTepy3kg9twOU7NA419HQtXoDu0flWK04Owpa2VlRRxE
	Iu+g4UfL/QV4Fma9K3TWVpeidSxKP6CSf8ku+qwcKeMg/ZSnPOjZq9l9bXiSOiy/I8wMtfcwyvp
	5/iFu7Ydpw+dGWiYpcXu0qd9AzXuit0BBlHBHvss+Kqx06H4xH4QXtym94ZMwg5lAYWWFyO7KWs
	6PtGXhQDGqPhgLlrGsajEClulinUQ
X-Received: by 2002:a05:6a00:2190:b0:7ab:4c7e:a9d1 with SMTP id d2e1a72fcca58-7b226999ea6mr4593598b3a.5.1762757278706;
        Sun, 09 Nov 2025 22:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgWc5pnkGSNwJDR7b/mhuRmkoqM2U37Z8tRqk/xuImnRxiqjCHoT5jkDMdFqNIO5Yv44sPdw==
X-Received: by 2002:a05:6a00:2190:b0:7ab:4c7e:a9d1 with SMTP id d2e1a72fcca58-7b226999ea6mr4593576b3a.5.1762757278278;
        Sun, 09 Nov 2025 22:47:58 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm10372943b3a.34.2025.11.09.22.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:47:57 -0800 (PST)
Message-ID: <522f353b-7965-467c-9951-9829e58dc681@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:17:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/4] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
 <20251026111746.3195861-2-sarthak.garg@oss.qualcomm.com>
 <0c791304-928e-4075-87c0-bd37ebd8e351@kernel.org>
Content-Language: en-US
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <0c791304-928e-4075-87c0-bd37ebd8e351@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CwXlhTpsfTm15en1G0VQgdWFKLnppnfj
X-Proofpoint-ORIG-GUID: CwXlhTpsfTm15en1G0VQgdWFKLnppnfj
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=69118a9f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=EGUEwqo9yqTfsl6hxHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1NiBTYWx0ZWRfXzFJgN4XY7pm6
 2gaWzEAr7Eq7PEIXnfXCVfLDyHcuPmTEi+uuj8GDO4GmzOLMuAJIdneXMS9mBL2DNkik2WXRPBI
 BE2fwHFByRzDorv0uQku7cukbhYq3MtbUPMoBTuqTmYV+lEjeVA95/z8S7sQqMA3DQelRVi5Qrm
 oDN91Q/hSCl/H2IcwampF7sZ3+bnoKkTtnF45Z+75raeK+HLWSDzRqB6cmR6AMwELF3RRox//GN
 ZFzs+iuvF4+nVSm4R9DYheCIkm2oKBYSbA81OIhuXGUxhrR2JkW/oCknZnx5Q0aVJbJXsVxQFFi
 Z/xSHqbuy46MKhyxzo9XuYMPgOi/ydnsdi6cYgTNPbQ9T+iE3hEnIPf/nanOeadJEWqZ0pEvGML
 xdb13WWigM+VeVMV0qQ3wdd4vTb74Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100056


On 10/27/2025 8:00 PM, Krzysztof Kozlowski wrote:
> On 26/10/2025 12:17, Sarthak Garg wrote:
>> Document the compatible string for the SDHCI controller on the
>> sm8750 platform.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>
>
> Why are you sending third time the same, even though this was applied
> long time ago at v1? Please do not send unnecessary patches, this just
> clutters people's mailboxes.
>
> Best regards,
> Krzysztof


I had assumed that we need to repost the entire patch series regardless 
of whether some patches were already ACKed or applied. I’ll make sure to 
avoid resending already accepted patches in future submissions to keep 
the mailbox clean.


Regards,

Sarthak



