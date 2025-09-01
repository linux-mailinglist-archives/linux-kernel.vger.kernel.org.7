Return-Path: <linux-kernel+bounces-793664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24042B3D68E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65B1173289
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD420C037;
	Mon,  1 Sep 2025 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm3wSN5m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4619F12A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692574; cv=none; b=qHWRQjiMdYNFn9zaJXUC9pq35mNsKGKEBd7EV1PGfEjnP0YH5EbsUN+GcDkbpJscMIqJUOeUwGTUihuETEN4gT7rY3EWEDxEHZKL0hZd8FR03SK6ax2AM7yl5f7p2jaWaAVJZU1HKd+1JQgmBe7bdOVrhsSpufPnl57mPERuKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692574; c=relaxed/simple;
	bh=FOP26zaTOY1xrPxkZDwQuusVzgnNln+P8abj1VM1Wic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2iTFecmve6Q5zwokzwLp+LJxVj3NeF9KpZ0mQODKGhKju4TBLYpQTb7ic2CFGwP61mNYHwU19XtVlTld5I/a03r7Vn2ewEhvpz+frJEcP7bFcPJ7Xvy8tB5R98ft583EOPVElUzEvPEIidiCszKkhETvINkDzGMMvRIL5vfA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm3wSN5m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VL0J93000844
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 02:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HJFTJhiN+4hmB6UylAdee9vnnn/inlLMUCHrFPbCUQY=; b=pm3wSN5mnW9lMLaI
	66RbTvLssLk0CyWIYOHVGhvzRPbj3mtLll+6fRFFAwNmUslJfGGlnpmmJ4zMAvJw
	fb1d9U6wnZ6rHtTVKaQ2NV5UtP+WWbaGkW766SrVmDhyqGYrwpYT5ZKCpMryQjpI
	wPdrfb9BKhKlo322E4dCNz5xaggl1OhTDOwuaI/Js2Es0b/qOC+c6NDp6L9xdQT2
	oDW0jGdFdGJ2UGF/imVwB8DRXrnkAULUTlAkPaAiStx+wtGK5WolUtakd+rhw7fT
	ZTRLE12IGEq+UB6uIYuFEWHd2bEW8zGk0lrivxRYwdT4wLkYg2SjtLGdls6L4oXR
	Hn39jA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fat99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:09:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e60221fso6499305b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692570; x=1757297370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJFTJhiN+4hmB6UylAdee9vnnn/inlLMUCHrFPbCUQY=;
        b=wfGY79eWDtNUkvAYWq9tBfCuO57wR+fUY0JO4Z2KvDhUjlLWgQxu9/PZ5w44mnHyEX
         g+x1Xw1Pl4hvWwU6GZ8DyPEeO89l1Yrq/ZMqHsBq5l40gYCOrsngTuN7TzTGInXS6mqu
         8fkXHsEjQ6vWEXkFAmXkvHwXVOfkNO4uyzI37sBM4H5hhT7jXMalwaOmnBJ4BVtABMM3
         gvQrjy5j5CWuHKBtF/XFBmLrkNAIQZIUvknRW/N4EagyLwgPiAFX2ExkS4SadT0leRAL
         tPOOotNZnuoTwJ5LME+1UiO6Wu1jqX0mzm7I2XTqa1HLdXAc7TVTyHvc7hiZmd8cSaE9
         kYVw==
X-Forwarded-Encrypted: i=1; AJvYcCW+dABw2WBuiu0KImRBF2LqeD4L702BmiT/H0dAD8cuaJmzoAlOHJwoVFjknOd+ZuQWKZOUoFHSEZ30sY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CbI0smjASSBj7iz+3W0ookHn2pOgv+jLqerOa16xanLCwhvJ
	wNIunEUN7QPZOfiQRZ8p5X2yNnGpdsIGnFCWWM5G0aPqIogT3bN2B/rlBO785umC68aB0oQYPaj
	TXlGtX5rRQkdHA95A1mGj7swDHa5U1rDlVlACO6RuTtwbqwutFaEPt5TibhAxiNCTir0=
X-Gm-Gg: ASbGncsCThK7JpUzEOUoy+6ei24upbj9Ah+7WTQ0gNrGipw2P9NAOJIF+c2qmPpGOan
	+1ER9IPFgTiAHcx0zLlNme5RnlCQznBWmN62iZl9hEbI07tqiih/ACEdZkRYY3q7nK85NQiofYA
	ql7R0XzH0dlvzU9ViIszWdwCMjh2pOCPHBAa0AkschvTodZj8vrJJR9/bfNYZOnU9i/dOaKeGYB
	XgiwJzTcozvwSsdGmd3qbjns/ercLRqIpyj1sQDJqKHXAbUEiMilkszTH6064SOsCjZFmk1YI6J
	CN/wr9hDjfubYtp6KNAS/XNN8Ow+3OGB1quutps/ZrwBCIEXWZRz3nm1PL5uFxh/Wm9s7giyGRZ
	Uj6UfdOK1Ac++Z6x8z4oWq3G8ZX/4sw==
X-Received: by 2002:a05:6a20:7f8d:b0:243:c081:b4a7 with SMTP id adf61e73a8af0-243d6f85b56mr8491254637.59.1756692569907;
        Sun, 31 Aug 2025 19:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv7jJ40IozONRbSG/trocPvA1w/awpQsGYUiMBvP2awE0A/DyTnHq/4z0XXj5ICaPVOFmkcw==
X-Received: by 2002:a05:6a20:7f8d:b0:243:c081:b4a7 with SMTP id adf61e73a8af0-243d6f85b56mr8491228637.59.1756692569368;
        Sun, 31 Aug 2025 19:09:29 -0700 (PDT)
Received: from [10.133.33.253] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f9f7b50sm568901b3a.68.2025.08.31.19.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 19:09:29 -0700 (PDT)
Message-ID: <62773a2a-235f-4894-a570-3496bd8c1c15@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 10:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: trbe: Fix incorrect error check for
 devm_kzalloc
To: Miaoqian Lin <linmq006@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250829120847.2016087-1-linmq006@gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250829120847.2016087-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX8AI8d13TE4G4
 rf0uXyHt7bb3itxHXDv1wfMTY1amL34gCXVmk7zhvtV8HqpA6LgNXjwfveXytUI7//Ij42BMdo1
 xEF4PIixblalS59ttPQ+bFmJyI4o9svTxiakRLADowUS6Auzd885EtZ4JRGp9qmjpcxBaZfzHoC
 omKrmQElzr0HDhZygnzTchz8opi+ShLwBvY2AfvkuKJyY8vi6ouX+8ZxA94RaFP091r84NG0xfD
 hLjAjEnayLKqNlvD+UQ/jAgzOWrLsZZ4m3gP16P30+2EhfneL6+rrOMc7m37bWcL8r1w90ao33x
 hzPOUBYJf5GIcIwM3whYGrIHM5DPAlZ8+hGgDl0KycMZmcMPG58I0Td+652rLwcTiemz7kogBTz
 fANQnldw
X-Proofpoint-ORIG-GUID: 8ruXdL7EMGMPAXgGIEK6wNUtR6vtLiuX
X-Proofpoint-GUID: 8ruXdL7EMGMPAXgGIEK6wNUtR6vtLiuX
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b5005a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=kMyzGuzSTzuwxu01R-0A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038



On 8/29/2025 8:08 PM, Miaoqian Lin wrote:
> Fix incorrect use of IS_ERR() to check devm_kzalloc() return value.
> devm_kzalloc() returns NULL on failure, not an error pointer.
> 
> This issue was introduced by commit 4277f035d227
> ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
> which replaced the original function but didn't update the error check.
> 
> Fixes: 4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 8267dd1a2130..caf873adfc3a 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1279,7 +1279,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>   	 * into the device for that purpose.
>   	 */
>   	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
> -	if (IS_ERR(desc.pdata))

IS_ERR_OR_NULL(desc.pdata) would be better.

Thanks,
Jie

> +	if (!desc.pdata)
>   		goto cpu_clear;
>   
>   	desc.type = CORESIGHT_DEV_TYPE_SINK;


