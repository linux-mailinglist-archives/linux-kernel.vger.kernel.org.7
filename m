Return-Path: <linux-kernel+bounces-887816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9AC3926A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C444E8DC9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650842D541B;
	Thu,  6 Nov 2025 05:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRc3ahht";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8Jb+feI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D4241663
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762406473; cv=none; b=t8GkzBdR7NRMNUEliMxpmVuSWtxHt0gqVSWVP2qAqX9Of1Q6Nif/3DnmlM6NaA8FqKFE4kjV/W2wxtm2NcJmKYo7JFcjcalq3IjusN7EX794v7QxbJs6AhhDN1B9vV9I4z7InQqMRlgFexfNYVyloe/HgLF5JF8lXGREJrWFeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762406473; c=relaxed/simple;
	bh=p+qe00afHvbvaXXEGYxAPPbKvcvlSaRRzwMcBzB3Bb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3PtW8SWb0l9PTAwOEUZi2+GcWy3uFtVDSW7gnWDPWtBz527YzK+U8njAPb0e/5vF9CXcfhmHfmpKji/qhgK8jAP/l/4lwP5O32scsUQiKS9VUVZsZbfuai4g6kGOVwl9Nsa1bOSRy3AX4wucE2Kzx/U4XReE7LKWJ3ToILFSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRc3ahht; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X8Jb+feI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFV321785434
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 05:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ij+zGrZP39izW7VSXxtNQBt2rAsGHOP1QJw0Oj7RuU8=; b=WRc3ahhti01mP/nS
	a0ZZsrLbtQVZqgGsDbJIRcegLE45S/8NII2PJ4J6egoXAk1eUpbMbArpEzJlVNEE
	yJrIixgUQ6TQhB1Os6qeGhK/SFL/u+TmtGKfjFah+v0jrHKg5cYOvZxq+FzGsqp0
	/GFQVq1swaEkRKJWVyr+iAm8QM61avcZjXdLoauOIKrMsaa0FSECT0Zu3HgwB+Nc
	EXte0pFxKeHbjEx3FlCYTiiQCKLoUXFVtjrpBYRmdpu/K5QBhaEZBgvKtbmrqoLT
	WGJdPfWj5+Q2diNGiPiJfWIDAJseEmjvNRHO82qEFgk8YE1RwRcp/mCbX41cs12F
	pn8+vg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8amx9v2e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:21:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33d75897745so189386a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762406471; x=1763011271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij+zGrZP39izW7VSXxtNQBt2rAsGHOP1QJw0Oj7RuU8=;
        b=X8Jb+feIOzGxes7fos+l3hvCIINIdnV/CUtSGqtZEur2cJriP/1Pb+zejdGHCXzmOp
         ZyeNd65jPpkS8sxYXVn6ojtlov7uO9pQtPGkoCB+kNxrxnOSVdknjblzbGcaXJXQ5cJv
         8gqOBFSo+atOotJ0sxixViGp7i36dWnCKUHkeGklB49V43+ThfnIZ+1BGkreVYRhJyuf
         VfE9S4Qc8nDAFGy3GbYvwr/vxPe+vnLGas/GWWry7oy9g/dWCeyPNFTUKJQJr+WrLT52
         5vnpsJw1YDu10NtjwxW31z8FGgIyYP9cqN8X3I4WBMljU5tEP+Q1xdB7RUT5uIWxLuip
         D0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762406471; x=1763011271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij+zGrZP39izW7VSXxtNQBt2rAsGHOP1QJw0Oj7RuU8=;
        b=XCZUrBwz9iXMEd49dM3cI2QXpe4Lex6sKPN2sx/E3ETBXaeIqm0CgKQpB/ZRyJT7rP
         vtwJ5rZq0Ah3DLt4XqLnqJc/aoZxSeLiIW7Y8iRExBqww6vngA6fPYqreaJUZoRO6JN8
         22TxEGENGaYgUvOp5kxNLBraus6vLZy4D4sLd7kCawA+4mPzjWS1OxcuBtLJWHGD/oEv
         AD0YniX9YwTnBYfSZGwelZ3SVZOFsmLn743xr94zUE8ONS5XA5gJgBchhnNDYJFRPycI
         QPe6ZIhRezyRbcWPXKPhxCJKopX2HM2Ge4WVnD5zcgDgvq+SO0KI9YCGWHR86uH7R/Pj
         iBog==
X-Forwarded-Encrypted: i=1; AJvYcCWo0FnMIw4gaoANtfrXg7KFVeCCEAmeyW/WAwExqt+Wnvut1SnfnJ9K8rLlKt/L3Lulc5vFsjZE+Ocdua0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5tZXirqldbYWU3W1DZkwUjNMcQpXwdqF3SOwTmyIPIXIuyKR
	OuyzqVdaL9sDOxUTH5Rum5CUPY7bTn151HxqvM7L6JaFJ0NbQfZIPLVBpjeIyp5N+6S/f+QYlXV
	+86EeaSxuLnNhdPdpWGXDymQQFzG260ruH7fJ5kyq0BvT5hOmsK2vL6AsL0VdIlfyDS0=
X-Gm-Gg: ASbGncvxRmHUg28v/SPi2rQssW8ffPb3d772wJ+Zal4eu6QiVWRgSyZksTElqUA2f01
	6R0cb9ZTFubku9jCOMj5O5C4q8gCgnmYOdZrBZ+D4hCRZUPkDArn71/8hcQsT9g7VdGmX+FyvNZ
	8D9LhGqE5StLgR13cogfa1gSY4yGSBWOw+73iWq+jxoEt0NZrpRrAvQSvS8p/b67RQqFcH6JdCK
	w7JL2/crHEQk/oBTeW+ZnGzxC4vn7GtMx87YKI01TWT8aiG6o7yC2HfwuR1Qv4v17h1MmYB7hMN
	CBYcujAnH8aLrucXdxPLnE2T8xLCRzoF1SBLe2mXwPb7r0e195TOZmOfCPTIPcFrBqhNB2g/qjG
	xUeH4TYrsJnqJig/gfuAE1wkdhXcbfdHhrUHZ13yKJ6ECtkMIp4DwLbMt7qAtceW/
X-Received: by 2002:a17:90b:3bc3:b0:340:29ce:f7fa with SMTP id 98e67ed59e1d1-341a6c38b41mr8663450a91.7.1762406470763;
        Wed, 05 Nov 2025 21:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7dLThSEW7j05wmchUfxTaYUv+Brm09rxPqitt04qLKdRwMZtVg1+BzIzZC/EM7YSPdrXh8A==
X-Received: by 2002:a17:90b:3bc3:b0:340:29ce:f7fa with SMTP id 98e67ed59e1d1-341a6c38b41mr8663393a91.7.1762406470221;
        Wed, 05 Nov 2025 21:21:10 -0800 (PST)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed21f6sm1151495a12.13.2025.11.05.21.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 21:21:09 -0800 (PST)
Message-ID: <427a8b79-075e-43d6-b580-510f99f547c9@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 13:21:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] add sysfs nodes to configure TPDA's registers
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tao Zhang <tao.zhang@oss.qualcomm.com>
References: <20251028-configure_tpda_reg-v4-0-23000805d21d@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251028-configure_tpda_reg-v4-0-23000805d21d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MTDMxgTesyqOMAXU6ErrzeYjckhLi8nh
X-Authority-Analysis: v=2.4 cv=P443RyAu c=1 sm=1 tr=0 ts=690c3047 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=rf22lFbXz3lptHW25oMA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0MCBTYWx0ZWRfX93bIfjvy1LFZ
 mKWtBAn12K8eulBJZM8wf/+7hx6fOZmwqxB8LqXzeQsfdUnXW1lKSiCv6P6alU6VqMa5o4N3c7X
 8diTs9K1JDroybAD+ulLV4phOS+fhta2bxa8ydXL8cNsHrJYwY0frYig7Gj4bTsy/gvNIXWNg50
 mc8brQTD87pGsVnuosLgfj1DnVA+KF1mcmRcoYpQJc0KL4Z+JeWbokeWt16q4sQVuCUfVKdpgXt
 P02S3nIMrjMXxeS3124Zoo7NCoE2QY+qnVUQ3C71D9AjheO4kSwbOx+YMAV+dBwOG79SO8APJSV
 1V15AbKiMxZzlziz+lIlmmrRKdKm3B1EuwXZ2lYWCes/QMk7FZdkK3xbGcu/xQIWwGjFFRmgUGq
 Jbs0RK2z+W1d/PbuozpuL9IkkT+5Hg==
X-Proofpoint-ORIG-GUID: MTDMxgTesyqOMAXU6ErrzeYjckhLi8nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060040



On 10/28/2025 10:02 AM, Jie Gan wrote:
> Patchset 1 introduces configuration of the cross-trigger registers with
> appropriate values to enable proper generation of cross-trigger packets.
> 
> Patchset 2 introduces a logic to configure the TPDA_SYNCR register,
> which determines the frequency of ASYNC packet generation. These packets
> assist userspace tools in accurately identifying each valid packet.
> 
> Patchset 3 introduces a sysfs node to initiate a flush request for the
> specific port, forcing the data to synchronize and be transmitted to the
> sink device.
> 

Gentle reminder.

> Changes in V4:
> 1. Document sysfs nodes with correct kernel version and date.
> Link to V3 - https://lore.kernel.org/linux-arm-kernel/20250827105545.7140-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V3:
> 1. Optimizing codes according to James's comment.
> Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V2:
> 1. Refactoring the code based on James's comment for optimization.
> Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1-jie.gan@oss.qualcomm.com/
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
> Tao Zhang (3):
>        coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
>        coresight: tpda: add logic to configure TPDA_SYNCR register
>        coresight: tpda: add sysfs node to flush specific port
> 
>   .../ABI/testing/sysfs-bus-coresight-devices-tpda   |  50 ++++
>   drivers/hwtracing/coresight/coresight-tpda.c       | 278 +++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h       |  33 ++-
>   3 files changed, 360 insertions(+), 1 deletion(-)
> ---
> base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
> change-id: 20251028-configure_tpda_reg-f3396f97f9a1
> 
> Best regards,


