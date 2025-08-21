Return-Path: <linux-kernel+bounces-780109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECAEB2FDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CBF175347
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359E2EDD65;
	Thu, 21 Aug 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxvFguJX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885742836B5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788337; cv=none; b=QHkWO+h7rAU72ovboHdHwiimR0LQTP/XyyxdOJ8T+AtmUorxx6lXM1ThICBBTA7h5SI1E1S0Qf+UJnqVfbwPH/zBD4V7lsCazx5sQfUXLHYvepuPTvacpCoAplCpDZ5sakVBB2zyGN0MyYlGstp4YtkBJ+Qt/tdDAQ6z3FW7eBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788337; c=relaxed/simple;
	bh=oNyIxpLFpjHMgtwMUYNrW8wmho4Z19XhG8oKfK6fB+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvf5Glx1NDwF7mR69wOfKX+9XrpMANyYe2K/q6pZV0WhGNb9bJrPlw0pVHobpBhUW4j441wZw+Y17rM1EHUxE3Dce9c/uHdcCHPgqVDTbE0QqLm362oNeHLZOmt5DqWT5Y2s93aS3ooTIubsH9XPcv6g6+gVmvbnybSEaxGzUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FxvFguJX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb731ca55so14997266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755788334; x=1756393134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wuUNI9ruukJidhqOJpPv3a267ufdzL9c5odmRqbEbpo=;
        b=FxvFguJXA0FLE2MH/EZUvxopglEzUATgrPhYA0cLhKW8drkv0bcVSjBrwFX+ntkvrE
         VeBm0ob9apMbqDFRaoC1Bf42rr46LzdiOqT8Hyp3zgIj2k0SltZpzeLmQqteXhrneGQj
         XW9b9LYjjwybdR2uaSKOI4l0rDz4ZeIxiqLBedvZcr1HDSTgc+xL1wzSCOnjQD8rV0ac
         C5Z58MlLqq1Nxnh6c1iiyWLuCbaFKMujxStLo5jSgF1p/5rd6xZ5v1JOAo7b1IvLt/UH
         mEWuJenJpsvl4YOWopiRmwAyGpuK+4IbYdG31MSJ9aFEU4aeStCfJz4Nrr5/PKguIupt
         BpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788334; x=1756393134;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuUNI9ruukJidhqOJpPv3a267ufdzL9c5odmRqbEbpo=;
        b=rERHEMWMSKhjieidhCFZ1B0r97j/oN3y8HyKnKOZC9HHbg4AaqTr1gQ6ieaNjopG2V
         epWlQnGVq5cmqXS0bHrrXx5E7ZLwhbESMNyv7/SJxfEiYj9pbsET9Z8lHZPJxi8xx0cg
         EM+ORTtvvqrmmRxkxcHqq59Ud9nmf3g9LzT3sxN9ihpJ+L5R8kJnJ34KWPn+c1iuNVFF
         DmM6OxUkQCbvzoDV8lQjJgZrxWNHo5aO2JOxtgHZ+K6tNsQ9gs8o2bnWw0xJXIk9DgF7
         iXEuOsilCUO4LsriMS6rGGpuYBtgCdGvg1P3/qMHwYu//cydAAtWXrqsgxDHeFF0VjQD
         8BvA==
X-Forwarded-Encrypted: i=1; AJvYcCUeDajB7dwuFc3x8tpdo+J0ScZ/V/JVc7jqWdeWLeiNoSXWffP5goD7R8b0RCTpKQycQWmXmldjCN4XCLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKziGtQcA7E7Fux+3ulmddpAgzIsXA6tprmrJzUBv66+89+pvc
	QgzXTUkGVqkGXDuKVXuc0y9yn3oY7HnsBnIh+0mFc/WW/kt7LBIU5tv24zXFQSQoEbg=
X-Gm-Gg: ASbGnctk0301+wh/o0fxRKei1lh3gE29AlOco24Ro4SF1PE8W8s6taK1DFrX74Kk23Z
	wODw/FKTPRnYcSorMn7Es5uaQPsRzSWoJO6MofITeYjIjowIGxSdPKilnyMWNzhk2MWdN+cee5q
	hu7FC/QAR/FAeTkAHBScFPhYpZ7aqr/+CdYjJTKLBU54LjgnPyOOiwTC80tJEFA9lRktSlT3TaR
	8aM3bz1Kcm+SqiY+D0JCaqQSSv/js6OxSLxc31/j47o8vciTJiUQ9kqhV2Ld0QsKE8bYW26BoUo
	7dXGTWHWh7c79/KO6yngp76EGnBl+OhNTFOygXJ4xgr6RXq7+3E3higL4yoUjlC5eTqIwfE02Pa
	s8fxKk1gwgUkoJTpFvfC6JtjbYEo65rrfIrtzfVMrOc0=
X-Google-Smtp-Source: AGHT+IGMu5V/dS2rr9eFsChybKmNEOvND3MWFdDQ8LLFAI1h24WzRb1G3ItMsC6nmiN9OzSp2lkRdQ==
X-Received: by 2002:a17:907:7ea0:b0:ae3:c5b3:37fa with SMTP id a640c23a62f3a-afe07abd1f5mr144747266b.1.1755788333799;
        Thu, 21 Aug 2025 07:58:53 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bc37bsm402829566b.2.2025.08.21.07.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:58:53 -0700 (PDT)
Message-ID: <462abd9d-bd4c-485f-8663-70dd20cb75b1@linaro.org>
Date: Thu, 21 Aug 2025 16:58:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] dt-bindings: media: i2c: Add ov2735 sensor
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 sakari.ailus@linux.intel.com
Cc: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Ricardo Ribalda <ribalda@chromium.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 Arnd Bergmann <arnd@arndb.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jingjing Xiong <jingjing.xiong@intel.com>,
 Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
 Dongcheng Yan <dongcheng.yan@intel.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Matthias Fend <matthias.fend@emfend.at>, Hao Yao <hao.yao@intel.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250821143126.319470-1-hardevsinh.palaniya@siliconsignals.io>
 <20250821143126.319470-2-hardevsinh.palaniya@siliconsignals.io>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250821143126.319470-2-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2025 16:31, Hardevsinh Palaniya wrote:
...

> +OMNIVISION OV2735 SENSOR DRIVER
> +M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> +M:	Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media.git


Do you have commit rights here? If no, then drop.

Best regards,
Krzysztof

