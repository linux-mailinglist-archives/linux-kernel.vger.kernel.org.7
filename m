Return-Path: <linux-kernel+bounces-747717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5301AB1373C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA5A7A81D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8796225785;
	Mon, 28 Jul 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EakDVqQ3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F082A1CF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693670; cv=none; b=KlNesZQX3yIQOMiBCz0H1cPM5aBMDjHVCcD009SX+pyVO/KgQhJuXUPw3JO9zLsZveOX1JmicqABfItr7v7jJHEgyXasRhJKxEDokf9TquXISeVwWg39rMtm7P3/O9jHLndkSZu55/2mn/wJYrCbACphKquIXMKA9h25dU6M4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693670; c=relaxed/simple;
	bh=zvZJc37IM1lXzSOwsBhbEwOaTkTKd3wszmRWIQwbGUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MK9TbTcbqQYMBXAkHhGEf+8Gw8PL2BKLKsSC0uBWkYbHNGyPQu1oAGiMfzzcUJzXUUobri9kr6z55DR2JgO8VO4xtBJUgQq3KfjuQGDkDoo/oo55Tljed5CEM9L/aFSNulf4tbj/NDMLrPuC15kwl16l365y3zfISi65f0VrXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EakDVqQ3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rRaQ008420
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OtaOTLSP/DV+d52JHjxMOpsKY7WYh3o1dzdSeMKQJ24=; b=EakDVqQ3QMU8UWWF
	pa75601iZ3iTooCqVGvx8BFtuU7ylEgwa2wvVGgq9L1Pnfk7PRR/hQJXc2uxab4P
	jIQeKz4BTFEdEQ5pUVwFvYvxu4J0UoCZdvOxg8CjSpG4+OGxrx1lW+rTaHBR866y
	t2wOBUkAoNRYffvEZxR6X7IJh59d8G+6sRNXpZnOKKI/4z73H0Bt/Ic54WJyRAtj
	PZ0vQLW45PvMvJIEpBuiqCwpSXXnvV+JEgHSdMlxIYBFXO2ePtXd4OzFu9BcaseN
	n0wmPdaqmoX+BblxRobSkk6gMRGKJGkk7164wQGLn75ljldjFp4v3b58leN9eYzq
	bgEGoA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qd9uwey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:07:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073ec538e2so6512736d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693660; x=1754298460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtaOTLSP/DV+d52JHjxMOpsKY7WYh3o1dzdSeMKQJ24=;
        b=sLaK4g3aPhsjhCEnorQ2bdIaz9eHWf+q8QUpPlcQZeSAu2GyJ3NJ+XU4z9sz3L0qKP
         d1WPNF7huVN0y7gcf/4UybnRMC/YnxxMPP6wWcNY7gR9ay16jEPl5unOdG+d5A6i/DvI
         xDBtcHb0ULLtEUMELQplrJY/LBq+6eAtdRx1JidxU/rAo2Mw2uV8mSVIqThS5Vo99GLB
         upbGzVONOSGGfCC7iJs+HJC8cso5AeekRcv4F7At8/Q8YCDcuU6lszjVje7adWvKcdDu
         1EZdx9HtYHGiu6JdkMwRHY1igV0GWURv2GHWxrvN3JWCAPHXn0x7T53rfhjGiEf5rXje
         XZmg==
X-Forwarded-Encrypted: i=1; AJvYcCX5/WTClgjsBlibuxy29BbpN7S+j4VkeosRIQ5OzmvOYLlqtJhhO3P2nkFIsM0CbnlLUeIirvBbIz+E+iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5d6SqTEqOLppyw1R8/ZemQI7+QS6Kkto1CIUCCxEp+MI7jEa
	aOgQ/vhfpKXFzo0IPXrKVhmVzQ0RglLWmU4jrURDxD2anwATuNAEE3KkUK/qfxgl9bRWHiE5b+i
	WtjnG9Hb/54gcyE2pkcCyWN4+5/f51GYqMFR0AuiQm0omxM6a2vvkR0PUzvav4wK4ehgQO/40hT
	o=
X-Gm-Gg: ASbGncsTQgu4igp+XlGOQHK7DPaFxN2DvSd+zRCCabRJiBhYJ6UTy4KJa0a+kexT1Uc
	MiSlyCXBEh0ZUcQz8ClBlPi2od6P+hh0R96UcNirAjdHLcTWmW5yQ4sIXoQPRCo7FhsFYhPKwYt
	P5njWDIypRKbUCAUQUR9dLr3PzTBlwHK5kSv9vjTq3FrhQdnc9mE49CPMN83er/kH6hp3BBp4k6
	v5VJ0JaAsBj+xl9I6ltsf5/IGsA99817sKhARHdhJFsyul0c9XhoUQL+fc3hb4TK2xPyqWAMvwW
	ljK4j9oatBeE3CvvAhk9uWgAzb7IKxvOw9uQgA6vsPj708JbPW8FP60TyOvFxtJ6FBX+qGJW9+D
	9XWfOyxJP/X0uIHqCFw==
X-Received: by 2002:a05:620a:390d:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e63c1c555cmr619352585a.12.1753693659738;
        Mon, 28 Jul 2025 02:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS7dcUDok8MlrUYjDETf2C4hAw3upxujHwxwpLTG4xsI+lKYIU6eMEVLJXJKxX9C5Vz8KwrA==
X-Received: by 2002:a05:620a:390d:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e63c1c555cmr619351685a.12.1753693659338;
        Mon, 28 Jul 2025 02:07:39 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635860143sm398459166b.24.2025.07.28.02.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:07:38 -0700 (PDT)
Message-ID: <dbd3653e-95b5-486b-b38c-422fca099df4@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 11:07:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Sort nodes by unit address
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250727193652.4029-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250727193652.4029-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0E8YbIjniU2Ubmpq-xVQZZBr2f8V9qB_
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=68873ddc cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=x0-Ntm4DP0gVEan9CnAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0E8YbIjniU2Ubmpq-xVQZZBr2f8V9qB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2NiBTYWx0ZWRfX/qSwwmPDNwPu
 alboT2CZpAS7GU/AJJa9BlfDI6qo+NrDnub2/rvCO5bKLwC/Wyfloz9Z++m+HQ7T7i5l2A/bTsv
 tKyedDdpH0qfjKsdIp157Ky8LmMO0033Txf4gQa4P9fDRTU5B0sAfsCDqInDMahRH+6otnexJ4u
 32ewb2fcJdHz2j2J5IhxoaSKUHl6/GK0MYzspsvm3aO4MTq0ZPruRd1yQEQ4z1y5awTaLDXqHZj
 n5hXhPK7UVxczgPy6u6bhHdz5AVuKbo2/4wT6T463lV+p6xqzuLmbOFQUzXE4uoHXt7kh7yXpZw
 6vFDGzkCsrJkzMGt+iMIHtb3L5VwQbmPCou9npgRSNe9JerwEtIJ7AwgOLIfj/HFMI7Wd2gHRFt
 a9mS2XNoh3CORTo1smeDLDL/QLgWFI7QKeH7K+3bId/5wBeZ90IVi2E8nzVxR5ZjdcW30nf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=839 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280066

On 7/27/25 9:36 PM, Krzysztof Kozlowski wrote:
> Qualcomm DTS uses sorting of MMIO nodes by the unit address, so move
> few nodes in SM8650 DTSI to fix that.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

