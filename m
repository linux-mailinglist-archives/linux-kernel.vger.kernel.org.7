Return-Path: <linux-kernel+bounces-779007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236DB2EDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F874162EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC02DFA39;
	Thu, 21 Aug 2025 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYd2mfqV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA61D6AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755752; cv=none; b=bLdabiULCZZR5t7npErgXWgO9iR6s6BwdBB7HjMEdPSQrxQaVLXDu1EIsSzP+q+dGSAWbzxZ9RYRqHt+BUGaFz86RkMQU6Fb+s8CJLl/C7yyuE1EsyfxVao2SrQLk+1TCj1plb1MDvWmjCwpQtpd8faBY/4IyxsWIZojG3qRn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755752; c=relaxed/simple;
	bh=BIvo3nNhhb6pq2hOpAZto/z9Jz8pBYdUUXgu7fOc0cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOkXSSsffA6dMbpfo9CccqWWB7asU2m3MaDTcWKYQfPlSlltEqavw5dfWmd5fjewalnZH9q3KBEviQstVxtUWBIV7KoDC0whGZNXZnqEjlfXp5DUlO2qFsgb7vu1sWC9ULplABuY7sSkAmuvJk74LrjGzLLC/scKM+B/j4Y3AwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYd2mfqV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KIlK1S005785
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vAQUJRzmvhCQC0jxSCWFX17btFNmXhfAUKzWHJ2kkU=; b=PYd2mfqV0VMmDHkk
	Ytuzn6AvvZQTy6B/O0sXilu63/vHWZ2nRHlC1iMN8uz1EvCcAsNeJHrCQFwm3leY
	gDry8eZRskRF3obqeuOylDoG9XGVfpj0xdWjMqPyS+ReHsyAdVJnyJysiXuF0XrT
	3Y2Utbd9vDU1GLv/c8uhzfLXcOL35ZXTbr5PEZsKGWEqSFWBlZLn8pF4zRqMNpCD
	8HyFYpb9kyLafuCSOgF3kIz9O87Whv8dXgjoLCJ5V5346AIAGvj4CQOL73st1/YE
	yII6LzTLPVj03Hwmbkqn6uUYC91vvFsUzZvv/ZQx3keX1rEgvhotXj9KvIoW7ect
	xQ0K5Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cm52u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:55:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f42254so15145645ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755755749; x=1756360549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vAQUJRzmvhCQC0jxSCWFX17btFNmXhfAUKzWHJ2kkU=;
        b=G3981uTXIj9zb/A0WzDQs+0oBUDJefdKs7HJf0f7oPJkBLel7Ake28DczvR1/cUjc2
         KQYs1ksZU3+9yPikjjrLaZNqP/1urKEc7Pu0upiAe6scdjQMQHlTn3XbRUuFVKryj0X5
         WhRlfH/G67x9eYH/YFhqf+cXWVCZx7JTQf/3RfdvA2U7YZzcWwi7iic1teRaRXUVlgN1
         6rQ+eSnlhcvknn7OxvnPVN6KQLsULSjErJyORBhKc/zBc343Xp+JJPpwW1N4tMSW5QjG
         zweNDeLf2fkIL/RJcq6YMV76yd+v57JreuQkKk7mrtZ8K7nYvFxxQcPYrxsItT35feQS
         2GLA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSudXO0/oENskfSVsCLxPne0Ldr1fomOBBjab7KOZtWUVKCJ7WlyIvKC0/MfEGneapa+3wQ7ddf73tbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZleyAFmEI+6JAUF3DgR2rjUnYgH0rAgpvPwbsZMoRyVL9BPQY
	D4Et3oFPavo1jkLKJcmxykINyCHkhwlOG/xF3Xyx0qYiDzyc8u2apuitttysXUX6rUFk3LP6QmL
	H2i1e06OGg/gaoR7BHF+swEUxO0sm8Nfn5fMqvUVQunpwGdtVU2K15OilW5axmukE7Kc=
X-Gm-Gg: ASbGncs5Lj44QY1F9grwUW32NKrPxn1hr7Z3ni7bpcX3VxzcRIRHNSZMJpYFwHvpnwS
	YbNLHeZm0/2uKiSmlSE/X5gxFIETpvZ6TGJXmqSet+CjIExOObwSqJzenhzpzuy4lBvht5BEJql
	RdnSgFo3+6eLMcuZiPCIa9bmnrieiyfdVjcWEJO5I5hxKTDYQnDVPY/7586l5E886U/UNXcdncj
	6vc6CnRSN3VpWjPkDHt1nFCXSv4ZVT0GEdTqdJoCtv/nF7GU2jN/dyZqTCibTP5K3SraJyBhWwp
	hmARaMdpkBeooSKDpfVCyW9/UdSydbgj5EXXTiits+BHCsDDgr7Z80DJDDlgQBlurnh2q3ezACf
	SKkHdPahjpgg=
X-Received: by 2002:a17:903:1786:b0:242:e38c:89db with SMTP id d9443c01a7336-245fed7e64emr15945005ad.35.1755755748894;
        Wed, 20 Aug 2025 22:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdHZMqwJ6N5/TcADw+wqbTRuW4Egpz+Ak9mM6X1MOB+PLpuwRJZ9j1D324y0FeF/bKUoWuTQ==
X-Received: by 2002:a17:903:1786:b0:242:e38c:89db with SMTP id d9443c01a7336-245fed7e64emr15944835ad.35.1755755748478;
        Wed, 20 Aug 2025 22:55:48 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.248.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24608c9daafsm6158455ad.141.2025.08.20.22.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 22:55:48 -0700 (PDT)
Message-ID: <86ddae9a-4931-b160-51a2-f89d45d4038d@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 11:25:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath11k: switch to of_get_mac_address
Content-Language: en-US
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250821032755.636661-1-rosenp@gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250821032755.636661-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CK2sBcyklyQY5BNqX-QzZHgCw1jPyj8M
X-Proofpoint-ORIG-GUID: CK2sBcyklyQY5BNqX-QzZHgCw1jPyj8M
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a6b4e5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=pagehsHO18wfKU6DcLw+7w==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=xJH9kgDew1csY8MGnM4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7c3uZBjvpUJW
 v5SsZfQO//FP34Fvmp2PH0ygGo3hqAt8ID0Yvr6k2ShxF/VpDOlJJ8GJvssdobXkcDfSagBZPKQ
 Bw9Ya73hl/EBjM/8pdYkKPttJif4OMQvWBMTL4NvXm566jy2Puyr9hjDEQrgjBZ2AMq14Vz4XNC
 pnzUjKIblhyixKMNav6mj2q53jNi8p+RmRQSxrhLRIju38vrbrV8Ew3SjegNrS9b+TrR3J6f9Ux
 Xg4BCn+xTKleTxe9IPQGsDlx33VPLiBXGKPjIkQiayPyTlzwvI1gvfjaYbezNViCrMHZ2VYKNse
 OQfzJrurOcnSmGXvidCdN50HTunlV2gcC1nm6a0zcueO+lngUYbXIJoLzDOLhwSj1Vc+rB03jJS
 dRyLT04d3zxDaZgKhQsTBeiHcEhFbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/21/2025 8:57 AM, Rosen Penev wrote:
> This is needed to support nvmem defined MAC addresses in DTS.
> 
> In addition, check if the probe should be deferred as nvmem can load
> after ath11k.
> 
> For brevity, ACPI is not a factor here. ath11k is too new for that.

This may not be accurate, pcie devices are widely used on x86 where
ACPI is not certainly new.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 1fadf5faafb8..801db15ca78b 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -9,6 +9,7 @@
>   #include <linux/etherdevice.h>
>   #include <linux/bitfield.h>
>   #include <linux/inetdevice.h>
> +#include <linux/of_net.h>
>   #include <net/if_inet6.h>
>   #include <net/ipv6.h>
>   
> @@ -10434,7 +10435,9 @@ int ath11k_mac_register(struct ath11k_base *ab)
>   	if (ret)
>   		return ret;
>   
> -	device_get_mac_address(ab->dev, mac_addr);
> +	ret = of_get_mac_address(ab->dev->of_node, mac_addr);

I still think it is better to keep the generic API and add the the one specific
to nvmem when the generic one fails.

> +	if (ret == -EPROBE_DEFER)
> +		return ret;

Please note that this error does not impact the device probe as this is
being done in the event path after probe returns withis complete.
Also, this will result in device registration failure even when
the device is not really looking for mac_addr from nvmem (or it is not
there) as firmware can also provide the mac_addr from the hardware.

Vasanth

