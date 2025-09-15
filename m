Return-Path: <linux-kernel+bounces-816216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5EB5711D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC0817BA91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771522D541E;
	Mon, 15 Sep 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCaefz99"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3182D47E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920835; cv=none; b=COofrrTuDdjelDqmOYE6AkO0vL8krzYb0HdVhqlOPOxbdZPfkomXmnG3xtJ5UMY4a2NW9i6mubmFEbcoIWf0whHpjknIr3TLPn/5BxAQq6pCzwP9x5CbxHO+UE1IOcNC/XzuF9SoublQ8sExX7xbMZRCGQfj4q8TJkzJB8Kvig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920835; c=relaxed/simple;
	bh=dVTKoi0nGwph4owDMZBqgXHJGIwE/d/dtjvrxSaCKQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+GSkKMHqo+uNkronyGXC8UWiDS4HCJ5OdDQrf4YTNfODOgAxKJrL8dphqj6NgYh27e16VpPs4wf8BJ1Q2Ws2wqZIniWknSEqezvDkjslOGwhJNCIxeuc6obCAntTG5xFKFnJ7a3yEXNveSL5ANsUPBNAXgsT9LbE6OK8Al5U3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCaefz99; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7IH9V014932
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HfgY+NXWGqdv4i6z+h2XWxwWaOeFu+/MuSreRH2J5fQ=; b=CCaefz99UKypwGuZ
	1bIwdHUqk9YfkymVWXJ65kXP+7C/3DwcpbAfeQElEtHkCVrZED/wGQxvU7WWrBda
	8HTjLQKZZXciavoivsfT+PKlOGaDYLD2IeZrclwWUeVfieVYjxYJ4aHfGa6VWnBh
	Q2cBQMgGAMH3H9jLFgIghnaqnw3G3C3ZDjULIVrcBx7nrq+9JHz6d7j9XZpbwzKz
	0Nd8WAGOrhgD6Uo2hziGtq7qbN2iuJACnRVNQdmKuBpZRNx3uOpE+bn8PwUaTCLl
	vpsoSbkjyOFxfTTDjXCkVR6DLBF3llyTHdZj+clAz1scjC+p/T6h9PG6GSgTjGME
	rfBsdQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9865e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:20:32 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7802f4ccba6so1090616d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920832; x=1758525632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfgY+NXWGqdv4i6z+h2XWxwWaOeFu+/MuSreRH2J5fQ=;
        b=c738MqnZWAzqqAADIj+ckkkimWuRTgbEInBZ2U9fmHC/U68fiS88z1deDjyirFUCd0
         rSrSNIjCH05HDwEp2LwWf1QNiVgM697eUTd0nA7JeqqXZV0MdIfoFlI9ejZWQT4KT5Ri
         qoBur6+y9iW3+kk/IEoM09JHYfBwSnqTY9vJuggzNAwfUqIAQqcAwU7jIJq5ZhLrtHop
         OoVOLN/NIzZOFd6wMsukJgXZHaV+J7pAH0emfWg/+hugFgDTNTq1+a9xo+RnQJLKrXwa
         Nn7KWRdHPFOIWDFfyf0+vKpxjAkuIL1IRyCw4iHWye0H+gqEpcKaWe8ZSSbPKOqcYWmk
         m+JA==
X-Forwarded-Encrypted: i=1; AJvYcCWrbEKkjPSm09fM+yNQwrp+PQ+PjBAMnPSJ74Ty1fir5PYNOZTAwAXcsdO4sdL+yuPwPduPNAY9yZ4fUKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyThp0cy1VonCwgavMa6t4q95+IpGxX9xrmyH5uSby8PlyzNHQu
	0RgFnp3h+lnDoTiGK6+0q7mdkMRxNfxkSZVI+NC0e2tEkyeBEuRo20sw+igGAWw2VK8G2Z7i+jB
	FEU8+z8iXD5AdpYUshMTEeuZBxxGzVZqBYghjSEZZIiUCZcmL0lOkyB63h3OGn/TthUg=
X-Gm-Gg: ASbGnctkjPVBDt4uI//rrmQ97bBCc5lz5MlFCFYNWAH5cv1HqHDJxK9trikYbv+sIzG
	+Ju9GmytTb2PTdCA7ETNPQzPgmL6Su4xlGNkeQ8UqgpzrSbYtmvojzwSxvYj0PQ7TaVsfcuF3T+
	IuZTWhufTcq6E33BXh91qQ4GUctsrlAAnKjpWFiqv7X+4S8kTM0xPLnZBP4x4UfUq83SJl/zIjJ
	H73kYWTQJRUrZ0EUq+5/plFj2Ns84zwJp/zyiTCrPaEt3Sy6uYQQ5j/9CrucUEVB8ByiVyh23Lg
	/SevDr5Nit2DvutXse84zkeIqsfBjef4vgyUPdpR33kG6xJ3LQtnCm7Fp8DICylGkxdp3UEbTRZ
	IUUithUIcg6rerO1PA7KGTg==
X-Received: by 2002:a05:6214:ccf:b0:765:b3dc:a356 with SMTP id 6a1803df08f44-767c5af19dfmr81853986d6.8.1757920832177;
        Mon, 15 Sep 2025 00:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5THJcwEy/hZKY8CARUZgNH4SQ3f05GlZ243mDpvwFVqlZXg8+0mC8pYr+PWlIiNDzDZHdLQ==
X-Received: by 2002:a05:6214:ccf:b0:765:b3dc:a356 with SMTP id 6a1803df08f44-767c5af19dfmr81853766d6.8.1757920831450;
        Mon, 15 Sep 2025 00:20:31 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f41fd18a1sm1327672a12.9.2025.09.15.00.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:20:31 -0700 (PDT)
Message-ID: <d2759bd4-2d31-4feb-a352-4df8ebc609d0@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] arm64: dts: qcom: sdm845-lg-common: Add uarts and
 Bluetooth
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-1-23b4b7790dce@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250913-judyln-dts-v1-1-23b4b7790dce@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c7be40 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=BZiE_1MFHw7nqvKuBP8A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: UfmvRPvFuO_i22W6CjtSMMwxFQ9lPasx
X-Proofpoint-ORIG-GUID: UfmvRPvFuO_i22W6CjtSMMwxFQ9lPasx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX2IKWlCsTh0pf
 QTEP+tDzy6CCt4rbC6t4fW2txtvHhJTFBmre0+1GuFsyK1pQx+YAiokviwnd9p+6df1MG3DBht6
 7IpMPVEy1jHW5JgTtxyo0ZXFp0LGwemng94AyYJ04JiWExfoX+P0AKFXehUocen9cX2mMMw5awI
 8ipOw6I2TrgU2l+hSS3AiAr7HAk7I1I6hTGrNUwutetTNwfXlnZ/iZpsGcYyaicF7EHdZAZKapg
 2McEZ7gUbwWSCve1wHRrsleKqB2BJ4asfPXUS4tA/dTvqsmJa2+IDsCKibjiiBiT1k/qmE4dblz
 1XilCOGOnriC5VN1nFwoWbeNrzzlmmWP9YqYELGcpUUOFGogo0czdF2wovpB/1gDN7KvT4++DrU
 om3I9yqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

On 9/14/25 1:56 AM, Paul Sajna wrote:
> uart9 is debug serial on USB SBU1/2
> uart6 is bluetooth
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---

[...]


> +&uart9 {
> +	label = "LS-UART1";

This is what the name of the output is on 96boards products, I
doubt it makes sense in your case

Konrad

