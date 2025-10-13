Return-Path: <linux-kernel+bounces-849820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 415DABD0FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFD114E5AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4821C8631;
	Mon, 13 Oct 2025 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMcxfFgR"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49619DF8D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760315159; cv=none; b=XM/Aaw6uJqnKAgfOsCjtSh1ETlSSTDVWLGXN2Oc53/F//UUqcnrRKzL+I4se+wNd4yTJG46n0NQkkWfLRFKpjonhiVQ+aY2bE3jLq06noNl2/4oELjqE7bsELWgfEZDzhY0iE++VWYLQJrD3059WVkajnZfHe/tnJnUnNp287A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760315159; c=relaxed/simple;
	bh=uMZY/eb58MXXTq9fdevinx3WkPol2Jn5dURLFB+Namw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sPeW9vW8VmREpExeBmESX6hZDLeXi/doutaT8DjvqD2XkbvIPp0rb2f8oCzDT9Xa2DACc9tWOhxNIr4UQtDxBLY3dflkZo3MAqUBImN6cCfFB6gIRbzT8Q8ULSMVurHpgJ6YtFzN9UCvIBP0bFzJ92SwS3pneZ3PlZq2LV14Rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMcxfFgR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b63117fb83dso120257a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760315157; x=1760919957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79KifPwGGK4mB0WoW1yjJ4Alo2Qr3NmP9KvDMNbO2zU=;
        b=SMcxfFgR4pV3qvN4vJehWICzVqR6GlQVUjohZvqjdr3Fx5YXhnjcG5cUUPqO5Lkg0l
         QlgnlIJDVdkLsrY1GzQhIo8xRj2+Bz3/lFBifSB6y/ULWqAlCnuPH75ZP69YXpGCmmp3
         6aWSMcg11i65QbR3icP/yql7oO51t3GYzpp4MviGrSf/Bw+F4RI9gNlhEu1+OlcD+bOO
         RYU5AkDqVhOAlQtUVrA0gWs7dFUbpfBFPC28CKqoUy4YB5V1b80kramGaoxd2hN5O9nI
         ENX30s1PSZNd3SilwgU0GuZVJ8VQHtZqAuot+e2mvZtwNx94jbzTOFgQ9Ysb8NvdeMSG
         Durw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760315157; x=1760919957;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79KifPwGGK4mB0WoW1yjJ4Alo2Qr3NmP9KvDMNbO2zU=;
        b=E2xApM4EgN/zNVXnvxxhcDjBdhbPerWzoQAS4OkjyB4Lyc3y7QVFawu/wbK3w5sGLF
         I3goSb8/m66J8YanQw4U4K10Ia3oXV3ifhZQTjN9IPGzL/DRec6yNANXaT4moHkrPoI+
         iXp/ewt09kxE8QewYrUlrrcpYomPlAMIRc6Lc40K1bFlL+zU33iVI6XAXk7D0oVUyuqK
         WxPxz8Ev5KUrLbyKttEhaCa20ULLUD+IepEan6pZL5SPEXLRV0r3+hnLlmgcrqMgGT+C
         dgz9su8AGuy85Tq23y3Pm08crYakndAWtXltxqj7+8xIb7fj42tFOyK578UN51WB9zl+
         BKkg==
X-Forwarded-Encrypted: i=1; AJvYcCXO92KfR9rFSq0z6QIFTsaraaP9kAGmG8ey5dhJ7ezSep8RlJNqhokFGEwx8tAJr30DVDv4AtEKo3rUGfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4Ct5i2BP9H8jtpyQ8TtcxIz6NnXyJiVaxxZ3tsU0Aakd1FfZ
	GnUwV7tkv6fuIKiuVCzjT8JkNt3Q7Kl9lwRUKbeFQlvwiucBV/wbAwLN5L5fLScATxo=
X-Gm-Gg: ASbGncsKL08SxWlKMVgpVO+buvWtAS9xi9EN9PEi/PL4BiwWMCsFBP3TvV3k1NupJ3e
	IwYGEuMC8cM9nl4jMY/UJYZilhwcCf714pIJODjc6rcZ4wmyXMDQIzZ4PsVEjFB966GhYdyDozy
	CfEr4GZbOZBLnXzOlXOP9UUkmCa/5Eo7W1JUZDEb4cni9qJP/BZBNx5pAHGg4VBj7TXEfCGuTwj
	DZOYB5u7H42vsToVUbi46CxqwRKIFTpkLs8US7znj0yENWKP8YMNeSnG5/74ZE9vIwrOJX60MeC
	7iX7V+g3a42R34p4JaFwqpJWmCRSSYWsZ5T2xA0gosVQT0mm57t1sKKBJMdNnnwYM4s6KDehiWB
	YJlP61kouGMZ9fFiMXv07kcALGd692ZTSQaWmj74dvT5AWeOzKsszdRz8z0RmwwLL4Isydd8qSb
	x6+mAhVg==
X-Google-Smtp-Source: AGHT+IG1iyXL4pN/qvD9XLmsJIck33wkHAeiVhxj8ffXxtDeckyVCZeHinEl84ADeFl2GumlvaBQKA==
X-Received: by 2002:a05:6a00:2295:b0:781:220c:d2c8 with SMTP id d2e1a72fcca58-79387146ba5mr12345789b3a.3.1760315156841;
        Sun, 12 Oct 2025 17:25:56 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096740sm9624862b3a.38.2025.10.12.17.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:25:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250928-exynos7870-dt-fixes-v1-5-a40e77a73f16@disroot.org>
References: <20250928-exynos7870-dt-fixes-v1-0-a40e77a73f16@disroot.org>
 <20250928-exynos7870-dt-fixes-v1-5-a40e77a73f16@disroot.org>
Subject: Re: (subset) [PATCH 5/7] arm64: dts: exynos7870-a2corelte: add
 bus-width to mmc0 node
Message-Id: <176031515137.11660.15560543530858079871.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 02:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 28 Sep 2025 22:13:56 +0530, Kaustabh Chakraborty wrote:
> Add the bus-width property in &mmc0 node. The Exynos DWMMC driver
> assumes bus width to be 8 if not present in devicetree, so at least with
> respect to the Linux kernel, this doesn't introduce any functional
> changes. But other drivers referring to it may not. Either way, without
> the bus-width property the hardware description remains incomplete.
> 
> 
> [...]

Applied, thanks!

[5/7] arm64: dts: exynos7870-a2corelte: add bus-width to mmc0 node
      https://git.kernel.org/krzk/linux/c/5b33bce0bd31ca3ebc5e3a75b3053141540ec644

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


