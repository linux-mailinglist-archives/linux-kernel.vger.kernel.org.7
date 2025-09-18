Return-Path: <linux-kernel+bounces-823439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA8B866F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A551C2531B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F292D3EFC;
	Thu, 18 Sep 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KH28pdFF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D382D2498
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220936; cv=none; b=imOxIKzOjgG8MhDN/xstzndR72IYs3rAMxtIAX+cjE6YFGpxW135/g9nqH+FE+vOUlOTBMiHL99qdIP8ERthFlvZC4KXvJSnVyqLAhLqb4zeUeVOOowUNE/RRbhb9yKiwsLsQnd7RfTsxZNaaIzAg1He7uSQ0AMeGAJOWD89I6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220936; c=relaxed/simple;
	bh=po+vLPdEwz+nRrn33wQ6Gz1tHmjdtWHriulevSWkdgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIx3xyvHjCSRXmP4xUq3wN+Z2KtwhKdh/5G6TWqiTzp+gg9H7lpILm2XYo3c9RsxFHs/7h7R8OZcT8Z4FRecqsLinJceY1qERsr/O2bPkeWbO5cXuxNDqVV9DCJaKsoZheKmmg1Hps/RcisvrsT4i9ZtZ7NrCjUurioku136nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KH28pdFF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIPdeG029526
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nF1fA0zbp7Djqf2UTk7dkerj+IhERcStYJUK4pvZ96Y=; b=KH28pdFFlHijuxsQ
	Tkqdw1reTQqEDndBc+MUD9qCFuM2XNpbvqD4c2uEhhH2V4OCR919S5v1UB7AQEy5
	3RlVlVzpTBlZBZONRaTU+84KuVpp9SAY40yGm11mLbRM+bgbzopewjHgb0LbM7Ya
	FGdvtXNzsSTxKCxYO6qfrRFKwN8VwBRaNcPsdcqePqFsn1WGtNZVRw5MqexVIaE/
	iARYmzkEdCwMMREiX/9LTzrhlVHScA/zUXa9hLhVecVVL/hE33NyS+UkgoQRZ4Lw
	tdQryztVonOH63nY8jL4OttMdwwXTOVb/VIThGwyw36RIhVMGDrER0/sPyJn89d8
	9H/keQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0yjk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:42:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7761dc1b36dso2442249b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758220933; x=1758825733;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nF1fA0zbp7Djqf2UTk7dkerj+IhERcStYJUK4pvZ96Y=;
        b=QEdyp9I4gh7/p7TxDdnmBqrhA9JUlhjUPQpBZEoXFkUUOJAQnxSfdhMVJStRKfcm/Q
         Fd53h6KCP9wptxVq/W74+SboWi0UhHSgrx9Fz/jU+4tDOEn6pdXSiMk88yd8JSzH4voB
         5NmsGYU4Y19/DITsXtoWgCaJso/DERWVnLGoitvt6TGrGmDN8XtKY0gNgxZUXau8MFEO
         aPnmMZMC1j1drCWwtnSshyIxPQWuMMTmYUPiK2lppGX+ageUuQJ37SweEn6zSbG8luzp
         pKnQUOJmTeg+8WGGdg9rjig6pV+zPYwGFZ1U1Sfx7yEL5nMm27TZFRlYA6WwzOG7VTC5
         P7xw==
X-Forwarded-Encrypted: i=1; AJvYcCUxWGrE5zR/pc4zqkCseDf7kKlfzDbk5e5FITGau+y0qAv1k3SFHR6A/l+ItGE28dLJOISx+52Y+UR9drw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpBGFPom4HNyviLXHoyeLciCIwNceFrw9nq9s7NEtSJbIJmov
	dwN+i4biQl6Lw8PKTmN+m9j4gh8vZvug4iYqOuhaUCim8yHyMenxYXyr4l6ZbDy3rKTEfYpwRGp
	LqIpONLM44rU3issPCI5OHRnNt3p7I6+kCOiLn3rIqbdBvq85EVZ42ij8H9q4o5T9GbA=
X-Gm-Gg: ASbGncsLLy/xa69x+d2P+RbbTvYg/QK0sdryWeOL049j/E6009ngEitF3QvV7utegqJ
	5NNB1yDGNPxuTbsEO4Mvk2h7VGygqER6srLTZTtx9xM8K0nNVE6NyPzkE4DzShO6bOZokebB1Ol
	DXn5xKCfb1ZlDeo3FSnCAHLzKIVyLMJ57QGDJF8hrb+KaYHvNSEKHYPXdMFmJpwA1C897Tdp+BX
	ZGZVu4uDItCH3rOoilnA8ZC4qUKpebGSGPAfWAc/W2WTuq5XYYbqHllb/OAoJUKMwMMDg+VkLXI
	1rAZjvEaBCW7leBTy4WFXVYBZKgHmO+Ff7cAy54pAzE9AjaTSxyXV/+oAnNz1g22XlbYOH1O08T
	OZoB6n/1F2ZtdTLoUDKcNWTTRYQZq1lPyMCiE
X-Received: by 2002:a05:6a00:3cc9:b0:776:8b9d:85ad with SMTP id d2e1a72fcca58-77e4e8ae21dmr394526b3a.19.1758220932890;
        Thu, 18 Sep 2025 11:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzBPxPNDF/BcchRmyd2ICCvlhe8W1SbwWFUAF0xA+HbKxZJwRAh+LwrobiAdxKNso5yJHRKQ==
X-Received: by 2002:a05:6a00:3cc9:b0:776:8b9d:85ad with SMTP id d2e1a72fcca58-77e4e8ae21dmr394497b3a.19.1758220932404;
        Thu, 18 Sep 2025 11:42:12 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40601sm3020533b3a.87.2025.09.18.11.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:42:12 -0700 (PDT)
Message-ID: <eb3a2ef9-3f93-48be-b6d4-28eeeba84f04@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 11:42:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] ath10k: remove gpio number assignment
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250808151822.536879-1-arnd@kernel.org>
 <20250808151822.536879-17-arnd@kernel.org>
 <27c1274c-e021-ba69-175d-a1271c33498b@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <27c1274c-e021-ba69-175d-a1271c33498b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SVeUPdr1XLpwfwjUEIA_cEus_SofUw5z
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cc5285 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=FtxLtjK2MU5K6IsP0WQA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: SVeUPdr1XLpwfwjUEIA_cEus_SofUw5z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0Qq/Ct0zi7IV
 mBvmxxIpY0/BnhWxodp94hAOW1B1QYlg9eydx701DhpjUs4eUyZ9HEpoTBm64Aj5ct73Ktl7HwC
 tV4rd1I5ftIfk4ftF45hTJGKadkk2Xi28RiH1vt5v0QyKRU4D+9jdTsSfdEmaY/0MMHnXXu//Nn
 M6cbcxlSx/Rip5JkGGebtbJfJHSTW8uC3NyPTEfyo/CebvqXMguHgLS31gYZUmSMTcjgsvyoMwk
 kOubwRsQMVwy3vUWtPSotCwwEwB5d04TeVU0xUF6uj17CQps1VN96w4quCbtQ5rrkPzmEwaqcsS
 ZTuMBWsiGop9xzOTTb5s+Qx9wYlBn6N1NbPnHhis5QG+DHEj6FTSGIUSub2tFkeo4YgcoHzyHhT
 7VWu6tlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/2025 10:22 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 8/8/2025 8:48 PM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The leds-gpio traditionally takes a global gpio number in its platform
>> data, but the number assigned here is not actually such a number but
>> only meant to be used internally to this driver.
>>
>> As part of the kernel-wide cleanup of the old gpiolib interfaces, the
>> 'gpio' number field is going away, so to keep ath10k building, move
>> the assignment into a private structure instead.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/net/wireless/ath/ath10k/leds.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> wifi tag is missing in the patch title.
> 

I'll fix this when I apply the patch

