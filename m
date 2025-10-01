Return-Path: <linux-kernel+bounces-838667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4CBAFE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECB17A9D13
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E022D9796;
	Wed,  1 Oct 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1IDEJh4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECF35977
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311325; cv=none; b=PhEEdBmaPgJjl9goyq+7q1LN10C9k1xgabpcYmCeTka5CacvqQDc+rrIcsU09KGPNTCphZmpk8ZFuZ65mXuF4QrmbmJG2A8W6ArQ9arMwVZ3T0Gq9MenxXZTDWbbQWqScHaSXAcC65dczTuz96qgWYRO3jAZu9impm3ctS9sJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311325; c=relaxed/simple;
	bh=clodCt2KFV7idC6nf+b0UvwIapnLPbxEnItnIWj7QEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0/MKlHxjbDzqXmnPT1mslDX/7OOMnoUMxu3aQ3vr2tagZlm21cTfJ39cwFeo7+nSf4kwPEJ+dy9F4Fxvboz0CcRBLDNPzQiVZR/6nfqR4SSgdrzsXoqA+heIogRyaIyLQ4a4wtZ5Z0QdoDvlcrce8lHSt6qm5jircI9dSpWJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1IDEJh4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59196I7M015470
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DDF9dailVTb9C+8g1Gxz0cI5TBD6wn76XGlSDfVLb5s=; b=R1IDEJh4EBryW4Sb
	vT9pxjcQ6folIvZgqA+UqusGWBLRXww5TIVxaPn7sLYRgwjLmUkrq8+zsvRI6zKA
	15jaPB+YRd2wsCuJwJs1UNNYjyctsUFM60nIxHtQ1uYrOeboFRQwO7cTqcslIDv0
	AYFqiFUJijfnhIwtIR1Gf0FdEjp6qg1EO/5BWc4F4EN5+Y6VkJnD/PbO6zBp/c8B
	0vi26cHbZqTwqJYj1R8XJ3cPWpShfJa/P+nK1zMHHmpFP+yrxcNooVzKaImHHSlf
	EL2RC3URhNiDYTX4OgtZuc80r2Vvm//aIcBbUXQPRXcBURxGietSfJUTLM+d1B2c
	SbYJvQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr417h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:35:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269af520712so75637295ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311316; x=1759916116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDF9dailVTb9C+8g1Gxz0cI5TBD6wn76XGlSDfVLb5s=;
        b=d88e/rx17VmZ+sWLRNz/IEEa6s4rcJRAgk8iSu/JHwRcIliMpyiMA3dGoOx4s2eRZT
         cv9ghUk0LDQSDHnwyfLu66lZZJ/WUpHDUTdyWrX6TsqLczJ+RUBN7Wik0ujzSHILBhGF
         d/cCDDWA3wRndKs/HXHNErmR9FJ0JaAh4BLw0AChostWOeH7XkDLZoYIhDWqtK1WUR8z
         haLRHmKvl+MHVB0uVBhweiagIWBV0Pk7O61LtsxcJK9h2hSCYBMtZ+jUHNdcSF0nKYtz
         BxnyOlzmWHfwscjDa1gu0ZYBLMn3MYiJzvw/1kdXfF8j7DgfWnjNn8cpiSW52DPEtffw
         OpMg==
X-Forwarded-Encrypted: i=1; AJvYcCXXkmPnZxXQLABho1AoALw6oePfNXZGXULrCASPgSQofhIeSnrs4zJVA6u1stn5V4oh5Y1f6x9Qo1NaN2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX2n/BhRJZx7vJPrYc0JzDUaBGIQBjbaBIjDq/16xZe6SnSPrl
	2IcqJtjQBErNIZSA1H9v+PEF3ByXjgs29AKBM+SAufdZ4WsglUHGT2YcVdvv25dShdiYAvMnYqg
	3VZXlj2xgJdMQFDKgRFH5s5eLqiGtpUaVZHWg4L2mVdGOdbduAfDXMR4CtDBRD6SHuv0=
X-Gm-Gg: ASbGncuz6+ba34UecK/hDU13DU2KTgPALw+3Ntcz2bVs4H3HyQdZZPYdwg1WgOD9ti2
	sw+mZTr5iniU17IZDD+Jgbhv3p+n22xTwe6wC5rX2fB4Y4lgktW+TzwK8Te1VCZznKNrCYAJMUn
	1IQWZpnXpblY6Ha8qC3O5G5EHJl7RHm//1VQ51ujyaHHn81iwyJu1ccFBikXQZRhjK1EBbYpUQ5
	TgPEwfWZBst8a7kOuVApDaMFXZijRwtRWtYci/vAe/TL/ecLuHOXKutyliIcLzHKGFZ1FCQXbZY
	vM9nOHkEDQwibTMiF7ZS/YSJTBWwwcatvd82goz3ZiaHPedx19KSi5dxs15qkG8cQSV7NzxviUC
	kHfZ0
X-Received: by 2002:a17:903:2384:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-28e7f2f4ef0mr36261175ad.32.1759311315770;
        Wed, 01 Oct 2025 02:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYUv/Dm0XesDSTyHwQm2dVe57hhTs7K33D3ebSSuW0U2zhQHMjz1FXWOI+Y+NBaNAKCKO4DQ==
X-Received: by 2002:a17:903:2384:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-28e7f2f4ef0mr36260875ad.32.1759311315356;
        Wed, 01 Oct 2025 02:35:15 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8c6sm181633145ad.56.2025.10.01.02.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:35:15 -0700 (PDT)
Message-ID: <32fd77a1-f352-4f82-be18-c978fabac280@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 15:05:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] i2c: i2c-qcom-geni: Add Block event interrupt
 support
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
 <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: C4XYLrhZirwW4rxZBAM18bKihcTkpJn0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX1/vWCt2Wa6q8
 0rOrT9VRlRmGWuvDTm8w/Inkula0MRkJu593gh8VRzHqXgoXW9apK8O0OE6zzsFNPkxU/2jsRtE
 msCkg/jVFeegnuW5jOQUhCNMlcejyj1jeQOuU9UhUHv7kTQneagFV5enAdIa7+ibJLgGgBfhIxX
 BtTzQkKkv/LPRmZHiWukqXaBebZ8yeT4+R1WJ6/h49vR2RRUCcb2t2gwC9XciYeQ5YYejtro/L5
 avIlOaBPdcW34YelngIbOLHnVW+sxZfUJA2hWxunySi09N7pOSJN9qYXEmPYvyKGJ4nwTNOM6z1
 U2GzEYfQ6nsIjM0/yaj1fwjgacdklkfjD+/YzEbahHffydD2G65laM82OVBfABZQvw4lM8qFVTo
 ZxBvPihDEHo7V33qOJJ8DxVR1/xQSQ==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dcf5da cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fvgdV2PV7z-sFcuOFeoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: C4XYLrhZirwW4rxZBAM18bKihcTkpJn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/25/2025 5:30 PM, Jyothi Kumar Seerapu wrote:
> From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> 
> The I2C driver gets an interrupt upon transfer completion.
> When handling multiple messages in a single transfer, this
> results in N interrupts for N messages, leading to significant
> software interrupt latency.
> 
> To mitigate this latency, utilize Block Event Interrupt (BEI)
> mechanism. Enabling BEI instructs the hardware to prevent interrupt
> generation and BEI is disabled when an interrupt is necessary.
> 
> Large I2C transfer can be divided into chunks of messages internally.
> Interrupts are not expected for the messages for which BEI bit set,
> only the last message triggers an interrupt, indicating the completion of
> N messages. This BEI mechanism enhances overall transfer efficiency.
> 
> BEI optimizations are currently implemented for I2C write transfers only,
> as there is no use case for multiple I2C read messages in a single transfer
> at this time.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>


