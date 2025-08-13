Return-Path: <linux-kernel+bounces-767537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E68B255B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B03A3B91B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489C3009D8;
	Wed, 13 Aug 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcAurwXz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966873009D2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121202; cv=none; b=eVq9ux+O2D8GxBpY18tDHjPt3yAhuHy0kOZzyttZ/KW7adEYn8ffZQQ7R2g5kxFTKxj2l0xivR4qx9RYWnk0066ezXMljwSEARdqDcJbQOdwjOewB3p2o2PRpwdi1HBZDA7TOCrHgrBipS1hGgLxAs+qaOlb5BFzqEeDE0+in5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121202; c=relaxed/simple;
	bh=823prMjoJg1j0sL2l7SI77tJcgvJxm1hdEbc8+qPckg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYvjpvNrUDfsJ+ZLeguAboguMtMID1072yxSzRBdCZCMwNFRTyrA0ARsmjwThdOVi3H3Koe4xiOhpIMjU86o6KUU5L/JkvgydQaMv2YkCHdMi5sWutiZYLkAyCz9wjIqIcBYeNLjaIWno0Ek5KekHy/2JpU7/I3UrfbFo6WqahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RcAurwXz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLcsC011176
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsHqObljI/QrkzM/zyszZAc8Qk56TEyRi+eNAb+o/hY=; b=RcAurwXzpAKXEdOG
	TRd+OlbzSSziHs0RursQXpp6noZ1157tRtAJB1a5hc9wHvfkGroPDG5dHp6Ljypn
	0aGqE0F1t/d4Dd/mfibRk26WeUDnSxgtKX7y79C0/MDYNtUcq3TDGcV16JO8hlh3
	EENDO3rjpsi6Fv4IkkzTUAbvjJFcSsf3esTAVx3EujYoEznwzY0vrFdvvyYIM3fF
	hp20v9KwXZodHbcdfQgLfrzVbfsHbsUYycnGxFau+RMrcBfutST5fj8gPHEt+BcQ
	c3KdObkbzELN7QXHZYBC1VwYb+avioqwBX3p7DKrFP7aFYobmjX3ivPskkahobja
	vmWFOQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbggf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:40:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445823e49fso2146845ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121199; x=1755725999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsHqObljI/QrkzM/zyszZAc8Qk56TEyRi+eNAb+o/hY=;
        b=Jpo5kdMdR0AsJTJNDRU09xRxpJ7o8LtOh3vwK53rKBwojZP4VOmVWGTM/+4p+D2B98
         aJtBfKqk1ytuMWjqQUMJ5B3zyFOjePPwysbfRAXisLxGKftsKqePpq0J39a4sED0tnWf
         Lnn7F5d9c6T11nOOOXpLMVN5x0f0bV95QmJC9h02EGzG7ly5jhMWa6MVgJC6jqUBlPuS
         /7B1B20r+M5MiVPRiJ8LhbKHIDdYKQgwD2AQej+aeBqKGvvqmoFL1Oi3W7TRIKGC28+V
         /kBGn/RXBvPCw+Ky/bwmkXSrKAXE7aLDgZBrxVM1xFjdt6DOW571201f1dyX1gTn9Bbz
         gIrg==
X-Forwarded-Encrypted: i=1; AJvYcCWHi80VXk9757HwoFY5d2VugfiUUlAYk9tXBMve99ElAv3He434v7fbTCoZJhez4kpRt6MgcdtlDnUXip8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMoCtxhdBZf/9JSg+sYBvrwKBcwPJY5FBpSWprehWh5iNUPS4
	RggP18vW9FyDhF/Al9UHKJ6RoZYCWHoEkcltzhLeAmaH8L5A67gXdU5iC+QQXr2Br8744wY6wFh
	qLOTQNXdTaQ3Yn1nQqfb7Ql9826LqZkXjZXWNqxc8jsO3JNQoCfwY8EokDZAoAgzOmA==
X-Gm-Gg: ASbGncuON73EYd83h1cBLPN11NwNRGFh0QbgonMmwbFfWq2NP6N8FVlghvOA0UV6aXf
	tAcBL/5/vULBx/BXdGQ9X48xV9tHdVd3Y4ZIY8Spyy0EN3fE+9lSYMHQyxJHjrb5zDTsgSE0o8S
	3y8NBoeI9FNy7w85D80dFYrjmULzuPAZb2Chr+mPaiFNcpzPG785Mr3vlYvPmjqym+QghbqVi89
	zHJYh8eG/TZALstL/fTXVblDEqor8jwcNzNA+9KOI69qk5t2YEHunCShsiBmAA57q7eQmds2YYE
	rwQO8XCspDD0OuqkhSaDRmi4GdYPKtoU1SO0s+riIRnqMgTJmm36HWmyBwBrPnbR1ui/Ms++0/J
	f89Th/vdPuXUZeOmBcRl1Hl5dTPtZxSk2tQcP7A==
X-Received: by 2002:a17:902:e5d1:b0:240:7181:8287 with SMTP id d9443c01a7336-2445867ec8emr8191345ad.26.1755121199162;
        Wed, 13 Aug 2025 14:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCxnQfRjpH03Kj/5q/5ynChdc9Gz8ERDFxOMx6F+r9zzLYTor/b2ISAK2vcBWx9FA/ouTeDg==
X-Received: by 2002:a17:902:e5d1:b0:240:7181:8287 with SMTP id d9443c01a7336-2445867ec8emr8190975ad.26.1755121198721;
        Wed, 13 Aug 2025 14:39:58 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9055sm336495925ad.150.2025.08.13.14.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:39:58 -0700 (PDT)
Message-ID: <d1009d7a-b675-4af0-a149-4856bca29140@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 07:39:50 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689d0630 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=21D8NHQQAAAA:8 a=EUspDBNiAAAA:8
 a=tfL3YIuboUik3C6ywHYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22 a=aE7_2WBlPvBBVsBbSUWX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX5bRkfMwHyXim
 1VwwRex83qF1G5JJlMwaZwLK4eSZq4xVQpbnHWN3YScLswjHKbh8QCw/HRAdhXU2LxpI86caKjk
 g28kdMtInO0z9RkAtLrtlIvzCuT+YPw7cXgQkrT5Gclv9XadkKosVFxdFlRwpmzsGv1doh9IGxj
 0TFyu+I2NbS7fKFeha82n91SNC7bwRaalp87Zpfpjtc7uZl5D95VCzCUC898+fxsbsJ1iN3ZCiT
 G9eazb/NNOCRfcE4WRbHZlYhotkVtuIn24PLPk431RG+p5A98c+CLgGwoNL8Z6ujWrbE/VH2KTB
 7XFp1yQ+SpQdECE+J5xE8XTmjNbyO+LYL0lG3e3I550iYvv2OGhd9mceQQ21nfH2v7r48Jzggbe
 drc1sN9p
X-Proofpoint-ORIG-GUID: mdlHCtXqlOVxzLgOKs8BcLJrq6bnQ9gD
X-Proofpoint-GUID: mdlHCtXqlOVxzLgOKs8BcLJrq6bnQ9gD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

Hi Jens,

On 8/13/2025 5:49 PM, Jens Wiklander wrote:
> Hi Amir,
> 
> On Wed, Aug 13, 2025 at 2:37 AM Amirreza Zarrabi
> <amirreza.zarrabi@oss.qualcomm.com> wrote:
>>
>> This patch series introduces a Trusted Execution Environment (TEE)
>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>> and services to run securely. It uses an object-based interface, where
>> each service is an object with sets of operations. Clients can invoke
>> these operations on objects, which can generate results, including other
>> objects. For example, an object can load a TA and return another object
>> that represents the loaded TA, allowing access to its services.
>>
> 
> There are some build errors/warnings for arm and x86_64, see
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/jens/plans/31DmCOn1pF2JGVDk3otBOXOL6kV
> 

I'll fix it.

Regards,
Amir

> Thanks,
> Jens


