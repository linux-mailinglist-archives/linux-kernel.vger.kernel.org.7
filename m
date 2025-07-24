Return-Path: <linux-kernel+bounces-743421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B7B0FE71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B24DAA35B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2414C8F;
	Thu, 24 Jul 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QErbye8l"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67713207
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321738; cv=none; b=PDAWTGXjfI5JuxK1JC5kSkYbAC+h4izlOxfs3+3KMC6U4mGdlvqQAXmPL2oizlsInqFadxTBj6TRT8XW5luQzCRgTACHrMYNwHU6y/eDOD5qImf1J2W4AxGXQ6lpo1tKuzumKq4iAUy6ECjMi8i5aLNQC2Kw0RTRsxGEtLo47Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321738; c=relaxed/simple;
	bh=yOckcSAWN3jOQjyFGoNTRs2pUdHiS6imQniYsYlRySI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s13vI0eOxCv3YKViUOj4HWOICX26dzEoFOC0bTRZBnJzwG5F+PprXwB+kj5weHOAHskv8z/URu9d8E85FQ+db1f+xMS5X4yCMyjFbw+hq/XhRIKlLGnWAghtYK6pfo303Eqch3hY/EDBp9d3UC0tdHDf9zgfIntn0iWxWSKqsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QErbye8l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXflN011227
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pONdAv4XuSeyzdXX1wuMYXUvcdht/3V8RKEwqG7m+YQ=; b=QErbye8lY2wArw4u
	nLa/nxC9JhoJBrDbHVmlNrLz2iPeVfvpHjk2sLHotBBSVHL3ek+B/04oX43Ltbv7
	0+tzjX+Q9YebaDDNbbvCwNHi0x3mlu6VrsRxxs1Fd93eeakTkNeMSQbclJLd1FLB
	qHdgB67vOlhCX94MxY8XAESIeRo7qE1wM3xBg/8lNiM1aIsx3xT7w3KDzD7bVxFR
	ucuxEch898Czh7RZ0tSOXONw4im7sK4XxoTIP1ct+CJmKIIh4V1rZy4L6WNa6KIR
	AORgCqkHOsKhwjttNv2I1yv+hFIhi7A6VU8p3qjv49ZH1lCi9tNcD4XqGEmRgHTL
	w5s20Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w873b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:48:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso807637b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753321735; x=1753926535;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pONdAv4XuSeyzdXX1wuMYXUvcdht/3V8RKEwqG7m+YQ=;
        b=HhmGkQ/dA/Z3FGjiuM3ueyRwSbK4ellIFua+5ClIaZ4SGJyF3rrrq1nvB+6xfL64qV
         ppLbZrDK+7f187SJCi9G5i71Y5wRTmAqgzJAgDqQ1Dr9GJxWOqxZaR74OD+hPi/v8IFf
         /fr8pG9cTuuIMk19dRvGFsFqVHLtIS7DP1XzECFma9AP0WbufIq9x4iq95wD7LX9cVK9
         VE/2cqnVqTXjGN7rFdJ0XoguaTE6NboDr2UG6OCmeg4lc1PZwJSFTTvuUSbkONvQCKgR
         IU2Q8BFnDDX2Ah+77i4yxX81Uq8U/3JSKUG6pk8NQnVMJ3q7yEXFsBMUBPXcy8OQXrgu
         0iSg==
X-Forwarded-Encrypted: i=1; AJvYcCUEmRReQWozLWfal2hd3hD7YDRzDDWR2h+W9CDJdzL8d9I7ynlcXAKjEslyTJifXKGmog4hj4Xu07zNkSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2A6UsNInRyZfAIfIg9/HLMvGBYcjKfUrPm5pZpqqzRquQ02WL
	qcISP7WIjiUK87gc1bPuiZqRKrmNVCqwQUHVSZWLS0DeNrSbcthnhcb6DslbWIvEw7Yl8sOhAzd
	9COiqWnq0OkJaa4UYjzFAg8A22xZp4NyTHllTOEPkJ6Uo+coA2e2xJ6kaWh/WEfbAd+o=
X-Gm-Gg: ASbGncsEqDIc9XjVyL1TKm34ARYkaJvH8kjGlioFKxAU4fiRae+vexKGeSeQzxk86A2
	nUeA/JrgukwNPoZ2ZzPInebO+SkXUTeQmuE5BToh/sF8Aynsrkpu0uU4jK2PQ+76cXQikW3WFyt
	I9ECVpaWyUTf8rl0dp1FIrsChbl/TUXds8zEJJze18C/EGs5fveu6CDF/J4d4MCmQZ2Si6Y52Q/
	XXeHZnEYiWYevkLcAjgXu83QvXsG2W/ekaOBFtogLlA5ZcAvEITq4tTSO0jWQHus2H6hZH16Cdh
	hppfDsO83octtiEEk+0nvKvGbeIYm8q3sbUagoK/1Z3/kdaPQRXdIwxeVC22ijDLCN8Lk+2vRUY
	x9xf2Bm1AIwXlcsIMA5o5Z9p0z+Se1rGt
X-Received: by 2002:a05:6a00:3d4b:b0:75f:9622:4ebb with SMTP id d2e1a72fcca58-76034c4d082mr7493260b3a.7.1753321734689;
        Wed, 23 Jul 2025 18:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNF/FxJN8S9VPMYDlqd+zaDnMBYiYx08UeUD4DYOcM/V096FBP/axlaYw4vfyBR6itOiPHtA==
X-Received: by 2002:a05:6a00:3d4b:b0:75f:9622:4ebb with SMTP id d2e1a72fcca58-76034c4d082mr7493236b3a.7.1753321734272;
        Wed, 23 Jul 2025 18:48:54 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae158d4bsm380439b3a.49.2025.07.23.18.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 18:48:53 -0700 (PDT)
Message-ID: <36da45e3-20e9-4ffd-9ab0-3f3804942eb9@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 18:48:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: use kmalloc_array() instead of kmalloc()
To: Yunshui Jiang <jiangyunshui@kylinos.cn>, willy@infradead.org
Cc: alexander.deucher@amd.com, chriistian.koenig@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aE-ML8rLXnLaqHVA@casper.infradead.org>
 <20250724013754.3429608-1-jiangyunshui@kylinos.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250724013754.3429608-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=68819107 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=otUng5Y2uqA8c-M6AFMA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAwOCBTYWx0ZWRfX4EVjZNoHkQRY
 wKRHpTRQdccXwvDtH98S9GzPda1btN0LoCXnJaQv6cdjyFXomlv7GmQd/ZH+BFMlq3j/SqwQYJ+
 Hw5g12boy4mJmQCs88+dv9+pTgp9DGvEolVYPGeRAQ9ntliyBmPmqWQ8+3kVRqqed9qdQiXI5a5
 hMqt76C4cqCLljKQ9R3dcdiWScf8tUddkL/fcr5NF3dVcTWwlxGo/FddzBcTq/Ntd2X3aURmod3
 ueapWMcZXfr8pskjaAIsGK7RkWyh8Gg4nsJf7SxYzi319yiUdHKXD1prVMDF7Wmyc16iiPlxSQI
 HBBjbQmlgRXGITGw2CdDTV5nyTtpQuWjp/o3vfZJ3MRleu00Q2KFSydnrmnnwgk9PM9RiQNiOdd
 dHK/I3NyIQDwmMzLeSyPNg7r7gM/CuhYcE7MpUSgHqD/FV0rHP30jEdRgzk5e/Ovxzk8VE+b
X-Proofpoint-ORIG-GUID: Dooo0PrjkMN5bTLhFcH7XTtYTG3psVHN
X-Proofpoint-GUID: Dooo0PrjkMN5bTLhFcH7XTtYTG3psVHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=621 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240008

On 7/23/2025 6:37 PM, Yunshui Jiang wrote:
> Use kmalloc_array() instead of kmalloc() with multiplication.
> kmalloc_array() is a safer way because of its multiply overflow check.
> 
> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> ---

1) When you post a new version, you should add a revision history "after the
cut" so that folks know what changed

2) The new version should be sent as a separate thread; don't make the new
version In-Reply-To the previous version


