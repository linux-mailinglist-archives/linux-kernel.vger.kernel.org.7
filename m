Return-Path: <linux-kernel+bounces-797524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA60B41191
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5FB189D682
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502019E7F8;
	Wed,  3 Sep 2025 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j0bz4Hgb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7614EC73
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861054; cv=none; b=om/WPu5I0jlhmL+KRhyNOzdLUQr2jbZolPDl/V5sls23xumlGJ3x07Y01ikmCX8TA1OBQ2F8/ofgAGrLEndfPrIx438o2lkfImQrJjiLXOOAc1znw+lqTcL32HNAxbpeD066rBeqvdSP5wSSJcCy1O4neeyj7lUMXTNYQx/00+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861054; c=relaxed/simple;
	bh=KX2L1OSzEQjP5CIuY1OZ0sO7glYqDChLojpPjBEMqF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULdVe7QApwHTNElCdKGGNMSWMk4obLBrGFOzx+Dk0wQn2rotv94EvP36BKE0viNZjtfhyTcmHqTFuhdlMbwedeuAsSvIaqFA3XmNtTUK6xxxqHPEz4KAYSJzrQyGkaki353dlfDB1LJuB9ZIrLxVPTTTMYFUJ/PpHzzcuxcNQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j0bz4Hgb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqL50012309
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 00:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvRBZ8l1soa2w5f7bVMj5H2wpo59ehpd/EgdLHhxglk=; b=j0bz4Hgbhfhw3Loo
	siOeyg0W8pTGzedIHctGIoidzuPdlGDckADqummia5zSpPkuOvVKBlYxVr4LOJmm
	+pEMglmEGv8DcSrJL4FHk9+zzMBLzZW77n2rev0w4Gk2qXH7yyvlpaWBYQvgVt2A
	5AsPLC52K8+gmnRgNbKouk1RM/JKdQMaxLv39Thth2sW/oGcW248/UVhfmpe+UBC
	bIfZq6yxXoGUkklwGacKY/rjj5EGqQSIjCGkURsq/qBAORQ/Fvg0qPZEHm7Rb8Rs
	O2Y7sfLLj/b6ro0DxbxodpsRzFhHvxTd1/nQOAXfdI1EhJNHnk31qqkuE0N0BQLt
	weSkTA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fhkd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:57:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248f7745075so89653525ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 17:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756861051; x=1757465851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvRBZ8l1soa2w5f7bVMj5H2wpo59ehpd/EgdLHhxglk=;
        b=bRX7tyY5aLAf+W5SAbDPKKMmfAykznBjv3kpuSvAmy311yVlZPx0cWkixLegZ5SLGC
         NmMgtLOKursMtM6gI2pKAvO2tBfsQjhpNKTW20kK8s1OvRoEjldEQOLoqoSiHAhSrLgl
         WOwfbdlVApB8xn6NbS7Z4TR123/O4muypU0iiQkWnmk7KKn6UTfhtBub8bqzuE7K/te3
         YwaiSt9cCLXUB1S7EO2CYYy74PilvSRltarok6505VF2LEqNmjLLHpc249dwevfyq9f0
         V3zy5oxsNg2v8twANEpAsxoMywrdhCEt47i+y7W/nsMtGTIOq7TYvWZ9q7gfIrrASGU+
         W9dw==
X-Forwarded-Encrypted: i=1; AJvYcCURrCwS6gBDn/EVkThb1LNBgR4DD4m9lx2bRSFea2pAoV7mF4j5tFfHT8FaDmwofVYucO8QBNxzKDxaHKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4cfYAWPPR54v32PrcMs1Zs61momjqbMKSxrQppvh/UPIp6mLe
	84mbKjAl6Mmq37R129kzQeo4rU8W6LFnJPU+W+JMoS+VggLLTmvt/ugx0TT/MZkBjy09t8L8pXy
	pqytk7t7lNWGgW7QGRu3D8Rsp9WZ9wPsdMyaMLZDp6pShbQOizAPdDsroG5yk8hDkaIs=
X-Gm-Gg: ASbGnctJdFfvteyH3/raBDbOYZXk1vAZX7zoApy7IV13WQtm7dbH944qAar6K0uUkvW
	Fl5D7boLNJ8yYcvEpPKyyYMWXnQ3/R9o/qiucTZjps5dOYi+zCLl4rtVP64ODUmCZhMhh9xXOft
	l1+f/szI2cl4V/VV73ygJTKqhNPP+aXshFGCdyhjme1AKbFKJBL0I/WdcXkWCf0pX8pspGvSVuH
	Ghe4mNdfdjBrbaosbCvs9kKN819/ZxW5IFvrNz3h/HuLEbGN121VBbzWQIP0hc2CIdfyozPbqUs
	dfoHfNBGK9WRaeL23HYNHzqFg75dDGPlK1REiH+/78ML4iVMSQDKyefaUkInNf9yYZNTQC79IFx
	4O0XQS2TAFEt2eTUbRVZOcminBE4l
X-Received: by 2002:a17:903:3c45:b0:248:f762:865b with SMTP id d9443c01a7336-24944b196e1mr173916155ad.28.1756861051327;
        Tue, 02 Sep 2025 17:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMWFJ+CC9Sz9EcWuN1L7X1HHC53rBd/UlzzUN3mZNfei+7evwXupqb4deQ1I5sJ5h9nBJvig==
X-Received: by 2002:a17:903:3c45:b0:248:f762:865b with SMTP id d9443c01a7336-24944b196e1mr173915835ad.28.1756861050801;
        Tue, 02 Sep 2025 17:57:30 -0700 (PDT)
Received: from [10.133.33.16] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249144837fcsm135630555ad.15.2025.09.02.17.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 17:57:30 -0700 (PDT)
Message-ID: <1a50602c-6c9f-4bb0-9072-f5a6322079c7@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 08:57:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] coresight: ctcu: Enable byte-cntr function for TMC
 ETR
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXyFlqojAJf27R
 t35SHcRlZUJrVaWNxNXRb+VRIRTA3Q+sXMTVgTzo7knselnr9XkkAN7cpre4MoJSJ2mi2T06NsM
 iLHgiD+xQzBvEHZjvXsT1nocyNITEfBk/0cR/MRB8jxYL7MvF0+mn2ySMmeeRToZ3jajH0qz/yg
 MauzA2mdoJqw6WlX/Q+HImUlME0PfOZ57BKxUP/4JbFCoOydmCvcb1KWMohta5C0A3d7nD7v/Vj
 O3se18kx4nOl1lOcyUDJsKvWMNSyo7W9cJlKQGMWpyZEGQQc7QumYciBF2rDlcMxSu/Spukp32M
 1G1b0dWzVZMDvMLspjpB5ultjxjUS4HE481OjhB1v33MDEleg7jcMoOPqyGOi+vQEturG2ZFUy8
 LWDKNxTo
X-Proofpoint-ORIG-GUID: m4EDFjBUU7jHflsj99rUlkDXOf4547aM
X-Proofpoint-GUID: m4EDFjBUU7jHflsj99rUlkDXOf4547aM
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b7927c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=BaEammc9KrtT-KL9giMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038



On 8/12/2025 4:37 PM, Jie Gan wrote:
> The byte-cntr function provided by the CTCU device is used to count the
> trace data entering the ETR. An interrupt is triggered if the data size
> exceeds the threshold set in the BYTECNTRVAL register. The interrupt
> handler counts the number of triggered interruptions.
> 

Gentle reminder.

Can you please help to review the patch series?

Thanks,
Jie


> Based on this concept, the irq_cnt can be used to determine whether
> the etr_buf is full. The ETR device will be disabled when the active
> etr_buf is nearly full or a timeout occurs. The nearly full buffer will
> be switched to background after synced. A new buffer will be picked from
> the etr_buf_list, then restart the ETR device.
> 
> The byte-cntr reading functions can access data from the synced and
> deactivated buffer, transferring trace data from the etr_buf to userspace
> without stopping the ETR device.
> 
> The byte-cntr read operation has integrated with the file node tmc_etr,
> for example:
> /dev/tmc_etr0
> /dev/tmc_etr1
> 
> There are two scenarios for the tmc_etr file node with byte-cntr function:
> 1. BYTECNTRVAL register is configured and byte-cntr is enabled -> byte-cntr read
> 2. BYTECNTRVAL register is reset or byte-cntr is disabled -> original behavior
> 
> Shell commands to enable byte-cntr reading for etr0:
> echo 0x10000 > /sys/bus/coresight/devices/ctcu0/irq_threshold
> echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
> echo 1 > /sys/bus/coresight/devices/etm0/enable_source
> cat /dev/tmc_etr0
> 
> Enable both ETR0 and ETR1:
> echo 0x10000 0x10000 > /sys/bus/coresight/devices/ctcu0/irq_threshold
> 
> Reset the BYTECNTR register for etr0:
> echo 0 > /sys/bus/coresight/devices/ctcu0/irq_threshold
> 
> Changes in V5:
> 1. Add Mike's reviewed-by tag for patchset 1,2,5.
> 2. Remove the function pointer added to helper_ops according to Mike's
>     comment, it also results the patchset has been removed.
> 3. Optimizing the paired create/clean functions for etr_buf_list.
> 4. Remove the unneeded parameter "reading" from the etr_buf_node.
> Link to V4 - https://lore.kernel.org/all/20250725100806.1157-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V4:
> 1. Rename the function to coresight_get_in_port_dest regarding to Mike's
> comment (patch 1/10).
> 2. Add lock to protect the connections regarding to Mike's comment
> (patch 2/10).
> 3. Move all byte-cntr functions to coresight-ctcu-byte-cntr file.
> 4. Add tmc_read_ops to wrap all read operations for TMC device.
> 5. Add a function in helper_ops to check whether the byte-cntr is
> enabkled.
> 6. Call byte-cntr's read_ops if byte-cntr is enabled when reading data
> from the sysfs node.
> Link to V3 resend - https://lore.kernel.org/all/20250714063109.591-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V3 resend:
> 1. rebased on next-20250711.
> Link to V3 - https://lore.kernel.org/all/20250624060438.7469-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V3:
> 1. The previous solution has been deprecated.
> 2. Add a etr_buf_list to manage allcated etr buffers.
> 3. Add a logic to switch buffer for ETR.
> 4. Add read functions to read trace data from synced etr buffer.
> Link to V2 - https://lore.kernel.org/all/20250410013330.3609482-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V2:
> 1. Removed the independent file node /dev/byte_cntr.
> 2. Integrated the byte-cntr's file operations with current ETR file
>     node.
> 3. Optimized the driver code of the CTCU that associated with byte-cntr.
> 4. Add kernel document for the export API tmc_etr_get_rwp_offset.
> 5. Optimized the way to read the rwp_offset according to Mike's
>     suggestion.
> 6. Removed the dependency of the dts patch.
> Link to V1 - https://lore.kernel.org/all/20250310090407.2069489-1-quic_jiegan@quicinc.com/
> 
> Jie Gan (9):
>    coresight: core: Refactoring ctcu_get_active_port and make it generic
>    coresight: core: add a new API to retrieve the helper device
>    coresight: tmc: add etr_buf_list to store allocated etr_buf
>    coresight: tmc: add create/clean functions for etr_buf_list
>    coresight: tmc: Introduce sysfs_read_ops to wrap sysfs read operations
>    dt-bindings: arm: add an interrupt property for Coresight CTCU
>    coresight: ctcu: enable byte-cntr for TMC ETR devices
>    coresight: tmc: integrate byte-cntr's read_ops with sysfs file_ops
>    arm64: dts: qcom: sa8775p: Add interrupts to CTCU device
> 
>   .../testing/sysfs-bus-coresight-devices-ctcu  |   5 +
>   .../bindings/arm/qcom,coresight-ctcu.yaml     |  17 +
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         |   5 +
>   drivers/hwtracing/coresight/Makefile          |   2 +-
>   drivers/hwtracing/coresight/coresight-core.c  |  59 +++
>   .../coresight/coresight-ctcu-byte-cntr.c      | 368 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-ctcu-core.c | 108 +++--
>   drivers/hwtracing/coresight/coresight-ctcu.h  |  62 ++-
>   drivers/hwtracing/coresight/coresight-priv.h  |   4 +
>   .../hwtracing/coresight/coresight-tmc-core.c  | 104 +++--
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 110 ++++++
>   drivers/hwtracing/coresight/coresight-tmc.h   |  39 ++
>   12 files changed, 824 insertions(+), 59 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
>   create mode 100644 drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c
> 


