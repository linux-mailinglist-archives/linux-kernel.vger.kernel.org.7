Return-Path: <linux-kernel+bounces-768437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D2B26111
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCB1586088
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3E2F6584;
	Thu, 14 Aug 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PXNjPbtC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE682EAB9C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163762; cv=none; b=BSk/R5EdVD6uamwbXCIHZ5ZzW/dL3nx5KRB3e+zLjd1JxRaT/kdGPcuaI8J/xBPZOjpi9ZGFICcRmJ9VSLne8oQiqx3juihEj1OLdXdqtHU1CNSuzhuyL/PfONlWmXrWZhrGa6PJRiY+oHfVVZ1bPnM/oEb7O8yvpGSku7tY7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163762; c=relaxed/simple;
	bh=hmfMkqS6ana0u+EpKErIDoMyw51bTZi24YBu1Ydi3bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeoDtKxJbdkhrkxCRelyDJhZodl6qpb9s3/LCzVwVpC/4TgHkKn0sUs879pgX0uaCYA54Tv0mneRfH7lfRQf1bSRGiDVEnVR16bYKKo3UTSrYm1Mgn+PT1QBaYrnOGycHg9WoX1uXbHWOUiYUDAZ9kzPPVPBIQ0ti3Hwi2pX1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PXNjPbtC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8X1YA013413
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fk8nJ1U4NK4Cq47g1680MH6eNs+TxYDcB6S39IrWtnQ=; b=PXNjPbtC0+ZaKsqf
	iqfflzYteWLXdyvnk16p25vqLncF302dXFfw0euC8CdGmGKWclLanuyT+Hsg+r8e
	mT2e0paHcOAh0zG7yVKnKiy3W5pQqHDbGiFZtC/eJD0a44vS7FIKppP8JoQQ8RIq
	JWHGLYP7LqaMdgBIpO3YC4+e1IZ+ybSqO0jHbyrX+kT/BYnywIaXNlf7Hj36UkHk
	PdyaU5VYaPo1DbIek+etbkkWuhFNrpL2fiUwy2VTPgIM9W3gaAGsmBbhdfZX6Z4u
	fOH1Uy+xn58uaTtKZV+CFUVDjQiUcXAGPenp2XnHViJUEABKxFFRrMH2cuY/fxPY
	v2oGog==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxda8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:29:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c6bf1dso1890331cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163759; x=1755768559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fk8nJ1U4NK4Cq47g1680MH6eNs+TxYDcB6S39IrWtnQ=;
        b=fWU4TmpQzZIkDdJmuiM/87baWiNjj6cB3IbxLtwWYtOiEtpStoEMhvNE1KG+FOuFcx
         TM3zY0PoXoMfk2hgn0tTtFhy6vwISHt+tnCd1YlTzBK8QxIP+oQ41lZaBXXWe9mk/QQF
         UfrLKvS79T26fAkTlC4Z0Y7cDID2RbWcZ69PBFvX8W9PnIPZLz+J1vX8tZwrBU6QgXNO
         NkRXAf5rKT6NWyqjUz7Y9ho2uAza7D+XSUkZZIPBOeIB5Ti7R/hrCLdvIN54FL30XnzS
         QafHUJXGEvdaCxO+NyQcgbWWO12+0LcFQXmv2I3ZUPZ7eLklCCYR+NXoAFGKWyva33lz
         dHcg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Y65mkr7wCtsEEqBZ4+0RO1coMhhKhQ5XvYZybC7ECgVZL0dtjhnZ3UnQQ47Lpytl8cicw2nfnLVWYm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZzP0LlcUYnMKwaHjqzRCXV3/pmf4Ms2Ve6uZLfeCQzqSZzhj
	9nS0PetMX3x1bqtkQNYJ3nUJ/HJvj+LLZ+/oLJQ4FpomCJjrI9768lkFwAcN3m2R48/fs3S36Y2
	e5E51DcxugtK66zRcUk2Ig79mgcMerIkPp7yFAngqeiuq6bm2Q0qYdhkUyW6j67s3DnI=
X-Gm-Gg: ASbGnctfXszfiRUM4K0b0jQjgD9Wtdc8o4KZo9v3rzE+tcDYGp8PhwM8pxlqg9NSvdp
	B8IcMolBRclZ/bLWs60ManjVsW3bJyrM01Cf7D/F12kvbVv5c/68aoiWcVRu4709Z6zZpOiXnAc
	PGM+EZH5+oJhucfXkclzsMRvudyrpvRGzwtd2tjQ/91euVxjnGNRWyr7pTecqU6X2wC4vXzNmNP
	n6Gj5GGn79NZyc5WQqdnvP4ASJ72SV6GukF+Jk3ObmK+BdPxon1dgEkjvrgYBOuz/cTSvQB7g5S
	wHlJcwpbwjGAHRiGxtfVGfkGujnylCEE8mp/FNmrrRpwucM5oyjg1DVqcwSEFzI7Vg8S0Aax/XT
	0KDncrnFDp3v3J6ZJhA==
X-Received: by 2002:ac8:7f44:0:b0:4ae:f8d8:b0fb with SMTP id d75a77b69052e-4b10aa20816mr14365111cf.5.1755163759441;
        Thu, 14 Aug 2025 02:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoUkspxZxE88fQ6qSXjIdAljwmvy0iwKdluYs2HX9M4nASHP+BgW5vGIwCkTyXEfvxEYXJoQ==
X-Received: by 2002:ac8:7f44:0:b0:4ae:f8d8:b0fb with SMTP id d75a77b69052e-4b10aa20816mr14364911cf.5.1755163758949;
        Thu, 14 Aug 2025 02:29:18 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3cecsm2549508666b.53.2025.08.14.02.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:29:18 -0700 (PDT)
Message-ID: <e67ec1b9-6e70-4270-8f19-1a29713a124c@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:29:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] soc: remove unneeded 'fast_io' parameter in
 regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
 <20250813161517.4746-19-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250813161517.4746-19-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXxnUSNRlpDM9L
 1l3jgHbJogatLHULrGmzgtpozS4MyldYuGgfGiAyunasPu7jYHXc1dm64/v5MewrKxuLBO1I3kX
 /elLR3Xs8dnBQKTmDXNcQK/8s56KEgV4ypQUhjh3+irJl5LEbmNfSkqldrSiQ8/LoyK45GfKZNe
 yAuaot4AnOeaofANIX5NvakoxGhLPG/Cyy0gTOTiZT2HDR+R6z4likd0nmGwefKWZxA30RBwmIY
 rk4bGQPJ5lc+tTnV0Q9+oBw9m0U9jdfk+XvksUl2BthLia26lt9YWfZzBcdhbL2vvONZOcSEUtD
 ZRZBS7PS544Uuf8VwKtuKELT0Ab2MDK7BjYy4H+GkijcFnr0NNpdlcU0kPz793r2yknI4cSbqkX
 00p7suIe
X-Proofpoint-GUID: EzyJqpmPYo4bDkiGz3bkJCuej7wLhfxh
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689dac70 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=LDBv8-xUAAAA:8 a=EUspDBNiAAAA:8
 a=XH_MJYJbSeHrvvoHTBwA:9 a=QEXdDO2ut3YA:10 a=xtd0hNyKXt8A:10
 a=dawVfQjAaf238kedN5IG:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-ORIG-GUID: EzyJqpmPYo4bDkiGz3bkJCuej7wLhfxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On 8/13/25 6:15 PM, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

