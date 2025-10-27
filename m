Return-Path: <linux-kernel+bounces-870746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 790AAC0B94C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF2EF4E3EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F923BCF3;
	Mon, 27 Oct 2025 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNGRK1ck"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC09238D54
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527671; cv=none; b=l5qFG3GBeAR8q5YI457wIqjpoKV+41SN/8AeSvNhGlFM9rkzDEamLp6jWttkxYSGSH7AKAGb6MLeKWUYhOyERsNV61vEnvu5eMbNf7z/rY2XdpM2JpynPUnURx2Lrrry64sCE70xmn6rkiwow21TsO69NIwZUjdIGmV4h5JuyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527671; c=relaxed/simple;
	bh=26Zr1IfDLM2HwHhlkPk74AD4l/itxa9AB7lNv8cLE24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tVS7WRcgzl0SlhXLzlEWP5KUFxp04CU7lJahVNYWqUt1xSUZmL4VZHMDAitMH/g2v94n+VIITEg9wMcUE8Bmvg2L6EHwkK5rWWa4iie3h1VQ8f55lkc0f+FBwlkqzi/ZDyOGwmqfSwAkkLvDZiBW9CloPaFyanySXpNHFEeNzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DNGRK1ck; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QL01Fj783388
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/6bjhQSOqx9D1Tl5pyAATW/nu6ENMdIgZuft4+Kzf6g=; b=DNGRK1ckf+y+TIL5
	vsUrDh8XWa45d+I4LKXOE8NcC4Y4t9tbHiRXX24RlWBdqva7/bvvLkSnUSECVmJx
	lOR2rCLeZi3WxxX2DcKOTfdRRTQWS30NYNpCq58Ud2E5hU4238je2e0FmK1hpW1Y
	bIKiYWJnWFphbh7NxgAtH/4sWpEZgf+5yC392KGi237aFcY3pl2Hb9X/rmjHBS+j
	6zt6RD586fFrX4qWqb3uA6yKNXWib6S/UndXImA330Pgcc42izLC7p4kZRXHmQQZ
	Jx9mpXsLWR4TFF2HwW3mKeXTgredgX84Fg+WLZxfGFecaA2o3P5zDdQnS02LQU33
	3LVtmw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g2tfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:14:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7900f597d08so2970414b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761527667; x=1762132467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6bjhQSOqx9D1Tl5pyAATW/nu6ENMdIgZuft4+Kzf6g=;
        b=FhvKQ8g2p8pBT4Gf8+PAfko0zTdE4B5PLEJFctDEXYAbCgNChxPEe+VVHIcq28G+EJ
         BscN0BgBM2QmlWckq/+OrNuKOlIJzoldKyuavOQwCQ/UvMKtJIa/GyFiVeWHMVW6Dl9W
         0PfwHeHeH+QPfKHaPy+zO3rUPjHkIqNndxGw5W5dGpg++J1FXGHrkBa6YMXKgpDGl6Gp
         Nt3hDFUZginrNLU52TO3prbTM9RZWnCAacStrX+j5I0K9cGBHoNYA+sVMMf1yeKFvCjP
         pcminQI/sdXCRiCNSFf5YbTCG45j8RFkgUOmUFtYFcESSHVaQLs19NyCKUPDDHQGPWvF
         07+g==
X-Forwarded-Encrypted: i=1; AJvYcCUaEzi7rpAcI3SA/I6gJq/DL3hz6z0L1TwTvUprr2Zn3Cs6HpeWp8IY0/zy8Jet8jEcQz/0azhcJAyqTvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyj6OAKbTK0o/BiTN7W/setlfJJFDpftT8Hyb3zbcqu8v7VYnR
	U7y1mnbTFt+ma0iEv2h2QLrKfZDYJESDogqO4STP3WeQ9J1YAMVS58e1ID6FQVsdxOPK1146obs
	FHncmU2K2a4O/AxJzjDTNHttGZd/yi91Wy4jISvNqLvdH/r1IX3roDalWM3b6rmbWJPwK5doG+d
	TbmQ==
X-Gm-Gg: ASbGncukyKx+D+9MP0omFmRRqbNbvEItDDsnaqVRSKVVpK0ptLIqd6NBL065LiDB+Wb
	iXcEva75UapQOnvuo/kRZMLO75SQuie5hgByfaOpLbRTthn9xgK01+0gws+m4qms/SUScTGiD1f
	VJeGe2rQL8NpfeoKEaW3ppBe9nm1b+imqWUAkaAHWX+7QUhwUC3XOSrHy4sowkEMGh/8uDr9lCP
	5mJMRg1dJNXsXL+zJCc3fnvrjU1f9lSoR+KjKelB/fgSc3qQxSHVszMHdvo+8udRY7FqCxjZkhr
	fpX9l4xsZL+xnByBq4Dr8TU7XAsN/xM0d0YpzmUclYTW3D9fnFwlS3TmrUEIXHbmjbGOJMrLrLi
	4SQ8T7eRlR1Rmkqt7ZFplICmct4lRFAR76XKnfSBRPu1097oPDwaT1I1HOE/p1QaW
X-Received: by 2002:a05:6a00:4fce:b0:7a2:7da6:bc02 with SMTP id d2e1a72fcca58-7a27da6beaamr13311899b3a.21.1761527667143;
        Sun, 26 Oct 2025 18:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF32JqcgNw2EBOJY022swQQnuYAkI1zM/sffyqHmGk+kPX4EtGMw7pwfLHomvFqdSoHf7H4Kg==
X-Received: by 2002:a05:6a00:4fce:b0:7a2:7da6:bc02 with SMTP id d2e1a72fcca58-7a27da6beaamr13311872b3a.21.1761527666633;
        Sun, 26 Oct 2025 18:14:26 -0700 (PDT)
Received: from [10.133.33.212] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414072492sm6066360b3a.53.2025.10.26.18.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 18:14:26 -0700 (PDT)
Message-ID: <b5762a05-8b63-4354-925e-fa3c8296e19f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:14:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] add sysfs nodes to configure TPDA's registers
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0Nw_9JaP-ODazO_oa8RegEK_oquNkFv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAwOSBTYWx0ZWRfXxoNEznR5Grp3
 tps5yp2bRTRwZFGBmu26K6JUcayQY12VqINUoKXnqv07x5mUoYBU/v7n8mv6rJ65FyXF2e+LK8P
 h2O+KY88rid6L7gcPrmVZ0d592P7jFg8beMS+bFoI2ioC1YLq6rDe+HgD8Y3yA58tf8fxRzfXDc
 oLSMvG8AJp8GMZ8DaU3myA0d7o92uQ2pWT1JhzVGdVlM7DFTELf3RPr2Sqg6ujkQxyi8ioCf54T
 891qUuEkQjGi18F+4lxae5vQHKrZLNfnV0X837CNxOqNKZ+qnWt6clkkJuU767st5lTpuK9u7++
 YmyjzAFUFH0602b5DfIp6Bkt5ZEK/BZVpuqa9NQW+cxuplwQoDRT1XRqAr0xxONOS/l4eDMXYsc
 uUKRbS0CCsxREgoK9rH23S42s/MI6A==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68fec774 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wn2eFai33wK1SlCS9xkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 0Nw_9JaP-ODazO_oa8RegEK_oquNkFv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270009



On 8/27/2025 6:55 PM, Jie Gan wrote:
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

Thanks,
Jie

> Changes in V3:
> 1. Optimizing codes according to James's comment.
> Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V2:
> 1. Refactoring the code based on James's comment for optimization.
> Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1-jie.gan@oss.qualcomm.com/
> 
> Tao Zhang (3):
>    coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
>    coresight: tpda: add logic to configure TPDA_SYNCR register
>    coresight: tpda: add sysfs node to flush specific port
> 
>   .../testing/sysfs-bus-coresight-devices-tpda  |  50 ++++
>   drivers/hwtracing/coresight/coresight-tpda.c  | 278 ++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  33 ++-
>   3 files changed, 360 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> 


