Return-Path: <linux-kernel+bounces-798085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C564CB41950
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A7D56523C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295DB2EC569;
	Wed,  3 Sep 2025 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3uC/N1h"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731D2F067D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889565; cv=none; b=K7iC0G+BuxOZp0nqv1QOx7v81YJvFd5dDYYzG960/8PjnKOcW4pGo0yQmggbYc8vVKcfGQ/jS5ZHWPtXTYgpeq7A9jedZUQ1bKGST2drk3XoUMeInbj3fucQN3IP/yGcGU8JBU5ctA0oqXH2cStb5JKaZ/zOTml+P/vPDkK0mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889565; c=relaxed/simple;
	bh=xgkUY21Rbxol8p2BuC1ppQ62HUjYK3ElgQPpX3aSKvM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PU4GkV8vINcvB4IPrfBY9liPRz9sJDx58O1uvB8S60CQbvJxgDBIZtCN62C49WuaKnGBg16jpeNTVSDQvIdRbI+L+GiRVt1cJadqAY4wcOu7S/UiDKSYRGwIqXv69oSXYFwA8OKvnWNyK9SgyObWlSsxCTA1ZgwJEendSFR9cuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3uC/N1h; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b046d1cd1fdso5473466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756889561; x=1757494361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXuAsC4/EYitpuT7j2ogEhP8VRvM8f6E0D+ICyRlOQs=;
        b=E3uC/N1h8fYevu8eZo9KF4dE1PfoHmRoazEJAAGAL6IshPEiQC3pT5W/b6h0+gJGlJ
         nwTkWJAW0J5hf1GPE0ELag+KGmDBCstmInbve2p/+lIgjr5URKLKu6qS7gIq22wTo6h1
         HDGxeu3KZI7aMG4NwNFdhQO57XOn5iWOy0pz1BRHie8dNnKPyymsW9ESUiRMEp1VLpNH
         1kAhOxwsId6Xk/9Pd898cZWP6syIYb5oETBCHP+rQFg1K/eLjFoMcc4obY+ZilsREr5j
         9Ah9DaR55nz/PQnvvrDOSyJsvyQklHNk3lS4ncGrBh3YkHaqO51far7MxPZHzcr8tgGT
         ZaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889561; x=1757494361;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXuAsC4/EYitpuT7j2ogEhP8VRvM8f6E0D+ICyRlOQs=;
        b=ghpczP+RV96Dt2pVcr9jfj13+ypsr6R248EhO+wgQeyfeyGvyWxJyOyKl/Bd6V7dbR
         GGBd2sxCvmI+XiOEolQip0NuKHMmH0Xq4dnGNB0umVfFlUSXJ7zFxnlmP1plIqAuA+iz
         Qwdh4JgMxH9f4v3a1foSmc7VKdoIew4zokqa9zKZno6HHJY40cq5hdkhVvfwqXzE8o2l
         N7Q27vVzLXOOuFOB6c4BCLb/Pa8Sv4x0Izsmsd9jo3Aiw8Fb/MMGBRtY/qixHOoRigrx
         gO7yaJGglrvg0PdB6Bm41iqGFqvoU1WsGYl982dX2FOvBU8JP+LB0LgDXRy75RQY9S10
         vFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnycrxCfy6h7DeSPbVSFUsfpFnMc/qHZyf89fr6USX+U3C8wUIGL3r2THeH5XR2molZGOfUY6dNLswybE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTw8xmJzqKJ2Fy9D8V+Dlu+Qaiw4Wq2R70Ug27NDbdn4YcIgdh
	uUHLpVwc0M+9Zqb5SihP/gkrr2v4X902b0Ryz0F877NmKcE6bLyxi+SQmJGpuvcRnFl6W95yBUW
	2nvpH
X-Gm-Gg: ASbGncv6FVVApMAphA1EGeTGbA9Mo+eo+KENU+q2t6zBJp/T1efkVm8xfv3bzaBM9jx
	lkomXqU3vmO6kw5DHOYAEDfLjs7j8PHeRzPja2hreeAKEIBPqGMNXF/zovesRrrTXU2VouBh0Wo
	nNhFR5EJXKnf3I4pUUTLRrBJCAPH94fnbgOYT2Uv5OET0/pU8OAsc5/OCDLMM0XDz3UdVMtNa+7
	iMdBVMeWhQtM8WGus2TeR+l/jJNkoTZgBV6I9DWF6Ti8aUf9zYnTKg8f33xtpd2j9eqlOttTZ2C
	kWKVdr1Lj446003z+natdC8lcWRYB7yrJGRzBTm/fL6++jAwSjt6Dmat79GUboWdTcpv1D5gjJW
	iSwxm9Wz025kFo067GJkXvK+z6ntZKxU4dB4Zj28=
X-Google-Smtp-Source: AGHT+IF79RuXHW2pwxOc2+riBp+Wf+b0VTzVijhXxVtt7yjNxZVsCII4hmqvTw9cMwLtHMrwtHfYWQ==
X-Received: by 2002:a17:907:1c25:b0:b04:53be:7652 with SMTP id a640c23a62f3a-b0453be78a7mr304851666b.8.1756889561565;
        Wed, 03 Sep 2025 01:52:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046eb335f5sm53713366b.28.2025.09.03.01.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:52:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250819131641.86520-2-krzysztof.kozlowski@linaro.org>
References: <20250819131641.86520-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos8895: Minor whitespace cleanup
Message-Id: <175688956033.32106.10753846034561344868.b4-ty@linaro.org>
Date: Wed, 03 Sep 2025 10:52:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 19 Aug 2025 15:16:42 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos8895: Minor whitespace cleanup
      https://git.kernel.org/krzk/linux/c/045bf0f825cf8dd53468e70fa494b06aa17e2d33

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


