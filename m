Return-Path: <linux-kernel+bounces-866515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F745BFFFA3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F84D19A41F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDD3019BA;
	Thu, 23 Oct 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQRrXgc6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B712F3C28
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208948; cv=none; b=k+d20YMnbl7JJH03h4LYJMLMM7n44v4mMdJwXyVV6/JTj69KF8H7FX2geNleJaAOFA4zjEixs4GP0irvXP3i1O6V+gg38FcdOijKBywb9YT3WfoW9VSdByXQGG7Ih/757vEbXXbtcRaceMUMUTxvDynSaBlAA3InUjiez/xF8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208948; c=relaxed/simple;
	bh=fjw+6ZDF1PL5GDq3q972gH89f6sufYhNm0JI5qAyHJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrG1yFEy1cmjJq62qaw4TztAxcj/R2FpmWyXRzVABLFxSnMIlgsd7NhExKwBHfljXNzMzEuI/h2tB6d8iQlOXU0PAQG+sNvxvWebkQkjV5oUPsLQZnVUCkjVG5LwPwoycrxIa1NYG7saEbTu+rnSNitJOEhGTU9dZv5b83Ce3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQRrXgc6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6uIKx014650
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofYX3HjRKgU33R+lakZyIrCWXfnZSj60qZrS5ZoOf3I=; b=WQRrXgc6kEvZndPz
	v6shTzHq7v1GyEeMcW7DUeVMdqHbf9ElamHkXy7wc/OYu3c/IFwd84d151HngCzs
	Cm6yw4jqRbUWTaCBvziHW686f7oyCdS33p4LYc2KxeNnj5cWXNFg6eErI0AGBsut
	xyJOyoSaVJd38nLBFnlYPYCDQZUOhv2AG72eyc08RP2+oz6JTeqbhUCRntUfrM4A
	sisf5Bp+k18FeKipSKKBdYFxYVhEorKAD0m9bsdpajEorBpt/9lk7xgl/ChPx8vj
	8p2Sc0UYalFqwJqt/AXwgI50LuGXkgsTleB6aS/4GEYT5hqHNmeRubXPT3KvADfu
	At1zTw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0nk29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:42:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so508103a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208945; x=1761813745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofYX3HjRKgU33R+lakZyIrCWXfnZSj60qZrS5ZoOf3I=;
        b=Cc6rBsACH71uWArAstjruPWdMLMtj627BXdbaXi8wvPr6CJppzM+evKBYuLztpjGsV
         v3frsYf+if4lnW0clf8jDwfWGxn3/ylXNsRz0K76ckKjxYBFSUhPRtK+SFHsqNUQtfB9
         aPx/BO624t+S36F2Zgf12vKO7rILn68Zd+Z1RIkfakGdgCRNES4d6MzG/Vf2vPmZdsCK
         8RNr5Q5euWZxQ4PIxiz/I9JjSE0CMRAz5a30rl0FO7F+EI/S5JMy8aevR4H1SiC6xtRK
         lYRWlP8szWcVXY3Qnxrq1TURJgK0NnxyAPGmzlti87AlANXCrsOY83OeY4pno/YoHi/F
         m7rA==
X-Forwarded-Encrypted: i=1; AJvYcCV+2YZCrjR43nBu97dXerScvvU5AtVwKXuHlWUq/wh82Pc+7Gq2P9uuf4MESWc4z7OT0SwooBVvlff3FVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDiiOz/6Ut7YSkh54Vzjp17L1ykIHoZJKfRTXSsLNf4IpEb7X/
	1jVDrU5gODasZLoKLW7LaPbco0/q5L/7s8sYpLBLfiLkFYf35efmjASYZZDcksmgQgHHa9Q1nHu
	QDSuBP2bfLXvubUuUeUxFBBCA7v2PLgwaSWH7Yz0aHT8GcN8wVNvNDjOQNs65IgzczPQ=
X-Gm-Gg: ASbGncu9qY1Dlj4eT3RMPevHrlSPngCDHg+wbIkl3KEjltnFK0XCM3wOrBV7mYaiINF
	73HUP27mW0Q3q3y9BRbAiTNBjHITh0jS52NfncXbrh+xWPkYWfJlLvdNOJzcaBs5k0+6ZZKvSGA
	kaXi1HeUM6xq61xtaaJdntT+4U+miTRRLfFmuo19tXO/f4ucmJa6S4OEN9t/DygrOLZflBqpwl0
	8ZP7a0g6+amq4f+zy7BVnlJU2VwmL9VVKztlImNYv1WJSBDDEcVGVcmDuHzDyUQN3M5WDCZ2wil
	evyAMjRnP7GnySrE5fiJRJA4UbDKl9U38+b36JBF7/XkOYRrLcfZSZlKn25y0T1NnWVNd3GkFBx
	sfqhtgeX6J7NaURS+KSKVFbbw0Hw=
X-Received: by 2002:a05:6a21:3988:b0:2b7:e136:1f30 with SMTP id adf61e73a8af0-33c626aecb4mr2160444637.55.1761208944641;
        Thu, 23 Oct 2025 01:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2rBCLzjTPJc/nY65doA/UHQAoORgCvBAhguw9qkE0tE9g8A0pq4eU8cfSTj3QkVtEG+RGhA==
X-Received: by 2002:a05:6a21:3988:b0:2b7:e136:1f30 with SMTP id adf61e73a8af0-33c626aecb4mr2160417637.55.1761208944214;
        Thu, 23 Oct 2025 01:42:24 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7f1sm5037500a91.14.2025.10.23.01.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:42:23 -0700 (PDT)
Message-ID: <703cfc97-ff4b-47f5-9f14-fb3ea4f68f7a@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:12:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add support for Clock controllers for Kaanapali
To: Bjorn Andersson <andersson@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <hy3dcra2izm3elcrmvmsyfeht6e4bhzqzy35ooqywve2c2htfg@24hpt2nn6um5>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <hy3dcra2izm3elcrmvmsyfeht6e4bhzqzy35ooqywve2c2htfg@24hpt2nn6um5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX2ufzCrOG3h7U
 alV0YZ5sQR5efIFu5G0lmZmXPqYj8+CEGdNr/9wIOL3+tTVhCukd8WbTavyGpS4brZh1y9eFk1U
 1nqyOPwS/c9/51KhUD/tP6dpTytUwiVfW/m3HrNOMX4wCXlQgWO+v1Oa/+Dy2eLb6b/0+qERW0C
 xNaNHGtfCMO85cYdkNLkiWua+OZP1gY3RYZR4GX7kOD4PKoEU8tcAiSxK5LjDDGht3AjeI8wRA1
 BSAY02u6RwnlUIqzqM8iBgtcgTphGSQ8NgV3Fx+I6OeS2AW2MKPkmEkT1Y53rxE1RUG/T3MD4Wy
 u0N5N+6vUjZzBGcUS+ZJ6PHyOx8tP6ynEolT2EjnNL8PocEhPGznOcLy2RjbtAFI+88zVGQFY/Z
 0PiTqZEMe5/Ra4qrM8PnS3ZsUgUZuQ==
X-Proofpoint-ORIG-GUID: 3_gTHK5SuV3eDU4i32xmm6cc3A3_ffV3
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f9ea72 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=M_Sh8l_qeD7bdTgo-sgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 3_gTHK5SuV3eDU4i32xmm6cc3A3_ffV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167



On 10/23/2025 3:23 AM, Bjorn Andersson wrote:
> On Wed, Sep 24, 2025 at 03:58:52PM -0700, Jingyi Wang wrote:
>> Add support for Global clock controller(GCC), TCSR and the RPMH clock
>> controller for the Qualcomm Kaanapali SoC. And update the PLL support.
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>> Taniya Das (9):
>>       dt-bindings: clock: qcom-rpmhcc: Add RPMHCC for Kaanapali
>>       dt-bindings: clock: qcom: Document the Kaanapali TCSR Clock Controller
>>       dt-bindings: clock: qcom: Add Kaanapali Global clock controller
>>       clk: qcom: rpmh: Add support for Kaanapali rpmh clocks
>>       clk: qcom: Update TCSR clock driver for Kaanapali
>>       clk: qcom: Add support for Global clock controller on Kaanapali
>>       clk: qcom: clk-alpha-pll: Update the PLL support for cal_l
>>       clk: qcom: clk-alpha-pll: Add support for controlling Pongo EKO_T PLL
>>       clk: qcom: clk-alpha-pll: Add support for controlling Rivian PLL
> 
> The series adds rpmh, tcsr and global clock controllers, and then it
> adds support for cal_l and two new PLL types.
> 

This ordering I will fix in the next patch.

> I assumed that meant that the order of the patches was wrong, but I
> can't find anything in this series that depend on these 3 last patches.
> 

These were originally part of the Multimedia clock series and got
introduced after Jingyi mentioned they need to be moved to this series.
I can update the order of the patches to RPMHCC, TCSRCC, PLL code
changes and then the GCC clock controller if that seems okay for these
patches, please suggest.

> They seems to just add dead code?
> 
> Regards,
> Bjorn
> 
>>
>>  .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
>>  .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
>>  .../devicetree/bindings/clock/qcom,sm8750-gcc.yaml |    8 +-
>>  drivers/clk/qcom/Kconfig                           |    9 +
>>  drivers/clk/qcom/Makefile                          |    1 +
>>  drivers/clk/qcom/clk-alpha-pll.c                   |   20 +-
>>  drivers/clk/qcom/clk-alpha-pll.h                   |    7 +
>>  drivers/clk/qcom/clk-rpmh.c                        |   39 +
>>  drivers/clk/qcom/gcc-kaanapali.c                   | 3541 ++++++++++++++++++++
>>  drivers/clk/qcom/tcsrcc-sm8750.c                   |   34 +-
>>  include/dt-bindings/clock/qcom,kaanapali-gcc.h     |  241 ++
>>  11 files changed, 3897 insertions(+), 5 deletions(-)
>> ---
>> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
>> change-id: 20250917-knp-clk-c60d94492863
>>
>> Best regards,
>> -- 
>> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>

-- 
Thanks,
Taniya Das


