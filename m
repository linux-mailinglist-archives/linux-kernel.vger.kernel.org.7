Return-Path: <linux-kernel+bounces-863560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C057DBF82AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01FD4F89F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3E3502B6;
	Tue, 21 Oct 2025 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="POIpx/kH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEF34E75E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072966; cv=none; b=R1dU9GncqDTaLjNLr+MJHp9ngY3yz56zUyVmPXLitJ+FoRNBduP6MFpZu0GJWulnsIBgMRDpTZQOv4iex2eHk+zG80PAJE7U75f5WhxBebvzQbH8CiCyGRdpnqEMgCJXwbsEauS0vMGR0Dra5RhtpaS7sH3v4luFOY4fPFH3A7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072966; c=relaxed/simple;
	bh=eWr+h+p2rCg/f9WNSmdg2UdER2LHBNHRJNAYZOXa1Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+flFjK11u281cBMOJafUwfc06n/68XWEzxAOLy2nYr8DIWqhbOYBgzf78Lcc7Jzrh15eeGjJGcIZs6xnzixReDlTLbkh0BJL9mhYh76EQKkY5MLYkFKW3ZFnA1Vznnuy0IpRgLwa+MTtWiu6XTvCsXQCAx5+d7H/eEyjvJrpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=POIpx/kH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LELKqu026228
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HQjRoXTRcS0OPuTJGmQ0KlJhjtTIYf+L9dhy3S8Y6LA=; b=POIpx/kHMge6zSSM
	RvH2TEWWnmpr/GYQzMYnJGaGhgOEwPMDXjWiwlVH1KA6lGzrHC8TDbC7bhNdmkch
	/O8wFiiKRGAxBCy2v7wwg9HcPdYBsISZAM5XoAkGvaYXJnHZq0ToBizBytw1JA01
	CrtTCRTv9PwWC30XPIiuKgLYeD+DAbU+UtMdak6KD7oXJGAZIapRkb7fQi6etUGr
	Gm2SXZFl89r0oQy8hEcjak/AtSfv/MWTRejBwAolHwO0Lzg0LQA3NOWfcfB30Gyz
	p+yxLDgzyhvfu8dRBy9BG+gcItSYRQ8ANNYUU9mzULxbd2dbpWSUtGKr3XnfouR0
	lesorw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws4a6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:56:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7811a602576so9243836b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761072962; x=1761677762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQjRoXTRcS0OPuTJGmQ0KlJhjtTIYf+L9dhy3S8Y6LA=;
        b=JYv2gV//UMoCQR51qoDrMx/l83G/06YR3GzF/TxBreNp7RybqM0KPc8crBIPdzy5XJ
         gddr8cRk2iUxMh+EqFBH3nTDgpHOJYv9sk//dV16kAShB6ta7qVW5euna1QyJ4tmsN8W
         /fakD2oF110zQeWJ0KOmmNjTr0AgTIwAkew5pSHKSzobP9k5MxYTlSNNMA1elwbnuhZ3
         pPcvZ3tDTbY1xP69tIA7qM27Q78eY55Qucb0tNn+aqjBO/t5HZ/B2lGRYMAyD6DO+9rL
         ivmfeviCgQyJISkiJlYz92YROnbg/2kT6+bMqSSfs3PfLLP1Jsh/h4erNAi/pEeryDL1
         o62w==
X-Forwarded-Encrypted: i=1; AJvYcCW7faCy0+4U8uGuTT69M40NHh+ZYgfuVss3T2cNuN8pFVzoBw4Qkfks1dfL7GMAvLRfZEiW4n1QVn3O6Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeReIgEdkJOcbM8XoGMbXUnF+sEk7kNzg+U8nCkRx+kl1TLBOR
	zvuZ4tEb2JdQWMB9qLoD13A6ZHYXh/r3jNBj0C1QBNZTPotDqW42/OUxKySLDzraVMalFVmMcwa
	KAGtileYDFFROcbc/5R32+WR02iL3RKvIxP8RfYSdMfz7CDsMWCd6j+v9+E9Vj5VuVR8=
X-Gm-Gg: ASbGncvj1+U94ovkIRLG6/tTW3/hz6w5CkaH16Kx4A9eEOSYsrW3uONu92v94GX3cgD
	o6a4Nrdz9g+6zri7q+a5Ex0IahzqtNEqFKTt2ihmzueg9ZKCHl/cJIeJODA1Q7GHgtgLyYLO19R
	6HvS5CINzvGAbqgipoezEVdDnh+xEB9Cd5QcisKQ+W/9qdhyetmrdzQPToat1clxKoyu8IRAYAI
	5fKW9RlqzMMNwGoeBfy0jK/x85OZvp0EkAq6hmJLg90vcqR3hfpunUmtc6A8AsxzNo4c5xXXzGQ
	fa+IpTFB2C3bko6nDnllozUWr1nVZUFHdsOh+sV4Zg1RZYc0t5qP+IPjmhnMrwL7PnDnjW/47sr
	xWTt1K3+MfNKZDFYDl8pKIkOmdHjhFunSwg==
X-Received: by 2002:a05:6a00:130e:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-7a220d573cdmr19758654b3a.30.1761072961822;
        Tue, 21 Oct 2025 11:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzsxj6C+gt4pi5RK02A8fX5w9MLOUBphDfxZMgPHSW4KqbqzjV7uii4eQu4FEcJbjtpu6vig==
X-Received: by 2002:a05:6a00:130e:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-7a220d573cdmr19758622b3a.30.1761072961147;
        Tue, 21 Oct 2025 11:56:01 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.248.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2326ac189sm11395710b3a.29.2025.10.21.11.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 11:56:00 -0700 (PDT)
Message-ID: <034bf6f4-0a49-4973-8536-28526b3409d1@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 00:25:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/8] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
 <20251017-knp_video-v2-1-f568ce1a4be3@oss.qualcomm.com>
 <c9d8f76a-513f-4a09-bba4-cb8f0df1d2fe@kernel.org>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <c9d8f76a-513f-4a09-bba4-cb8f0df1d2fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfX/sEpJ+MnrZOH
 h/1I5nqSSoKLZG1lR0JYRLeE4l5sW1IMRq5tj2PxPA/fwRcZvUXdy6pHIRvNLB0PzkM37vmrIXJ
 0kL17rZ35x/5FiSY5NH2e9mJ+u4q+fcKHb7sCfI00HDlWAizi7kPIrWXETBrtKQEKwlWBh0wcCL
 Trt6KeHpYyJNTPH1aVoZrAEzYghqfKfZTEsbFZ/XXsxEH2uhUR6K/C6Fw71YXZP1H3YtAqPB57Y
 7JqPe/LjCM7IQnd1Rx7iLVHDyo8Sgl0Vu/+PX6jJzs0ocwbL3Q3rIqiZvOmiRhp1dmFido2UwUy
 ZWWvflVJ1no3TV/KJlBHRM//4VUh1dcGEcZbXIwVPY2m/KRYYjR4Wjv7GZ17haQC+ehK/Qrn0Wf
 8ED1ftUphnFZVMnd/6TdjE3SzQN2cQ==
X-Proofpoint-GUID: R7DeBxml1-A2_2hGy-yyMeQFWBC1Wo6X
X-Proofpoint-ORIG-GUID: R7DeBxml1-A2_2hGy-yyMeQFWBC1Wo6X
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f7d743 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ysf2FyB+yl5xZy2y99iGVQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xOFkI6Ot18FV97ylQRsA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148


On 10/18/2025 9:28 PM, Krzysztof Kozlowski wrote:
> On 17/10/2025 16:16, Vikash Garodia wrote:
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: core
>> +      - const: vcodec0_core
>> +      - const: iface1
>> +      - const: core_freerun
>> +      - const: vcodec0_core_freerun
>> +      - const: vcodec_bse
>> +      - const: vcodec_vpp0
>> +      - const: vcodec_vpp1
>> +      - const: vcodec_apv
>> +
>> +  dma-coherent: true
>> +
>> +  firmware-name:
>> +    maxItems: 1
>> +
>> +  interconnects:
>> +    maxItems: 2
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: cpu-cfg
>> +      - const: video-mem
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  iommus:
>> +    minItems: 3
>> +    maxItems: 8
> 
> I don't understand why this is flexible. Make it fixed size and anyway -
> list the items.

kaanapali vpu generates 8 different stream-ids. Now, boards running kernel in
EL2 mode can list all of them, while boards running in EL1 can have only non
secure stream IDs. Min have the list of stream ids which can be enabled for all
type of boards, while max is for boards which can list all in HLOS given kernel
is in EL2 mode.

Below crash would be seen if boards running kernel in EL1 mode lists the secure
ones.

[    1.361157] pc : qcom_smmu_write_s2cr+0x64/0xa4
[    1.361165] lr : arm_smmu_write_s2cr+0x2c/0xbc
[    1.361168] sp : ffff80008005b8f0
[    1.361169] x29: ffff80008005b8f0 x28: 0000000000000000 x27: ffffc7f252f45320
....
[    1.361195] x2 : ffff800081200c48 x1 : 0000000000000048 x0 : ffff800081200000
[    1.361198] Call trace:
[    1.361199]  qcom_smmu_write_s2cr+0x64/0xa4 (P)
[    1.361203]  arm_smmu_master_install_s2crs+0x7c/0xac
[    1.361207]  arm_smmu_attach_dev+0xb0/0x1d4

Could you please suggest on listing the iommu items ? I did not find the
relevant references in other bindings where flexible iommus is being listed.

> 
> I already asked this.
> 
>> +
>> +  memory-region:
>> +    minItems: 1
>> +    maxItems: 2
> 
> Same comment. I already asked this about iommus.

Same here, there aren't any bindings which lists for flexible memory-region.
Please suggest if there are any such references.

Regards,
Vikash
> 
> NAK, we should not repeat the same comment.
> 
> Best regards,
> Krzysztof

