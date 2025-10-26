Return-Path: <linux-kernel+bounces-870521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022AC0B08D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C065618977F8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C829C20C001;
	Sun, 26 Oct 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="nfuU5nc0"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED261DB127
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761504407; cv=none; b=Hdm4pBXhf6g5Ob7sO22t09q64azJlEiMUQsln96euBGDS//G6sAarltTFWaeBfOjUItikbS64SvD5oiYJtNWAORcH6RD9RtXXRMDAYsFLNfNlR6CxpVpnyZA23FPLbpnsa/of+xe2+bN22ShWwW6gXIElCe1vd0ZBeBEBLqOCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761504407; c=relaxed/simple;
	bh=9JElRUYcelJHNX0v60zr/J8lWtgoWXeCAYKccVAcB3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/s154ArfsP/7P1YOZ8JD/4CdYeTsNAj4gBEQoJ7cPS8yqgiZeJsji8o46IMTPwvYUOnyivMbV4NNenChz4sZohP5rVmKSVqdEdORquLt1Hk62QEgPSbjnzIXPRuuC8QGHun51PWpo9DMnlhOkRuoJ+ql2DRvOcuM5cvVBXZtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=nfuU5nc0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290a3a4c7ecso43061755ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761504405; x=1762109205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr+uTiTscqC5xNsxJVLhouOq96vCtcj/UADaRDhqzhs=;
        b=nfuU5nc0POpV4P3j/DGLhWJQXNqr0k1HE9XSR9yoHSEwcBdUbWJrDZYIJNC/Zigl6F
         vHDtRKR7oa6eXm8LNFt350e4RLDLiyPUquzPNz6Aw1x35N6To1Q8ve58ATIPNEeiBo11
         ur7nEaXMjxSGzSoYn4diJtavEwxzJPcZVVmszzlpx690+BugfkfxFVkZgxNNGpnNZlZP
         Mm5mcMN+BY8C0xEeM+VI47tSDq5MCuJIZWbXA01kn/aNtazHm6o4pnG9RfYsx/ARUmMh
         ysw1c0ZBFcNMlGfNTBSpKL19nfZYqEPPjLcU+HpQ0hrU3LPAQzmZmrFNLRF1ld4A2q4w
         VUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761504405; x=1762109205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr+uTiTscqC5xNsxJVLhouOq96vCtcj/UADaRDhqzhs=;
        b=bNaO9kI4jn18UdDVAEPsGa0zhEfovKWyk46uFlTzmcYoWzCFH6DAB2Uo7f6shbJTAm
         9FcrFDvagCyCYn2uqE0bMfYHWt0dZii074keXmw2Q9yH2gPq8VXzGoE3Vujkk48yk/eF
         m4VrSacaSF75PtbH/TgMd1GguDVZdD2GH6Ytva9MqhHsRBJXC0WxFtAqGjx5R7CiTCkx
         NSPZoFF6SuU334sqsK6U01T2z13TDqxLTEILYPBliqrJjxN7A1lmOudVUUKv4QV4Ir0F
         tT5vxj6LUcFV2wFugPizHMfJsMjyWJ0ee3987iwYQC5asrCWoSHqUfMct0EGC4tKnGKa
         eE6g==
X-Forwarded-Encrypted: i=1; AJvYcCVcv7bT7eFvA6rSZ8fR+qPm0dTJDAaXbLgZnYiY0GLpca36bErUTASozLBsvQdiB/cjpbPfNrk5U3N560g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGaM5q386Rte2kHropfyDKPcP53CjzBzE89sytO1PenvTgVuOV
	z8YCRAePzjdcs2QLhRTe5gA3yPHnyBPVqkQ0MWKw9kWXnuc/mqp74LlnzUZxI61lrYo=
X-Gm-Gg: ASbGncuxGkbsc8QlRlGYONWyN9YReHLNyjq219KCKwGHvqRjMp6hXEM7n3m+URl55fI
	xU2YgEg2PZV7l/mbAMCMyd9ZltaNvUKliOoktAd72H7TSCw34QJ6kLswUKJr1vfwo8UbEZYA1HJ
	uD9k1uK70vv+Vhj3UekGHuFqevo0ZwL6iaEn+WZ9Np8GLt55sFskK0SOW93C/bZRyj4J9yc6YH8
	zxTLpTmLhCCYpQd0GAzGOVflzVUu2EM4Va8291MkfY548dA4CBIJTpEhfubcIatjCBi03ADjLs7
	yqrX4SzL20EiyRlWxXAz+SJJH0OSsHwbymZiO+nCzDHnaq9RLUf4Q0fOBDzUpEORkrF8GYe7p/P
	06P45GY0zORFGYNtNcueo1piPWiY3g3jyVmUG5SA/Gq5cEbP9YfDIG1jX3i/KhBblPcBiT7IRgn
	mqHBG/zFESsnJWs5Fa
X-Google-Smtp-Source: AGHT+IHyb18kbZzmWwrapG89GEeH9zIO5kUERUgBm/20I/UDyDk2AQLJZ+iiUs1VcHb79+gHNkmW7A==
X-Received: by 2002:a17:902:db05:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-290c9c8a5e6mr441023785ad.2.1761504404962;
        Sun, 26 Oct 2025 11:46:44 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:a43b:396a:591:2ee9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e2851sm2432460a91.6.2025.10.26.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 11:46:44 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	igor@reznichenko.net,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641 power monitor
Date: Sun, 26 Oct 2025 11:46:41 -0700
Message-ID: <20251026184641.631641-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <408c1698-a8ad-4e16-8def-352c2c265f5a@kernel.org>
References: <408c1698-a8ad-4e16-8def-352c2c265f5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Subject: I asked to drop "binding" and not add "support for". "Support
> for" makes little sense in terms of binding. How binding can support
> anything? This is the "ST TSC1641 power monitor" not support.

Krzysztof,

Thanks for feedback, will fix this and will create following patch versions
in new threads.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  shunt-resistor-micro-ohms:
>> +    description: Shunt resistor value in micro-ohms. Since device has internal
>> +      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
>> +      655.35 mOhm.
>> +    minimum: 100
>> +    default: 1000
>> +    maximum: 655350
>> +
>> +  st,alert-polarity-active-high:
>
>Isn't this just interrupt? You need proper interrupts property and then
>its flag define the type of interrupt.

This controls a bit written into device register.
I omitted interrupt property after looking at existing power monitor bindings,
especially hwmon/ti,ina2xx.yaml. INA226 has very similar bit controlling alert 
pin polarity and binding doesn't define alert pin as interrupt. Overall, I didn't
find many power monitor bindings defining alert pins as interrupts.

Thanks, Igor

