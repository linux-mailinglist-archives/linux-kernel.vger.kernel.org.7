Return-Path: <linux-kernel+bounces-864062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79152BF9D33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069BF19C6750
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58DA278E41;
	Wed, 22 Oct 2025 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUmJKvyo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE77277CB8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103536; cv=none; b=mKdqykdfZUoPbTHEskJxH9qReQf8S9pMhkIwYRtl/QCLLn8vOPOeLRr+DAmflzfIhVecmihFNoCWJPHFQUfR0OWjGakTxE5eF9OlZObN/BxGcWGXTK/eBNhneElTE7834PwjABUzFfh6RKU7Qu4cNmQatYPuGn0ZJBulPrs8Q5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103536; c=relaxed/simple;
	bh=5AvDweL6Ij6AI/0bjUj8ghDmL/WhCz8Xq0xvwgQbGIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4ksMFZ1DiwZlHYGiSpZA7tPWLVJ2gpz848sfbALGLiCtXgM/q4N3TOIYGmfbE/5U77vDgeQumJEPme5lFSFvlOpFi5i+t35U2F2BmEquJRGj8dtzF/WvJxEDvAdTothFoFle7CvwX3o4HaAnxpnALhJ/JIz5PCSTbxc2nyaEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUmJKvyo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LNFqV8003559
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjfw9msKx7xfOlkSa84c0dlqx1z7JGX+iCQNM8Ki9hA=; b=GUmJKvyoXB6CN479
	A4sYjHWtTIZK6m2EdL9JNWYZHSPWih0gdSUEy4mPU9QQyZGOJLHLgGg5nt2cA1uR
	OzM0Hu0O17N+mEx+3WyEvGmSDdIk10vOKYVWctOLHMfihoOlSZPZxT+wrdtIoao+
	QONYHWpjRyvbCyZaJJzvceIgLUdM3s9KygA81mPoPGY4/WJEa2nps0UZmOUbkr7w
	Y4uYcm9FonNRd7UaZhmY+2Y7lunOmdiO7to/dc66Fg2VC+BQZcb/Tr+lF5kWZPXh
	09FUDyARNQln8Z+cyUAbhDgvvFSCzSDq3RSZjcWmPd+uML0Qv+xkYTPabmvli4CK
	4t1Zxw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkps8hy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:25:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28973df6a90so62344135ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761103533; x=1761708333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjfw9msKx7xfOlkSa84c0dlqx1z7JGX+iCQNM8Ki9hA=;
        b=UtSwylPrI+z1yvasQE1s1FkZmh/Yu6qYrKaQUSrAx3nw5R/DMcQgmYDikxWrfU8OIb
         /gzPs2uocV1QvicmqFXOBNCgipUFf2TCbs3Tm1sNrRXtUKSBCG+1X6Nd0RPemZEddKwH
         zqjrMg0h3bRhr27uIV4w/0WUDwLlE/5UqBpDoqJm6x86Br8x60czLNgfyPDCNLdBB7CT
         nFRi5bGNyzFO0K1/2Th8000kslcMtNTl1XKBj9JC4dyGeLMxBzFrVSLtykXyu8QPUEWx
         +dxbzOVRhO7KLfG76dPMG9I9pZp5thPg/KEs7++fmSHqN/q/9P4t5+eXS3S+cGr0M5/j
         COjg==
X-Forwarded-Encrypted: i=1; AJvYcCUy3FRmvf8r7pDPSK0laZqH66CYfN+sp3q/iC0P/9PHE4HrMcvN7EFDEO4ChRVH8ObjjFsGKHEKdlUf3ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrY5dVv6KW9Y1oUhLdiWnkLQ8CX+f8koIEoERlxAHCez5cQw2j
	eCWbb0n+2BTb7xlIFJdtxUE0gFOb4A+udSud91RXaS+Hh/BfZzfxUc0e6wsO41I0ZutDmJ37kV5
	2xTj0Ul0TWbV6GYiQS3ud+uJo5Sez2Pw7PftIEWJqSx0fP88Es9Z9EccKM0/4w9EYKAh/6tLsDd
	4=
X-Gm-Gg: ASbGncs0M021G5yXB+meNzdcQ41jSFlEpHKn9SlK3Xh3SAFr9URjbFzn+h4Vi/dLKo2
	0/I5s6x2iQg5J9UVrhwwXeksrHrfbCazr5O56BtgqGOy3VbEg2kYhTDxn/u60wJvQopius1cyd1
	w5jsp9u9KDymHVewzWLz5X57ZmQYyxMywOzOeWhKxjKDLQ1iI/FVkp9jFEd6DXdfumjiVYHmGPw
	4NWImnoS/OmTQq9oWrGBu4D+LEbY+OCPw0KGls+89rYnl+lex25yOzB+TiDbvYtIzp7/BjYU7s8
	PAY6Yw9+Hue4wXr1ZCQjdDKiWwurUN4OK9r/rNgimhwrx4hBuJuhY+cyFxqn9DPh3dzIU91GgAs
	2QYF9Aa342cXpnc3YdK+6keFM6st8NFvxNj3Z6uRW5ehGtKZ+dw==
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id d9443c01a7336-290cba4efb1mr250800325ad.35.1761103532708;
        Tue, 21 Oct 2025 20:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH7Ukk1PJxZsGOLz5xP4zkZ3wO3/M0rmRDWi2+HGPc13CHW4ETBLyTqSQW9AahAE6bQZMKGQ==
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id d9443c01a7336-290cba4efb1mr250800045ad.35.1761103532255;
        Tue, 21 Oct 2025 20:25:32 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.122.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cdafadb8dsm1179405a12.1.2025.10.21.20.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 20:25:31 -0700 (PDT)
Message-ID: <6507afe8-02d6-96ec-21b8-651fbd9b3319@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 08:55:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/4] wifi: ath11k: add support for Tx Power
 insertion
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX+Ppfgaz7TfLf
 DVM0HLa9ASh/mFgYQV/yAfm0Nx9ELo/wQ6oOItudvDCVwaNHYWakx0GCOtH8pUuye7nYXG7zuGu
 eiqzrqKdqJf3q82czpmo5nnDdJ0c1zqO3rRgOJ3G/NEreRhM7HOE/TRBKwCIhOruJz9v0RM42iG
 wMXImnQak5xPWBcUKGnKPSXcUB+0mQ+hvkQtPsY+eVd0XiVJtRvnl9WkzBSqPXL9bacV6VaI47C
 OYG9erjk9isfK3mW+nvs3vixDBs930IM+uwOZPr7iNJvDwXegUXJidX46rjbhRDB76AYvMPKk4y
 kq+iVXQyHn4bklJLVEMcRvEdvo75u3mGYaudTTMl+S9XsqSG60fKYhENdMqZmbd+bR3Z7xWUz8W
 5qB6ovyF/SuXugHiK/jxmF5kafLczA==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f84ead cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=MVWiM3nRykcdLg9H6cDE8w==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9jhMNZ7qWXdoG8tHMgQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: E4iEpEirVLLRkNN828E_b42WNHdVuOc_
X-Proofpoint-ORIG-GUID: E4iEpEirVLLRkNN828E_b42WNHdVuOc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190



On 10/17/2025 9:37 AM, Aditya Kumar Singh wrote:
> For certain action frames like the TPC Report IE in the spectrum management
> TPC Report action frame, and in the Radio Measurement Link Measurement
> Report action frame there is a requirement to fill in the current
> and max Tx power of the device in the packet.
> 
> Add support to populate these fields in the relevant packets. Advertise
> this capability from the driver using the feature flag
> NL80211_FEATURE_TX_POWER_INSERTION.
> 
> In software-encrypted cases such as PMF, skip insertion since the packets
> are already encrypted and cannot be modified.
> 
> Patch Overview:
> Patches 1 and 2 serve as preparatory groundwork.
> Patches 3 and 4 implement the core changes described.
> 
> For context, this ath11k implementation is adapted from prior ath12k work [1].
> 
> Reference:
> [1] https://lore.kernel.org/linux-wireless/20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com/
> 
> ---
> Aditya Kumar Singh (4):
>        wifi: ath11k: relocate some Tx power related functions in mac.c
>        wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
>        wifi: ath11k: add support for Tx Power insertion in RRM action frame
>        wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION
> 
>   drivers/net/wireless/ath/ath11k/mac.c | 447 ++++++++++++++++++++++++----------
>   1 file changed, 312 insertions(+), 135 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

