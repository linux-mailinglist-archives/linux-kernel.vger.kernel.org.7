Return-Path: <linux-kernel+bounces-841282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B30BB6C58
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7314019E1902
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7242F25E4;
	Fri,  3 Oct 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="If4+Xn0N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD82F0C55
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496596; cv=none; b=cGYpBd4BdBc6sOLVbdDTY3xj2d2CeVvHntkW7rsyu3rK9IiXj+lKCtlOxf6ADAWtwnA6PuC+46PkeEjGZU5SxllQoQGggvrL3/3FOcSkLIDb97HfZ0ZEvBSGJHaWvX/vIILFEIIfYZ+E3rNmBK2iEhgK35fN0cq09pahy9MdsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496596; c=relaxed/simple;
	bh=/+vzANEWukvpwKeEiEZiIlph+tgYWtmfH2k1oDiry4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2KghsOmE314bxjfUXfeuRX8UIQ59F20TbSGjv4+Yo9GDjwYGPCBzGuGdqk+iY74eq+aPSwKM3nhJtw1xEYVUDb1WJnxxY1Q/D3m3riIbBHqaFPn+SBVRZC61DMKCl+H9Sc4PtL0Ap9Dtqt4x8ASniTuqOSofjdUPbrMKeSmjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=If4+Xn0N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593D0Lia017999
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 13:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GUfToON4fuL/wPZ4KQXRYs7Yvx2Y1KhbqwkK/RVyoQA=; b=If4+Xn0NpPkjXR+q
	iPcZfBJOHHUVUM7bFWxsOqCb/a1a5VERnqavHzrBldJ7wbzvHFz+ZyfqXVVRiagj
	3jTrgrX2wzCfpO4FVWtY0uElLaVkByEZ9xr7/pKT0oiFsVLlZ4cyiM+NhcRjGNMb
	ZzcaNIr++1ybss2zqdd4PnMC7R0SoX9xB4VerSEvx5BBS7uuODnYTsM4H7lIvpF2
	OODhypSap//3Q8DS0vpCwjmLjoF02MOVBKPazbWlDaCf93h3MferwWyLRaxhmFVM
	fvEFv785yiKeNYFsPkYZdq+D3iU+F7xv1pPSTwG77N6v5kJ4Fd6DFEi0bkheqBC+
	AzvCSA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrfcbwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:03:13 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-54bba00a238so299212e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759496593; x=1760101393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUfToON4fuL/wPZ4KQXRYs7Yvx2Y1KhbqwkK/RVyoQA=;
        b=HtPvSL6TJU1ciYT4V7mZwmkJ1iGjxnyXPX5t1j88pt+fcLsibdSazfNHb50iP68dxq
         Nwr1saxhKEVizN2UGvZTRu8g4BkGiNcBfBx6AxLPv1qAgAA/+JgcjpQJplAfWCDBG7PV
         wE9pWMUBMzuEWH0kQxl0wHKOBPFHnKlKKKPpfqmEN0QO0/zkWrUrrXNqb1zBIMI4J/g8
         cyKulNWi3vOCkXwP30N5vMB/F5S8aJ92jVTag6aAR1N2A9wq8Xz7dvyogCpBrwldDshS
         4ciNicPiBpy3M1MQXh5lAw3RyxuaGt3l4bwPh9wZquG+y4GY/ECL6BzyaR14P8ovZJhE
         +HRA==
X-Forwarded-Encrypted: i=1; AJvYcCUtO9HciIAnEIhMLctLSvg0MD+c3Ftn0E8I4Hmmgu05KyV34KWr0KqXUSkjoBzc2WiYDIcpsJulfSbcH4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZm9Hek6mX9/hhbzK3sWcvnl4de7daYXcWkoUkCB8GnVhsQY7E
	qZmoTJy5w3OqCvMsXAOBxdbTQRcuWeN0DPD6JgbJcm9tsmRgvP+JiVgi23zu3qKfNijGuyge4dp
	BrPKBlNQ5ktl4AA0uZsLm2TOxeMadeR5FMU7a+usbwrZ7fiSI3hXqZWokkRnkzZE7g7U=
X-Gm-Gg: ASbGncuZUsfLUf/XSpBeZXx6yvl36Gxehi9/RfOak5URJ7ek2wTMnJy455FQVeDIGcf
	1TSjrdze0mohlgkWK97iasICZ8qJuHJz6khNBIiUbraHoF1rH99/6sfkP8JsSLK4eHhV7xo77T2
	ciBVVJ/BZe3Nhu6igW9tzTle8TLMlx+JBnebIQt1F7HJU+99gfmwVPvJYNbXEPBvjYDMJP2E8b8
	kaQPRktkkSTUzymGMG9cG9Nbx9BOPqzuMX/eU8xhKaoZfj2wvL0SrZQmMjX/ZHtOKOHUDdA2BiW
	K6zdC1iHzOYXIomNVZ/K0WgBSsLCYPsE2xN3T1xDerXnawhqPL5vOG02GfSitfuBsMK+ns+ivSR
	aL0r+10mS2FmgbxSBpZicqkKDN00=
X-Received: by 2002:a05:6102:809c:b0:55d:b35e:7a67 with SMTP id ada2fe7eead31-5d41cfe36f5mr438307137.2.1759496592651;
        Fri, 03 Oct 2025 06:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL615tEydfIMsGqpnM6Kt93SV8jnAC5FaGdRPAbgaQXeVQAavYg+Y9iihBDoT+UcVp78gOPQ==
X-Received: by 2002:a05:6102:809c:b0:55d:b35e:7a67 with SMTP id ada2fe7eead31-5d41cfe36f5mr438254137.2.1759496592041;
        Fri, 03 Oct 2025 06:03:12 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3ab167sm3923312a12.10.2025.10.03.06.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 06:03:10 -0700 (PDT)
Message-ID: <46b25c1a-066b-4983-ad8a-d4f5f3da580e@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 15:03:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: qcom: sm8250-samsung-common: correct
 reserved pins
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251002184459.15742-1-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002184459.15742-1-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: INvL78ShNCT0WZCQcwjxB3RSDbpfLYFE
X-Proofpoint-GUID: INvL78ShNCT0WZCQcwjxB3RSDbpfLYFE
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dfc991 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=RUP1UBqQREs9RzM9fpIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX0+yqXgC2iDRU
 K1OF6679M5QT11M7LSVzMnK82KLPrWvz06x2kV/3KNbrJL0RFNBmubeZcgRtvfu2We6Imt4IsNP
 xfaJ2X9gn1Uej8UBo/HV7RjwQd0rlzO7NeBQ8n6SZQcovRL0G9IMAgH+XfP0uTyzFv21jJs7E5A
 heifBStW/6G3AzDEGYahRumGezOtC4UrkHElf5UiariDLpAUu0Ib43Z6u9mgNMsoemM2hEEYcYp
 I37oJ0XAb89CPj1w3UwLX7aRZ3+usPduh6WfdJ3MjpvlaNUVxtSoR9A4PEJbR66ZoH0UZXZSUea
 0OGHet2BKJ9ZHOi+JtvIc8Se0AP/6BMTkUJutVfqB2uwodFvWnMZnMjZZ+JTFqQeDQcJkJA0nai
 gJbBuLHfRC8/tv7cawBeLOZs9D/TEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On 10/2/25 8:44 PM, Eric Gonçalves wrote:
> The S20 series has additional reserved pins for the fingerprint sensor,
> GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.
> 
> Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

