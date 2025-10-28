Return-Path: <linux-kernel+bounces-873386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C940DC13D16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D62D15007C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9AD30274F;
	Tue, 28 Oct 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4wEuk65"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEAB301477
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643567; cv=none; b=HHYSuYGVWqRwkImtPX9WjiLOVufA2ZVJQJLIQ0o1WHjufvMWmb7yk8edcnkF0OBLvXINZe8PxjmcBHWNCNeTT6+46/HHHjZkBTIrYnd5vjaAB3BvqifCEB3KNC7ELGoD1u7BoxSZs+hrNOslXmwngeGTSZIhgJkXMAiYKq5kp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643567; c=relaxed/simple;
	bh=G3fa4DEKYJsrbjpYbG8l1S+0+U7oaIpFhApn3v9mVok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGQZ/4ZEYTQtyJxBlal43k6aR40NzqmfaRDJpFXIKjcX78NFltLtFQ/B8kRMCecWsWMthA0uxrUfHtNbOwOIugiMeRQCf0q1XAaILUnAuM18TC/57iFRwVsvza3VSfb/2YjuWPEkVvoOJLaFUt4L/+0kQ5FjVYzHYoaMwGm63bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4wEuk65; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471191ac79dso59960445e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761643564; x=1762248364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WIhNUyRI0kZl2LUkLnytvQqzIt3iG3+keT/4POrd5A=;
        b=i4wEuk65Uva9JyllG5C3QAYlNH4CN9Ckyf3TnlnzuwawRg/lQIuwBvSboDw89RtB8j
         DrRkpo+XKGbDGzW342mx807zqrdPXxbPl3z150+96RbmE+VMnaxftxuNVg69bmCcKDHi
         b5MQV3sUliY/GOUPsn7/sXQtEs9CwwJEAzWHlzrUFPZW8vF14WGE2emLog1az3rmohVU
         4QC8GTHe2vqw2Oa31KkhnoqLCdx68gXonYBuJFuJG5Nwihqfn8dXj3p4ZH2kMSJ70jFD
         gOpOLdDhOWqGtvUfdawcU1sHQsTLLZaq9w1c7FzAqVU3CLuQgHkt7pn+VjWNOyXIcSTq
         MCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643564; x=1762248364;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WIhNUyRI0kZl2LUkLnytvQqzIt3iG3+keT/4POrd5A=;
        b=l/VeBZjc5CxqufdG2sI006Ldm8PpDdYZ7U/ZdQVc2Y+RQwWqgSkempltJggjF3Jhfq
         XSw+d/XlpG9JuTij1J1rWoaN6XABMC0Gy/Go7fNq3+nx7U+Vg6hp6O3jXnQm24BbUFb5
         +oUyOUnBzNcK1uOTDfezrqhau/gjU+x1FVPRzZ5DP+bV1jn9xWIp4P9RJeP8vw2guF4z
         jR+7NJ00DlGVsCmglLi47SA0Yz/kUJGU8xcs0o+9LYLQWsdukuNLsgtS6W70iX3qKYd+
         g0ScJ4Aizd1U8TEr5cN4+y/qBkvwNlJtY15zqrVghrkZxyMYIo2+bBhZ/6ym52QaE8dq
         x+tg==
X-Forwarded-Encrypted: i=1; AJvYcCUgTnpFmUtSTNXJWMdfSXd/rR0QJO1cfSwAkMKG82sNwkYkz1pIlDLDJCxPVnLMdiy03xvfYD8TEZXZonc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwocSHmVb83+7Wp4/xM9DUWZ0WkdEcnWpJ1b8ryugUAGK/KImHR
	l2vrqw14+tKHx5nRwb2KL/rcp4GUtbDwJ+qjdkRjUn17ShxKZaBKSdkrx/BnFVmGKnY=
X-Gm-Gg: ASbGncuB6tvSfIbGjT8InYIJRFOiby6I6a6X/9rdgQOFhanwJdA5xzDzlOKovnMkQL6
	QCwH5MSD74YbyXNmi5KyiUGAPoM838VxOvczQVtFIIf8uJZKCGkZmMv+D+4B5mySzuuQEf1g7C4
	F+5RTTCQncndHtmGNChEtyhcAkGOOvAJSxpVjT+gElbjXcUQ4P4PzVTgeSAYqE39eN91YE6Qa5Z
	j3wQuNVC8Ckolv7sgklofwmEO06oRiCebO9DZMAiniCnMcPJJ9I05pj4eK8f4O69xLz43jwNCUE
	jTIrgD9rq/NKR1ZUXUdkJDr+DGkLvHTYPg5CExEUDxPQCc98uxUB9QmsOs7VlzUcDcAKwAcsz+S
	8A3kD1zhKw8iZw5PdG/FSWjHUO9XGy3ef4POr0H6nGPohVHk0a6ttQpwvX6e0So0H8rXS//qvUh
	7/oYtdAhnMHPBsDJZU7YamlUUh2C3AMTahkj/DHgJnPCTNxEbP9hs2Gw==
X-Google-Smtp-Source: AGHT+IG7SGjSk8s/DTqkizgYBNEXizsx92+JaKgr3Y3fQprN5gLYg9kJPcLa3kFS/x+7fFwVaMqF7g==
X-Received: by 2002:a05:600c:470b:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-47717df9dc0mr25845305e9.3.1761643564349;
        Tue, 28 Oct 2025 02:26:04 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035dc2sm188343505e9.5.2025.10.28.02.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:26:03 -0700 (PDT)
Message-ID: <7e7e35f3-82b6-4757-bbcd-38e0e867b184@linaro.org>
Date: Tue, 28 Oct 2025 09:26:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] media: qcom: camss: Add SM6350 support
To: Luca Weiss <luca.weiss@fairphone.com>, Bryan O'Donoghue <bod@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024-sm6350-camss-v1-0-63d626638add@fairphone.com>
 <20251024-sm6350-camss-v1-2-63d626638add@fairphone.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251024-sm6350-camss-v1-2-63d626638add@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2025 13:24, Luca Weiss wrote:
> +		.regulators = { "vdda-0.9", "vdda-1.25" },

I'd like a little bit more consistency with the regulator names.

0p9 1p2 instead of 0.9 and 1.25

---
bod

