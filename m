Return-Path: <linux-kernel+bounces-892934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F4C46299
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319953B75AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250F30596D;
	Mon, 10 Nov 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EPINLj1j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YFZ6Kj4y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF47302CC9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773056; cv=none; b=c5PG7Jpc7BSIQ73YAauCEAJRqgj4/Z+fV6s1Y6gdM9CQUGAPgB+FTzJA3s0GMck55MKKr/4M0LfuDhFczCl8SH3W2eKmLzEWOrMrpoRmlWPz1km/fpOLBmkhOsrdt5S2xWvwXJ4TsQbxtHmM/3/wttTzCdg0V+JmFsPS39HhGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773056; c=relaxed/simple;
	bh=yO77kwBGZo7GfxU02vl61rDFI9SWDoQ8KYXb0fdAB+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5Bj5QL1riiOsXpKtzEZkyZrWdt6YiGROXv3ZhJDDUWcX5m0IrkqGyGQdZMSryq7gSroP63XHQ4opjv+qJNT3gXPk0ZG28TT37aL40XivLhUKNfQpDXiM7Wknm85/7hN0mxKGwmAz0GjdgMLGVv+Vb+tATrfb6Ll1afr5mqyzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EPINLj1j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YFZ6Kj4y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9EpT82993118
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ybEh9EFc/k/OEFrYVPKW0AEC0K4ZVsg0OtLxn2/42jg=; b=EPINLj1j6GgstPbx
	EjcOg6UjpKrFUYhA8RYbB6DrKy12ikq8bgeLM3PTbAfswMaq4+O/Ca44BVa7rEsX
	QU8uxAE0NAyZ9RKHifJj6S3gze3r5/BhE6PFpLi+Np/nE7SubUI0B4mCk7YVziyG
	ywhFO8n911i4X5pqXKnNbJyjSuzLf5JDRWvZfZnXHYySaTRILme/MwWeM51Ja1uw
	pSZNWM+kuo5UpOR8wLplKTPpEr1Ut1JNHvjFAuNaRU1OlkJBRyD54L/RcRNeJTfx
	nMsZ/wFMnzgBb3MSFzUTvx9TzoK6jWQlMc2BroZfL3CcIHnWGcuMTCjbLTRZRKIa
	Rcnpiw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88rb9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:10:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed74694decso5834601cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762773053; x=1763377853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybEh9EFc/k/OEFrYVPKW0AEC0K4ZVsg0OtLxn2/42jg=;
        b=YFZ6Kj4ygnKMsmkYXMRjAV1n8YYhcIzyhhHy7fHsemqma2dch3TqEOfConSrn1sow/
         O+1iB6tUwixEXLsONKWmSrk09KUpKCxhTlpyQ6n2N3Imao1knMrDirB8wVFG8SSEzsce
         qNGzkccO33pyCOzI7BxdxeKRX6wW4MEzR6381jXiQCi7dxa03V/R66Zl2IWCipPVRHQJ
         O/K800TAtV0dIF813rMrIaP98zYrKawBBtwpx9mQKMC7rTC5kCX+vMfobtXYEioUrQLD
         ZqDVJS1ZGQ/gdIDq0nBoylRAxnUJ7rA2/c/VXs0kJKJj14T/FsaMeJnTALTn8KsnC0ye
         8JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773053; x=1763377853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybEh9EFc/k/OEFrYVPKW0AEC0K4ZVsg0OtLxn2/42jg=;
        b=ZU9EJ3qI0HO5UZhWJWuVxcsDdmKcYOwZCFGAaBTILTksnBQs4jhGYEhMUFB7qpHbYy
         n/66V39c8cTd8yZXc2LSMIJ7A1ekFNww98lTtz6NYa0DHxDIk1+AFFnAiY3xTPm/dYfI
         L+bL5xA2+hShnlrsoXy1VrEBpT4P4U7sNFG9jHpj1NKt4DIY1863Kr5bqxwJcDWwhU5n
         DMDhRyr2aXCA4y9rA1DWPmrvB/zb4CfI/zlOXwaSRhSVnbH/ZdUcGORVTaQnm7Ew9EXR
         IH9LGs5fas8XyGKJYUBrRaUV5FAsEb5TsU5tz6aPcskmwCDIYTdt9AHkn4DFtcMmhZSz
         XXlg==
X-Forwarded-Encrypted: i=1; AJvYcCVb9WMUcCZlL69IXKZQe7FKiYHdGVvlXeUWp5zvsPMNZru7HTHhR9xmL9CO/ynQi18r5mH2iFyU4ggXMMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNq+E98R3W+hcMuqDyfV4Jvy9iVXoVHGwQ0MeeUeU6gEiV2JsI
	xXPlAm9xh61LUfY6g0eUe/hR0ePypN/JrrJ6QOvEURL7neJfnNJEgzRHt3YJn3YiLz5ObtIDN6K
	5gIgnq8swHfbRgFyx3Oj2zM2+jFgG9QFKmqFuUW2yOhEovPfsZlWdifQyu7F6kPF+Y1M=
X-Gm-Gg: ASbGnctTSAOv8ayUszhKYclJpmI4GERNsh6Bx3u80W+VBHaqI5tJMnNr/3MycClqQfB
	y+rbdprvZkDpGHHXTGElWY+Swys3OG20Jp8Z+MfnoBXhaf7wtzrU7S85O/k1JOPQWNhKzhLo3Uc
	myCqlHD5UU1cj+OY6U2OU28l12PHjZV4O8IiS1COFNeuoNwmvqXV6zu0xM4Ts/nef19J/XJUzKH
	7g5CJ26EvP7Hc5MkM9/ieoUaYnaHvaDS0scpIxY+Nn0Vl+RlQ8j/zkDgYl2V5eEfmZ5eMVWVUQy
	n95iBPbCnBSBLDrAStIrFn6Mwl510/+t3qzgLqD7P5/HGCtMMgxU9Exq11j0rQJn4zxivCcK+/F
	Gy32pbr4JCVniCinWthn0Aowa3jR7fceY0M0jtL2jbYQeHs2SzMSR3PvZ
X-Received: by 2002:a05:622a:24a:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4eda4f9a9bbmr68189961cf.9.1762773053474;
        Mon, 10 Nov 2025 03:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQu4fNZk2qrYjwhHpbxn0AAwOS/Kjp/AlwHX5/cKYvrUDHHZLvsGb09MZi5m64KKoPHWj67g==
X-Received: by 2002:a05:622a:24a:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4eda4f9a9bbmr68189481cf.9.1762773052978;
        Mon, 10 Nov 2025 03:10:52 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6417b28a73esm3989933a12.35.2025.11.10.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:10:52 -0800 (PST)
Message-ID: <fbd241d2-d383-4476-8e2e-0f9dd9dae484@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] arm64: dts: qcom: qrb2210-rb1: Fix UART3 wakeup
 IRQ storm
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        krzk@kernel.org, bryan.odonoghue@linaro.org,
        jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20251110101043.2108414-1-praveen.talari@oss.qualcomm.com>
 <20251110101043.2108414-2-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110101043.2108414-2-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vYx87b-B-rwUL-1c6-nXsKdAgqcC2E6i
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=6911c83e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jiGHEdQAExhvJ1pZOisA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5NyBTYWx0ZWRfX6VWfNBp7bDuw
 lKz/v16M1GBPsIVm8ZLoKk8iqYJgWfWEn/eey/M3iJnvFAp6tLN4/ekNdhszfdlDlgArxHCktlX
 Zok6LlzrU4eevYlZsbeZiY0fvjrsg1ZhLJt2ZNpuUvo98RiG8NswLtzYXqEvWStsexqM63Z9Ijy
 V06gAglRRFKKlFAa9F6KvSAGHe0coDAGMd9oERVqncGho9eOprLkoAT212zE/28HgZfW6GTKq9/
 IYkamsIwS4aTSkq82TMce7z9U1VWdzNR7oI6EYx2ey037KthXLOEoQQbrfgSTsRwL5ksTHK926e
 LaAuBMSIH/sRaPPfd/KRMRk93yYOpWsSE3Rhxp1llOnGrNyjxDZpxLeHmxfkPYFcrNGRz6Hpl2p
 gJiLhdi4B2lW7dCkrFaAuGIKmSXteA==
X-Proofpoint-ORIG-GUID: vYx87b-B-rwUL-1c6-nXsKdAgqcC2E6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100097

On 11/10/25 11:10 AM, Praveen Talari wrote:
> For BT use cases, pins are configured with pull-up state in sleep state
> to avoid noise. If IRQ type is configured as level high and the GPIO line
> is also in a high state, it causes continuous interrupt assertions leading
> to an IRQ storm when wakeup irq enables at system suspend/runtime suspend.
> 
> Switching to edge-triggered interrupt (IRQ_TYPE_EDGE_FALLING) resolves
> this by only triggering on state transitions (high-to-low) rather than
> maintaining sensitivity to the static level state, effectively preventing
> the continuous interrupt condition and eliminating the wakeup IRQ storm.
> 
> Fixes: 9380e0a1d449 ("arm64: dts: qcom: qrb2210-rb1: add Bluetooth support")
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

