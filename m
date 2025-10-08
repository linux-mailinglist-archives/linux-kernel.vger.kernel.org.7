Return-Path: <linux-kernel+bounces-845362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16DBC4947
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345CD188A03E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680692F744A;
	Wed,  8 Oct 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQOFmVmO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7F2E9EAA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923361; cv=none; b=GLpSONyFoxqh8BhXTdzaZRZU3XU3hfmJZLgiaNb1/kcYW4nhiq7wOhvNyV1vgnwW6QvKCvTYfJkCRPgOdKHoZl4qQ6jyLx8UxinhWAvEEeWjMY9GTpM3sgN4AY6vPW8wBZXD6Uy1WpVzkD2xeMSKu8tRCQsGasJFsp+2foxiBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923361; c=relaxed/simple;
	bh=5Y1g8IlsAUsUyZg4rL9NNl2CE/y+DiX7jrFayofh7Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aILkH7x4ys3zrj4UpJoz//QDiYLvyLdcfLm8AgfxEVkjnDY7meJZgJx8xuo5Zu+xBgG6DtF8DIT9beNv0dEPexeqLH+9uwtuGgn6252pbNnetRZeTu8aSY6eNlY++ffoXfF2SzcUj4ZCRwtNegVPTgAzm65E5PUh3XN4jB1b+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pQOFmVmO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Px6031366
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UcxtLcFi/NHIwxXXVTKMaEEjGDe7tRYGlHaZ/t/nCmw=; b=pQOFmVmO4VUYyJUR
	WsJp1Alph3OVUyni6JKCB8fp03H/V6aPEbFeV7wwvucNFgmZYHRXgg3qM8DaCZ+g
	Iw9dqWVVJz7Ea5BUNina3v7Cmc8/wupTeEJU2d9SpJ4AWcyrgSpn6LNzLx9x0QYY
	BhPtQTEfy3Z+pkxhLt03iZIWi2bMfsqZsVYeHb/C+Kr1i4zfZd1LMrBSZ2bzinLy
	ugIFRORtuZ2Ylct0NjedOlXc04Z/qccVTwkysrSOwgRfbfYxkJSw5OpK6Vzm6CN3
	cx54w1U+gU0o3ZgxL5gXGCQys3tlN1Yk6V7wWZekmEBn9dTsKgYzUgZZy2jlJzKy
	sWVwoA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7t4m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:35:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-879e3de728aso157101985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759923357; x=1760528157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcxtLcFi/NHIwxXXVTKMaEEjGDe7tRYGlHaZ/t/nCmw=;
        b=irqtxJcJCsp1BedGQXvUI1JX3086TXoqeckkj4kNYvMFgG+2a/pLNqvVm1GA3FJ0yC
         7PLzxP6raGDatsxAEYkGGSCualCINakQBexPViQgUavqCWkdIM9g6B1UyY7p89NFFIxh
         a1+5Jb+lh8/eaje1nTtMCanhv3FVixhwmN+dkK7JSmXkTqVbKfL9ygfrGyhUCsyZsJg4
         OHBFkw/nXW4L7eQQw5SeDQ+zBlXeVEfcwBUg7PIiodh8Ss0twlLxPQjD29CBHdPK6ikH
         6xuIjHi3qAmoSNHpe7kI83SqICoshAm0FO6v6Fg0WTIBavUTmLIeFyIAKgOBnGH0xKbs
         drnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX84lvB+800sjNOKcc/sXtGiYWmBbd6NRqJOGvq3tPlEMaFeqV49PsHSaCImm8NQKnvxS36GzmnhgcLwL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5x4HFLFzVZMQFCrhIU9KqeYAs4peXkzuSjaqHp5z8tqrAcX4
	mXRc+7pgrZOHrQd30d1LQe2RHpeS18WGoLvlPvXl8jAuAu0sfRS36hblFirU6eGy0CgIg1C7UB1
	pFXEclxJXSk6bzMDiHJbmWgLAavnIo1MOO+kYPQKlJ+sgwHCHxqoXhnJlR/1d2RE1AfE=
X-Gm-Gg: ASbGncvvQbSYNHyVVEslmibddA/1gxFcpYcWfaqbVyx2PYDn2qcfFtWUdFC85H0uSFs
	oAgbamv8U9P7+GnWa60GJo4WTlhyiKpg436IuNtd5+b3LfgK7z48fwu4Cxg/0cwm6tHfrWebDmA
	oHUehJYk3oSD2xvU09elF3nkCM0Az74xVlEeZn6DDxlvLd47JkV914Co+HzCX1/rVu+LbpCSMk7
	wX/pWs77G56TKllxhxA2lChZQ9vZ8WYMb7KCVk0h5MMN2lCgt2ObkZvExE/JmJeyBaeWmom1GSj
	JXTi0Z+/m3NQSf33sRq5lGqvEaOywtp2etinV9qk2nyZP2GgSBt/aQnmszdDf0xowSO9kaFGBQP
	pOuyt3T34HGJ5z0rnT0Z+QJlWHXg=
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr273038085a.9.1759923356970;
        Wed, 08 Oct 2025 04:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt/p9KWaL1e9SZdVmnvmGbbEbWOxiPEBK7bXd20TZj+ydCuPVXuNpIcjVWSXqwKTr1FFN+RA==
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr273034785a.9.1759923356368;
        Wed, 08 Oct 2025 04:35:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b0c7sm1705829566b.57.2025.10.08.04.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:35:55 -0700 (PDT)
Message-ID: <aa06df81-e594-469a-85ee-9dd1e192e2f4@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:35:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-4-quic_mdalam@quicinc.com>
 <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
 <2394e63f-1df7-764e-5489-3567065707a1@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2394e63f-1df7-764e-5489-3567065707a1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX/+bnkrosPjtd
 LhUVOVTF/8hDgTQn0+7/5+y33M01JP2kTvufS7Vk+yqqcVorWCSc2Yoep4yDWDi8P3uBe8I6yCQ
 e0RTVgI6RI3CKs+U+c76lvU2bdxF9g8f+5PK6y6GC3YztAIxBnxT88gdJslkCJ5VGCdiILwsYxj
 1KkWR/zUqUKWHYVSxALWn8HpiWRj4xEkjQ2yMaEdOouxJzTUHGNGkgSyywsfyjLCwdrEm3n5XZK
 cj8pTRRmy7A0vQfZ/GwiabWSzeTJooJaJp/HFOKmxjK9jtcKLXUpv5Wl4JzaDuwt7EAiZUDQ+6l
 M6JDFXSg6OAWg1rW+ZN6GNI1yFlB6SFfmTXKGPBzFM3Ef9rz2+myvkpMRcsqodiKkbN1mBJIggU
 pG+dbu1sHm+xYbfxWCiE/d0i8PLt8A==
X-Proofpoint-ORIG-GUID: 01hxdkXpL2ZVbfkRVTvNFYq68hwiQpw2
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e64c9e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=W9ArKkagtRzJc8iw_qMA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 01hxdkXpL2ZVbfkRVTvNFYq68hwiQpw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

On 9/19/25 7:56 AM, Md Sadre Alam wrote:
> 
> 
> On 9/18/2025 3:57 PM, Konrad Dybcio wrote:
>> On 9/18/25 11:40 AM, Md Sadre Alam wrote:
>>> BAM version 1.6.0 and later changed the behavior of the mask field in
>>> command elements for read operations. In newer BAM versions, the mask
>>> field for read commands contains the upper 4 bits of the destination
>>> address to support 36-bit addressing, while for write commands it
>>> continues to function as a traditional write mask.
>>
>> So the hardware can read from higher addresses but not write to them?
> No,
> Write Operations: Can target any 32-bit address in the peripheral address space (up to 4GB)
> 
> Read Operations: Can read from any 32-bit peripheral address and
> place the data into 36-bit memory addresses (up to 64GB) starting
> from BAM v1.6.0

OK I misread your commit message

[...]

> For Read Commands:
> - BAM < v1.6.0: 3rd Dword completely ignored by hardware
> - BAM >= v1.6.0: 3rd Dword[3:0] contains upper 4 bits of destination
> address

This is important to point out. With that, the change looks sane indeed

Konrad

