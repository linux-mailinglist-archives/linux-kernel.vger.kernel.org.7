Return-Path: <linux-kernel+bounces-823137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9CB85A65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C57C0A20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2349730F953;
	Thu, 18 Sep 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFi9e74j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0D30E0C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209444; cv=none; b=eBoZbaF2s3mhsAe904uWa1zJ8MOxBrW92iL3fUsSAybY71c8TRdrTs2gtobNb6BKMYV50symxs06B+VuLTQIRgrRQV7rlJl0dwqtolLxb94RqNoT2AgL8eJfnKjQ52nWsEzQLV4ZFH03bkCy+O9f1tMN8m7jJGm9etl0hCn1EEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209444; c=relaxed/simple;
	bh=eHexsjWST8Mpsyps31lBz0UT880fxViH3NiR6TxIE44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyzcYn1YQdw/CI44xawHksT5mWOJNjU4GknT1d2GCn70cH1rfFHzdnzupB2UL6OgNJqO/CATgSmdFych7F3rNQHFD4qxBkimiVTR3E/phVPiCDRPVKxo2sy/DRAG4jpxpT9TdzUb4drL9WMa1Q1tzwJ+7worwuBSEXond4lbEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFi9e74j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAW9HD001743
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bhSX98HuJMkyrMaoMiSuQu57olFpyJn5Wru3dPmWuJo=; b=dFi9e74jPDRlKBq9
	wyuv/FewfFCifXgDzVQNKatQxQ/gGqnQVf0D51B/j4e0LDOgDPm6FB9Pf1wHg26Y
	7XtX047T9jmYvLYORZjmXPWzDIuvE/WEAptzPhFj+lxn2J6av7XgMAtof0ThpoSR
	XUC/dPUpYXnV5hI+wCoHNetm43pcvQOKHH/9obHjSYCi+pCBUKFpR+JT73vW85TR
	Vy3XQOpFCKmRxk+ZwVjxLsP58ib2qr8yMc8F98JVXGTvEYNXleDneff21Bv+w9EP
	tQf0BueKnMnV4owOWYel4dgxDEqxKZUGfe+BDnBSscIFwOTFJrkRjXPe1u+NAngh
	Rn26sA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxypxmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:30:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb18b5529so1023120a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209441; x=1758814241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhSX98HuJMkyrMaoMiSuQu57olFpyJn5Wru3dPmWuJo=;
        b=v+FdKNpODWQAxa1EltS9zCQnnxTCuPSCof+JV2kvTNkOTcugdJdf7tX2tnPPGnQYaG
         l73QnkaIWEFtUiT0cro8tLRQtnJLQ44OZxRfnPNPOqTAs3Nrb2grM4G+wIFGS5ldJWXq
         P7/6sBTM5OA5I8NDL0A2yIAIbjh9z8E7QSkOemGBnvfhGEyILpOoxL0O+lBPjGcn6wP1
         seepTz3mCPsIOQSRZtMSsLqHGWU5vMCZmt4/BzcUH4oaSw/gAEi9YRGEPL3ai3RnSYJY
         9TDFa+S/H6vcrQv70arwjLEv3uI8o19QUey71JPh/zPPA+POq04ApxJLHoE5yxbzwXbk
         c2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUUVwOCPLBnMD4NylYJri1L5nrQdyYRPFGAwsfFbkC6+eC8SfMlRyD84RqIkdDtH0f5ea5TzquO10tW7sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCwpOxW5bxCGtkCeust/shdCBmqEoQMaET1QYeceL2liWIBMz
	orDhc2IUhGESGga5QnmOhDlcV2LDbRaWk4PvXj9U5nx7lVFU+IM7BVGs+LIGO7agXzYDvnps4TK
	NJPDEH798GIlzWDsuUd0zK6exEGILyHlj5mM9kB0lYp5b+83KwbGAIlj9fna8jpmI5bA=
X-Gm-Gg: ASbGncu+2AuecZYN0Rn2TWj0ms5CyegAg1aXy8leKZDko/Hu5KgiwbyJKra4jSeekaI
	t/KtC1P4qfeTIesdv4aw2E9p8zkTBZYLVFswJDijhleBoulBqyuTGGry59A1yCoNrbdAYYxPMCb
	SrsQkqTqhhR4re+0pntqrWSfL8iYqULcA4YI1oOCkm3XGzpTQ0Vj4b7gnRVclLb/wc9tfseZLTX
	AV7kDokxhsRFAVSN9QI9SSKAuDiX4gWUQyu9zoTjIPvuthS08BxXDPRrBfPubQI7c9DA1BUOcTG
	303u397gOVrJkfQ8cBxK8saD8oxn31tfXhAwvQOU22h6iyoCK++5nr6BG0OcceHKeFxc2dzMAhk
	CwXtYyp62PVs=
X-Received: by 2002:a17:90b:5590:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-32ee3f68353mr7443679a91.23.1758209440729;
        Thu, 18 Sep 2025 08:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJtZalFVe+kGAbPWvX/SFNLY4dbFllQVIHjbFGW3Gqec+5jAn3kcNmX6T2JYXIMtSPBWimIQ==
X-Received: by 2002:a17:90b:5590:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-32ee3f68353mr7443610a91.23.1758209440202;
        Thu, 18 Sep 2025 08:30:40 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306061925esm2937000a91.2.2025.09.18.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:30:39 -0700 (PDT)
Message-ID: <3ecf5010-7480-c780-1bf7-b0e762bf293d@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 21:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] wifi: ath: Use of_reserved_mem_region_to_resource()
 for "memory-region"
Content-Language: en-US
To: "Rob Herring (Arm)" <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
References: <20250813214933.897486-1-robh@kernel.org>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250813214933.897486-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cc25a2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=31WDjHDmXr0yx5AvGNnQTg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VjuCZWrZiTeoWwOd-AYA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: uzaML0UfFSiunPDGdYVhsiJcjiD9cFIU
X-Proofpoint-ORIG-GUID: uzaML0UfFSiunPDGdYVhsiJcjiD9cFIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyFDgYL7VE3uI
 RHxTHEvoK9hi47auAMffTmYRtyhMj1E2bY80w+BDXaUSr7ITnhc2QDAIDzwvjih9mxMyzhh2psx
 uQGbC0+pe29I0qbZdTfQdbEt9ADYUdEwqu0TvWcqlF5iE6VL8JILt6Dz5Ks9FRgPyRQgCGkPMAn
 Amz84iM/Plk0I8VKxwcE2GG3/tcd0AHFqehkYGvsa3OsYDQufPsM2EceOKYoxpiGHuCBuDPYFV0
 929wQvrBbWKfZxEonhui8WPfJRFveORoOjO0sXtoc4SzeyH8kK9cTTbzEiI/s7dNWzLXmkoWAha
 Te6a7xq/Ika/uWGI+13mL9ybIJvbOGJtLcggu4wD3MVrblgcjKHa7yA4MfZjuY3BKSOjPiSNMZY
 KWsofdYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/14/2025 3:19 AM, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> The error handling is a bit different for ath10k. "memory-region" is
> optional, so failed lookup is not an error. But then an error in
> of_address_to_resource() is treated as an error. However, that
> distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

