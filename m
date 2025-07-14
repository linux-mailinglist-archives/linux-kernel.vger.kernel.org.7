Return-Path: <linux-kernel+bounces-730733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8BEB048D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB5B17D6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9923A58B;
	Mon, 14 Jul 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QCqaR3go"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD362C86D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526055; cv=none; b=IzPSDvabUoOKbUAGEpCDV7MHYXUItOF8a7ZYV1kIhjX5nHDMz9Atz0MHje1NUnPFFbfOb4yPINKAf6pJM+VKBac/uIMqb7glOkDvu4Zp8V17LBBg/CjdqQbGzyuyZ/tbhbdA5nqol0wHo7fhf3dKOyuKuJKPblaLPAsYSOJyeVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526055; c=relaxed/simple;
	bh=BGb2iBka8bIFERmezVZ2AmArgnDd6RKKxILjH1YWDSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uolOrWH6jSA7ysbcgxfRpkMy3OrJuqJSxRa8pG2MJTgtJccaCoq5XzZHAofA7Ceg+jap7QextE0BvPPxzTpEy0F/KSEwvZjJ8gBRCGc2eop0sYjAK86TNr9SwNJ2qNjsdsGIsTlM/K6OuhsjS0klKWnFEW3mepWTilxZol1L618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QCqaR3go; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EI7gvM004164
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+6szoN01qMvtkgP/ZIMTwafHhBz2p79aT5gKKnIkfmQ=; b=QCqaR3goC9uClZUN
	Sb5eRIzhmsupAAJFCFty6dx6hBZ4YqpIZfsEaFJqM8+0ry1182YC4irqZb6HZ508
	Vnqp+HnzmKE05YHDPb8HoJWs8yvBuEZJnG4II2mL47ZPUvwHutyWFXFZ+DXKWj5Q
	akZm25lAydQUDkMPyiyHPCvqwQIRCjSgGvBSYmkQNQLI56lIi+peZcDmYCslzCBo
	/Rl3jhM5MfQT6yMfHJpFqphCUnAcNy673QE4bMVocznxFnB+WRIH17GVk8w1FwXl
	8NaE45EuYVwrQoBHubjWmlFCA61W5g9gToXYNaKlpSmEDJui55kbkk26kwed2lJn
	xnealQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu85tct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:47:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74b537e8d05so4068612b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752526051; x=1753130851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6szoN01qMvtkgP/ZIMTwafHhBz2p79aT5gKKnIkfmQ=;
        b=ta4/pjC+dZErJLH+bljISUlFAQHzUcGYTKYuB2zRkdg3HG7V4j/mNpg6N9LcThPZzu
         gpkpifWMZ+ZcZGRme6FnIgf3WI9TiAszM+BtvV3Gz5JhHrl8VlWM1hcwLQgTWW8mNn9v
         GUisTghOznpdIGxBdPp+vDLE4IF89PNEqa5A1a15OVuKTkmNJoFIEE87AcoeHLUCVKGR
         zAhyzfjzKH4dDlzKbzqtFDNtCY7jXQ3SGTQwGI5NKrwZbystaTJjwjychwKeUuJ2MNht
         jQDxKWlpiasnWIuLQ0iEWe5nI/Qg1t+hwOUkQ7QTQAO8OW54oRivw4n1qJIaEOeb7OJN
         1PYw==
X-Forwarded-Encrypted: i=1; AJvYcCWri/jasA+TrkMCDxsx5V35625WNQctJowk0aspxSFXOY6Qyr0OKVaPnpTEEIn20N7l1aM2Pwzy5oN6ASM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOi4PnrbKX+2p3IJGCEPgybgQmQZf9e0Ct37Aug82y3x/yyXhm
	fDAHrKdBrZakA6z6V2U4mlyFOGdo/uWzzgqMnMfnLhha+MV6hJiyJNyAL0CruDXuxPW1GqjjIq6
	PRPNbP/XDTSCwZBOfh+e3P9Pwvocvay5f+T2qPZ5IlHAzqNhG+7LJPIvyJbk1GrDHu3M=
X-Gm-Gg: ASbGncsfQ4ktoj9rw50B4K+mh/+RvEl1qRYeELf4J9eDjrjZd0EYxcY6M8n20oe0ntv
	7ivQNYfY533G43ZCjaxPd/FbBbx2WwldT+IHsHUTuqV4sdcrbicnSWEcXUmRrCgfpuTSA4rfhWs
	ZWDMYUk5aaBvbiVx7TZF8pJXZz9CGwPbRcSHpU4wZrKqKBf4TsQSIQ8vlJ0+yB2KVOeZH74tWJt
	Ds5TKk/LyjFwat9sj3SArDv9jUr/Ri8Uy8LNun1NedIZX/2rFWpGkug6lBFlPfoyHy7EYUm8aiD
	7AsVKilSw5Hz8uE8pEt6uonBF6SKqa1nBFunYw2Y5qQDG+rERXwQbyS4VPhNmh4xjdl/1uIxHRr
	olWagPIyYY75RMp9h2LY3kw==
X-Received: by 2002:a05:6a00:1821:b0:748:ef04:99d with SMTP id d2e1a72fcca58-755b41ab6f6mr437039b3a.14.1752526051354;
        Mon, 14 Jul 2025 13:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh+Xikax20uVvqGMWirr1Ngeo4M3PY5vi4JIlcDBOfp3FjPa5Y+BJ4IdduqjZYXlTEboQ1uQ==
X-Received: by 2002:a05:6a00:1821:b0:748:ef04:99d with SMTP id d2e1a72fcca58-755b41ab6f6mr436999b3a.14.1752526050905;
        Mon, 14 Jul 2025 13:47:30 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1a841sm10684116b3a.86.2025.07.14.13.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 13:47:30 -0700 (PDT)
Message-ID: <b6b51282-7ab0-4cbc-a12d-86f35bcd6ffe@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 13:47:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] drm/msm/dp: replace ST_DISPLAY_OFF with power_on in
 msm_dp_hpd_unplug_handle()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
 <20250711-hpd-refactor-v1-4-33cbac823f34@oss.qualcomm.com>
 <rmlgjr3fzb7dmnwmthf5bj67wb6fkcksmn3ouchzsvhhgxiv7h@vwcieejcufr7>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <rmlgjr3fzb7dmnwmthf5bj67wb6fkcksmn3ouchzsvhhgxiv7h@vwcieejcufr7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEzOSBTYWx0ZWRfX/GOc/Mnd38Jz
 NxAzFD+Oe5CVoyRFOvxXEjiQmKReqGGxNf82zOZwJKs1wLwN1NSR53DGUZ2cY5Tetf0cDUYAFwi
 MnGMEraJGhi9RjSi4dLTJOT5Yl2E0hNsKgKcjVpODLS20/oZgR+b56pZfPOCqG9dadxM76tJnuP
 nF1GsBP+ddPAIkV+CT0Av7JjBc1sokvo8QmSZdP96dDjZvYjl8ESFBx5+r63G8h4ze03AdoaQpW
 2fwmg49s3/jb+Iv0VDFnFnkWAvNYIEKuZe4oK5zwrOKNvTSORZ0YKBXIeC0KAoDZiYZE9LFDD4w
 Lql+JNK/a69r5UG+wFp7Cli4cMgBFpjScaitFjvUIB/NviSXB70/Vhd+eTyslNOentzgRNIQSUT
 UFpbsdkJDG52VB8YlMd5Tej1QQJkqIVVBm8hFvoUIHomfrICfiWMeMbcY3D9VZbSelN+z1pU
X-Proofpoint-ORIG-GUID: EWXN5BaxzIEmYrI_GddaBsjMdGYXrIDK
X-Proofpoint-GUID: EWXN5BaxzIEmYrI_GddaBsjMdGYXrIDK
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68756ce4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=a_MUTpskHjF2EEzg2GEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=675 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140139



On 7/14/2025 5:27 AM, Dmitry Baryshkov wrote:
> On Fri, Jul 11, 2025 at 05:58:09PM -0700, Jessica Zhang wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> msm_dp_hpd_unplug_handle() checks if the display was already disabled and
>> if so does not transition to ST_DISCONNECT_PENDING state and goes directly
>> to ST_DISCONNECTED. The same result can be achieved with the !power_on
>> check.
>>
>> Replace ST_DISPLAY_OFF with !power_on to achieve the same outcome.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>> Note: Taken from https://patchwork.freedesktop.org/series/142010/
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Please squash all state-related patches into a single one. It would make
> it easier to review and more logical.

Hi Dmitry,

Ack -- I'd separated them to keep the patches small, but I can squash 
patches 4-16 into 1 patch if that makes it easier for you.

Thanks,

Jessica Zhang

> 


