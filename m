Return-Path: <linux-kernel+bounces-888125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C8C39E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 290084FADA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148772D9EDB;
	Thu,  6 Nov 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hSLKx8pI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Euh5obur"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71097214A94
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422478; cv=none; b=Jhm5ftwWqikvZmyoZo+Svu68u5GsRHjPhZTKVqY5R5KOYLxeA2JUYdDLMft3xO1DvTUFSEzLt+cSFup9NaM8Oe/lJPoHSJpu5zAgxkjoKQLQKb/F+UIr87kRJBYt421Ocazuaniz5uE+ubQiaLzIsv5c1noT3bsldhlXKGfxUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422478; c=relaxed/simple;
	bh=vavezM5McYCdO0GTAExjvodbuYeC8rvFYUP3Bzrb6a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC4lLgv5qfd0ejAQs+wcLe338uEeBX97DHGjPXOiYxi9Pu/FxEXE5yOqMUINqSZT28NzQH+k7zjLgJnbCZET56+MSE8+Uzkwkl6DNj+ZzrKjWMlgGYS5r6j/efaorh0DrXbGwDFmWVVOwXdo8JnTAGppvpJKS3Xp6krueN9aldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hSLKx8pI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Euh5obur; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68aqXX2327621
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 09:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9IBxiMX/J2w532V+aM7PJT3Rhdmy1U28t6gabb7CXog=; b=hSLKx8pIVW45KUsN
	UE5qLb8ljopgQ97CwrnC1XRVYnlbeIqDY038Sk3CR9zQENRHt/lvWe/aDxbbGneS
	3RJk3WO1YHDNZtvBotsfSLca3QdcnMj7lNqHXqeViHhZvydRyBeHP1k5L6L9KMWm
	hAOQhhkM24EwKjEbtTR4I/Nx/1zABG+ROYSnyrQ5pnXyqYFzVJuUigL2Y5k/S6BP
	ZQNXJ5gaDs+M6dFf0aSDex6f8G+371Qvpwogtnnprvt7IsX2q2utiPV5LZGVhZSj
	V9ukR/kvm6aPBv1vY7TAkfcLu1DjBS+bePfFMy3W9zbeMCpOFXsbm4aSsuLrcuxN
	IXCxqA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h0v1e8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:47:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b1be0fdfe1so3790685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762422474; x=1763027274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IBxiMX/J2w532V+aM7PJT3Rhdmy1U28t6gabb7CXog=;
        b=Euh5oburOgbQyEo3+sqVXqEORRndoSlqmAN6LGWQSBl1sGYMlx4wnBx0tFxz2l6vlV
         DHLF7gLt2BVJ5QZirossefsLdfaGdmaCyLcBdBdlBR5TtX9ryNXT9P0838qCyFaHcBZ0
         GKv+ZTSH47S8iQ+l6XTWrUC5p7ykvAaOxyM2B/502fTwiLq8qAyUzIKpdYghmputGnPn
         NXVasNDInm8U5ScXlpTumOWA6Tbeqory/9plMw9lzlmaMB0aVzvXcayuqS4FHfuN/jpt
         hYBOb8a8HXreZCgj4ll8Ih2G7F4fPwzFsNtgJ6cmjBcUcVBc4szZQh6Bc5jPodraOavS
         n1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422474; x=1763027274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IBxiMX/J2w532V+aM7PJT3Rhdmy1U28t6gabb7CXog=;
        b=vLhwVniZcik+wJFROdWRRpZlGiwsYKzW+JTW9cJovIi8Y5e8USiFsn7dLmX1PYqONe
         d9EBSTh4kTvZTx+0Pf7jpnZU7KFDAuhR73dXM6ikxWbvGPlbI6ZnPokZNaAl9FwLaJCI
         vX6wldG9/PvvCPPBW6pf+17brmEEws3rH2uh5NHBZQSzXmd4sVFOrUfK/TRHJ496d4W5
         Y0Ancvg2nJJ+DgcYqAb8/mfkFV3EVWyC3eqqT/xb+E2uHhCM8Xt/HBQALF9L2n9GyytN
         3KyHKJ7DVuDUh4nMwHATYj3gKtcPKhQ0VelxbK7tcsrIWNmkPBjDw8/JMHTYE3oDl+N9
         +uMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+o2X+D79SyzP+LFtig59upE6GQ8GlhgMAhyqPgKvjpDgV3tor5uRfrCXpaL4TIizcPoev6ebNe3KYizE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1WdE5ykRVLeDS4ImwOzX2SN2kzbyb2W+pD0tOMk1HNyMVpxM
	qoBCEcG9f+/6Huy0GhoyeOscOE/upELljODI/VSIZvOrGNxGaFYUsAykjPrDIuVAvZaQBwy40qA
	qJQh/QQ8VF1RahDxlwHqD4HXsW2Ovpbj+t/7FiQhA+/3EahHjmQRAeNPkBM9Nw+6XLUe9E1IP7H
	M=
X-Gm-Gg: ASbGncsOZvTcOr3Ks1qa2nObo7hNW9L0bpbOdTD+6jGlQAY+Uvf1g6MxeGsrPfRYoo5
	hIVNWfpl6zqw+eeDT4aoszQzrXCinNFwqnMTprnX6X48UoFWX3w3YI96PJFxfcMlk+mVRVZO3pE
	ZFNON6BGFVrSNzruhTub1z3RZQh3UMqB5J8C1I1oSZ7SpiBX3pNbHw3Nn/fI5Gy/mHawHf1qdPH
	h+F+dywSWXV+3Xxse40T013i8JmfQGrogBTWy2KlrMsXtxgcUl8MfZXraX+y34RKmw/xZ3y/esN
	W+Es/Srr8E9CVtBHb/MazXwd1aWoCoUiGZ/KG3OkYYgAN+iH8EBnqBS7oC/1XdeIimVJu4z5Y15
	vSgcbCC/+DtsssYlQkWTkYoM3saSbaPNBV92UsKT6dlD604hCdr7bcaIo
X-Received: by 2002:a05:622a:18a6:b0:4ed:1869:6c05 with SMTP id d75a77b69052e-4ed72338594mr57540471cf.5.1762422473661;
        Thu, 06 Nov 2025 01:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpuKuCWzp0t7fCbW5KVhS4FD/Jdg9+sVXbJS47KWq/o+LFPWmer47f/TSodncTzWe2GNegOw==
X-Received: by 2002:a05:622a:18a6:b0:4ed:1869:6c05 with SMTP id d75a77b69052e-4ed72338594mr57540311cf.5.1762422473198;
        Thu, 06 Nov 2025 01:47:53 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6412a27d68dsm516869a12.9.2025.11.06.01.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:47:51 -0800 (PST)
Message-ID: <4aface5d-66eb-41bb-b6f3-ee8ce5d5da6b@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 10:47:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: host-common: Add an API to check for any device
 under the Root Ports
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JnFDJXUrz-BtTptZwhBQXHRNJLWgm1qg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3OCBTYWx0ZWRfX8poqf8JUh6Rr
 vPGs+YaGNWBwSkweYyjBo0NRVSsrayPq80ZD3FWAQDCqhEfKlsMtp2+XepRnJE99docfgwiRShB
 pX007vLh/vnt3jiaCG1okRjGn7QZaXfqy2Jd/y124nEVwbGICr8JU5T/R7pwDQ/NtwwFgSy1eD1
 zP3W0RhZ7upoje+xf9e0blW811tdOTh/1bcyZWK9ZcFl5y03ekuofEzEFaL1nNZ+wv/ynkQnOpT
 sOiKQRQNKf1iXvrVj11CeYCuWJV95DtgLsNQwBpyAhbZuwsEsNulGkXpdnaIqty/adbHvGL9zZP
 R5FzGaUXlE9MBL2b1maALlEUIl7ltHHWQt/pd7WUztle9NBjZ+QMAOvciikS8s7BUUxZ8eggkEA
 /7jd/k3Q0GXbOgArH4/XjOU3PJgMjA==
X-Proofpoint-GUID: JnFDJXUrz-BtTptZwhBQXHRNJLWgm1qg
X-Authority-Analysis: v=2.4 cv=PoyergM3 c=1 sm=1 tr=0 ts=690c6eca cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=X544SMn2G6euAj6E:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RsEGIJiJnbDJ2EEs828A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060078

On 11/6/25 7:13 AM, Manivannan Sadhasivam wrote:
> Some controller drivers need to check if there is any device available
> under the Root Ports. So add an API that returns 'true' if a device is
> found under any of the Root Ports, 'false' otherwise.
> 
> Controller drivers can use this API for usecases like turning off the
> controller resources only if there are no devices under the Root Ports,
> skipping PME_Turn_Off broadcast etc...
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 810d1c8de24e..6b4f90903dc6 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -17,6 +17,27 @@
>  
>  #include "pci-host-common.h"
>  
> +/**
> + * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
> + *				any device underneath
> + * @dev: Root bus
> + *
> + * Return: true if a device is found, false otherwise
> + */
> +bool pci_root_ports_have_device(struct pci_bus *root_bus)
> +{
> +	struct pci_bus *child;
> +
> +	/* Iterate over the Root Port busses and look for any device */
> +	list_for_each_entry(child, &root_bus->children, node) {
> +		if (list_count_nodes(&child->devices))

Is this list ever shrunk? I grepped around and couldn't find where
that happens

Konrad

