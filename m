Return-Path: <linux-kernel+bounces-855766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608EDBE23D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DF13B0724
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD7530F538;
	Thu, 16 Oct 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7jC1FQs"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04130C616
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604939; cv=none; b=ajnoSZ2IcA8LnYq0BigHEHuboZCSIfOmDy/hHwHmuAHnG0yvp05YVkMnx6yobRVNHuxhMyKh/u9t6Hir4qJIorFWWOMpO561B2C10PNm16/cDtU4naunV+XXaXbpiUL+b/HoSNCZJq41zv5QGq7aMWpAPeA0/W79frMgaSlHpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604939; c=relaxed/simple;
	bh=VnQz3tD5fL1+HIoA2SNYDkA9Yt4wrKPvx5cxJ2QaVMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx2NtKlzaKgFIDq/CE7ZICHT5xe9tMcUBj/gIPoRliSvzlFw8cX8n5Vsr6uowQJnXBLIWP4p/PTW5C74znde6XoFVe2bHt9kDgAQ7T6lqMTVRbDO2qdfZbGEG8IsXvNysTRLNdBSxdzSy1bncDZuDC3cGOkPeDNBCKhtnMZhFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7jC1FQs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fc536b5dso221539f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760604936; x=1761209736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsrVJFlpunpde7Grn4QhbslhAz4SkbZMhPQmJfh5ifo=;
        b=J7jC1FQsia1Ozl10hqIc4820I8fK2dmnbTgS+4izjsjoPjwS5UO3BL9sjUqxqk95dp
         aZVcLB9coP7RrbCVwk54KNwcIfy2cN6qp2i7VYPPIl4rPWMy/whg1PPNxHkR3gNcvLfj
         5JHylF32mCMprnaAODuDTxI78uuHmmDI1g+3UI3Iyq2ObVGPRqkpMpqdf9s9Tsi4NfjK
         wyI4bMYfEufYtV7ors4pkCCG7niU/PigtohpPCG5Z7E+z5aUIds4PDgYS7EJkXPXT12k
         156b5v4PjEO+cbrVC9ONZFlO+YhNyn4MyfW1LK0Q+jK1M4T3VmxXEuoufcsZ4mGBgsV7
         WEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604936; x=1761209736;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsrVJFlpunpde7Grn4QhbslhAz4SkbZMhPQmJfh5ifo=;
        b=sJr2zRwDpb0NYy51JiVKuDGUxSXfVc4xN/S7XH2OejCBDU6Dl9KW9SxVs0kXw4q4Bg
         NiLESBY5M9U3ybzlvAEEyyYwZ26/kgPG9z7MY2XfLZG+PzyIOfcBXOFBVI6ax5kpizZG
         N8D/YrF339l4wpiIa8Ho2dejoCG9voWdEDvBA1JpXtWKqI8LF9Y6IIaODVia21z5NQjY
         j3wVbx+7I6qWdoO24B/mHNbjcIBdh9tSZtd10oOI5KWzm/myM9lo1uCiEphNZOELNmzK
         23r7dMF93AfhUKbnp7kay4MTgaSqT7O8uZ4Pd/ByVvYaX3OqPjTd+wtdgTzsyQWFqBcI
         sN8g==
X-Forwarded-Encrypted: i=1; AJvYcCXWDJldnapRi3X88qKzFLyOfIRnR7hSL49VNoqA0xKUnqLwJJkPbukUTIExHxFvprtdx4M5217h/I/vz/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZ7x0ZyrLbHhiRfdrl1hCBQtTdd3TP23cFtfFBOVK7KmB4DAn
	EVWdCYvwAq8EU5yMX6jItcRNkTD0f9UEGROCL+Z1u/k7o3zS+gLsK0mXrT2wAQAaF0o=
X-Gm-Gg: ASbGncu7cV0RR3+2G4lIaWW5oeOnVW0LIb8FFWU6NvFm8KJHDluhrHn89wVVIr9g20C
	9l93wmc6iOVz58Lq9JR1V9mAKbuPizpbANdexxhzMmsUeK6cM+dA7S1hVHpYiHOa8UCblmq5lRV
	HdXBTkfv+HhDqDnKrUnH+RJJG7wg/q0RcCB1OL2mnUuectfCVkfhCeU9773oYSY2g/cPIdaN/2V
	T2ecxYcLMirtPME9vrG0gM/U2Or8o1xIR8/PVbBM5RgDWl3gqGiu03CtM4CmdgejFSrl71QJCs8
	wjy/80mOL8Fs8iwg360MqUAsqqZkAKrHFAZIHAjmXSiM25Tvw2roqi8iMWoCRKriLrKKN2AYyZd
	8a8evSRhvbBF1GgDurV/EqWenu9z7HIENQnRmeuDQn1rizh08RN/s7985kAFv3PGuBCLVCeF2Ta
	GDdDwuBz1enbHcx42BcziQFZJik5LkocefRpv8uGCKX0W5T5guZZLEpC4Z
X-Google-Smtp-Source: AGHT+IHAmY3cKpb9sKauDzAPuMRSBw4scaCwVsJY6UgUsWKiz8av6DfzkDhrWM75GsjBU5op+ncafw==
X-Received: by 2002:a05:6000:2207:b0:426:d5ab:789 with SMTP id ffacd0b85a97d-426d5ab07a9mr13486191f8f.53.1760604935890;
        Thu, 16 Oct 2025 01:55:35 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8141sm32874494f8f.48.2025.10.16.01.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:55:35 -0700 (PDT)
Message-ID: <0fe25ca8-8dd4-42c7-a818-a803a256f42f@linaro.org>
Date: Thu, 16 Oct 2025 09:55:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] media: qcom: camss: Add Kaanapali compatible camss
 driver
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-3-f5745ba2dff9@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251014-add-support-for-camss-on-kaanapali-v2-3-f5745ba2dff9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 03:56, Hangxiang Ma wrote:
> +static const struct resources_icc icc_res_kaanapali[] = {
> +	/* Based on 4096 x 3072 30 FPS 2496 Mbps mode */
> +	{
> +		.name = "ahb",
> +		.icc_bw_tbl.avg = 925857,
> +		.icc_bw_tbl.peak = 925857,
> +	},

Looking at other implementations I realise we've been adding avg and 
peak without too much review however, wouldn't 925857 / 2 => 462928 be a 
better value for the average ?

---
bod

