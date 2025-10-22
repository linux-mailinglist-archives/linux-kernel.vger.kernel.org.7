Return-Path: <linux-kernel+bounces-865283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F077BFCB12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8D118C20B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEB34C811;
	Wed, 22 Oct 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJwrqEJF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CB34B69D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144703; cv=none; b=g1fClZZxzfPE8GQEqqfwsyqAAoYYc+3O3UquR2ZB5FoV55VCyZ7WD/ayKg2UTCcnRB7EZqEmZhK87AvAzZghCVYbBe16zq1fDsxZGlC1Qu6HLyVYPXSY13dSQzK4sYwGKbE9cXX0AnFkjx7+l5xZ6YZ3L8ZPjltfNQ7q1Z6Y3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144703; c=relaxed/simple;
	bh=+lNmP55ZvOzuboNbO6AIVCl9ja7et+pSFN7b3PWR5y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PusSAS++E2gjKSJnd+GaJqrw0OzbVJRmIY4mqOIw1Mf1SVl+65UKuzo91Ma1em5XQbKx3siaHZq1VunwxCiBZgsteXSNSMKPKq+aalpwPIuro+RLsnAeClkc/UQqAMldApuoQlKJhHl67fC0faxSmlDACqNoeMqWbVYLq0cK3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nJwrqEJF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so13294105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761144700; x=1761749500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9yHRG4JI34JOJGAAS4v922SyM9JvWMCsMtr/NEHzv4=;
        b=nJwrqEJFfgmVd1xfG3+yEqcERLAYqQqP7g+emT+JGXxxT0JsxR4pjYAb/5FeuBoycz
         3tE4G4T5IqH1tV5ExrhfjZZhI83G8R6LDsGm8hjvMXKHjO8m2qV4r01SCkVwUvgCNka1
         WI6rhCeYbucijaGAYMrWo32Ub6ZYMkDEnbfL6wqQtDRpiXuG0t99EQigE+q6+yl6XuqT
         M6nVb1z6i3mDqELqkBNRJIonBSVYvRCgTSbV2tMIIUwMMPd+zizVmIxbnnDZICCepPb7
         yu3c4dpgEzCf9b/C7Z06K2RwGPY0tkGOc9O+mWWOx1Yf+Fvd9Wf/ueabd4IcxWsO3DxB
         UFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144700; x=1761749500;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9yHRG4JI34JOJGAAS4v922SyM9JvWMCsMtr/NEHzv4=;
        b=RXJ5YtsBP0VSCTJ2ye0mSTwLYj7LzzMx2FKvijWvnK/QTA8SIwn6gDSqFHzumq1HH3
         Dxa4Q5pUBjqzm5NnL7ZqdkKxxrmzSYrz/SxaMXsj9qQqmtc+i84xhsA7MFzJPgULicuK
         p0cwEVoqAPBwokMt3jjggYFBlWPDpeYgucEJ8D7iB2qwxRTCnDMrctDbiEUwvfh4axwA
         KW3LHeZpWTwwx3W8bw2nM0rU9jW6jOKxtyUiFcdtNmuzAyaC/uAcXYvcw8ZBHnosICeN
         hav1Z9lemW9947k5/ZSUDMeGoO00JCitDJHH9n7ivyOFECBEfL4NWNsUr7FShgnY67Al
         nppA==
X-Forwarded-Encrypted: i=1; AJvYcCU8f5MP8CnWqTiHymUDzkGmdr3JrXAcBTcDlfuOyYo2hUCrkTm8AZBHtBT5UMRyFc9tYAbwHEFuju16GgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuFcwIZc6Zx2+a4kt8zkLVd5WX3s5jiFXJIqccMyyjvic0ivV
	YmH193nUg4wrRBWEG0r+bxMyrKFpR+7nDmprsvCQ/8KMlFzRBO+k7yMnS0XjMhb6kN0=
X-Gm-Gg: ASbGncu2mKORsEy54wSjHyd1je6jwHsRmwpOMVya5ZbBM6AP/7f93B6HoJ0YHX5+yyZ
	QanuO7+SlgJxflPF5blqmZqYrCPajiIDehROPU3vbEnR0owgvEZQfuosy/Gk051fBioNI4kgmhf
	/uXir3NbdpZR9ieGbWdl32h+NvMMk25fdaDxbGa4T1RWcWQo1gGNzHD6KuY1cR5FLQexiEVEas7
	7ZtBcdIo/uCCk0BT0RYibU1zfhmc30Q4+PnK3VrRSAl9G2xKVrJ2QxGylTB4RQt5VN4IMDJ/tsm
	TNblkxGbo7tRzuF/xeYiDF3o99nF0adqHAPteHYLKFgVF1lPWIcgd9x2z/zDfGc54EWVVqBn2Ry
	2ICihtWOPwWEDL1GrmZnlgEN4WSHQNKubeHJP/sz1klcIxCnS1FdD04dj2Og0nbffGEgRrU+5AE
	sB7t/f3HAuq9Go5TLTFgamSqKTz/bcyP//u9t2l1GdLKccNB/7Pfao
X-Google-Smtp-Source: AGHT+IFN6BO2X6wxeB5Z3DkFGrzuZyz4TUKDb57huKKbsjsVDAwxVSn99GksYUGwPErkTVppl8SPxw==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-471179176b9mr179678425e9.28.1761144699894;
        Wed, 22 Oct 2025 07:51:39 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42d828asm48802225e9.17.2025.10.22.07.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:51:39 -0700 (PDT)
Message-ID: <bf23808a-4f49-47b6-ba13-1200d4b4c0dc@linaro.org>
Date: Wed, 22 Oct 2025 15:51:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
 <20251017-knp_video-v2-1-f568ce1a4be3@oss.qualcomm.com>
 <c9d8f76a-513f-4a09-bba4-cb8f0df1d2fe@kernel.org>
 <034bf6f4-0a49-4973-8536-28526b3409d1@oss.qualcomm.com>
 <d19b1279-3031-43b9-ac73-7e5f990802ed@kernel.org>
 <e1bfadd4-2d53-1953-beef-1350594c5010@oss.qualcomm.com>
 <miU0eB2Bl_rKVzJMoTPUR2-GweFHwQntP9c8-zLL57CgPPMD3ZEZm3_X61Q9Oao6tZMS4ypn2FsCfdAuauKuhA==@protonmail.internalid>
 <mtlwpa3m46qwrfjcpa7wapjjnllxopoip4mpnomw2ngteb6btf@2z4hrjr74bts>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <mtlwpa3m46qwrfjcpa7wapjjnllxopoip4mpnomw2ngteb6btf@2z4hrjr74bts>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2025 10:37, Dmitry Baryshkov wrote:
>> EL2 DTS for kaanapali is not yet posted to handle secure SIDs. While it is in
>> development, describing the secure stream-ids would ensure to cover all the
>> hardware generated IDs.
> EL2 is a slightly different topic, it most likely requires additional
> changes, etc. I'd suggest focusing on a normal usecase first and getting
> the EL2 sorted out separately.

Is the conversion to EL2 only for compute then, Kanaapali is a gunyah 
system - Linux running @ EL1 here ?

---
bod

