Return-Path: <linux-kernel+bounces-847603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB8BCB426
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D72E19E74D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33EE79F2;
	Fri, 10 Oct 2025 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AtbhKJwb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F265625
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054934; cv=none; b=LCguxGUQ+S2iVXhxfOs8oOvt+8KryJWsRDwB4TV04YR5B7qMgtWEmQc11yS56Bg6CebpUdZEJhb8CUPZ2Yk44B3chNuHyb8CkSuCACqtq2D4sHsh8ipFzIfBA3uuFLzU6QesGDuLKvoKQdHOb8Utg4NSA3Hnu8HjV2NddUwL43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054934; c=relaxed/simple;
	bh=nD1RfYY9flTnzptCLMHOkQHLxd5HOlght6AiPmzHtek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byTPyvl8y9Lzzjl36MAsy9+0Wzwup54sv+/TsSwJuorGl05DAz5gT2fyVxCl5P0tj4oMbpIiXjGlTOmJ5BweRN+i6kcFzPwisQ7xMRuZDcfk6TW/lMY3m9jPE32oksJQmABW/5LJjK4+r/q2nOrxfvEV5l+q3GkaNrOBk2FnQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AtbhKJwb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EVHYW028649
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FXC2znu/O4gz2QBAE7hjHdMIeA++ApqEJcSghjvlbQI=; b=AtbhKJwbWpC4ynDU
	h1TaBiUaPaUT8h8PYeMIOq390tW7t3PXkF4aTu4MXQaMfPewbQ2GRQa1fbrNrY0Z
	4c230jLFsV/XL06myd5JCvASTVEPmyJf8bWjsUhvzed7FOeXqb/EtOnqTnGnLrso
	yx2mhJcXpq6hglK2HpBY2XseNPoUR0rKPdOKePwYgp8e7bk+xQyy+sbuDdDgmgWj
	uZlhzIKUZuAikd9trrLTcEP+Wu2We5JKyAkGTt6Vtz78QwLkaQJ8ETQZ+R8DS3nI
	u7LUXod2Y4KgJHp2vYVEIXQF+Xn/hllGQGxrmvpPFH48P0XlTtfuyHNZ9Bk7CgWN
	Di27mA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kvkqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:08:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso4193249a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 17:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760054931; x=1760659731;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXC2znu/O4gz2QBAE7hjHdMIeA++ApqEJcSghjvlbQI=;
        b=vkDPkHOb8CPodPPo89t3VMKMjczpnHcmztk0NvH/KQIpQsgoXpt7q/tjJswGVprXKU
         NmUCeWgJk7iUaTqhhUwBasKlCzgQHqoj0TFNKEvJkJqFE0Zcd6G6bLYJU/ChxRUDZGPk
         r6ckv2DlVSXCw+Mx9E76Vu3UwFsLAUjsvu4EngkJ7SNXlKU6myd7nyx7gxp2Jsr0HEdd
         juUmuwULxOCdQ9XrJeNCxp54GAEswQp52JciiS30H+r33uFOEWiTVS6jK3fKkNXi4Qrr
         m2hKyu41xKajLGEuF3pXId0GKPpq6ucxAhT+ug2mwhiHLXuTU8YAwWUYEsSCjytoGps6
         KzCg==
X-Forwarded-Encrypted: i=1; AJvYcCXymQ+1WjeGhFTBJJRfeJsZuXrPJsv2IG+ZODyLQ9aQ6o3E1tb90pWaalRadliRBeiLkN7J6t+ovl5w6IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWlrzThvYSrA7M/ZOVZySu/eTk+gX74/DYhU4UDVzh+gfYcN4
	KTwgkaXnbugyM9f2xaDAevJkwIx6OG+NSjHqWM5IheOS+aKm0Th2rMQ0XHF0fIbU2cSn5wj1RP5
	4DH5lhtNqozmhxKbC5UVPHdO5rFxj5qYyCv4vQqQtPeZU7vBScE+acC0aZqmB+D9/bmo=
X-Gm-Gg: ASbGncuB3V8/P5CxbRnjejlxwOinTCrH9g8ZOPfk2Vvcq2iR1fP6VcuslhCFFFT76Vx
	FuSGMAe7NBn6s3EFiDjxd1hldp5po3AJkMk0eunJ2F4GaaQJm47jWzeqAnrgP1DzWVsOde+/GG3
	Lzb6dqUR3L5/tfWXmW2TAK+upA47HrM6hKpH8Ek9aDbBNKWq+z9k6irD+Z9KT14b9JErYD4vAHn
	5n/7qwVvy/F+86gjBbkKpKq0HQeDDqyLBFUaUCo+o2A3hBY+pJuMOrbDnWB3JVAWNsXP7G/ORdf
	tSTxWB58ErUjgbC9KPvZgYJCRugX6uZxhcnjlPUhELESxx8+gXPxEBH2YKCQGrZyG/7cxywUSZS
	fTsVYVWGfbFPA8o7+/Wqcf4gp8vT5V/7iRpjGQoT6Fw==
X-Received: by 2002:a05:6a20:3d1c:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-32da84eded3mr12406408637.56.1760054931403;
        Thu, 09 Oct 2025 17:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTGfNB9JrV4xxoA+tFe4KLMIcWr5BeqqOj5gLPEZKV5hJ1wcPR6KhCbesm2TDyQyXVLfOdUw==
X-Received: by 2002:a05:6a20:3d1c:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-32da84eded3mr12406366637.56.1760054930721;
        Thu, 09 Oct 2025 17:08:50 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6793b03d04sm316783a12.5.2025.10.09.17.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 17:08:50 -0700 (PDT)
Message-ID: <83b4ff7d-2443-4ba9-8103-77c8dde518f2@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 17:08:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wcn36xx: Remove unused
 wcn36xx_smd_update_scan_params
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: wcn36xx@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
References: <20250619010506.296494-1-linux@treblig.org>
 <CAFEp6-3U2rQEUtntb0cdJeykURocEZQdeVHXFbXXogZV=wxGWg@mail.gmail.com>
 <aOfT806hw7l2BeJu@gallifrey>
 <CAFEp6-3tq4FkiBLO20mk2HU1QkbyVMbyutu11v7b8PSyps2Qjw@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEp6-3tq4FkiBLO20mk2HU1QkbyVMbyutu11v7b8PSyps2Qjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4JZkZJI+kz42
 FK/LtTyn79MMQzC9F14Urvvft7VBZZrbnnJaGORS42gmnLQSwk3oeYE359iHreSEQSJDdinhzh6
 u+0mJmnY5neyScy4VUWzuVFt6sAwyQG2NI2VUieJMx5s95ae3XthfeCRDweqmc7EQauCxxP0v9l
 Dj1VSGPFU9z4Sjt9vySnENNll2yyabeeS8p2Kp29Rui3AwQ1sPdRn8aKDXRu69WTShK4LXRSo2m
 ok4fphO3rlM7eswvYhJFP6N2sqB7hEL4a4XZ9auIFR1j95f46cIqbqe8lGUEVWyJJhIPU8aOBey
 gGnZSmivM/qiK6edV/TdZ6qn01Y+F6rwqaVexE1dwihnsZYk3t+MYR2dr2rYSQdM4jZTSiPDEPZ
 C6pCmnzAFEaJ8gbzZUchMhUnierDkw==
X-Proofpoint-GUID: 3BffxbgHNAKqDNf6_EtwckcRmO5zW0gx
X-Proofpoint-ORIG-GUID: 3BffxbgHNAKqDNf6_EtwckcRmO5zW0gx
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e84e94 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8
 a=OKNGu4KP03xi2qYGA9kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=1cNuO-ABBywtgFSQhe9S:22 a=_Cyqi_Il7Mi3aeVNCMp4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_08,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/2025 3:15 PM, Loic Poulain wrote:
> Hi Jeff,
> 
> On Thu, Oct 9, 2025 at 5:25 PM Dr. David Alan Gilbert <linux@treblig.org> wrote:
>>
>> * Loic Poulain (loic.poulain@oss.qualcomm.com) wrote:
>>> On Thu, Jun 19, 2025 at 3:05 AM <linux@treblig.org> wrote:
>>>>
>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>
>>>> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
>>>> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
>>>>
>>>> Remove it.
>>>>
>>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>>
>>> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>
>> Hi Loic,
>>   Is this getting into a pull somewhere?
> 
> Can it be picked for ath10-next?

This was not on my radar since it wasn't sent to linux-wireless and hence
isn't tracked in patchwork. I just looked at it and it seems the following are
now also unused and could be removed:
struct wcn36xx_hal_update_scan_params_resp
struct wcn36xx_hal_update_scan_params_req_ex

Let me know if you want me to take this as-is or wait for a v2. If you send a
v2 please also include linux-wireless so that it is tracked by patchwork.

/jeff

