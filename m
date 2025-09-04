Return-Path: <linux-kernel+bounces-800909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54FB43D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4317A7BE57C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81443081AE;
	Thu,  4 Sep 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XllKDlSw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B94306D26
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993580; cv=none; b=B6tBz2eHBE8J08My4l6V9vIiQ44a9JTiR+TooXnCh1115TvnADYETnOa5q6MgR65ye/QgR+sxGw04oCOXsKb91FhfF6NtVIQ3l+/uADXUyrHHRAT/9gXhgwnG/QJcPi54s8IzjY72txgI03ag27wFJSJ715ofQsrSX/ukcpw864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993580; c=relaxed/simple;
	bh=exbALax/KRnxM/htU8cfFCENh4IpreCWgJhwJJBmuts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t7FBhVbTcOYGISJc8XPBCfElMhLBO/TjJ6HkB6XqNKCRQqqyWqX1Wq3iFr1fF1+8Q+Qt4ltNSoaczl6ToIic8HgDhu+u1y7q0fC/uUoiaMPYnAQtK5vjeyWPcafqtRiAfvXMx/N/ZylIynTdhudONJqZTrQcijRbdCKB9SwuT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XllKDlSw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ab87ffso14606766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756993576; x=1757598376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWzUXsK84owgqc3mGwjxow+K46mQbNDiKZu7L/mwO3w=;
        b=XllKDlSwVYM4Dm4Eyfg6UnPT9NGYHhowMX4kzz7IeWlSwsiCSzBy66y1nfjR2iROfs
         KZ74/ywLobRVkbXPbBJNd2jAx/XM+T/tZbRg1W6f8kwWw1IDBhMydMM6m9XXN/rEXXY7
         mRJ/r5x3pMlF0ipbplmE6ad7ym53WYpeSuXPH9HmH2FF03bZ5kOG6rJK46teDxxyrh69
         RD4FFDxSsYdRZsF0JWGceHkOT2qjObiJJXhykEJ7sAvn22Wa8qV+cnZvtWdpeENARRJF
         6DmU9ST+6yT1x/1S1qqCwKD6mhbALNoC1pVg5ONceldmh4tkWV50hFFIF5mY8LLBqoYu
         56aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993576; x=1757598376;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWzUXsK84owgqc3mGwjxow+K46mQbNDiKZu7L/mwO3w=;
        b=tauT/fBcjwQmDJvDF/H1MHw6MbvFRokM1HeaSmv5LwCGzcXlijDkDIRWXRKdUn0Lpk
         YNOrSZBR9ZqaYPQq6Q4b44HlTAtIJ9/FpS0X1vBTP6anw5DvCn+Lr0l2RuSgkkEu1HT+
         N21p79G6zDBfWl6rE2hIG3XPzlxu5yDCHjQ4Jl3ayt2ot2SXqfZ/cH6aqKNBtRSCIAFB
         D5+gXXu80jXsU+gMEAP182lxBsm9AXmCX3IHAMbvyecBMNfOrT9E5IC8s8HhbkWO/9nL
         FEs+BUyNP24Dt1v7+wueNJYyat69VmJRJ6qBvMAbyJZ06SIo71Uhj8UkxTnrUdvBxYup
         Dd7A==
X-Forwarded-Encrypted: i=1; AJvYcCXxxPV7ayrrZrDizVCdtDw93cUwgVP2w2GVPNDQkUikMrIwR5w78lQ4IhuXiHQ5poZjx6pKeAJeRocqneE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mJGPV63ItjIsW6aEBKzK3nncTizXuBXCY073elnWcTC9UI7S
	zvsJzxYu8QaJYG43bVvptmiyATAIj+uk5LFiRRwDrvqjFNbxLF5MJGtpT9e8VCSv988=
X-Gm-Gg: ASbGncvlbC8LUC8LqxU5mOAJ6QTW3fBgXyxui4TW1JF0iaj6XxSQ1tUlDo7PE+iEbUD
	OM+0tDP81dIKyq8ugJARvAZjvyHfszFqFJBlngcc638Lt4MwtgY0ijUymPAPykYaUlzQdmc5FZA
	Nlqii6Oi8d81oKCAUgvBUXfDZBYw+TTv0Ce0FeKlj9yBaUpEZrgaam8Kk32AwTg35xvm+601ISZ
	UEXU5VZpJR2FaEvuJVFjGWWIQqzg9kT6cyi6vdIctBtW/rrUB9AkJeTkj+or74tIE4PlegdfJlY
	D2xdut+6qqb9nbGhbjJ4fmMpbWUvg+BSM/j0qfBGUei8ixJvqNjidaD+oKihG2ZOtUHzcU4pN/g
	2UiyduLuxvm28i7wDF5rxtb/J0zf4m2669OkRg/OlMlGBa3MfkA==
X-Google-Smtp-Source: AGHT+IFRjqi0rL8OiC4NZXNOIG4FcZYbVhKsdzHVKskJZtLsw0JBOE11012YrpNCw1Y7RX8De6y4QA==
X-Received: by 2002:a17:906:4785:b0:af9:5a1c:fee5 with SMTP id a640c23a62f3a-aff0e28e4e5mr1209123966b.0.1756993575559;
        Thu, 04 Sep 2025 06:46:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413782b94sm1180634266b.35.2025.09.04.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:46:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, Ravi Patel <ravi.patel@samsung.com>
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com, 
 gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
 smn1196@coasia.com, shradha.t@samsung.com, inbaraj.e@samsung.com, 
 swathi.ks@samsung.com, hrishikesh.d@samsung.com, dj76.yang@samsung.com, 
 hypmean.kim@samsung.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@axis.com, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org
In-Reply-To: <20250901051926.59970-7-ravi.patel@samsung.com>
References: <20250901051926.59970-1-ravi.patel@samsung.com>
 <CGME20250901054303epcas5p3d8079b7806d995bfaf3004cbb4f95e41@epcas5p3.samsung.com>
 <20250901051926.59970-7-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v4 6/6] arm64: defconfig: Enable Axis ARTPEC
 SoC
Message-Id: <175699357327.171312.14592323274121562181.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:46:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 01 Sep 2025 10:49:26 +0530, Ravi Patel wrote:
> Enable the Axis ARTPEC-8 SoC in arm64 defconfig.
> 
> 

Applied, thanks!

[6/6] arm64: defconfig: Enable Axis ARTPEC SoC
      https://git.kernel.org/krzk/linux/c/eca86a61aedaa40310135c8799b28187afbc677e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


