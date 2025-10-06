Return-Path: <linux-kernel+bounces-843066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F193CBBE57D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ECA3BECF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DF2D5948;
	Mon,  6 Oct 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJ/49MC+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C62C325D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760946; cv=none; b=NZknA7lBEy2+anhg0uikY/QVgb3ZaSJ8tgz8GI9/6uRU6SgL1thVi4iYohYjBIUNjbKz+DJRYtm0/SOXK5l21sxVXDYBr7BxoqpxItUp9PK+drGZSsYuesv1xe01DydEh9elqfTyQQ/dXPKXNG+ztdQD1coWDlql1D2r2VQ888Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760946; c=relaxed/simple;
	bh=ROnstel0j2Gkqs0U4k0SMhUJQdmyRLNPAywgaOS5mrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPuW9FIS5leebfpAB9942fXRGWK0Oq9yVHU8P+m1HB6F1Eo96/SM93LYFz0lho7NeFj2gyEmo4wqWDxAqKJ0cf5x6gXjZrsZ5bSPAyCwKfbyz89yczDQQ0Y5/p/lvax6vH1+NfJSKjsA+d0+6AJjkufj16BXmfrEvNVBtZR/XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJ/49MC+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960H64N014337
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 14:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CS1OJiTNhhN7sRrdPpBTKnj05Le98GVQEYo1gD8lWtM=; b=KJ/49MC+bMmbaPFo
	D9tZjzpl84oU03YCg2tDyioTmpz4JGeq0UkJlLyns7k+sUVjn3xye4uE7waYdtpX
	3OQXqUukJqcm2UxLsPQYnyI2ggD077+F14RPyLffqZxXoK9dATsUs/NTc5nfjohm
	KgjO3vwNHmH6ozjeoz/LxL3cTqGqd9uLo0OFZ7QGhByNy+wJT2CcS4s3FY34q0+N
	MQVnK4II3VoEPkmBksPSDzDDQjOijSlmpLrSmDDpj//Wg5Xp4AyKv+GN3c4mKncn
	2AYeT+Bshsani1N1WKrcAbWwBOdaQw+SmVRTIss82JQn2qAovSdANgUAvk5P8ye+
	nWQYoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dva30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:29:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dc37a99897so13141121cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760943; x=1760365743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS1OJiTNhhN7sRrdPpBTKnj05Le98GVQEYo1gD8lWtM=;
        b=CEIHcb+Ss/HO+K/vUXwxiWeWvSS3Q+KY5sFOTlEIiwp+xP+AzarzH08I9DE7VPm0sx
         FzqyPaE/hFkZ483ZKGWlCmezCzmjDUkbNF8Q2s8cYwkTSRNDPCb5g4JVa9cc5MLwXQDN
         rE9pSZC7Ly2iAkRdErDk7VmFb3BPYCE7oe8WSildquwzCJ+QkdfhoGhdIhCpyxSvIwWt
         eky9Y4YwR/aThomKqIQiPKbkl16zZg4WfeiryWRhxU0fJ2uYQu6+fAufcm3wWCDIbAzO
         jszK7PEC6M+fWBU7az35CEh/RAVM/IHo3HJsAN4fn/2tLPhbI45JOtUg/Qm1iOsr8Ihe
         53Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXzGYhQvmCXc9j6Qy9OsKZWdKCAfKfmFwY3Sp1miv0Ja7XEeoy4xax2ReGi/0LJAPMT75tq7rfe7lUCoS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHvGYDECN+MlYhaAOMEWPREjeVXrOS9QGQl90dMVx6Us0nnnm
	FL3KzZDV54r4IT08iNykIGELIDHmyJTZS18JGhJ9Pbe3o+Lr5048Xb1wPC/2ltvman+9QoZq8ES
	7wFZb9PEWMLjsfO55wxu8Sg+ASNqkPTW8jq1tmxJ9UMN+rwz2gjjCJyQEFiutN1uB6/Y=
X-Gm-Gg: ASbGnct7KEfxu7GyeZhdLXc49PbOgCAEB6BLoOlEn+exLWL6rkzLxeKIRm7UmFRG/X+
	oImBvJ6mF3wFZ8vSdmm0KisOa8z9S5olJjOWl5MeYcfs0NO3XkVDezd4nhX/B+JZbzKJrkDNt0w
	noAcjgMBEyxiTU393dv6z7Ut9fIt6jFlbitvlNgS9BVxEh7fMtuJiu0yN2zamegnHCs5QPj/Irh
	mjSNE+WWtt59EkANt3Hr1vPKGKxO5rzW4bd5UNcJMW6LsyfnPLK8+ER65JMP/Be1APzd1QWDbMt
	eum9VxL1qct01qFhJ3OxqeHwztkbTIzrwKt7cjXU/bza54lPfbwtCTBjg0KMAKDIkR90svgp4w/
	foxPVyf5FIMDCP3l2tOrTPXGUL3g=
X-Received: by 2002:a05:622a:20c:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e576a81e8emr108726071cf.6.1759760942926;
        Mon, 06 Oct 2025 07:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSKznZkC7MqIYL2Y3aS6tYYQs0BrzaPohLlUfJv0W+der5wzZ88gecyQbopr5mVqM+Gnlljg==
X-Received: by 2002:a05:622a:20c:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e576a81e8emr108725741cf.6.1759760942317;
        Mon, 06 Oct 2025 07:29:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b57f0asm1152277766b.77.2025.10.06.07.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:29:01 -0700 (PDT)
Message-ID: <8f81289d-7672-42e6-b841-6514607cdb38@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 16:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] arm64: dts: qcom: glymur-crd: Avoid RTC probe
 failure
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-17-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdi0+c_FqinVA0gzoyqG6FVFp0jq5WSLsWWKiT12VVs3Q@mail.gmail.com>
 <CADhhZXaB310hVo_w8_CoJLQ3j9dy1eeTwbmk0q=vUV2ga1PAYA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CADhhZXaB310hVo_w8_CoJLQ3j9dy1eeTwbmk0q=vUV2ga1PAYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e3d230 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=arJHdyfYHkrX3WdpB14A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: xINOU2BiQLMhF6ZiPEAwwcek8QiLZU0a
X-Proofpoint-ORIG-GUID: xINOU2BiQLMhF6ZiPEAwwcek8QiLZU0a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX2kSoSixh0MWx
 xRw3FJWmaGHlmwjeqW1oCIbF/0B1mj5cAZrHi8+Y5pFJyPF2qfXzAQrnHvAb0XxnJX07ODlaVwD
 j4UfzZ7cDt8ew/Vk3xk4CdGQzKY/nkpfCmlkpaAm5LPkv3Yi6K3XOzwkIDjsLlah+GfWBucbc3i
 mWxNgGeD3aO/rWSNq0v4oYwnEn8jbLsId6QXxdDFOOcQ2Wzr07lkxmzKcU9YBRQeHXB7A5jiBYv
 6u1UHDkz2FLX7PA1C7nX/bZGOoU2eYY5c2rBmIPBQcQC1jwQ/36annVHjko9scJplai0RK0leXa
 /0/Yb9XeejDd7YPcJHhEu5eMdJ5SsyxdD6gCSmxQ2v6DtHeh3owVECZFeWcWp5byLLxMVr0ZE3+
 N3NUKs5FacubNjP5lfYAvzGM/zDSYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/1/25 2:23 PM, Kamal Wadhwa wrote:
> Hi Krzysztof,
> 
> On Thu, Sep 25, 2025 at 1:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
>> <pankaj.patil@oss.qualcomm.com> wrote:
>>>
>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>
>>> On Glymur boards, the RTC alarm interrupts are routed to SOCCP
>>> subsystems and are not available to APPS. This can cause the
>>> RTC probe failure as the RTC IRQ registration will fail in
>>> probe.
>>>
>>> Fix this issue by adding `no-alarm` property in the RTC DT
>>> node. This will skip the RTC alarm irq registration and
>>> the RTC probe will return success.
>>
>>
>> This is ridiculous. You just added glymur CRD and you claim now that
>> it's broken and you need to fix it. So just fix that commit!
> 
> I'm afraid, but this is an actual limitation we have for Glymur
> (compared to Kaanapali).
> The RTC is part of the pmk8850.dtsi that is common between Kaanapali and
> Glymur. On Glymur (unlike Kaanapali) the APPS processor does *not* have the RTC
> IRQ permission for the RTC peripheral.

This is interesting.. is that a physical limitation, or some sort of
a software security policy?

Konrad

