Return-Path: <linux-kernel+bounces-878088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB7C1FC09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B071240695A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81D3559D2;
	Thu, 30 Oct 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nThFwbBZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="epUANSGN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0E35581A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822668; cv=none; b=un6K62oET+3CGzZYRztRjy6EZYebVOONVSMJ8ONYxvHPma1sEyjl0XPnsxfOboEMdGKI5ZSAj05wvda/ykpre0+y2L1ru4fe1x40gB1KcitB3lqQAeD7QRMjiBG/Tmr7cQKkAlSHLxtjjg7PlNN6kLfcI8tQ8IV1A0ZKPgNUGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822668; c=relaxed/simple;
	bh=fmpYylNuAJmlqFeElJjlI/TjczZxhu6sPCw11kOv1FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4eMJ2il9V/8gWGBcWQbHrLsh47cA/fMJb+x4nAylBWG4ZEhxt8s1FMcRvLV7lBWS7Q9WtbYxGANfEFUUC50g6fWxpy+nwszj1WNonA6MXWeoCTeVELryMMnYX2M57M5m+zutGB65dgiN+hRKleGrOwLzSN6Zx3n6WdE8jWtE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nThFwbBZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=epUANSGN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7hHsM1579018
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pMFfKO0Arp0PpNimZso6vlYJl8HCzGUjKA9UJmqi2NU=; b=nThFwbBZy2cQM/W5
	oRoiDY405VdGO2Vkvb0AqjtIBcZu3hq3bA7hygdxWe/1gfZoUKEdVlKA1StohLJL
	Y9KfWfAI4DqspPbqqQjwPb4NHlZZbmF23wOrbExYNBssSiS0lvxJiymZXPOLSW0c
	gIc65glDS7BG/jfdZo5+xPpvNpVvj3LxVOn7XyUPKI9BDMss8nusbEWJb37fZGEO
	b+uLw8yt1mMCdFZAS59gVplKL5LxyfwjAQe1dVvwSCcjOZS0WONJMAZCgRjSHBbj
	UxfNul8NOMp5PBARG4N9KyKhwMzs0fxXr25QSVGguRU3QCAHUn61AdI3zfl6DRP7
	+LpeTQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjej4de-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:11:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87dfd456d01so2952806d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822664; x=1762427464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMFfKO0Arp0PpNimZso6vlYJl8HCzGUjKA9UJmqi2NU=;
        b=epUANSGNs8c3D1adMBAl8sQFh4Vg6y+ce5rSwh4nuBDY1PuAGXe2IZsOVcCa6h5iv+
         fSBtGzX7rSTVn/ha+d9j2JPS+0LNA+WpYRtSv23YVMcR8KdsXn2zFp9oItwt18SH/6A4
         QzFem6L8BrCqBJsmzeOVr252ECySFTLCViH4nmKpCy47RZtrX9ORCAR1+ZaXnCnAe+P5
         /WepDqCB8FmmbUopMNXWc3dLG7WO0fCPv5B9BYXJvlHCRmsgpd6J76H/fV/S75oFuQVp
         we8UvMQwipTb9UZJskeokd2p0L/FX/GhWO9bESq31MCLorPixrGi7ZWOLYsXYs1Ivaow
         YFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822664; x=1762427464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMFfKO0Arp0PpNimZso6vlYJl8HCzGUjKA9UJmqi2NU=;
        b=BkNcC8VeCvYRycaoyMoz5bJNhYbOoK5ahvvDtqOD4XbhS6TIyKXiFuMmFR6kKnvRGt
         2YVEMYWu+kN/sUtuXegYI7M2Ad4+L07NWhInmtYOkOqNB0oEER/MxX7RcBcbsqrE4uUw
         nBF/V4MCZhp/b8Khx1oeznpVOtm8mERoy/qCuOuqgfiIFJYfgEF9RX6wdPdRcnt4LTP2
         81nJLGdnZBjNUoVcBRjGOLX6UbfyVXKNDvmjvaKlVf398HZAIWNp0MT5Mpa8cWkRORXW
         LxHhMTR8kZYd3e9WQ9XKp47hbxBjVelZWrS+ct9gCHcZZg308Y3WZD8DFUsQ0SUMMumj
         +aHA==
X-Forwarded-Encrypted: i=1; AJvYcCX7z5m1vFshmgiXW+2NPIFMnTKEprtJaTaCa3iYeKbxEhnK7eS0b+JpOTeQ728ItahMC+k3GP6kUpflDvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQFmgjnUKdjpT//IrvpAgueD2nejNuXoZPDKTJtrmVOGIR/p4
	8GB8PkuJFfFyKj++iblJDSMVwjKvsWy42++KOBB081WvipSwtGlXXZsTtZoioD9LLlSalzpJF+P
	mticXdryeVD7J9zVEsXTSQF6haJKHhLqPuJGYRgglSeHAGbPhrj4aiyKAKLDQa/u/JGw=
X-Gm-Gg: ASbGncvxe4EIosu1Z+2gWfAfKlb5eZQfVpHu42T6pb3RJ2AvgPFitzz1zE+LsEqAaUV
	olwbiO6sVWsqgzy5/DFAGMnwyg5Zqz4DN9/NYqUSKg9mIKDLNVLyLRG/ZabQJHTxY88ZUDk2MPR
	AYzp4AF4rMursjhDn9ESjpVMZSeEdR3D+tvBXDp8L0IjZH0am4bh5f/3P6Q5beUi+02SQ0NCN2s
	+IbUCUHlrfL+OjstPadK7Z5IuNfuk7xcpv4UPwsRrFTojAXMjONJdpNC2FAEevtgaTLoYNHOpmn
	5NC5S7znzc+AMFIIFoIAX04opG1Eo5/XkJedC2L35xIruF5TFrmikylbk38UZdAy4n+/MMKAeaa
	CCXRlBpBgp1Zq2k4dELyArDRaVdS0js7bbKy0bBJRaZKlT9+PyXpqAQ7F
X-Received: by 2002:a05:622a:93:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4ed15b96605mr49603051cf.6.1761822664442;
        Thu, 30 Oct 2025 04:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpFUZiuil/RskYfXLfvvpxx+bsyR91O1/o4OpX8j5gRqT/vHxdsw9YMsVYiyR8GLWNDVwovQ==
X-Received: by 2002:a05:622a:93:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4ed15b96605mr49602671cf.6.1761822663942;
        Thu, 30 Oct 2025 04:11:03 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd116asm14888487a12.33.2025.10.30.04.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:11:03 -0700 (PDT)
Message-ID: <98da2c17-764d-43db-9b13-d950078ba41c@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 12:11:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] clk: qcom: ecpricc-qdu100: Add mem_enable_mask to
 the clock memory branch
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
 <20251024-sm8750-videocc-v2-v3-2-6286bbda3c8e@oss.qualcomm.com>
 <102d9042-49cb-4aff-8b93-a882ed8da27c@oss.qualcomm.com>
 <e308a74f-1724-48d4-9d1a-fba6d06a29aa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e308a74f-1724-48d4-9d1a-fba6d06a29aa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E9qf8IMRHmy34SIwGHP8g9mNeoWv0KsV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX9Maqc9N8IVC6
 wCgTZTsklVPlWZdSrXwKOkhoR4/OYai3/p0LJzpT6sm04ZQV4auQcD4j9Dcf5XR5lX7GKMYzL6y
 HB9mt8WCKXYzbbOv06WYgR9FAa54rM80tKx8Bzk405oS7xVIu17IYhPp04PlCrvmZgHV0cv9Eul
 2J24pYNBMQOGK8DsY0YeMgznFuA+PqxgSFBH7LKcuQ8zwLv2d0kiuIC3naOLJ/9mU4t0OOcqvlq
 Zvn+PJutwyiyCkszTPFf6Qf4BqJnuvOy6ghu6/j9rAflLF+uruk3XqByb5toLKLMkyDEOFd3pPr
 mV6jkfxP/bsZpfyy5uMCjYTctSdeVcSTTGzspQSh5Uk9xuew7/8Wjc6PTU0NSkZ1hsiUN9y/jP4
 WDC2hHejNPBGBJuG4NM9JcWU1vfPlA==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=690347c9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YgdUf8-DBacfkLe4iqcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: E9qf8IMRHmy34SIwGHP8g9mNeoWv0KsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300090

On 10/30/25 7:24 AM, Taniya Das wrote:
> 
> 
> On 10/24/2025 2:09 PM, Konrad Dybcio wrote:
>> On 10/24/25 6:24 AM, Taniya Das wrote:
>>> Add the newly introduced 'mem_enable_mask' to the memory control branch
>>> clocks of ECPRI clock controller to align to the new mem_ops handling.
>>>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> ---
>>
>> This probably fixes some ugly issue, could you please mention what
>> the impact/problem is?
>>
> Konrad, this isn’t an issue. Previously, the ECPRI clock controller’s
> mem_ops clocks used the mem_enable_ack_mask bit directly for both
> setting and polling. However, this approach didn’t apply to newer
> mem_ops clocks.

Right, the videocc patch you attached makes use of this. I didn't notice
previously.

> Based on the feedback from v2, I’ve refactored the mem_ops code to
> handle these cases more cleanly, which required updating the ECPRI
> clocks as well.

Please split the changes into:

1. add new struct fields, explaining the reason for the change
2. update the ECPRI driver (so that when the next patch lands the func
  isn't broken)
3. use the new fields in clk-branch.c now that all users (just qdu1000) have
   the required data filled in

So that the platform remains functional at any point in time (which is a
policy because it impacts bisect)

1&2 can be potentially squashed, potayto/potahto

Konrad

