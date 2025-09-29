Return-Path: <linux-kernel+bounces-835851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B57BA8326
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23203BEE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D192C08AA;
	Mon, 29 Sep 2025 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqBSAIPi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46A2C08A1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128671; cv=none; b=s0KKDd2v7zDc7l3QzCM2VmvgIm0QTDJi2HTpPc+uNq4LQejungpLJWfvA4sB+PQZSuu9fJTI29pCf+noO+8mW5uD5DsfxlhJZ1ksaXCzeh6yPdP21BfDln3v8Ubu3VA6uaqntYLBaA5xY7WBdbpjkEbHtHIK38WaEnvGxCdvO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128671; c=relaxed/simple;
	bh=Qs6Xu2skLRe1j3hqfR4jb/bGbkPW2iNTslRy5lTMWsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSBt3sfxr2sPWuJ2HBXLN2r1vO7bsHAgDl01boASRoP5vuzYCUYJqFHSTR8t4/B8qC3Hw7MFekb1UHDX3D+5kMEKRpmDClqM/bUSc8Zf7rVKAEAk2BFQytIQauKohu0laAEVjlYYsiOyGb3s565lqmTVclbrcPFgc92l6CwuaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqBSAIPi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SNE0hM020759
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1g51hOpNYcbi+fYrTKGLSDcwoetQbIsCELfJGZDrqFU=; b=SqBSAIPiwNbuvuHp
	CbwQYSdS/AY8z53FTL4wf8vEEJ3LwS3LMacqeby5qnN4Bso8ylRZNZHU4Y0kxR1r
	PFjEpjSB5rOXpdlrdXlEI68DO1iTPFV4dit3y7C5zuEbOO3uB+QEqKRdDTTgjuLh
	lfT/ppNZQJy0rTU/u12DfXSnLiVEcuCXPBUAxOOv+BE5mwCOJTWE7QrmwJ26Brh2
	+fMo/6DcOgiGt1jOX0iJnPpTdZWyPTMJ5Yqa8PxLGIbGcgdFnBQ1vi2u4zb7ziIm
	WTjDlwfNt2T92d5eoclIWaPmwa5hTs6ZRB8u3HpF7zSKMevjgfxfL48jCMkS8RdV
	UrgYwg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqv714-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:51:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eddb7bad7so1230924a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128668; x=1759733468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g51hOpNYcbi+fYrTKGLSDcwoetQbIsCELfJGZDrqFU=;
        b=QFeVEu/aNVHmat3ArF3BxYU2e2ufEFp5lDl1mV1vN2cu1LHNhdGuLqDCmwRAOL7XUP
         ds18QSS4xsP4ISJaj9FFc/jlAyj/Se3LPjsyAJWSgxFysChSu0aWWrm6RBakb4SGppin
         CrIUoHQvqcsh5FA12p/bEgEnXex9r/0+TQ0hojWltmuAMxN1OHtMlQa8PfAYgL9k0DBI
         HA6y8/N4CI5j7P4qQj2WezOyRtoiHO+OZTbgj1F1M/pvT9NADjTrL6QMRGW2nHY0QObV
         nPpdg2v5q4JHDHGl0l2GQstBdOwy/CoSK5WD8cuUL11xI10X55zxsnw1Srf/7dQbguio
         WsfA==
X-Forwarded-Encrypted: i=1; AJvYcCWdJCmKj8Hx7PUCaPEwm6dnjYQBFR1t/acA1VQ3NyebCC/jvMPEd90KoXoaMw1YIT9obBYTCYMRkXMcX5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03XuIGZtPCO89rfTcc1V7dunEWcTy0U73XFxUqMDudN8o0y2S
	cM350ZE60vtALxgxnbU9xJsqrk9mA22z76gzE9lr7bRSA1TIbesjSMEa3gVSWiN7dk9GNXWXSzY
	GrdZW6mOR1FpQn4yAgywF2zKDjs058yAHCUUtTNmZ0++Y9zaYOAxHboByOVo+cMWv4j4=
X-Gm-Gg: ASbGncuxg7c0dZDbjAZczsrD7dDbMhCP8MAPpxIna+BsUBtmE4PymA4e8Bm38pROLFM
	wmwkAITc4aNBXIVcoTchdxP13qeZnTp0oiJo8JE5aC2Ty7Mrivc9zwxZcy+iVx2mq6LbpdPgbeG
	VK8eeZp5l0Wm/aveFZO4oq1ACUpPWGHturovAob5GP+HFcTEi4irYcPJd865ovOpj6FkRuOQHsv
	EQegVXVNsfuwKprIafSECohICuuHWuR4cKw8IFUj/BORoK3bu+chiRy7+R8u7GE9rCfEjpanRH4
	ZzZS3270myt0ahrNvMFv/kwWoMnLQhlMYFdMgVgu6yW4I3uecuxVVKW2Ot14HqEc54bsjbcFKlg
	wcMCX5UonT9Sm9el7kLJ7yWhh/nC8ihA=
X-Received: by 2002:a17:90b:3810:b0:332:50a7:af86 with SMTP id 98e67ed59e1d1-3342a230e4fmr9581396a91.1.1759128667838;
        Sun, 28 Sep 2025 23:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqfrcDffEGa89Kr6nZD7JGX9u2ah7a4jDj9bw27/AGY3Zd737uosmm3FQftDtufXIByKAO7A==
X-Received: by 2002:a17:90b:3810:b0:332:50a7:af86 with SMTP id 98e67ed59e1d1-3342a230e4fmr9581372a91.1.1759128667293;
        Sun, 28 Sep 2025 23:51:07 -0700 (PDT)
Received: from [10.133.33.226] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-334352935d3sm5945332a91.3.2025.09.28.23.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 23:51:06 -0700 (PDT)
Message-ID: <8429ae83-e027-4ea5-8cbd-a65f3a5a8cb6@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 14:51:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] arm64: dts: qcom: Add PMH0104 pmic dtsi
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-10-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPetzYdOvYkzeWmm9pVM1MwJhng4JLn2jsoAuey4jtfrqQ@mail.gmail.com>
 <7dfd14ed-18d2-423e-abbc-33ef8bdc0a75@oss.qualcomm.com>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <7dfd14ed-18d2-423e-abbc-33ef8bdc0a75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TioAmyRYrcbw5UPN5r0UTPCbAsaIKxTE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX9Zrb3bqP3/Ph
 EEEgak5/G1f5CwHUQBQXilnyc/muKALZUyWhGIqmwEQr02ngdXQ6LHa/00wnXC455kcSqU/yUbN
 G+9qykD/Oy8qrziuW3TUapzPWPXdSFwSqYif2D/7R0TGv+zf2UVHEWm0H2sh+OuYD5rZS99nvR4
 kW/vm7sd6vtwf09yfSZcMBMPoIn3WtE+Kmt6xa25X2LxG4+m6h2S9YfLmhroxfA/+Pg+PDNeHCl
 ZyzpOcq7g0VdaYzYL8ucw5Ng5lYfDPaVov+epYbjG1Wdk8ulT7y64BwBGQtbtkeIZHxvtTutZSQ
 /rST838V3PLtinNZBgc3cT8u+l5mffmSJel7vSE4rxmD0oNp6POlh/M4Dkq/Miq4K8582qoktCg
 ooHh4+YJ46uRXAozp8tm9pESTlXvDA==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68da2c5c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=SANCmw4WSCOK-ABOScoA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: TioAmyRYrcbw5UPN5r0UTPCbAsaIKxTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

On 9/25/2025 8:21 PM, Konrad Dybcio wrote:
> On 9/25/25 9:59 AM, Krzysztof Kozlowski wrote:
>> On Thu, 25 Sept 2025 at 09:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>
>>> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>>
>>> Add base DTS file for PMH0104 inclduing temp-alarm and GPIO nodes.
>>>
>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/pmh0104.dtsi | 33 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 33 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/pmh0104.dtsi b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
>>> new file mode 100644
>>> index 000000000000..f5393fdebe95
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
>>> @@ -0,0 +1,33 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/spmi/spmi.h>
>>> +
>>> +&spmi_bus1 {
>>> +       pmh0104_j_e1: pmic@PMH0104_J_E1_SID {
>>
>>
>> This might be fine for Kaanapali, but it's wrong for Glymur.
>>
>> We discussed it already and I'm surprised you come with completely
>> different solution, not talking with the community, not aligning to
>> solve it properly.
> 
> I think I omitted said discussion.. if it was in public, could you share
> a reference here, and if not, would you happen to have it saved somewhere
> that you could forward to me?
> 
> Konrad
>>
>> Judging by other patches sent now, I recommend to drop it.
>>
>> And instead just join the talks... Otherwise how am I suppose to look

Could you include the talks with us?
I've discussed with Jishnu, Kamal and Rajendra before the patches send here.
The conclusion is Kaanapali should be post as it is here.
Feel free to have me in this followed discussion.

>> at this? Everything I said should be repeated?
>>
>> Best regards,
>> Krzysztof
>>
-- 
Thx and BRs,
Aiqun(Maria) Yu

