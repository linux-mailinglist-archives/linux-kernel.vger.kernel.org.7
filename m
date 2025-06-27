Return-Path: <linux-kernel+bounces-705675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D35AEAC23
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2AA7B3082
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2645C14;
	Fri, 27 Jun 2025 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCWxXp0E"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D22BB17
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986348; cv=none; b=Ju+QlQW2iw3EKG6N+y0aW+S8x8D5q84adY4BgGmaChI+JFLe35plPVFm+Y54MBTvKr6Gktgc0gFQ1MxL+puk/GezhbIWo/kXmux4nxv7+Uiae9/Hv8MoMMgdlv4beN3Doi7q8E446vhgrQb9cf/L3JjMvFWmopt+FcbOoQ9audE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986348; c=relaxed/simple;
	bh=5pMT3+eEro9ox0pu/3gJoCitkuT60qFDYmpBxmejqZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPTCD46jXMd3FkgOsw5t3rctsvXvUS/VamOhn8nkWcI4hOZhucLmRpccRBu6DQTmM5vgDS46LsHXHinnQ4vvVLZ3pphSfSFX9wMYHNGpzz/8TudfYwdrGyCVZQoUxz+bnrqdsHcZWWCFmOzJVLRipbvFOxkIf0D/fGS2Q0ap4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCWxXp0E; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso1720034f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 18:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750986345; x=1751591145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCEH4/nYFQC/5D2TWQLQCIAUawTphbfim/GsSeVhbPY=;
        b=mCWxXp0Edg++D7XPrK91D4EXpGANa4cc3wqKnU7lbaLyHmbh1u1oi4QQwgHQzME2Ob
         GFTe43xf4cAnAqB9SLIpTNf+xBglj3OTc3yl2Y00yz5fKgqnMDqFYJEO/9ySK9GmG7Ja
         Ni5Uvw105ixK9RVs3WtrDAUxmBROT8MlrdSasyAZdmKaeMfhy168vGnCVvthIfSckGeV
         7p7bcP8HpSa/PVezEMrggjSpdfn+wNZQ2zSHfIv3DcxnjfktFjXEb4sqaJ2RtaZTmLtd
         xfd4xnQqddM/Q2ByLssfG5VewSOzvsp/SniHYe8zXDXN+S67cXpSa+yEGrT2jbCVSqDL
         Y6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750986345; x=1751591145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCEH4/nYFQC/5D2TWQLQCIAUawTphbfim/GsSeVhbPY=;
        b=upWlFW1XqyXpXwoMCzXewa4xzpCFf+09mm4bQar9wkl1JWkRsJqaAnJq+Gk5XRug5Z
         5VVhPP2nzi2ndthY/G9lIlrVH0IwUQjcQyIGCU9x3ksVG9X6Gja70dDDczzUng7ER0a+
         A98ONZITa6BTng6cF2YGIe4DG+X6bkJipFqUVfiW9s0P5wch4BtJxru9AjSfcOfthf67
         fLmCmdXO7AJifXJBlG4wHVEDa50Qp+JZ4wXTBsxnRK7Xr1dSVjJkNDILZyX3lj7qyH22
         Y/mtQiaJX90T6ECD2ruJb+gYWwPduJLMjMkrznZaPAZ7B7MWdUOVbkDcW9/ALFuIVbsd
         Zlpg==
X-Forwarded-Encrypted: i=1; AJvYcCVpdkxwxYY7gjHADn4/QmCJemXKG0hbFcZDeNivk6WmoKKdrQ5emdq1mChtdSpPSQQHTv2lchwTht1Bfyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbEcuR6IVjwSnLEI1dWZU0gAiscQX4GydY6knlK1F8Y6HbyFa
	7X4ZU4o6g6C0h2UfRQ2hiK7O7dqIVkMu1UlcaXOkhgG8vebzuKpCtt8jvS1svWHS9K/0mm688Yr
	4cNFN0P+oKg==
X-Gm-Gg: ASbGncuUCjh2hIynH5Ct5a77LXonGi0v3SY1Q1ME4BGEofhYXcKMbPAX09W63SMqfnf
	21CRePm40lWG99p/lJu1qLBL4ddgFX0ZcUhcZeWvTTnprAtgF1oqSFar2tZOZqF//ivvOywU2Mw
	Ls5FjWUwKxtGSJMcmaj1x3hqsvubUg1ULO72iKIRa1tfuG4FYZegaIOWpBYqQmBEDk29r9HRxjS
	UUGzLK9ssukw6z0MQC/8TX3d1d7qHls+C7zk/Gt033FakLBiKa+19Iev1zpjgrAdmoiZ7TB8N0r
	vYEoOvZuWQD/6zT1vG/nm02yAaw0QNbHxDfHZq1NwIMljNVQk8bigxEOA104srT3c2SsSYghNrl
	n9F+NIBqWAHNbj07M3+mlCFSLDqLWvL5Fg5YdtQ==
X-Google-Smtp-Source: AGHT+IFey/mVIRKk3UWUu/tEfrImgRAEJgM0T9pJubxRsrTOR9on5HnEM0Ys6a04nuCT6wlQIXOdGQ==
X-Received: by 2002:a05:6000:21c3:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3a8f435e29cmr997757f8f.1.1750986345232;
        Thu, 26 Jun 2025 18:05:45 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380d0f15esm59111445e9.1.2025.06.26.18.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 18:05:44 -0700 (PDT)
Message-ID: <9153b2cb-b123-4799-939f-cc8b7e3f1330@linaro.org>
Date: Fri, 27 Jun 2025 02:05:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Remove extraneous -supply postfix on
 supply names
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 vladimir.zapolskiy@linaro.org
References: <20250626012433.261328-1-bryan.odonoghue@linaro.org>
 <0975cd75-2363-44b9-8ae8-b2430799ab78@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <0975cd75-2363-44b9-8ae8-b2430799ab78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2025 01:43, Konrad Dybcio wrote:
> On 6/26/25 3:24 AM, Bryan O'Donoghue wrote:
>> The -supply postfix is wrong but wasn't noticed on the CRD devices or
>> indeed the Dell devices, however on Lenovo devices the error comes up.
> 
> Please give the commit message another shot, perhaps with "PM" in the
> commit date above ;)


On 27/06/2025 01:43, Konrad Dybcio wrote:

lol

> 
> For the code:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

thx for RB

I'll translate my commit log to English after my suspend/resume cycle.

---
bod

