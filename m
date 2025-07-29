Return-Path: <linux-kernel+bounces-749306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF60B14CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9F33A58F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5F28C02F;
	Tue, 29 Jul 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xrw44Sfh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872328BA89
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786898; cv=none; b=aZxUYyZ/EU1fjnoXejRdCPJXUtggi98faBY4x4Pg+Gu/6XBgmxfN1Zd5epV+Z4owMuIBCdEjogMW+VS3AaVLWlz3PZhdXrBhYlpyKyz30lIPUYyvcIf2/Riv3PM5DlNTF6x9iHmKnxccdG2gzDXpAIgpMD+0QEZmjBTlow5UrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786898; c=relaxed/simple;
	bh=8f2SEo4XBdgTs1jpjDIkot8A+fWIBeuKn/IbDGluHN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWa03kh21zq2/f/x4US54FHBc8JiHzmR8IfDn48NzCseoVFPyGJbyier9iKH7zRD7UcjY1C6dYrCsrljfhxVHLV39XG2IhZ+rQdv1wFEX7X/UW6W9wLzMDE4ZTyO5ziOYLFJqTI2UAn6HJ9vPnRuc/Jx/ajLQxFeCR2Raz72RHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xrw44Sfh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8b77H014622
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K96z8vUYHVZ1BnPPZ4P6DoWPT/UnQ3ldWwK7PWSLHpk=; b=Xrw44SfhSillDu7X
	wSrJyJrHDfoJeggTAMaAacR/4bLMaqQ7vGDjsnfVX7zeCSOUFQzVnSEOH0MGm/ft
	UT5TNEftv5qp+w2lQ3NkzZ168uu9Os4QvCwmNFs1kP28X16Cr5dHFH9hRTwQNCFX
	e1S7eKuUWfjMHRhti+QGmzYy+zuq76UBrhPy6tlSSN580JU7ELaD4fUTW+oC/jK/
	Qr/sRQ0QvIpVvhCr1kuk2npFLPa7TlmZ/ElK/2ixGoWbh90M028vTxKFazasS8KJ
	Rec0/pTJwKs01B91VqK3oiRnOCVKLYCWxMOY6Bq2F41zfOdjRmPNv0KOiQ6xNMhS
	c2PBXw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xqt10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:01:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7deca3ef277so108417285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786895; x=1754391695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K96z8vUYHVZ1BnPPZ4P6DoWPT/UnQ3ldWwK7PWSLHpk=;
        b=Oc4qv6IX59r4b6fukxdzm1WHS/U/e3KVwGfPmd8nptTtH7IGmbe7TWSjMQ9Y7onfN+
         IYzwNdMTXyQhPI5Y/MqVlFqSqigC6bs//7cJG1TcU59XpDGZY9wul0D9MTX1PQz0mHhm
         6wgRQHTAvHqQXK24GCwJbKPRb75F7+Xup9hJVAZFFt9hsbg24DCD3A1zb8sM+U61Ku5i
         kwzzgBKpYgCRKdTCP7XVgrDhr1S7mca9KwDQ/eLBJjPkso3JwNIG4juXFs6GvicoM+pF
         maZKJhS2fe3BcqBhKq6uDmk9N4kNmGFrb4qZua2LG+fNR7YmHE+JZl7hoBRg/uGz4sNx
         h8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxpNL1ux1ryJ2FqfXhZVZdsS2J9wSaj74iYdo03kT2Ax/UjdnpuwlHqDp+3ozWH4Y7XQ8RIdRQaNP4vr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0qgl8ecOICQaKB4jAbWaJC2NSWeuW64coDZ8ThzYjrbbPPCA
	DX1ImAxfWsgOnc1ZN3oyXb7ZCSNDB95hvHksvEZ3cMLAjAjDznA13MP/CFj64r7iBI2rYMyd/3l
	WFUQPXBHDptc1yQWjbZyuTHBkF/tuT41rm7/PmKra8h9gnmWVh0LLOJJjMyQAKc1YwPA=
X-Gm-Gg: ASbGncv68a3XrEvgQy4h6ldPoKiEmC7QjPT7e9EEgoQxEHw79FUhetuSo18D3B8QpiW
	vIzvxahZJpZV9o3ZCJ6RCr4eSb/ZxyP1WEKRygoV6tbVULDnyEUaJRtLxJRHYHggflULu/sFBU0
	VqYXskt/GnI4j5VVae9yn45Mjsq+00Rkv6zQdpdZvBurGKo+R1kq/ntZO/sTbrzswbAZD4o1nLZ
	kLIQtWbX8mHV/w7NZrtSVD0qx/HCblhKaOzsVjMH5gLgJUqlcBaVgvsHCeVwn0wZ9NzXxaHYNlY
	NM/l7t6BR8ETSn6FM7xWuFJWQ8qPkTTYnA767yAOUyvgJg1LTHKx+I5D4ZL8HDciJCZO2uTcal2
	7rpjnFHAkm2B/kagK7Q==
X-Received: by 2002:a05:620a:199a:b0:7e3:2c3a:aac5 with SMTP id af79cd13be357-7e63bfb2a75mr936547785a.12.1753786895050;
        Tue, 29 Jul 2025 04:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5hkbGdP9yGcQW8bBmtcA+DatoS6/Sk05o9vp3Pm8uMRRyc9F2uLjItN9/JUxZOI4zhhcinQ==
X-Received: by 2002:a05:620a:199a:b0:7e3:2c3a:aac5 with SMTP id af79cd13be357-7e63bfb2a75mr936544385a.12.1753786894421;
        Tue, 29 Jul 2025 04:01:34 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm3534384a12.45.2025.07.29.04.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 04:01:33 -0700 (PDT)
Message-ID: <f3c004a9-dba9-48b5-9930-979053d0a32c@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 13:01:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] leds: flash: leds-qcom-flash: update torch current
 clamp setting
To: fenglin.wu@oss.qualcomm.com, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-fix-torch-clamp-issue-v2-0-9b83816437a3@oss.qualcomm.com>
 <20250729-fix-torch-clamp-issue-v2-1-9b83816437a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250729-fix-torch-clamp-issue-v2-1-9b83816437a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6888aa10 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=m2s_gCkc1pbH6IbsRzcA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 3gelE3MuOA4UgdIl6wcVE5ksXls-rqSm
X-Proofpoint-GUID: 3gelE3MuOA4UgdIl6wcVE5ksXls-rqSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NSBTYWx0ZWRfXxlrd2yVR4A6p
 vF65h08Eu7+3dhIGMVeo7K+ZW5I/4pcm9AhHe7Nd2M/g9gp54E2dZpT7TffCBAlhnyVH+3wcp6t
 S6qp7zSqB/HxOGrynx/UZWxqNF2srFYwegkthnU2WG64Y6i281RyMhQvIN8+S22RMCH+tLy4pnu
 JafkF3u+q9hd9MroNk23dBuSHwFkG3D88iY0MyXVf/qOZRNXv1TEOf3CG83aeqGUG4TeZt5kez0
 ZXjKBidr9KD16t6n8okP4Sf48EyVlSnvZSMnHHjO3nsi7QJ5qI8kuVLQcvQsGeuH9lQznN+OkXO
 y8jhOoYBySMExCu9ejVqPi9rfwqo4K4v8VJ+QteP/RLCjKvn1lQ8FJE2ChzNaOEGLGT5P80kTxf
 cVU2NO2+u4NQmsCWC8SiWbohgV5pOwweSM0opIZS3hgFlMqUaozX7b8R4v1unbuqadAj5CS/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290085

On 7/29/25 6:51 AM, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> There is a register to clamp the flash current per LED channel when
> safety timer is disabled. It needs to be updated according to the
> maximum torch LED current setting to ensure the torch current won't
> be clamped unexpectedly.
> 
> Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---

I'd prefer the regfield change was done in a separate commit,
but it's not groundbreaking so I don't mind that much

[...]

>  struct qcom_flash_led {
> @@ -702,6 +706,7 @@ static int qcom_flash_register_led_device(struct device *dev,
>  	u32 current_ua, timeout_us;
>  	u32 channels[4];
>  	int i, rc, count;
> +	u8 torch_clamp;
>  
>  	count = fwnode_property_count_u32(node, "led-sources");
>  	if (count <= 0) {
> @@ -751,6 +756,12 @@ static int qcom_flash_register_led_device(struct device *dev,
>  	current_ua = min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_count);
>  	led->max_torch_current_ma = current_ua / UA_PER_MA;
>  
> +	torch_clamp = (current_ua / led->chan_count) / TORCH_IRES_UA;
> +	if (torch_clamp != 0)
> +		torch_clamp--;
> +
> +	flash_data->torch_clamp = max_t(u8, flash_data->torch_clamp, torch_clamp);

Please confirm if I understand correctly, we may have N flash LEDs 
connected, and this additional safety hardware can only compare any
individual LED's current draw against a single maximum value, which
we're setting here

Konrad

