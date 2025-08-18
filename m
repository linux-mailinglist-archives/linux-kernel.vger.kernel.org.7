Return-Path: <linux-kernel+bounces-773255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F69B29D58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C17317BF3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925630DD38;
	Mon, 18 Aug 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+rKIoVd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B42305E24
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508370; cv=none; b=alsBCCsdFJgKaEngIumUW4iHJ+4bAg2xEcM9pEsUP96ZK2YrYWU86SO4XPcDpjBcV0xppF3XTaHktK5+ugxrU7ADSfpN0/q50uwn8v5vg/j4EeumRzk3SXPTJPrM2sf92nm2cX9A5zsk3JsojeKDHFkphix35K5y1MHdv90/zaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508370; c=relaxed/simple;
	bh=hoKhlgCsaez47ChkXd4smB04QyZuLTl2dlMho/S4q3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLpUNBx/Hr6j2zut05CDUKox/56/aO76bo932fmvx3vDPFlOh/ZXygLJjS6o/Hnv9y5H2jQu19OSjSklDANYVCpGggd4xaHBykFyfA6hHdKM9KRMx59atEhKw0imMcUsvd4alXTvk8TUM4l2a5AAtqbgmAegKDaUa65nPd7wFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+rKIoVd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7VH1K026407
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	miHpGFSXBHte0kT1H33Cn6X49n9fxBNnCXyhZUBomfg=; b=Q+rKIoVdHK+xGXOh
	j9QMZbRQI9sy3NazN30IbbQoelMBHTflj4aFO0bnzu3L9Lm3ZnmNTMXz9xMuy7Pl
	uAVaXwM5rgT4A3f7x60WkOINsZ1romHkqwAPkPaMeteGwCywoKDWd/Q82X3veSOg
	lPrOGEg6sBF6oEPLujhwPau1oFHUjAWtSOsq5D7Nq9Xpk5DFQS4hwWDpbwSi1RAV
	DnpnJ7/W4+Q8JbwEB10ECvAGt2mYlY9sFzbwzXSWWFEaEiTC26Y35LNZYSFMDKAl
	lFzfvPWom2RQwly5WDkIZPA2QBdyQjFB2ZT4v3Ve4Tfvn4ujo44z9Ck+3yjtD13h
	PqoR/w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunr93b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:12:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce13aso83054855ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508366; x=1756113166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miHpGFSXBHte0kT1H33Cn6X49n9fxBNnCXyhZUBomfg=;
        b=XqBwVyECF8Em4aRPXKeSbo6ujLtqguiLg+8tZlqnbCmDJlgOQ3tRTdepoKxbkdUKJg
         SkbtZuN8iUaK0RsoGBoxLyEa4+aaRfGsTugI5kDboeQHkQ8RSNIdGJ7AvbbqHkKeXiUJ
         US2TwnN0v3X3nqCDFNiD/yiuVxHqPGWd10RVR6bLq8Dt0QM+1okDiypRIm2LM9lLfLg+
         QvE9BW8lgqnzAYkW1Nh96o+9iFSfqnaXICMAV0O5+zmnax/idlDXT4RFra/fRM637mr4
         4K29nnGKVz4GChMqgD8nI0gL9RyHmNu+cTMyZjI7pqjZ4SKhSWf5Gj7fyksfaH2yy6U7
         kfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1aARFiYv45U+tjxG3esgL3Fx8GqwnjIkpBdnYXJ65C+AME/aweXnMIxdPNNgodF+Oh+BIlv7dQYZBs1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfnFahtnfQE8NYV0GaJX/VG5DBBIOr/8a7K5qlgQ3mNRkvSB/
	l+gzmjMKLqARG5bPGGWTOl/7Qo/UzKic7gyVvmfQRnsxs2duH74PP5JYSl4Iv4aK2cR+C+Des80
	mPXorGZ0KXNg72LPsVMkpi31eNTPb4r4afAX6MMIVp3ONHg+UzXDLQxjfY+VSgUSsUsw=
X-Gm-Gg: ASbGncvKPvolFC2Mnu+PFPaBX2yUbMdOTKEAdaG+5iuC0JzG/HUYGA3ALDxrJiEJPN/
	zzclvxgttFXYQtBkNR/zjPmNUiQNMaDnTtv5n+L71tSvjiuvqf3XAwS4hQDOn0lD6GCdflob/Dt
	foVv1N8jdyG41tRjumcq9x58JEkjySuIcysz7scf05Sy+/3Tb48881+6sdiXvvFTqdf3PgcGTE6
	mfGm3eDN8/5IguRQAl6DodmYHi9j3OXWG0nBmvSjdA++2luXOAqdYu3fFGak05JRBEUESZvYfq8
	ba9W0PkcM13IATykS2By8w/Z4Qb/i1Iudm264Pq6wZgubnwNQ/g1/dEoiLTu7LdD4pKxw+PxRZZ
	nUzIA
X-Received: by 2002:a17:902:f68b:b0:242:d721:b019 with SMTP id d9443c01a7336-2446d94ecd6mr204860245ad.38.1755508365643;
        Mon, 18 Aug 2025 02:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI+ZnayBkfh1I+LDsy5uA5eP/A0aBudlcf26OZjn8mHjvl9WanZtIa98AhhG0B3aE2tNRFYw==
X-Received: by 2002:a17:902:f68b:b0:242:d721:b019 with SMTP id d9443c01a7336-2446d94ecd6mr204859675ad.38.1755508365189;
        Mon, 18 Aug 2025 02:12:45 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d510f07sm74995495ad.96.2025.08.18.02.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:12:44 -0700 (PDT)
Message-ID: <14d0e02e-350c-42bc-93b5-c81e11b3bd5d@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:42:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: interconnect: Add OSM L3 compatible
 for QCS615 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804061536.110-2-raviteja.laggyshetty@oss.qualcomm.com>
 <3b79dc0c-0bcd-47d0-ab10-ba1514466d65@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <3b79dc0c-0bcd-47d0-ab10-ba1514466d65@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3qqeyulFGWVboOtqFMru6ifmBTy6adHx
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a2ee8e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=smnEWK7FS6KibTvaVXoA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfXyRkkST91svtb
 +Tzgri327BaoMJbPia4V1k/tuT56ZjRRL6Sa5MiYuUjLr7zGN5nLWfdkfauNqFEgVAyVhNsB4C6
 oIuVkIwXFuHuHlpKXQjZBqxtN0MjRN03weEFWcof9+tbridSswrZPmwWArom4avCUphwC86nwJT
 pyg/HM61rIa8GKndO48OjSoAdqW/uN7cf7WyrhVRuCRr95ADPX2RkFC5dTI2i4NU+yEyugAa+ap
 +JqRL8D2ulWiimVzaDRWxocJLKPIAwy3GFwaxpiq+cNWvUgZICu5ny69rl5qFCgZi0755ZnvXVb
 E+AfOf4wuZznOop7Ay4+gpHlWtGdxNGri8UjjPaUEumOAZytm9J7E2x+kqLm3gzOf93evWuflDW
 9UltvDue
X-Proofpoint-ORIG-GUID: 3qqeyulFGWVboOtqFMru6ifmBTy6adHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071



On 8/4/2025 11:56 AM, Krzysztof Kozlowski wrote:
> On 04/08/2025 08:15, Raviteja Laggyshetty wrote:
>> Add Operation State Manager (OSM) L3 interconnect provider binding for
>> QCS615 SoC. As the OSM hardware in QCS615 and SM8150 are same,
>> added a family-level compatible for SM8150 SoC. This shared fallback
>> compatible allows grouping of SoCs with similar hardware, reducing
>> the need to explicitly list each variant in the driver match table.
> 
> Drop last sentence, it is completely redundant. Do not explain to us how
> DT works. We all know that.
> 
Sure, Will drop the fallback explanation in next revision.>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml        | 5 +++++
>>  1 file changed, 5 insertions(+)
> No, slow down, this conflicts with other patch and makes your entry
> duplicated. Just squash both commits.
> 
The conflicting patch 
https://lore.kernel.org/all/20250711102540.143-2-raviteja.laggyshetty@oss.qualcomm.com/
got picked into v6.17-rc1.

Thanks,
Raviteja

> Best regards,
> Krzysztof


