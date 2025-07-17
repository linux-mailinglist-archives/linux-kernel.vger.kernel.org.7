Return-Path: <linux-kernel+bounces-735985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA93B09645
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E111C46FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDF021C177;
	Thu, 17 Jul 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fIMVvM1b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48371FBCB2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786406; cv=none; b=YbkLY7yOTvd+rCSJyRXEy3kFw17HE/rR5nO+LOhXPe1boWgj9r23sNO4OpgYTNw+T+9sT5KLDy5az6+a3NssfXbuPpPuRFQ8pzMlfZL6Kwk3L5U2vVKL1M3QdG3yGzGHtpRyVioLl1fVtcbDgVv+9w/ap8k0L8YQmE4D/3AtpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786406; c=relaxed/simple;
	bh=uhfsvd6ujR5IiuRkGHiGSpUgRbJAikw6tYn5QgEz+VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZPnVutYRFUUSYdY464zKSfX0MaahEpzWuGBUpsulYcACima/UDlKd4sx9w4A+mUaDlW1hcnk5C7LHJ5LsGJEkx9OrpPpzTaKmFKi6cSQq77I1swAxxq/7e8T2B7y1ZgcChumDgGhVMl2MgZ9YdADoLFsJFnnLovZJPl0QvNHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fIMVvM1b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBrP7t025369
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gjye/euzJtJqLLETvGURwJ94G0Q37cEw/XWFQryemcE=; b=fIMVvM1bN1hE4eUK
	WGzlKQawrUeXo7QK+Ku6DfRkL9mijak+Krr7T78veaG/n+2cu3v93hVr3JsQ5ME3
	cXLeCvcFfBgaodGi5fGCWH6LSu6KmvUVMrvzmNI3+sn0hvy/6RF4XsxtvDzY51m+
	kjvLDcteG81VEZOwVTB5gkcp26i7buKXYdP3h4qqW9pDz67Wb1JaThOwzNAhVruR
	SWd7LGbo5HkjnpTs0FRDOSyuVu1fSs1L4OaHU6uz1gm1ABKhY0RyXq6ZTeKy/6Kz
	G3cl1nZNOWZ230vSSGE22EyN2fimf8eiLR1KADQOvSBbrwiZgqE/qaD2L5kdgJ5y
	04lUug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqdc5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:06:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7deca3ef277so32279585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786403; x=1753391203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjye/euzJtJqLLETvGURwJ94G0Q37cEw/XWFQryemcE=;
        b=SFLy18NUSA2gpqL7NNQBQQM5ENwWtWOz93NlRQjcXGZsHUYWoRtj5RoqMsvr/BAVVH
         zUePjsc2epwWDgxnH9i/s4sh4NeOf5nfKXCfo8vGh17JUNpzUGGsE/wIU8RJcoK8oWpE
         Scj+4ljsfD/8yxN73Yap5RBASgr0C6fgQrTuC45yXg2nyk+PUtjxQqX1/mFSw9Nb7B/v
         Fmsbv5JNiGIDKzGVF8vTOgpXexntvgkpeYqvlUgdWBWwc6jnU1NyQjmW8Mb3LgOGdV+g
         0AT8qSO7sbeS4OYzqwuJJ6H/UDxRtGs07KyDDTU2yg+Ucudr+KwfZBQukPZfo/45A5TW
         +2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP0JRuL9h1BZ/HksxejdIihUEiwDL2YKoZMRfQ/SKNalGEfGZFnSMTPmQytqM8g8A09MfbeCbRKS02i3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYwi7qeo6Mykh6cHKpo3FxsDUJDGBsq38YGcXiaJKsOuNZui+
	tWxiQzzNiB32+w9M+cGOsE3d5FHUYkgBU3zIxbWekZWgXjqP54zVOfDVS40j0dyt4TesjzaJHsu
	M5TjE6tjVqeOth3NLuh0Ii+TiSOGWQsDFraQI6pMLjvm2duFZAXOox+K+mUgSZFXiQqc=
X-Gm-Gg: ASbGncsHnj+JuXDGRxa5T2lwVvzimaysP0CkXG8ZF1iwlaeRlL0duqrRj0fgSGKemBs
	vcngtTihgtAtkjkst4BdRrzZrQZVfF1mD1M2HV5wUXR2G9bJraUA4c3zt5yPinWK3ESQOndvSfq
	RBhVoT+iOZxHOb1RXvX8SNRwWlDYcwQbhfa7MGTEDjnQ8oXSGUuEUHK3B9KowpyWmvwChgg0Hq2
	obx7ucbFqEkGDDYR8QM2XcTxWH2RG9uRJ1jqZq0Xi+KEleeQqLJUWjy+ByThsS3zW8n3Lf2k7T6
	7s41Y83FQXwW2BwMr9m9pF5k9KlBvW+QhyhzGtVXu8acjzCbw61+nnxD/8y2fg0tMC2msATMDvd
	BMqmIlrxYuDQHdUxwusKo
X-Received: by 2002:a05:620a:192a:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e342abd519mr451825585a.5.1752786402695;
        Thu, 17 Jul 2025 14:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuPa/yRCQICTQrA+jm+Q73xxpZUEJk2US/0cdFi63bdkyvw+FC7AgcXaKulKKmsTwOdsW8rg==
X-Received: by 2002:a05:620a:192a:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e342abd519mr451822985a.5.1752786402252;
        Thu, 17 Jul 2025 14:06:42 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826461esm1427290566b.100.2025.07.17.14.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 14:06:41 -0700 (PDT)
Message-ID: <653da558-9dff-442d-acc7-65a1c0f84494@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 23:06:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: Add PM7550 PMIC
To: Luca Weiss <luca.weiss@fairphone.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
 <20250709-sm7635-pmxr2230-v2-5-09777dab0a95@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709-sm7635-pmxr2230-v2-5-09777dab0a95@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687965e3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10 a=AYr37p2UDEkA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 4u7q3VaHWQFPYVG_fB5S8sLNsQ58JT8g
X-Proofpoint-GUID: 4u7q3VaHWQFPYVG_fB5S8sLNsQ58JT8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4NiBTYWx0ZWRfX7Nhp+jmqktKt
 vgbyemSftJ+SzOEZpPqUCOyQ7evwUU7LXGoxwa5jiFboT5HBf0zV9V1ZOPV67eTJXEmxsgnqLN7
 SLBpKQ8fws1MKYDexBZ0ppn7mmFTvKZl2brBF2YSpP/2vGB4AetqNATusHXp4tIZR0D0gxZw5qb
 nM0YC9QcZdnUEQRkjhFS1bIc7hJSq1FdO/qJovTFAVs2iAvHDhpq4sYBJ61gjw/e080P6raPtot
 hgBaIw0Uesh/ZeZ8cxE/lTzhNYXHw4hXMz2st36UgW81RhO5fVAK0cIAaQf0hMy+/SXU1dm0xPc
 gw6Iw3wLc3wQ3q+QCHYbI583g+0TpFJdtBPuw5dO/JwbpbwHig32NwgQ/rfB3i+mzSxOoHM7ajm
 8ScdJswHSr7kSQUCGNo+sAqvLQXQZ40Mw9HPrwFPKfD7aZpKpSh7iN+sMQD7ARO4lGO5V6+u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=884 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170186

On 7/9/25 1:46 PM, Luca Weiss wrote:
> Add a dts for the PMIC used e.g. with Milos SoC-based devices.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

