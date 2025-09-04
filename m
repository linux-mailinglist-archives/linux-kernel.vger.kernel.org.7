Return-Path: <linux-kernel+bounces-800905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A0B43D8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429504E5A37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE283054EF;
	Thu,  4 Sep 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWM/I8aQ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A4302779
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993574; cv=none; b=I4CttqL3iAF9qMicgag2vfTsBG08pb6mRxeXEMI77nr429UToyG4wJzT4phz83S1RnnwekFHiyo7QLsxcFYPSX3JnPo5y5UrSZb9/zd/h/LvejyBRV6lRsGFt2Nz/pTEhjlBfGX43lfLXmKigyXLX5V5W7398nweeFE7jaQIgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993574; c=relaxed/simple;
	bh=tzrZdWUmau9Ko5Je+ScAN4BMnTd/A6L4sx0uQaFUKWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gYQXURi/fj9xYsbmxoDHM5O6V74QaFWKuko6n6B815I+FOwLaADKfUaizoZc7GsBZEroQ91GMN349NdRe2i1l2ADspmOF468yVn1nfvPm854+L0THqIe+D+FE4BLnJzcau0ELWExYauaXExj+CeL6Av97oVLun8wOsmKgIUvsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OWM/I8aQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b00f6705945so10589666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756993571; x=1757598371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vateX41qLmBe78jZzOt63uJFfCVkgcgyVW4UPJkHk7I=;
        b=OWM/I8aQzkazJJD8u4OG0BnAM4ka1XpiSM4N7jpxoap8Lo7EWM88L6dC8qMlyTN2/8
         Q5JvlidA1hit+HuCP1Wbim9vgQbOGZOJK2Eun69mon1PFjg+fueoelzBWYQwfoZFsl2c
         aP2ceuB8TnflzD1uK+OMxgXx2JFcO/B1s+1ZGT2tQWnzVexYXi6rcfphd+UQMHK5/rRB
         us5UNNl5rvI3AUQGYmh8PqA1umnqYS/pbIMxlgiRriNlM1GjpMoFcbmH6jRnz6neddFt
         ViBAW8zcrWOs+pqMwvrj5IjSTQWK7IP0XA0SPA63vvGn9V9ZJt6JtNtApfEkJ698KnJb
         e9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993571; x=1757598371;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vateX41qLmBe78jZzOt63uJFfCVkgcgyVW4UPJkHk7I=;
        b=HnOxelx+MhF1eLVQtaTHniRvY4qhitnPG5hrfTXaVZU+XGS+PUS7lHbjMV8wSiFYlj
         MQww0FCMgs0ZFzvV7XWok2YicxPw1dwYjP7eexxaM4mLiPj0+wqu16y4/aHVaP4VAUT7
         Txqwbqdd3c4kHe9xoeKz5xsxMXYmKw9m6FwAhG+pHtN/ibsTN1SdfeEdN+M6zlkL4rr7
         Xrz4ovzt/2kyc5tqWKr1wEECUMWkVZmB8o6edONUlI+OwcnsxgGKpVyzEnlDkGKcKlRX
         1GLKdAAl4Ju1gHfigtrjFVUZ8pbFLJlSxsfdg+6bG8cRVgn6dbKv+IUpEzTna+VprGuB
         ka0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzHu8cg2X1ylX/c/e9vKDeMtAavVHHvCI+5beCbICn8t9howpCXguDs/MND3Rgrpzxk9lVE3ANYMba8n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXnmkp5plLvDdbHqHlqvdP1sOhsDK6mJpi/saGLh2WqK0Crf4
	Sp2z185F98DSdirW4hxV297i9O0GvXyMkyeCeEYItATNXsqIdulzxxfic0GDb6i/bwc=
X-Gm-Gg: ASbGncvrdU168sghEK1v6pxcE2a2WJ2NSvKmTwC9CeLLNxetwDHVIVFFzMlYZEVYuV4
	lAPsgX8seEMtpbFPfRoBfIZFS10b6ecinLhwZR/d3PyzxHm/az/WfmlWAwjRew2tooBBARjEOBr
	d9RG4k3VICj5R/bHBVJHJk2GOcc9dDCw8cTmJn00tKFWxgaeVE4a3yv0Vr2dYywdworu2a/Sxl9
	eF9CWzPgy0BPifAdckJBxrzcZA4xxSk6czPNmHawIUdmJvMFl0rfc1NXSJZwl3nWAmLOpM5PhLK
	ewQXyVCUgZAqM+M2cFN3+aRWVBv9aQv1yMQ3mfs2IbhXXiTs24kAoNrvUlLVJcDNDeFj0LqLG2u
	owqs8ejaXie4vCeLsvaxcbZiy9iQeq3soHmB5wIJpIvqdCmRZcw==
X-Google-Smtp-Source: AGHT+IFvWV4hrMxiuD4s72RuFmU5dC8uJSFz1ccYAGwp5WTz05lim7XPN1obF/dY5Raugo8Ut7n0LA==
X-Received: by 2002:a17:906:4fc5:b0:ad8:a2b3:66fb with SMTP id a640c23a62f3a-aff0ee1dcffmr1098615466b.3.1756993570841;
        Thu, 04 Sep 2025 06:46:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413782b94sm1180634266b.35.2025.09.04.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:46:10 -0700 (PDT)
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
In-Reply-To: <20250901051926.59970-5-ravi.patel@samsung.com>
References: <20250901051926.59970-1-ravi.patel@samsung.com>
 <CGME20250901054254epcas5p24db87bd64fc57a25b17c51e608f15e7b@epcas5p2.samsung.com>
 <20250901051926.59970-5-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v4 4/6] arm64: dts: exynos: axis: Add initial
 ARTPEC-8 SoC support
Message-Id: <175699356858.171312.4717453350737707503.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 01 Sep 2025 10:49:24 +0530, Ravi Patel wrote:
> Add initial device tree support for Axis ARTPEC-8 SoC.
> 
> This SoC contains 4 Cortex-A53 CPUs and several other peripheral IPs.
> 
> 

Applied, thanks!

[4/6] arm64: dts: exynos: axis: Add initial ARTPEC-8 SoC support
      https://git.kernel.org/krzk/linux/c/2b48947f7b03e0fea32ea2c6841a0d8cd67e737b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


