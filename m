Return-Path: <linux-kernel+bounces-743648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C410B1014D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400161891C43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF658224B1F;
	Thu, 24 Jul 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bdlKtXYw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAA2AF1D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340812; cv=none; b=mMLQkj71QaG0u95UpxZ6XHWrZUO9fzUu99XTt+iNoWpamImCzYj68cdNnSoJfN27nhxRRJfQEdJEtdeCuSro6OnLORXSUbWKsGSIEBpxetcoKIfWME9Mhr3gV4Sg1viX9+xdb7TSK79PJF9Ap+wh5hoOTeybD0oUISyZQutI9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340812; c=relaxed/simple;
	bh=MOg9l889BalL1NxkmWg+3mRYNIkpecKw26ZBBFEefgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7OHxDDaNtl3Emh3t2zWV+j8b33/XSuTqB03chR2dJGkyuJcA3Np7EXNgugJJWDoWs2QDfxpQrU14GHqrVBdAAhy9SggPYzbbaAPbHYp/F+xu1ErUad+htYj5bngf+lmSp/Ra4vJbHs4ZmZXLUurNbiTrJa5rMqeIMk65dfVq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bdlKtXYw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXKNZ018028
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8QZLrnCjykC/+h/YYhXm9p3/5D3IDBg6T9aCMPtCFs=; b=bdlKtXYw8EGkJrfb
	shGhZspzTTcJayrsOIYu/VyeOSF8XE0pSvEIdGZIZvOuxRMIIoHTE12hHwQgm5pm
	n+u6gX5m7cDskQwIWPOx4arnWLrZ1icg/kmbVWHI/EamccgHXYs8msRgaBJSnDTy
	/E7qpp4Z1bZFG8H+HSPeLc9Yqpnh26LSJM7lZ7dvI3C2RqStuI6YokQ7DG9T6uTv
	GB1K8NGbnqDVwa7U2Kb1KhSw0Ndj55ebbbj1JZnBc5z4MS5ZmGitpXpPgAR+OynO
	J7gd4/vIEN6DcQLhAhZ1w/sSgQvfIPtweK+l+ddOVDwHT/KhcDeTg3hCZsSBdWcO
	hULS2Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6swrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:06:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b350d850677so569451a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753340808; x=1753945608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8QZLrnCjykC/+h/YYhXm9p3/5D3IDBg6T9aCMPtCFs=;
        b=p3t/zl6eJVUsFnIN1QOLAKfnW5sKx+5CxR0KUeuRFteKKFTT6Qpx2kslVrckcggnHu
         ps+ctBaTUPPRw4w25e8Uiu/hrzA9k2e0cx6EwwBMK3/rgAeUHwUUlXQPkA5IIMYZMxdO
         UOSDd1ISOwIGSdi5hiQ8Bv5yovk03AcYQgpA6J6fAbhVP1A4K1DpD9xW/yJC8zKP1t+y
         5Ap3/W7TSCxih4JsR54zz3aIsiNXFRQLPSvNLZBCWN+FI4wxSSeGqdiUJoOTmy+jSq7B
         RdavUbdcwDqM03eSAx66pJR1xQNiPzpl7PZDOJSl9uu4gfTd54W/On72KjXLcg0F1Aag
         DptA==
X-Forwarded-Encrypted: i=1; AJvYcCVfIs/H03E+4NNi3PQ9HBhyNoWEV/eA7exay0vO2V70+NdbqBF8R1/BtxVTDKyYX9LGmaFfFkahRWhEfUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GljTkJpOcskOg4ENUYYGjZ08/mgNnJlAVKmJmzZRbR+HR8AJ
	s/tZbIV9Npsp12a3aRHwNKz7frz7x8rr7p8+9T+Q/Q9ZXNEb817eozdbnJPdVH121HTPCvHN6rJ
	9QlxofiOszXTy1P2pKIdKOphlIgoSU20hSRweal4m1OCw7VIjDj3wfY/vCYY/mzy0RBw=
X-Gm-Gg: ASbGncttjCsaBeHaME3J/HJLkZKWg2VZqDYvzyBqYGXSab6NmPnff76p/CAYnLTmB60
	ERX5a2MHzNJZnUhCYBfMBxXEiEgdlvJIQOnOibvGHbA8lDaZ3Dw5SFefegpW+N6spihrOQUp0yR
	uPB8M/EE0ojeEjKTzAORpWHnDdw6L616mRRUy6W5JGbdCsO3XZB4WhAUXuztfamjjJJMsL48FI+
	6TGZwxqYylXoayoaYx3q81uyQKBmz7uNaDT+u9LCTNUv/ga/WgAt7D3R3YdXEsId5Vf56sH5Noz
	dLrPcwzPeq2tiJXPMxgQtPn1fyKu+FECeZiIn8BxLf5Jx+0BzoCoOUsFlrOIimxMSdBKBE+c8DH
	NAsYV5E105ZlfhsA=
X-Received: by 2002:a17:90a:da8f:b0:313:283e:e87c with SMTP id 98e67ed59e1d1-31e506eea04mr7799980a91.3.1753340807837;
        Thu, 24 Jul 2025 00:06:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhoV7Y/qXx9naOCUMQRNHNOXb6Xr53WH5YOfO1E3P29Maf46gRTRCMU2dKiugt9qy2W439cA==
X-Received: by 2002:a17:90a:da8f:b0:313:283e:e87c with SMTP id 98e67ed59e1d1-31e506eea04mr7799942a91.3.1753340807381;
        Thu, 24 Jul 2025 00:06:47 -0700 (PDT)
Received: from [10.110.12.211] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6637a33asm614159a91.31.2025.07.24.00.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 00:06:46 -0700 (PDT)
Message-ID: <8f10fc34-20ab-4edb-b4d1-d2e361f47751@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 15:06:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs615-ride: add WiFi/BT nodes
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250707-615-v4-0-1a2f74d167d7@oss.qualcomm.com>
 <20250707-615-v4-2-1a2f74d167d7@oss.qualcomm.com>
 <446cd45a-0284-4782-949e-2e5321545b96@kernel.org>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <446cd45a-0284-4782-949e-2e5321545b96@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=6881db89 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=oRJlAaeS_37yXmdwZpAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: JK_uNB14lCFzL66hxhtR9ZlLpMkZ-I-h
X-Proofpoint-GUID: JK_uNB14lCFzL66hxhtR9ZlLpMkZ-I-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0OCBTYWx0ZWRfX3VuvlCFNemC/
 hOWL01FdHXObi5O8esp/jNGtXbf8E+T2smT7gB+tGkOSo3MP+ewv+mhe86f9IRNQInXmRYNhx/z
 P9vtMaF98UZgW2NWZJkgQYqCltqCi8axdzATL5u8jgdQF2cJ115u13Xz6/c9MiRPbJzSR3XBSTv
 47fW52A6V5SV0LODHB4RCwkWRfG09P16LQ+yvBuis16iMicXOHrlMQcsrJD2wtHxvJqVoE+Mn6C
 fw1hvKs8+nMtnbXLc8es+gE5CrTXftaLJQFcI05px+1lhzoGOVgD1IgNAKq7DgW42xBFETjVjlk
 OH60nCpGMjNfaBnBMdDsZ+tS5iKnXTj8o1Hn3Qmn3d3CrO4X3FTctijge0jAwKuCsNMZqELJmI7
 pGocporuqXYT34yF4Za9pb92efkNq0qXMFVRT51u+NKf/gaRKg8JxkCmo50UvD5JNyhNV1/l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240048



On 7/23/2025 8:12 PM, Krzysztof Kozlowski wrote:
> On 07/07/2025 04:51, Yu Zhang(Yuriy) wrote:
>> Add a node for the PMU module of the WCN6855 present on the qcs615 ride
>> board. Assign its LDO power outputs to the existing WiFi/BT module.
>>
>> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
>>   1 file changed, 135 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> index 011f8ae077c256f079ce1b07720374a9bf721488..2df8e7e3c1d3b6d6353a6753b8387c7411edd927 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> @@ -18,6 +18,7 @@ aliases {
>>   		mmc0 = &sdhc_1;
>>   		mmc1 = &sdhc_2;
>>   		serial0 = &uart0;
>> +		serial1 = &uart7;
>>   	};
>>   
>>   	chosen {
>> @@ -47,6 +48,85 @@ regulator-usb2-vbus {
>>   		enable-active-high;
>>   		regulator-always-on;
>>   	};
>> +
>> +	vreg_conn_1p8: vreg_conn_1p8 {
> 
> 
> Are you going to keep sending the same? Third or fourth time, even
> though there were comments? Please take comments seriously and implement
> them or at least RESPOND.
> 
I appreciate your comments and apologize for the repeated submissions. 
Due to a possible issue with my Thunderbird client, I did not receive 
earlier replies and was unaware of additional feedback.

The v3 and v4 revisions were based solely on Rob Herring’s suggestions 
and included some dependency adjustments and rebasing.

I will ensure to properly address and respond to all comments in future 
revisions.

Thanks a lot.

> NAK
> 
> Best regards,
> Krzysztof


