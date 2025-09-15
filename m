Return-Path: <linux-kernel+bounces-816837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84106B578E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1341A28013
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48DD30101D;
	Mon, 15 Sep 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYAEBRaF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A133009F4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936762; cv=none; b=duf30gs6ctyDgLsriSKTskTkUKH8InH6hxyjx3kI0Tupuu0A8AAAcPJru4RBWOH6P9dvf14gDplnrpt1apkQT/oCcw0bd3hr2TtnO6dcAPTTkyNie1Q+WCzKb2ghUis6pnIiYguRc4w4m5MXglrvVuaWicZaFkik+9mELifox0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936762; c=relaxed/simple;
	bh=BrOH+KcMwf/4Z7+srHs9vRripsew+HPQoXsssvWqnNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBMOINy7A6vN6EquUKYo7hoq9o28kOKJBLqhBaG+ghH3ma33IjcbPQMtCBDPF80uloWzZNtan9mu5rsstbZu+cRleavSvuG5gQjL8gTchYq4g5iSyC2IJpHFZpX1Sdemegojc2wCdYI3VTKW9URuK7NoISfCGxFWZ54I5CvTaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MYAEBRaF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FdJV020478
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yc/EdeTsapZAIKdxQSsdsqo8W7xeyLArRmYWMpRhLgI=; b=MYAEBRaFPe9kOt8a
	dawDB/vuw9Ht4Ok6tk4vv0Fmoz4sY6DA65qFAIHMopmwqD6QW5fntBxLagnC4iv6
	Ri2Mea+gZC2QIeZk7DFi4G1jslZZNPeSDrAp95+RCDPeZ1VEQ6sukDEDNC4Mj3rx
	An63bsNplrbb/P33nSok3tTc2zL6R26pu0Uax0hg9y5zSonJv1D75yRh490plww1
	UWkTv7A/Qt4/Lp7nkgmAd3LmLDhpRVD6dVEu4cr8OOiJNEEtpqU2QX8wNiKDANrS
	F8hKciBykwEuIuo5+tuzp09wdyo90Vnv8J+2Wd2upe4AGa2oNPpvqvi+XC8j7546
	O0f42Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950pv4sbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:45:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54abd7e048so1590373a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936758; x=1758541558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc/EdeTsapZAIKdxQSsdsqo8W7xeyLArRmYWMpRhLgI=;
        b=pw4nXD3I0Pder0GjCmJHA9z2lXK/p8BC3S3oZ0Rr1ri5Op2DzpU8DPR1TI7R4rCk23
         PnfQB1I3PDClxvO24nMxwVQb+LXHxflsxyHVjEMF3C1uSzRYLpYiixJlzSX0dLpRxIGj
         e+mhGteJz0CT0S/PEcEzR1b/0aIkKOcGlxf/t07bxfxIqNwGQO+2GPvs9XuBbYfQ30RJ
         heOSw7G04+PPruvNjG6yAzKlZ9xfwYxU6xx83/a2QqneQ0zkdFvnX9l5yccjpOADYwa7
         4ZKuMpS9ky0eRPs6IW9Z0rXqll8A6L5os/hMAdWwcrgp5sr9oPL66XInTYzHAOiIaXl2
         wh8g==
X-Forwarded-Encrypted: i=1; AJvYcCXrLHzox5qZWq+3zMJNLTN4IXHX55F4ajKMoMc8VQJTLDBhxzUHMtBfkeuojqUwyd1dc4N5qfc51E6kwt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmKRh03fpgemwg/JGA/TfqrhP0ec2SCvJ2UrUx8jxSEt9XO3Y
	OcA22vbXb3Ox8Qexqux9NaUs184jE9Kgic3W+qc4QGFapAqPtNPFk0JH2S0kAgKdX0C4TK5D2H5
	zZI97LVHDFJPyPaqyvRhzxFDex4i/jIkCTTf+36MlxTb1t6WFp5Qcg1Zq1807O/VqmZM=
X-Gm-Gg: ASbGncsYxuFqAt8YXs2bff8c3Hr2OrPDL7I4R08rcnwqIciQ7zZ/RyUF4MvdeprlCJO
	Bx86C1HGt748YvBh9Nv4M0bvf5/VQlch/1KUbgNs26bLHvOP5aH4TWXtxgK5Io5yllHd1+MupYc
	H35yi0BUKoNHBhF7WGzwWbZTULKY6J45IYVIV8hakWPvriy0MaIFIUW+LUSpYesle8C6fjPahFG
	iUp3lJIcz+a00XaRlR7hkhu4qjn5u8bUAm3FiL8rwHgqo49Cp7G/KlbzoukoEqaTBaEqqww9R+m
	jORLMniBPMlqJrro6NhY7jf2WmlovVaQT5+upGUZUmtvpFYuSb2gyFDc+PWwcQb8x2IJz0fJJbj
	hr8kUEY2cisKIsCGkyatHfvnHAufHtQ==
X-Received: by 2002:a05:6a20:258b:b0:252:fbd4:630c with SMTP id adf61e73a8af0-2602d00eca0mr15922309637.52.1757936757957;
        Mon, 15 Sep 2025 04:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1+MjVkOmvS+r+M9ltPuOloFpakiq2fFlYI2EREj0x5+CbeV4GyC8RJBbCrDtnWLdep/CZ7w==
X-Received: by 2002:a05:6a20:258b:b0:252:fbd4:630c with SMTP id adf61e73a8af0-2602d00eca0mr15922270637.52.1757936757469;
        Mon, 15 Sep 2025 04:45:57 -0700 (PDT)
Received: from [10.133.33.70] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761853866bsm9648737b3a.95.2025.09.15.04.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:45:57 -0700 (PDT)
Message-ID: <796b89f2-281d-4602-8351-4ab00b131c39@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 19:45:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: core: Fix data race in CPU latency PM QoS
 request handling
To: Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com
Cc: peter.wang@mediatek.com, tanghuan@vivo.com, liu.song13@zte.com.cn,
        quic_nguyenb@quicinc.com, viro@zeniv.linux.org.uk, huobean@gmail.com,
        adrian.hunter@intel.com, can.guo@oss.qualcomm.com, ebiggers@kernel.org,
        neil.armstrong@linaro.org, angelogioacchino.delregno@collabora.com,
        quic_narepall@quicinc.com, quic_mnaresh@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com, ziqi.chen@oss.qualcomm.com,
        zhongqiu.han@oss.qualcomm.com
References: <20250902074829.657343-1-zhongqiu.han@oss.qualcomm.com>
 <4b970683-bc36-4dc2-a404-e1440da83ae7@acm.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <4b970683-bc36-4dc2-a404-e1440da83ae7@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qqSdE_If1Duot2Qa8VWE_hTrI_YrNXSj
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=68c7fc77 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=9Xt4y-262ZfalKxfTLgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: qqSdE_If1Duot2Qa8VWE_hTrI_YrNXSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX76H3qQxyq/Mx
 jFlS2ZEMJBpWBx7yvFO+12JRFUN8cPsI5A8QSfyLRXNqh3szy6btUNPdnfh0yckJLGus5SADKif
 xtGjDzBss0/R4jq12lf3g27GJNRBLtCxL/heOoFEPWdjkD9ZxiEZlym4p55+ETU8t4tsiVdzNis
 2YU82dIaELDLNK9y9kJfCzrV4pqrS0QFrfvZoXdXshe9iltqCicx9w0b5XXYo33QtLMXmzEjuml
 bUEnCNjhzDitQSOPjvcxtDZZoxurzKtIlHx9ir48n45TYCg6w0GwWZYKSegzg4fz6ccY52UaAXo
 rir41DF+Bk1sfMMsqdkUWkm8pRgcUgpeohFQB8H4CSRh6SHD5rApwSbnRblT4vKpbPYfwGmFhBb
 Pnhiwhh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130029

On 9/13/2025 12:22 AM, Bart Van Assche wrote:
> On 9/2/25 12:48 AM, Zhongqiu Han wrote:
>> -    return sysfs_emit(buf, "%d\n", hba->pm_qos_enabled);
>> +    return sysfs_emit(buf, "%d\n", READ_ONCE(hba->pm_qos_enabled));
> 
> Using READ_ONCE() here is inconsistent since none of the modifications
> of hba->pm_qos_enabled use WRITE_ONCE(). Protecting hba->pm_qos_enabled
> modifications with a mutex is not sufficient since the above read of
> hba->pm_qos_enabled is not protected by the same mutex.
> 
> Has it been considered to leave out the READ_ONCE() from the above code
> and instead to add the following above the sysfs_emit() call?
> 
> guard(mutex)(&hba->pm_qos_mutex);
> 

Hi Bart,
Thanks for your review~

Yes, in this case pm_qos_enabled is a status bit indicating whether PM
QoS is enabled, rather than a constantly changing statistical value
(such as IRQ count) that users can tolerate. Users may rely on it to
determine whether PM QoS is enabled, and thereby assess whether current
performance meets expectations or decide to enable/disable PM QoS.
Protection is indeed necessary here.

I will use guard(mutex)(&hba->pm_qos_mutex);
in the V3 to make the modification.

>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 926650412eaa..98b9ce583386 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -1047,14 +1047,19 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
>>    */
>>   void ufshcd_pm_qos_init(struct ufs_hba *hba)
>>   {
>> +    mutex_lock(&hba->pm_qos_mutex);
>> -    if (hba->pm_qos_enabled)
>> +    if (hba->pm_qos_enabled) {
>> +        mutex_unlock(&hba->pm_qos_mutex);
>>           return;
>> +    }
>>       cpu_latency_qos_add_request(&hba->pm_qos_req, 
>> PM_QOS_DEFAULT_VALUE);
>>       if (cpu_latency_qos_request_active(&hba->pm_qos_req))
>>           hba->pm_qos_enabled = true;
>> +
>> +    mutex_unlock(&hba->pm_qos_mutex);
>>   }
> 
> Please make the above code easier to review by using
> guard(mutex)(&hba->pm_qos_mutex) instead of explicit mutex_lock() and
> mutex_unlock() calls.

Sure, I’ll make the change.

> 
>> @@ -1063,11 +1068,16 @@ void ufshcd_pm_qos_init(struct ufs_hba *hba)
>>    */
>>   void ufshcd_pm_qos_exit(struct ufs_hba *hba)
>>   {
>> -    if (!hba->pm_qos_enabled)
>> +    mutex_lock(&hba->pm_qos_mutex);
>> +
>> +    if (!hba->pm_qos_enabled) {
>> +        mutex_unlock(&hba->pm_qos_mutex);
>>           return;
>> +    }
>>       cpu_latency_qos_remove_request(&hba->pm_qos_req);
>>       hba->pm_qos_enabled = false;
>> +    mutex_unlock(&hba->pm_qos_mutex);
>>   }
> 
> Same comment here: please make the above code easier to review by using
> guard(mutex)(&hba->pm_qos_mutex) instead of explicit mutex_lock() and
> mutex_unlock() calls.

Acked, I’ll make the change.


> 
>> @@ -1077,10 +1087,15 @@ void ufshcd_pm_qos_exit(struct ufs_hba *hba)
>>    */
>>   static void ufshcd_pm_qos_update(struct ufs_hba *hba, bool on)
>>   {
>> -    if (!hba->pm_qos_enabled)
>> +    mutex_lock(&hba->pm_qos_mutex);
>> +
>> +    if (!hba->pm_qos_enabled) {
>> +        mutex_unlock(&hba->pm_qos_mutex);
>>           return;
>> +    }
>>       cpu_latency_qos_update_request(&hba->pm_qos_req, on ? 0 : 
>> PM_QOS_DEFAULT_VALUE);
>> +    mutex_unlock(&hba->pm_qos_mutex);
>>   }
> 
> Also in the above code, please use the guard()() macro instead of
> explicit mutex_lock() and mutex_unlock() calls.

Acked, will make the change as well.

> 
> Thanks,
> 
> Bart.


-- 
Thx and BRs,
Zhongqiu Han

