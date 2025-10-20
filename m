Return-Path: <linux-kernel+bounces-860778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E016BBF0E98
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8134BA6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AB9303C9D;
	Mon, 20 Oct 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6Q3p+Sm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839C222568
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960816; cv=none; b=k+uzeQA90Vs/NnollQjo0YAVUY3w4C/l6JMP+2tMcuRH5eN3Xs43+XrYHQyqzCwq7cWyHRQeTtAzjxANZYLMeXFUQ67gAv0KjNTwR1TYOMQj2Yf8daTz0czU+ilvsbpcc8yiaFa1zJ/g7hyXdBqUnJKIf8EotTA8j/SbZjYgQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960816; c=relaxed/simple;
	bh=JFiozswb4GIwcHmliKn473FjPA/idEM/isbif6byJ4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3cFzuyrIC7R9RYT4cWFb7EF/BWmV7QiwpUnBo2FY7aLFnWpb2IItw46dWPK3SwBZIFnpo5nIt5TZr0Y7hE1QBY54Xo1harM9Il8hWSqIoYxDHJzWufI/KPQBcAyLuYWYi3+Kx+HWL1GBuvjw+xv91AwbMdhUR2JPXCe+RgoL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m6Q3p+Sm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMrbxH021576
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rm6MWCmMyPXrv+yc3ILYtdzHGcjXJf3gMY4k9S9ZBr4=; b=m6Q3p+SmEku7qT+Q
	p72G+slTEFiw2gYOI2o5MzZYVzlNt6dyW/mOHHVpOcuYr0RYQklGgWaqpojzBmRf
	OJs93sX2BXAoNc83bsmlHueMpVa626jGox5koOPpQ7iRbPQu8YPF6Fqmf1+0Bzk0
	XuYHTuoNxHpqGqPhzUbqqdQr7PmI6oI1e9uzAIjJQCm6bG9VOZKyzyYHyMQfE7wB
	4ptwE2mlU5d2+/V+5FmFWWj3O0BMycGFw1NS+uYyFo2J3n9NY69M4YVj+YV7Oe4B
	gSRqyYt59BqL6d2cCZvfpIx2Cvc1bPm7GlEDwHBSPWEyybrIadK1R233+snxYxSS
	uu2qmg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w28bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:46:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-826b30ed087so13160476d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960813; x=1761565613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rm6MWCmMyPXrv+yc3ILYtdzHGcjXJf3gMY4k9S9ZBr4=;
        b=j1Z5ep167CJobYB98UeNEydAA20GXKwsNHrEBZrUdts0hyLnsiC5UXfFi820A1rVNm
         GZrRhg4fF1y0FMvwWqMrVrbZ6OI5aKoSVOoLeb/iyBOiy6OGaxJwydEPgVND9nUoDlos
         7M8R2L56Ylr+MwPbSa1zpqjWUUCDfUSX6HdH7mbz22PtmzEK+LE81OI5VL37XTQivgjV
         wkx5Yxcp39XKtTv8tvaG8KdqLeSnWWAr6tVhWFupg+1RHuT6JnSoSZRNWmgEcEP25FSS
         3KEyXMQHojp8rDgrVL89a6Yhr7nDawgwFg8BeN/shxAy4NwKDdjKa5t8GLy7YI7BRpxi
         z6yw==
X-Forwarded-Encrypted: i=1; AJvYcCWV6c50m2+OQBY9KXZnQsjeZjYtLi7XR2QoJGP/sAQjcr2hOwkbLqvkV7LgaaZwO5kQ/zqKYU7qFVxFZTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuQC/uG0z5z5yqG9FShpaqkD63dzqxrjjBBCCKSWb/ih3Wn3G
	TeSQHuTUidyEPnFcn8VlRxbktvtnS4PvjdjHGY0Ca1/nm0JnRvkjNaBmloIEavC2eZLJhwViyv8
	05kXQ+b5DPI7m6SLNBjifK0JSGBM9G3TyLoYKmUSKk5v8NQiaumMD0063dUKMMYsoFG1ar41F5k
	A=
X-Gm-Gg: ASbGnct2bsWTYeWpCRZZjdgCiZTwsN8vSzHMO8DGcttUS04ZDlE16UsGpfOWUQXu06D
	xUIYnLCXm+mrrMaQEamQpHWsAs2u5IFT+pyh0iZH4sobvZ3JRlTWFOrAFYrTQB1/fkKrHJwPCOy
	cNqOMU/jr/yoUfraXC+zVo9GIIMcQLKNz4yVJZUcoizqmBPcE++AwecCOxuoPUGp35ZKiulbIIu
	UmW9O8N9eS9qBmsy9fHsUeSLnsbaBdTE7XjlbBIh4ExDNuSajkIfEe4PytsDR1RfTizHO4NpwxO
	tmkNjx0gkbog+lKJAULkzpJekdAR0XAzp8Q3JyODgIjhtN4mxMm/aYSGxNIUzeSA/xMGFOMFyE8
	uGo6LuvVvYhjok4kaGIsD9u5BNV1tP0nxURBMeGRqh3ZV5JCCwKc1e99X
X-Received: by 2002:a05:622a:164b:b0:4e8:9126:31d2 with SMTP id d75a77b69052e-4e8c1ab2c0dmr25835681cf.5.1760960813377;
        Mon, 20 Oct 2025 04:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0ciRktPb03dlEiAGKzDkyoD8TX52gJeD8cUeDXieeIygJWDMDsI1gkSlumLSnNzXkAMMGzw==
X-Received: by 2002:a05:622a:164b:b0:4e8:9126:31d2 with SMTP id d75a77b69052e-4e8c1ab2c0dmr25835501cf.5.1760960812952;
        Mon, 20 Oct 2025 04:46:52 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm770447166b.56.2025.10.20.04.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:46:52 -0700 (PDT)
Message-ID: <6491e048-eeff-4216-be03-cf14437b6788@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 13:46:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: lemans-pmics: enable rtc
To: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
References: <20251017-add-rtc-for-lemans-v2-1-0aaf174b25b9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017-add-rtc-for-lemans-v2-1-0aaf174b25b9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vt7bKCm_Ub4pVDu6tyPaSpnDBDDqa3PV
X-Proofpoint-GUID: vt7bKCm_Ub4pVDu6tyPaSpnDBDDqa3PV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX0nq8FWgSmwFD
 FJ7bwdkeruv7F8CaQJG1smolIeOKl2dt0akz/uJJpxl2gLNgrcy0iWq1Ac7jmxXWt9/gkgzOb/T
 /GRD0RaChF8djMlWBLUtmTGqBEMsLInmGgxvWNq9nPK7QojxQDBl1QaX4a6lO32Cx82CUcV31N7
 M35Glg4j76lLkvn8qWtIHa0cSU3DUTlOwxoe8Qicqb27i0rfS1xyoiHC4TMOHFhwIbra/0zzLp+
 lU1YsJ+40FPuFCBgPBRkNOdRpvnx5akp9es6rSszVpXF4zzCqtAHK+t9oBOWDTSSBDBSNa+PJ6t
 Yy9AoCD7EUTRT3NtBnkG+ZYmeEQIaeuikcOAh7WCLJdp+RMAUMrZPcotoiRkZTj6Ns/qjizheP3
 mPxg2xe4acx4Pli/M7dFjaImYppTgA==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f6212e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xE60aKYvQSwzfKn-tTsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/17/25 4:56 AM, Tingguo Cheng wrote:
> Add RTC node, the RTC is controlled by PMIC device via spmi bus.
> 
> Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

