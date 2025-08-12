Return-Path: <linux-kernel+bounces-764363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D78B22208
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F51188061C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35292E6104;
	Tue, 12 Aug 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YLEHxVhM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64D2D9ECF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988512; cv=none; b=OwYPmXPPEwBsp+b4p6J52ncFwzA+rebMIcDJDrFlSKgY1WMo13rgl7SQWMtR+wEnpgT1LVT/RpIS7WojVsUUw+iqVFr64HQZk92f/GRVNtRfoXCc0jBcJXouIWxR0wkQyZT8QSY9rx7++iS/05eS5HoWoXEe11ox9lxtzKFS4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988512; c=relaxed/simple;
	bh=bIaw2FNK0aavrRb6Xybh2kRuBOYiqlu0QUXQh1nDLb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoQy1gfpLeW6VtyebXclqvrQL8cz8AttGIuaKlloKqnUJmOLTZZsdxSxRaznoR2RK1U/foYhRvxNQXhUAEcGouThN/g244CVPcsqFCkxV+Fc2rmXlnt6BCwyjmt0IKRwN/L2L46dgEAHvEym9cLoGrnYpiEnvGqoY3UjoUrusXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YLEHxVhM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5YBjN018331
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3yei4bAWRTPlfjD9mJuCaf7V06gKwYYP2mn0nNjJIEY=; b=YLEHxVhMXGTLrKTB
	6inOCxhPCCG+SwslG+L6YC/DWarJSjoQ3ARSNrHSqqKcvuBuVXbGdY0Fa/w17uQT
	HdkJNrP8nK72Bktbd17izgld1oWf1sBqeF0kgAU2luxubb/nnEAmC3gg7IIinz4n
	rsEIYDoA9QSlOFVI6QkUJ0VVL0+rVu0gqPykJkxR51+Dbia/SbkrkycmHD4J5Q8T
	IT5MywbWbgzHKUZM+rlhbgDYihBrNlqiSyiUZhxCY1nlsylhYMPsS0r590Uz6p5S
	Dk2VKu9bpysH/7OlXpLPUwI9Yu0THLgLdKnAI8zw/y1KUpYlY8eKLSQtlB/CNUkK
	xUEO4g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g7dmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:48:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b071271e3eso13227551cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988508; x=1755593308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yei4bAWRTPlfjD9mJuCaf7V06gKwYYP2mn0nNjJIEY=;
        b=SvF4PIdw7ZAwbrnHR28j26RusjS7lwLUT4le5kRJTQtpcV07yg1hiuMu9nmz7Gldbf
         c/9aTeRVfbDiB2xAR5vEZ6T1X1wo98Fc91mk25oNPM/r73wPU5A1mYuQOwgnWiPOEZz2
         YBoFsqq8r+ZABTmBczvnRqiPz7cayIoZQsMsUU9cKTyGrlZQ53Z3KfRS59OXvIL4S4H7
         gFB+TPUR7/m+KeF5LJKTwv0rDFE4o23jO8f2JLEXwyyX4M9FXLp+vr1qyxegkX6tAzDs
         6RNXJ1nxHGXwUvvHtCsuVOPgJXFlylTJBU+R8GIyRWDBPhgAl6gg4xNf7RnYErTLGQ1s
         jgGA==
X-Forwarded-Encrypted: i=1; AJvYcCVrD0WxsuLx5pDtvNwsSYAGes2++9DkEHDgsSKL/2PtHzhg7M7msA+Is38rua9mkX+DfDUC53DiDcJbrXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOyhP3Xssk7tObDJSzDXWoy9jc2VZxqyNFonaO9HPeAoL0A0O
	zlq6GYp4dJeG579C3I+nCyrRDf4TMl/Dwzi/ohy8HOFWywekkJrCumLxwyMKcybc4h6KVmxzolX
	jVlqPcY77TArcsI/oirW6N8aQFKy0B6kE8MFkfjIabfN3axAGl+grV7fiRLj0Pq+mL2Y=
X-Gm-Gg: ASbGnctoOlkyIljzjOiFC4Fsw3fQY4Qw83OOyHgRrQ1S9lAMi4JIVa/JEE5TKT8gfyQ
	EJu9DnSMZXkRpGOE7j3ST0M+7UpdzMus9g5nSGwiiGsKiVZjQ4HmBaRNwMTTTFobaekiwI0LWrS
	B8lgn53N8sJNoPZTfknRpjUzHoTYK+9Z0+qKMH2KfSl+y532Px2hlOemXHrlTRwDC9kH5yNxV++
	8I6dGqPraPd1uCE1k0BeX1UAOicqYDzjIlmWcgeNAYmfTUcF3RZ+C5j3eLpKYiEMRO4naxizma2
	QmtmwPE2BqncchL92V3cn/OT+t600O3HtBoVsFC0+GxJmUnDVQiGVwtGdovCpaQk8Z35rLqf28L
	ZYNPW3jyZQPA3ibyqSQ==
X-Received: by 2002:ac8:7f8f:0:b0:4ae:73dc:3896 with SMTP id d75a77b69052e-4b0f4abde25mr1977211cf.12.1754988508337;
        Tue, 12 Aug 2025 01:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG49SlooCoq2QbTSVdsPIBo36eilKODoBGFzeYr2YfN/S4e5IAMokZikrVjfKkfSBp8TpMdyw==
X-Received: by 2002:ac8:7f8f:0:b0:4ae:73dc:3896 with SMTP id d75a77b69052e-4b0f4abde25mr1977031cf.12.1754988507544;
        Tue, 12 Aug 2025 01:48:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0753f9sm2178410966b.20.2025.08.12.01.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:48:27 -0700 (PDT)
Message-ID: <61a781d3-eb4f-4c56-8873-41c95999630f@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 10:48:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7280: Add MDSS_CORE reset to mdss
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
 <20250811-sc7280-mdss-reset-v1-3-83ceff1d48de@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250811-sc7280-mdss-reset-v1-3-83ceff1d48de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689affdd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=S_9igCkNjxJcElqm350A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX02xboKjB4quJ
 l8FNx92iWvFxsTJHpU4VbFzx9zldczJqSekO9+9kJnJzcWWyqRp/mDBOSseneECWQEVXJPa6MD8
 NbjN3/q5+IKctmQViY9YvZy9MDRhFJIQ3fkce71GBT6NGuSWf2xubr2zwZ8DAF1hx6ZtyQJkLtS
 hUJfEFdwfEroaf6CkR0w45hEeii8t0H97aZ8emTepT30upj3x6xkUojqlmPyGzBSvTtGQfmPmmS
 TixBr5HZXjycb8rpQryBa+IvB67ftX9PcSwTf4GTbJ2G0NbkiYhZgW+pybNHaesBe8P9frduqbo
 cT5SDuP8nzZTdSN1Zl5XWwkV7sNlBo5Mb3Q09pLg3fk1wvQ3W8zLwbv5jyQA1pb/ObIb+wqFwA2
 X9VN52Pr
X-Proofpoint-GUID: D_YkqOuryr1tw_Pgdh59LxRsF6sE9w85
X-Proofpoint-ORIG-GUID: D_YkqOuryr1tw_Pgdh59LxRsF6sE9w85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/12/25 5:11 AM, Bjorn Andersson wrote:
> Like on other platforms, if the OS does not support recovering the state
> left by the bootloader it needs access to MDSS_CORE, so that it can
> clear the MDSS configuration.
> 
> Until now it seems no version of the bootloaders have done so, but e.g.
> the Particle Tachyon ships with a bootloader that does leave the display
> in a state that results in a series of iommu faults.
> 
> So let's provide the reset, to allow the OS to clear that state.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

