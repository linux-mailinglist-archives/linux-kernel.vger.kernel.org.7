Return-Path: <linux-kernel+bounces-873522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E4C14216
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E4724E83C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674A304BC1;
	Tue, 28 Oct 2025 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QBhfMgQz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA552C15AE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647927; cv=none; b=ZNus3kmgUgAcsqfoD1d/eEQjTOUWO6KOVRwtFFvBIs7K52ZApk8cVIDB7KxkkDLA9nizDNlQUOMoY6977yia3vXjU4wrgIepdG1xa9CUPdmjKu5VamC1/qK07kqkqCFbL9HQEx3TIz/fidxWuxXxg0MmiDjhgZCKqj3pTs9gCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647927; c=relaxed/simple;
	bh=uSFUVY+luc2r0dmmvOXHLV3CbFnFPlkKvrQeqh2EgiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBrVNUdcFgSQYqWCCbk6jvtSLoPe+LtXBpe2L7Fw+64ww18Zu2kwc2Ia0R5Xqs4MhNgqdA2gnRE9vk9n79C1MWYZaNZLacYYJN4CrLzlY1jo/eV/8yBfCz+oEKls9ChX3bpD2ReEUUCHUo5s+jJBBxqjNvCsEb/A1Tcic25uVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QBhfMgQz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S8XrcG1177136
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jg7Q3HNJiU7N99bYi9t626jJ2SX6hSf8hOLmETMSVfc=; b=QBhfMgQzhlbXhPHP
	tO/O2UVAAMY1hclDNCz28wKMilx5kZa1S23JZdl0Yn81nq2H3YTezwUKR0fNZK1D
	J8Of72jl49Z/SQGC3eitOW/pxKQWnkZzMwQfDjmgvohPMIz8aLtrg529f6RpueYR
	PqZS18ahB8PjvhpuBzsvsdVr1VVtR2bO+rpvhK8o3/1Iv+8r9vWB2aQXSdG6IDWs
	SxRVjqYQh7hqgsYTJuKSsmDfcwc+ty5GBvzoxkNjPnBETNqIXxWTT3nn7PR+qML0
	Q6H5eRgCgGjEG6q9eMB1Z9M3ULP6xtae6q79sLEHTQUPWdwCg6Y9nNqm9GhbM+mn
	ZX5wgQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2tebgc7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:38:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7f5798303b3so14863686d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761647924; x=1762252724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg7Q3HNJiU7N99bYi9t626jJ2SX6hSf8hOLmETMSVfc=;
        b=vq1ke+yLW7cnec+d5z/rdC2x1z93HF5dFDf5qomp16uZgMOWlqlZfi36r4xaqFFsLI
         w73Ut7zkNo7zo5leaGsx+qgZonl5iz+ckR4y8tnrfrVvyn1P+UYAd4Fi1xtuoFcbZZUo
         l70umU+qG/eIFMw4pMg5h8v4p/YjZ/OQvlqjw3ns8uf0qH1TphXKWnGOVUTbgdNiYZhs
         OmrO4+2Hw/3Q0RC0VGhPaXTyVB2qyONcYtu56PLgJXT1QJnWvpN1jud4RRTtfwW/ydd2
         JYfp8wNZsIfKLNBKFeCliRkMbltsj+diytqEdVNWbOK9JUdfGAgmWshGGUjvj4ieylJE
         18EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHkyHwn094vqnfqJxusiRfOe1/K1nnxyNPw/Q2yvgiExplTuL/cZxZL5yLjAbBKp9GDiixH9zHqshrF9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPJQws6XN0piK3uGdBY9OTq2TypCkvX4B0Kl4miyTWvtv+nR6
	aZtiXcIxbGi5V3xOSxq9mN33w3XD7+m9uBvosAH1cZ1IV/dXiArHnyr6gw8SJAPyTY6nx9wymhA
	ChVhUdh70KMEP038uJlMRvRLLMTU92ZfvCRhrCX7GpPHLOI/7cgGR5kFgBcvLWNDmv4I=
X-Gm-Gg: ASbGncu0VSfE9w3jDKLUf7vTCEM8UjRM5CXBd5GtsGm4LNNvfRg06v30lQdzdopIleJ
	GR+v72/2FwMnnS0AEQa/ttvkrEYbCCHHxbZSGCNstRTr5c36/4BozMDaPgRQqh9eSPqFuy+xPmV
	DgN7GuTSIAlrXqrMYhVr/9DPwCMK8aNbmttS9ypDd0x7ZdFLvHLlyqS3B9JFsf25A0MDAgy2mKF
	gasqoJftixFn+ZT/op/Jwk8BKAYywyw/IdU1k53gKA3KY5BiR8Q0MR3Hrdl7NUeC/0f+wt13y9Y
	9H3oA8Dh8cLfzfH48iKyivZ4u6zfakpbYGB/p0A5A8YBEDCB+cMzLxcHqbuKIrFyge8FazChzWm
	RTpkNLhhfAqxygLl7THrC+DGbJeSMO/rCmbZl7+cGJhP/eAhaU0Zg+6Zc
X-Received: by 2002:a05:6214:2521:b0:87c:2bf5:550e with SMTP id 6a1803df08f44-87ffb104bc4mr23361566d6.6.1761647924140;
        Tue, 28 Oct 2025 03:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMfBni25fxII8Eovc2H8hAcEfVNeKGCiq4DQDNAv6UqFCPRMdvZA56hE1YjvIaEC9+i0ytow==
X-Received: by 2002:a05:6214:2521:b0:87c:2bf5:550e with SMTP id 6a1803df08f44-87ffb104bc4mr23361376d6.6.1761647923722;
        Tue, 28 Oct 2025 03:38:43 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c5bd8sm1051405766b.38.2025.10.28.03.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:38:43 -0700 (PDT)
Message-ID: <37676360-49f2-4b3c-8c4d-30b1393fe253@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 11:38:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] clk: qcom: videocc-sm8750: Add video clock
 controller driver for SM8750
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
 <20251024-sm8750-videocc-v2-v3-4-6286bbda3c8e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024-sm8750-videocc-v2-v3-4-6286bbda3c8e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5MCBTYWx0ZWRfX7a3mfPz2sdoI
 5r0LMzpC3HgsobiZNmUbMhCq2Bh8kJIuNWyStOPuNdQmNoVUqLvlbAv2bx55toWxrLqWhmD2c+P
 gkJtUV+RtUqSGAfCRSNt+uRtGL9SAHP7R389JQOYNdnHAGjzq17NPnPCa19SFtc5xzlz9VsIR1c
 cO/h4zYGAJMigOZNwbrpx5Ho/JLFlD1IiD6HlYT8beg79edAY3VXHwhiNga9AMC7QtCXVMBNzc/
 PcxPc1IXGE3eL1XelmwIRNC8YtbJG+mi9sd8zdSvt1jXpOoWW03I1WyerqBhp835zyiHF9daAGo
 3q4+kNaQYAslsFwMYH4cq8XZ4pI89pamCo+HBsrG1lzIRaQdW7DYfPpOWRB18ox5RM7WwSec5Bp
 nDaZat7718kkmIqQn5U3z8td5PGrmA==
X-Proofpoint-GUID: Wh4fgoGz2h2g8iE0QuDAgimskbw0dzQv
X-Proofpoint-ORIG-GUID: Wh4fgoGz2h2g8iE0QuDAgimskbw0dzQv
X-Authority-Analysis: v=2.4 cv=V/BwEOni c=1 sm=1 tr=0 ts=69009d34 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=d7ClhsmVZ3m4v3ji_18A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280090

On 10/24/25 6:24 AM, Taniya Das wrote:
> Add support for the video clock controller for video clients to be able
> to request for videocc clocks on SM8750 platform.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

