Return-Path: <linux-kernel+bounces-873970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF707C1531E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46691887501
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B336339708;
	Tue, 28 Oct 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iEZ6x4AC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057332ABFA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662258; cv=none; b=NRnURMFwu5dPFH/EE/4Z/8Wd+W4VYu84FAjKpHv6bfKjN9GeEyVUp1vGJunY6VyogTLEH3aK87DUCTPEd2eLLy52DzLmU1ETRqv67oldUHNX519E1i4LB3DsfwALqHhxIvIb+BStn9+RTyQDGl85KYGK04D0WmpDurw398qpzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662258; c=relaxed/simple;
	bh=RlL+HspI/qKibOJ3Hm/qcxkCvXtTeg2FxvrSbq8tYKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEjNUWWxtogiPv2er4nZoUAG/GpOHN4DUcaTHWKOkioaKjDzB2ZSRbQxtWgZLDECYCLw095GTWIGH8MLBnzF0ap47bdXWJgjxPXQqVGRm4AcRUBpaP1i5OJc6hyIDfdiKxd8YScSuQpzSeqGhCpdgzF6V4LZvtJGcISlCjF64YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iEZ6x4AC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEa4mk1033248
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/rG46MMpKrRauqQ4haAq1ic3vjVmepSj7Kf1llU8TV0=; b=iEZ6x4ACCNTX+Qkj
	LerpyqWm+QvfYlmVDBKgpnJDIAN9SAAPvC6nnlidxd4A/LXOz9oamk7c9WDnMz53
	pMrkrmCbGR7BMvqM3IwGzBnuhdH45LbhRKbcxnjSngBeyiYvPp9NjfMooASqatrY
	67JQx4dRHhPjclbvNIf8D6irwmMy+XWF0uQqq9KrmjTKqXn4V4ZaEjgUHly8W/5m
	C+6a+Kd+OPrpYvvk1iOEs+XhH1S34j4R+ziwFdzl1Lgd8W8Q6hdW0Mzj0zAacRO4
	/7uOvxwOwqDshWAUdJuJUFUGMMj3yEzjTOifVthdunqgzhMuvEWAJSJXD8c63PU0
	bnPi0A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2smus76c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:37:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5a013bc46dso4562492a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662254; x=1762267054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rG46MMpKrRauqQ4haAq1ic3vjVmepSj7Kf1llU8TV0=;
        b=giQtuzZ+A3/r18TZZuKY4aXQJVRaPyxxSClXDfdX/LIgnQ7mcpIRrOs2HurhgDLJJn
         9L1VAwMT12NEsQEUDd4MFMiEk4ykmCaDd+fzERDbpBd0nFoURctXaKvKBesMYLl0I0kU
         ZdkUfoRtMfl0qWwQb76WZ9II0JfCdAfjfD1BuA6jYuwzDPoXYfIfU59awonkxABArt0Y
         BC3+8WDi2QEbftmtsVP7SDmcaQsQlDZznxua7CGjIyAdhNRYjByVjtD79lpHFAzkfX0H
         CrBfSeXiB29SlFZGl7YbOlcGTe3X2UUEUyddmcUSGKRIROQEtdT1D3na1mvwzR9c7bkZ
         2/vA==
X-Forwarded-Encrypted: i=1; AJvYcCVGy2SFg2CcSSca7gfgZkL9NDFk59oG1bAfzi/eYmGJMWYQDN9nNE7HD/YIjE9H/aQ6pZt0KFAlXhLQbtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyCEmduXzk25MbBJOljHF6cYm39EC/e45d2JIi1recUPC7V+u4
	NpdnzxZjhBtQvLb7Ao+Gp9OEhTHzBmTtn8kulHW9R72QVJFOdj7TA3gxWpzt5LQs7BaH/PK/GSn
	axFbCPhtwkg9rqO2UxVFsvzedR9ajCUUoZqal6g0R2qHRGJuMNw6VwVXdpA1woGp41Bs=
X-Gm-Gg: ASbGncvlHiwyib2dX3U/j5hC4aDUWBbVIAivhK8P+7MzllZwPZU4l9Pd8I3c+B0aNmd
	huNUfK+mUrSja35J4VnjJxZJclnUHr+XIVjocJcownpxP6/DCHL6iQahD92MSmE+rVHp5tV2/q5
	Rle8hY+zTeQrEEhbJ5J7EhpQ27vjP3EZDFpqBy0Xds+2KVfe9IBnGh3qtoqW3uLidvsSOJELxt2
	HL16krsvfHmVHs8ZWA5xuzdSuepxtnGi9xRpN9wzDNn6g3Z6VwkctJzx4p+/nITBjRDed8+hjZd
	X01mkabByb3ENyRmS8WwAi0A6fyrH6ay7kIIOdohov/PjhmaMKR32GRDQvVdvISti2SYstVozDK
	vzAh+mzjdNG5OOK36KP/9ODAf6buBlw==
X-Received: by 2002:a17:902:cec8:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-294cb37b846mr42602895ad.2.1761662254230;
        Tue, 28 Oct 2025 07:37:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNEIHDBFZq7QwFF8HDQMJV1KmXTeW/+0baTbAylgg4BeWPJ1O+kRI2qc8L1PgzmAvM7ihU7w==
X-Received: by 2002:a17:902:cec8:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-294cb37b846mr42602425ad.2.1761662253506;
        Tue, 28 Oct 2025 07:37:33 -0700 (PDT)
Received: from [192.168.1.57] ([98.148.145.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42f34sm117630335ad.106.2025.10.28.07.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:37:33 -0700 (PDT)
Message-ID: <3524e5c8-3848-4554-91cb-f2e034378013@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 07:37:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] media: qcom: camss: Add Kaanapali support
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
 <22f63af8-281d-4783-b770-36cb1feb4732@linaro.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <22f63af8-281d-4783-b770-36cb1feb4732@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aI-lJL-ntvqa2U8D_H4kz8ZVHz0soQTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEyMyBTYWx0ZWRfXzrbBi7wOuuyB
 GdCYgj0v+hgtPYtDLhu7Qb0/OGxeawCHTPYfr9uhnayW4+OD1VmbBTxN+GQf2BY/juQhYJezBpU
 xMaH4bGzC+6ZNyvAtT4PddDBMd3yTMX3u794/f8pE6wf9073vt8xrwbYFjnmRzvCUblSOp9cV3G
 yHCHHzIM+hPNZNQBMt8uxmscJ+9CCglWpxuJhvom88OK0s2RJjbhAfx8bmk2uOXfJSRpooQlrC2
 MywWPtkvUXg+jrIm+iX7/njN6avtzWwVXIL4hCoFVkiv4ndKm5L+m44vguhWGFX55e6Xyg5xvoA
 TdWO4V5hlYOt7fN1tEQQTaBtFBKgna+abSUzwekdBCVdV/bEY8cm9t7Fx1xilIFNoppf6ax3TWD
 8+A8jM4x3v8QNTo5PcY++QMcFwDK1Q==
X-Authority-Analysis: v=2.4 cv=IcCKmGqa c=1 sm=1 tr=0 ts=6900d52f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=BiHMn5M11h/vNwziJwzFrg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7mIJVjpd1DSiGoLQp9AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: aI-lJL-ntvqa2U8D_H4kz8ZVHz0soQTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280123


On 10/28/2025 2:34 AM, Bryan O'Donoghue wrote:
> On 23/10/2025 10:14, Hangxiang Ma wrote:
>> - 3 x VFE, 5 RDI per VFE
>> - 2 x VFE Lite, 4 RDI per VFE Lite
>> - 3 x CSID
>> - 2 x CSID Lite
>> - 6 x CSI PHY
>>
>> This series has been tested using the following commands with a
>> downstream driver for S5KJN5 sensor.
>
> A few comments here:
>
> Publish the code ! Its actually in your interests to do so.
Hi Bryan, if you were talking about the sensor driver, sure, we will 
evaluate it. Hope it wouldn't block this series though. Thanks.
>
>>
>> - media-ctl --reset
>> - media-ctl -V '"msm_csiphy2":0[fmt:SGBRG10/4096x3072]'
>> - media-ctl -V '"msm_csid0":0[fmt:SGBRG10/4096x3072]'
>> - media-ctl -V '"msm_vfe0_rdi0":0[fmt:SGBRG10/4096x3072]'
>> - media-ctl -l '"msm_csiphy2":1->"msm_csid0":0[1]'
>> - media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>> - yavta  --capture=20 -I -n 5 -f SGBRG10P -s 4096x3072 -F /dev/video0
>
> Good to see, it would be nice if you guys could also start running the 
> RDI path through libcamera - softisp soon gpuisp and start showing 
> some realworld results.
>
> Not a requirement to merge this series but, a strong suggestion for 
> your own verification purposes.
>
> ---
> bod
Sure, we will start doing that. In fact, we tried and faced some 
dependency issues. Will reach out offline. Thanks.
>
>
>

