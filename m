Return-Path: <linux-kernel+bounces-764085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C61B21DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFE11882DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AC2D3744;
	Tue, 12 Aug 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JjfgSUic"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2FE2C21CA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978374; cv=none; b=RyyF+2m0da0+bwuTTUiEFqtRLaP9UIHpshHQH4E/uFt/ixeRUKsgyVQ3btk7AYiPfOuftAiaZMPoPjLnseUdkjtpdw+qr50WOaTOVHHsMzXpFtWQ1Vup/qeRxwQpT70b1Dq2KRBrjpIWjX5QuljVWSLZdC/X1/WX2U6+Dp0FIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978374; c=relaxed/simple;
	bh=MZYffmo89cYE8maSdSo0z0Jwfu3QhnjLnWg1HHvDDWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChHGtlAnDbPNobMxVLtRb91WdiRMmHZXra9ayXbTAlZBDv/LiICfbeO2GPLQZcP6Q9VtQqDFIs2Z/AzOhEPlCGNW0iFga30EoJJIJj/Z6PiBpaTRt6YzyfHZfR3fEUjETCdhgm3DWu35zKFFAFTlDW0aENrzhbLBPgSFcteH5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjfgSUic; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5XddU010041
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UVs1qOUwwZ9Ygbyop1f7a1vL6vie0gD3Yyv8YMlSSUg=; b=JjfgSUicPYhkaNMH
	ta2JmlpPCCMD7Nf8UnH93O46VdDpISPs86GqyO4AXno7PTVVdKGd0s9gzw8grMKa
	YtXrbqCmURAsIkJTK4hnGDJtDJZKUlkrMgAqwggCB0/Oyi0aoSXAI8srDYa1AqI6
	2IKrDcOw1xHqxWcW8RHBx9CiHvoB9OzIFOFLOLZVjJHkKNAv5hB+JZqLnzqwkBQL
	1GxKrXH6TpWkslxGINc1KqfJP7H/24TJaNGAc4rWht4OdZFiuPqb9UYnQ9F3etfx
	yudSr4l3RQI+OcUsDef+akAwr3VMf2d7tFANHZPKYv/j+N0/5xG3UkEDDCFGxfn2
	Tlf2Hw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx56d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:59:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fe28867b7so68689245ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978371; x=1755583171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVs1qOUwwZ9Ygbyop1f7a1vL6vie0gD3Yyv8YMlSSUg=;
        b=RoR9yf8zRWde7Xq3kUWTi2t+uyItHqxe3Frig/RAq2RfquzZDfK3GRzzCdaB0kQLw2
         FLU8QD6E2LKLyg4brAXd3Q3FwGb57eTi14cXlJmcr7yMLXamkUQZf0FGaTEAEB7nU+9f
         kIb9tmBHObpzrnwpQ1SBgQXrSoNRdxTvchsLgTJTX/N2bT+2HGgSBqwr9XGpnlzTVLJR
         zQhe379C6L78r+Zsfnltkzy8sW+pUgRxxgq/tFLWfOFzohcBgjk3OE2f1QC89UYhweGw
         DYG50ihrub21UpDQmCWqUROhO4GJU34iOq20UWHI450Bd/HXIhlv2UHU70xHKoWRbhJF
         Y+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxfpCmaPT3G9thmqjf7ddqOdovC5x0Bjkez1M7XLESqkKzM3YHscjPS6uJZDT9QtvLfZ9ih4ZNlqZK4DU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZKRbPO0dZ8SMy/BSPymnOgP1z1ICs3aa90UE+aAimiQZpZnp
	ewgQtJLhkbJMEgS8aHbU1kZrzk+YURkvvLuXjdKhfBx29L0rfI0px/kTpRWRvcdUxprJM70bpEJ
	042CYdRdgZ6z10c+O0juPCqob8mUyXx2wObtag4RnAH6VbAvi0VmuvdGflUgFEE/Uhzc=
X-Gm-Gg: ASbGnctrmKP9RnLKF5KkUuig/1tiTvo6u7HYGmbdtncm7+3F38vywkgZLfR0tEfYnz2
	OMMh2PRwf8azQqSW4AQEde1vcvymYrIAxH0WMRX8Adr4Dq48Gp3GkRA2CFOIXsY2PPhyMCP8l3t
	c/Dru2E/joFbg/tkbpYuA6va6+KsLHW2GOb6P9Jg9M8HwcB/ypAvTxy2GTOYHOMNzGFtT61lo91
	sncl4QsjglPxNpGbWDtrN9pKmz5Sab5yFm3OMmNXkAiVYuaRp6ire9G04Pm17+BrIdxnoqednf1
	BMmb1nz6AWz8xJkb/Cfh2MOt/XiJ5Z7EhQHYG2L9YCjMInR/SbyGfwvw42k4mN4aeLIV1bc=
X-Received: by 2002:a17:903:3b8c:b0:240:3909:5359 with SMTP id d9443c01a7336-242c222c92cmr223933765ad.40.1754978370738;
        Mon, 11 Aug 2025 22:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn6qxc6dEvtwqsdAG3FWWRuYtHLzpWr8RjIwuXy8tAJXkzisuhVTlP6xpTp/Z157QjqC6fXw==
X-Received: by 2002:a17:903:3b8c:b0:240:3909:5359 with SMTP id d9443c01a7336-242c222c92cmr223933365ad.40.1754978370317;
        Mon, 11 Aug 2025 22:59:30 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5bbsm286877015ad.128.2025.08.11.22.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:59:29 -0700 (PDT)
Message-ID: <beba23d3-b7e6-4368-b2bc-b802bde4166c@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:29:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] misc: fastrpc: add support for gdsp remoteproc
To: Ling Xu <quic_lxu5@quicinc.com>, srini@kernel.org,
        amahesh@qti.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-6-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20250716132836.1008119-6-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX0hVe/U5kpbzv
 FqR0Or4GTiscbUxdO2txSwwiMMOVXFE6n/k/Aagqf7Wl2fZrg3rQcexyuOl5VYPPyBxmxNPkCEU
 aYu3olUbXzY5xvPXtn3rxgimZhE4vFYhijFHOoNIMEhjEksSdQXQT3Eo4TgqwpwvK3Onsg2OQ1/
 UuqfvXEk5INehr38dIlkxuYOzKRhYzFKt/JAdZjVZIoq6uwkw8zgZxDU+VR5dq/NzmNkK5Raj5u
 K3EP2IDKqqG/05LeYtfjz62syZfsbAVO19vjmmXlzqp2oJ//V1PKsun1SIoPrYxKX3R63P1kB7B
 /M4IfEzwJB1wWsc/IVwhcjBxY1PUwbeOiDYQsKqR3ie4qwjexFvWjK9r+yzxQ4JSR5tUR5KCR5T
 WvFAp2qi
X-Proofpoint-GUID: YPDSeUnjK1Z1tK8WFbDn6Vv4-E8AfcNh
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689ad843 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=OU-qGZapnvjOigiI56EA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: YPDSeUnjK1Z1tK8WFbDn6Vv4-E8AfcNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057



On 7/16/2025 6:58 PM, Ling Xu wrote:
> Some platforms (like sa8775p) feature one or more GPDSPs (General
> Purpose DSPs). Similar to other kinds of Hexagon DSPs, they provide
> a FastRPC implementation, allowing code execution in both signed and
> unsigned protection domains. Extend the checks to allow domain names
> starting with "gdsp" (possibly followed by an index).
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 85b6eb16b616..d05969de406e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -27,6 +27,7 @@
>  #define MDSP_DOMAIN_ID (1)
>  #define SDSP_DOMAIN_ID (2)
>  #define CDSP_DOMAIN_ID (3)
> +#define GDSP_DOMAIN_ID (4)
>  #define FASTRPC_MAX_SESSIONS	14
>  #define FASTRPC_MAX_VMIDS	16
>  #define FASTRPC_ALIGN		128
> @@ -2249,6 +2250,8 @@ static int fastrpc_get_domain_id(const char *domain)
>  		return MDSP_DOMAIN_ID;
>  	else if (!strncmp(domain, "sdsp", 4))
>  		return SDSP_DOMAIN_ID;
> +	else if (!strncmp(domain, "gdsp", 4))
> +		return GDSP_DOMAIN_ID;
>  
>  	return -EINVAL;
>  }
> @@ -2323,13 +2326,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
>  	case SDSP_DOMAIN_ID:
> -		/* Unsigned PD offloading is only supported on CDSP */
> +		/* Unsigned PD offloading is only supported on CDSP and GDSP */
>  		data->unsigned_support = false;
>  		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
>  		if (err)
>  			goto err_free_data;
>  		break;
>  	case CDSP_DOMAIN_ID:
> +	case GDSP_DOMAIN_ID:
>  		data->unsigned_support = true;
>  		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>  		err = fastrpc_device_register(rdev, data, true, domain);

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>



