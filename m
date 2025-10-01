Return-Path: <linux-kernel+bounces-838573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2E7BAF96A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185F43C6F32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA6280330;
	Wed,  1 Oct 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d43vyIYE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21013279782
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306994; cv=none; b=frXq5bS/fGIrTOmYJdvZ+OPisrxcbhuqjh4nifVTcwCkMUX3JvscVKiWd+2hrbiHWKBfVkj40wYcuG0f/eTsli+J78k8rnQ/oEbIhc2lGaqp+0hk50oaJ+VqQMKyrIt2VBoMOiz4QCcuOe8pZ4TqSYklOOhwnSr0XOG1srSm6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306994; c=relaxed/simple;
	bh=6qX378YfIp9QrbNMz0Pxbr6TFYT3iKxK+48OaAx5WCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWquuzrWpU/DTZAY3yQEA6AMvAdrJTBPI7diiZpoKcmdX2XZgZiD10p2M5l48K39tF6wqjegU6zIUhKhFfbjGoefUkkGS778mFCjwuC2Hg2upzyHhgc13q7G4G0gt/fLjUftRsYh5DShMjZ9wN9eMFENL2FGyHkUuLwjzh7qP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d43vyIYE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UK4GOR009323
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BfqDjr2vHvMLSpelJZSSDQAyOp1sqU85uHcOi6EeR9M=; b=d43vyIYE8peS22gl
	RaiBsLJGpH0xAWW/ubA1bNyiMc+R28AAo7E7Lw5wJZTAnbLA5W92hEmKRjMDBapS
	VoxIURn73FGmZbNhpM/jHtpp7XBPRyomW+SGdRxs+BPAfrNThN3JHP70B/gm8lsw
	/kVOoR+ZYbXgSpfBh9YmP5IgEG+tB31cdu1//8v4F3NrU40udh97dTuSFzt6sy9e
	pZMIistL2DRplvNwZEDDUn8kZ6IGqQFhPtlRJWXq7oe+9zz5W1JVKPEHa/Bq2cPL
	GStqNNbIHldPYNI13CTSV8dgRrxolzW/CJBfFoUfUGmgwnOLosYC9jL/B9Ycbo46
	6D9K+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977un8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:23:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85696c12803so299637385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759306991; x=1759911791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfqDjr2vHvMLSpelJZSSDQAyOp1sqU85uHcOi6EeR9M=;
        b=pkvqWQjwsS8K0inK1ohbWN9FcCLVegI9gqc9iZ/m6YcaKdR9G7gozkAsGEYJ3gWOoN
         ZqTb8+wtANexEQ4dP9hQyTt3dxMc8LU33yuPCuwsYXT5vSU4ikKAN6ww2ZWiEh2A4Yxt
         b2Z5uKOy4kasmR5tj0MHZ1W9pazdxussUyWcfn9NSzv0Y6k6hVkmCGWSXFXotYTX/swY
         ZrLXzUSrZor1Zob4rq2zydE4KbuDD4k+IT59Da8U1PPGh+6XS1L1p+QaT9S4d8OUvp4Z
         BI2yAcM+QgWGtbDjwNsBtU/aKyJvJg/IaVsQw6lwEUGxeqwkzLeZmwSE0L6Xyw9UwtcP
         99fw==
X-Forwarded-Encrypted: i=1; AJvYcCV1K1Q9Q3wINpbOOrhI60kXq+hONhfDaiRJWU7wMI6rPKTTVUbqkAS5rwVY2mCduGqLds/tamPDw5sMmiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCoGasI5uJRU0h+XebLcmbXhosHSaQlJklpMTI54E70OzvkuzA
	agdmXYUg+U6iDKdgOB7qyNEKuN7JHt3Ff+wDi5EI2SUI9+kG4+j0/yDjVboI/tkqh59qk9AMXD/
	q7RmeX1J///K2/TEpTUT6zhTJC42r88ecdnaY9E2Bj53WVB3iA0G7cYeIgtNulfjG+Dw=
X-Gm-Gg: ASbGncvk3pODa7lRVJ5xOaDL884N0dBitQbvi11LGpNZhnYJ2yLiKy0sgWwrMO+9vQR
	OKanoRK4KI9ntAmFIXCcKp9wanO+d9sx31hLpG+kvFWFS9xKqtBlMfnp2wlv6uqr0A01tP37dnZ
	IX7yX6qBZsCx2AcI87pS0HkNbO+yXb9+UVVPj0pbUPVbwGDd0n5CK4Q5hqC8oBpOR0XhVAtCMgm
	q6E00cy0sIuRHsTb1lLuDLS2bisuQy8ixXaW9WOBnTuvTOYqgJk2ZdBFbVpfah0fIJqRtsOXNty
	JiWIst1tXcGnjTl1+1bzPxw2bdUoDm3GSbI3T0V8zjtq/3Yz32GGoHefwanXtelYlVgCCfCMrnH
	6yo1vNGIcBDXvT8DayBbzNDaq188=
X-Received: by 2002:a05:620a:1a90:b0:86a:79f0:6b30 with SMTP id af79cd13be357-87375f08125mr218916985a.10.1759306990816;
        Wed, 01 Oct 2025 01:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGnFUTD4TkfM05gLH1wKBu6EI4TJguWDNzVTARV3sTq77NHeGIczqd8JoSF98aSUiX1VzeMw==
X-Received: by 2002:a05:620a:1a90:b0:86a:79f0:6b30 with SMTP id af79cd13be357-87375f08125mr218915785a.10.1759306990262;
        Wed, 01 Oct 2025 01:23:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3a79fdbcb4sm894030066b.85.2025.10.01.01.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:23:09 -0700 (PDT)
Message-ID: <a5907537-cecc-4564-bae5-981d3ad85d7c@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:23:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: QCOMTEE should depend on ARCH_QCOM
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
References: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PuHajyvn2FTYurJzmr_l87LaZ2eOEyRo
X-Proofpoint-ORIG-GUID: PuHajyvn2FTYurJzmr_l87LaZ2eOEyRo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX8VAZMgEdTWZC
 Fi3t9d2a3AUXjphXvm4G4u9KTDKB0kSOHFgpGeaCZK3TLfjCT4PQquTXMTdauolGThMe9LdEBfl
 pqr5D/Grn6+gO+NdiPUuzzAFutYIMltYE88sN0Nyv0mpKEpi3UIrFbk7SW+2NAglaJSTc+i16uR
 PQf3aoc0HCzZ5EmAwbhte2KzwRWnnJr61fmCfBRXIvHe1y1BIxs+EUngy4U8/gopaEkjW7Lxjkp
 3u3GW/qgVDx708oipISPdHJb0K3tQXErDGZnApmIDGWsuA6JuCqH37Uq2j/4dXYn6rxVjw6S6Yt
 TCPM0aHbpPBIR/LpEZpLIvx+bigj8BkJasiouOAWjxkd74P1vCKKB8Jbk9FUyo9J00WJFklv46e
 Axnn8jJSfxZwTVgkVmKR7VJ1kQGreQ==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dce4f0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=yXkz1KN_3VbnnYl-rMQA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On 9/30/25 4:44 PM, Geert Uytterhoeven wrote:
> The Qualcomm Trusted Execution Environment (QTEE) is only available on
> Qualcomm SoCs.  Hence add a dependency on ARCH_QCOM, to prevent asking
> the user about this driver when configuring a kernel without Qualcomm
> platform support.
> 
> Fixes: d6e290837e50f73f ("tee: add Qualcomm TEE driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

