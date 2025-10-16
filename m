Return-Path: <linux-kernel+bounces-857006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF1BE5A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4233E3562B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2752D9EC9;
	Thu, 16 Oct 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IH0iahE7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058428CF49
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652226; cv=none; b=i/wb7diEPH6+r6hRrY/9rk2u7OYeYQt2WES5NjlApVDhQjGPen57mBcEOGtJpBEcaWb56Br8XzxHJrjifR46EiyM80Cq5AIHvaUIxRETnI67uDH0yUnLgCs1uKQuZFCgZGzOZGdjFgJz2zhBUi4WamphrabgcMx678u54/ZJfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652226; c=relaxed/simple;
	bh=REPaXfEEwHSvCPYQv1YOGPYDOJ36+iQWTap+y51gNTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gt85vaejFh/Bn0IhrUjOEOR5/4GH0XA5gC5xuCdTuvrlagIVzC9SFJ3mF3NEcoSh2lVkLwoRNCUCKcpZw/0jT8G8fLvMnHC30WSWrCRjRov3479SkfWk2Z5CS1eyo7tpE9ESDoMwMpf+KnPnMM2jYQ4vUHFHuExHKyu8Ec98y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IH0iahE7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLM6f028584
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hy4oakQHnBC57FbFZ/RDt9wr7jDjpQ0QoQIdKdfku5U=; b=IH0iahE7zd2RU9FH
	JXT25DKQ7oALJmhqpYYPRCgzdpYiII/8oI5R13Pmh0CwELM8OgWJTiPmuB/nRdTr
	mzndNtjqiZN4Qv6J35QAz+fKkjwazsct5nOm/pQvYphZXvZWgapz2h1NpcHdS53r
	QzJTNFcIvT6TNuL/hL9wMbpR/pOR6rL4bKYlxzHQi+0L8PMrQ9m/roiEWqL0HpMj
	Fgff+auIbwHmEjeJnO/gPcjRThy2p7U1eyFW2KiYzDRKMmndZ4Y0sVupo+jOPZKs
	6nImmyVCwwSSGdTEFELP/Umlho13ihak7j8bycaXIAJYyr/EYnnjIC/ihgHEgDAc
	O9gCsA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0sjem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:03:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55443b4114so831295a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652223; x=1761257023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy4oakQHnBC57FbFZ/RDt9wr7jDjpQ0QoQIdKdfku5U=;
        b=oZ2b7uvyCht15o5JEcYdjq4OTSB8JbOJINCKUyHA2BWPVN9qJ50SzumBVCJuNomBf6
         BFEjUArNd5pceJmOQPqDcmo68jnXIWyjSklz2Ju+bYY1kaIIqQymI+lRw0YMU0T1C7G1
         330cKzgX9drPtUvdH8cvm6LfFg4MQLgHOxCPLlYejHCpNELeo0sNLAKlHwDfCwHc7dvQ
         kxEiAJiZ1eFRDiEAYj8jyACUqrewR+0EJEX0OZTuFNEQih84hdrwSyjG4Vv/kGpFFfuL
         f51ED3SUgwCQFzqnk+fa3nFiFit1f5LBDj0+k71HJCKFH6ZVRQ8i+PNV1Zs8mxoKUcZu
         PPNg==
X-Forwarded-Encrypted: i=1; AJvYcCWgcFWntM90sLCcyVrbKUU+6shDSLaDo8QFtyExGKLbBnrHoGprhsD1bnzGszAeyynrU8znjbSy53RvIvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLbB/7iLZaq9nSCO1vLMb4OqTgW88YhhzMlyxo1FdzOiJzSIK
	0DXe6wgCzkrLPBpjwFoY50OuHUApx5rLefoil6bQGdxbYo3pVgs9fi0JuqlIKHZ+YAdQGnGPWgm
	UFsFPyy+8Y1ME7ZnMjnWuwt3G5avXZeSy+RHRQMZqSZyhpV2Z2kX6kSpRumgCgP3VGNI=
X-Gm-Gg: ASbGncuh3ra1KYRWTEa67MfEknrraiRYehDwu1R2+B/2wC4u6f8EJ5q5X4WNQxSJKf0
	Tv+5wSZ1CM9xEBQiziZOf6cf76ol8waLX1nEg/xaIxcIICYaB95ExouJdbKhAOpQ4kSfyl9bNKO
	8eJWnUL5OTNz65pXz/EZ4ARq5ZviMpqvhxpSPGAUesu3B6gfVIVW8jeNhunCTrMLWQhUbtO3LtD
	+k/AjmZ4R17oBG8wpeQE8CefRzLjy9TB+jPyOlnKpNMPcqchKtaXez0MKoKFuN0i/g/jPu4ZeLL
	tZW43DyYT0AEm7Ve22iTBa3an/KA7Vq50m7xzvOflZmoA1dHUN/jsv/KJlSBx7hLd6GQYsKHmxo
	rxpwWF5kO5CrmxZAmOLdVmzS8X41YqjmkCMPSRHHxQGi/O89h8G8R9Q==
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id d9443c01a7336-290ccab6c0amr11702695ad.51.1760652223247;
        Thu, 16 Oct 2025 15:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdlNyditaaAKOFd3CyrSvZAeteR0a/ircCtUxjXi9qCn2mN27imlOzHsdxn+P/3lQNSL8XVg==
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id d9443c01a7336-290ccab6c0amr11702295ad.51.1760652222695;
        Thu, 16 Oct 2025 15:03:42 -0700 (PDT)
Received: from [10.62.37.19] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934b0b5sm41340775ad.38.2025.10.16.15.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 15:03:42 -0700 (PDT)
Message-ID: <1d300d0f-97c7-4538-9b14-4216f8762a1e@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 15:03:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] media: qcom: camss: csid: Add support for CSID
 1080
To: Bryan O'Donoghue <bod@kernel.org>,
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
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-5-f5745ba2dff9@oss.qualcomm.com>
 <5f0e081c-30f6-4ff9-b8d2-2af0d87efd23@kernel.org>
 <16def16e-fead-4d32-812c-5672773ef3bb@kernel.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <16def16e-fead-4d32-812c-5672773ef3bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f16bc0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_bdMYa0xl-006hGExtMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: NUWvUMrgjjdbUJwZzZzJfy7haKOxXmz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfX0465KJoRNr7h
 3DOv6f0PPqKaHk6KUyl+kEGBYVmnCFmd+Z0PZTkApK2xGr6m+NrlW5KTWPRwexrIWHxcrrCocRg
 S5GTNiCRJLk0GUufcVJfEwiUH9QaCII85SRDzLDwrXcdnSWb48Hums+Cu//4ku/fzbNofrebPx4
 G08CWL+FHX2SS3qhxISSCX9TPYD8JDT/iw6mmmDetwCarDW5y8Q/iMEGO6/wcU6j8o6m9Twcy4t
 h6HDDj0dzKy2dVMW5dpMQzumK9KK55dTomHakcwJxYmYh/Yl0iFfHzSeT7eJ7J/mz9kKtf9RPmY
 edZTuteJapz3F1n67xDD9W5cAa8holN8edO/0idMjiDfUwDfH4tD0jK9ta8HtbJZ7COe1Q74CtW
 mRK88v4x63smpmblgEwgU8Z3TCcdMQ==
X-Proofpoint-ORIG-GUID: NUWvUMrgjjdbUJwZzZzJfy7haKOxXmz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099


On 10/16/2025 3:18 AM, Bryan O'Donoghue wrote:
> On 16/10/2025 11:04, Bryan O'Donoghue wrote:
>> drivers/media/platform/qcom/camss/camss-csid-gen3.c: csid- 
>>  >reg_update &= ~CSID_RUP_AUP_RDI(port_id);
>> drivers/media/platform/qcom/camss/camss-csid-gen3.c: csid- 
>>  >reg_update |= CSID_RUP_AUP_RDI(port_id);
>>
>> and this in your code
>>
>>
>> λ ~/Development/qualcomm/qlt-kernel/ linux-stable/master-reviews- 
>> oct15-25* grep aup_update drivers/media/platform/qcom/camss/*
>>
>> drivers/media/platform/qcom/camss/camss-csid-1080.c:static void 
>> __csid_aup_update(struct csid_device *csid, int port_id)
>> drivers/media/platform/qcom/camss/camss-csid-1080.c: csid->aup_update 
>> |= AUP_RDIN << port_id;
>
> And now that I see the code side-by-side - also please use the 
> established macros and/or write a new macro to follow the established 
> pattern.
>
> There's virtually no good argument to replicate a bit shift or twiddle 
> - that can be functionally decomposed and encapsulated in one place 
> and subsequently reused.
>
> ---
> bod
>
Hi @Bryan, sure. Both are essentially shift + twiddle, just that in this 
patch, both are happening in one place. Where as in gen3, the shift is 
happening inside the macro. The other difference is that on Kaanapali, 
RUP and AUP update registers are separated and hence need to be handled 
separately. But I understand your point about the consistency. We will 
modify the 1080 macros to be consistent with gen3. OR we can add two 
macros commonly in csid.h that takes both the base bit (RDI0) offset 
within those registers and also the port ID to return a value with the 
bit set, just that gen3 file will have to call them separately from 
within "csid_subdev_reg_update". Please let us know if you would like 
this. Thanks.

