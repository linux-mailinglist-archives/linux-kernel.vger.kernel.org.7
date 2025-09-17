Return-Path: <linux-kernel+bounces-819853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C60B7CDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB3B2A2A56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C787215077;
	Wed, 17 Sep 2025 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vn0VS5S/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8213A55
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072972; cv=none; b=ZCH+cqE5//DN0t51YlkgaZ6LLtyg8mWO7brZXOu6LLnjmWF6ORprb5sdoo7F++cmwLkSy8yu/h6iOczzGKzCFcUVHdXttwrrEdAt40DqhuaxDuUlBDyTc1ghTrpG7AaSpxVwR4Gfw/GoZgUMt4UDo2RDBF6nbY/hKvzOVGtHgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072972; c=relaxed/simple;
	bh=KNkzGOUNM3E41ugSz21A0/wII/YCjpGTcJKU/Xe1zK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifxOuvdnjiuOOk1/fvh4zrq9SAlXiOevlTWHeUryctxbGiFx8XIXduu5LJdzpEPlvbsy762wMNqS0rFAwRd1vOLjuiR3psAii8peGvlsqWQbcg86LyBvw8n/epuDSPCq7Qe4yDnhp9Mp/YAe7PPmTGwqxdMJVWRxLZbyWuY57sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vn0VS5S/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLaO4e014976
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vbrL7SaMgW5EyV4CgmYacYgOsDFSLKeaecH2Z9zl2cQ=; b=Vn0VS5S/9xi60LMI
	BPmCg7yppM+lRo3rQY+5Pk03oj51L2Hy0iwKvTOy/JxuoWzZ3aaa18tmcZ7Inrt/
	yNmTpkDgAX4IC4RsHxeH0oPJliD/BdKy5V8nzJZHQ3PITso66ew7ysd6HHMhVwga
	FkzRajMOTPSoMBGHgGorxIeip2HVQbVRVV7eox8q6Nelf2NT8Q4jv5LCoigfgDTD
	14aoFEwjFgUE12vdVFMvidNP27DKDe25VZIOJETdNX/VqJ/PkW6q2oVy1bqqphIq
	y2o2ncyYnRKc/o/0TYtG9/U5rWAfO1AmrFILIM7FqSBKDy2M64XLhU4Uu5uR/PqZ
	kZ7LFg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1rfkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:36:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-265e92cc3aeso31567945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072961; x=1758677761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbrL7SaMgW5EyV4CgmYacYgOsDFSLKeaecH2Z9zl2cQ=;
        b=jFPJyDn66LqO0vZpdf8uGCVuYFy9Qlw3wXrmA/pipEK/TriJNwKxJxfihIIR1qByc3
         LxakWCuRQyxliJ3L5eAbhHh9FS0p/D4KbMzeUxDG8AcPq6zXSB+jZ/KZBD3IIDGzqknr
         UmXuEcq0WHl3Kbt09RUs+TJK3XjdK1dI9dQ4ikh8mzkfHGrT8F0cBW2IXxdyXQORy89N
         vWNqSKjvTM3xwNyHDmOAt7mkbswon4GAk5BUdfl/Wu/1njCDn9jSYW6XkcUZ3p3DAMJv
         Ipr/986ijxS7euBjhb9awIC5f9X4VfBpjEkWp6kwj2jzji0sq5JhwCV95GRVC7VUFg11
         Ltzw==
X-Forwarded-Encrypted: i=1; AJvYcCVw+c9NOIkQIjizbtk1heKhC4F8lNBH+dqpcSZgfS+3InsjhbTS0tzAxtoppleIzenHCL1gOnEwVflI8iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+U4M0ADfBV/YeKz+flFfQaIY7I2937yNNhi3zqGJFLqix699z
	sqSCMy6oQkBXIa2B+btGIh9JfqGlsVBdgM0ILNRmg8IayXVbcZOolHgVKJ1WGUKU/Euybu6/Klr
	+krst7IRUcS9XSDnM5Dup1LXyqfGur06mR1ERphb5a7rMtlLTmRxQL+VwWbMQRDotXK8=
X-Gm-Gg: ASbGncty8PZIIHkqOLBcoHDN0pGUUcvbX5pbpst6BeeXV0OPe5bVdKWRyGw368xFi6k
	SHWxFmfGxQH03iX1VcIPHVF1jKHElAQR0A5jJC1RgCOJuoRjQNvn9MvwpdCZyh+LTCOjOTyOMOO
	AXtLIFfT83JaoGWKlJ/fMQyiMv0uvHFGxt4RJd0vvatGZsMGAWEFwXFzVIcNROPPuX+jeD2oE35
	zdUk9J0tlkRNjEvSbe7Uq5PhNWjhS+M/0DM74oAKdyuRc+d5by2ge/I168OfeBOdz8hTAJO8RzG
	nHZLolAvUoTsgcNbDOtNEg0SYHtUadi6SfzOQVHucZhqQGtY5uEAIIwRGQnTISygHdfm323eHSP
	GpmiXXCd12RuQaeUrK/vdGyM8468b
X-Received: by 2002:a17:902:ec90:b0:263:671e:397b with SMTP id d9443c01a7336-268118b9895mr4989955ad.7.1758072961252;
        Tue, 16 Sep 2025 18:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHylmZ+tGvjOIZumm372gek4AXZFCL6OxaO2OU0fsz5O59DxdnMl6rUMyBX4IQ7iysNn9tp7w==
X-Received: by 2002:a17:902:ec90:b0:263:671e:397b with SMTP id d9443c01a7336-268118b9895mr4989345ad.7.1758072960404;
        Tue, 16 Sep 2025 18:36:00 -0700 (PDT)
Received: from [10.133.33.43] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265819a61a7sm81502865ad.48.2025.09.16.18.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 18:36:00 -0700 (PDT)
Message-ID: <a331eceb-ec49-4396-a61d-78a75789b090@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 09:35:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Fix data argument to coresight_enable_helpers
To: Carl Worth <carl@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250916224441.3008824-1-carl@os.amperecomputing.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250916224441.3008824-1-carl@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A6r-2xrzOixhkUFENt7U-PjGjk0kxJmQ
X-Proofpoint-ORIG-GUID: A6r-2xrzOixhkUFENt7U-PjGjk0kxJmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6BqM2sflsebk
 vChaf+Ac/oppU47GQP3wKqoK9ZAbwfBXwJ7RH0fnFqsP5SLLpMRmzJCSqICiwcHZiQ6k7iR95Vt
 aLOGmGnbr65gaUeOtSsdTDOwcUdUc8bUGPWfzGMhz4UMUL34qqlR/QJQTflNFI3+bgmWLD0XYKt
 NQoqL/04YUNyqPieexiEakz+04NxsvT72sV9ATDi/G/ZRcskCAd1vIiiZpaPkjA/lvdyYTo+Mnq
 1mM3+uR+KNTboHBSwAFPYMmPdijIf7+uoVJOlHSQE0HxrmzJWrcBNsJuNL9oX64XkL9u96SEwKf
 ZypJk2g480Rh9JfRQNVJPlA7SpU1XEca3hEdbiPTJYHggt0orblyeEzOOVsPdjx8967i3ZqMuGz
 kT44Wz7Y
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68ca1082 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vzhER2c_AAAA:8 a=6_jK5pOYWtS4egWhfC4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 6:44 AM, Carl Worth wrote:
> In the commit being fixed, coresight_enable_path() was changed to call
> coresight_enable_helpers() with a final argument of 'path' rather than
> 'sink_data'. This was invalid, resulting in derefencing a pointer to
> a 'struct coresight_path' as if it were a 'struct perf_output_handle'.
> 
> The compiler could not flag the error since there are several layers
> of function calls treating the pointer as void*.
> 
> Fix to correctly pass the sink_data pointer as the final argument to
> coresight_enable_helpers(), exactly as it was before the buggy commit.
> 
> Bug can be reproduced with:
> 
> $ perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null
> 
> Showing an oops as follows:
> 
> [   88.696535] Unable to handle kernel paging request at virtual address 000f6e84934ed19e
> ...
> [   88.911293] Call trace:
> [   88.913728]  tmc_etr_get_buffer+0x30/0x80 [coresight_tmc] (P)
> [   88.919463]  catu_enable_hw+0xbc/0x3d0 [coresight_catu]
> [   88.924677]  catu_enable+0x70/0xe0 [coresight_catu]
> [   88.929542]  coresight_enable_path+0xb0/0x258 [coresight]
> 
> Fixes: 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
> Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index fa758cc21827..b1077d73c988 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -510,7 +510,7 @@ int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
>   		type = csdev->type;
>   
>   		/* Enable all helpers adjacent to the path first */
> -		ret = coresight_enable_helpers(csdev, mode, path);
> +		ret = coresight_enable_helpers(csdev, mode, sink_data);

I dont think we can change back to sink_data since we introduced 
coresight_path to wrap 'data' which is needed by the path.

I suggest you to add the struct perf_output_handle to the 
coresight_path, then retrieving it with data->perf_handle in 
tmc_etr_get_buffer.

before:
struct perf_output_handle *handle = data;

after:
struct coresight_path *path = data;
struct perf_output_handle *handle = path->perf_handle;

We can assign the perf_output_handle to the coresight_path after we 
constructed the coresight_path in perf mode.


Thanks,
Jie

>   		if (ret)
>   			goto err_disable_path;
>   		/*


