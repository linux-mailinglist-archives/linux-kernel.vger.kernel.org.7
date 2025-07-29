Return-Path: <linux-kernel+bounces-749288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37AB14C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F9A16BD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D461289833;
	Tue, 29 Jul 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRWU3Ptb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C696253925
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785510; cv=none; b=e+Du8ral6l9DE5L9CEzgQn7erECUsi+jvI05TaPGoSGmcQP0YTKfhdWgQ/ITsxZfcW1HUDyc/FF+lE+yUYlXVHtyVOne0weWatwhEEVKXUcbRKscMdWeByOZAW2UcHChMsTz+BbtTj7L43yu2EyOoGP17BzafbbjjyL69EcyYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785510; c=relaxed/simple;
	bh=nkIhTMT+UrC9eByz+KmOqpV7xTJv94wB9jjPbu62Xzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2ucBdSj5cLe+YUGKVpWo3KefuMTwi81xzqLICsF6XGseby5KTIHtuXpfc2HyTzPcpxACbnd6WPhw1auYC6BA3hfw1AYde3DC/il5Cuo3fq+wnNx9/0qXCgsGEuY8cwx1xZEwJyDNfN6QEvsUtc54xIb1C0C55+eaQNKOs96Lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRWU3Ptb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9fRYt017653
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtmyegjcI8dNEuRPjZ2a9kIvcQS2RvGr8n3kcK3eumk=; b=VRWU3PtbcxQuC9gu
	MaJEkZEnEJV3RAq8PBBAtjcoO6HeguUWKconsvL/wuR7hT3lk0YwjBJhpMGnBSlV
	vNGaE/C0E34GMYvLWBh1tKsll9L4U/b6z25SYPbFGgbAI+fwPGRGa6kl9HiP0ITc
	ApBJKykGr+nu2stifb4v5vxqLtdS1tLyMl73qfXw6pPPXk1uKFGEzx8UuVcJ7M5n
	jWY2Twl17s7KhaJRWR+/Tzqy13wUVjLwhUrCxVswcvxAzdJxzgVIAI2A/JZKbKfI
	MSldc266q1FzdLaeUh+dVvuwkYM1KvPXXah0dUOfgXla11gcBl0iFqLOmvsqZTIv
	O9w32A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2fpvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:38:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-240607653f4so7446545ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785507; x=1754390307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtmyegjcI8dNEuRPjZ2a9kIvcQS2RvGr8n3kcK3eumk=;
        b=CzeHz+Tl5GIf4ETNSI6RdHZf5UggYdjhfQUUlcg4m2TcT8f7g9du43rgUhqgPmY+wo
         Ey00E8vExXCnbD+pNgBjYzr+5HIQHt7/TgHtd0an5FHY/1vl4AMVYEIvoXvxRANH1Mjh
         tuGy6aVCGeHV9Xq9+uMVWbAtBNCBb0G5NslNzVKNAp42CUJ4ozv/3XgkxUnqT9FuFZAO
         MQ/zg0bt40/GGrEERCMJAmxdLRmh1f4ez3HhHCs+U/VKdm6VVLhDYMQP1qKsCVtyYV1V
         5ty8Qn6JgjQ0UH9fmdDb9o16euXvAMq7z3xFLThKswCDTLSRBOxP3dLchIvaesFFyIpb
         T5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCV2bfO2vArYgfhwUOk6rVCCHGqCCiEZ1fhnJMtPhXV/uKkVjE+tdcS+Xau5x3qwu2VphDTurxonLgjoiPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVW+5MCb83wJhv04U2PMHWhSOgAC1OT9uytrAyJ1NOWuyhIJN
	TExeJKz4LVK+S+8Nmefviz4Th2qq3XzPTpoCqJCCyiezF2bx3ZZgfv5t0weg4xyLHVlYe3WLvzj
	H/buOf3V1ci5fPL0QaDfnJ419Ds5pCa9RZvTBivrpSmYHayiSHTiLy2OBCQEw8lHUZHM=
X-Gm-Gg: ASbGncu4eEz9ysoj8FxTPXZv5nhGQV4j1E9uBg2b4LXQpETCaxTNjbfs3ylf/nYj5wf
	QISDEk0OWoBlAK3uH6b6WLhdhtSe1eLcAOsvi74nPE1rN6oqNnRcBCnl5TzJSo1X5B0Wp+KsTvh
	ZsulwFPTh03D71gxxyQMQJU3SkGJWBzckDSKsVEVNXLB9KKyaLYDJEHMyf50oWuW/N52e8YMW2s
	tSWdDoc/ZsLEmIyxb0cm/PtIn3lYYzTzid9A8xSYk9mvWP67PiP7T+KL/aNVBBJKzd8B3p+Cr3J
	sJ/wtqBnQseFDuZLKVcNaOquAjYyBVxSvmGS3sjwmg65gY+aTqaShAre9bDLqliHBJw=
X-Received: by 2002:a17:902:e94c:b0:240:3913:7c84 with SMTP id d9443c01a7336-24039137fc2mr90885135ad.4.1753785506684;
        Tue, 29 Jul 2025 03:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKmIZt9Z2VjUyNjAm78HIoNSL4gDkCwJzYsVcvwijgXYhzs2L+GPUc8Ve0bspPFS+fb7csuQ==
X-Received: by 2002:a17:902:e94c:b0:240:3913:7c84 with SMTP id d9443c01a7336-24039137fc2mr90884905ad.4.1753785506263;
        Tue, 29 Jul 2025 03:38:26 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24009b8661fsm51264915ad.126.2025.07.29.03.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 03:38:26 -0700 (PDT)
Message-ID: <81a1bd2c-ad4b-4042-9116-c1604e4f0d98@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 16:08:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-qcs615: Fix gcc_sdcc2_apps_clk_src
To: Richa Bharti <Richa.Bharti@siemens.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, srikanth.krishnakar@siemens.com,
        cedric.hombourger@siemens.com
References: <20250729094943.863392-1-Richa.Bharti@siemens.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250729094943.863392-1-Richa.Bharti@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hTLthmJNHl2csOXiMre8vwcb2yFZgBCo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4MiBTYWx0ZWRfX868co0bRnHRY
 bhj1/Nhsu6KzqaLGuYX7tiHGC6kP/cr7paMIoQyA4AdhwtqJsWf+p+FIB1uesQBM5nEUxozxNxz
 uE3OHocNXw+37DJX7YL/IUT6ziPJOrYzE1g1y7aKiVyxLFQNmme/o+hZJ8NQ47H/5zh7WnP3JLZ
 Nl9JOY4KqOzsN2W2QPsEPAk4s+U4OQxQZh/TPvebIO8ULmdWhd2ipGFdrI/xDDS0m1+p78SxVmx
 0trt9uwnSkOWe3uGBoJLCb7mwaXSbsbaN3yQTHkXol3N46zUGA9F/JyWEM1mdZYSltuyrrwwYaN
 VQTq5kopNTjtOijhMNngl4qsF8CHp+DyyigOpTkR8udUO2znlJbVxif9H/3Uve1s75pIEeMwBDV
 9VeabYIELfVcPA4CObC0OO/Bcf7lhcJr2BX/0cZ6mQoADyDb1+mIwhH5fUfzREGmj88AFBji
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6888a4a3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=a_U1oVfrAAAA:8 a=FtIUmZvm79rvchHu-DsA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: hTLthmJNHl2csOXiMre8vwcb2yFZgBCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290082



On 7/29/2025 3:19 PM, Richa Bharti wrote:
> On QCS615, we see the same issue as reported on SM8250 and SM6350:
> "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during boot.
> This is due to GPLL7 not being enabled by default as a parent clock.
> 
> Setting `.flags = CLK_OPS_PARENT_ENABLE` ensures that the parent (GPLL7)
> gets prepared and enabled when switching to it, fixing the warning.
> 
> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
> Signed-off-by: Richa Bharti <Richa.Bharti@siemens.com>
> ---
> This change is similar to upstream commits:
> - SM8250: 783cb693828c ("clk: qcom: gcc-sm8250: Fix
>   gcc_sdcc2_apps_clk_src")
> - SM6350: df04d166d1f3 ("clk: qcom: gcc-sm6350: Fix
>   gcc_sdcc2_apps_clk_src")
> ---
>  drivers/clk/qcom/gcc-qcs615.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gcc-qcs615.c b/drivers/clk/qcom/gcc-qcs615.c
> index 9695446bc2a3..b281f0dfe165 100644
> --- a/drivers/clk/qcom/gcc-qcs615.c
> +++ b/drivers/clk/qcom/gcc-qcs615.c
> @@ -830,6 +830,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>  		.name = "gcc_sdcc2_apps_clk_src",
>  		.parent_data = gcc_parent_data_8,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
> +		.flags = CLK_OPS_PARENT_ENABLE,

This is not the correct way to fix it just because SM8250 and SM6350
uses this ops.

We are testing the right fix internally and will be posting.

>  		.ops = &clk_rcg2_floor_ops,
>  	},
>  };

-- 
Thanks,
Taniya Das


