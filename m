Return-Path: <linux-kernel+bounces-721601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B263BAFCB85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828B21C20529
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C062DCF75;
	Tue,  8 Jul 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJkmmfuH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E325B1EA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980123; cv=none; b=LnaTJ9OmYZobJOTmyPj7O4zxCCCvSbWJkt82bLTNReZiw0nEKSuxTV3ooH7SYWt9Nrra1qQZBt4fwtM3PNpR6Dcyv0BtN7GIK89GNLP7Jn3aG0ljqmYQej/PqsTh7zC1fs/aHMO5AGh1WYzOVNUUPAdrNU2unRRsjbwcG9cw6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980123; c=relaxed/simple;
	bh=WzAnNBoWqDOEgWIAvOrUUm+cPnnAQsDqlITlF4IdpJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmiwhb9BOy/tqh/ukmWsBMFJ5VRLzmGOpfQI3+2Jz52bUw97NHiO0GbH2hqYzF7CwK5Ao6jwoZ3NY3WiQ7dTtfn7Sfh9dU7K3JCW4pdSU+6mc4fTG81vOoHz1u2Tzl1YXISbwsUFtyCM13hpJzovGOrypO9qyVv8BjTNmxV/N1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJkmmfuH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAFf8000495
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 13:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=; b=UJkmmfuHN0Jr6kLA
	ld5/JgheNu5sbMNgZkiwYUgO4GjvZ0BhglW00c59meaADsYhrZJWYQqmA1gc/OUc
	DUrnK/NvCvH5C3ONM0GjvGKFSW0GsKNdezqCPza8ZE4tevjkJ9e1npZeNjJmh0a+
	INZ4fgtIBBYO0j6f6etpT389hYl24vuIu2PlUOUPRwGL81B4dcop5sZWnBHRiFtS
	shOo7dNQC/vBBtAFgTDT/48Rt3FZKyaSlMLbcUDvTnThA0dRBC3CHwWIE5u6O4Qv
	lz8B4EKeQFe+0hY6nqY73fapqXHeHNzj+ARgwUPzAaWQ1qY+sXoEn7n7SuSC6Xxx
	t7bbIQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrknf7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:08:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d09a3b806aso38803285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980120; x=1752584920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=;
        b=m8pR+NmcyshsJKpQt0gfKPpcEZQNG0MaXKWhVZblLce25CHP0/tvetDK/WJ/1eAGRH
         CwRnjoaXe9uRsD8cQqa53ib+PKezO2uVE3VYCun6DY5FLJKVPmJBodApR5aq/FIPtwju
         wPkQ6hJYxiQLJpOPE02NsNnjy9GsoHPfsqcSQgxJeKARtemeL/bIGARcteyrbt/JmyuK
         nr4nSV3t+Wfo7QKao+rR9UgOyR2S93eqYTT2MEDXbYNeZ/JV/YQ6QiNfQPpZOtGZY+77
         WsdYYrC0ozvHDqNzhB28ZzQ/PG5bZISRX1u4fEMsm4oFhGhygw1sBdcw/Rrqu1GBdoEz
         Bk5A==
X-Forwarded-Encrypted: i=1; AJvYcCUqGuJ4nmQMn7wjyUOTQeUEwZKswZSwhKYOFQw7gkEyqdqv7HXHGeAYABHRMQ2rgscYHL3O5vJsL0RAx/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJc0SkbNDg1wxbYl1g5w+AGGxweot0SMEZ+rX8068aSGXis5bH
	CzNmd6Hch8LeIG2tMdA2SV+cR65QiOTfURkVBmsknSGpAtH4DKgPXw7wpcA0dXJAj11mp9SkEjr
	1r2JRAcuVGhy97/XLR8wwmX8NcqsoNIXoT5Cp1BdqaIB4fy4LEN0JBvGem0Xvdxfvs+8=
X-Gm-Gg: ASbGncvwEhgxSXVVedno/7IPpCy/+VfeuZbilQu3RxMp2z9o58rNT1bccdrXtXXRtGq
	tBRYk+YMroSL9g8wJXQyRRvGGGp1FJKEofB1AhaOBKCwFF8lvsBD01tnlMZcY3y7GyI8lg6yplK
	4qpph+5Rn3dbSq4agZrqpIZ93DwSnpw/KQdD6r/6toIrLHopHLW3UlFMmktMNkB+nRhll/JdC1B
	yo2da72aQJKsUjpiAFdENq8Rn5ZlranmjuFAshNjsY3+nCBWcj0u3j7wtuTZnOUigzsIdSIO0Se
	zt7goHoSVThYC7PeR+kab1jmiGtBSovwbVm3q3LlgCPw2xcIuhG+EhdrU6uTRed3uAd6zdW2NnV
	CTpI=
X-Received: by 2002:a05:620a:4148:b0:7d5:c1d9:939a with SMTP id af79cd13be357-7d5ddc689bfmr784814285a.9.1751980119802;
        Tue, 08 Jul 2025 06:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjMkzcx+Tq4TsX9kndjZh7wHfMuEQIojKWDO/yYN17QbawLmZlZmFuRE1iLw+w/7zUU6OuFw==
X-Received: by 2002:a05:620a:4148:b0:7d5:c1d9:939a with SMTP id af79cd13be357-7d5ddc689bfmr784811485a.9.1751980119240;
        Tue, 08 Jul 2025 06:08:39 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm883127366b.180.2025.07.08.06.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:08:38 -0700 (PDT)
Message-ID: <fd367b55-fd20-4601-ab03-b398dcb326e7@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:08:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] clk: qcom: rpm: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20250703-clk-cocci-drop-round-rate-v1-0-3a8da898367e@redhat.com>
 <20250703-clk-cocci-drop-round-rate-v1-3-3a8da898367e@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250703-clk-cocci-drop-round-rate-v1-3-3a8da898367e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -I9Xrh8c7xkVehLgxlWJu9siwAxbjPhz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOSBTYWx0ZWRfXwYJSIREXQV0J
 OYdGKR5lpK4+IQDsckzI/9l7Js3FYCo/zHxLcxZHlXIiYMf/GlzQFHrXbELfyw6e954pZ1AQpcr
 QyP9uFnhIN8V7tGjDJFPikY41GLOwU4qohwtxEMN5pSm6FqypdGzGkZ+UnKD3ow0w3wiMLWZZ0a
 TC9UIpFL2o5zuuWndzY5ryPqXMSRe4LbgpRR0+Na/NqTDPUxK04kRubN847bjtJCVe/aEUIhFK2
 iunX0ifeZN9P1n8TLG4/0chQeXtdCZph74OzoCs0iWiY98FXYDMsYjUwXXE5tVh6vgxVgbxDFN3
 IXPNTuQSVhZJQ7ZWZfLMW14uueb2gT9AfgSbZl92kKGFO9b497G0/zw6tIZjUeyiEkh3w2zmTxn
 GwBJdz9XBHx9tlIX/W5+dp+LRLnLV7HeuekwI3GaRWH1erk4LNu+L6XZzr3pOKINnQXQeehV
X-Proofpoint-GUID: -I9Xrh8c7xkVehLgxlWJu9siwAxbjPhz
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d1859 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=oBXrOfH6mq4iYN50PBoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=798 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080109

On 7/4/25 1:22 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

