Return-Path: <linux-kernel+bounces-863989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE1BF9A92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CC418C73EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB020FAA4;
	Wed, 22 Oct 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GVYzx2WR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5A1FE47C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098352; cv=none; b=Wz3MwhZY5jxyZGP+XwB8iWLtEQR35aeU/tx1dySx+iPGVr65yYILuJqNMwWq6Nv8i9C6NWamGxg4CnjdHm2E+rePomVAOfdz9M7iNSfSXVevfmCIqIxceKMA+rgrazcaeh4aVYhO0rM5OV2Du9C5LVW4482Hwho3UMUrNGtk9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098352; c=relaxed/simple;
	bh=GH7P2Z816MXeFIc54lW8I7MJ97fWpsE6LLus6ueQncY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DppJt/yRpbbzIcmEm8J3B0mcuwQVlbzzBZCBeR6CjfWAmViduIMdqiRYDVwLnYCzQ+aFwL3A+Rel0PPpdPWNVaqVNzvPvZ4jxsHBu5/jpakVTbhD6MI/NonALrMTESKWCTZogntvFbRnnWHn0NqtLHQLERTPKITyNKqqOt4GYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GVYzx2WR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEmpkG028420
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z1IeuNaDea5YK2zKyUZ4RwziKcJaa7Qo6G4eoyjFFNw=; b=GVYzx2WR4WyJJwD2
	j08SKgeMjohK+ia+qVEvEGSgh1+r3gWz0I1hB+Ot5oBtr3SHPnKwaxK6FBHAkBPY
	h2moINtIaiuxUYE2DG9w758qCUNEx16nZozEu/B2ghk8XnhpXDMJRPu0Zrwkf/8R
	Z/VihAX9fk8JJRuaxYgpnCjNSywl1P8mDUwMKpsC8ah/qdt1GEDxDmlNO4wD4WQw
	oZnySejonWzq8iAGonT/YaH23uVbELdBeUxBlwgTkfW4sbZRjSoBq9CqWdJ5Q/Dv
	LXUFY7+BDOcPrRH/o4lqTvyVpO1DmsMZ2mQx7QXFWkNoCP71FqpUGFIWCqlA1UHt
	1t/s1g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pk1sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:59:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7900f597d08so5519507b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098348; x=1761703148;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1IeuNaDea5YK2zKyUZ4RwziKcJaa7Qo6G4eoyjFFNw=;
        b=BfQUy18She0WyES2JLTo5HWg46YcMRoLUoNrmXeWlpI6iQa6iyzUd+ckH6iZNbwwAq
         TSytoJpx1ifKvpf+nmdUapGwwMGpogkGIPsFrGFYSkqZmr+zxDmXC8IuyPl6jQSCHgdV
         YIMR0wMILYqKkckuU8YIDO3W4kzoXX9GxRdk1SaMWVpChWsrJ0m6aRfkRZWw19XMFh60
         yBwVbB1MmxPiSgA2CJX5uv8/zXHzVw0gaLhSsUbJQpihsDIqEsDKxapz643gWsON4Yyq
         Xh2kyUtNQTQ0r0WgZ6CQv2+tbSjdj72h46lKTzmL2OZhZTN+1QCZ1w+a0snpk45bl7ow
         FmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2MMw/+OwiUboYj6AzVvhWQGSHALZmBOr6nZdEJjg4polkujWiukgMThoxljtIdfFkj1LSEn7+kLqs3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdkG8vTmJwwLhZr1YdGpHWDef747RhatKPa0TaA1dAmG61YiI
	TzkSvk4vsSjhEKCyUFUpnTq2Mm7gXTOyXoDqDA9ril2tJ9CxlRogh9KQOQDdtOL4aEMbnyiFc3R
	DeJaOzl6w7E8YUI2XwFT9bzc0I1towEJVhT15NfCLp/w4bhE8RDlPpJ3c9OomthBWun4=
X-Gm-Gg: ASbGncvGTMbPKjBkxuSr5oDETqJvKn/kXDeN3qLQ0XfHHYaqP/gN/d4fhWbsMPGiUHS
	zDhO3h/QqNqAZH9b6ARG/xU01GitvcSkvIMkgZRm4CwegR8kf8f/X64rVSxbT6uYfKoohOb5A4B
	FnK8zvtybfD36QB+SRqboO3dEizhsXymvwIYGS46BJOyOap9oGfVJe9vgPEgmzoTFn99NrXRy7Y
	Ba3SrNryWt3kxuTM9NMnYQRkEAi+ZmsH3KNcmxjonfAnv/QjLhS/1EzRBDgtyQf8kDvqBxlwDBP
	y0+jlBX2/Sa9PfaujVcJCcU6Be4YIXwghkrUZkaYYTnB1Oqy8XHBzd6uoP8uyMFAJSLkUN8T2cU
	j5FU4Adfhf7IpvPZSScwKmleAkWWyhB+ghka2ncjYJ/2kcxw0CAPPvMSoekbY9JQ1xk7oMOj0
X-Received: by 2002:a05:6a20:1611:b0:334:98c0:9c3a with SMTP id adf61e73a8af0-334a8585723mr23162900637.24.1761098347812;
        Tue, 21 Oct 2025 18:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA3Ow01RmsRCtTan9tz/juMLr3gv7kE5ADQ1R9VputSABfYuzoLi42dtGfxiqZ1ISudZNqwg==
X-Received: by 2002:a05:6a20:1611:b0:334:98c0:9c3a with SMTP id adf61e73a8af0-334a8585723mr23162879637.24.1761098347339;
        Tue, 21 Oct 2025 18:59:07 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76676a2esm11489091a12.15.2025.10.21.18.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 18:59:07 -0700 (PDT)
Message-ID: <1f49fc62-9416-4443-ac47-e67fb7836797@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 09:59:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/4] wifi: ath11k: add support for Tx Power
 insertion
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX9GXeXzUPLvPx
 g+A01SfUs4esmLD5ZVnPsnClTv0Mej/56g7qqDYSbstncrZgAH8MVdDsf2VlO8caubQZ6VG31A2
 qqPPVYRIWCPkQOKeBbaNRyMut3aGajzj5H3cN47QkxB03IpSRHiR7r9iS/QuaQeQ/fzgbDPgAei
 enORK0ytjGW4m1dpl+4NLfHOgu7ltNgbyiybRtDOaCjFUq+kjZmsNN2+1+kqppfhmaLUGlGSBwJ
 SB+y6NLSjtTfDtdVxauj/OZyO79BgGvGD1QgEQFdRqKEMYPUwLY5A4chidCx3242CC9ge/CRrh+
 H3wfptMlTa8gw3mRVm0wTYV+Yfx97wDqkZUhbl9dHsp0AZFPEG6AIkZeWnaQgH0SOxowntD0fBz
 bgeYrNNRtsmPhv1AUOVrzi4w34D9nQ==
X-Proofpoint-GUID: qeeicM1AeQvz1n4aYjqvf2Oba3gKD_e6
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f83a6d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9jhMNZ7qWXdoG8tHMgQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: qeeicM1AeQvz1n4aYjqvf2Oba3gKD_e6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000



On 10/17/2025 12:07 PM, Aditya Kumar Singh wrote:
> For certain action frames like the TPC Report IE in the spectrum management
> TPC Report action frame, and in the Radio Measurement Link Measurement
> Report action frame there is a requirement to fill in the current
> and max Tx power of the device in the packet.
> 
> Add support to populate these fields in the relevant packets. Advertise
> this capability from the driver using the feature flag
> NL80211_FEATURE_TX_POWER_INSERTION.
> 
> In software-encrypted cases such as PMF, skip insertion since the packets
> are already encrypted and cannot be modified.
> 
> Patch Overview:
> Patches 1 and 2 serve as preparatory groundwork.
> Patches 3 and 4 implement the core changes described.
> 
> For context, this ath11k implementation is adapted from prior ath12k work [1].
> 
> Reference:
> [1] https://lore.kernel.org/linux-wireless/20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com/
> 
> ---
> Aditya Kumar Singh (4):
>       wifi: ath11k: relocate some Tx power related functions in mac.c
>       wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
>       wifi: ath11k: add support for Tx Power insertion in RRM action frame
>       wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION
> 
>  drivers/net/wireless/ath/ath11k/mac.c | 447 ++++++++++++++++++++++++----------
>  1 file changed, 312 insertions(+), 135 deletions(-)
> ---
> base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3
> change-id: 20251008-add_tx_power_insertion_support-e5225e924bfd
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


