Return-Path: <linux-kernel+bounces-757560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A305B1C393
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA50186C93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39F28A705;
	Wed,  6 Aug 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dcO/BKs2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4C28A1EA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473337; cv=none; b=Dj76zPm8l8klo9hV/ot5nwu5KiU2rLHelyKNFabxnVfbNSUEi+qRGtt9Q1RxWFkBDF8l0QmUEpFnPmgQifSzeV6+lrxa8iKgtWBRQuS44XzYQ03VrKrnSJ8ERhYxpbq08p9R1Z4cuc/tjIzea2fy5nVIe1JbRhO3nege2bkIH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473337; c=relaxed/simple;
	bh=gw/XakQa8gqbrdGE5wYENtsocDLSJnH77c1LBGUGarA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=daG7ahm5mGRXYc2V0s8aa7m+sDn/dMcIwKufv2gmHCzX4UnGk9gr1Q2pmMMfwmXw2xXswLBQrualMYsVNA4gMwvx5OkS/wryNklpbB1+JmQNBAWRSD+DwSwypQU0J/2vgp0R4QFiVpvf3r+6iQrBkpUy+ccl3BjhEGR6I4gQnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dcO/BKs2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765fgh9031590
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V9Ngevlyk8k8X/tpRuupzi9AfwGVf7XUwxRKsTAPODE=; b=dcO/BKs2Qt8dLR5R
	L10GWFn6tx32PPLdVnajQFaH8v3B5ecnnZLdlPLNVOlx/vsvg66VJJOGHE0eFvUX
	OZ+0FE0zVj2Tg8g0dl0jgPBOHbSKsISx3WKFmd3BDN8f3D2vTD2+m/5NH2W3pzbw
	QxZiA9liXvczQbpdJPYRLqaQ7BaB4OPxsAJVNF9BikJbWLpxHjPo+VvSB1rbZMof
	/yRaNfKnYKYxBZm0o4HDCHje+14qP6Jdpk4060JRI95ZB7Sw1HVFyRxDvhv2KYrk
	1BHYwERFLtLQ2NI/3oGNw0DJau036nl3fAxK/v4/TR5z5FailqMEv1F7tguwH2cV
	PYsxrw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybaadx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:42:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b07de45deaso2175361cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754473334; x=1755078134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9Ngevlyk8k8X/tpRuupzi9AfwGVf7XUwxRKsTAPODE=;
        b=SXH3X+L5oLvFloV0rTQRh5i7PO9wW94aWlMDXBSZasEFatuUtfuipZpK3mYG+kMOuU
         KXrXtga96/EL2Xkccmnif3heC9rGw3JbVMHNoTq3jOqtztZwNl7oeaIRVtxwKn7aIwN1
         MVfrRxs4ouTJ5gLMopcTTKzQxbyvFEIjKLK5NLkuVsypnfGpiAsonlEmCDZcGhvQ9+9/
         JJRFJ+FYjUEX+NgaPC5lBnZOSXHnMtgJk6fqB6P0uNVNo3tHfFXvpcsRnDtGBZ8fezqx
         0c7JzuhmzOLynY6RGlpmydGc1iQUu3Az+tvG1BGzVKkfjuUBFFa3Co+WzijntnlDUwd3
         d7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUITScWvsUXkI84KvYG+26849FMfvTCPHCsHcMS3ZUiWOD0Ct1eTuCbr3pHfVjODc4QW1g7lCVd3T1cm4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QHJyWSkk5eaqVDrRotdqiCOGcbB8zjzUTVlxsbReZjVhJA0J
	+qcsfSvg2PySWgfBQpo1SOYYU5rb1Il1QgQd9rdExNbVcRz+FS4eiZ11LX7V7MTi01KSwBER8Pg
	3R8aPNJkALWbitiEUhlYckX2gvNjYf4RkQAzAnXzU7UsNTPOFzPmmFfcKl7oG0l9HBCV3ZekPp4
	g=
X-Gm-Gg: ASbGncsO8TKTwBd7adcdcQdcJ6BIyhy9EWfdJN5z+Xp5KtdCs/9rw4WIfRdIdBwxPOU
	Mf5vi0uRbje5GG/E0JISg15a0vM2i9+z+do0J5j1uFGzN319qJIstikyzmGpfSmfHD0hqt98PmX
	BRfqeoYYaarVBC0tdoyomGJp7UE0OqbLCu8fCKEepRR3JxW2YQqGip4LQ1S3a5iqS8+yPltQlzr
	yZsN4RhIoZNNBKmVlesFagJTLBXCbYxvjvCFEF7NOYj+ff7W2TXPwzvtkyixSqKgoWH7yJRg+Ix
	CEXrmQNGDJWPHghXydtIXTPJDh0PAueUK4U0Vu7QAsjlCnjK9ELSyQ7+cdo7vyBrQ5QQilwixIF
	yiVH9EkHFjf2hcb78Dg==
X-Received: by 2002:a05:620a:4001:b0:7d2:89c2:eddb with SMTP id af79cd13be357-7e814d9d48fmr156053485a.2.1754473333994;
        Wed, 06 Aug 2025 02:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPRrggUJ01puIkv/R9C1gEp7UiwZiVDu3B1Vp57Vmzv05vWwTbj1vfe7NY+EM3xP5Y3a8jZg==
X-Received: by 2002:a05:620a:4001:b0:7d2:89c2:eddb with SMTP id af79cd13be357-7e814d9d48fmr156051685a.2.1754473333435;
        Wed, 06 Aug 2025 02:42:13 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91ee3c1f7sm1006103066b.68.2025.08.06.02.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:42:12 -0700 (PDT)
Message-ID: <5da37b49-8daf-47ac-9564-b2aec4384087@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 11:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: qcs8300-ride: Enable Display
 Port
To: Yongxing Mou <quic_yongmou@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250806-dts_qcs8300-v5-0-60c554ec3974@quicinc.com>
 <20250806-dts_qcs8300-v5-2-60c554ec3974@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806-dts_qcs8300-v5-2-60c554ec3974@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX5n4PBtlhQVnJ
 Sa1u95KYC73h4zGHkMCycRkXyaws16sJ9+tfB1nxhvZEXztadsCl0n0hMZKCJnMIPrvDUl8mR3G
 8lHTAR8V+ocCVpmL4jjntJDxH9w5vR9loUMQ3eXT3vN298Q3cGmlrVMtz4sRF6PK1Tlzo61tElf
 aodIrO+6nbmnEpvC4wRDny2kNvvCODYdcArXsswbykQgvAauMMmH17OsATn3QgoT6+yMzB2ZR83
 mFo15yFM8d3OxNTOMFEuNz5ZIqSActxZbLm1A8XYuuGTHDLMg9bXLu1qF6+ih1Ftc895UtkyUG4
 5Dt91pTMaPLEyLuVTrPOY7KippwnIBv/sqAWhqRDWzEcktV3nAppBJlej6WcTAkuopRLj7wPew3
 9yO0C9/y
X-Proofpoint-GUID: nRa0WpKBMF9ZHKrEfwNG7rPSCatxrmDB
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=68932376 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ejZKuhsRmfo8bG81SBcA:9 a=QEXdDO2ut3YA:10 a=PYnG6sVWyDQA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nRa0WpKBMF9ZHKrEfwNG7rPSCatxrmDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 9:12 AM, Yongxing Mou wrote:
> Enable DPTX0 along with their corresponding PHYs for
> qcs8300-ride platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

