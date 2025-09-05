Return-Path: <linux-kernel+bounces-802814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DCB45758
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A3A188BC9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6670034AB15;
	Fri,  5 Sep 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0r9UQ4C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA226A09F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074233; cv=none; b=FSzaSleWFuEuuuiY0dN/AMURmDjCud/A9yDGrdWTkKxF7ywOaBV3+wjH6SFBe82XIkiD/4Zuwyi5o4YPNF5KhJymyCptLPTdF85p8RDDwqhzHPAvonnvujak5YAsyxu7jRmjWozWEYqaTootCT/+V8/qRB+ll7SIO8GrRLhNEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074233; c=relaxed/simple;
	bh=ErCJ6Ql1rDMt2vKVLJW9jn9Ni3tpQtFY2dmm34Q5uBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7+JNWFlCGbODU+tEYpJv4CrIWQWlSOyW8ZIbDrJGD/0CpcA3wGKOETnUsWnUMyGSki7CLgo+MH0orgm877BBfdPUkoIyYXtecfd/I4pL1pgFoUqegDLZjulkUt0abI4DE75g34XeqhUsB7bBsjC5VY/DcmHBWxMVE1gjwGRD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0r9UQ4C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5854oqlC018660
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3CXvHZCGtK3JzFKnruevi9kzIT/zr8k7RvjkNKrle0=; b=m0r9UQ4CLWMjutZQ
	qETbEc2XdgjwRETjCNkkIMt0KynIg4Qxw3/QNyNYNWIoF5s6EQK+MmTf8jkzQ1KK
	SlRMk0Y2Cn+TAsMW10hykObKOX/tZ/7PRIJ7tLOoNGnN2dZOPm7XzgnJKyGOVZmn
	FC85p/oGlW/yqEQvbmqO7FTO01Wu5ktI+iuC31bDI8/ydyfM6taqlZaAw9dwc+P/
	oxO2b/8jg+eaF4roRMEgRimjFezbnlVumB4ywh+Sckr2BOFj5tMpQKwOK1v1VuKy
	T5Rysd6oAMP0z2HdnqLBFPgfl+tgqE8TIyZmPkO5h7HZHYWi8LupJLaQ6Q+ORNds
	oCOtlA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebutxmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:10:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5eb710c8eso1929831cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074230; x=1757679030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3CXvHZCGtK3JzFKnruevi9kzIT/zr8k7RvjkNKrle0=;
        b=Mqw6E2Mq+UQfutyH+JV41qKUtEgbOB0vH1rR6xZg6X1KAZwneO4kJETzI81KSZZTVd
         a2d3I4EtcRlqaQWSnUtYFz0eZ5NFTtiGV+XFLIxq0RjaYZu/jBCnf2/cAApfbSt+ffsg
         qSYPICE0GSUr6FaVkytkNCoKhRYnvqkRYt3rU1pR9+VqmIci6J8hMGmVOutdNzDirBHn
         d/QLY/gHXKBU31XKrvAMUCFXv+aca+4rY2dLqHtmVl0dol7G7iRy1SzSbwMXs5EXivDm
         gjgodPjTfymRYW8IPJGXtfoHoDoYjNqbi0e/NHfZLjispwkFJ5Rjzc8cEV/eBWMPW81B
         3SBw==
X-Forwarded-Encrypted: i=1; AJvYcCUgxu0RG/7lXk4dWZb+1+XuxG3CfJxuI027yYKboO3yqgr2hA0vJZSn6+toiFReTuwzA0Rd+wif+1vAhns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU1DIsJJ3ATQLt1MoD6iOzmwmzuBfIq8B7KCkGAHixhDn5WtnQ
	v+i1QIQJD27fesC3bIIw9yT4hH/gNSkirc0MOJU1XkQRYOGeNBX9QWKSC6nBlCZ0vixScrL1+/P
	VKls77XcWhvikDE6rOWryS5KP6aG/AaCeTw7MLtPla1fJoWGvu8oXY9YIqr/TP6pN2Fo=
X-Gm-Gg: ASbGncsOFEb4KI1Dp0EMe3mKBKkrS7uDrUSnkR7mS1jitnzT6GFcW2K44vPVYDfinl4
	Ru3261rLYumRfBu+xYckd2usW4Rd4/UxKn7FMIt1wIOuWtzc7VFl3akCGUqzeLyeBjAQ0jmwNAn
	YDP6pe3Wn57aMd8VL/i86Apr71c7k1idYqRA5OZ4yehVvHJCWRutOQ3VZhe92fKBdjdA6yFfSfi
	b84LI5lqv1uN9AXZAlI4Uf9cWU1dqJxwzJNCPtkRlou4dp7hJQe3v05U4vhh72kOFZR0/TVFp9N
	Z5RxfldtBpb81f5bR5KcyWF0EZTphPc7ehkLT1QZiFjvWZqUAfauKN1BkDZMtWzX25V2X5zxr6i
	gl7aPEH1f/0SvPrlcEJVelw==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr79002011cf.9.1757074230290;
        Fri, 05 Sep 2025 05:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/V1Ut9FoAm3PMIuMlaHnEJiGeKOqT+3I7Y49huAY9u92oCVKu3lzCxSzcPEtH0e3dxFF09g==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr79001621cf.9.1757074229739;
        Fri, 05 Sep 2025 05:10:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7caesm16131666a12.9.2025.09.05.05.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:10:29 -0700 (PDT)
Message-ID: <a61d5e22-6a0b-49df-a203-aa408856cf43@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2Ii-G-jr9zYSdy7SiPBK4UVaHK4C5Bno
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bad337 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=eKh8lGy-H4yf2MGC_tcA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX93TN+U5Wgs1K
 BSyvYO6MelEV19nKs071/ZJvrqCpJujwHGNPXcf+0P2WS+GYPXiDccsTbsyUVW3gBXRStcWwVHn
 kCKU8Di+PpugPkyAa6PrKJ7y8JQp868EgkFwgPAQh2hUr/ZG32jFvQB163o2sZ6/2Mn4OmtTHG4
 MDskqoR6en9w2XRTbnk5IHJkWQggyMVNjLYusLF+ExNHMvJW+x99KG/IhI54Mte8iW7PdoRAIi/
 tGtl2stiCuVGUWeKH8JQIpNO1iv1RFqt9E+R17IF4E4efA/ewVNy8AliNysWcZ5z/sMZF1Yde2V
 R4hoWrRiCW+QIY3Mqq7dqnUuXRxK+LuKRAyotMDMt4u28E/3sw2r09Icu6Lk1C2Wtv6/UyIPF1a
 JI0ZsWKX
X-Proofpoint-ORIG-GUID: 2Ii-G-jr9zYSdy7SiPBK4UVaHK4C5Bno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> 
> Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
> functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
> Additionally, support fetching the MAC address from EEPROM via an nvmem
> cell.
> 
> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

