Return-Path: <linux-kernel+bounces-882396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA913C2A5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5F83A794D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B62BE7BE;
	Mon,  3 Nov 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HOQZKHdk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LK4z+5gO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601729AB1D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155455; cv=none; b=kewP190sDnFni3VqvdIeEIUxCP3AFnP46dErIf+x8YjGciXdNJzZ+b6Qq+3mpk4K+q5vwJ6GbAJGLgm2qVBN4pcOCBE1xeGe97qMdl3Cee5RxEXTo5laO5+v1DDIPMxid3ADUSkNVb30vrP6O6lqYxpMkWWJsuxlolW/Z8HJflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155455; c=relaxed/simple;
	bh=MfZR+LskpRTC4y8CB9iwSU/ZE+amtfzDSPNjwSCYW+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeC/YWI5/7IS6z3GaZzxj/eyC9Z9S+sSnvCTR3t/A7dVkllWZpqz/lkU1QJYyz5GgqaOOTWJ7ZpmnaDO4cja6VifCs8xOISuG99t+1legfUnPdVuhoTYa/4n70wwbKwwcG+mDLfYnTY3trgusC41RvdQ9zZj1aYziWnRLv6X/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HOQZKHdk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LK4z+5gO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2LrXPM1194251
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 07:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3JXCgZLgZt59euN+7SYtL4D7oNSh6Gr61wJkEKqtQ8=; b=HOQZKHdkBaAoj4gT
	aHCPWykKvtRYa6t+42YS0My/FrLRB98mZe+PeakIbvw0LL8iqHuD0SoWAd+R+TzK
	Ppju3v2zGVsZD2oeK5lUIJwRJGQaAlKNfReWruKsCYkhyov6EUisWRUanAUOnuIp
	8W5n9VQEtrVWd29+6Cgi/4wmgYzExE3OcAylVMRaeV5AAfbD9GoXSq3RTKtxwrZC
	HuzknQ5IFBeCTtpE4tDjs99AxKeD6EdoJsgT7QWRmLTwN3r685gBylkl4s4HoMYX
	4Ko/Ph09lmXFye1xp2HzDQ69lLRpbQQPKy5g3CaM8Uoa+ZR0bJ6oh0TfxbyrnLGz
	5Njtcw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6f0w911q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:37:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295595cd102so32151235ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762155453; x=1762760253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L3JXCgZLgZt59euN+7SYtL4D7oNSh6Gr61wJkEKqtQ8=;
        b=LK4z+5gObgQtlvmS5gx1TYDXzQyP4xZ+y8wOkIjZey+ai6JItRjhsevEI4P08ok12A
         TZSKLfbdN9LgI+pVYHnw4p8davjfx9REh9TTptHg4YQo2wIhOOUkmPoH9Odnu6doFgX0
         Wm/Ek3GPIDTytFhoJRxDz5wcmpJrGw5GrsMc35zl0NtePaSnZrd0dzjcY8k1cEy4Gx7d
         Li4ls5ynCGD8lZ5vqwyis/NCjQ1lRYPVj+uZOOlibh+TtyIf43grSP0WASw/BMIfKTA0
         QiEYhrPeQ5Kgs6i+b1Witdz3x/e50fUgYXsMVCmeyz0+Nkl66KOxW3zYHHoBPaTZ6dky
         fG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155453; x=1762760253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3JXCgZLgZt59euN+7SYtL4D7oNSh6Gr61wJkEKqtQ8=;
        b=j8eVB6OQgr7pIQDlqhVt/NK1Pkds9Z8ZEhnAqxZP/71mKQOODKiFzbFdPEQYAmaTEv
         WODvwQ69epReDqjwSfgCBC+FaKMDNM6HNfDZ0ecXIbrVd1DHl//4VMZt0y+ogHNppxjx
         VWS+5gIoMHfJcVtRvLQzPwhLkXOXmaqs7VgJ9fb8HYbQuSLZuhvhAVoTaF67rIyyW3HS
         CEhb2U4U6itmGiUW0vx0WWTo5kYQmeoXxn69PUB6eydx4GmmkJFysESZr38vmnaeL8s7
         Tz1tML7rMNzyzx8LuaBVKpsWjayP4GtC9lGRaoN0P0h/zodq/agOt/IN/2Jg7RqZmUFA
         iNow==
X-Gm-Message-State: AOJu0YzMfQk6VlajUjvbotbdZUWKmSNGcyFsKOkB8JQbQQSWzdK5KI7x
	qFU6liUugZcEN5/inylydI6NtG1d2W00/XI3CaUG6/IG2gUHh3esR/njcMwDY4/uw2p8UiwWvOu
	YfyxAdQShvY6al6rbBQD/8PvjCskiPouWCyVb1DxJmxDrVlAbVfB5KKgbXcqyT8Ycg9U=
X-Gm-Gg: ASbGncscnfDmhSc3roRrOMuJzjDzLePJl6//bO90vmjI6758Ie3JR9V+SxAE75tI/k0
	ffe3XMVYVn/3PFRWxwwc1rkAaRJbJrZKT+o3M+i60xSEwTETXXSaC6hCpJnMj540R0+bMmZMd8C
	WEuaZQwyLneAUyLHs28S626Dt6X+A8THWEmY6SL8rNaUeVIRXsRH7/8g4LuAJ8Y2Rd1niQFIU5b
	v3uw9glJFUltd16Xt61eRHgIouRJUGoIjrhJ07xWruoVzWnj+1hgSYCLPeC0XrXYtF7dxIbSP7N
	SfkHDjArBJQyfocbiTjiStk1j5jf2ZJ+YxvmzqhBaAZosqMiTVt6iOqzceLH6YunpCgp1wdAr9K
	DGrPDBXU5zt5NnU50SF34ork=
X-Received: by 2002:a17:903:2302:b0:295:557e:746f with SMTP id d9443c01a7336-295557e7a25mr96007435ad.32.1762155452799;
        Sun, 02 Nov 2025 23:37:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGoYjUzwXxifSe05+L8+ZuGbe6Sp1Ukl+bahFZYvc6hkeGLR5aBvmkwawKJdsuKjuz39BQ2A==
X-Received: by 2002:a17:903:2302:b0:295:557e:746f with SMTP id d9443c01a7336-295557e7a25mr96007145ad.32.1762155452329;
        Sun, 02 Nov 2025 23:37:32 -0800 (PST)
Received: from [10.231.195.211] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ea51sm108400405ad.57.2025.11.02.23.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 23:37:31 -0800 (PST)
Message-ID: <dbb7c7ae-1c8e-4b7e-bbb5-a7866d173468@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 15:37:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
 <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
 <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
 <5d0e6d7b-d127-46be-8985-9be33a490aa0@oss.qualcomm.com>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <5d0e6d7b-d127-46be-8985-9be33a490aa0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3MCBTYWx0ZWRfX7vlLhvgZXnQ1
 wNKS081rEDuMx4cEQFhHsf0BkAKeHW1WdjK4bQv8VBNVFM8IDZEQds+FR7A+AsapQaDad+fo6cz
 e7d1vk0sv151PBl2Ppt0WBDzbAYnA5yQnKrblQdNIl4/mEy7ho3anUlD85F6iwvDgmyvQHJqcVm
 iIK/3+vAQ8LQyEFgHvHgfTxniHYtbp/8SjXv43clTsFbs9A+mEymT4DQAO3fzCzYnddusT87fcv
 sWkfs0flhjEUE1ISSdR8rg0i6ct1POUowTPdX4ol/afjIQIHy9KHuAdx96IjXcmdXSO1idDR9MF
 bLFY7G4sAEncqq191/iaY7LHHPJ99uWCaXXbo1ma+u/woKSqavgv3P6hE8rBVeSUdSHBiVq2hjY
 XHH0neUygUYIlcbqYEUxSiiAxs+8qw==
X-Authority-Analysis: v=2.4 cv=LcAxKzfi c=1 sm=1 tr=0 ts=69085bbd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iy63uO9faCoK6JyWAJUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: oTudN5gPBMLVug-5GvOnPdiWQRJ6RvWH
X-Proofpoint-GUID: oTudN5gPBMLVug-5GvOnPdiWQRJ6RvWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030070



On 11/3/2025 11:14 AM, Baochen Qiang wrote:
> 
> 
> On 11/2/2025 5:21 PM, Yu Zhang(Yuriy) wrote:
>>
>>
>> On 10/31/2025 10:43 AM, Baochen Qiang wrote:
>>>
>>>
>>> On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:
>>>
>>>> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>>>>                ar = ab->pdevs[i].ar;
>>>>                cfr = &ar->cfr;
>>>>    +            ath11k_cfr_debug_unregister(ar);
>>>>                ath11k_cfr_ring_free(ar);
>>>>                  spin_lock_bh(&cfr->lut_lock);
>>>> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>>>>            }
>>>>              cfr->lut_num = num_lut_entries;
>>>> +
>>>> +        ath11k_cfr_debug_register(ar);
>>>>        }
>>>>          return 0;
>>>
>>> miss _debug_unregister() in the error handling?
>>>
>>>
>> The documention for debugfs_create_file() tells us:
>>   * NOTE: it's expected that most callers should _ignore_ the errors returned
>>   * by this function. Other debugfs functions handle the fact that the "dentry"
>>   * passed to them could be an error and they don't crash in that case.
>>   * Drivers should generally work fine even if debugfs fails to init anyway.
>>
>> So IMO any failure to create the file should be ignored.
> 
> Maybe I was not clear ...
> 
> I was not meaning the error check on ath11k_cfr_debug_register() or debugfs_create_file(),
> but was meaning that in the err handling below it, _debug_unregistered needs to be added:
> 

Got it，Thanks, will update.

> 		cfr->lut_num = num_lut_entries;
> +
> +               ath11k_cfr_debug_register(ar);
> 	}
> 
> 	return 0;
> 
> err:
> 	for (i = i - 1; i >= 0; i--) {
> 		ar = ab->pdevs[i].ar;
> 		cfr = &ar->cfr;
> 
> +		ath11k_cfr_debug_unregister()
> 		ath11k_cfr_ring_free(ar);
> 
> 		spin_lock_bh(&cfr->lut_lock);
> 		kfree(cfr->lut);
> 		cfr->lut = NULL;
> 		spin_unlock_bh(&cfr->lut_lock);
> 	}
> 	return ret;
> }
> 
>>
>>


