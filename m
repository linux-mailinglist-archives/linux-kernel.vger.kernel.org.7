Return-Path: <linux-kernel+bounces-792854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA0B3C9C4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAE81796D5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90106262FFF;
	Sat, 30 Aug 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afKd3yoc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61F2609C5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756545602; cv=none; b=j/hstb08RIn+SKMASfwkuUzjuJAMWtXy0Lc3AAWnp4bo+h0WKNI3d0BAmKsh7PTgE9kd5yONcceylVBY2XFc5mb6DZ6hH++EEvlhvrdlCGpbcDt98QgtS3o9LulHjgqZqtPJ10bBsfXe/am8EZbaEBTNw+NiFnSiotF+KTSGfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756545602; c=relaxed/simple;
	bh=eoKplZm+kkBtEjqGIAHB/J7TjTlViSlS7wYncCljPF8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SUlK3f6KRlTPiKK3YCz5wy+UmUAVK081VTFsH8HIzL3Q+xB0htOJGR1M3lakGqrO+VQk25geWd5TTaeokX+T6Ug+KqHveqhc+zlIKskFAhkHgtVYGElTsKvZmgjYnHzvzu+AOiY9lQHr5Qk/KAkkP1e58Qwcf03VjDXKREhWzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afKd3yoc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b86a6cdcaso41875e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756545599; x=1757150399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RvDvjixk5xDNrFQLv4PeECHMMHurHSG9SqBUI6Nr4E=;
        b=afKd3yoczRgI/i04d3VF+OZlyTmGrsWYfQREfG/gtAJZGWmGd1d2T1UpRY6+F5Ufpb
         mEKhjE3wEom3UWnDAidK5moesAPXBuQaOos6i3wdnGsm305xlXp7OsNXD55Fv7UYvGu5
         bPXBw4QVdxRmcyoC+lFfyU+lQGIcdnrsd9fJgfYEzvdOiyeIPlwjUil43LiHBworJ0NY
         UCjdwWwCQzDVx/26DBG/f2LKY7/xjlaT/cB7W44IYc9dSUCFg6sEJe8kvp8lUMlS5/XU
         edO3izGEdFKLGyCHGNqkMr1zMrgpZwFxr/lmE9CsN6fIF0ujW+Z82jHTZWNEZGUujJVN
         wPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756545599; x=1757150399;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RvDvjixk5xDNrFQLv4PeECHMMHurHSG9SqBUI6Nr4E=;
        b=ZJf/t8GS7MvblIq8aWRmbNo6sL4JOQrX59SVi6sGvyGHr3o2GGvnc+4kRxg4K+5I9X
         /JMI09syydPEt/1ixPxNnzKxF0RbfBn8GLzWs1qlX/F+hPE8tm0RGotPmTa9j0lAQ0jF
         8RdgSsYcXQIDCp2Z6auWFf/+lYDFHfERvNpKmk7AacU3Tyz71h8+bX568y16tiS+0z0B
         e+/o40gINbulVPmM+glSXsG9qOkupJCrkLtAuMwNpGhpOZTGXKtTZBZ6uj+r84q//eEg
         TugWHMRPACBDxOhLktAcnlzcILet1NJxmP50dzjD7wP3uIk3+4TH3y1lLQqHg9Xwkbyu
         LmYg==
X-Forwarded-Encrypted: i=1; AJvYcCW+nb+S0qGagEetd3mlUTmX76gPWWXWyqCZjwGjlMfZiH7OQWwiPhL6+yw6F4uOMGAqeUCHxv2QLQ18sOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJAzl8qN2raCv52GMaWvP2aXTYJJtvAMWWIivRFFI/rr+QXW1
	PIj7A9KI64MN4t/IPSjOiXSHoz8oIe0tC/C+KUxSB9VC36jrKiOaBZ2OTNu5NpxlyiY=
X-Gm-Gg: ASbGncu9H1DNbHh43cX4XDRB5nDNLzmh6da+IC5kSdmc5Fj+vXaNhEk6HDVzqcKPwZG
	zdQjKcehC5jedd99YKbwS6MADqclaKuDkLOgr+voh/T9QCQT84vM0WY8N535KAk8LLa1mx7RKG0
	usM9+2ni0jYoVMIWoebrlWJURHchxp9pucreiOBeks6sqFN16jeH4DClOtekdeCyN5bFchIpeSu
	LrR+nJ3YTZRjQV1qUw0X4hUpnkVHixw3IyG+6U7GMiPhSO1xebhIKaGNizq72sYZ8yYPxzKUUS+
	YEZ5vPU7jEuQxs4KmOijNv/KG1cpP9COVu7kafBqlPZXOSbB4yRd77l4vg2JDqQBNvvCK/M63Tw
	0xiOQXW597k1hzZUF13+r6WEOXIBDBH9jiHs6FOM=
X-Google-Smtp-Source: AGHT+IFR+X0EgGj5F+ZAPuNA44QJat2dgEsfyiD1C0mZqTk+bdaBYGDrDIoBDhP+GQBrz8+tvaUhmA==
X-Received: by 2002:a05:600c:5287:b0:456:2137:5662 with SMTP id 5b1f17b1804b1-45b81f120bamr19089785e9.7.1756545599375;
        Sat, 30 Aug 2025 02:19:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8525a94bsm21186815e9.15.2025.08.30.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:19:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, linux-fsd@tesla.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250822121423.228500-6-krzysztof.kozlowski@linaro.org>
References: <20250822121423.228500-5-krzysztof.kozlowski@linaro.org>
 <20250822121423.228500-6-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 2/4] arm64: dts: google: gs101: Add default
 GIC address cells
Message-Id: <175654559768.10738.10874618252730969524.b4-ty@linaro.org>
Date: Sat, 30 Aug 2025 11:19:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 22 Aug 2025 14:14:25 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to GIC interrupt node.  Value '0' is correct
> because GIC interrupt controller does not have children.
> 
> 

Applied, thanks!

[2/4] arm64: dts: google: gs101: Add default GIC address cells
      https://git.kernel.org/krzk/linux/c/a75d45adb261cbced86701d2512098044a6d310f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


