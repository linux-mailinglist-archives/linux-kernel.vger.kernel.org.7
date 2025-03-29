Return-Path: <linux-kernel+bounces-580783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC6A75627
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62AC7A505A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F26F2AE7C;
	Sat, 29 Mar 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3wiT/zY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079B149C55
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743250020; cv=none; b=eG4m9iu1I+Eg1guIpsUI3wNP9XhEZ1gg2/3uN0LObN3dL22Bx/IVjYxQCUAogsINxEg1ThnClrnSnVfplXc8axIh+hHFJgAQ/pzI0CR35pJAFdC/7yxp2H6RwvEyZc4JrrFpZvE2Bhr1BaxqqtkCO2GbJYoBWOBPm72Ry2bg2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743250020; c=relaxed/simple;
	bh=JRDw47hnBad76kPzHF87TIyZ/RQ63GX6NTfAgQK9cK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNYU8DKclWscXhkRvvlKqfAAQ2aEMTFF6tCZ+Iu4MZLuzEXaNwy5bsZzPu3ZsKl6lqxWXakJIpJTE5SFj35yQRPZ//DZtg0ET2pA02nz2BiJGafNYm+eyFJe+mb1btQ8bhpBmscdA+PooCYPM2fAB4sj1mkN2pdtq3uxUwUAfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3wiT/zY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T9PZsL001647
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 12:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNmDeGRJa23NM4Spk7uKeuQZcKlV1POHjWAt2bZXH8A=; b=j3wiT/zY3zyenaRM
	wqBKQe71E3vV0dEqpuSeo6FivO7EQfnWeL2bwBPj5nKV3yEWCwC5uE12VM1oLLMZ
	gqrkviRp/8tO2TFuqg3mp7qhHQ4k3ZFLj3iPq8WUGreypHUN5QDBkl8WGOApxtNQ
	KpK7NT9DqDS7B3+vyHHyuM6Kpu2meJs7t3SBHzH5JgpeZX+bMoyGKde7bZo9UovR
	OjMNm9mhnrwCCFZ7AkvB9XNCdda4F5Vla5hDh75OkcslaQHfsCEGY48FNB4qj1ZP
	jD83xP3l7z6sdcHnWEYVeGnqSxRYk4c1R0BArFbBTgHQBShnrBrmm6nYAMA016Wk
	U6FGcw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p6jhguwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 12:06:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c55ac3a1d9so48853585a.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 05:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743250017; x=1743854817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNmDeGRJa23NM4Spk7uKeuQZcKlV1POHjWAt2bZXH8A=;
        b=EOb6+VnerhxL0DubfBiw8CSyEHzUjDprrF7FeytV922sBgcd0CpHB6xg0rFGtqtVqh
         f5fBIp6fEbdAREOcctSclK+/X6S+WhGqkjVop0+pptUEth9N0gOA4sC8RgB5ff28Kv3a
         pEbD4N9WNopLlA24i/bPx4dHTaAPEtdL91es/qh7KsF/r3C9Rr9O/hLBDrJV8AmOZ9vj
         7306fPvZWe+zboqKklbVcjesViXwV1n9Wy9OOso4fJp56wkbxrz400RPSp+MfLwZ6+rZ
         pwzSByaFSaPdDMumc3cMeT+OtHnbZ/6t1AL0+2lDI427sVayq1/RuIajhUM5ukk3S3md
         00nw==
X-Forwarded-Encrypted: i=1; AJvYcCWQJKcpuAtt+Hr82k8BrC7lJNhfoikXS6q6msRb3Duj+IuVp29yzqd9VVO/9/jIm9KIQjGvj9tWwjTViWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHh2+i4AeBCBUpDg4JVlRSokqaGkp2rfFyiLJ/0BzgBn8qNPOs
	B+b97tbWRbX8b7D1XbIsh9jcBKVwoMu4blQkWO+Dw2nuSWFLaK5KAZkJiB0TJwVoFp2ZaK7dojV
	4ZgfNd7gjaYDoClZTjItuAokMhIZCzTLJK+FoL3pubQnEOft5mcPe9PYzavzDGwI=
X-Gm-Gg: ASbGncs2cWpoD31PC/Wn27VzjNOFfY3F2s7tSC2qNlV5E2MD7KPhfQSH5I+e+AtAXwu
	76xhHdDTCfZXu+QBa01IlEGCzASfLrxCPhdJFfqPn5ZXBch8wNa0puPiTSjgKWAxl/fizAbL9mF
	B+VGIga5PbawlucO9ahwIZs0AwaShsvvRMppYCLEvLgDgjj2Hntq9gKekSgmfxqlF/ydBpxY6UP
	KdTkZhNxuPXuL/i6rjlC3mPcqJsr8BJf5Ru3Syu+ZHuNcvDLOn7NcQkoXTSFRLf+11hnDzgJgUx
	7BR6+rW9UDb13tgJEzezQZz2Jw3e6H/9k0xTAYulFXNHzsdxn0qPMvTeTPMHiSd4LuH9mw==
X-Received: by 2002:ad4:5c69:0:b0:6e8:fef8:8b06 with SMTP id 6a1803df08f44-6eed5f87e60mr16320516d6.2.1743250017019;
        Sat, 29 Mar 2025 05:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWtxmy8q0ReZiZy3CsZsNPhns/iOWTdrbK+IuRtub+1CLYbcLY16JZgYSlOWc6R5uax+lodQ==
X-Received: by 2002:ad4:5c69:0:b0:6e8:fef8:8b06 with SMTP id 6a1803df08f44-6eed5f87e60mr16320386d6.2.1743250016728;
        Sat, 29 Mar 2025 05:06:56 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f0f9sm312968566b.88.2025.03.29.05.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 05:06:56 -0700 (PDT)
Message-ID: <04ada91e-bf41-4be6-9021-96bcb781a40b@oss.qualcomm.com>
Date: Sat, 29 Mar 2025 13:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e78100-t14s: enable SDX62 modem
To: Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dennis Gilmore <dgilmore@redhat.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250327081427.19693-1-johan+linaro@kernel.org>
 <Z+ZsE1wm87GfVanE@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z+ZsE1wm87GfVanE@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Wmv8eDWnmsJzaa3czUukYHaazrVf2Neu
X-Proofpoint-ORIG-GUID: Wmv8eDWnmsJzaa3czUukYHaazrVf2Neu
X-Authority-Analysis: v=2.4 cv=bZZrUPPB c=1 sm=1 tr=0 ts=67e7e262 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=PwuDve-1MTzY0m-xjTMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=812 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503290086

On 3/28/25 10:29 AM, Abel Vesa wrote:
> On 25-03-27 09:14:27, Johan Hovold wrote:
>> Enable PCIe5 and the SDX62 modem present on some T14s.
>>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>>
>> I don't have a modem in my T14s, but this is based on the work I did to
>> enable the modem on the CRD reference design and the T14s schematics.
>>
> 
> What happens with T14s variants that do not have the WWAN ?
> 
> Is it OK to enable it on those, HW-wise ?
> 
> (Hope we don't have to split the devicetree again, like we did for the
> panel)

Unless Lenovo planted something else on these GPIOs (doubt), it's even better
to enable it, as UEFI brings up this controller anyway

Konrad

