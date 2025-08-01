Return-Path: <linux-kernel+bounces-752858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74562B17BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F20216AB8E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F11DB958;
	Fri,  1 Aug 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aRYK9Flc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D11BD9C9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021698; cv=none; b=o2VyGRo2/KMw+Yin9SX9GZP6Y6sVQ4hq3pntuXYEY2iTLnCWWPWSFE9NsuJXgpAW5r5PNZdN54nuvKgyYMVX9BMOkEzs6Mtat4r5DIsC9EcyfDrkRU3pj4SnedMA+vgQnyXAA5JddsPtryKbsJl+FeKJuNs7zuH0+Ppk04rBM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021698; c=relaxed/simple;
	bh=Gh2ntd814sIoBv3VZBGnfUAB0tOVDMLn2NZVjot5dm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmNUtSykiJf5ay7Yu0xdbPKzq0u9CqIyGsxki1OHTsxfxYC3rycRGa+PHksfgJOClNSOpvHZg1mF15Lgxwa9u2f8EHgvRgVgEkwOMQkME9czu7uakoww35LCF8iI2ztcgR5WAxXwOcHRj/L90C0rFDMsXv/jtAzpYj0PjXHBl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aRYK9Flc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VJpSiE013642
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 04:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KoEUODVqVvmRTyBdHpSdPr4lOpOEHOdK4PtMa4kjFg8=; b=aRYK9FlcEoQPkOHR
	BmZvttV8RtzDfkKIi3R8nCQbqM7q9GCW24EdmyUS9oGn7Jd4wWGvtg3YIggrBDgj
	OfOzF4IM3QA0YgixlVE5a2mVycH9ltbmjtQvUJdmttagZqk9CWOV50EwOiRiHLbo
	9k+VckbfNi1qPKQqoR4Dv4Cqps2u4YMOxssdeT4gx8u/OBw9wPpF3eOhOfc2OsaM
	nGY/eWTEeC+PHWb4juj0P6el83zMykvuENPJDljTQOa9uoWAp9ReZOeKDSwkJfwV
	tl6xf7U+XXEAwvBookslk9RAwqzFhhjedGXQReWRFp9K3gNr2Dx5kDRAxCd5BLj0
	VoJEOA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2t6a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:14:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3f33295703so2302483a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754021694; x=1754626494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoEUODVqVvmRTyBdHpSdPr4lOpOEHOdK4PtMa4kjFg8=;
        b=dgwRythrNyRvM/WQlJ4xVrZEWmvuqI/gUozhPFiPf6nIDXCm6SNLXiANMHU6tZjLjZ
         zwU8XhQA4H5thrXpsPQg7cqQFwpteADeJFRvpHqDRpze56lRlsjKaOldD6cTjhHyItbc
         APEh3ODrJ0hBH3tGRDjjfoF3/C+aknl4YcS3JRMHC9f88zztE57lWfyo8Q6Kde+rV4Sv
         lET+U19yjeQoP/m08/xyG/lPKsmYk6Ie/51PCLs0vf3NdvQSGcLug4dTm9l/bV9wHmtb
         jvOk4lOJdZGJwuclWG+ORe7WuEB5KE6mgLW7j438DKyLccydglNgpSwwbaEqyptXbggI
         QRtA==
X-Forwarded-Encrypted: i=1; AJvYcCVaRrWP9kE3JfaTrGr8kMcZd5WnEOJUhhJQ6wEh2+ILkqmlW7WIwcn5t/yJ6PZnLkKoO3rLKLmJQ2vxfus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUAYFg+JawGS2lH4R3N4wTgWbbInk1k64bT0f69BEViF3YFBY
	zgECWen3I/AS/OLts4TSkqQZs6htRfp2G1C3CEZj5YiVR2ll1q8uBBb3yo3ZE/aX3gFdvdkwaSg
	y5f5nDXTegDY7E0g0Q9rALAPbuIKX+S83Z7FFOx75RXd3el9lGUM5F3zxbbrkBmpuquw=
X-Gm-Gg: ASbGncuB+QZPL4MKSHBwEfQ+CJQhRCpyPD4BESWyZ1ABGCyAp87DU2OsC4Ud3/thB3S
	PpkE0nsscv8x1TQCu1UqmWC47SXYvPX4/Dzq7Nca5UZhK+yzd1lnCN5RVUSE7a0mzerHrrkdqPE
	+FEjcw9BxjfrjEJQW2ekulEULiCyQUZ2kjs78xyyHIVV5BwXBIlUy48xpgwQKGq+D8BBNXW/lfV
	RatZAi+Hkw+kY82khskL17kpMmi+88noT3Y0nvSvKICkmonJzVBxRJi2mlw7tex/j2hn+skVwYx
	CPwQunvGHtTFn298yoj+jSZogYryMzwiToPoqwCgZf6mRIqwqmHPO7dDuYKnaZ5YMfA=
X-Received: by 2002:a17:902:d4c1:b0:240:3f36:fa78 with SMTP id d9443c01a7336-24096a97f96mr161069205ad.21.1754021694218;
        Thu, 31 Jul 2025 21:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRs7ytQBzqDA73c4cijGGPqsYp4V5AKtdxtskR/1bICgpcEqSGo2+1y+ueP91TM0aO1GU+/w==
X-Received: by 2002:a17:902:d4c1:b0:240:3f36:fa78 with SMTP id d9443c01a7336-24096a97f96mr161068805ad.21.1754021693753;
        Thu, 31 Jul 2025 21:14:53 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899acc5sm31273885ad.130.2025.07.31.21.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 21:14:53 -0700 (PDT)
Message-ID: <9cb06263-2a61-4acd-a9cc-157abb832d62@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 09:44:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: qcom: Document the Glymur TCSR
 Clock Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-2-227cfe5c8ef4@oss.qualcomm.com>
 <20250730-mottled-myrtle-bull-3ae03c@kuoka>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250730-mottled-myrtle-bull-3ae03c@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yhy_AtciBbTC9b8r0OxiQamXxCIHOPBP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAyNiBTYWx0ZWRfX1jcRFKOlw7xf
 NpA0Jz2/ointiCoh/Hun5qg/DcKCmeofge45+jymiaMGf19tDoHb+nIEFpzAzO2THXLq6UOfnaG
 2hIfjwp48cJ3Z0UzRk91J7VPxcRAtvIQptWmKxdAnWEdQiFJGgSIG5cXWj+i+TaxP09NC0oyQUa
 vpOgXXemjcYhQUQjRua0IZhxh3voDkgH4asSHbWlKS+jTvtoedjF7Xqm2V61oDgmQGK6shWNjru
 /gbPFd79X6Mf9ffMrfiCXYJtsqnMdYLvcNtSrCzMgnj3pmV+QFv9uUiXoAC0Na5NvYaP3j6FVak
 Ry2IDCEZEVRJ1R7u1zMsSt0Rexmi6HkYfsw6od8Lkq3Ao8Bez/X2Ioz/RE55KTeZ5H/DQbWkJ9T
 os4gUtLpelz7tVKPlrS6eytx/IsndybkVpSQ7TMGv7RvEtzQHt2+xeCc19vtn6ZOaMVB0A6X
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688c3f3f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=axNqULdi0T3Ot6y0ZkoA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: yhy_AtciBbTC9b8r0OxiQamXxCIHOPBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=971 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010026



On 7/30/2025 12:47 PM, Krzysztof Kozlowski wrote:
> On Tue, Jul 29, 2025 at 11:12:36AM +0530, Taniya Das wrote:
>> Add bindings documentation for the Glymur TCSR Clock Controller.
> 
> Same question as for v1, what is Glymur?

Glymur is the Qualcomm's next gen compute SoC.

> 
> Where is any DTS using this (or explanation of lack of DTS)?
> 

Krzysztof, the DTS will be posted separately once the driver and
bindings are reviewed.


> Best regards,
> Krzysztof
> 

-- 
Thanks,
Taniya Das


