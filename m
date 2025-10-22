Return-Path: <linux-kernel+bounces-865305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322ABFCC09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC01A01F37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785F015A85A;
	Wed, 22 Oct 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNHqvOYJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3834C820
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145324; cv=none; b=J7iDqepa6MWFFgMyj5ohUIwT1FNQiNmoCrW85crgexPNFGOyMJUIu+ai4wfL7k0QLKX407Dyt3ymR/rcxO2TLTZCN7b6TcQQm3FLFvLnOmy8m7nCHY9pa/+rfl72cJPvK4IN4RrvAijc8Hpz6g6UK1flkbGQK4yZB66gNxCHwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145324; c=relaxed/simple;
	bh=AS6GTchDJiG/VSv415eyoTU4UvcWXjnpLTn/xX286zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NziwnaJS8ZM76BHmNONI+YZis4ebYBZMYWJOxCvPmUQrFSkZ0IUtYDByMaup8eaPA0QzaLHQ8BLWzQZXqfKOPlbqZfNWNe2ARuqrXfOtXFVxBX2xmhfMp6878W/aPC7RIxQrZb7o+7dXIDIwvPPznI+0V3fPrq27vsGDdlrP1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNHqvOYJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAYvU3026883
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WVhUC5KfCy052S9d2cEakHXZ3DpmiRO1eWkjBgLlKao=; b=ZNHqvOYJ5BbO4Dbc
	Xtu+XaBVfr47/MXPRQCupdjpSjx62/yERh6mbpW2O8yd4yIaaWW8qWnMniDLruQK
	wK2m75UquT3XJ07ANajsdglGzqF8O/TZHOelLz3IouGK15T+JcSRqm/vo8eGVwYd
	PsksKp3F30DyhpZt9KbhYkXIiBcJ7ToJOJiLZm98X3C87q2f1bvKdMXiaNT1Iiq8
	aS67Fswl/uIIoiWN+ne4Fem1eYUOX3Njlt2VzrOvCu0kP7VOPmYA8tZwJkBLPYaR
	hxfSqhVw6yQ99FgVMmXn6vvUgiXQ4dKfnzQ4NplpIx9D4wdIfmg5ZLj16g2CF2uz
	sbaNWg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pn9t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:02:02 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5db22173f9fso138055137.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145321; x=1761750121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVhUC5KfCy052S9d2cEakHXZ3DpmiRO1eWkjBgLlKao=;
        b=iNLWscOsme5cdmrZ8DjYb0TPqT8v0WLH1iUi2cw+vgFdOm8fIsCnvpOqEv13JSIhHg
         Gkic6hhaqIVBjLSX2V5mMegwOwVYJHX41bpf+pAZdUfPQ8pSgUs7P9MOPpDBUnFYyLwn
         8O9yDXLnO3L8JddwvS/FL8VWmCwdfkkErUiBhix0c8rKPhG7C42aDC7GFyNwPzUtxvSX
         s9aeoqYs/T30KIpGQMyUYMPch1Wzvbz3+eTrMusqSJOayEOYpAV9Luw1SjFklcitr2ea
         N2B+sYA1ELNCGITQxp1czOq8SOf68A8oRGH6sCbLZDzTfyHyHaG4298uaNThYKapBw1c
         GnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJAs8trJuNH9WMQXE2sLAU48gIDIFg/2o/OIMW5vkprCRShik0b3vRNMeR4PkWlQWOKt4m6ItHR6RtTx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxt9GLm7Zr0SKSRoy79MMQzyd/bEm57diwU80VxsMbyIhC3XW/
	kHQ+Q1F0DPuoO3QPQPyCimptroWDam0Ylx0KTPOlxqmFydCZd1f3ZLdk6jWQddR01VioZ+535Zs
	mf7HYI6H3w2se5mLSfR1n1PPLcBmSElV8MOoS4EeN2uMgTAkNdg9cxNy8SV6DI7l5PJ4=
X-Gm-Gg: ASbGncsGMjK/337xehr4yzRNB2TKUNT220nibR+VyV+G5uLQ6D9i1aJSSSgkA5Y28WK
	MfSTzJrFDIykEGKOCgalnqlGhQp4hgEY0gKeHkA7aDgUxo39O8ld1k6+gbCFqYMJ5Gh5FxUfVjW
	gwFfoDnF4kJuqotYrSlpZxYYdZuogYYV+8/908QuzBmO1qg/MjcU063kD92mBsNxMcAPceEzGQx
	BeVCMx4xOliKYA/UAkd+0C4osX5mb5b7orIfco2cuMXElDKNDuhosXnxCKE9Bnr0Dg/b6qL3czQ
	UKXiV4ZavwC1wgVsxRNSlqw7qhq0+EgHMiMIUhoQp6DjTjXycFnwxSrQzTxUlf2agARisublm13
	ZRWnk/mZpQ0GQnbPIJhYWJVx+GXt1hXGqOnidTbvKnh0wLXiEjsTv8/7j
X-Received: by 2002:a05:6122:15a:b0:556:8b02:f82b with SMTP id 71dfb90a1353d-5568b02feffmr660199e0c.0.1761145319385;
        Wed, 22 Oct 2025 08:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5zhFY1onskFYnO+4Fv5ggq4wyPuFkBT13ek6QdXSAtiXahagt25PhXd78pcdYze/hqeLzg==
X-Received: by 2002:a05:6122:15a:b0:556:8b02:f82b with SMTP id 71dfb90a1353d-5568b02feffmr659951e0c.0.1761145316876;
        Wed, 22 Oct 2025 08:01:56 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1354965566b.68.2025.10.22.08.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:01:55 -0700 (PDT)
Message-ID: <c56d48ad-425e-4e7e-9489-b3c926e4d617@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:01:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] arm64: dts: qcom: ipq5332: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-6-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014110534.480518-6-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX/Th98b//H656
 F8I9ZmVPInatmKXe8mQjzufRe9w6c6YspekTyfQ2sIn0zQqbgYXHuBn8MoUTWrxGhZyxctIexFx
 lvIxpl2sGon2OvGW/LaND4KgBJiy3aecPTBr0pXS7DmOSwRwqHt/X28BP1jSnzZOppzB3aC2en2
 NfQoUE4/AcMWHDfdo+RUTgn7nZhXwZxVSzdJCXECFwG55HmkMiCB/zEgimnGIbfPBi1zzeFQSVZ
 3BGs4sCS7BjsehwhEGhQXdyquuHhkvljze+3xt1rGlMKHR7L3yO8qqriyteEatiQmF0LoH9oLJA
 MkSwvH8p2m27fTLulQKv/qXJ1Jfit6S6ubaIfxf1tuKnbdO0icdaRiBcXT4dSrwIzOxofClBaDZ
 0ZAhiAQUCMQDwJRbW2s9GWFKsT5/rw==
X-Proofpoint-GUID: SZY-RIiXQynfwqMTSp-StwUh3qBHaSit
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f8f1ea cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eg2IErnvy-Z71prtMQkA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=crWF4MFLhNY0qMRaF8an:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SZY-RIiXQynfwqMTSp-StwUh3qBHaSit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On 10/14/25 1:05 PM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5332 SoC.
> 
> The IPQ5332 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

