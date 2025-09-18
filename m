Return-Path: <linux-kernel+bounces-823517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C02B86B56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD401CC1399
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765912DAFD2;
	Thu, 18 Sep 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xtkp4Uxp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F32D9ED5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224114; cv=none; b=nHzskk1Ph8uB0tM3lT/ZRr+CbINYX++4WL3esosE1/pBqo2qLbvv8UfUoPipIoOvL6tdujqRGW+mX88W1bKg1p0aT6cbouKH3h93XIFsI4yrmYkFvrm+58qUF3n9EUabGog9eR/4XFgC7S+7gTy0xh29Oc8fT5zrKKV4dAxtxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224114; c=relaxed/simple;
	bh=UaXvHS26IwDnH8wrFoWwa3f3iOMn9rhhgCGFpZk94oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQIb9ARTqE1lp61xRA81DZfn5eiZS/kXs0wFosC+bs8Z//Mj0lLZ64M8yhiITBuxCgyLmj7zpw3oTjzhFqI3UOePavECIVDab7zMsRKzNJOj2coiiLDe3ll2xW7BDlRSH7oouXc7fWspKODpe84dC7tA/Vn4x1LQVwdhcoqPa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xtkp4Uxp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IILX6i021466
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lXAg7ojCyxBCDClCOw8hFL48+P4B5I4oGQpykRIfRcs=; b=Xtkp4UxpjlRktOka
	jqZWRYl6lSN6eBIMOk4s/wbGhSvw2lIWoj6cu6WlGj6xj3iGFo2eB3QqIeTDMT/0
	uraaCxyVsyAAgfijWWXphxW2hlWGDySWfEhFPiGXgho/D2NZIa1nF+FB6h0q+3Up
	G2W4FhUNU8oPycgRTNshqheGYYz4phi5FHc8Qv9Wph5QRvqH71EGyUlbE/Q5vQvT
	4I8kk0U05HFSM6tVz0KFXgOnzAeKryj3v6pUTUkjzc3p0bgxMN9259j0QXxW92m3
	+sDsp4FptxgRepegnCZPjdn4a2oRtDiQWkmhE4G8a6/k71rAysZOCuKBghjDkR1l
	jGREzA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5funu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:35:11 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-757d075370bso987546a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224111; x=1758828911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXAg7ojCyxBCDClCOw8hFL48+P4B5I4oGQpykRIfRcs=;
        b=qiKpeijc30mCx1UE2kzXWZe9xnW76226msiwtdJ70JWWoS95Ff2X33Oj8kkxKgwyRL
         Kxeuy7Pn4GRJIRlXvSBWUCwF6wrEUskKrhOdRSx39w/sklmwh0XNJ1/VDC6o/C9KBMGh
         bNCxCk0yguSXlMArlQtIEylPpKpAfj/kqJqXubsRVk5FhcpqRXMdzLDiChYfGrT4BoT8
         RpEabGUjq3peYEqbeE1ctk0kNk5NWaxRB/KyBYkyqEy9MGp/OKXtGIFhTG8G9PwaWtVw
         w6Krl3FR8V0nEiAfzvXguA2nRkTBfKun5a1T0HdHmY9oNMo8vLOMOIxRZD567ZgjSMKb
         hwUA==
X-Forwarded-Encrypted: i=1; AJvYcCUxIkfuewhRKB/5asOuQeq2BNZ1GLJOzAJiT3vHS23Sh/zSuZ42O+EvXqCrglBYkPmxtFWArDu3D+TSZPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEt3bS63ii0dt8zwOCzNh+jt1u3xf4sXP7f9B+2ECMr8x0ZYQ
	Jrl0wS0zzJXREcynFBRgZ0QJsEkNZi8gQ0BMJ8ko9fliXj39Uj+/ucUUOHZOespLWfaiKymO9C4
	p1wLeCH6GeLAJ1TIASGoYsHwY58CiqZmuncz2zWwQ+fUE8kdNKM64yF5xx4PSW/GNMVw=
X-Gm-Gg: ASbGncuQWKdQwv8eJrJbovO3CWHi3e8vPTRsEtY9a2uZtxXsVGFUl5iDAv67nzG3TAs
	oBwAeJ+PmejBS+4gC7SCfiRVTsqRspEGy2NlKhW8jFHZ7IP1qIYLvMnh2Q0CzswvUVa0nFLLEHB
	c2b/kw06VKpWXME5F4SCKknSt+sOUBzvRHUjpeI9X8CJ+ZsRVOUxs5lkEQgPXHmP/V1OejOCBds
	sqcc8ZkMNMQw5hVrDwROHY+H1TdVM975JE8qjDOoil2+SIhq+E708tGjXF5g/bgu/f/+NGkVttP
	3AuuYi45d2xn62J3aQ1wReYIzhqEvVqIle2V4FgJrcizMVCgjLTJ5pm/qVxNT253m92YobSwG7u
	n+i98fuwwpIXSuPn2Yp5VZTecZHiImK+SCgFg
X-Received: by 2002:a05:6830:6619:b0:758:4f2f:239c with SMTP id 46e09a7af769-76f7a3a1a45mr571458a34.30.1758224110984;
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwoxCYY5Mc8kGGNdF5NWEJW8KsmKqjizen55hJBywYZk1+LhtDIBl6+ggbcPD21Fo/hCQlzA==
X-Received: by 2002:a05:6830:6619:b0:758:4f2f:239c with SMTP id 46e09a7af769-76f7a3a1a45mr571435a34.30.1758224110392;
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db7d1200sm1008387eaf.21.2025.09.18.12.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
Message-ID: <1e3e936e-595b-40d6-8404-aaeffdeb3df8@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:35:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
To: Matvey Kovalev <matvey.kovalev@ispras.ru>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8r3gTrWeUuMnYjufEbI_PnI3iV98tgMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/d24riBxwKI2
 a+UxUn+uSIfljhZqTTPQosd5Tg/dG3uv+qruMfYZd1ZtgR/bCCx+mIUMSDt7sdApay7xRUGvhjX
 cpLGYxtehNF6EJ7tD63RLsiO198RN0ZYWHaJQYquggXktbq3Hki2AqNXSPud3LdSiGjK6Hi7pR8
 cbwezbwMWFcpJO4yEH/93Myl8VHWHRlCzf7XcTsjQks7BKzJZ65VY4r1yLrWVdArDpyZ43zL9tU
 ieSYKf8SqyC49LeKq7/f9fh3lXT1n+1mgkNKgcgOlJ+gw2rlBa8RronoyuVMukzh8dwDKswwOP/
 dvhBoQGHxvbj7in+xisoXNZHrdnP6Xsb+B0N0mTJJR3wl+X7UlxMJ9ok3viLxKNKVXy2UZlATuE
 uZpKj8dX
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cc5eef cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=KkCtspFpTa3j_I0B6KMA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-ORIG-GUID: 8r3gTrWeUuMnYjufEbI_PnI3iV98tgMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/2025 12:20 PM, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7db88b962f06 ("wifi: ath11k: add firmware-2.bin support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 378ac96b861b7..1a42b4abe7168 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2557,7 +2557,7 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
>  					   GFP_KERNEL);
>  	if (!m3_mem->vaddr) {
>  		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
> -			   fw->size);
> +			   m3_len);
>  		ret = -ENOMEM;
>  		goto out;
>  	}

I'll fix this subject misspelling:
WARNING:TYPO_SPELLING: 'derefence' may be misspelled - perhaps 'dereference'?

/jeff

