Return-Path: <linux-kernel+bounces-802118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09558B44DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C361B209DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741B2820BA;
	Fri,  5 Sep 2025 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pd31JRqV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0D283121
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052017; cv=none; b=UokSrK+AvHnrckv5iuio41cylcBTiDvLKQXSN4Paeh9XIOI7nJLp9MiUOvisqMmUxY9kyOvhOW7YaY68rzkBnPCyk/m+CaFyX/ggZzp1wizaWfVs2ECCjotuxspdtfqchnStxw88bXgO/GW86M9+E9ESAwkwlx3Z/Bbjp05Uxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052017; c=relaxed/simple;
	bh=AFb+9QCqjGbJ/1m/HKU4siOLrQoCZ646eOELHAiI0rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0CfE/6w2joffqBXwwfqH/7LKKZktYoqCAuGgb1wGsRf0TWCo+zbZcsXs+6OsuMCNei78bUBjTWUYu8w93gEGxg/0de/638F3bKqLT4a1phH/VnlkL2crTYEELRbZIbxCyYnF0Rp3JyDdj6w9NGZysG0zmtjTYzUeDDvUhsOU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pd31JRqV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IF2mI003172
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 06:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K3wvqQmO4VlXSkPHtA+kQ1G3ijV/kY/N6LPpzZ6ALdc=; b=Pd31JRqVJVL455fW
	iIxfXyF8FHxyLPsYD50i5INO954E8+4E8CgDJvSkSUPXRi4n4BONKqIgl4QGd943
	03MyVmB4xG87yWf20teujpwDINGn/TATUWK+azJkm33sQQGnre5qjBG3S78wEZPG
	G0NwL7FqJPkAl9lLDLr95cvmAtu53e6W07/hFeXDwJM+LBwdxyEcT9HqH4FVxoxR
	KOH4tiV0MYfrtHtnGk5viR/duYta8IJN04n9kHVoFt7AkHkhjaEIWbB2iuUnP6Aj
	HJRIDVRVBMzGOFvX75adZRmrGIBiuKiHlzhWXypWO96+myK2HGUXBC3CeoKJdZPB
	roipUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush39vsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:00:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24b2336e513so29532715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757052011; x=1757656811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3wvqQmO4VlXSkPHtA+kQ1G3ijV/kY/N6LPpzZ6ALdc=;
        b=tslRVLTxmFFdm4gKXOZlz/MBLSOK51R65z6ymo1rWNItpPJg88InMDZ3UlmzVsdVoz
         jS/0FvJXny8PnTznO5ZZLdKKDnM8BmeaqosOVjQY99IRGxbqOAlJLaTPYGFonKJDX1tD
         FcDiz2SWPUfvmUOEjLuVS2TTszeQ4TtJnlo3FsBlF7zvYCHYp1cCfZ+9JSLImE0e2dZn
         2ZahnVwPjLuquFybG6ebxnpQekqJ2Jks4mx1GRfLU8ysPBTy1tdebCjCVqAbpW9kVN8L
         vnEr7APwiL/PIGqnJpLFQmV7mG3i0ShfiBdj/Z43/VBN7sI8zUNI/MuPGEHw34u7kwZx
         AYng==
X-Forwarded-Encrypted: i=1; AJvYcCUvN6gXk2x7Y+cKCsvlwB2rZtWgBQNc1M92AANOYl7uIyRKQMNGDEr30b38McDpkDA8YqskzHJLGu4CvO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqnzVrrideXx0rQjt6dU6ycH4PVtQSAc4e3LXt+GXhEuq2h+S
	so2MNrYGNi7qQRosdcu/GlzN302uO5eG8UCF9qgxPv3G/p37rAB0DKGjgQLZmlnXmBDfhPNB4K4
	z8ssBu/BtT+obLQbigB63kUVNUiHw9quL3TyQvY2iaHqjpcrhggsg4fT8vTT+96whizA=
X-Gm-Gg: ASbGncs1MsJhJ0pG+3fY1L6+fu9GYK0vIQHd78bPPmymPFnWzcm0EqTajrjbNk7BZOh
	9PXlZ8avZYe4Nh1hcwObo4EWajaJ1rgNhZ8YKT05+0EQ6YgBVxECcu7cflN2FqBo72HensI8FNH
	7vzLclbWQID+LLyjAozhztDXDw1wcV2wOHP1lzjmIvGAQwgpt/03T1Sh64Ih67cf5Oo6WSXIItD
	x30P5/10O3vBpp2fEPUv19X81wi1K4W+ckqDU+9zsyf8IvgEu881TjhTByb/JE+DNJKInbLBr1T
	8bI35R4e6uVKWUSO6IYzwWoeZi+ZQt9VV4FtuMGMFpshuOywqgFsRu0laeQaiwBBCicQj362giI
	Rm2Y7Nv5Jbke+Vb9qbluF9+gsoMW5EXJZ
X-Received: by 2002:a17:902:ce8e:b0:24a:d582:fbaa with SMTP id d9443c01a7336-24ad582ff65mr218517375ad.12.1757052011483;
        Thu, 04 Sep 2025 23:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/cHmFw51D0GHNL0K6FHmxYOYqdRzziDWguo5c6iA+8dTLIn0jYMYcaSVHHWMsKF7j5DIKqg==
X-Received: by 2002:a17:902:ce8e:b0:24a:d582:fbaa with SMTP id d9443c01a7336-24ad582ff65mr218516805ad.12.1757052010969;
        Thu, 04 Sep 2025 23:00:10 -0700 (PDT)
Received: from [10.133.33.61] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cbe170977sm37426225ad.42.2025.09.04.23.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:00:10 -0700 (PDT)
Message-ID: <d8a885b5-3054-4dff-aa64-5ba194be4cc2@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:00:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
 <20250904-hamoa_initial-v9-2-d73213fa7542@oss.qualcomm.com>
 <2o2ypmxo6wbohrb5edkj27ueqpgbqhsnqu4ofzfubtfwg7vyri@mdsu4ca63fr5>
 <wturd73lfutj4njzrmatzli356cfyehbtr45fjcttmbo2pieu5@he3fnsqzumfv>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <wturd73lfutj4njzrmatzli356cfyehbtr45fjcttmbo2pieu5@he3fnsqzumfv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4lPdyc6Z+5uH
 cpIljmpFgPehljXK0y+XGMRI5SLCWS2PsJPRgqXg5l8rRsI0/fIUFkXhJ1w4jTBIIRaMV7ZiNIQ
 xrORobQQrXgC/e42hyykTBc3yzqkIxHcByDshi4YoUW2eMEtaRFB0E2eeMWVOy/ELqsqENlNVB1
 fzqGeJypawDr+iKEjOINxE3brq2ReTD2eUR6L7Zri/dBurqGk5JEvTfQGGkIapthathVU27qsTh
 WNugqpE3rb25V6+jnPbcC5QFczzl+CfrWQ2zIFcpbqNUuS0DtK/yCV0j+h7uJhf7L+lftuHvBI3
 LveoAwax8Lf0+uP9GsWkYXsYaly4TZMGBhmFWqoecEmjVTZOfQxC1uqL/rtERihhL2JXC0apEp5
 6hYnVE3N
X-Proofpoint-ORIG-GUID: 3edf-1-4RIkWgEWbsIEEsGowSe5IYGAI
X-Proofpoint-GUID: 3edf-1-4RIkWgEWbsIEEsGowSe5IYGAI
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68ba7c6e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=5pxm4SLHXydbrukv4qEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032



On 2025-09-04 21:58, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 04:52:26PM +0300, Dmitry Baryshkov wrote:
>> On Thu, Sep 04, 2025 at 03:48:33PM +0800, Yijie Yang wrote:
>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>> components optimized for IoT applications. It is designed to be mounted on
>>> carrier boards, enabling the development of complete embedded systems.
>>>
>>> This change enables the following components:
>>
>> Documentation/process/submitting-patches.rst, "[This patch] makes xyzzy
>> do frot".
>>
>>> - Regulators on the SOM
>>> - Reserved memory regions
>>> - PCIe6a and its PHY
>>> - PCIe4 and its PHY
>>> - USB0 through USB6 and their PHYs
>>> - ADSP, CDSP
>>> - WLAN, Bluetooth (M.2 interface)
>>
>> No, you don't. WiFi and BT are not present on the SoM.

Will update.

>>
>>>
>>> Written in collaboration with Yingying Tang (PCIe4 and WLAN)
>>> <quic_yintang@quicinc.com>.
>>
>> Co-developed-by, Signed-off-by.
> 
> After checking old thread, you can ignore this comment.
> 

-- 
Best Regards,
Yijie


