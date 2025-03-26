Return-Path: <linux-kernel+bounces-577794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4409A726AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 23:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B3A17AEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 22:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69AB261399;
	Wed, 26 Mar 2025 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOgg/BhS"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E9263C6D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029499; cv=none; b=bx1GdMgo0rcZmdyt2yNFgMnm+3GxIsAMelA4grJxa8Ahc9lD0P85o2MtBu8qrHIOFoCCJ6v1ZKqzdS8TaSCy2G6i6Wr3g4Idz5ZRu9J3wmibxV0JC8xDuHz0I/S9jnY//am3Dog4ATVg1XLXZu9k0xbCwylD8wftpCOCZJWiB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029499; c=relaxed/simple;
	bh=9W8BT1rU43QQlM3nGYO2e/Y+imPrehWaKApa5DpYXV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTVF5D3vFYqEgFMDKUw+c8uWuQcJrQQhEAy/VV2Q+0NJc/VP78yrM8e6P0glhNBItJfXC9+hgNUjrt1/xx3RG4ucuScUTBg9aNb7A4A/Hskxtn1pecWFVrD6lz/SY7LgDGnuVj4yu0MB2/gmMLzIkJTOBao6JI0hzZ9kgpduzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOgg/BhS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso2201805e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743029495; x=1743634295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9W8BT1rU43QQlM3nGYO2e/Y+imPrehWaKApa5DpYXV4=;
        b=VOgg/BhSmJAiJgAm87D3F8MZlouJMCeHJWZRBiDPasL6DIK3woDpOMmf2iMJBvMg0r
         ChZbfnDRwlfLleNBC2xvlEaYPb0jjMc61NQ2l9qz/MZ8g9jsJbEUrcJkHFGNCZJhes8O
         TCqwJ7m/znyuvVqfM53oC+wVuTjGiUIrd5f7bE8JDkKch+k+Ygpd2VwikAb4W+QMgVwH
         GpCznW3GSPzCRXNowYvZ5a2gkV4c1GNUkxzVRN61ACZh7oNkViMDah0tZTUIQjvA8BU1
         I91e5bs++ybUIwF79Wfxbvxul7FP5bTKnkIJbADRQ7y/NsPgYS+T9qBO1kcYj8ILAu4Q
         m8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743029495; x=1743634295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9W8BT1rU43QQlM3nGYO2e/Y+imPrehWaKApa5DpYXV4=;
        b=A6bvnkBtD9hsQu2jB2ZrTkjsYZtK99MkgYFbD2HnGa5VvAPL2bg8wE+NB30sYqlqaM
         i92lJMDx7K5w3SgJItfAR7lqtlvOfDIVXu/XFWUAXNT9HiLLrIIkIecBznBSYl0KTB1l
         IRmjm78O6HBvxWLjd+9uBeVAjhPjx3sBGa5kjZUGXVStWAP4MUEMIovbZ3y3MC7i38+u
         4KQVxE5kCa9EwdrzkrJOX8vENht6HyalbBG43FhpFlt0WKyn019wwjtrWD65yY4jDw6J
         zpX/MUJKdbgQgygoGtTPM1xu3s5cb+GrE4IC2T8ZWSYpUyLFmzDQ+/Cuk59wJvHDx/I6
         EhcA==
X-Forwarded-Encrypted: i=1; AJvYcCWG3oSpwAtdOErpt2P8xY7mVVI5hy7bMnlh58g4r6+SP+bw23WTbr74+k+C1cojtCBUIntsoVt5ZYEBBJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuqOU3hMl1/8xYqFwj+Ca//o2Urxnuj9iQHCVbuVrt7QPmm7O3
	5fW5UshG0LR1oFtxxhm63q/L9d72gDu0VPSf90ySVxAdgK+k0bgRGguSNTu2Dww=
X-Gm-Gg: ASbGnctb2/PB5Jk/LCYqRtQSoAfZXDnd82vL2bQpzec8M02XGWxlKb+KnK+uEfIfE1s
	7CZ83lw/hamriyQzv1sSYgxlgOqfG+9SkEkhZKCzMzGS+km0zcGsQ6q3BXAtJSEobgAipx+yVF/
	4Ht9YIS+c+X0ZfBegCIUv6MT0HbLmAhFTq7I7tdC7Tajr2CDAi4dd6y3c1v+o3Gm2k15Tylfal3
	EM9hP6NoP5oQahGuVpnUM1TlXTv+pd1R2mCgFfXq4nZNEcKiZ0L/Ft5FL4yGo7mJnrERpivUW5B
	CEeobO2dH/odwY5NjAVHp071pkd8+CGToXiXJVq1f/ZF9kXvuCo6nxlF7wEdk6/0X9KQKEs5dG4
	p4U2hkLYqlmxudprmtkW9
X-Google-Smtp-Source: AGHT+IF3X3/hnoBsNfxpWnPlMXapCurjNlJImTiX0kVvl4eg95HRoqZ39nIoykw0ueeFjPTVdJiVag==
X-Received: by 2002:a05:600c:4712:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-43d84f5b6b9mr8578955e9.3.1743029495605;
        Wed, 26 Mar 2025 15:51:35 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f5708sm17268115e9.32.2025.03.26.15.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 15:51:35 -0700 (PDT)
Message-ID: <bd73de09-bf5f-43af-bdfa-70b3c9d82698@linaro.org>
Date: Wed, 26 Mar 2025 22:51:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] arm64: dts: qcom: sc7280: Add gpr node
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@oss.qualcomm.com, Mohammad Rafi Shaik <quic_mohs@quicinc.com>
References: <20250317054151.6095-1-quic_pkumpatl@quicinc.com>
 <99Kmw5-BXfX05ZwNUzOT9v3wiUXyJRCIyH_U5oOlBvz6-3i6cCbHAnDSD2431sH3adMtdNWeAwbc-05oPm405Q==@protonmail.internalid>
 <20250317054151.6095-2-quic_pkumpatl@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250317054151.6095-2-quic_pkumpatl@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2025 05:41, Prasad Kumpatla wrote:
> Add GPR node along with APM(Audio Process Manager) and PRM(Proxy
> resource Manager) audio services.

Nitpick.

You've defined APM and RPM but not GPR.

Your triumvirate of TLAs is missing 1/3 !

Please add.

---
bod

