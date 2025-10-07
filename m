Return-Path: <linux-kernel+bounces-843640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B8BBFE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0D189BC02
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C21DFD96;
	Tue,  7 Oct 2025 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbRT3MvC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EE1A7253
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799124; cv=none; b=Ft9Nni1mZNXa3kFsokrtBb8TLW4/JUA9WWbR09gpnWWto7LvlwGV77eJ3T6rUhlSCMMrGZpvb2oZvBKWVfixDsUt6EJhWlByHTLudE5y6mZUt2iIeRcQ/T3a/WTtOO6fNnvp8OM92Wm3wZ8/LUwZR57hrNximraz/RfbqX+D/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799124; c=relaxed/simple;
	bh=bN78AEgja7FUP77gENw3DiDXom3H/G8fEsmu33m41jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FclMrzT3gergxihqBXIqCCcDtTEmcn/D93WidU7IdllCecLEmrg7cxg2+/M7XNX4pQXR70Cg9mqaEOfDGmdZAa+lrKg9++KX5VdB69IEqlKymbYROF78anr/d5vVFX/xXvQIjrcJr7wQwMTPnOBvsAtLEADaeU3wrGzGZn2p+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbRT3MvC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Ncx3P014632
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 01:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahrNSeb0NQWhBk3m/lb45NZJspf2/oAz6SdApzCbmB4=; b=NbRT3MvCpVXIy1/j
	yBsNPUnV+xpirXET0ZtQucBsmSEZN4tVhOuo63z61mDu4kqH+cS6kuXYd/c8LrhW
	wFIOpeowFn+oAGZS/C5hLi1zSd/ZXVWgcVUEyyY+ZoEcxgluOirk5YVimKmYiotb
	sHyoP65AvirMhuAHnD2DZTXNoKUGRW2cuh0IB2K+2F2SIKnwDYpBb72+wawiOhOr
	qhjdUHKuE5m1pbo0vLNzWdoOubSVjh7UkWp3oa/h9UJobxYRfT0mcXlw/mRcHP8T
	+7oSz/p0ss8iyKem9W6AKcW9aFQYSBshVXvFuTZ0kuhqVOvFNko2x13KhtiZtcVw
	SfoPgA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1njgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:05:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28a5b8b12bbso116085145ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759799121; x=1760403921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahrNSeb0NQWhBk3m/lb45NZJspf2/oAz6SdApzCbmB4=;
        b=foYuM6AY2ub0pACc9O5G1pGLr+EooBZD3cT93sAHv67gt8YLmgv3kcJ0oaKi1VAcZc
         ALGuySvLimALjsLrtsuXu+aFPHybUVuY3pKrnmf09LlgLPIV0NT7KRbKhqoyR/x1ro85
         Y+SLJO51Jan+knoU1OS7anvxtRK/N0nQQOlT0cDIoOrAppM+pShnqiBKQfgjM5gylDEp
         ISmc717n6VAfzNw1ykNteUUblaNn5RLZwWjuLvPuVNK3SSp9EFgkXWz8Q/Yoy9S9Eust
         IQgKM6KzmelgZrcMLM2X7TeYwL3boN3Qu+0Ea+0PiHSuByenyeSjZa1m+TjlQyiu537E
         /M3w==
X-Forwarded-Encrypted: i=1; AJvYcCWCMK597CvPspHUt2XWcoiV3Jy6V5erJcbsKLpGhqsdnOHkay3siyT8NnmCUsGOj7CSMA7J7VhR5IhBZC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb60/SlReQEROQTTu29gfpF+AiawTwjFJoGwbWHZPpgZFTc3Hu
	Y9QVBZ6UjppqUmfD3jBbH90Qse7NlCBimKuZ9YHlaMu7VMnu1+EuKjJY4cyTMDwVJzd1BTxHaxn
	8eCLQ+UpIHcFZjwWEmgrG6MqbEh2ziTVGDTykCknULE8OUe1koUigwUbr8N3f/Llk4XI=
X-Gm-Gg: ASbGncuAJoYDTvFcuR4GvK3ygjkq8Pr15NuEg5zKu0Ez9YmocvPeIwwE5gN91Ns6WGt
	T4Wmb3l75TA141QiEw0ZZMhen51B/QHWkcBbvvQQ+LNqjm/TDtH/hOOzGcpAxX2KJ5nuLO2PmZ5
	9r41ovR7KiPIHvZkkW4ZehzSev98X69YMaWjdY05+5I7NAw/aaV5DRSRjsri/vSzZyAn75Wc3DS
	Z1F4nfIvLgLBUSRQoahNa4dR+/ky3DOSV5qB2omgy225rxmfBdEXOnac9sqvpQKia2bsE+qH514
	S2MFBVIk+vMw73wW+JbYSlrZaU0AMtULQGS6mWXtnCs9UdumPF89Rv2/kNaCEFSi3ZvOVMRKZKY
	cr1OFoIRsacuX
X-Received: by 2002:a17:903:1b46:b0:26a:23c7:68da with SMTP id d9443c01a7336-28e9a5bf107mr191525505ad.25.1759799121219;
        Mon, 06 Oct 2025 18:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK5FlqZZWAVLLYWf7xgsddH7C7vi1Z0PSmlxL52MRXH9QOeZfRWq6du/B1w3IP8YVFcHH7cQ==
X-Received: by 2002:a17:903:1b46:b0:26a:23c7:68da with SMTP id d9443c01a7336-28e9a5bf107mr191524955ad.25.1759799120730;
        Mon, 06 Oct 2025 18:05:20 -0700 (PDT)
Received: from [10.73.54.138] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099af3cf6sm13327205a12.13.2025.10.06.18.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:05:20 -0700 (PDT)
Message-ID: <6ed9bd6b-37a3-36a8-a347-85429670837f@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 18:05:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 00/10] Introduce Glymur USB support
To: Krzysztof Kozlowski <krzk@kernel.org>, krzk+dt@kernel.org,
        conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
 <a6690fbc-0b86-4725-99ca-6b4cc477b4ec@kernel.org>
Content-Language: en-US
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <a6690fbc-0b86-4725-99ca-6b4cc477b4ec@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 48FUT_kugFkSY97sc4nf3MIkebiXJIb-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX2bXmUckAFCph
 A+KLBoKYBI2PU8ovzx/X0IZTjvrN9GYwmQVWCt3o4qo3I2mEt2SiNqKf/G/SPL0y39SPCR8wS7Q
 N/EeaJhPKr2QNeMfMQoOMyyafZsewc2gwVe35km9k0NVxeDxgM2080Pp+SNDFGX773IhA6G5RGq
 P6WHVX3HpjRhYgcIZZH24g71GQJxADFmcnbbTTQsXPxEKPaNFx1M9MijE7dXBCOOUKeOmpq4JUw
 jF1tn8DxHhf4prh0Ioleo8cdRXt9M5a2JxNC6O07dThGDaP8onLQnj1p8InITPXoVvJVnuE1GwM
 T85SkJMGG85ZxP78e4Z/Fzf9BndlqE89QCSOQd96qrEp/xIy2Jd3gem13Eo3klxQNMip1W6BYHz
 eFkTvhHxg4PwUgaaDZjehePmGyUEpA==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e46752 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=Zu9LzCyC9gr4H2Ik_2AA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 48FUT_kugFkSY97sc4nf3MIkebiXJIb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027



On 10/6/2025 6:02 PM, Krzysztof Kozlowski wrote:
> On 07/10/2025 07:19, Wesley Cheng wrote:
>> This series enables the PHY level changes that are required to support
>> the type C based controllers and the multiport controller.  The typeC
>> ports utilize a usb43dp based QMP PHY for the SSUSB path, while using
>> the M31 eUSB2 PHY for the HSUSB path.  For the multiport controller,
>> it will utilize two QMP UNI PHYs for the SSUSB path, and two M31 eUSB2
>> PHYs for the HSUSB path.
>>
>> -----
>> Changes in v5:
>> - Moved phy-qcom-qmp-usb43-pcs-v8.h into USB specific QMP driver
>> - Fixed DT bindings for clock properties for QMP combo PHY
>>
> 
> Where are lore links? Why aren't you using b4?
> 

Sorry, I'm confused?  Lore links to what exactly?  There aren't any 
dependencies here, in case you mixed up this series with the DT one.

Thanks
Wesley Cheng

