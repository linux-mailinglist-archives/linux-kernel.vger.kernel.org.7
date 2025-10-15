Return-Path: <linux-kernel+bounces-853675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA348BDC49B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033044F3972
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A81C862D;
	Wed, 15 Oct 2025 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mVAN7RI/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEC21FF49
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498115; cv=none; b=UPZrDfrBg/pPSsX8Fesii9OwMqARL45TIbrYEEjPVdSRFgM5qZK485qOQ2XkrZ3KFxm3GnaWwBEbwf0iQmmtxRTZx6Yp3aLUgX+ekwvD9aTo4Qhukjec+aeiW7zYf8dCpaFFndK3OO8LCICkTMUijsjlTzCrzPwpxvSuOFSVTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498115; c=relaxed/simple;
	bh=Z2EcDgOIRnYP1iO3bEVKH8ESk4H0ObpufOU6wembBn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xqui2O0VmJxgoq8H2BJSlObjErhDA2/V2hvFSZig5/r6I925XoM71v3lCl06OmmLdaol0qJvK1Swz0F8xftEQ9dNT7GvuOPggM/bOgEe0p28tEKerwMuIif45y7d5f6OrboO8lsNI5P308T9sYbsTQa21bxOJBq9bQvN5Tw0Bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mVAN7RI/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sASU016719
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z2EcDgOIRnYP1iO3bEVKH8ESk4H0ObpufOU6wembBn0=; b=mVAN7RI/A06bfnIl
	1gCkbCZ8teDNzbQuKxj9nsliOeh1IhTBwdOOUxHbzZt/XdLIgTALZH5D2aZoPnco
	gGefSCpJVDANTSVFWyUSNo1LO2xe5vpFLU5De4UhpCoN6W9G/IWpIrCSVcuIzc+s
	d4WboTsmBRSafPpZKu9zmCbuybIOII8gwvloOob0ITam/t/U2PBDs46pgPdhNlH/
	ELdmmkZR0HgWh3vp/1fW6qk714ttANC+xN+tiknE9xAe1sGEahFbAxi8YAqeaHnd
	1zrucOPv/S0orQt47wnG0FkT+ZnfXAMVa6z5y2hmFO/OTTrnh7cE0R7YW/RnPjVZ
	Wzvq+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt7t13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:15:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2698b5fbe5bso129551815ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760498111; x=1761102911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2EcDgOIRnYP1iO3bEVKH8ESk4H0ObpufOU6wembBn0=;
        b=jkJ7axNPAh7/2NnCypEUoGOtfSZ+xaZOiUPnASOTbv4qI9jTGMSKXMfgxqdki/87JS
         rvIse+dAWvPIbLmafyqjaSQTlwWq0ovev9Ot8HtVn4ObNwswTpKFUspMQIsEZJ7vsyQR
         RJ4l4h2bayWx7w7cqNvIsZleufSTi55StnefBMYdUjOA7JBKBySQYtSZYded039O5JeR
         8UbsznAkEJx3/xy6avn3VLL4UDMfz9JPJDpiY221W9tBDS89B/uU79zSPEFL4O+FPZpx
         5wmNW0v+XAa7S2LmPQI2M9LMXwVdr/J/9kVFfuAk6Hb5LUIC8trRPng6hOT/XH2bDHho
         H1hw==
X-Forwarded-Encrypted: i=1; AJvYcCVF2w0GjMhwBOb3XcXhBQr7fT1glj1y6bCMndFzrjB2uEaJMSj+BykMqqS6mvMZExmCIWrHmlpkMZ1iy3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0efO1E+SFAY7RAs1s+l4pAsJHBHjs5KQsZTQ5if7q2nOljoC
	qVbdoip/6j24qSgj+8cNjXcP3l1jPBHj+I/OMUJLwz8CyxfQujN9+A6YTdhiAW1dF5OF+KjlQMG
	lpLednNhXjbkam39SXXQ3zcXNdgRM+WVjGreE5AJQhn3xk1us4jS66EQp7qQaeJavn/o=
X-Gm-Gg: ASbGncvtAIaiIksSE2Nuq9DV8v01d4sFr9O2yJ0Wxrco8FY3baz5Bvzm3iVodzhrCuO
	CI3GV8K43SBUbkj7Wz8qMxzyCl9vJXJ9/ly/gSpQcsVF4Ddl+Zx/AoCOn41wQ8gU12UE1pY8vL3
	wVEAOSz0H9L64lzX9PIOi9ZzXJo3kq8B6rWxO6Fh6NgaO3odPyqA4b0vlh2mzZvQBDzErWYc6KN
	R8eN0oMeEgdC2dT+cWSIS7VbQir1ksu5WnGQvNWAgFtDgAZakuYLGavNPNOlQbxBZ2j7px8CUbK
	u/MxsBNo00erQwB25cOq8fqMl9TzRvTQYC603cS9AoGSwpppJaccPD2HpBj6WYGqc6xLOHEA+um
	0AMhZuYIqxrWG6G7OEKQSBoNnFntKFDT7T7Q=
X-Received: by 2002:a17:902:d481:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2902723d3e5mr379806615ad.18.1760498111434;
        Tue, 14 Oct 2025 20:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp8mRCfk/F3vxmV+6b5oqRQLgmQBXREp84fmteVqzoMJJXI68+BftcVdGldgZVlfhqzx5J1Q==
X-Received: by 2002:a17:902:d481:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2902723d3e5mr379806135ad.18.1760498110835;
        Tue, 14 Oct 2025 20:15:10 -0700 (PDT)
Received: from [10.133.33.56] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddc9f8esm13665626a12.10.2025.10.14.20.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 20:15:10 -0700 (PDT)
Message-ID: <446fbe37-3bf0-4dae-bf7d-b863f7fa3b4e@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 11:15:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
 <20250924-knp-cam-v1-1-b72d6deea054@oss.qualcomm.com>
 <CAFEp6-38buo3WafiiXUEUs8n-=SKgacMD44gGAd1pnEDAsizCQ@mail.gmail.com>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <CAFEp6-38buo3WafiiXUEUs8n-=SKgacMD44gGAd1pnEDAsizCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5TuDIrcJtOA682twWR3qnhMjguEarg2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX0SJj07oIafFQ
 vv88WOaq5czy6LMQHwmO0j4l13u5R/8KAmMVV2MVWLRH20yj4lFSQjS8J83PdVgbjRYrMm3CqU5
 2QYpPQR7aViYIQ76ajzBbp9UJFB0xoA1m3tDWGnN6rNKzYlbYGDxIuMHouuIE8svjIFrP2eVV9P
 BQLHJD9Rmxqgr/bVdXaEpzQQm7Rj5E4+nPVsBqiXF6ZRYWlJ3dkG3UIjbulCxm8shn3mdXbl3O5
 3I87CyI9OgZw7R42SnrBIa9R7klIUSuE88ajJ5jww1EI0N3LTU7I0roiQ2QEbF791EfvV4T0Ktk
 pjJ4lo6+pVvC5lfu+0CJE0J/3vPzxK8pohjvncS8vvwmYkvKX8tjlWxbzE9yc0B6nymUdbBE5vJ
 F28GgpkrElOglBjYFogIxtWKUbqQWQ==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ef11c0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=t5TqcTtw8i3Z0Z80VL0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 5TuDIrcJtOA682twWR3qnhMjguEarg2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

Ack

On 9/26/2025 3:32 AM, Loic Poulain wrote:
> On Thu, Sep 25, 2025 at 2:02 AM Jingyi Wang
> <jingyi.wang@oss.qualcomm.com> wrote:
>> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>
>> Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
>> of clocks for Kaanapali requires its own compat string and definition.
>> This changes the minimum number of `clocks` and `clock-names`.
>>
>> - const: cam_top_ahb
>> - const: cci
> The recently introduced qcom,qcm2290-cci has the same definition with
> two clocks, ahb, and cci.

