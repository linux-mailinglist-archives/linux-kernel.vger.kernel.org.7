Return-Path: <linux-kernel+bounces-745940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8131B120BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862401C2161F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737731AC43A;
	Fri, 25 Jul 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YyVvggjk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438CE77111
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456766; cv=none; b=bHFmRJEYsnY3gIU/f5BXbVMMzK5tx/KN9WFbo90NvEMT3vOAa7A/nGHMthdlKijI/jpgnrSOYo+2TVfwWx2zGA2JQxRSTO9S1TXhXGSr9kDTPXMl+7UAWpqk1Siw4iydthLcldBnQ+vqLIM2y1IpzvOewDqPYERqBh09l+ewelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456766; c=relaxed/simple;
	bh=iRW4+4MhIHbeDv/M/TWOtdvp76wtYswFbJ1ptFWajv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBDFmZGUiSam3i0mOOu/iq5KT7596tKwFz4VwPgswNcbgkCoHeRh9MatikxkKQgvrIWAcnqnO2Sgvv20wlljENBJKfJ1pn7D5Z2DgP4sKtpaZL4It7uv9VMGmTdvghL0h7NjCZdCjC7hBkf/ztLCqTP6G8hyk8Ch3PMdpVpTf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YyVvggjk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8r7eC015756
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7M8blxILZGtEwPXR0DdexLPUG8f85Gp1piUzlyp7IAM=; b=YyVvggjkQ+Kxoqkm
	TE3aVHJx0dBZIJrolJ3E4ghHVB/yEs9Hvl/uFeKuCKwUrRWpVfqJuaqOkB4jMsqr
	RnoRnUoLBCpl+VF9Ey8G5T90hgyYXWt+wsBNew9xFELukFFEAbJgpLDbqcA7OUwH
	6/U/qgUj/bWcd1MVFhAsGEpYrfZKXV9cGQUx7v8dpgp5eyFRFXA+aGYrUeFF29gU
	n7I3WHXR4MCZ05IFxWjkG5nCFw8Dw8gE/yH2jEXrKv+ik3Mql3ZmllzRE0EOZM2s
	bWfNKlmjN7fOanPm9KI2TQngbSAtLCMAVMzoIlyojnsO9vT4s66sNBgHfPWh6Pc/
	QC29YA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w502h0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:19:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235f6b829cfso19476665ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753456762; x=1754061562;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7M8blxILZGtEwPXR0DdexLPUG8f85Gp1piUzlyp7IAM=;
        b=lYZ+qgseh1CrmHE2w6X20HeLbradC/IAGx2Vyavdoe7zSV+rpys5dW6ZWinENAqMak
         OrRCXil/4rM2YdjlMoRzYWfRSvHAMQxcVXKiCajEvETbdoFXZpoiebcTudDunm5XNC07
         tsA03qTp4NAecQhmjb94Lk9KQvSWpOz5xIXpO+ksqC17vc6bVf/ykJOIREbCbL99FbiB
         V2v7xrKKoIcr5aSoa5JiFSkYDmhqP/XpqsOWQwC9OBO2lQensVgZI+W/PGy8uNFvqr84
         5a58s6LWvLxRdpzetvfaiu8XZEeLzlj6t2QWLbEkNKuQtwn/nkK/6kGBUsMRLZTESWEU
         kDDQ==
X-Gm-Message-State: AOJu0YyAUbsi8Hno9Qemj5lKE0ytj9YMS3tE7yh+hLn5Tr7eEKM43zCO
	uO0OsPCcMP/e4LTKAjfx229TAYMTuY7JMP80TT5yS80AsmVlT0WGVhCeKOB9bTvbJtQLqlqO3mI
	tdF+Jhmxb8EFid7cpvaCvIZ9k58i/AOlyyD7baIPQH4YdN6L6n0EK8h621l6OV2WGlLU=
X-Gm-Gg: ASbGncvUt1xcdKB9MLPC91ZCIQLJ2DnNdsrkRVnBx5M81VfDaAFDuvRsudBfo/y2jy3
	QrhJsFVW4VTpLlmMQjuLsz5qAnJKGHvL3yBO5MgRgdSlgaciEbHxYMSTtGwSI682+DA739+4fEU
	qDBz0PTUWCHAPIww88FPEDgFuoa7hScWceNeaJl7vRsSPn5W2uyq50UDfvPr48QPvHXKQ3OXjtV
	xZK6tdzj3Z8dMQLuiBUP2TmLdr5GQhT3HWD3KrGICR2OWLUrOPDEGi21Q2NM8mnf14mK3CNM5JS
	yGapPleTQ6KjPHtpleLs8Ui0CHSYF6WZzV23bc6Ub/NbuXxH6C+qxW1QvKPzdA+qu8g3aEUGRNC
	1i+yHZ/Q8uhAN3h6fQ/MmU8OcLFPlMIC4
X-Received: by 2002:a17:902:dace:b0:237:c8de:f289 with SMTP id d9443c01a7336-23fb30cc9damr36195005ad.36.1753456762600;
        Fri, 25 Jul 2025 08:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH26rVXlhdF1lUN54Oy+P6if3MOrfHZkMtjRF9KKnKFIArb48JX9UdKvHklIABCAs99YUTw/Q==
X-Received: by 2002:a17:902:dace:b0:237:c8de:f289 with SMTP id d9443c01a7336-23fb30cc9damr36194585ad.36.1753456762224;
        Fri, 25 Jul 2025 08:19:22 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dbf2fsm40041405ad.137.2025.07.25.08.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 08:19:21 -0700 (PDT)
Message-ID: <796fdcce-bf01-4188-89d8-90906bf94a42@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 08:19:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: build failure with crosstools gcc 15.1.0
To: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <8362b484-ea77-4825-8ccb-d5acad660102@oss.qualcomm.com>
 <617201f8-1ad7-4403-b195-8c80d35ea30f@app.fastmail.com>
 <aIIOn-5Zndlb2tDG@J2N7QTR9R3>
 <b2feb2ec-9e69-4ab4-b75a-6c7f287c763d@app.fastmail.com>
 <aINJh-WFKHhxZ3fW@J2N7QTR9R3>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aINJh-WFKHhxZ3fW@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ew1AdWDHanyc90nLfmYzSCvl29cWubir
X-Proofpoint-ORIG-GUID: Ew1AdWDHanyc90nLfmYzSCvl29cWubir
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=6883a07b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=o86VrzDB6WMx18d22GAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzMSBTYWx0ZWRfX/pD6kqmIIVCM
 4HkdsPwSMO6N25rz5h3MPlDyzar6SspWFa99svI84CLy+1bPpDNFyoizMNJA7Uvx5BHa2qmOakb
 tkSsW4Kdf8cT0lSswjoxRUfODrSJVWVif9ezEW9em7gsn5YFkIWV8466joNgV0smGd9IW37AX2X
 6D8aSJ7ymNqg9xIMOOxYdlqaiaR/TSZQbR0bP/6Q1f8yebflH58hoas8kWZLi2NSryL8+5OroK+
 /VpaK7gUWPPvQBAHzL1pKg7iOSCKVLcCFat9DY+U5gS3yQVVjjurvSj+HInVxTmJpAoPEUi6oSE
 OvbqvjxRsN9fVIPbiVLaE8t0PFMHhYpLMScdzt4Ae1QASIqDqFRv7aCsD2API5BOdKWDx8QzogR
 enAcG3aAuMwrb7tk221S0Co6k2K6I6b0qlG3DeGEbUkWpiLTcavWax3/KaOJ7YOCMMyKtDD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=637 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250131

On 7/25/2025 2:08 AM, Mark Rutland wrote:
> ... I suspect the version of libelf might have something to do with it.
> 
> The x86 host has libelf-dev 0.183-1 whereas the arm64 host has
> libelf-dev 0.188-2.1, so maybe there's something added or fixed between
> those versions.

My distro has an even older one, libelf-dev 0.176-1.1

