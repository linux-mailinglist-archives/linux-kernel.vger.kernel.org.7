Return-Path: <linux-kernel+bounces-852039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB1BD802F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E936F3BE441
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDF830E822;
	Tue, 14 Oct 2025 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lYHdlgjg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B725F7B9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428321; cv=none; b=fM85PNj0vvhLpZg+80Ef7YBkLaGQbcCyDocQ8Jyf3bVl3IvThjtCTIwZYFRfBPN2gyT0oytuZZ56mmt9tvO2EnpvdWhvU2LZTyDUvKNzpskP1HBmh7MAmWCuMkEYsMltCv3MKEqPWwRRqVYuZtYGlM4fOXKTNzNTd065iD7FudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428321; c=relaxed/simple;
	bh=qOlGTnjWC7S//4ct9mMhcN7fRfRzafEbye9A+w41OjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7eJbQL/3ZqLsVOe11N5eetvX5kSH4+QuF7pjGWEdTvo3spvLb4+FeLC9VuLrn4Wi9It05pWxZGJhDmUt24AAKiQzhVO5XsjwkbMt/wVx0pqep60CwVxrYsNNDXflBk+3v2blPOxHJrt+AkSBEGVAq+Cu5XwR87usk1f73tVI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lYHdlgjg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6RAx4016401
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z0qtfAcbRRGVp6DETyBKrSN8epuMBuJtgVuS3PjeKqI=; b=lYHdlgjgVr3qv8Sr
	r9abvsgc3pQ4XkE88OpfoSkvoSxnwgnq3EQCFOEcict/bDXTXPhPhy/F7eBZAX4T
	MOJtDnXSS2rpptGgc7JVR+g78VVF6GlP9HJ/r9vuICrmV1t4TVgik8K9LEDa31YO
	D9710R0JAzZtGR6M3Dh/Fo43smDEkIzxezLPfyU88ZDZ7Egra4CuQbBwdb3Q/3gV
	IQb77YbMcpZHtAFiA/ToVXsPYzmLZMoDSadXFIVdgDwxo3EwxKMjT0h6zerz28Ah
	2Z4feieEebgzHTZRYwnvSyOViqF41zyByI0J8uwyiCHdHEU8JdrWZ9+eP53+Home
	wdgeEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1abxwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:51:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-879e3de728aso218198085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428318; x=1761033118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0qtfAcbRRGVp6DETyBKrSN8epuMBuJtgVuS3PjeKqI=;
        b=X9tyP0abiik9mtRZXmcyWJ3rrUsIdHfFbQkn/oTn8y7fEFlYrNhzVT0U1UxiLO0faR
         wVUAc6TpqKhNy0jz8+hS+NpprjbBGy9A0pR/7Zp67TW2dY/I+RiuwerlKXAbLtnMW+nT
         vCUfRstoBTov1WgkYRk1QIdsnWpLcF99LANnu7oRNbp7KgEWJaPh1R6zqs0qHFiVVZgv
         rSOIXGC7CrWyqGdBhXVnb0BOJ+Y/UvjqfRLsQbEU7drLpTGFbblQh4mu+zlHX3zL2OtD
         l2KZBnizbGeY8g9PfjhD80qRI29h2RUkS7bRVu6iFt+LCF4MkUJI0dbsapXhQCkHS3QY
         XnvQ==
X-Gm-Message-State: AOJu0YzZ3eKENeyTLIt343uc94piTxl1xaCJjV41AAIiLHQw+IntU5Ez
	eZkl8ov6mbuB7E5yt0v4KfbfB9gHBmdRmiiNI6XDVJNmSQhbhApdJs8GRZCxPvW//wIrodjMgJv
	YE6HUtU94glLKwuuADwNj5kyTK3eyfzdFIIfQCTYqM3vNlXhlVPGnwk9mlBRxCDkWm5o=
X-Gm-Gg: ASbGncvIBzBc9j/Cwh17HuwhbKhqGnIQj/EsdWMDDuMLASUaO7flNT43CdaNiOHNOhC
	vs+DTWBbvy7AVIdn2Lr8Kxeavw/yANyLbZBE4bZe1fHAhGKgPZlE8Yzz5TlQWc12MRrH8R9bywQ
	4640lSwluUSzkVE4sZBkaLpmKj8joiBYFkrjQtK9Cb2+rVHEjBb2bdMHCdpI0IxjrsfUhpkIhWp
	RL+MctCSBGDc7qWgRzHzNVHnb/jDk8mDOLLyrMjo+yCmFvB1koa+uIxdHLOiYDIksiuFo4xTLgS
	v2roU6cjOt4wlbTCa6rAHjKkWEDCy94WPOXQPRJkeR17XY4noghNpk+fENcXQv3jp6LWgMMYifb
	PGvyGMNVLxJITeqGKE39FUw==
X-Received: by 2002:a05:620a:269a:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-883541153abmr2177175385a.8.1760428318084;
        Tue, 14 Oct 2025 00:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7dAVG2/lTAN89xViTE07+yt5E2ydVjSGhDeAoedXXt8eICGnDvQLJoPAGhJh54cblZhK0ow==
X-Received: by 2002:a05:620a:269a:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-883541153abmr2177173985a.8.1760428317632;
        Tue, 14 Oct 2025 00:51:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c124b3sm1123874466b.55.2025.10.14.00.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:51:57 -0700 (PDT)
Message-ID: <98b2bd9a-19e2-44f5-bdf2-fdd8e6c31815@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 09:51:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] firmware: arm_scmi: Increase MAX_OPPS to 64
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mike.tipton@oss.qualcomm.com
References: <20251014073454.461999-1-vivek.aknurwar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014073454.461999-1-vivek.aknurwar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ee011f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=yHBzqE6aYKRmK_OBsYIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: W3QTdyld8AzGGaMsksAEm3KHJp-ipRMp
X-Proofpoint-ORIG-GUID: W3QTdyld8AzGGaMsksAEm3KHJp-ipRMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX1NF77wNlJ06I
 UK35aW3JH3kATIlB95eAJ30QACJfDo7yRddW4Hj0PBJcPzvCUZqSW1cSZbECuene6yGDrn7dj/T
 i32MMreQJM2KLLzNEu7DUyLQQxCfRtSyFzkGmjVtr9zd+Gy0oahBeRFzvJik+oFfyP2FKJEI2vs
 hbLJyzdIC4fotRex/bLz895BJqlrSlmxECOOp4vuGRz6VJ4ywSWYDa7hMeNpWsJvyN7CRtG3RtO
 HeusJf3+am2CHE5CrD9ymtL78uLdaUHggNewcG3ZyLUvVs1+XzrWflyGCgkbmmQdJoi12r1JgsU
 AqbJ5XvwKUrU2Wl960TickjGK7mmzuVWLOi+muHquyneX4UvouzpBc9U9th8cTrYhHY3q3vuwis
 5rOx6DKKcjeK8I1rO33fzTtbtYTfkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On 10/14/25 9:34 AM, Vivek Aknurwar wrote:
> Some upcoming SoCs define more than 32 operating performance points (OPPs),
> exceeding the current SCMI protocol limit. Increase MAX_OPPS to 64
> (next power of 2) to support these configurations.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

