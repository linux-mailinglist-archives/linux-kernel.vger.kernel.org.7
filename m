Return-Path: <linux-kernel+bounces-765099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14186B22B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6213B136F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C92F531B;
	Tue, 12 Aug 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zl8YIv+N"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3472F49FF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011143; cv=none; b=hqB2bLVs6TEFWNgTniAcI0i+uBDEf0qg/zDF0R8ORqib96aQoSAuqg1R1707/M+UEPzRCPLRIIEE8r/2LYFnwJtEz7i5qh8mRZzaV02uH5caBd9ebL5v28AzwLis/TZJm8ck6+3m0snzazAADMWQt9UTO7HbJ+CXmqCXaKqP/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011143; c=relaxed/simple;
	bh=13LJJo6dqvQkGASUem9OaXV1fYDIMnu0t4nIeHZzuOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8fGSqK9ekGYxU4wo57KnWba65N6tyGNxB9AHgNXfCEexETUTprwLYtOqgMSp4KTPtpaNIR7+/j2uZxbEbIH6CZhJyO4OSsuV9Djx/Pqgcn7Rdl2PmeYWoc/HlGhfo99N+qLcsArIfScHLl8Aa+Z9/anfPw8BkAHy+y7tcdt4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zl8YIv+N; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so28118625e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755011140; x=1755615940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFiyXHmzPTJSM/FpIqJQMHXEodXhM8NURp+djBOJcws=;
        b=Zl8YIv+NHaeknxTmX9VUlwVpvAn5dSqHUWM8OFlo/p0kE/AHP4jeEIkRAg62ZMW8hk
         HUTFYHU2v1m+1z2CSX+6p+9lixrqccZUN1fj3vr0lml6gcaka6RNVvE7yWIXgfmWFgJH
         pDmwocEuHB0NtVj9tuQw6ZTHKuq6euv2SR3yoI1DTUImknQ6WYTf0ob6r1J+eJpKccC9
         gPpSeNYmNHF0JI2M3o5DRSqn8STh818a8DqW89rWT57rwnOewHTbI5V3xtXqik6UxYnr
         j0hqrTIcv70LSYTRe5jQKT5FtTgIoVOamlzO1y6hVpX8766HXsgNKrRJLVuTB1ycYaXr
         KWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755011140; x=1755615940;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFiyXHmzPTJSM/FpIqJQMHXEodXhM8NURp+djBOJcws=;
        b=O7D/WmdaU73z3xxHMWUZ4hcKqIk5EryTq8aipYN0Sol1Tfyv8vCyGFIA2N0+rXNnpX
         0843YJAnP1aKepFylHq6fXH6cdnfg0CfC9ZcV+rCJDE6+sZmmYecyDpdWLuHTrBiNdsF
         TYvCUx01PACTvn77rSfZLopvAOCJrPml0imMdsW6eLIOiRY0f6OpZB1d3i5GdW7hCqUs
         7ISDNHzgmqzGqcyL1DA2YJEMolDU5tk5Y4UKx1kJQMI5o6EWqsdusS4y2Q4Tn27VtRP8
         +NtnFDkGddYCWvbu3tHGcrGa+o2lyfCyXHVGKyjfTdldDS5u8+PDdVLW3WHLQJ29NAkI
         D8PA==
X-Forwarded-Encrypted: i=1; AJvYcCU5br+XXI+T0AI2uiqy/j+hymePAS57ey3cIvPnk/B+xOkgKyB7y7jJBzaoHXZc3wjhKxHWv5H5nIZHXLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJGGhVsI2uZG4TEM6kypSZyq8qUXfK5Ra9Xpp9HZR6TQKgLzq
	tQHt/pkL/y62OmfSo7jz3F684FoCoDvbsU3pTUT4vgB80sQP/UgoUosrOEYqaIGrUY4=
X-Gm-Gg: ASbGncsRSRz1i9OvaiE7VhOq7hp7w15Gx44hSyR5mpn7ixmKvsaEj6ul3OMe/S34uuB
	yL8+62kj6QrkJp0lFQZo6MyU4LKQkfzHiMFu0LHUdX2ZdXONh5QQpzn5lPgInT2BAXPGznXtIjP
	IBgGOQB8MDP6gs/2eVe3X0ZmmRYUCxK+ZRMpCEJ0UQUHqt2sxLyTacl1xXEB4KLpxvtiEtNVcbm
	QDbBnGES2Xdg7AqIlri+b6TwYTRGKfB1bsFp3bNlGGoJOOhr4Rxs4IlqY9gcuRFKrbW19ev/gTu
	eEUUuasu/pXzsIAg0pgehNlosPKiYKdbivMpmmiKXXukuvdD6PnTVa81dBMNoIu+BKl5oDeHJ9m
	hHSezEd32m44UXTxII07ZLmfNSP3rvY+/+2a3Yxi6GshzV3WsoURADvqmjjJVBQs=
X-Google-Smtp-Source: AGHT+IFaF18WlpXLiOPapLF9skeq6bos29ChTJTlyHVAm8O0Lnm+tnZQv8MZbqesSAf81giG9PV3vg==
X-Received: by 2002:a05:600c:474c:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-45a15b555demr1276015e9.26.1755011139689;
        Tue, 12 Aug 2025 08:05:39 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5873c43sm327424985e9.22.2025.08.12.08.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:05:39 -0700 (PDT)
Message-ID: <16e4883a-a056-46c3-a7c7-a87ff5da89a1@linaro.org>
Date: Tue, 12 Aug 2025 16:05:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <d7949778-73c4-4575-8db3-a3724f75eb38@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <d7949778-73c4-4575-8db3-a3724f75eb38@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2025 14:39, neil.armstrong@linaro.org wrote:
>> +    .clk_freq = {
>> +        zero,
> 
> It seems clang doesn't like this at all:
> drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c:486:3: error: 
> initializer element is not a compile-time constant
>                  zero,
>                  ^~~~
> 1 error generated.

Weirdly I compile with clang..

thx though

---
bod

