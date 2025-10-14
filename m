Return-Path: <linux-kernel+bounces-852298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9230BD8A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03193A2294
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A0F25D546;
	Tue, 14 Oct 2025 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BEOJVKLG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68B2E62D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436106; cv=none; b=dXlZ92f32hlAlQy3hFaVPsAsRemoF8WxVM5B6wGi2TfLWN+CTw0NRgJYhEyyY8EEW/Gbkm1B6obR5ODv3lngV+kV70NBj22w1+qxn5G3Wb1pD1PDLkj0xuVK7qICeFLkvkpDafkO5OPBZTrZ/TkF8a3CGQOJM678oR2A5608AXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436106; c=relaxed/simple;
	bh=D3JssWtrvIhSzBbDco8w9yHj80wIIo1ixaviq+V/bGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JldbiKRVSngSJHslLYeguq/lXv4mwkLBl8Y9JGuyw+7L022wPP9ExeYfp59kDm4MRK2t7WORPZd35T/ctI6rgROhTa2EfKcn87mqDuaHqZzF/ba2IcXamZR5Tyyzhej1ZSeoM5Ul6ejL7r54OpE1ip/mzKgt/tcPXCyIid81PYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BEOJVKLG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87Pok021340
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D3JssWtrvIhSzBbDco8w9yHj80wIIo1ixaviq+V/bGw=; b=BEOJVKLGT5h1eESr
	G2O9Wpjvvw6V8dnmnR3mAwWPSVJ949z9s/j/Ip3AzvILr2noC6K+7zFgashQmOs2
	aWIjkBOp+OMthuHfiQ4xpbkBw5Gim7/ei68Gx7BT0b6lWcxt9dOhWGZIUoeYaxLg
	wjlH4gyJHUngvsRhJcKHDrCi9v5o8dDTrvQlSGPoYoPbxy7IYfDX0TCSzQycYypt
	enidv5hcBWl46qGrI/DD263X5zKdn7KkirkdoRo+wESw3nNv5PeTtHdjDfgmW4vq
	Bv0dV00kk6nCt8f8qEZnuw9GxEonvXO2cvN/QZ6GslFmhr/BMgJktrdm1FM/K1A5
	+/RLJQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwjad9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:01:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5d5e5b2df67so818579137.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436102; x=1761040902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3JssWtrvIhSzBbDco8w9yHj80wIIo1ixaviq+V/bGw=;
        b=BRx+WVdK+AI5bvyHnAzK2s2KZfdJDjiKIVI6wERC2TwSBfFOTwtAvBv+j1hK+NdOox
         dNTv9SLVVLtL212nIv3ecOfLs25FPCkj7qr55g304I6s/wWU6Czlk52o9Vt2QGis1u05
         OaQn+Y/wbhg6ItMzlCQ7YOZbVdu3a1v47ePFzYdbWXu7SVyEg1L67bFzu5ArpmFIGlXX
         N0fo3a62OH/vYAhezcFnv2UARTIzIW5lSdaJNCWmYOimSqzXK2NkRXUJpizKw0WR7gzo
         /H3Ae4hFsTeXseSwqW15QHHkH+jfNqP4NeHLqcNfi7ZPpd8fzCZP9F8ov8LOzQlCv1z8
         rY+w==
X-Forwarded-Encrypted: i=1; AJvYcCWun87oeizI6bwLUmRkSdBQflpF7Vl9reWvKhyQ0EloFo1NaDPMpivRphEKSSQOcKEVvwWBqrZ5SKpZINk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCx7lMWwU1v+LmS+WZhoGsw8J7GryDN6VP8v7mbgEzYN9iD30c
	lrFJpD/IsQQmcysB7+oPprnZwj/+3QJJ07o1vdpVwwPzsfkGjI/gmpjrKc8oMu5dRYlShAflyJ0
	hqu/g/jOm81rkts+/tKw+yJtH3KvsPbXFnbbGs9zlyeNHYHzoff6GdQSwFR1JhQ8EZCrELkUptV
	A=
X-Gm-Gg: ASbGnctE0o6wNGXu+gSiv5/HK3m5G+Xpw/VO66Q1hd81S5GgRZsfz+346WztwsKQBxA
	C7WbD2R7YTwBnFV+VoP3Gpqf6P4KFWzEUWfdsYmAoOn7v6TCm5+wCI4SaKUiTA/BGs7hmX597Bi
	8Rxu70+eXWbrPWBd6gXApY76ZLT9ejx6Xh8rzMBFPGafYb12Z+KFs2EvMRwO9rhTYleZ4rmAQku
	12bI3esXsXqsrLcrj6j7nFNZ0Zsp4lH+4ggsXH9A7TIpPuehhMOZY7OnWDr9vRIxiW74IgGVYTa
	tkaouYrckPtyEZxNZ38HCOWYWdmilVf5QL2GPWUGWchdx86qvrUWmkylO+4ntGTLfGL0AEDgN/9
	N01/svDQLhQDS62aM5W+Mww==
X-Received: by 2002:a05:6122:2a92:b0:554:fdff:f3ba with SMTP id 71dfb90a1353d-554fdffffbdmr659639e0c.2.1760436101834;
        Tue, 14 Oct 2025 03:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTz9yawJiPf7YIyriQbzNgRPBm+dfvbCiuWFvtl/QW91dwMWxpX+kI9Ls3+XCel3PRAPzGHw==
X-Received: by 2002:a05:6122:2a92:b0:554:fdff:f3ba with SMTP id 71dfb90a1353d-554fdffffbdmr659621e0c.2.1760436101312;
        Tue, 14 Oct 2025 03:01:41 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9526885sm1120614566b.84.2025.10.14.03.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 03:01:40 -0700 (PDT)
Message-ID: <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 12:01:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251014044135.177210-1-ghatto404@gmail.com>
 <20251014044135.177210-4-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014044135.177210-4-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX/7NjzTzczjq0
 D6rvXuQ7zFZO2AYRyojQtHaUn16ZiXCJowbeR0T4sa8ScJ91b9JA9YH5pc9gxvX39g/Hvv48/hx
 uf0SH+0Q/f7PAzquWEA1NgFnwrk93uZE9RZlxTPsliVjwUpMwwDbpyRHeQ8xnTyt1hwhmNvqrG2
 Qr1H7S/dhkTFEqSmD/7/kO6UennSJWWUGA5uH3Kklmj4LltvKqo8o/h4OgdvEtDzp+OuvzaXeoH
 a366G38q5ULS6Fsz6Ek90r5Tu8Qm58Nd0vO0AR6Pj7b/N1rH805qKUXKlQZ57+4ktyPzrqHtjxX
 NjMWtD03Xmqp1VbzLT/Mh2OZvUXrQmAtsA7IlX/UzKYQNTbzvNlP96rwacUvRzdTolCK+cBOVop
 I/z0y9J4OAH5fRbIHZCM6aSGnkT/Nw==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ee1f87 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dCpwloqO8bWZMPXPVoYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: eOb3rfr99w6VyQ9YbJh6pjfULReVTTDC
X-Proofpoint-ORIG-GUID: eOb3rfr99w6VyQ9YbJh6pjfULReVTTDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On 10/14/25 6:41 AM, Eric Gonçalves wrote:
> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
> depends on "Input: add support for the STM FTS2BA61Y touchscreen".

The second sentence doesn't really make sense to be included in
the git log

> The device has an issue where SPI 8 (the bus which the touchscreen is
> connected to) is not working properly right now, so
> spi-gpio is used instead.

Some Samsung devices used to use spi/i2c-gpio intentionally, also
on downstream. I'm assuming this isn't the case for r0q.

Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
that? I don't see any obvious errors in the dt that would cause
problems

Konrad

