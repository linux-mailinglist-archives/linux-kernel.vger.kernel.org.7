Return-Path: <linux-kernel+bounces-849838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB085BD10D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE203BE174
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74212234963;
	Mon, 13 Oct 2025 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0Kpn4GO"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F652F88
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317341; cv=none; b=FH5+CbNFpU74TRYXYslyO2sYd4preCdklFBy+wWC2nxuqBN5CrrykpqpWfWbEqHrE9FZ91wV/BSrsUBtxlQdMlMqn2yOk2K2IjEhUN+oE8a5Kx2ecN6GPyooCMcogqJgDWEAzk3MKonLVAQfVmyhRSjkh0JDWVhES/jTcqphLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317341; c=relaxed/simple;
	bh=7LWUTdGD3fSIXfrlVlEN66Lo77zZq6a7cdAXAuHQS/0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mQZVEFmFhL6e5stfC9JyOlh/XmKK6J0rg1/muAZbdQIz5cWeWt76ebO+sLgvcfG871fhMZkHYtV6lUsdfPAaQOcuq2BFB/fQ457V6G5z3wQaErsAxtnQZmB8h+m0MqK0wLLQDUuGsUlc7L5QkIqxtYMzadpO2RWgQ/8DbKUKTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0Kpn4GO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b631a684a9fso260009a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317340; x=1760922140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qskwUA9a0ZXAj9gIGOlNM1CbPhOSvyaPzijPhKtGdE=;
        b=j0Kpn4GO5OedenAcdktMf6soHOXNBz35WIeGZ2UeU9XeUZF+ilyuy1iCJPMl+fVyVE
         BdpXEUSMWjWqZLUsGvEFU8J1OZ/6WX+1P7ZBsZaRs1D8M1LFvNCM4f9pOPA3R7ek9/QN
         CYSxlvbv9mz+zviDEnQKKHwigOn3WN09nzdVXfIGYiaFapBL/rCf31Q3KhogeOSFU3TM
         ELUvaziNxma3zrMqSkyLrUdB7msUAk5C3Ffmj5kFz4GZCGO+g4NA6vPNyEuvDcutk0eX
         dggbhXEpPO1Rftndbk9AsbZDBp+/abO3aou7XymbmfwsrKSlHjep+zFbgEu1mSzYE1Rl
         3wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317340; x=1760922140;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qskwUA9a0ZXAj9gIGOlNM1CbPhOSvyaPzijPhKtGdE=;
        b=HqYjhotQXirH8JvllZ2OXufXfZGb4gxqeeTA8FRvLyPSz5pnavPNnAEJBhHh84BNS7
         K6r7dSnpwVVVNU16/dQ0/4Mjnbsbf8NNoCO2obRUqzTSk9BFwF1s74f7Jv6Kc7OY4NFp
         G5bxryzyMRtbVqUb2eLGUCCxgst+Xk9fYebO1/+0qB8/6gkTtrV9N1sMx6il858DDvWp
         KNfmepPPPF5Q3gZ9rC5bD8Zc+5NWNbXDNH+59A9w7jIcLtDkZ3Fng9Yyc4f3M5KB7lCS
         FoGcf8qgDOX6Is3SfNH7ymR+3g/4o6xlvFjcESCVA1O3o3JF9sJUDNiT1IBysiiikajL
         gGUw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Zz8uSDoqShbR7pbYY3f5Pr56D5HMp69NtYvp/wlH9tKZmjwIV0yc7m9H2VBLBgP9areM8mO1lkZ4VQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7lCIzPY7LRu7xSPgzNg/T7XGZ8JDDWdiZrJlsbcnrhiw32j0
	tpWXuSAF8fHSmxIU9WY1ApyNpFnwIaKWi3Qq/GQM3FB7RBvN2X+DCJxUaQ03OMp58HU=
X-Gm-Gg: ASbGncvwyeyZMHNEdLthFSJx+cphIyJxeH7Gn4xetdXXwR50VnUV9Z9PEaYLm9LXgI7
	6HyPcoSFEC3LAqPEMwBCT9iL5nfj4D3Bk+lq4aJDEBFNVFp3yBtgJeKRlJWCYIayi/BjncFV75V
	hU16Gc1rwyFE3tOHmbcaxTywPYA9b7uFl++X2CUtAW1oI8p51ChstIlWc5aEFCjhsl23RwgCLS8
	4MAe37RUgntEmxUEZ6QQ7kWmngHwqnZFFrjU95xjQnUZQut67BtEILDd15qBs+dnbKthrbT91fM
	R228ZnZRutm6UDp0TWpwkr76NsGxKTXzfm0wGmKX/ugmCdLTNPL2VB16BYWzHhSc2skAoqYYk5V
	eXRrzlmTq3cVnK1tmKfr9BvMOcSd2jqZlACSzhu5OFVG+fTTbkphOUkaNqIFYvr8XejB2qsE=
X-Google-Smtp-Source: AGHT+IFCIddCK26dec4n+ytGNYUXqJLLuulmf2agh5auUmkxLNW5WchdvaXA+14Zkd33rJWFKcoCRg==
X-Received: by 2002:a05:6a20:6a1d:b0:2b6:3182:be18 with SMTP id adf61e73a8af0-32da7e23aa5mr14077202637.0.1760317339798;
        Sun, 12 Oct 2025 18:02:19 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:02:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250905173717.34240-2-krzysztof.kozlowski@linaro.org>
References: <20250905173717.34240-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soc: samsung: exynos-pmu: Annotate online/offline
 functions with __must_hold
Message-Id: <176031733717.32330.16031922861063779323.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:02:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 05 Sep 2025 19:37:18 +0200, Krzysztof Kozlowski wrote:
> Annotate functions writing to PMU registers to online and offline CPUs
> as __must_hold() the necessary spinlock for code correctness.  These are
> static functions so possibility of mistakes is low here, but
> __must_hold() serves as self-documenting code.
> 
> 

Applied, thanks!

[1/1] soc: samsung: exynos-pmu: Annotate online/offline functions with __must_hold
      https://git.kernel.org/krzk/linux/c/326312707492c136ba44cf96730e70aabc959da9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


