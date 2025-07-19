Return-Path: <linux-kernel+bounces-737832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64890B0B111
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C390189AA4F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800221FF2C;
	Sat, 19 Jul 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LonTf85f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30B1DFFC
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945725; cv=none; b=M4z7d35UcCFImPP+At0F7BSO9jX3RX5aaBTKVcZangNIWcBukzyignxbZFDmV/g6Gd5K690pENEWejFa6clVb1q0EVWzl52ePYO9UWLAoWtIV7ZAV3Ti0oaB9NOZ5jGJdadIvKlv+fOvSnkQLMsRHeSEqPq2q8z4qroNAoijMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945725; c=relaxed/simple;
	bh=MLAvcegA4PyP2rE2wMK5AzgmTWEH78sJO82rM4rDDLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Whx1LSBTAsVgpRZRecP6B3fliDq83jbdJxQIgzdqHBtfKy02Eet8B/JtRi3iEidFdgmev5WFHFEZf0mvgNQiQSnI9GYcHANivBxgrakmt6vCu7feNf5W21jmN09M4VsKMkCeRWIOTtrBImD7pPK3Ntm6HBCNdiNa1MB5EKcWxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LonTf85f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56JGoEth014087
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4JpVhQLJSPv3BQlSmdFwM3pxbrYszmWw5/rIg8qZdnY=; b=LonTf85fWyfriiw0
	e4ypW2SavodVtqowc2E43oFqsZNM8WVylIGSR8mTpvJkgoxLzwhiKW6k7d2uY1MP
	stKl4Lb7EjlAUAon9xJeGT/Qfj9yf0TGs13isOUUaoJ92ewMMyQqpIwfZHYgByeG
	ALCz1Wdb2UN2avFgD89ZFfkBrx5Wp2ChN+g6QtBSjnoQHM8iVvXUBUO90xV+QEAq
	wPaYKti9LUNz2oiAGO3Lpx8yarJOCykmzl2A1Y0SFUtzHuOSuK/cgHlmnNw1b0f4
	h2VtuRFnEHyTeQySKGNWhlzFtPqGgjNK9rkaVBWnfHhvXz3Ml++XpR4tl+0/l9XB
	D76iJA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9rw81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:22:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b115fb801bcso3484660a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752945722; x=1753550522;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JpVhQLJSPv3BQlSmdFwM3pxbrYszmWw5/rIg8qZdnY=;
        b=eWoZw+rqeG+QyrMFfv6VvU7H9TNUulpmg9N/ziF4jz2ADNFU7pw4BE0ez3rXHQP9AG
         onBEJVTUz3NL7O8RnW4Rt5hZQFz7CQxqFNpDAq8yjjHMM1x9nt/GDkHIZTwdjbThcC+r
         yNvwPoE9+nNaajmIqcZkSBF/tPW7nsf04yhQPkv+mQq7ljez1M0vNTlyYWvH/2efRflG
         wn5PWWwTil46HUW3pQ7RtgOrsFX3y/BmlE3lEG64i33WEBeVaz9AolWkrQ4BUTGbvpHq
         5/QS2wi8/l7kFTJha6lsNAEB1MLWH+esSfVNeh2fz7H7o9hJewCHkbgEnkogIcxQyG6c
         L89w==
X-Forwarded-Encrypted: i=1; AJvYcCXVXu5K+/brRs/pnnUgxa264tBG8QGtgApSGJVZ2ycbVW/WdI08EYOjxHJvTLsdHXB59guevBfnnVaQLDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWkKUvTuggmKUcH8tupDplI2bkZJqM+emRretY38NEOnNv/5X
	/vHTqv0HK4Hfksa98aYJcSERIb28XIy6D2AzQ5ZiVsiAgrRXng2Rz76Tge+7dVYABsDmAwXhaq/
	Fs0WIdj/ENsSBHAUognai2Zr6pu4jayyknCJ0huQfnHp4Og2V8tPNXw8qhW+gU7MmPXY=
X-Gm-Gg: ASbGncvgaCMXf6u22B3e6Ggq2hPWgtPQ9LjSIG+b06zbpd7jI+fTmQBOr7gxrC6KaU5
	6YDc/J63LkNhxw950OW9+oUgkOx6fmpdCRcPP2pyF9baWuKI9bN5OOpULK9Ti7y0z06YgS5Q92k
	fg3SyQvUzrWBSGFekY807k70Lmq7YPI6DVhiFLDHPiEJnib7vx+E9a23bfnNVRnRZ7PIOYIRmfw
	IsLf91bb+N3+B4LLCPX4/w3jFPuzTwbzUNrgkw7p29n+980wFtpTJVylRVZ6FmzNYn/VwmZORY+
	xnldiR6crXcvM9pIzwHRoR8d9gh5PNWWHOZ+tLZpRM1/B7j55uxxhqc2CB++VUNAeyLT22TO8q6
	MvdbCDAIs3LU4XbbeBH9kwqTPRebO90I5
X-Received: by 2002:a17:903:230d:b0:234:e3b7:5ce0 with SMTP id d9443c01a7336-23e30384570mr133419905ad.47.1752945722048;
        Sat, 19 Jul 2025 10:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvDdJW6YIr1ZYHpaTRpQN36bqxM/GTcxkOqpcyyNNjkJ0nFfayx73Pq2oYbOIAbABFTcfX5w==
X-Received: by 2002:a17:903:230d:b0:234:e3b7:5ce0 with SMTP id d9443c01a7336-23e30384570mr133419665ad.47.1752945721571;
        Sat, 19 Jul 2025 10:22:01 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d8825sm31331245ad.169.2025.07.19.10.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 10:22:01 -0700 (PDT)
Message-ID: <1cb5c9e8-9894-43e6-ba3b-755a7d1dd56b@oss.qualcomm.com>
Date: Sat, 19 Jul 2025 10:21:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bcma: Use managed APIs
To: Salah Triki <salah.triki@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aHvFi5PMXFxGwd1W@pc>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aHvFi5PMXFxGwd1W@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4pnnwdTNrU4b_ulhoklCJ4V51f2DZ_4O
X-Proofpoint-ORIG-GUID: 4pnnwdTNrU4b_ulhoklCJ4V51f2DZ_4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDE3MiBTYWx0ZWRfXx0LjM67ZYtsc
 E9AskvRiWd41KzlMNFsjJregAz9Pm5KEZI+DfyAt6Eozr7HN/IM++we1x3t5EjQpOTFOEKZr2rJ
 MAKoFmHcDZSD/lNcqdTZfE+jE4kKEQeqggnRdV+bzbln6RwW7e0z2PD2LI3qleLp+0ceIN732L4
 SAdK/ahK2afg5UFUgfDL/QqqDAQtVl0PUiEDSPcARYTdqWPK/x4KTPzyPXtbHGg3O8ES8iAeqgb
 4i7k2dzJ2yQlImkpt7yMd4ZBIm7g9M1d8TSrsbSvK/BTNjQhK8zMuYC+g3j1JCSIzAAIkkJ5Q2h
 DS2IRpdwYSQJHCbAhLsXBWUf8qWTarzLk/aD2yU0bRlKdj8eEdwKcQM3uxGgHyCCfEoeF6r340R
 WLEAwa6NDo3KhQiIxo7sMINe8X271qPaCNnGG1dWeYuhu+lL4mOmaok1B4ImO5wIbD5t2j7i
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687bd43b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=C54rZm91nIrLC89xkaUA:9 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10
 a=xa8LZTUigIcA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=887
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190172

On 7/19/2025 9:19 AM, Salah Triki wrote:
> Replace pci_* with pcim_* and kzalloc() with devm_kzalloc() so that no
> need to worry about freeing resources and disabling the device.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Tested-by: Compile only

1) When you post a new version of a patch, please do NOT have it be
In-Reply-To any previous messages. Each version of a patch should start a
separate e-mail thread. The guidance at
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers>
seems outdated.

2) Most maintainers will not accept patches which make such a big semantic
change without actually testing the change on hardware.

