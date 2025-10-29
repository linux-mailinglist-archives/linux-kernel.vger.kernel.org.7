Return-Path: <linux-kernel+bounces-876759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2763C1C39A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C741893A32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10D33B6C1;
	Wed, 29 Oct 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jurMUHDU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xp4c7do7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2E3314BC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756191; cv=none; b=IzrKfJIF3weh4Y35WrGI80qrtxfpfWnNjchIRIZj5UeGo/SfwoARidmIy3yDz77fnKzpRc5GxU7zsfvFr4SXGMyY/g1/aEg/7Su7AQYKI8vCWxWsxCHfg9jkLUkivLwaOoM+Fgl2gD2K73MtmXZ69fiFBryITy8Qkl/grGxLb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756191; c=relaxed/simple;
	bh=CMWQj5jtGtAgppiK1n11UOBvfGJAKubZbQAB7EpoUA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN3hGGm9b+7LqyOcgLTiPvBg553IYbh+NrVUacW8fb3/apJcTeamtKYQ6TGqaG91otrj1cYllwc9CY6a96vl7wB5+gX0H6p5oyyLzUrj3WI/A9/i+Udf7R3GNV8DxyZ6Ds4dRMFrh2BIv9+w36VyeyUjnm4iaRWDx3wXwFuD6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jurMUHDU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xp4c7do7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TEhGOv816673
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YxIKHvu9IRyd/kr31TQ5+bn3d7b2acGDQxHpx6QiFGw=; b=jurMUHDUf/mNomJa
	+oeZhdG+83i+F9+e+daqj3ssXJGeXirYKNx1u5hIov0RBJSXrbYf5MNDxSmYBTy+
	z5VDwtI3nXmbitvuF4hOr5XGdm8kXpmMFYePm+iChGdGrfne/bEnLFZC+ctmCZmZ
	SCK8zEP6JoFcNZrQKO0fuD9J/xedI4lR7N/85OaAfWTLBuw4QTWI5qliV7S6RDVG
	Z6tfQoptPVHLvTFxiKJqRw/WAd7IevjU99fQo0vRDyAMZSaJYgMJruhXGkjcIh7G
	cECyCPQ0833F7+feQ/JbCBWzlRyHyK6TgYOPpG5mrJBfLK0e1VJafSC8w125m2pr
	L4G/4A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3mxggdu0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:43:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5529da7771so4452167a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761756188; x=1762360988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxIKHvu9IRyd/kr31TQ5+bn3d7b2acGDQxHpx6QiFGw=;
        b=Xp4c7do7fPSwN5tGsalx1vBkHfecOw3mzsyAZ3zc2cbzZLHzYatllliHdBli7XpkZG
         RKbsvo2hHFwxDG0P9lG0x76jGxZl1T/WQvT5nC4asvX8dgZYbvTgspaVYodIxhhyhAbn
         JSKFUK3ujun79RHbmH8U2ofXdbffznsJvzeHhrpbVXYHna+2lQUP5frFtX+vlHd8rpnM
         IqHLTNGWBCW/cKLH7S9aw/esOdIYgwYHqXllVzYxGAVEqFu4Eh8gcciUK0d0ErBI4UJ2
         eDUVnYBWOzvPVuNjcOH4q4xzoHIkJe9LBgYCrYUgkHs50Q8+5maKVDeJDDzstPyXthb3
         bgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761756188; x=1762360988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxIKHvu9IRyd/kr31TQ5+bn3d7b2acGDQxHpx6QiFGw=;
        b=vkV8U3jtDV3POwytaDkZDUde3CTF0isb/uHWo4v1aTNgxfhqGE2utWKilVpE949mAD
         duooGt7OMGC+d0xTrObTZrKb4HjYuXIQs9YGNh5YI0lwcAjfibE/lZUrkIQ3/pu5pZNG
         G6FSHu4GaXZze8X6P+xQvtQzHExrlEVBcC3zlKsiADvEtwuge2a2iz4ClS9YPsybhYdT
         WAONIbNMdpVNj6bjbzAIAMDwSgAJAEKIt9lwNTpNfqKS0g2yjzHriR3oOOsvhaGUu/13
         iSOXLzAX8a/yhpLAyDewAHMouhbWWg9NWHJGkcJ73H5FZvmNB6BGboCwYfSIOptsDXSn
         D36A==
X-Forwarded-Encrypted: i=1; AJvYcCWTEOAiXHtjQJ43wXTxvM7ZQ62EvhCwWNFrstfyjWw8q5yOlRQo4Gznk+8vdhauJFqr6vS56OBoKC+IdOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9VeRpCO85JGqSGEPYI4d29hzM9O4Efn7uckJUMgoSfo5sdnhQ
	lmC9iNh6n3nHDcunI2Kym14K+5zJLR8fiPOPBtt0P9tdKimNL+I7dOEThDNi/qbi7geZ5jdg8kG
	6Hrbw2K6f0aiHag5ObT124Iy8uw8Omv4F+Se0XEh25pdvRnzh5U/OhAvDwataakK8RGA=
X-Gm-Gg: ASbGnct0C+KHw7Fs24po7M/xtDQ0b3Vtc9eXbcMGupGzAn1GkwrhSfm1tMdiup3s9V9
	PUY5BpNCcq+hZtOIHTfAtSmqtaMt1WLmClsuOpit06fUBnnX0bWebcp1Wb1zjsYqgYf6zr0JHXK
	PAut2DWE2oFyK7qaV+RKzNOf2eUl97hJHM8FJYyRr7kzbtS0dFsgIeeQPZMuXqzTUxtJs7k/s5r
	O3+eo0rF3ZyMf2GMpoYnhohzk9Dpphtk9Wo+nouA9K3wnMGhsCE2kFA8KrSBuEk9YLSRUKAhmIN
	YwQhrcGnCdRj3MyoJEU9F9RMhUWz0Fh7ltNFVOQy3YRZsxMcGwnDfMQi2Uw0BgbR+u5AXa+EJRi
	SYi1BoqVl+QdxJAS7p7SFbE9+u+XYtnm4zg==
X-Received: by 2002:a05:6a21:3290:b0:343:68f2:3728 with SMTP id adf61e73a8af0-34653334edfmr4521755637.15.1761756187883;
        Wed, 29 Oct 2025 09:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa6T49KpR+tP4OKn61E0XyxYqkZWJ0/qeQQmMiqapSzHCPzMBLcjoz5QGBVzIZXALq+pjJnw==
X-Received: by 2002:a05:6a21:3290:b0:343:68f2:3728 with SMTP id adf61e73a8af0-34653334edfmr4521722637.15.1761756187354;
        Wed, 29 Oct 2025 09:43:07 -0700 (PDT)
Received: from [192.168.1.3] ([223.230.47.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140168f7sm15655726b3a.11.2025.10.29.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:43:06 -0700 (PDT)
Message-ID: <bfc126ad-1443-4b9a-bc8d-3619606294e2@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 22:12:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 MTP platform
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-3-krishna.kurapati@oss.qualcomm.com>
 <r5zjb7v2ngsbx2y63tmdhnm4gbpla5fki4uzpjhvn7sqmzsqi2@7637rbudt3z6>
 <469fc3aa-9b95-4b30-a704-d568a830452f@oss.qualcomm.com>
 <vmtm6wy2ldvobgl2o7cqdtknyfg4fup2pqpddkftnhzs5tgqrq@vbo4j2gmr4px>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <vmtm6wy2ldvobgl2o7cqdtknyfg4fup2pqpddkftnhzs5tgqrq@vbo4j2gmr4px>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AuHjHe9P c=1 sm=1 tr=0 ts=6902441c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Wzgei3/ilxDouSaUxftnwQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FR6T9U9chX6Biide38gA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: KU6-bs4B6-lJvcviWOvo6osrzH17SLGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEzMiBTYWx0ZWRfX5/xwMm5jKQMQ
 ZrzftQzkZM5wavXmm92xXIoFyp+rziEplq2H7ywcGSis8nmkct2p9tCqdgTnkCArRN/3JclCLH2
 WFl5LjuVz+Aawd2/40NzYXChhSx9EYueQM/Ajb1gOTQhmb58a+ry/lrQYybg0IDKbDsqug/1r5b
 sszEQ6+WhuVs0DhAtimVm9pexpjHZhia1oXtyfQK2S52D+J5mQ8UCuBzCeNF/Uljiyajto3KtEm
 eZ8vkyFmf7M/1JwyKn3X0dZUSvw9K3r2y6yjStrEJgMezdfSFB7bfrOdYadekOM6e7ZzeOIwJ5c
 mCIB6dhKZouyJqD5RNtFyDqV+Tq1wiipvWpA2GSBD0SJNwjK6oynqPSINu0FF+5xLxNEAt4oUfn
 G0GR+WURxysAuuriIZfnA1CqWxgeWg==
X-Proofpoint-ORIG-GUID: KU6-bs4B6-lJvcviWOvo6osrzH17SLGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290132



On 10/29/2025 10:04 PM, Bjorn Andersson wrote:
> On Wed, Oct 29, 2025 at 09:20:48PM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 10/29/2025 2:45 AM, Dmitry Baryshkov wrote:
>>> On Fri, Oct 24, 2025 at 08:45:20PM +0530, Krishna Kurapati wrote:
>>>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>>
>>>> Enable USB support on SM8750 MTP variants.  The current definition will
>>>> start the USB controller in peripheral mode by default until
>>>> dependencies are added, such as USB role detection.
>>>
>>> Which dependencies?
>>>
>>
>> Dependencies like pmic-glink and adding remote endpoints for otg support.
>> Till they are added, we can enable peripheral mode.
>>
> 
> But this is 8750, Jishnu got qcom,sm8750-pmic-glink landed in the
> binding 9 months ago, so why are we spending time discussing this?
> 
> Why not just add the whole shebang at once?
> 

Initially I didn't add those changes because the series already had 
acked patches and I didn't want to disturb them. I can add them in next 
submission and send them out.

Regards,
Krishna,

