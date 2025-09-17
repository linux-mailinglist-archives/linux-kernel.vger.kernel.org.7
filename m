Return-Path: <linux-kernel+bounces-819881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79961B7F6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6833D523462
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457222F5316;
	Wed, 17 Sep 2025 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJEr8WnF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA52F1FEC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075836; cv=none; b=C+uTcnokng1pNnIXPd1SectXAT4roCVgK2+nG59guTG0BYOOqj/OFiZP4js8FZ3WX6Yh/LAYOXPS+h+HszvAe2en7jPkodm7NZGj+cXXX59kxR80tZP+8oVPFlNp5J6D+XUR2ARu2LzAgBwc1EPFP0uwZc7/xkXhGDasey2xYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075836; c=relaxed/simple;
	bh=JDu703gJi4SNHr8MEaA7gFNcyg73bIGejUOowGwFSGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+zb6o58JOx0rWjH601VnfqTqnF0UXLijUscP1/3venLBsFKF2OWi3dXq5ws1rk5QufIUaGnOTT/fTqFdoApWTMBsIU09ZJc1n700KEQ+Q8U5FoeikmHUBc1zjjrLO2Y5TLYFvCBpL1Siv4lGnzO1ECSq3WVAllbmv4iga8AyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJEr8WnF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLaJ3w026980
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h24NHOjh9CfAGdrmNIBn0f+X6SHiD7K8dLr4j2/9Zz8=; b=cJEr8WnF+WSbXdio
	QIU8SqkLnYn56mqq5S5lBq5auaKMHJLd3OjAEEWVtFVM4X7O6u3KAgqtrBLUAS/H
	SdVPx+FTZzyjGpJnWzZ/BFnayQnD4fPwzFnDHv5agx/k8q2tIjuVivzzbUtQOuO6
	/IKGXFXGDoPRPmITk/oQJN88lzzU36Q2WJB38H+1FFxmP7xr/TQW9FvvRunSgmA6
	nKQobfDbgZ2tEcKsUZ0CrCTO4kwj9bhq1GcL8i0OKnFcIkoLHxKBZwdOfI78NB36
	FejrhZIU8YaAuP+Ng+R0rnvjjEWF/HebvhMG6AodjZcpzxPpDQsWcvmEEZLmKGbB
	pOt0OQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxgk2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:23:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so5494205a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075830; x=1758680630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h24NHOjh9CfAGdrmNIBn0f+X6SHiD7K8dLr4j2/9Zz8=;
        b=mLJSTZS8jesp3Gy14M/plekyQ87PWDpkeHm1SqHACAUcNkoZ/6mzEa1fTWldfVikwW
         B7zHOzNV57n/QiXyIi9wRr1DfQtwDDPUCoJ88mvdcd2JqOjmtBRuixAoU8f6mTg/oCdK
         2pzeNHn/aFZ76JgbyE8RTk5lMayZJW7AJ2swEjOnXR1t8KroM0OXu97emJpo5CKKvaZU
         jdRwE4A91glxL9CkJkpkpgyxPY8hzDODBCj6+x0WBbXrs7SgIXQbZtLUZyc7SiIGxFhy
         WlTS3AoEo91byFYGtIwTLSgdHLW0UJabxTp+UIVXsjAtsezMs9y8rfpgTxTSYR16lt3A
         SqLw==
X-Forwarded-Encrypted: i=1; AJvYcCVosTd9870mgbh4PIYn+RMYRFJF0nSz+u/yrsh2kQantA2oOVbe379EgthCJcH3xYNI6qKhJw1pXA6Dwac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7mLaYSMPCngS9+5w6mhYFcLNbsnEM1R9yEcilkP1A109j6ae
	Oprm0aQLhYqykw3PYkN+4/iIWVpXqNSjHfX6NZuUCiI0FEqM5Q5e+76932ceFcqoemsmXEXFZyQ
	dns8fe8FL9pKTQI7uJMYTpjHllX38atahMeheU7BffilPwe7esZZ939YboKVRW3uuCGQ=
X-Gm-Gg: ASbGncuQPvjJ+Qx8xaiT2GPH5GlSvogQqSWxZjCBwRFGyV25UCM/KyQ7fLVsbIawv9u
	IfiQrQPei+oyjt+WkTF9DkCYqfoZCMZ41M9F2tpRgVxpm1vn1XnZqPbElKc2ZgdFl1S7w2gZkWn
	3t2DyD5D2lCnp8WwpSZyNAzbRyjfqwv/d6v1vvicdpa9kMWsxrn+qmAN1oaq0x2SLguCAQheCQw
	5tceO4qXbqweZtppo2nOnGR2jhrYZIdQm8EIJWgJLtfosjqB2SGsRWT8FVD2HnjSZQBvXGmJP78
	wRZh6LK+2mNiNxLHkB/vPotHkgOlZcpqyLLcEqS4RNklnM6dVFNsWLn45wm63k20TWZcHbLJXsw
	2fYWerqFZgdjnzekpvE7WUmRr+5/p/am+sA==
X-Received: by 2002:a17:90b:35ce:b0:32e:4924:6902 with SMTP id 98e67ed59e1d1-32ee3e77a22mr630844a91.3.1758075830561;
        Tue, 16 Sep 2025 19:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY1YBqTy1MRBizc/p+yW2rG4Z6RYxx1hlDxK/FRXmTIxiFlffsuMnGhMwgW8FYwvbTxyKbcQ==
X-Received: by 2002:a17:90b:35ce:b0:32e:4924:6902 with SMTP id 98e67ed59e1d1-32ee3e77a22mr630811a91.3.1758075830045;
        Tue, 16 Sep 2025 19:23:50 -0700 (PDT)
Received: from [10.133.33.240] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a6ce6sm906637a91.16.2025.09.16.19.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 19:23:49 -0700 (PDT)
Message-ID: <3d2e8600-fee4-41ab-b8a2-9940a2acd389@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 10:23:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] power: supply: Add several features support in
 qcom-battmgr driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <r65idyc4of5obo6untebw4iqfj2zteiggnnzabrqtlcinvtddx@xc4aig5abesu>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <r65idyc4of5obo6untebw4iqfj2zteiggnnzabrqtlcinvtddx@xc4aig5abesu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxbCACWU9kHfs
 ad26ZqthrCjAdebhPaOlTpNgqK4p1yFsGZGTkVIHWHC7RfymENtj9X3RbqTkh06DMrofCf2Yg+m
 vlFtDThRF4LZ75PJhxsdLMYY1ZS4DAsccOvMiM636Y+FpQS7e4cHlBKEpy2GxpyXeYbmt2Qb6TZ
 3Qiowagg1JTgAX3Ot66u9p/yvMns+TbqtFMM9f9nxUYBckMnhzuwdvPs0FmXoW+Tj/ePNZejqd9
 iTSt+WU/kx5h1PCsKchmyeDLWaG7tZwh4HgHkF4u3IQRVOTZuuepvo4up2VY6u4gQ/QgSj3pZGv
 Xfi/FqL52gj4UViIgibr7ZcrdBCb7aXq/N7B53ljT0TDhR1h7cENqet867rTfEZB4l1tEhDKVFS
 yiL25hOG
X-Authority-Analysis: v=2.4 cv=MMFgmNZl c=1 sm=1 tr=0 ts=68ca1bb7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=fapJcwKh2RYohvRb9XYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: VlWblIr8CbjwgVYJGsniH4e5R_IuLKza
X-Proofpoint-GUID: VlWblIr8CbjwgVYJGsniH4e5R_IuLKza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On 9/17/2025 3:35 AM, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Sep 15, 2025 at 04:49:52PM +0800, Fenglin Wu via B4 Relay wrote:
>> Add following features in qcom-battmgr drivers as the battery management
>> firmware has provided such capabilities:
>>   - Add resistance power supply property in core driver and qcom-battmgr
>>     driver to get battery resistance
>>   - Add state_of_health power supply property in core driver and
>>     qcom-battmgr driver to get battery health percentage
>>   - Add charge control start/end threshold control by using
>>     charge_control_start_threshold and charge_control_end_threshold power
>>     supply properties
>>
>> The changes have been tested on QRD8650 and X1E80100-CRD devices based on
>> qcom/linux.git for-next commit a679f3f6931cdb0c2ef5dc0c26f895ae3f6c1ddc.
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
> Unrelated to this series specifically, but can you look into fixing
> the following errors (appearing at least on X1E based Thinkpad T14s)?
>
> qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown notification: 0x283
> qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown notification: 0x283
> qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown notification: 0x483
> qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown notification: 0x83
>
> Thanks,
>
> -- Sebastian

Sure.

I will look into this and fix them if I can see the same on my X1E80100 
CRD device.


