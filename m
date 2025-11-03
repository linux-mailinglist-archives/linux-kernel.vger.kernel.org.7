Return-Path: <linux-kernel+bounces-882685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E8C2B203
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2EBE4F1459
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FEA2472BB;
	Mon,  3 Nov 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sxy+X6bt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FkhfPsRc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC22E7BDF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166641; cv=none; b=GcwkQu9uZMe16LcBLE5ziFCB9ckjTU87wUsRCB5/hA+z1P41ophwe/6rGkiCPWSUpNExI0Fe/3fct6joYQLPoYx5T5ctGw6mLJMq6FfPyh/aAovR6kGpjxSwhEVEGsUPqb/XyzWBXSdmOzWQv4lXPyjReXNPuebKbP30M9Qs7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166641; c=relaxed/simple;
	bh=S3z3AEYSNb6TqWPbM2T/LYKK3xNTKe5o6Px3LyQEqeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdJZqyP+SE4EVvnUQR08i3zAYlmktRqKZ+m6YXkj1kxksp/qArrKTYbX2qliv2TqTgpRu/K1BRmKLBd+cEeT58Fj4vAjN/VcFFARwGDmGXJdqwH8ZY1A9+Bps1BAGZYuZI4MjFXTHkmQo/Q0Qak0aLkKmZxbYO0G9P/McQOY+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sxy+X6bt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FkhfPsRc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38mphB1320887
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 10:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iTCZB2uO9jAu0wY+BLk/6izG8J5g9DH/vQc6x1Of+V0=; b=Sxy+X6btoxN9FDsF
	Ahg4XrrZA/uLfXkL3j2WkbUm23qFSe6Fr86Vsg24q0R1WJS/w1IFErKTXK+dl77q
	4aipmB13Uo3R90BoeHOp1SVSsLZuPCNs02xO9kB4eYP4wwhJk2MOicXJtmtGZNVD
	jFqGj8p3Y6pKAqqfOovOptA7nraw+y/8uYMiis5rBKN2idS8y87wK/ScIrpaYtzx
	Dy3gp2BTYudm7aweeNIrqAoxBULNS76v2U9O8MzLJr3E8jssKBxnKLinQaFQi01F
	qNiI03i/gxLpALO8CezqJPkyZNCSVPA2cUeZgIBylKejJZ4AnZi7xelogw+zV+zo
	oMLOqw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57wechg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:43:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-826b30ed087so14878336d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762166638; x=1762771438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTCZB2uO9jAu0wY+BLk/6izG8J5g9DH/vQc6x1Of+V0=;
        b=FkhfPsRcWFgwOPCf29bo3JRIVowFEL54esLswpUZPNGqqIMteG15gYsESj4D24MZl9
         Y2F7DajOGHVB7wPaNCIbq1gRuazKxmwUruzYhaa9S2ai8j4LIgYZt6/49SB4z1yYc6Ra
         x3OTVphDcvRMMxzSIkqFXqJRR8NjCVsnIO7gDRdhF9f13kvcCzO9P3NGRUMGxySpBa20
         pvimZE4+02KINUooQ1ktefSB/OoH9vPnGILE/1CG0mx0O/6VGUzIzrTazrd/lxVTzsHd
         E2i6poX/5yxF3Oxw8b1nwmMLal7wEcsQbA5I+VeoZj2wm50xqCZoYb7FEvXm4EUJxExQ
         m74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166638; x=1762771438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTCZB2uO9jAu0wY+BLk/6izG8J5g9DH/vQc6x1Of+V0=;
        b=OgKq8O6YcC1thhseFC26vWNOhu81OD9A2+ocNVmuDmHB3ZjP8GxHaYnfyKZ49/IbYB
         6fIVMYjqmh4OKlqAHbOmlAS5daY+H0sJjS8sXzwguEv+QBGs/Shq1ph5kZarLvrPKCls
         EDvTEr4XeiZjNq/g3qeKLOSJAEeMObZE4KYKmAqOs85BkLTLhjpSGddRwGb/KfIEF0Ay
         EGs4ny9CBlKF5BXz1RZYzz+sol0+sHbcHLEX1dKaQrK36vd2+BKD8RGnaSA219S9tUQ8
         7oz+RTlumMqFp+iZeX0Yb/t5sQyy94Mv79htOpKKzQukT7MSDqmw7tzlx047AGW00yVy
         htWw==
X-Forwarded-Encrypted: i=1; AJvYcCX6GPIIe6oNLFaUPKMSVViU1uI6vco+z2xwqO07SxjKEBCrEtTbazsIu0cV94GZv7Jg61BVQAusdcBRHqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvv+aX0YMqUsUCgWUSWcOFq/6o4sOPxRLCQBPGCSbi/lWp8ZI
	+DZPw0dAIyMVbte+m8QaCDVZ5shz91cKjLJl+l0MvTyrxb4f8+M18qBF6d0PTaApDtmrStafgzZ
	7UUZqcfkRghk/jU3p7kTlXkhEoiwtM2lroq05Fm9/jDmFbCaN5yX3iEaaag9kAALQSe3SvLtA0M
	k=
X-Gm-Gg: ASbGncuyxeFybd19A8l8efeRJocOmgU0TXUX6PV/jYovgxJ2sd+eIjuJkeyEqP4ZXm0
	FKn5cLk3LUq42Hx4fVI8SpyQjUmQMVP+YqIQtm3zmsz3MOJ0qz6vyutaFA9Wk13Cx17oI+1E1Jl
	KG2FcIDyC24IhnRH7HrZu5tHRDPTHE+Br6z8mqhpELaWjngd4hiI4l7NF5qHFl60AAq+I+nMgCg
	1kUdVkiSLOtAczbIwE6VE3kZLFkqRY2AV7+uA8QOD17L1jJsnBfuUVgrwDh+xhw2IjgICcWNlPk
	O17+exWILjdmIMWmcU/CxG9y1kC/oJRO4Ba/b/OOB642XJAGOSeGXiwG/aUIaZ25cZxJG32a+rj
	O/Y5YdlrXk0trcBhlrMhSoEEZEJypvUnlRWC+RtreuCW2yFn/9sim2H3j
X-Received: by 2002:a05:6214:1634:b0:880:442d:6339 with SMTP id 6a1803df08f44-880442d711cmr61924026d6.4.1762166638110;
        Mon, 03 Nov 2025 02:43:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMpuU91JDujKnOv2gb5OrdLPzgPeAZ8rWjLiqjT7iQk4EJ7Oo6aW135nvnZvmkdSKRuGQ+PQ==
X-Received: by 2002:a05:6214:1634:b0:880:442d:6339 with SMTP id 6a1803df08f44-880442d711cmr61923956d6.4.1762166637617;
        Mon, 03 Nov 2025 02:43:57 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b719b3117a4sm60330566b.59.2025.11.03.02.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:43:56 -0800 (PST)
Message-ID: <48292ed6-1d63-4fd6-9163-096358f507d5@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 11:43:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: qcom: ice: Add HWKM v1 support for wrapped keys
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030161012.3391239-1-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251030161012.3391239-1-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=6908876f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fyxe1uYkvd6LmZs5FP4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 9MY8-Lh9eYTvatNxcf778apqKT4kTdUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5OCBTYWx0ZWRfX5DFNGezdHdNk
 NuTypedsj0zQewVJJ7TYZ8o1i5kHv9r/J2Ci5gYgUPasg+qP7TAu8dZarzWGgKeNgtIQIkPanRG
 LnZDvPOEzitlmV6QljWg4D9UGn4OUow03zoq7Ibol7GpCRyRAjg8cvxp/lWdECEmZgkpKVTlIef
 Bs2dn79uMIDHK7hhpuNK4rq7vv5yfX1T4L+mDHyQhdchH0CwcAQ6q71fCj0tCV56aDokNibhuyX
 1LweV4z/GN7WuEhGY1PWIZ+PXZPWW/dLT44twaHFeRweYTw4BEg9BEcbKObVYGq7Fgtp0THGF2O
 DNu4/badxpJFeJfuglR0lPFGWRSHU32O+n4cMCwLX6XcvuqHadJv96bTtEJEA7mJxa66ty/a3/R
 8/Pb3ATko1tktPW6/XVlM3vCON4PBw==
X-Proofpoint-GUID: 9MY8-Lh9eYTvatNxcf778apqKT4kTdUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030098

On 10/30/25 5:10 PM, Neeraj Soni wrote:
> HWKM v1 and v2 differ slightly in wrapped key size and the bit fields for
> certain status registers and operating mode (legacy or standard).
> 
> Add support to select HWKM version based on the major and minor revisions.
> Use this HWKM version to select wrapped key size and to configure the bit
> fields in registers for operating modes and hardware status.
> 
> Support for SCM calls for wrapped keys is being added in the TrustZone for
> few SoCs with HWKM v1. Existing check of qcom_scm_has_wrapped_key_support()
> API ensures that HWKM is used only if these SCM calls are supported in
> TrustZone for that SoC.
> 
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

