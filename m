Return-Path: <linux-kernel+bounces-723617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A9AFE920
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51183AF84F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F22D8372;
	Wed,  9 Jul 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drdx4gKN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5A2DA740
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064796; cv=none; b=ESONrzeer1YIkJfP97y1tLtD4wyOSkAvL/Ny/i/2UiPBcLvmRHJ67pZ3p3ZAnSZ52IRxtaJ8Ca+NLDGqfnf5ut3jZd8NrOuUvPlbhfL2Da/wZ2KHjmsC1MbG1f9uuxUghilTUZFedC8uMKfsBSbxXR6FNzRVzBqw0nqxwzf5TfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064796; c=relaxed/simple;
	bh=CzTpBjA2vitR+omBvLXiUIC3L2PGyotOkHTVKMqAEec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HabgPN0+p3xNDhVTrf/frLzDyUQWXl8fb4f0g5A1NtnSn6qusTpPWlFsutiN5eC+LU00PsIK1IzDn4J9qwQbmCj1KzZREY5piq21ghIT2B3r3eh7nOzCESndb8MluopFlhY6f356/838zKjogagDPUM3evPEMCHDQVgGEBTlgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drdx4gKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697naAp008067
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 12:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E4JeUBjGXjiulqpr8ObtMjmD+OAC5jcVrNpe3NW17TQ=; b=drdx4gKNJBEiVjKa
	pFzbQ5pKPXyrrXPMylxglnTaYC5rvnvPvEE1jIX1VOgObjerKAlkVUWIs54yaTKa
	giz5vaoOdlDUKMe33JGPz0AfkwTmcZPVIqUXcK0ErkBHlXYs3qNgt3++8qHm3v9I
	T5/8IK5yLxUgE+xYwVH0F35FHemlOeqr3kPefKSspmdYFAZs/EqoC07NJmEVBfbT
	TXxl9uEJPQtU4+rMMp3hSiRd59vsUycUOF+tWFSF8PFULdaXg6vEz/XRwY4o40zX
	UWB9CXGSkN6rm/V/BTsByrL/83AzAQjznWIiPCxd0XqU+lUxatm1B3Fw+tt0OgAg
	uE5KfQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg0xkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:39:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso8251203b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064793; x=1752669593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4JeUBjGXjiulqpr8ObtMjmD+OAC5jcVrNpe3NW17TQ=;
        b=X1efCpoHv7B2MTef3RcFYl06YLpRzbIGsLgvVXvbYyC+xA2Lydq2AiAkuaQEkDGeds
         tvdceUHI5c43KcIzYzbkCJyZIMEYjlf5/ZC4GX+KxRq51/BCGYByM0CmedPEUWNlrMnE
         RijDwc/hgbM+SkppyK6Tw+EKiYCu65VlvLLGjF5J7ckGmyjoLNnsV/5/h1mrV/Zbq3Il
         /moym4D9rRF/9YEZ7BZTpplYSnD3+018i/cRZYS2G2TLMQNxJmVj1m4drFwx3l5nHJxG
         xQ668NHCvi6pfSyut0UAi63mlKM/jwnsSqGBJ8iF33ug+W/9Uj8wr7pF5B00P3cFmfZL
         k+ww==
X-Forwarded-Encrypted: i=1; AJvYcCU+kX6Qlwpu/IRsI92kugvMEsJaOeq4vPD51HcVSaXsdj7apbiFuMztfO1TCeHEXeXeJpAzqgc0+c3wU2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRD0hoXSJUx+3OBp5mAuuhdx/BUfGxzUF53T6AxEfdtZ2ous5Q
	FSNaxnEXo9ZWY080CEHFvy8dfiKK1jXnpAIYxBtjbynV7Ehb0Z7d/XG7lZE5oouCBZNI+rdt1UB
	Eqmlorn6+iXMJ7WGvTHp6N7vz5fR2HimMM7lJKzhpTfiYMmgY9o73AyXpxynCXotoCjI=
X-Gm-Gg: ASbGncvZp27NuOHaBzs0QjZWHx1QzjHFBCwRjT59LCwI3Q228run2VOhUIzdKt1Qd6c
	f6hD5mlk6h68bS/2XgA3lbwczPKHxEp4n60fY+ebs1KMlAd51oDQ0DcRZ16qIzuPEgtA2YmNnmf
	lR9q3YcrLrvLOTArZ5KiFTQ6RZ2t0lNCsFP8GIGo04l2e5PgnATtJ4vEf3iqq6p5NZy6pyunD9r
	s68rPyjRegSorBlyOyfMiYFDPtLKO1f0vTxHdFNLj47ZW18D5xsfaVS0xdgPsa2+hr0Cr368fcU
	FM1kD5IwRLHvooGY7mb3NN2r2GpfpZdn7EOB0EZCaiXEYOJLnSjc
X-Received: by 2002:a05:6a00:2445:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-74ea644856fmr3569752b3a.6.1752064793503;
        Wed, 09 Jul 2025 05:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK7VBdZMMbsnBq4tAIekTkIsp6YkexavIr8EuGi0wWr9Tw52la/RWx1TJ63OSStOPaGoyV+w==
X-Received: by 2002:a05:6a00:2445:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-74ea644856fmr3569718b3a.6.1752064793079;
        Wed, 09 Jul 2025 05:39:53 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429c46asm14970330b3a.129.2025.07.09.05.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:39:52 -0700 (PDT)
Message-ID: <7ed53821-c86a-41f0-bb99-ff43ebedd680@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 18:09:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] bus: mhi: host: pci_generic: Read SUBSYSTEM_VENDOR_ID
 for VF's to check status
To: Vivek.Pernamitta@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
References: <20250703-sriov_vdev_next-20250630-v1-0-87071d1047e3@quicinc.com>
 <20250703-sriov_vdev_next-20250630-v1-3-87071d1047e3@quicinc.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250703-sriov_vdev_next-20250630-v1-3-87071d1047e3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=686e631a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=zv_5qE797hUBxoToDSIA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NaA17WiWpqz2_R84mmcmWoX1PaMSpnpM
X-Proofpoint-GUID: NaA17WiWpqz2_R84mmcmWoX1PaMSpnpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExMiBTYWx0ZWRfX0dlwmv1jY7yD
 08x0IcdSSgfzXsw5ucY9haDVyWZVnaLKRKnrCQUYu3fme9s8/+fbflWCFWNcC6b3Sv2F5TDOMod
 lw85Hs6kWt+eaFefdpLhRjbzqfyqWTCJCPMShBUswJCxP+ncf1QX0Ff/S16KSXGZcG81aSbXcJl
 3Lwl2jeIFxv51b+A91tAQLvwczvEhnLEKclOvzcHq6xJEj/A6pUj1pQZFN408E1YxaKOqotR2Bm
 6cqEdQU2KfnxJx/e5g5CGs1roBgzfywnQhGGkrSbywT4XgSkZh6TJm0HacNoY4AMEphYqv3Ab+9
 r8w16DCfOngOqoLnJdG1evOP/sp3mJHkV6VHyJO8sUAAgJyJWmLlUAhzKTXvMSbNMvtZAl1BRE4
 IBG+754o3q5SRAFsz7Tir/z4gohkmjH9hhC6Gk3JoBOAYmbGp2jZbTMYVyPWt2guxRU93Ii6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090112



On 7/3/2025 8:39 PM, Vivek.Pernamitta@quicinc.com wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> In SRIOV enabled devices, the VF DEVICE/VENDOR ID register returns FFFFh
> when read (PCIe SRIOV spec-3.4.1.1). Therefore, read the PCIe
> SUBSYSTEM_VENDOR_ID to check if the device is active.
> 
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> ---
>   drivers/bus/mhi/host/pci_generic.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 22de02c26ceb946fb618d962ac8882d2db1be6b4..938f37d306a18b9a47f302df85697f837c225f0d 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1025,8 +1025,10 @@ static bool mhi_pci_is_alive(struct mhi_controller *mhi_cntrl)
>   	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
>   	u16 vendor = 0;
>   
> -	if (pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor))
> -		return false;
> +	if (pdev->is_virtfn)
> +		pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, &vendor);
> +	else
> +		pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor);
>   
>   	if (vendor == (u16) ~0 || vendor == 0)
>   		return false;
> 

