Return-Path: <linux-kernel+bounces-882613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44753C2AE76
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9EF3A8B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CCF2F28F6;
	Mon,  3 Nov 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3JPoNyt"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82C2FBE00
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164151; cv=none; b=HpJh4lVus9Q2l2so9bGrVd5WHBMvzdDqCCFFP/xB4qusMMf+IQt9hz5p6eQK/JKDOWq10cvuuMm8Nr3QvR3CuxGkis0WPX9e2ZTIU4lh0f157LXDTn02qK5niUEBFMJ3TvBmfL6G+S8nGIZPF1qtkpNgbJahaed+UHwH8gHayeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164151; c=relaxed/simple;
	bh=W0zrDmAkZxcdW8N0iwDoYZEJ2E6P0O3vg9i/EhjU7kY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XYuhVHEQW45Ef3nF7s3I4Df6dKHeds/6JWVvL+3kyeggmM6OVBNDp6KO3TB0zShHjWpOCjeZubdQpxRZZo0X3Hrurmx3eFueX6zeecvGlKq8s57k97fVuX9D9VJWiaw4ecd2eaxp2xOux550LqNiebdHwkxeEfWaYukDXZyQmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n3JPoNyt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b70ca7d1e78so10346466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762164147; x=1762768947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk5WeVX3WZidjw/Ohoo4baVD2n02pPZGtcsCU88fulQ=;
        b=n3JPoNytTryJjNZW/YZhzRHW5SNucl9bGohkFkA2Q1bHwBFBhVvFbf8zDrFS0Hn0ui
         YkKcK7hYYsnlTwwy/u08LWCR59RwH87Fs/CpUwjHrJiUxs43qmG+o5btr9dXAP12fc+Y
         Kxdcx8o1/ioHHsv2zKpf4JfiQMFbtjILKDPCIrbk0QwsUYEtHAn07mNckkjWcGp+jCC4
         exO3s275TbRa9szT5YYF+vLR+PlHAHK8VOlNWyv4EZ4JsPx6awA9HxEq6UVyCyu0TQgr
         6+576ufbHQfQQJ2GNfN+j0mJ7wyJ345Dh69zibBUMgDV0SsvCXswNZhagrHw22bG0TEW
         Dxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762164147; x=1762768947;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk5WeVX3WZidjw/Ohoo4baVD2n02pPZGtcsCU88fulQ=;
        b=TxtqAkqMzIrzovijcJz+na1WQTP3mzwVz/PeRRgdNASquoE4F54ATRP6QV8PyWyZKx
         iTxYgqthGxMR9AY/rNkmICsuHsSudcpU3h3WXWbiVfkXU9wKo7xYjOsZYK/YhUKycIIW
         clidg2L9c5GWZ2ZORga47Gz8vYxlej/FFlgj/MrR+mSV45u1hsWZ4o5p/Fa1u4HFAWEs
         X3qtW4R2NssAKJOMR+F4xDehPZvFXIT/2p8f4M1+UL9dStUwtUq7LmFtkqAkxw8SvLRk
         8qjSM4TepIx6Sze/cXofdKigCtU38XRPcvcp0mdzNOOAmS1UWuiFVr50Cj0uH+wr2iLK
         uqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq5DBqufijjTVw2tMizsKGfDA6lFRaU3jBROM5tMYsqOrYMSYB/2pjl5xPFgQxGF//BbP/8w0eF+rDvro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXagGXUScATicVxZ0rClGqKPDwXi1ff+3RYJ3P1MSKjpMNkn1
	9RCRrSs3A3/M5bOYnKRW5IkRpuR7EjoBVY5nyRssX6OMDL7jAO6Ny+ne8fxkv6D4ZrdHy9WDYog
	PwQqn
X-Gm-Gg: ASbGncuDFEncLRqfzx1369bg/PNDZMjY3q52K1Obql4SSNNUruy+iJDRMxHYHXwFqNy
	MEp7hJaHMey7z/uBTWnQxrDNMEXN0C254Y5zwxr9o6cDgZMADVNQNJfCOsRi16I1IK7QyqkC+kn
	u8SU6Tr0PBTuSgH4aSxPfJUvJCOGehY1O+gz0EoI7YPkOb0dc35PNnPrpqOplwZiFCLXSwHzhJm
	a2jzT+gwPJOWtL01Sf24MpPMj2hqNq5tD8woJG0I/Nqkz9lmceQxRBp+YG+TvdntI+/6DqjOWYH
	uAGHb6p/iMAFja/hsf938eDfCfHEa0RmvOgpFsXzwmFoD5lRTACFeh03Slwsnx9heI3FXMYCf+0
	TcjDwqOMH0/NHWFCKj3XYLxx1Jf5ExIY2lGeawtO0yInrUsoXmYcVBIzi8r/EsE52L8P07cPKko
	dcXgsrLhzT+jU/gtLXpzERKJRQNgY=
X-Google-Smtp-Source: AGHT+IHhQd0Z7HhWjALB9oj1UOU7TBdJPgOnwuPH3RM+AzCngFPe/MvWD8B/RttW7aRFtZ4rAovK8w==
X-Received: by 2002:a17:907:3e03:b0:b42:1324:797b with SMTP id a640c23a62f3a-b70708ea28bmr632326066b.9.1762164147447;
        Mon, 03 Nov 2025 02:02:27 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b1576c5fsm433340966b.43.2025.11.03.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:02:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031-gs101-chipid-v1-2-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
 <20251031-gs101-chipid-v1-2-d78d1076b210@linaro.org>
Subject: Re: (subset) [PATCH 02/11] soc: samsung: exynos-chipid: use a
 local dev variable
Message-Id: <176216414543.27448.5786220259949366154.b4-ty@linaro.org>
Date: Mon, 03 Nov 2025 11:02:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 12:56:01 +0000, Tudor Ambarus wrote:
> Use a local variable for struct device to avoid dereferencing.
> 
> 

Applied, thanks!

[02/11] soc: samsung: exynos-chipid: use a local dev variable
        https://git.kernel.org/krzk/linux/c/bea18c67a0ec75cc602aabc523d726a4626e1341

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


