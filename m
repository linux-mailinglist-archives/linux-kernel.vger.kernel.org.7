Return-Path: <linux-kernel+bounces-878288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E273C202D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520BF1881E55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002A35471E;
	Thu, 30 Oct 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ABYraAcS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cf4qAOqf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E62D4B57
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829908; cv=none; b=mDDsAO/g2oDn9Utb3s2lM/6CDU1UmwE3+978tdxaEAqAKZjnOFfqOHKn3L/4cWPIBENxGuDt0z0X2zVCgWbDUI8vmFcmwKHWaIWPG5p8d6d/Z9ZJjDq12ENeRFAiMiuIL8XZcBvn3txJNCcnrI24vnskFwCvusobgcv9U9OLjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829908; c=relaxed/simple;
	bh=CTON+1YiSNLXW7O3tYfA8KU1jBCvhgFdVi4tIrcfgMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzUceChgGs6oEi2SnJDHY7LKrW9v5s3gSGeu/cUJ+DtR6IjPLu8pPRuRFn1XjztD4tuSqOeLPEjZIURiMXQWU+7UnlrxNh0b7UWP50AdiDzys7f5hMDQIc2qaFGNDuzi9LsqAHNVXUq4QH4Ek/a1S1uGk46MasJWNVLABaSJ4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ABYraAcS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cf4qAOqf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UCbFiB2623042
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fe6ZqXuF7BFQDpJST8BTWNx753y2EUmzRxkdcWX3P94=; b=ABYraAcSnQ7IpmMR
	PlP8rkb2a4Scju+jkm+iEuC3RJT5zEPpOVe+zas8wKWI7HgiK8CG+lqj0fOS5Z8M
	FvV1iEE4v4DSYvNygXNqdcnSvJwol3pf0wcYV1K2iFkWfo42VHLhJdnLPtJXz2gQ
	3SemBoT6z2YW0CcIUCtaXMhXI8SN/i0UqPqfYffzOkEDvw6RBGX+Xr96gi8r9C15
	p0SOWS4wzV7KmhTreWLj8yIMUtsxXLan+SwEJ4qSqa1HNFyhYvkC35xZvhFsMOal
	SwlBVE/LLBwZlAorhswkOvXjpBBs0nAiKNUeYj1LN0fil+8hOxkqE6+y2WqNacgq
	tO8uDw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a41fxhbxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:11:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6cf1b799dcso756437a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761829905; x=1762434705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fe6ZqXuF7BFQDpJST8BTWNx753y2EUmzRxkdcWX3P94=;
        b=Cf4qAOqfjCnfoClVSZYGf78l2OLrL1Tsm5xHU0VcPpuWunzr7yhlSYlbfZD+E6PwiQ
         MpWvthBLNtU7cVTeq3U89WLmEVOLXTXZizXRsSmr1qMv9vuCQI0ebUarBNAEE84qn6tn
         KU6pWWALgd3gTVL0Hux5CShXopqz9T69iw0gwU5GsQHGPx2C1zkbTIjzkm7TOb4ceMdj
         i7FEm4B4zpbfFwbn6eGDv11cU5T4NoOcCUXGzRqNr1r9E5JlQiThKNpuqEHBU6jdZ8Me
         BBXi0azVsrIFhSo+54uIKv31sPVxagRPMuqHtpxXxUOa3dk4EPlVF+dCWepwJnpyuYSA
         Sv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829905; x=1762434705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe6ZqXuF7BFQDpJST8BTWNx753y2EUmzRxkdcWX3P94=;
        b=UnhGfp6j3R/XOGam4vcGOzRUbsWrlwzt7hi74kN6D01kVkKEfat9vI2edOGjR/F8Y9
         jh3kwRUhUjrjcIY5T8eSWOaCmoq/uJHEdTeybEXWMnIymdreT0Eo2hEKJPHjpoptMR56
         osCZbecMfrwPz8xbLPNdAXOIMGsUCQ/eRVUAHi+/kyJ/oDxAwfGUWTVIfFtXRFuHb35J
         47PhY/uhc+OWUqZ1GpRPKfwiFZs5EVA6TM+FtwGOzgJ2k+pxCtpVi3f16Fk/F54o7nXE
         SzFETiodL/3O8Ghy3+rm3FaAWyHq28kfpN+ojR8f8iD6jbZ9LEagll/czY+Q2YsXrnCa
         Sq/g==
X-Forwarded-Encrypted: i=1; AJvYcCXt4766RxNKeV6ZN6IID/4K0JjCj0vuWbgkELoSqdE/RF6AurYldCt0FxawoaloL7GKdAI/0vt+PK+urkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DgQEiZkGWAW01gL6wA9iziYcdC1aP12QMyWYOY5yNEIrroNe
	1F487gd9h5C9TaoHQK4GoPH7fMRhZEBvUZZNe61UZPkZ3tx0kqWHn1b6LPmuFm1RMHbVsmAwcDX
	VILEc+AdHh5tNhvkXBJuyT/kYWvKtuihOgCLeES2PkapHGAITK++86oiP5xMEdjEwBds=
X-Gm-Gg: ASbGncuv8vMWBQlzkgQidnx8NfR/CPc7B4Nh1lhVgwoza4w3f3r4PCVBVWwQ09v0a/U
	5lu0zuc/E953eVDwTjQumQpQ9wceh0SEiCoqBStcT1O1x/vHO4rApSt19YzSC2tCgsc0jCQhtpt
	BLWrVHiuR3CIq1S0CZoav4XaAXs63K7pPoNl710VhBNA21t9c3F1rTb1kdhPxeSPgeykh0k7Y8z
	Va5et1kNrvBmr4m3J+Laz8caM0iKjCT6u3dyUjR8yjvM8xUZK4g3AosYV0eisjrrM2Et+OV7kCK
	oBxhmvNUv0rH2mYwFBk/zMaheYB554Ue0V2CD2OYFaK2YYIGHYVZq1yTLqfrihQpXqskbv1EL47
	mQGB6Bf8UQSQuJMS9dvPBxSbcADpLfdr7r8fYsawV5I78r+IJtPwoOwRZq3E9mKTUpuu2jA==
X-Received: by 2002:a05:6300:2189:b0:2b6:3182:be1e with SMTP id adf61e73a8af0-34784e363f0mr4199126637.12.1761829904633;
        Thu, 30 Oct 2025 06:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYo+sTstYK/heFB9PDCfOnBRUTwhY5YthFbAsH/cpYV6rgtf1ia/tw3RjvmsxlIS5v4slqcg==
X-Received: by 2002:a05:6300:2189:b0:2b6:3182:be1e with SMTP id adf61e73a8af0-34784e363f0mr4198740637.12.1761829900455;
        Thu, 30 Oct 2025 06:11:40 -0700 (PDT)
Received: from [10.133.33.41] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408757csm18627442b3a.59.2025.10.30.06.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:11:40 -0700 (PDT)
Message-ID: <83d8d2bb-767a-4dd6-8e1b-de96164cad4c@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 21:11:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mei: bus: Add newline to sysfs attribute outputs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alexander.usyskin@intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20251030123000.1701700-1-zhongqiu.han@oss.qualcomm.com>
 <2025103052-taking-shredding-c77a@gregkh>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <2025103052-taking-shredding-c77a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oLPOgdKWaasm4kFfaI1VDpbxP9Yc3IFz
X-Authority-Analysis: v=2.4 cv=UJrQ3Sfy c=1 sm=1 tr=0 ts=69036411 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=r73D0LNGBsUp-UDSsYAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: oLPOgdKWaasm4kFfaI1VDpbxP9Yc3IFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNyBTYWx0ZWRfXxLwy0dkJ4fAh
 2AnfPVknJ/Xq4xFD6KwC4vwLSSRmF6QoDQAPHwxdM2MMeTnLx49gh6DqFoVcjwCfienwX/hL5Zk
 oKlkq4Vdsz2nDannTtLfQI52z0L7LEkam4VojRXunr8dgt4b9F+DMLUk6Y5meCo5/6ljQywWYoA
 41THE6zyqhAAVkGH3XuTY/Rew+Vo31pVwUleBKktuelAFA4RWwIoYvJXvg8tlvW7+iMibLNHFuR
 OQKjqjWSpJsv3zeuOCOeAP2doEaEEpBghXmiG8YD+XNkZhspZhnVWHYcpz2sXrM+2W6Z8cs/9Go
 crkiSHXBXbi2C2Kmjn3duRF8YHtYA0SVQ4eMYlt6D4wumq75Ce73YtE1hwO8EgtyHR15rSt3RFO
 8aPZ5MkibLBjx+kX5xmv7wtxf87STw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300107

On 10/30/2025 8:32 PM, Greg KH wrote:
> On Thu, Oct 30, 2025 at 08:30:00PM +0800, Zhongqiu Han wrote:
>> Append newline characters to sysfs_emit() outputs in func max_conn_show(),
>> fixed_show(), and vtag_show(). This aligns with common kernel conventions
>> and improves readability for userspace tools that expect
>> newline-terminated values.
> 
> What userspace tool reads these values today?  Will this user/kernel api
> break them?  How was this tested?
> 
> thanks,
> 
> greg k-h

Hi Greg,
Thanks for your review~

Apologies for the confusion in the commit message — there isn't
actually a userspace tool that depends on the newline in this case. I
just made the change to follow common sysfs formatting practices and
improve consistency.

If you'd prefer the patch to be dropped or revised, I will proceed
accordingly.

-- 
Thx and BRs,
Zhongqiu Han

