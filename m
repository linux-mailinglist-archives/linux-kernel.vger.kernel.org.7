Return-Path: <linux-kernel+bounces-877719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC8C1ED98
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF2D19C419B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67923338910;
	Thu, 30 Oct 2025 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="doq3994X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WETNeMV6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD83385AC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810658; cv=none; b=rSoEZwxtdnUV4vvH+D2ZUec2PDLQFOtcd4edwHsEQgL6FC3CI22CI5bHPXJhLBx92e8r9j3Xu2dCexDJArkCAwPWhMsldx9F41woXwuw9PLC/auxWtUPaNQC+wvH5nBN4ITAg/Or08vwSwmg8XP9Y2E/ZtIVGei7dtuMhwATKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810658; c=relaxed/simple;
	bh=pXjnDfOPXpQAncHdHfuPL6JFTlWW9bZTNDuiEUQ4R70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tl/dYcj4lhaZzzL8vVBZoO324E5shYJ+YQpTG0n7l0Ugdw4ID9Ub6b6jms4qob+UbPDmb6Wx1HEGFPvZfOfxHkpishXiwil21gXB4BB/+yCXJBO0q4/xtE2TnzUvAmw2PhUTpT/1FRVZtv03YQnwKlUXotw5M0fzOaUsbSX1ejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=doq3994X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WETNeMV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7VoIV1598489
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B27lwA289hOVFDD03ZYundVjCw8IiiBblmiysgXXmQk=; b=doq3994XaUhaE0rB
	KLEq6rcU08BZueNFtgYcY6bT68ZJXcagqL21OVCozmGfUSFEBCWAMrIREmyQ9OkE
	71HYXBO3JRL+x1ECWXIwnQp35IQY0k87LZetNKSWyAGB5oU6Dfrcl7sF2TZOIDga
	ZC5ZTS7XGKaYiBEiY0UEXbJFo90yLKa4r+A7HPr8ZsIVWlomwSbmJIcMVrbGa0uj
	BVYNlL3H+vxLbj04/Ef575ZiwGu55SZ86vnUvYQDkx5l5avGrWntLF3PqES3JC8c
	dwJUEmMTV9gXKgyU07T+x+0UK4O2vnJfelznZEa4J1qxVvpETxk9HhlmKOzy18iD
	doV4Ag==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7sjt4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:50:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce7f76617so1255917a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761810655; x=1762415455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B27lwA289hOVFDD03ZYundVjCw8IiiBblmiysgXXmQk=;
        b=WETNeMV6Mezk7WMGo0bJbTinpEQq77lANZ0w0u88/2tuyIAhNrTRiviQUcThfJMk0l
         yavfEniJLo5vLWL5bch95v+ARVySIdYc7DVjxLMwBCOt1KySUx4ph3NA4zgn0DfMz16v
         IhSUacxdolEdbedjaTwzT6/dBldf/d0aQ29yop8rzmqBneg07ZedSAdkMbQR/9ihYQ8o
         bbLKtfst8zMzs30gg7Os6W2MVVvMKcbEDt1VfIPLMqSLxxI2j97TRt1QzZ7BRgpt9YOT
         mJ188mSrsJpIlRCdgv+7l5psKO4FHGQh4JjALdiZ9hg9AKdTdKkFkukUILhRlDlfQ/4R
         uKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810655; x=1762415455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B27lwA289hOVFDD03ZYundVjCw8IiiBblmiysgXXmQk=;
        b=k0tmZrIbBUzFiZsdtruLpPmvQYunQVxyHvhLkSPJx9ZBySHezqPHg8Ire/RaJI/y9t
         4JuoqMVAQdfpOo3/SaO99qoqQfNYJ6N18kjpMZTPpoMqJM4SbRATCY/SrnegxK0Lkcx6
         8UjmABpTJvR6QtwhNdgIEqiefE6YbeDbZEDXhoUDMOuYMAUMGrp5HvAEB8jNm4Yciz+h
         Vlcs8ajDAvOowkYOzQaq3qBR2gN4pTMorQba4iOdIGuL7SrLMmPtKqYf3BRpx51Vd+E+
         ts9RHqSMmVH2N20uzhoLSk31x3O7KQQ2MkK9wMl62BP937Uy2CY5OTXjvRmgOho/AI+Y
         RE1g==
X-Forwarded-Encrypted: i=1; AJvYcCUtUeyCXP+ZGXXV8ly95kx2QnlJWQCv0WqJPNsmU1dkf5nAaNM6rAZ16a5RM3jhr/ygUIv7ilG6saz62ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYnh0hr/vTYD1XekBzwiJgRE2thHn8saZEo5C/4Fr0hrhvMe8
	IjB+BXqTqypXVcnGXLxJB07z4+32l9dk7X1cno3abUl5NMhxVFz+UazEhxxloYU4f/zdHbAZ+wU
	dj9tXx2v39bzKWzxzTMifMkhV/SUVN1nudLbv9r/fYZnKcIp1RmmoSwzen5kRMTqBlfk=
X-Gm-Gg: ASbGnctCN9vX8a4CHFxW9xiMXC0KlrBDKsK2cgcaqcz75PYh4TIPsf+pcqm+aerYAUN
	LquIvHO+AW6vuDDHamkysiCSeKHTDLOqMZtQv8OYV2uz5Et/OncLz/kEL5CvIUEpmuhLve8wFb9
	BiO+K0Tc12xTtYE4GvLyzTqNoVdl4RSlulQERWRS/vkL7jE9YcnpR+gTJ0MahF/idqniDyR3zZS
	DwgB5IabxUw4moDP8rpwKl5GnPbTeBC2XnfZMAwglEpOD6fCDayr/0zog3e5Kx7sXsNSqwU/wlg
	D05Hie8EX2ufMnTUF2Nr/xPAk6VrFrdXIhKfnunBB7nHU3C/KVvX1LfwUTmPItFHi5zG6lxYk5M
	S/XUDWdXyyDkab8ngj/c+YbNBsChQIhoB6rsbWrekPUkng2KgZSGCcLmillBWuPFIZY1W
X-Received: by 2002:a05:6a20:1588:b0:334:8ac9:bc5 with SMTP id adf61e73a8af0-34786a1374bmr3111387637.36.1761810654542;
        Thu, 30 Oct 2025 00:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4wdEqcvhO7xoUpldckKiNV9ktmOba6appBpb+kPac+Z78FjRfyPLDIShGA0wr9QQDPS9J5Q==
X-Received: by 2002:a05:6a20:1588:b0:334:8ac9:bc5 with SMTP id adf61e73a8af0-34786a1374bmr3111348637.36.1761810654011;
        Thu, 30 Oct 2025 00:50:54 -0700 (PDT)
Received: from [10.133.33.37] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408757csm17590625b3a.59.2025.10.30.00.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 00:50:53 -0700 (PDT)
Message-ID: <2f0b6ed4-046c-4257-9cb2-8c7403736bd3@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 15:50:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: remoteproc: qcom,pas: Document pas
 for SoCCP on Kaanapali and Glymur platforms
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
 <20251029-knp-remoteproc-v2-3-6c81993b52ea@oss.qualcomm.com>
 <20251030-venomous-apricot-falcon-b3fd64@kuoka>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20251030-venomous-apricot-falcon-b3fd64@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=690318df cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=86O0OiZcg5MvzqARIlQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: tZfbvEXmIJ6RVxQ5gwAJHN8GNMif5oK-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2MiBTYWx0ZWRfX6jZwqbUnQxUW
 Rk7+IRr94Mnv3aRSLJ4OUbP5jI/Erv2molkz5X/hYd6ZCJeEBgUbYW4Ua37VZT80Jk6vdbf3YNJ
 90y8massGay5/8TYxm7lvWbrH3mudJj7MoZeKnYur7TMm7BWsOexU6Oh+OgVC0L9CWT01GhHMvZ
 sz/WbN104DGY3YnVhTT8P8MZ2VpObvC1OhDWIVWnBJu7Lmbp9tewEZZlsxtYGfWMNNyGl3sa98o
 YtClQuvKwqgHzO372cQyUZ6QqNE0jjNl/tKXYwtJrLBEK3Lt5WIQ13PSZev+zCq49yxG1Xf+Hk1
 L3z3xY9gG7TEHzgHG1hfcPS08Z6k1BqdDdUqIY0KihxJKjB22EKQlvZ/TL6OTVGAcVENldGReS/
 O43WjL86pzWnnmiXYcV46h1Eawcvqw==
X-Proofpoint-GUID: tZfbvEXmIJ6RVxQ5gwAJHN8GNMif5oK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300062



On 10/30/2025 2:27 PM, Krzysztof Kozlowski wrote:
> On Wed, Oct 29, 2025 at 01:05:41AM -0700, Jingyi Wang wrote:
>> Document the component used to boot SoCCP on Kaanapali SoC and add
>> compatible for Glymur SoCCP which could fallback to Kaanapali. Extend
>> the "qcom,smem-states" and "qcom,smem-state-names" properties and
>> add conditions for the "interrupts" and "interrupt-names" properties
>> in the pas-common.
> 
> "extend" and "add conditions" but your patch:
> 
> 
>> -  interrupts:
>> -    minItems: 5
>> -    items:
>> -      - description: Watchdog interrupt
>> -      - description: Fatal interrupt
>> -      - description: Ready interrupt
>> -      - description: Handover interrupt
>> -      - description: Stop acknowledge interrupt
>> -      - description: Shutdown acknowledge interrupt
>> -
>> -  interrupt-names:
>> -    minItems: 5
>> -    items:
>> -      - const: wdog
>> -      - const: fatal
>> -      - const: ready
>> -      - const: handover
>> -      - const: stop-ack
>> -      - const: shutdown-ack
> 
> ...removes them. So no interrupts anymore :/
> 
> That looks surprising if not wrong. You cannot remove properties when
> you want to add grow them. See writing schema as well.
> 
> Best regards,
> Krzysztof
> 

There might be some misunderstanding on your comments for v1, so I removed
it to allOf part and add "if-else".

If it is changed here, we need to release the constraints like:

  interrupts:
    minItems: 5
    items:
      - description: Watchdog interrupt
      - description: Fatal interrupt
      - description: Ready interrupt
      - description: Handover interrupt
      - description: Stop acknowledge interrupt
      - description: Shutdown acknowledge interrupt
      - description: Pong interrupt
      - description: Wake acknowledge interrupt

  interrupt-names:
    minItems: 5
    maxItems: 7
    items:
      enum:
        - wdog
        - fatal
        - ready
        - handover
        - stop-ack
        - shutdown-ack
        - pong
        - wake-ack


Thanks,
Jingyi

