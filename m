Return-Path: <linux-kernel+bounces-845425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19024BC4D29
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9C34A323
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033F24677A;
	Wed,  8 Oct 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OwWibGsX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131724678C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926797; cv=none; b=RNzJY5E0rbt4MZKImIipMiYBpasv4V1EnWReNUVSKiE2uUJiG8lNQdE/R/lbt3FyXexNA2YNb5QUBFkc+dUVE2XOIe06VZnWDHzF07YRdtwI9TiwYRaWZPlkstcYz3nncnLRnF4aV5uqJjOufEJRYkdv4hKxGrncKoXCTSoyHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926797; c=relaxed/simple;
	bh=//8t1NhDDv3aZbpcl1yQGBSqtJZBajxd+nNDjr8+aZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPEZpop50Wak/Z4RlukzmXM8l8k/1AIqlFz9NB4I5FyLSg8gOGoO5TNBMLtCzY/m0liPm7zIQ+rEX7L+sW5K+Oklqs1xiDgWi2wDsDwqVTEwIbKCPZWkvkGWJgMzGuWnVPl7RHUG9JYr2c2kPDethNbJ7TSiXGJK4cYZSHM2I34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OwWibGsX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890e3Z002274
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6wfZSf95CHgtI1KREXLOgXa2xinD3Ro5IOxdVOqt1o=; b=OwWibGsXastOCWwr
	cudCgCHYC3kFVxy/+gifKXtSuRoJA12pH6krQQ/9vpIXomveUt8DRhn4APEXzvLk
	/PjS8JG/Y9rHRb6Zo2AKnO3FStOc4wtM0hk0LkczeluGOkwKBc83qJ3F4OC0y1Sw
	1wZBz9HejLtzAyp72fBgzF3kbYFBH2BlLevmJgdfXH3KhIdU0K7+EUGkDr1ZlNro
	qgZXCpyGb3RenY1eURE67+op9heoga2pHXrtJkaBPj07IanynFy4Ofc0i9ILfbKU
	uJDL42//AcZJx77rVT7ISV9NAJbQSVnZurZSkzSSihW3XPF71TIaGRZ+DZvwejfo
	2XnlAA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy72fc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:33:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85bb4e88394so175994385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926794; x=1760531594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6wfZSf95CHgtI1KREXLOgXa2xinD3Ro5IOxdVOqt1o=;
        b=a6Rzbz4Kdk6n4ZbgCzN4oe0Qvprwu1Uy6Wb1/QDNw9JFbPxBs5MzQO22NnatyICo0x
         w7PGvk1fcW8lWO9B6C0lbs29WoXto1oU/DsdNebaNQobIm0xrlYIarRy0EFBHNGjlSFe
         /uyUewBuWMpDOw1LtFy+Ix0pOkbguNY5lxyHjt36p2bHKtFGuwmENv7FL9XWHmjDN2i2
         /GLt2OItbiOAivwdXVqW9tdHLnJe3zhFd4io+SOQsC+ofTJhAuQnD+CXQNj2jLjggNkR
         xDxDhXDJpEdIubcCVfSIePdQ8skLKoZBDNyMy0iaYyoF4s0LLOH7PNlg0U2Hd87IOqN6
         FFHg==
X-Forwarded-Encrypted: i=1; AJvYcCU72iECl1FAiv+NtE+1pPfgk4NfyhfjGKSNEOlS9674qk3SBXIinqe1ourxvLlFFP5xOTuaVeqWqEh4zuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvO+Qufa8Eng9a9PfWSHEmku3ujbqDhbuOcx2vJ78lzLrM+Pb
	QQs0WsaO3y7eQ/POl7B/thP876snPzE8vOCTPJuCE3rl6/Apo9cVU6xtFV+ml+HJ7Mp98BhdVAm
	eCURv9EGV0mnpt3fvDC7XJ7hd1KNT0seTAyiNsGYe1le/bmPjkhaJxK+61QbPqvqvBjI=
X-Gm-Gg: ASbGncuFAGpBPW7LTo4I8j57pshitsEEdchlCZgTrEiT9LLU6FdbRSBWhcOJEHtKz1p
	zZrI2N3796ABG9D/5U+L1ZciFBX4yNUnJMJw4CXmMca3ZZ5UHlAZRrvQ2MaK1YtFztL7jzhrSEA
	YARG8+wiC21qpRH5L5P0pMG8xiPNdnyvQN0iaYkbXbRUl6miTmFcs2GrhUmLjAGjVPhWEXtDEYw
	OxtGW6o9kq9z4V/1ap//lvVFLpGUFIGVHFW1lg9TluKJHe0kCcobcS9DhSvjpaowErlrer4T+Vd
	RW4/jbjfLil9qW4BGa4Z5QoJJAXH/j+mSI/8v9+UxtdKIr/FHUHej6WczTu0xHvVpPf7ARuXxWy
	PwVx8cMvUkN+4xTmINvLtGCAZ1As=
X-Received: by 2002:a05:620a:4456:b0:85e:429b:b5ae with SMTP id af79cd13be357-88354304602mr338466285a.12.1759926793761;
        Wed, 08 Oct 2025 05:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAq5uquGqZ+wqlPlamUADJJRHAYrFogaML2CeN1PWbZyjBahtgdInWklh6rUXYPttev4j0qQ==
X-Received: by 2002:a05:620a:4456:b0:85e:429b:b5ae with SMTP id af79cd13be357-88354304602mr338458985a.12.1759926792743;
        Wed, 08 Oct 2025 05:33:12 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b57f0asm1648527866b.77.2025.10.08.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:33:12 -0700 (PDT)
Message-ID: <24544f3e-f9c3-4650-a300-a786ef589be5@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-8-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-8-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e65a0a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Swz0U_bwno74A2bXjT8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9v5-aeQizf1vyB3II3j16K-30VZcviMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX13LPyjQ1t/J9
 Ivo3D2m0kZetu6Ly/jW+pkAztXDS59x3BSatN8LnGqk5D37K5rHVJL4Tnj/0wiZvi1P4E8M7pkC
 BQlPy0hHbVS4EWgQU8byQZYmkUrXrV+gZrr9QCZazPje7LKAHnAhWLDTG/RF0idQSzpC41NiEov
 LxsKl2jZOfqYnqT4clIecfqoCS9Mmpr48sBH+kqp9vE28ld04Kj8goOEeSik7uMXeAPqyADU02R
 eLLaUXeM4YMMt5y7lMgMfcJmsmDLvDuWUc7YaxCyzJ8rmp1aiGYXaDdYVx8qUO5WDkDVYo3dHIP
 fCbvYy7TEw7osrEXI5l88IydQBi8Pqeguq6XO+Rm8ESZap6wJKtHN5lCUs+vnIITCHVKTboH2u4
 op2Z9l28K8tl0rolTnhXmz0H+90QzQ==
X-Proofpoint-ORIG-GUID: 9v5-aeQizf1vyB3II3j16K-30VZcviMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
> design platform.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

subject: ipq5332 -> ipq5332-rdp-common:

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

