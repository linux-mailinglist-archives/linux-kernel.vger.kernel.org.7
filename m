Return-Path: <linux-kernel+bounces-888796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6386C3BF14
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB0D188FB39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585143446B0;
	Thu,  6 Nov 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ErN99+zn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VC4p3Ra3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A931326A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441114; cv=none; b=K9mslaHvP1ivKCUvC7S4nX7o5gV9sQCHOHo4cLQ/SyHzlFBEdMJJeDjkX6XL/lUV+YLJ4aA/gRJuxhGgBizxuWQFwE5cop2peVCbIOfbedyyIIc96aW75iObAfQLjmft/wb1OXfBmZn2popez7pneqhgSwGxXTgYXbCf0qI4qj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441114; c=relaxed/simple;
	bh=wHjCF8IEFhlkHVeBtODMM0Twhtinbk9jVlqp9J8Ua4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYg9k+UeJ0EInDrT/pv+L9uUBzX6OhyXIGOcBOEt/VlMouTA+NxeC4MdqrZzIro71es/RyStBb9ThzGfXZeJH5IxgOEH52se32jnDfXTMjOdV3GSchfURzZAC2/t1P81XlkgoMF8FdAn81v0GyK8NDVaX0xRa8N/YSrVjjtOD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErN99+zn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VC4p3Ra3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6BlMaa4131640
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 14:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0f0Yt6BImgfsLX1VnK160zjY+hQZVBZMn8DoklT0x+M=; b=ErN99+zn6TORx8P5
	MbP4jS6yu+eedDMXyYq61cyBKDfeTwTOxwr+McB+MnXCSX/Yvrt0OQEFPoeO785M
	R4e+dPTDHba/WDlqZ/MRn9jxR9/3ZOOAkYNRBbRraGUJF8d7O8syCaVLHJj392/i
	JYNuLKgWa71i4iOMQW+TDcjoPU0P35qOOAv9uJepBbjBFo04WNVCvznhwD4eCBlq
	Fm5PQ4aZJqCclbG1pIb3TVrCZqBvf34uWZsSzgZgVZBqkDUhA6sq/GXE/9Gdr5YD
	2N5sQXdYmKnT8Krs/pTNh3SVejMpc6ojFj/lqC/mrKuFMa/iDA+kesQq7nH1S45o
	gLtSBg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x0hfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:58:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b1f633955cso16344485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762441111; x=1763045911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0f0Yt6BImgfsLX1VnK160zjY+hQZVBZMn8DoklT0x+M=;
        b=VC4p3Ra3JNEYPtI5yUy1/INqfdQzX7YtoM/JJmVu8ZFvhBJZLF43Ky80K945phFGBl
         nPotlKhHc/HQhx9xrN/D5lstEOj3YcFiHovw2CtdHEBkZmY2tQBfFnw1yMSsihdv+WIC
         9HzHBHHR0Lc7GCWJlK1qG+BgXs49i9msp8uuZBXVa6imncpKANtVtlaODxDT3BElTvi0
         ZSeG3PGZxsZvM0zziTVogeOO4hHSxGLB3HdYOOG74t5lOroOCJB/0iy6YRKGMKiFE/oU
         WuXGO2vQc6Ts7FCYaR3qp6R6PsHlTxr6r+vDmfvJomod+WaPVgq1alhFhU967jhnL3/p
         SM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441111; x=1763045911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0f0Yt6BImgfsLX1VnK160zjY+hQZVBZMn8DoklT0x+M=;
        b=D0HrYr9tIIzAJu/qIpPEXJA4qzCl2ka60DXu9KQaDYV0bZexlldo4yY5vPGI9ABE3H
         dSuMj5LolV+qjD3uJtN5PfG4ajgk9MEEwT8/pRQMcG/PD5EvCfoP+f1deWioQ+K93i3a
         ENlEdjmUM1akzFZMs6GyijrZTODkzUrCeF39Rk6n+AEqD+n8hBHJC8Szfh9d+YWCfqJT
         PmF/W8k7lwQqyqqVHXXxk4ZWp+ZywMh6jMDR2D3pVwUKiC/JA8M/XoTtF/UOPZ94LdZQ
         Reh/j1q4sAe8xfdLEsVRnVFGn/TBO9n30LrY5mQLmG3FKoPH2d/9By6Vo8kYbvfiXQxf
         zHSg==
X-Forwarded-Encrypted: i=1; AJvYcCUflGlk6C30BhXKMPz9rVrRXSVIq4rlpakY6xHaVQlteW4zr0RcaK9lHG8ye9ERCBwOxO01tMav4HfPIpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabkpLQ+aQ3lFzJOmF9QU3GDM3BbEK3QqSvKlD5YPs5OeoXlun
	CPbPkvAaqZhpalwjesEEBfFPtIWz6IAnRuPe0xwMZ3iV8+Lzd90VUze14i/hVybqavkQzLJXyJG
	DvJ4iPgRjyPqpY9fwhrqod347QQk7XDEMCpnFqyCOSRYzlUhkgE145SrZTM8V+oKomOM=
X-Gm-Gg: ASbGnctZCl9Wtas2Id6GWVzBdDnj0tMLdECWj5eudmE38UsqYQi/uim1ShXv+eHlOd1
	nuka9gFxOt8twAVQ042/l+lQYBeCEzLGgDw6wDvIUquYM1ocDXINqGJ5KbOzDNF7SGd+wqNKL7D
	q7oElm7wJp2fIXJYa9alixLRq/JqHCKAgh12bU0rJfqxH51u642nZ+fTB98GUQcMJy2qDaqGwCg
	CafbhvrtxJ953+bfN+1B7XCv6HkTuHABi0iG3Zzuv01x9qRXvZ7pQs4fw3hRS6/pgytXcYi48j/
	MXCZzPI0kaua1DM0atekIcJyqFqPBYxjpawMOdzA+slPHIgt9iQEujW1gXBBp/WsEhWAUg25Aob
	eteL4MEddPsc9YtzIJdZkC+SFP+Qnxm7TIlqalULmZPEYC/vbZjdeGvtL
X-Received: by 2002:a05:620a:4542:b0:8a5:2246:bc29 with SMTP id af79cd13be357-8b220ad7018mr654836485a.8.1762441111170;
        Thu, 06 Nov 2025 06:58:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIAGacM18ZhwI0THFt+BtjFFO0RmYpDm0B1ry9GZvpBjnFxTd3iqjoXH2/KEvfgGC8+bdwYg==
X-Received: by 2002:a05:620a:4542:b0:8a5:2246:bc29 with SMTP id af79cd13be357-8b220ad7018mr654834285a.8.1762441110580;
        Thu, 06 Nov 2025 06:58:30 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-641245fb967sm1379654a12.20.2025.11.06.06.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:58:30 -0800 (PST)
Message-ID: <9b024347-21ec-426c-b783-1a9351fc248c@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 15:58:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: codecs: va-macro: fix resource leak in probe
 error path
To: Haotian Zhang <vulab@iscas.ac.cn>, Srinivas Kandagatla
 <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251106075055.555-1-vulab@iscas.ac.cn>
 <20251106143114.729-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106143114.729-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDExOCBTYWx0ZWRfX4qoo5ukfCHE+
 096DJQf6WVnaHm6YsocwqaKyYipYSkO71b7CIDUjZsMdgQWeUPsnrteVAN60IKrasflU+yaeIE1
 Qk6qjH0mBka7x2gGiDy7ECAvaypQY9Oq4ZzhHKgtDxWemflA37ChjZ4lNyhrrYFxeLRkekwl7ZV
 SIRjeMD9kN71YPFnqwt7HDthmG12o/HRRPfWokohexeonBvyD+iyCQk3HodaJY56C56C8X3EGdb
 orKTya/K2Y93qeEpv9gjPmfxyT+O3uUiW8mn0K7X2LqVCvteGol5jYdjtc7YCbKCb+fpgADO60J
 e0Bc7iWsc0QEtqkXDsmVrUdlZPf0tJKl/LsRZT9Q+zBl4qutYtcvsXigFc1dE1bTrWgKkZQEKgj
 wTNz5C8/ynJ/+T3qfVlQRSTr0IrkLw==
X-Proofpoint-ORIG-GUID: pkT3xg9ipySfcU-pPIofhHyeB3klKhBa
X-Proofpoint-GUID: pkT3xg9ipySfcU-pPIofhHyeB3klKhBa
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690cb798 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_CcdfDJzPmikts8YXegA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060118

On 11/6/25 3:31 PM, Haotian Zhang wrote:
> In the commit referenced by the Fixes tag, clk_hw_get_clk()
> was added in va_macro_probe() to get the fsgen clock,
> but forgot to add the corresponding clk_put() in va_macro_remove().
> This leads to a clock reference leak when the driver is unloaded.
> 
> Switch to devm_clk_hw_get_clk() to automatically manage the
> clock resource.
> 
> Fixes: 30097967e056 ("ASoC: codecs: va-macro: use fsgen as clock")
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I feel like that's a little much given you found the original issue
and I only suggested a different way to tackle it, but regardless:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

