Return-Path: <linux-kernel+bounces-733811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C89B07944
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F287B8E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30182620FC;
	Wed, 16 Jul 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e+gLK6Uh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48B1F4717
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678806; cv=none; b=Ot14+/eJ/TxLbjQMM7vrSsODmN2ny4Qae6VcJBQ29My7lphpERmgMtLbWNjy+QsQj7fh4EPoXfJRALAgHA7NHEXus7i5huosy7fLrlmqJUxmoQsKFCSbhdRZYfDdjt86WGwD3gNtEu34vU0xbO5PTreKqWdTFaT9AWTFFVLqyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678806; c=relaxed/simple;
	bh=LVR9w/dUpPReGresRYLtdEMlsGIW7JaY3/r6knRbqZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su4GONFaWuGUlmjojnbIkkFNyIFcTz2mbsYwQJXDG3Y90ojk6YwZYp0tplj6YuZcSn7tLJI2aqA5jGAkWcwyXzedJccu/EcZPE7N/g7lb/zzNgqK5EENEHfiy9lljMeXqRhBLvV763PT+4n/IoYLYL61ZiVyAlqzORm/kGLuTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e+gLK6Uh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCrfav003277
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CtwVruHuIm50LWxWnF3hYBprC3Esh5tU1YhwYPkVmYU=; b=e+gLK6UhreOYA2Aa
	xtkjKj494E6LYe80ZfIfNJyd3pt+AB4+S7gZ7K48X6MuljSxX99DeoPz0Ng5tQsi
	UgPgvZB3nmwhm2oOQ8iA/aot5exJoX856ekXbPOZskao02kIRkA3+87oSBXiL9W+
	ALRrom7w1/khEkQayc0zVpCbCfQhHr/5oS2UJLakYyEse7cQ9IGDpkY5UC7ClauY
	uDIHQMEI/UotXcNnxnk+AC6CowmPYRbHxAhgx+EgLPib2wPXDCtoBhlde2JGfI2p
	o+GxVJLBBIkK9C2jTdxQuqqfUMqZgPcmXqigR/VsYLajTcSNQvbM5AxpZND/kLXS
	EOxzbw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drqdax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:13:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3bde4d4d5cso3093919a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678803; x=1753283603;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtwVruHuIm50LWxWnF3hYBprC3Esh5tU1YhwYPkVmYU=;
        b=mrSW/kwt5ersDm/BtewzHsk858SAdyRgZd699p+aguAh6qExlwTLeTErDVtzjVJ3Mo
         7m8EM99VXwi4o2sVYPD02wYnqnGN5i/FGkUm2ui91u/uOtLx6FUkL15el48hgu35xdMo
         0U01X3/5NO7+OEGc39G4usQozmcOqNx4DhYEEzQ6Ba2acPnqS7Igv7S+8S9f9re8R7I6
         IQiZG/WRisXCMTKNphM0kuTPFNgFJiufkLremWPqFAUVRAahHIJoDXsAO2r/3wVeBLPv
         29qAvAqsidC87g86JuOaInaj/RGHJwmgn7e9DccLfIYX+gElUMrlvoHHHBitQPnQjchk
         3FuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXJQ/id5yXtFA3Mi7d18J5T7U/xmNeLQy5/i24zLkXzBRgxsxhfQAXi6fZPY/wdDbUNHV1Y05uKr17b8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4q+FD0zLIBrE6VFrY/q+BwGC9BU5fBIucUGdcPy63Ik2YuSs
	EWw56K2mpMNyy6IMebbfgaTpSok3A9jFm9whMrdEGO4Y8bUuPep2GlMbXGB04An7amQRBTfV7wA
	2m0hARyxc/c0cvf+dOauNltn5muAw5PlyCJjDSB+WViXW76i5OmNMj3C5sW/RWAR67MA=
X-Gm-Gg: ASbGncslagEvQocezSJxYJtK+FGfsXlWcuW4E/F0k3TIMDL94Br0JjA7C6sCX8CmwrT
	rMi96Nw89jJA5eLoARXc0TSUhl8AI3yRhBsj/4VwGswXxwP1Vb7RVEQ5Q90wVP67vV1KLN8bpgh
	DneylaP7s+MMsfh7JwZAUCGzq9zbh2VgETAoblDW2bbR78fgMatdmIcXbUaKNaDSwDSjh7KBH+g
	tSrNkm2tdmwUF8g5OFys2SdX0PDDHo5Kw5EEgG4gpjG3NXbfBsGD+PFw/fJHf5NYLfbpkFCf5O7
	niqcNLab+oROQNt4SZTzCWE6YKagTZIXSj5lyti4+EmGopfuH7TUKht+60HMP7M/NL9Ia5JtbDO
	LWcNY6aifFt5sMoxc198=
X-Received: by 2002:a17:90b:530f:b0:312:1ae9:153a with SMTP id 98e67ed59e1d1-31c9f4b4161mr3809054a91.25.1752678802565;
        Wed, 16 Jul 2025 08:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEblc3jY+0h7Aosh+m7nUh8Q/00sNNYAVcErrYvNH3JTZ8WRCcrDKpFARGnKRnqDBN3kK5TlQ==
X-Received: by 2002:a17:90b:530f:b0:312:1ae9:153a with SMTP id 98e67ed59e1d1-31c9f4b4161mr3809025a91.25.1752678801982;
        Wed, 16 Jul 2025 08:13:21 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1ba96bsm1582569a91.7.2025.07.16.08.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:13:21 -0700 (PDT)
Message-ID: <833ce5f1-51b2-4d4c-a839-38989ea10344@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 08:13:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] wifi: ath12k: Fix endianness handling in QMI
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZkzJD-FQKiMAk7Aoa3UwNaPiSpwRHids
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=6877c193 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bi_AWBljq3a5P2oXxVQA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: ZkzJD-FQKiMAk7Aoa3UwNaPiSpwRHids
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNSBTYWx0ZWRfX886xyDPGMGBw
 U8MsT2N3H0aPPLYEaKd6ZY2QhTSYKHOldwumq6RR+VhnrmDcNQKDT9JQBFRbZdzOJRgB2YhfIPh
 Zh+eL8uhBGGzRXkkD2hDpIF28yBh7DjppAIaitDE45x6Sft0SVF1vwvxC8K/xc1TDipp7bH0yKg
 Sv/ICw4GY2KJ5IZrd74cBzip0nSW6z6U7DMLal3IwLiGiXh1rsA3hMN91usx32cHYCbrYR1NrHt
 wk7i28Fr7jX50C37f8PutTvtTC3ffCE6oy6Rl8sQT9p4aSqPkic456cf4+pAArIkCsx2Gy+wUs/
 wiQtMBJjFwio1izbABns1jFpdZZE+kfb+wxzqP8LyUuYz6G5yG+CDXoN3dhgYosNf4jSC4gCJYB
 2x4s37+rCkEqiF41b5ypJ6JxvLa0NF3X7ltVyx8d5npxUAs2+kdjh7w7oevUScIeG+uBltzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160135

On 7/16/2025 12:50 AM, Alexander Wilhelm wrote:
> Fix endianness handling in QMI firmware transfer on big-endian
> platforms. Without this fix, the firmware download fails due to
> misinterpreted data structures exchanged between the host and the
> wireless module.
> 
> The issue occurs during early bring-up on big endian systems, where QMI
> messages are not correctly parsed by the driver, leading to failed
> initialization sequences. Ensure all relevant fields are properly
> converted between CPU and little-endian format in request and response
> messages, as expected by the firmware. Attached logs showing the failure
> before the fix:
> 
>     ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
>     ath12k_pci 0001:01:00.0: boot pci_mem 0xcd4148e9
>     ath12k_pci 0001:01:00.0: pci probe 17cb:1109 17cb:1109
>     ath12k_pci 0001:01:00.0: pci tcsr_soc_hw_version major 2 minor 0
>     ath12k_pci 0001:01:00.0: request MSI one vector
>     ath12k_pci 0001:01:00.0: MSI vectors: 1
>     ath12k_pci 0001:01:00.0: msi base data is 0
>     ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
>     ath12k_pci 0001:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/firmware-2.bin size 15134776
>     ath12k_pci 0001:01:00.0: found fw timestamp 1722934582
>     ath12k_pci 0001:01:00.0: found m3 image ie (421880 B)
>     ath12k_pci 0001:01:00.0: found fw image ie (7229440 B)
>     ath12k_pci 0001:01:00.0: found dualmac fw image ie (7483392 B)
>     ath12k_pci 0001:01:00.0: found firmware features ie (1 B)
>     ath12k_pci 0001:01:00.0: features
>     ath12k_pci 0001:01:00.0: using fw api 2
>     ath12k_pci 0001:01:00.0: dualmac fw selected for board id: 1005
>     ath12k_pci 0001:01:00.0: Assign MSI to user: MHI, num_vectors: 3, user_base_data: 0, base_vector: 0
>     ath12k_pci 0001:01:00.0: Number of assigned MSI for MHI is 3, base vector is 0
>     ath12k_pci 0001:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
>     ath12k_pci 0001:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
>     ath12k_pci 0001:01:00.0: irq:18 group:0
>     ath12k_pci 0001:01:00.0: irq:18 group:1
>     ath12k_pci 0001:01:00.0: irq:18 group:2
>     ath12k_pci 0001:01:00.0: irq:18 group:3
>     ath12k_pci 0001:01:00.0: irq:18 group:4
>     ath12k_pci 0001:01:00.0: irq:18 group:5
>     ath12k_pci 0001:01:00.0: irq:18 group:6
>     ath12k_pci 0001:01:00.0: irq:18 group:7
>     ath12k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
>     ath12k_pci 0001:01:00.0: cookie:0x0
>     ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
>     ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
>     ath12k_pci 0001:01:00.0: soc reset cause:0
>     ath12k_pci 0001:01:00.0: MHISTATUS 0xff04
>     ath12k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
>     ath12k_pci 0001:01:00.0: pci reg 0x3164 instance 0x11 read val 0x11
>     ath12k_pci 0001:01:00.0: setting mhi state: INIT(0)
>     ath12k_pci 0001:01:00.0: setting mhi state: POWER_ON(2)
>     ath12k_pci 0001:01:00.0: mhi notify status reason UNKNOWN
>     ath12k_pci 0001:01:00.0: mhi notify status reason MHI_CB_EE_MISSION_MODE
>     ath12k_pci 0001:01:00.0: qmi wifi fw qmi service connected
>     ath12k_pci 0001:01:00.0: phy capability resp valid 1 num_phy 2 valid 1 board_id 84934656 valid 1 single_chip_mlo_support 0
>     ath12k_pci 0001:01:00.0: intra device MLO is disabled hence skip QMI MLO cap
> 
> Alexander Wilhelm (11):
>   wifi: ath12k: fix endianness handling in QMI host capability request
>   wifi: ath12k: fix endianness handling in QMI phy capability response
>   wifi: ath12k: fix endianness handling in QMI firmware indication
>   wifi: ath12k: fix endianness handling in QMI firmware memory indication
>   wifi: ath12k: fix endianness handling in QMI respond firmware memory
>   wifi: ath12k: fix endianness handling in QMI firmware capabilities
>   wifi: ath12k: fix endianness handling in QMI bdf download
>   wifi: ath12k: fix endianness handling in QMI firmware m3 info
>   wifi: ath12k: fix endianness handling in QMI firmware wlan mode
>   wifi: ath12k: fix endianness handling in QMI wlan configuration
>   wifi: ath12k: fix endianness handling in QMI response
> 
>  drivers/net/wireless/ath/ath12k/qmi.c | 149 ++++++++++++++------------
>  drivers/net/wireless/ath/ath12k/qmi.h | 106 +++++++++---------
>  include/linux/soc/qcom/qmi.h          |   4 +-
>  3 files changed, 136 insertions(+), 123 deletions(-)
> 

Frankly I'm shocked that the low-level QMI encode/decode is not doing the
endian conversion. Since the Qualcomm internal tool that generates the data
structures has always generated structs with cpu endianess (i.e. u8, u16, u32,
etc) I just assumed that endian conversion was handled at a low level.

So should this issue be pushed down to the QMI encode/decode rather than foist
it upon every client's read & write?

/jeff

