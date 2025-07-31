Return-Path: <linux-kernel+bounces-751484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBCB16A35
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3C7A2808
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877413D24D;
	Thu, 31 Jul 2025 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaHfkFfd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C67080C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753926233; cv=none; b=OLQB7lFK1mXHTaSddEm+yj8xH5+zz1g/yubLfNgkXupuaqxAcz5c7AjNb4zD4xryTp4bt/JKOVZh92GVyzk8dTQp1czhy0DfSDY8xhYZek+hspbJBW+8DB1QwfQQPM+9+ZZ4gDM6T5tiNDHU9DDFYyNCCdTlK+T95oKbo+EMwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753926233; c=relaxed/simple;
	bh=6c6CPKeVYSm/Nje3nx041XmLjIkTbymaDdjGrlTM10s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFEJ5fDxuyj+YchVBbnLCzPYVFyYYzLSdVfGwUEqtl7/qJsnqi09ZAqhAnamkx40znd8MxD5FZc+J9ewBWvGa0XhEuF+8aWlMZlBPgooHFqMvWCTYTgsGunkIsSXVE5I5NOgTN+K2dG+5R6la7LTIF6jZNgspYL01QnIRAp5pUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaHfkFfd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fNo6024824
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iEClsVWkG5VKecjEdwib4zfwZqjUZAXc840AZ1TMsBk=; b=TaHfkFfdLH5flNES
	4MvvcGUNkZEvj+rrOPljdtEBXVqq3LR/wHSSIFpm2MgoAQv8dXoUiuoMcxL1U+1m
	QSFnESoBqWbrVxKE6gDBpKVC4K/w2tWbMc2lAX7lY7X6L443ppto2hRAIEHZkwsp
	aKFvXPmMQFToF3aMvy1euZ1Ec1wfPd1AxUnSlK3ixw3olamWqCcDbwrmLWNKX3Yk
	qOOSQysmY/TfBzYktQUUPhQivpOoIDR0YwOM8kAsbTVARHPxGQXKGGsc31TculqO
	wvI4FgvJo0JQcaCsF1ufSe88qPZykUW6JapwIXwl550Y6lwg7KPVciRjeQlC37oF
	5b+3Mg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q8662b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:43:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso613084a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753926230; x=1754531030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEClsVWkG5VKecjEdwib4zfwZqjUZAXc840AZ1TMsBk=;
        b=JvZfSwYtU44sLrodxZW8u6dV9J0gA3k9FouaKOcRmOUleciJ3bOAHZZUEl9HyFZ9e9
         o7Y92X0a/Tssju5Td8anQ/w0ee77DKksMW5qTVewo8LcOxEr5mX8250IgekXVsXuX5JR
         9d+4vpNkO9W7+A8MZXnSjNnX44lghIjM4chcp/Z5F3/fRxR/v9W80+xxBNRiBgXyqs/W
         +9kCGpMGS6YHev61vAgPFkQ5f6BQVJnIUhH4DdG8tuTCrs8EEmKf0wUiRXYxZGV3FEnI
         GPqny4DXgkr+EqGgEkf8xernz17MeH6GpcPfRL2+d+tEVm+l/vqDWbcwh6htDVH3mZSA
         ZX9g==
X-Forwarded-Encrypted: i=1; AJvYcCV2chHq2PF4buK1tBnFNmESNeSizToKmDHZo+jR2WT1hlvxN793jz1y7+twCchnXJl5R8wn9ftC/hFM4dI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq21GUzuB1jaYyh86qQ3xBcnHGCzywwjkRbl7HDVOZdCspizDI
	w2MyxGmO3JkdTDxppE7UGUZNJK1faUx7ZB452Lp3gbE3HFTvSJbN+48VhYFI2EzNnTwDtwcuiPI
	751yddzUaQ5APCLWgdQlc/1Tvfu/j5AluPGybDGcSb/1xjJyyuB0mLdPZIh5JuVm6VBc=
X-Gm-Gg: ASbGncsf2u7w6JrHXf3SdCxdnLxomCgUTb7zoSQQlvkWxzKXodOu3NcfNDRIwhiHMIz
	2t6toA/1l/gubHRd7i2SSDJeEZq//RygYKtCB9Q8G3r0E1Fw+xYNsKKVWdyjDsSavAOaCdDnuiZ
	PuOSMtc3woOelqofvcPZCldALFpgty4kLIxisH8il59FkabzqbnwLtKr99/Y7VPz6jz8tp/iU/7
	0eA2coy1+8n7m4dNMDTGcD15QR4jdngUr39UMqyGjcIch4vyTPpxtMPx19+LD8gR8jburkoCZxB
	EoohymVInv594ZEuFxakQFaPjArl8xqeqVzQ+H9v1g9VyGFfMacnkSxC8+xJquFKAnxveGY+vgN
	QCX4BviP9W1u/s0vdIVDcZZVQJbhL
X-Received: by 2002:a17:903:2a8d:b0:234:a139:11f0 with SMTP id d9443c01a7336-24096a72a07mr63142655ad.7.1753926230131;
        Wed, 30 Jul 2025 18:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGeA7dwAAcKBLFo4NeBFBuWGZ33mZa2ufW3SFDYSN5mlhbysww0yxJDxS/Ld+l1CU8IMpouQ==
X-Received: by 2002:a17:903:2a8d:b0:234:a139:11f0 with SMTP id d9443c01a7336-24096a72a07mr63142455ad.7.1753926229761;
        Wed, 30 Jul 2025 18:43:49 -0700 (PDT)
Received: from [10.133.33.141] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976995sm3442425ad.91.2025.07.30.18.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 18:43:49 -0700 (PDT)
Message-ID: <e0f827e0-1552-4542-ac70-70903227734e@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 09:43:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] leds: flash: leds-qcom-flash: update torch current
 clamp setting
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-fix-torch-clamp-issue-v2-0-9b83816437a3@oss.qualcomm.com>
 <20250729-fix-torch-clamp-issue-v2-1-9b83816437a3@oss.qualcomm.com>
 <f3c004a9-dba9-48b5-9930-979053d0a32c@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <f3c004a9-dba9-48b5-9930-979053d0a32c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAxMCBTYWx0ZWRfX5CL+V4YlYztb
 rtgkmId3+dDykUn2XutW49MxxFGwUVkhWxWKvW2Z9uMuAQzBRCq+W//QXrTvCidP+Luy/R+3BkU
 rFkr4J4xC32gDNmHRajguOuJI/qDMPYt93SLj711xa/Rw97HF9PCXIQXKg4ZWAbjUWHcVEfU+bO
 XkTeGXJ0H6ebuCRc71bxUNJ3vi0OgdT0nSLA+Vn+MuAPtzpN5tN7UFDC0Y+KYmwNq0NL55GHbbF
 Ih9P8Xm1TQu6Xed71K8dNk/Rx0yGOci0jFhxm5xdCFjub5/tcgL27glPlIGJryImsYMCMKwqIrh
 z4y+bdvkbOmd0AFzWZ3DK3JMPLMkqIcbDi+H4oMEEKk/8xe0+qqDkhTlxWPKihPqpchn/UInQD9
 Bp4Hw345IQL6YTzR7mNzh40xAO+uu0wVan4AAVb0DCg61DtPibX9I7RoWgyCwzLcGKJP8OCI
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688aca57 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=-gdVP2Hq3PRLCh7MhMgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 4G6pLYyMaEgWgupsDi5_c1Ogq0fyZdwP
X-Proofpoint-GUID: 4G6pLYyMaEgWgupsDi5_c1Ogq0fyZdwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=732 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310010


On 7/29/2025 7:01 PM, Konrad Dybcio wrote:
>> +	torch_clamp = (current_ua / led->chan_count) / TORCH_IRES_UA;
>> +	if (torch_clamp != 0)
>> +		torch_clamp--;
>> +
>> +	flash_data->torch_clamp = max_t(u8, flash_data->torch_clamp, torch_clamp);
> Please confirm if I understand correctly, we may have N flash LEDs
> connected, and this additional safety hardware can only compare any
> individual LED's current draw against a single maximum value, which
> we're setting here
Yes, your understanding is correct!

