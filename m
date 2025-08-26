Return-Path: <linux-kernel+bounces-786870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFD5B36D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B9F6884CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E1F21B918;
	Tue, 26 Aug 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRG7PNoE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7F192D68
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220433; cv=none; b=Wjrhey0I98FMt5oSRVLsS64GbJviIAaPOHxk9tqsdSu8BfXsT+okkdUimOhhQHPRKJ8ssM6LNnGlSXc0m5mBBasGTZ67w5Xg1xmaEfMKWrPLoEcKIDULHzNSPvHHpCbaUHEoDLZOm1cIkfIMKaJGqFjjtT7UCZewGwMb9YwArxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220433; c=relaxed/simple;
	bh=2sy3SUnm+GjMD5Z9IU85pM6PJVMtTyWK5ugr4sAqHGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YFsdsXczBX6Rj1XiA5EGtcnUgj/QSr1h7rsQWNk9gZ7Gd25kq2dQYiGny2X6uZcP2ErO6C+tg3XcSYRmRSBRcFnX6Q39i4aU6spClsrxSunVjnuvKOLMU+jlOK39vIbBmZmrefff4G/s/Lha/vUZcW/eiC4e5asXPo2nd9xaanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRG7PNoE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QBqVjO000801
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E4zX7FDy46jTNSQfokkMWhQWg4d+EwhS10aZhkxTroI=; b=WRG7PNoEhPAZ6Las
	GjPzDASv0k7AsMlKLNXrsayQz4PVoDt9yLz44JJ2T5Gh1evTDT5zmrIXN2aAhuOK
	0oB5z38kF84s/uQ43DmvwRQHaQDSaNokR9iWd9tvpt+iRytNm0KzY1hihVuEDjqt
	64CVPXVxmAg2UYnTFyeoGiUq+gQmFM9P05X9q3qBReyXl1t1kBaQemxglkxubCLa
	fa1j7tzj9/JJBAAcnDc4zSXbyfzWTlYvd0IjYop+S1TjWFZnMqF7V5wLk+e1xUkp
	+f6ontf3JCnIEu2a0A74avaufpUNQVf4QDaTuoo5eML4C4z4EhdKI8Auii2zPoXw
	cvFxgQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpscy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:00:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2445805d386so65640945ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220430; x=1756825230;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4zX7FDy46jTNSQfokkMWhQWg4d+EwhS10aZhkxTroI=;
        b=h7WDlggKRzxrgZtW9rRo41URI+1c4F575yw4KUT9HO7+w+UYk0n8zgbj0GHz0l+xIP
         8FD5yZw3NM+18b0fz2AT6K8n4WfunETrH9/Wcnn1pg398TokkG4SXiX6KYILtDVSM1HO
         G6k8xMkmRJCtFD3krg0JQ2ZjNIAptod/TsD99Q0bWFgHI3/GWCvsV/Use69Fxwa40/dB
         yVjcUUnvQlKNuihSoh4yt59m8bIRh3M/xVCExvweqJFZJBp7yMB/TqMlsmUos2GdYpq+
         H1bOYWa9yoJwtHEgjYB8bLBd1sTDULVTmIM45EVxO8embzJYhI/+/xXiSy/L5ZkRtDxk
         zGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT0glucFSdDelx+LtDTybB3KJSUl3hXSRsP08moLm7fz9DYct+BcSOlKnZVVZHBpc6d90r5Q8FemJAHpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa88XkXWI+rBLJJgdNjDePGTTlBCA03fYFTgNzm58Xx8yzK9E8
	89mE6fdprQTbEYQF0AW6h0py+B/8VaS7OIAHLdcV7hXohE/NNgGXZN3VbO30j4MxUrJ73mX4ZX6
	F2WyCkOXx4ezzNpbR+arzn/+6QI8JLD/C16pntYiSWU2LnHgpKTsaXvhJc1Hm9Lc+1+8=
X-Gm-Gg: ASbGnctgc/fZRPsZl80dKXTvVKYFp2cJiVvgBsolmQhc3PkJK7VGmQemhgbfz6qcVSM
	YkSOtf6ZcCrgUR68fILDBlkK6O+QimYQPEw8yqE+kpZkNozhsqfgo1yZJDPzi6gOa0piYSwhXZn
	1+1kQ3YnTw+q32t4URsfiDzjpV+cSgBFrhErTkpD3ZEF0T6FfrgwG0z+BKnHI4CNTjFETIApQrZ
	ZNVo1nwNfZ5dvhmUaz3sHQ3POBw8p1HqzEAluO6HC5fvpOmoGhDObNk83fAc6RwACMrMSjAmnZd
	JvKqz7U0BXR790shm9zjkfGURP1/EHpQVFx4fnKSf1K461E1u/uMXtBXgitXnk0Q+GcV4GGv26k
	zlFA82nzUbyvclw80kT0=
X-Received: by 2002:a17:902:fc8d:b0:246:bbd9:3810 with SMTP id d9443c01a7336-246bbd93ac4mr97127665ad.48.1756220428201;
        Tue, 26 Aug 2025 08:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtHCr7bGLy8u99KJ7otoMRWvX2qvOYlQm9bz63m305Hao9FmeN0OIQ1YPRtU1qfgas8ctCIg==
X-Received: by 2002:a17:902:fc8d:b0:246:bbd9:3810 with SMTP id d9443c01a7336-246bbd93ac4mr97125605ad.48.1756220426060;
        Tue, 26 Aug 2025 08:00:26 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3275933d6a2sm904010a91.23.2025.08.26.08.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:00:25 -0700 (PDT)
Message-ID: <eae93cc2-8090-4040-8b27-c492af528b45@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 08:00:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix incorrect type for ret
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:MAC80211" <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250825022911.139377-1-liaoyuanhong@vivo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825022911.139377-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68adcc0f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8
 a=LVyCKMctt9a3gUk7OTIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 4hhuG0cP0JSJaCVzIPGHoEkKU1nOxuC8
X-Proofpoint-ORIG-GUID: 4hhuG0cP0JSJaCVzIPGHoEkKU1nOxuC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXyKsKib4wzn/H
 vUq4qltinsrYsjK7Bk8OVMlctvXY0I8y79RPHrrs7+Fyl+kVdN1F89gufbKdcdvQGWIf3G+tvF0
 YMbg8sCEQCNhMTI2yKgAEOEzL8ULrNRDXiIcfoZOxAz52gSdoyQIhTVqp1NkNUGwRF9ZIhGW2V3
 vS6xi/Ld7vzI7Cf3us009vRYhNQGVY4KQGh8u2OJVw8toC5l+Kx03a9WfUHtXmYIkuud3yTso9/
 fqWwuRjr3cw0ZyBRRn9POdr4lootFt7tUxPY5Fhj9sap2i6vZ9kJ5QWf86B9ds+8gSJYLZFgiiU
 FMYjK3lFz9EQsF3zpeAPi7HSxUEWPugC4pELhJwONxDaQFKEjgFHyq6XLRHIRPeWt0KkxfH2J4J
 uFTal1pH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On 8/24/2025 7:29 PM, Liao Yuanhong wrote:
> The variable ret is declared as a u32 type, but it is assigned a value
> of -EOPNOTSUPP. Since unsigned types cannot correctly represent negative
> values, the type of ret should be changed to int.

not only that, but drv_get_ftm_responder_stats() is declared to return int

> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


