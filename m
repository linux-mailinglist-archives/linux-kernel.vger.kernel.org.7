Return-Path: <linux-kernel+bounces-865366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C071BFCE69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88D33AA572
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4534D4F3;
	Wed, 22 Oct 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILZvfWV6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560934CFC6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146911; cv=none; b=etgwE8HfMqgSmGYQ+3e3gNixRPys1NFCNcjNJz9aayxEjH84EyDBh7tGvmAmffDR0+fRpY6oMe1kunf68VkzpYMJ/ys9qkkTgZckWQNV7EhvmE2VX2FGXxvr5TMPO4qrjzy3md3AmGjjrQ7dw33oYU9LMNyoyNu+N/Yg06S1l6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146911; c=relaxed/simple;
	bh=LKg80GSsXajEimsbU2IImSWBv/62yWeZsCxzc4ocqVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h53MHO9aDua0nQWqzm9a22Kjo4UbEszT3XdZm9JS8g9w8N+6q6ziNGRcJsVswq88BYGUHDjxpSsnpPjH77Hg4kokQfi+Kqt+fQk+9s6ppVO4OqA3jR+99va7yE0BZibJZIho+LgV+qHLlEnCuxNGEbQjZApCkxPnxwE9T89PJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILZvfWV6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAOvMH032759
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEkN3I7ez210KvWSzWyrOcOsuH0KwadB9yDxw0Xm8nE=; b=ILZvfWV6hSPfBB5J
	g2+JWRa5A3ucDW0n2H2/I/8ejYIUzQKN9LYqo6m/rEmw+chUvqXhMcY4/CdbfTGr
	sRT++teJ3xdavvz6u7hIdzFqOmiXRAFzbhewbT5CLz7yNZUGuZToZVTx2aD700bn
	pKHNPVLVCcCnwBw2lHbBDy679TTkT6bWKyZxZTTNZu9nGEhiZ//2Fc8WiOZWkL0I
	05/3zBBEnxjxatTOyk+UMsjM4sLQnZhKc0c/9E8mjvcYEef20Swqa6V0y4piTCLS
	EA71sOigZgcIpSvN6cppV7fEb95urk8T0saPXw2q4kJ7SvWztAQddwx6DEKK5WmK
	+kRTmg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wasnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:28:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a35e1923so3276061cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146908; x=1761751708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEkN3I7ez210KvWSzWyrOcOsuH0KwadB9yDxw0Xm8nE=;
        b=jSkN8c8x98CANERnosL1g2M6a254HBzLhisUuwpqUmc/j2S3tMHxMUZY5m11913ail
         3/MZN0irBaWHb3uVQpkfjXR81gJsorWN59nQ9PzzQUH26Ve9aY02OZvQ3dNmpwbM072p
         V4KvxgM5yV3qNDrfh0b0vAAAB7oC4qz32upHfgv6+5TIQbqobLbbKxvS45vxX7AH2fBN
         6WOZ8fBWup4gg+MjNfBZ3Z+Y1NiC7wyYLva3Pesr9nlgH/yuyXkljhewz5/5B+TE5hiU
         YAmSB5Cdx+bJPOd/3s7q+Z7+pJvjzkWwz028ToX5+c+CDsv5TV3kURWd9MbgPgLG7SDP
         uQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCWIwyvC5/aF+/UGEoksPSSJ2X6BQICRGDGiiXTanq/STDDsZ6tJ2yedWcvs9/1D8r0fnaur78aBq02HVgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/WSkwiYRaC/Zl/t90qpRDGEWSCerlatT5KyQ1HlrhgLGKsWO
	Pg3cwNeASoJbBJn1ywqiamKF+Giyjl+d7vQZLzYQC1MYKNSDeo1W8MGgGlVWori3KAdgcnuZDCl
	weqVLUmq6gqbEbzL54WDZnAqOl5TvzaTzBgdjbrIrHWYlqXX2+YrQga/tMZ+mcYRhyP0=
X-Gm-Gg: ASbGnctfWrd2+ZUErCs44G6aHOQdPGhnusYmx6rZtg38RF/fZy6gAlcPofZ1grHg7iz
	di5nISRZxacq0+OkWTdqI7wXE/GFq4na2miIf8l83JMdjZRhWQtJe3CcxW3V9fncIn2GxAOpOOJ
	y2XJvUlt/yUIARgzdsF2oHl/wguNJ6VP5JxXlH/bI7Mv8lAUN8WRAM9wVl4omzI5Xa1KSHQJxMA
	moMwcL1jkeVqheJ6lep7VhAh71EoFFYd9pUK5SE01mIfDej2srWngOf3ywbbSFO5M64iD3W+jD3
	QLUkUBxUcsHJ099Yeygwz5w9EBib1XTpjKFpeURqB7N8a2jIVCGs9TmT7NaKCcgsxMdoaZJ5qI9
	gyX35VWqXxhLu3wzA5xn7vwaAVFW4vju3/QrvmNPmlVhTtwMHmpzF04u1
X-Received: by 2002:ac8:5916:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4ea1167dbc0mr64496491cf.3.1761146907948;
        Wed, 22 Oct 2025 08:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIbfA/J7/7e/fTVE+4K3MaejRMmguF//6ihYzs52oLlv/Bgz24gIfsByl/uIBh4sKc+gqcHQ==
X-Received: by 2002:ac8:5916:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4ea1167dbc0mr64496241cf.3.1761146907534;
        Wed, 22 Oct 2025 08:28:27 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb0365e1sm1371481666b.48.2025.10.22.08.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:28:27 -0700 (PDT)
Message-ID: <41481de2-12fd-49b5-b3bd-f3e44e78dcb3@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:28:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
To: Md Sadre Alam <quic_mdalam@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
 <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
 <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
 <49eb9f15-fad9-4f8d-1463-04cd692bbe51@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <49eb9f15-fad9-4f8d-1463-04cd692bbe51@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JPsurJRJYCRPl0xTdJ3j1fxoh6yOq8fv
X-Proofpoint-GUID: JPsurJRJYCRPl0xTdJ3j1fxoh6yOq8fv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX+STYOu8/kVK+
 RlJgJJyeO4p5xjNddNT/7Da/5KlUPZqQJPVKBHkQ70QHe857umYbHGIuHZUsFc9zPg/0MeGM1ut
 x73BSzcFbERPR0vW6GPl8/NlLz7IkTgeV1LAGCO7RC1kbgzQs9Ygbr8fenYfT/qLh33UyyaZ7TY
 Qy+m3nDqvJ5JRkakyC9m6iik15Z+t00GnSshWbTVQKQ2VL77GehevosP4fdO+3iV0ltMEcQQlTY
 ZQGvBSIla9T9jNu51E2Od2v8JMg+xP0C+26rFU4d8gWmMhjVyHSZU2Dev3HyJU897D6KC6kp/Og
 h8FrSGGsCkHMPCUjFrceNyx5IVe+OCBeMTic3v8cT29Z+n+O5kbD0IiyrL6uviCJsoxPrryE6ji
 6HEQCn9Idf3TERNBgSCbxYTVAs3ZjQ==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f8f81d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=WIUPFbzvC2a9H5sHzXkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/22/25 5:20 PM, Md Sadre Alam wrote:
> Hi,
> 
> On 10/22/2025 4:12 PM, Mark Brown wrote:
>> On Wed, Oct 22, 2025 at 12:29:01PM +0530, Md Sadre Alam wrote:
>>> On 10/22/2025 12:39 AM, Mark Brown wrote:
>>>> On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
>>>>> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
>>>>> the one found in IPQ9574. So let's document the IPQ5424 compatible and
>>>>> use IPQ9574 as the fallback.
>>
>>>> This doesn't apply against current code, please check and resend.
>>
>>> Thank you for the feedback. I’d appreciate a bit more clarity on what
>>> “doesn't apply against current code” refers to in this context. I’ve
>>> manually applied the patch against the latest mainline (torvalds/linux) and
>>> it applied cleanly without any conflicts. Please let me know if there’s a
>>> specific tree or integration point I should be checking against.
>>
>> I tried to apply it to the spi tree
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.19
> Thanks for letting me know — I’ll rebase the patch on the SPI tree (for-6.19) and resend it.

JFYI you can generally count on linux-next/master as a good base

Konrad

