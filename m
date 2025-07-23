Return-Path: <linux-kernel+bounces-742339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E126FB0F027
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC556167582
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311A286D7C;
	Wed, 23 Jul 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dy+lQEYF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A528B7EC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267383; cv=none; b=Gv/dBjHwDzEKSPwH1DF2gLx9y5KUKKn7wErmEVw2W7m70OQ/Fz17kTbKhEetbj6cIb1rp/rOi9VWN68xuhPwWsWW1uRwABHToaA+GMXWtHGFnjN5bkHKWwXUyBZqkWju1ItDvql7LB5mgyYO8FWljaVC6Zrl5UMpJ4fpUEz8Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267383; c=relaxed/simple;
	bh=f5vjYnuwq6ABDcw1W6FfEOgL9eISvsb8ivewKAcEJXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=banzNuq9LRqcuEFQZ7p1xoaAhwVcCjbp0mkC8tbgeVmcRqGB4/kikTy8ZMjcNaMZHA0hhASHsap63mjLAwItfxmSaYn4eoDfMkNpO/7XL/7+n4pIFP8RuWxNoap1iP9I66xrHW/I5HoPaheFRlUW8CwU2urRmpXOLmAWIA/16GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dy+lQEYF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N92fon009244
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zqTjFr0XvB8rxNwwFvY/OMrafbYzUbXKrxHy9b1cJTs=; b=Dy+lQEYF5EQev29I
	PBsUuGSRAdaeaE0aFK+ofrx4XNVBVdInAbCmtKrDSe9KtHurL0vWHBlr5NECj2Qg
	oShBbqGDNi+4vRsUj/be8evf1d3sA6LAS9zkX71Ds0+/t0JlNPRlLj7sr+0+Lslm
	mUX7M4Z50lT4HHkAdcCNBQoe+gymJ8DbUv8jn8ZxSv58DiR9OfcnQyJh262lx7GS
	lAD4joq2/+KCEx0/tlUYNOna8uL2rjHFxlU7/z6dx9g3PWf57LWheFSVMxNT4y6v
	9vkXiW6sfOeKE9IvXnm2gPEtA7+6pbECOOcDj0fEqhBNAgVjZMQ+VCqF1OhJXgMd
	yjy3CA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na389x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:43:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab77393308so21526301cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267379; x=1753872179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqTjFr0XvB8rxNwwFvY/OMrafbYzUbXKrxHy9b1cJTs=;
        b=g1pIBZiBNp/SzV43ntLI5v1EsC54yPD6XCxGCtCls45LJ3Irf1mSlQIQjXDnAO9Xid
         lpCqjpB5bU/GK/5EYcq3tLTC0bCAJ3a8PhBH/C+KWXNTC27n/Os0E0DkHsahEP5p3A1g
         qSJX1ipKFQcBWtw6wjnMPur4TmeihDxFF+fLIqcJmYvCv4UJta2yPBRMakITxv2pJRi/
         1q3dCMY1UwfBBWAXZKr+IyXkL26NFhQ3+wUNO6r3FiVBIplxkwSvc4MnFMlHKFf0YTS7
         x9gCj/QGDOaf1OfH3+mNPkOvJELK1Y4XniAw9H/Wc3NJbBkZKy+6u5aB2Djsfd6Od+Dg
         y3Ow==
X-Gm-Message-State: AOJu0YwFYq9zxj/77IvM4Zt1OHFP449Q6nIY6OBdi9J+Y7JlOP2CQVef
	+S6EFvheV+JtsLEyBNe8+D4GkGe9LENIEgLTj0gq/H42563egNtcp/aSPg+TdsVNNg89UxnqjiP
	ji3vvRxxVVURsnW9tH3bJ1pNPrUQBy16kCLP90FFuV/t/yFFSVLsOtwL2bAJ7hhFFrac=
X-Gm-Gg: ASbGncuTFdtObS/yIQIFG28P7W7gP/35V99pO4c7r5vAUmT9UWIcRXk8Ka4dVWOo0cR
	3QEvkiE3WmbO2x9wLH6pLCdqVt3jZtjuqZ6oZCZhfnsXozzRCsJ3qOLI1z0HpEx6bsxjFK3fkb1
	XJ/Eoc8W7yGQTqTQuHLr9ZELGPKjApr5hNiYtUSm2xR25nHfywu4D/1AkQdiuV/6EgZ7mhlyuZ7
	uRMklEBorXDB2LuI/UAu+DZ1t8w87pIXtObTOP1W6mQABsrWnBkqAi+FEIKtYQODMVTx+NUvXpR
	9vBRmH4Ultm9nBtFJjdpQ25fkQToqRqbdJhmhniW6Nsz1ncU5wmFv0LFB5PGoBgwf3BbKd02BKB
	XDuRlaJNvLsNVOU/mvQ==
X-Received: by 2002:a05:622a:409:b0:475:1c59:1748 with SMTP id d75a77b69052e-4ae6df217d6mr12951231cf.11.1753267379382;
        Wed, 23 Jul 2025 03:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYlXiYalJcIYmfsGuDzo2btn4rvUYkzj8173rBsMVorgA9iyFHUcxva1ejaW684OOniAAJMA==
X-Received: by 2002:a05:622a:409:b0:475:1c59:1748 with SMTP id d75a77b69052e-4ae6df217d6mr12951081cf.11.1753267378840;
        Wed, 23 Jul 2025 03:42:58 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612e7125fb4sm7106394a12.9.2025.07.23.03.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:42:58 -0700 (PDT)
Message-ID: <ea856550-263c-49e5-9a6a-19f9fabfb407@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:42:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add initial audio support for
 Hamoa-IOT-EVK
To: quic_leqi@quicinc.com, kernel@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Trilok Soni <quic_tsoni@quicinc.com>
References: <20250723-initial_audio_support_for_qualcomm_hamoa_iot_evk_board-v1-1-816991701952@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723-initial_audio_support_for_qualcomm_hamoa_iot_evk_board-v1-1-816991701952@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7hSrkgXqg6wurAJn9B1MVv_AuVYyg-Ng
X-Proofpoint-ORIG-GUID: 7hSrkgXqg6wurAJn9B1MVv_AuVYyg-Ng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5MSBTYWx0ZWRfX3W+Lkq8aa5DG
 i2D7Zzz7V+jwISDugmGMU+w3P881OblxPShQH/vyGAzCKyKaTUSWdPJVQ8VykJfbDWcHl7qBU+w
 AbrEaLDjdu5bqlZHrZimp3YijEvkOcXIM6E5FgHse/87tM98JOaHKsIf/uxf5heXeklrg8Tr4SZ
 U381nB9DOAQcwOHxpjWRJzf8UkFkiGwFa84dTpp3T9BR9RRsL0r06R8T4RS9xeTWuKdlVaZvwRD
 RqlJXcaGgz+EeicRRxxQkSnrPLDjWZPiUvCMR+CrjNbyaUARghDcjn5bIX4fuSiL4PBJOficoNp
 qR8EXE8zKJde+GF/ej8UUWQTTl5x3MYEShjIeLoYeyIMicykO2+aR1OwMCdtWXtUAVXsfqbX5rp
 RJ0VSEdT7dFlRH/NesG/cgTfW4wL5SglJBYQA+U5WxFSMDSBnX/B3/Vnu+81NXLwQQE55NmU
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6880bcb4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=e5AY6RWa8OZnZzLWLjkA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=914
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230091

On 7/23/25 10:29 AM, 'leqi via B4 Relay' via kernel wrote:
> From: leqi <quic_leqi@quicinc.com>
> 
> This patch adds initial audio codec support for the Hamoa-IOT-EVK board,
> including WCD9385 configuration, micbias voltage settings, GPIO reset,
> and power supply bindings. It enables basic audio functionality for
> testing and development.
> 
> Signed-off-by: leqi <quic_leqi@quicinc.com>
> ---

git config --global user.name "Your Real Name"

Please switch to your oss.qualcomm.com ID for submissions.

> This patch adds initial audio codec support for the Qualcomm Hamoa-IOT-EVK board.
> It brings up the WCD9385 codec with basic configuration, including micbias voltage
> settings, GPIO reset handling, and power supply bindings.
> 
> The DTS changes are adapted from the existing X1 CRD DTS and have not yet been
> validated on Hamoa-IOT-EVK hardware. They are intended to enable initial bring-up
> and provide a foundation for further testing and development.

Please hold off sending the patch until it's validated, then.
Please also use `b4 prep -c` to make sure the patches can actually
reach all the maintainers.

Refrain from CC-ing the internal mailing list when posting to LKML.

Konrad

