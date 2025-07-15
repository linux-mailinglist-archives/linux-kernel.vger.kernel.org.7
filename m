Return-Path: <linux-kernel+bounces-731264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21198B051F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1045C1AA6524
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5A26D4F9;
	Tue, 15 Jul 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1sm9XCl"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684626CE1D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561618; cv=none; b=dUqdRearZ0daf6usRWZwX0k+BbqJmwWNY7ovR8z5EUKKiARR5Yw3WjztoQqbwuGUTXTtKFekEXPlC8Xs8B7+FqSWozBCLaYLm9pDGdZ5sREbRGfemvq0W+3VEz0mba2XOFYxEJOwXtRx7CBwL3/HbtoeNdyePNoghaW0m5FaoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561618; c=relaxed/simple;
	bh=XvhUwch1kWk+h7hXn8TTsbFUD7dvqo/TCnjlMoY8wd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7Pv+8XSUlRVcW1GPJQIzSCocb3JSsjIGd1CUA9n1NyJc0HNg+y//s0W5/S2MH4Ub2zAkTL2XP3ISX5F7rQagDP9mb7pva7ZPO9nx1MYd/iBqivUqcs8pahusA/+7H6ROakcAHp7T3Ke2ZlzmfdUAk0pqKhExZdqyE3eB/Mcts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T1sm9XCl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5562a92734dso770294e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752561612; x=1753166412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIQ0MAA7ilgsnxpjHpbsqjmKUfNKURLm5JM6QSNd4g8=;
        b=T1sm9XClcdjyQFwItMITvys5cQI8JEk6Umd1TG/Zj5ieX//afOIqm370efy1SEzhv5
         wc0dmvJFqHf6AeJGJLER2KGNlRMV7uqWlVDk/PyDLyuUMXg+2MzaIzmaaUg2IGKIjtYG
         q/3cGSnz41ghCUKsoIKJ0f7rbMRXd5EvbQoclrCtrA5GnXhaUuHh+434QtIjavZ9v6uU
         hbHKD+tCWgp5bt6m+9NY88SH+dWSKEUcXyU1HS3XR4Y+2ik7LDOu/hsmxZ9U0utzQ1G7
         5f9CCqWdScFflJjJmoZ8WWWiOafZrBTyPoa39tF8MygHaCBDKtNKve1vcgKreEi+vwcV
         7tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752561612; x=1753166412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIQ0MAA7ilgsnxpjHpbsqjmKUfNKURLm5JM6QSNd4g8=;
        b=M6JDxGINmk1ScMUI5LaB9bJpoF1J2x1zA89ju2f2yREz2XHctR7RDJeEVVycQJ0voN
         rvymPC2t+q2zweiltmLxm3RXSo8VxNNTAcJTKQPilba2+ZDNMkNMapyQk0TGlKThmq9T
         a5AVPtZ2YML8HJY4cco/zURn9nGbjHs/nwLIoT25XaLNlNePD8VVeEnw3+jNXy7V4ye4
         7KtmDla0cp26qs8RSWBYnMuz6/yJ8eqG/5jYYpNGoBAxxD6vCXZ15okYEZ3/Tg1z6a+H
         LBXvaDPZjrL84/SXd4eagzpQOBOsCKz65Yri+ikWdNfwns4j0hogm/1zE8oxzflRegT1
         OnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWki/L3NoJoqkCaTwSLqa0rrf73zLC0iMfnsTIgkvY4VIChYn3+uIf39jw3lkEZVJNSlPO4K3IQeRXXEYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWo1lp+u8FBOSPfdQkrGy7morTWVaKkczCombxSutI4mWbQiiv
	e99DdScJ4B2xwv0SQluG8RGxXo6wArj4IsiY6aEPEJETeud0GL+0g/UuMJpBIkdZ2/Q=
X-Gm-Gg: ASbGncvttfw9zXLPFIx0nzWrvBZUMAxaosJ4KgnIGCVTgA8yZUKAhnes5pa7I9dad62
	YCLOxf08RGa22W7kMkemwke6gvf6EGMzT2rolDB/I7fy3WjkIw7W+4bG97ynyH83xoar2LxDrcV
	CHGpw51RSH6Oe4wuGMJWrnQJWqKObmw3Taf5zIZnsDuVOMCcwYprn4FuwsxhJ0QPA1TgG8o0gW/
	MicUfuuWMRhq7SpeRUCtC50/iOSXefTml23OxHnhNt87u+AaQ0IrSH8rRvULS/NCeWH6lPK/s9P
	t8fbc9Yjn0LTfo59tx1tTynvzf3Qy8zgmq+Bjw7pbi544GMRZ7mLODA7YfQNFSwdTL2rfvRXCVW
	hRyCXJO3qluARqeJQPtxwacMaHnq6jquvc5GS+NodgLQo/LXOrnRFsbM/gb/wzas/6q2gjMd07q
	uP
X-Google-Smtp-Source: AGHT+IGaFJXLkox1nF/8pLLN1OAvLc85Z5RHAm50nAQslP1unGzqc1kserBe9j82STD5G66WKnTIuA==
X-Received: by 2002:a05:651c:1a0b:b0:32a:7d76:2660 with SMTP id 38308e7fff4ca-330872d2995mr581861fa.2.1752561612382;
        Mon, 14 Jul 2025 23:40:12 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8bf2e1sm16881731fa.55.2025.07.14.23.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 23:40:12 -0700 (PDT)
Message-ID: <dd3c2fea-2c85-4a4e-b048-68f95f4a7d5d@linaro.org>
Date: Tue, 15 Jul 2025 09:40:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom: Add MIPI CSI2 C-PHY/DPHY
 Combo schema
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-1-74acbb5b162b@linaro.org>
 <8ed5eeee-78a2-4b26-989f-03676a9e5da7@linaro.org>
 <01080f5f-f3e6-4989-ac84-766c030dda35@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <01080f5f-f3e6-4989-ac84-766c030dda35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 17:42, Bryan O'Donoghue wrote:
> On 14/07/2025 15:13, Vladimir Zapolskiy wrote:
>>
>> There is no ports at all, which makes the device tree node unusable,
>> since you can not provide a way to connect any sensors to the phy.
> 
> data-ports should go from sensor to the consumer of the data camss/csid
> not to the PHY.

No, this is an invalid description of links between hardware IPs, and
this mistake shall not be copied to CSIPHY/CAMSS.

> Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> 
> https://lore.kernel.org/linux-media/20240220-rk3568-vicap-v9-12-ace1e5cc4a82@collabora.com/
> 

-- 
Best wishes,
Vladimir

