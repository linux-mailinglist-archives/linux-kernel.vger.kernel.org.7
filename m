Return-Path: <linux-kernel+bounces-713212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15704AF14FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513841BC67CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968A26D4FC;
	Wed,  2 Jul 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elPdaOBf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5D26B77A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457982; cv=none; b=fZ4EVDXRpxN8UUidZT2eitWWL4kxhxLDYDP0EWRAkPmSzTQEjyeAxuhaEKcN4Ckh1FRQajYKw8fIbX/JDu+djCTeKvmH3gUMFj2/W3MPY/i0jenVHtRxWi1wmwBEdlK3m5eeH/xjFYq3C0nmwGfMNmbde1Y+3R2afI5zgc+a/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457982; c=relaxed/simple;
	bh=GVNj0GiDbzEfuPNlWlITePA20oGFkxhZ//VQ6Wqj9z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Okk399cli8jgdiu3V2xjrNA3TZ45h2ztQukdhmVmexTdh1DVFmu+H8YGrWfOECA10zNMwGW9azwqXYkOL6PtoTjHkB7Kg+sfmROZjq92cJse3cngKALaUAQhUQI96ZuzG9n9ix/tVRESp2ftYOWu4R5LK97oHKx50Ji7RtXOnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=elPdaOBf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso45517895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751457979; x=1752062779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I9wHRK6ycL/nw5skCVK6BibKiZIXkW4VmffJ6mPK24=;
        b=elPdaOBf1Y1osT08GlI0yQdY9yz4+VCtXoORGaEDDCY6UpcbTyPRcbfPBqjBONJVnx
         MmhuaPOftEXpMQBKVAKHoeXygZ5GBU9TwsTIduNp3yrNBhLzfMmkKlZKb1iWcLUu9KgI
         7+Blwbrbc5wPF3Uo98ROKzmJMaJX+7urND9kwFBD7IMGk2FLoCclyVkPxEhvDiQA7X6D
         UXe77TD3LlZqg/anNUEQ3Huokik7tBwmQQGqmKnUrJRy1A7ZKjvRvDaeUSMyMqAIQfKL
         jt6SEqYCwGM4FQuD0sJ+hYi1Hdc/z4TwR6l5UJcdc2bortlRVmFZbmCMY5VunfmHTQqv
         AZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751457979; x=1752062779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4I9wHRK6ycL/nw5skCVK6BibKiZIXkW4VmffJ6mPK24=;
        b=xSS7IlNl1pdLfK4mrvHk4NUTFWL3dsJo+zyxGl/PFneEHxoZb11s/kQTKAMLEttTS1
         9vgdfwuie4DYgoQGF7e/0Iq/yy6MZW98w0IgXJVe3nb0nqRxXTq9NnRCm8OFNM5s5LRz
         iOeX3flzy1Z2omKF9BkpqYn8G0pcDWIe/LbHPXos0DnpH3hU/RyEoMq1fMaDWabJUYCU
         VaGdBae7umkfpkpYDXufJ1ixBEvaGyLdU+feFqDHiwU6YDSh2IFSgUbr5uBRLk8cMceM
         g2P75rouQwyp1ApgB5MXvKzwHG3jOFRqT46GdfhTRZfHShe9a71vZHBL26UZXuinbjv5
         COlg==
X-Forwarded-Encrypted: i=1; AJvYcCVR34ee0NMBJpPvnuGwwJGGF4KXIoT+vwGD51B/I2vDK5Q9QcdraKaFa1CcC8UcfQEhQakQj4CudzgpnDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfiDysxI7fzR2FLHGVDOhIw7WzWnOMs9J06v9t+ORz45+qGVx
	Dd4T4prmtu5Whq7B0DFpZNSE+c4UDUqZxrjOTvgcLfa9ixMhvlWkiY8qTmZr22qLaMNxQzpWiYJ
	MSoxPV+8=
X-Gm-Gg: ASbGncsAZShea4nqRJcC8WuGnIziTS5AHApPs6s2tBR1Gl+MgYmvUgMUH51tPjdwJXG
	ZUwJJUpe3hJYSw7aLDESiMG13jzJZWGH6mD9875uTstCXD665muyj5XqbjQieOiywjhju/F9yVO
	u1vFJvxW/sdiE4vDqvfuJTDbJYx/4kKCtN3bXiI4cS5JP7ZOq9FEwzibpJrmmrgGXgBV1y0YREf
	OytU6M/lHiugWP7POKWdKHmxc58PItZMbPFyqPVYOzwx0cX69qlnJYlPMCM8u3/KZWgV2m1tMOB
	RK68M0KCScMws3UHLuRFohrbtfGc0vin4HLHNH73zrpa69XuhZW/QMODGzRjmtKbkqtFDlYZI99
	c2hygMDVJ3J+eIFO13kuHvGRQDckx
X-Google-Smtp-Source: AGHT+IFiGQ8eoDbIef8H5WgcGBsaUK7l+LIPHU5+0N6yFyzZ/rasF17jb2K+ACo904sf9rWYtcqByA==
X-Received: by 2002:a05:600c:c08d:b0:453:8e3d:26ef with SMTP id 5b1f17b1804b1-454a3c22568mr18064675e9.6.1751457979384;
        Wed, 02 Jul 2025 05:06:19 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233bd14sm230508525e9.2.2025.07.02.05.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 05:06:18 -0700 (PDT)
Message-ID: <f5ebf0d6-2f0b-45cc-b99a-b786e5df9edc@linaro.org>
Date: Wed, 2 Jul 2025 13:06:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Introduce "non-pixel" sub node within iris video
 node
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com>
 <5f90547d-945a-4e26-b36c-75f2d8a1af97@kernel.org>
 <eab8d79f-7188-9537-9176-3e4d22f0978a@quicinc.com>
 <5ad418d9-8199-43c9-a477-1e3b939c054c@kernel.org>
 <7b6db4fa-2f73-376d-4eb3-64c1c7e6cda3@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <7b6db4fa-2f73-376d-4eb3-64c1c7e6cda3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2025 13:01, Vikash Garodia wrote:
>> Anyway, in other messages I explained what is missing. You are changing
>> existing hardware and you clearly must explain how existing hardware is
>> affected, how can we reproduce it, how users are affected.
> Exactly all of these i have explained in the commit message. The limitation with
> existing hardware binding usage and how my new approach mitigates that limition.
> 
> Coming to usecase, i made a generic comment saying usecases which needs higher
> IOVA, i can add the explicit detail about usecase like 8k or higher
> concurrencies like 32 or higher concurrent sessions.

Why not make this change for a new SoC, instead of an existing ?

That way you don't have to make the argument for retrospective ABI changes.

---
bod

