Return-Path: <linux-kernel+bounces-740977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15EB0DDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D601C870CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C8321D3CD;
	Tue, 22 Jul 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBDPbZuF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9991D6193
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193284; cv=none; b=POr2d1iv37e6ttS8OeVq3Bq6xOWexTziaSE7hRN4PD8S+Gv+Cofa4FBeqjECRqQA9aVQg43aFsvtloXMFK8YyxXMkfs06yNN+gRW1Mu6jcV5LrW16/AU7XAzql4ZgrlTPGYre3CdQEdqegZwnfL6qXaNed06KbFmqYXUWPBHYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193284; c=relaxed/simple;
	bh=DKfSz6nGkxGk8gGspa7V4haXrM0KCGosPlQ8AncF8OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0t66us9j5ZnRJc8PegkQPIi1dReczHcdBAfL9R7rNXy5lISmnabrkNjxaFP8RGPCmUhd9h+qdzwUSrTYdEe4Wdd0g9EyuASiYpTiV+jcH3Xbp3pFLanfi+7//7V2nZcvpaWgKIvejBodQAPRtLTnriMzIRDm9wklvI6iJ8fAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBDPbZuF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9wmde016283
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YhcCPoO4dmlZ+ZNBZT39IVOE2JZWvvPg9v8aKMa+61k=; b=pBDPbZuFxK20e/R3
	SloFtloflHthyk/4e3KVSnDhR4+EWpYsHSujNsQq8SSyXq+U39kncRSkuKa8+10x
	IKZNOMMk4nqv2grdmU2x86sJ2eIHSnUMifKywlsVVFQjbQS+22wUzDja0wBMAKzp
	tKsHX5ueN5roBNl5p61DjbUrYrM7F8CMPbCnZJUihGhf+x51lCq1ouReviXmJKgR
	SrCssQUEgYGbO0tMGUaqwGXhFhm60p8XJAMQQTsdrpzC9OE0dmjxE+a1Jnbvc4Ob
	g8KiqJtEHT1s0B+5Za6QTkdfXa19LrFHh6VIxyuR+g6ARtSd/MhV+mLknlHqXNH2
	6kBn3g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s1r5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:07:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so5647571a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193279; x=1753798079;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhcCPoO4dmlZ+ZNBZT39IVOE2JZWvvPg9v8aKMa+61k=;
        b=m9CkIs2t6khcHEidHnCT7l3jFh0WimCvqHXsD0cE/OQ8Tw8+IvncO6sI90UlVR4YBW
         DkKNh+KHScdFj360TUBbQwmTUbSPWLFFP7wqP47SllYHpJV4/rzbYsjHRaBXH5TfupOT
         zczXy4prf1PjTghwbEvuOi/pW6DpnXmNJbtEWIdslyH/Zy/9FB6bZRNT86mny6rC+Llf
         85KMubrtHfSQmT8eZCFyuUOspSPXliuiV/zS157JIvmZPV9V8iEPtmpxNsZJDfE1+tsi
         KSQu6sP4tzkf8gxkqQHB8vc8gqn9r0TAfReO7jipHpkSTbcDCbuXktw6rr0t2ulnw9vY
         jhWw==
X-Forwarded-Encrypted: i=1; AJvYcCW/J/A5YYHu96bsRD907wkOHMpds26xreeF8tte7bJADunzvdLO5yFMdrPO3e29Uf8u59jCknjv9oLI4hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGWDIjp9Y2gLb8giv5CK3G8aJKWtF62Su0KU1Yt+W5QQJPoCX
	b/YG+AiNhChKLoGQ8AzqZzQsVYt4snzS1+m8GzrtXo6VG561hi+tTh0ZxI+Mk7Sqg/bQMO47l1n
	QlQfJ8UwzFoj1prQG1eA7AGkFW+yBNOv+oxe3G+V/NpXnbFIKJBpTnHtRBYtBMBmD0iU=
X-Gm-Gg: ASbGnctIh/WgXBC0F77FhbXcNq1LnlUWKiPMLCShJ5MmYXWP7rWEdlmVK3wgJLLNP/Z
	5WXfithokr7hofPKHWh7K+Zm0CLbPZc5hj4vy/Llmuy8kuZvYjSn1VY6INMHvxXnuQ9YVwJjqLL
	Mo6nztXNDB1NBRcF8GcCyoGali6XsEB+Xx6xbxwsPawH1rJsuIabGmG4DMTlkWul551yU9B/cHD
	8YbcLylt6hiGOOFklt5gOsNUHXuwPb54BQg48jCO2xlPOfmCpWIBHBU6gc4mh5ODbDz2tjEyFD1
	8ZePUGhtkxoeFWg0ZAWvpFBmNudKVhBjtdO2EVT7o/NMSksvaycFE7KxAwoYM2Fvr5qo1b3HPZw
	5YlzhrjF+Wg5DAOVu7BD8SAnNOiYX8gcu
X-Received: by 2002:a17:902:ecd0:b0:235:2799:640 with SMTP id d9443c01a7336-23e2572fffamr302404655ad.25.1753193278451;
        Tue, 22 Jul 2025 07:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ6PTrMuYd/lsu07Wt16SKi2Zds45iU2lJz4tGyH81i1eCRKNI5dS/lyAorKJy4cfJ7lPrrA==
X-Received: by 2002:a17:902:ecd0:b0:235:2799:640 with SMTP id d9443c01a7336-23e2572fffamr302404405ad.25.1753193277972;
        Tue, 22 Jul 2025 07:07:57 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b48a2sm77221245ad.108.2025.07.22.07.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:07:57 -0700 (PDT)
Message-ID: <ab5af5b9-d5a7-434c-938d-3f9aac388542@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 07:07:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Kalle Valo <kvalo@kernel.org>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Miles Hu <milehu@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>, kbuild test robot <lkp@intel.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Sven Eckelmann <sven@narfation.org>
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
 <1598d25d-e254-410e-ac5c-66d5450fd686@oss.qualcomm.com>
 <ae7a08cb-af73-4a27-aad4-c852be5f77aa@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ae7a08cb-af73-4a27-aad4-c852be5f77aa@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExNyBTYWx0ZWRfX97tGgKNnGveQ
 ev0qKiObHGfd0xuDFbBP5T4SCWht2gdAv9TldsvTvEH2oVEsy/o8PfsScTxEPh3gPK06fUeMbhW
 d2R/bkIFzgVLobFc52LiBvS32owaQnt22WDptxTc4PmROPS4NNEJF25cOkrv65KTYbKwAJaxfxk
 88QN8HNk8Wxxr+jgV0+S7cbZXqE4FBfgtUbyoBLzLw3WhHXeeC3O823PRv5gzbINiHEdSeCg8tU
 4rhf7PlvLlZPxPDuGEabPdd2pLdmuU/MawPwEwXq5KXXM+7bGfTYqaLZwCec7YNBk962C6ZEBQf
 wGUJ0kL58DH33lyZj914aCflEIEU70m0GWw6TcUZ3F93v+HAsZVZc415GHr+pZelPxPynffESnQ
 QUrmP78PZ7HPWkru7J58u/NZLWAeka5P3qzfp7awd/HGmqS+tp5bSYOROfKBiMHk7VkEsv0u
X-Proofpoint-ORIG-GUID: o6d0newODp195icYRTZQ24Oj87cGFlnY
X-Proofpoint-GUID: o6d0newODp195icYRTZQ24Oj87cGFlnY
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687f9b3f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=kCYrOAKyVCnItiLis7sA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220117

On 7/22/2025 4:23 AM, Muhammad Usama Anjum wrote:
> Hi Kalle,

Kalle is no longer a maintainer -- I am currently the only ath11k maintainer.

> 
> On 7/22/25 2:47 PM, Baochen Qiang wrote:
>>
>>
>> On 7/22/2025 1:31 PM, Muhammad Usama Anjum wrote:
>>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>>> deallocated and there is high possibility that we'll not be able to get
>>> the same memory allocated from dma when there is high memory pressure.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>
>>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>>> Cc: stable@vger.kernel.org
>>> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - Cc stable and fix tested on tag
>>> - Clear essential fields as they may have stale data
>>>
>>> Changes since v2:
>>> - Add comment and reviewed by tag
>>> ---
>>>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>>>  drivers/net/wireless/ath/ath11k/hal.c  | 16 ++++++++++++++++
>>>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>>>  3 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>> index 4488e4cdc5e9e..34b27711ed00f 100644
>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>> @@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>  	mutex_unlock(&ab->core_lock);
>>>  
>>>  	ath11k_dp_free(ab);
>>> -	ath11k_hal_srng_deinit(ab);
>>> +	ath11k_hal_srng_clear(ab);
>>>  
>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>  
>>> -	ret = ath11k_hal_srng_init(ab);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>>  
>>>  	ret = ath11k_core_qmi_firmware_ready(ab);
>>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
>>> index b32de563d453a..e8ebf963f195c 100644
>>> --- a/drivers/net/wireless/ath/ath11k/hal.c
>>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
>>> @@ -1359,6 +1359,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>>>  }
>>>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>>>  
>>> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
>>> +{
>>> +	/* No need to memset rdp and wrp memory since each individual
>>> +	 * segment would get cleared ath11k_hal_srng_src_hw_init() and
>>
>> nit: s/cleared /cleared in/
> Please can you make this change while applying the patch?

I can make this change when I pull the patch into the pending branch.
I'd like to see a public Reviewed-by before doing so.

Also note that, except for anything critical, I'm not taking any patches into
ath-next until the upcoming v6.17 merge window closes and all changes made to
Linus' tree have been backmerged via net-next => wireless-next => ath-next.

/jeff

