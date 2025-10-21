Return-Path: <linux-kernel+bounces-863590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C3BF8408
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C83C3B54E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B6344028;
	Tue, 21 Oct 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOoe/dQO"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1134846D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074834; cv=none; b=TKAzmZRO7ApKN3gu8fKJ8f4d+HIsiDKWQIF0pJPB0dEFtTrXW8h7DXKlrsDxnQJFVP/VPlkJT2JUuIsr/vMlieAWKhBbd4Bomn0GryDjYVo2VWdOeXmCV8QUdCT9kwri8HeK/iTfLC7Y6WgntOPvhL8Mxg0e+LUIh0Cz3rjsYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074834; c=relaxed/simple;
	bh=80lKMAyCvwagR5exBQfzbE8bJPhC05JQJ4q2PDAq1Fo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RcMzZhCN8PlxQM/kCRpGFoIRB0I3WbaM2jRhvDi7X0672MBSMR1wPQa8uBzJulCn+/QhYwDW6OtjTihY/bD7AEcit66osL+oSppxULBycoMowq5grH/hQRjW5D8WnyXfHtTReP2Fp6yxsRkYvd2aCS0riquSsqlaisyU+R9QyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOoe/dQO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426da8090b0so712361f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761074830; x=1761679630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5/SqlA3X/ZkVhbqceO5ccBn+9e7HcyK50UX+eusqGE=;
        b=sOoe/dQOi1vedCzQnCcKxUCDdZiKcemRWrNDPq7LUBVYGMz4kBCumvHqA0IMi3IZIG
         wAxXCAxmeIoBRzRmc/sbw2BKbiByqz/3smmLq24lskpjsf9e9jc/HyB1eU8FPdTiY2K4
         PuTJUBLrNtov0qKXUSvBwGKGZIRETxr7jNESYv91xec1cP5tUz0jBBUnI5oCJVVBgk9W
         eEcZSxv/eoxH8zgYKHDbDmV/38DrlFhziaccDlNf+jKP8kAL/vU9N877uvCPnQPARlPC
         ByJcwneih89fRUxzT/FqEXzBR+jUGJ3l5n4XDEbGx5sNgvGCJVOKaB5terYi6LA7RbB6
         PR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074830; x=1761679630;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5/SqlA3X/ZkVhbqceO5ccBn+9e7HcyK50UX+eusqGE=;
        b=UAZSXZU9QaEnfaLbk5bTF4sTm+1Q0Yxd4RrBzH2cfuHT9P7yL2qzIX1DAl4VB5tTlp
         hQX1JxxslM3Bl67xLRkWjGHxWVGFY09UPsJtMzlszSscizwRNRKKOfdjaAHJbuwT4OoQ
         90OULYKx0CIDWsuf5kfrabl+25KKcpFy4wZJrw2VQZKk5rjx4KWsA7FFwhhanUqYMPH5
         9TKDjjFhavezuSh2LQz8QYApQUXw6I8dY4Uv0+9KS9bbZ22s0Pi3HgqTCUAOoJK/9Qj4
         Uy/U8j1KSmqJGf64SxhlK5UTBmpAIDZK3aZuCP0DPr1R441btmB2KjQpKQQww/XKzUNw
         q+1A==
X-Forwarded-Encrypted: i=1; AJvYcCU/3l7lucLH7piXoAfFNG+ZiKeyX4l/h1JC99q9qVVCOxoiLcVKNj1ByuUy2RrgaQrc0/YEgFGBxV1O7+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSUmW7QwhOjXspzTcdABGlJzToIoT4C1aA8WNZ2EAV4aj3uRn
	QkCreu1R6AEwXOmgdF9F3okzcYnU22G9ItZTw0tM0Jv3URuGqdHfSyht77rSYzbRA5I=
X-Gm-Gg: ASbGnctI70ceLdlKFglTLCdR/vB9ghXvjpadNbplo/pkjz4GCWblhbkksfjBrU3Cmz2
	EABXI+t+6Fy/IFrcVruRb2TqISM55+uU0/wRv55mUKNaDiJ/9JC+cNqnRlUtyeHV9KKmjehBohp
	D0Ya0X7uakgoOkF9p6GtTGa2Vlukmo4AZLoE2jv8fwL7yYxZodbO3GVlUF/HZL0Eq1XQCHG9fMn
	8BlwKuQJ+MM9NWU5/hcGb1yV4wRIAo7GVKUC/fTMAS+jB9pvVFUEIcphk6l+qBOFHqK5zkxtEiw
	qVUmiK+gleIles0yaynr/YbdaF5Z3vHVkW9rB0WPVPY66RYHCdfewHbJqJ3QaVOh70PCgqkq5DA
	fVWT6ZAKHIIeYzOKjuXdD15xtKWvO4fCdPQ2E8HEk7aFDZ7GEHTm6wVRIEYTiAhK+fFDo/JsYv3
	/xRqoqVhTNGqwXcB/kyA4NrapZ+CU=
X-Google-Smtp-Source: AGHT+IGAOoUW0XD9+qwwI+PbL9VG+MrdXs4rR2dEuVGyu8dEGa1T5rx/ZK+RB3yRzWux75q9C21zPw==
X-Received: by 2002:a05:600c:3b9d:b0:46e:5cb5:8ca2 with SMTP id 5b1f17b1804b1-474942bf7b2mr23336545e9.2.1761074830178;
        Tue, 21 Oct 2025 12:27:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b48c9sm7839115e9.15.2025.10.21.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:27:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 kernel-team@android.com
In-Reply-To: <20251013-automatic-clocks-v1-4-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
 <20251013-automatic-clocks-v1-4-72851ee00300@linaro.org>
Subject: Re: (subset) [PATCH 4/9] arm64: dts: exynos: gs101: fix clock
 module unit reg sizes
Message-Id: <176107482865.33931.12362645662957210185.b4-ty@linaro.org>
Date: Tue, 21 Oct 2025 21:27:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 13 Oct 2025 21:51:33 +0100, Peter Griffin wrote:
> The memory map lists each clock module unit as having a size of
> 0x10000. Additionally there are some undocumented registers in this region
> that need to be used for automatic clock gating mode. Some of those
> registers also need to be saved/restored on suspend & resume.
> 
> 

Applied, thanks!

[4/9] arm64: dts: exynos: gs101: fix clock module unit reg sizes
      https://git.kernel.org/krzk/linux/c/ddb2a16804d005a96e8b5ffc0925e2f5bff65767

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


