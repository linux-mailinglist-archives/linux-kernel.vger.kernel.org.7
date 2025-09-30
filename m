Return-Path: <linux-kernel+bounces-837031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC98BAB1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174691C4530
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62C226D17;
	Tue, 30 Sep 2025 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GRCgXwxu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55B533D6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201578; cv=none; b=ZMv3jrwBFZVoVR8VufpQFTc+5FaT5seSI/PXb/Vqpokr8aRS4L8vq04JD2aA7ymXtoLgyu6COARCqVHaeXbG98oiCjmyOnBX+igDeKQnL6krcHMATTkbJ/sKNxWHmCas8VL/j5xLb1IB/3TMGQHjGBJclE8QpCBruGl2AKRq3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201578; c=relaxed/simple;
	bh=wRBGoZ0w+/yO+4GK/SekM4EcOmzBtCdzP1s9NAQ0siQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inv7MUslXEpiJvyFS/6gyzKIiPu51ZOZ3eB7p2Z7gcBAVy8F+nS5HME6SzzcdCsbTGiHi98GRFg2/lse0DzN4/WjL0Rs5Ivvn0VdKZP7fWVF7qpv1ZAcvZVVwcUHV7a3WH6OK3BpMdmAUJzFwN2mNbcpPcRnkVSNzhNTy1QHWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GRCgXwxu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TIIuIJ009316
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6q+XaInOzB2LHu4CwIXfwgbLjWT9VQ02Q4RXVHW+YAk=; b=GRCgXwxuxDMEUl2p
	SwfreGHZIzR7xB0VTjUI7oxh1kB8qop2uQr3gp0s5yiDrTNelbY5NFf1YkZ1OGwI
	ETyGrLtDDoY4fcFaOdR4hRId+hZiWMznPogiElfbYqQyndu8TQg+DuSiUlU9YsVx
	MsReF5HrqHqG7Om+IMkzmKAOikZvK0CE48y41oLJ6kDpuj2aoyQEiTdBMSw1BL3o
	QgPQVjSVfCOS4NYE0jx92lGLul0DeKJ6wCNB//u6HKOCuSyE+MkB2pRYliJZDaSc
	MW+HGhCzh07QUfqxRwZKa4dIN4IxAPXY4DzMSyKhiVpzHVcutNdbOvCO+Clo8bZU
	rMMt7Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a5yej9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:06:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268141f759aso51372455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759201573; x=1759806373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6q+XaInOzB2LHu4CwIXfwgbLjWT9VQ02Q4RXVHW+YAk=;
        b=GWLemKpgUbFhWKiqNtah5qT77vOmuHINztM5rEKxBrdu6zsX75yKxWWWPz8M1urmuT
         Nhh2xs8icy0W912hxkOEUG+lovEFrhlstBQf/+dNgNWqmsW9D1lQFbKZxJD87PRW8dhJ
         x+matoHBrSHZtvwGuMjqDnGrlohW5fUY8H70qg3Ka3owA4ldF033UvTGhYG9EyyEeAsF
         MOFy6qgXoREWabPpXRqH53VxgpZiBsrI3gSuUaqqmeaWcls9P2VE9zJCtaLC6+3q5H8e
         p3WiNoWmcNXXufSBWWUQ5JRKsOQBtCYvNoKMq9NxogR+ZVIvJ4sxRwausoa6f1W28ewF
         kJEA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Fqr+m8mQ/cpqhIJpTkiGnt2+XfY41s8O40ovC53FXYkNS9FKG0+kJusH6f08r3anEJa/ELVOKugnsxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxao9pZ/788wX5HisyBmYU1mzTVmmfgGfaHVbfEwMuTDyV06efV
	e4XDKGpi0VSwH6ZkADFCMerl/XBd0Dv6iNg9J0PgbyBDO7YTYRBfZlsEOwhWublmwePgtCT1UkT
	ElW+sm5lGTbKqwIm96VzHCpUjBLdlsvxmvhhgnYITAR+1TwWETpxnLPgUsCzcjvzvKgY=
X-Gm-Gg: ASbGncueX6kdFGY/IVrGQGZEP/jpxTeW1zjY9g7J5zAWred1wdWJJRED3+X9dnCUXX1
	xFoVd5lTfq/34v8NgDJN90l2Q7Bmri8a8VYjVjvafDuRDWCFep9J72d95j40L8nG2Vd43WMpojk
	P6qNJBMUom4Eu7WBxTiU7FlZ9jzz/LqOSyyaiexC9XynJiL5nZcBsy0L2nYDeMG6sNODS0zZHDz
	PFEhK6ytS178oHHhZ9yn5WikMTjrJNPnTdcXRQBg6r0EJ+hOlTtnjpwGTT2Rpf+L62Tljqbkvsz
	tKCsi6+aLkLIQjDjsZEvX+2GyU+qfiqpV/gg5N5/zB6jBhMEwUvbpPMGhaKzpjZLC4b1bCe2iui
	ocbsYVhDTqw==
X-Received: by 2002:a17:903:334c:b0:27d:6f49:feb8 with SMTP id d9443c01a7336-27ed49d2f57mr156108965ad.16.1759201573197;
        Mon, 29 Sep 2025 20:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFppymW1BaRnptlS5tRN1jEjk6aV/lNXpQE5CYU67X0s4DFB3lZF1LGafmAUHUxjxxRxnJzbA==
X-Received: by 2002:a17:903:334c:b0:27d:6f49:feb8 with SMTP id d9443c01a7336-27ed49d2f57mr156108635ad.16.1759201572746;
        Mon, 29 Sep 2025 20:06:12 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69b12cdsm142955845ad.115.2025.09.29.20.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 20:06:12 -0700 (PDT)
Message-ID: <70569fdf-7a3a-495a-b1ca-d35ae1963592@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 08:36:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Eugen Hristev <eugen.hristev@linaro.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Georgi Djakov
 <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
 <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
 <f4e7a388-54fd-42a7-8960-be6a3de7ec6a@oss.qualcomm.com>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <f4e7a388-54fd-42a7-8960-be6a3de7ec6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68db4926 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MsHyvPc69t2rxRqWf9MA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: He3VfQ8AMc_c-WvIBzhMKqP7S2v0ToVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX0XygNSXiunud
 tPwJ8/KCOr7XVDLO6GKx4zGoCtAYjYyED3MrHJBMm6RbxWAqKkeR7gg664syV6slpZK8h0RUXVp
 MzqwI655nOZomO70m+/+tJDX8+2bsCtwwQZnOxr5RS+1qshScgS9Q3e2rzhrzuq/+MVOPrcjNop
 SOdfKHoF9XsVz36HUUQMPfIeNGPjYsl9991mpfMgFkzTFHS0+2mF9Gn0PAeBcnmJnM8qp7nCQOk
 AMIwXcBVZu5Lvbh1mjMNuX3H4oT+o28mluW2W2cr2E8cul8ELcoJwIAX6+OCW38rrvarEnnRkel
 U1nNcAQ4tj6fYSMW6IiJ6aJA2rLh7BZkCU+Azy1OZuwg4rA2m3CrYVQgwjacKGCZQGq3Ueenp8P
 /3K32on+hUrSSNVANOwFPAJRCbaI0g==
X-Proofpoint-ORIG-GUID: He3VfQ8AMc_c-WvIBzhMKqP7S2v0ToVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033



On 9/25/2025 6:10 PM, Konrad Dybcio wrote:
> On 9/25/25 10:57 AM, Eugen Hristev wrote:
>>
>>
>> On 9/25/25 02:02, Jingyi Wang wrote:
>>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>>
>>> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
>>>
>>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
> 
> [...]
> 
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,kaanapali-aggre-noc
>>
>> Hi,
>>
>> Does Kaanapali have a single aggre node, or there are several ?
>> On previous SoC, I see there are two (aggre1 and aggre2).
>> Also in your driver (second patch), I notice aggre1_noc and aggre2_noc .
>> It would make sense to accurately describe here the hardware.
> 
> They're physically separate
> 
Yes, they are physically separate but the topology treats them as a single noc
with two slave connections to system noc which you have noticed in the topology file.

Thanks,
Raviteja.

> Konrad

