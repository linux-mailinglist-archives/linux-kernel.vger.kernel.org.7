Return-Path: <linux-kernel+bounces-803868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2248B46698
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790D8A45BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A628CF49;
	Fri,  5 Sep 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lZhEdEOd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8628506F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110937; cv=none; b=UX6rPnq6i/esi3xD+grHLapZcZc8TtsC3E8xTbYP/WsDze49j8PRq2YewHtQbl4C7oiAEeWE/u8vsqVuPricOD3e6ab1btYacfRnFUbWY7jLJvi/17S6SITkDw9U/j29Dv0LhX5SH6xTFgjMhCyQwH/uI3rIJyhXcQRIEGVDvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110937; c=relaxed/simple;
	bh=P1j50aF35GnkXQk2lVmzjTni8Ue0o+yg2rhWnEq3iWc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ju9Inj4XnwzbfcipB0EUsDKxNd6N8dYVC9ib5knQJ09wr2K9JyqNEoWoJQjNTyeaA2wR0mLEX9tulDzDjJ8r1Vjbo47R2QbHPtMhp0bKkLyDNVx3a1RqXccucu4NifHNadCa4Zbqo7CXvSaV//2Wx1ERyUBmaCnsH/2+uh0PdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lZhEdEOd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b13313b1bso19703215ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110935; x=1757715735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3MoENRKP6mYeZPRW/pxLj4qhNh7qVu+dXlOTgSs04Y=;
        b=lZhEdEOdtRkzD2rOLWVSU3Ocgh586guK3HJkZg5DOuvksqR5M3EuVbOEJ07zLx1+Va
         OMuSxEr0wPiiOB2vwzvNEB6l9XJMU2xfvMrKH9OyjwkXbwMNYWt47dqEpbX0weq5kkXj
         mbq/dEzjgDcWiKtXRT9KIPZ/hbyEeFAUXO7Xw07TTTyvESIuU7QGId6tJ5IiL8/7z1qr
         /QKWNBEmXRqOQ8yN/ph9JR2heY8n9c0JhFRF4sUoIErUmSqEo4p/796tjyFviaF+dcB9
         iJQ8xdHBFQO6EyBR2Wof1FiYyNayhW4EWk7K4n8sQfq5tg3KdoqQwwwYB79iIjtcpx2T
         3J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110935; x=1757715735;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3MoENRKP6mYeZPRW/pxLj4qhNh7qVu+dXlOTgSs04Y=;
        b=UT12mQBauyJUHRx1kt3BbgWg0Bv7pdEuCrLGOcEHATXEOEPdTo7P8FN9Rcwqo3ApCO
         Io99vL9X/OBV+h+eKQ1L5zUL6srwT7rEcOgLS9/N5QyllSr6FbcEfuuw4NOuQqJXJSYc
         HZmnUJw19TWq4VjrMfnKSjMzTEzcBkBnHTkzkxxeqlleSQDRaIZ3XBiuBVC6UhW51vFX
         /kARuJJv4umL0jMTpayBb/SD/rvkWRnnamD5+WeTS0OBCAyEF8E9KPsopZPxBhCjmHhS
         kVlpAiAI863pih5VVrv19GjdOl/3tZOQVInzUYTHFEZyP7BWp4CVIazL/OFc350TdVCc
         fRZA==
X-Forwarded-Encrypted: i=1; AJvYcCWwr1eXZB6SMIgZTe3B+a8XbdeghMQGDLUaPAvK7JoyyhcoE2aexbkLi9YMXi+GzMyQftyeAq9oSd7qp+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcsi9Y2lrK3C9hk5BTs8P47qHVzI0yItSTL/XQOamvMDkQigAV
	kFI5sZQyYtu1xyQJI4eNY5GpPzFuWIm1EsIDSJgdi2k77dDMybvZY2muLRPjBuBCjOI=
X-Gm-Gg: ASbGncvED7yz1JagxFBTCAFRnWQowSBOIZXcj8Q5SCDkobFLMDGTL4an3kUp/2H7LLW
	1sR8c0G1313yO/BLd2mM2daPcO+Zk/Fv+LtJ3JcBKcCXgJ2Xuph0B98UYloykjB6FGcSRm/nKfL
	pBvrdH6ZaZkjb73uhVunGODofzU8T3gmCcbjicdamQD8pI9BCGYzOgeKEKhFDdq5RLBk4WUCh+n
	ONmSdDYPUIZsHZhNcVpmIDRbMKWKLqgSyWSVWSN1uUUCCGEnNkRbYfrOuQh+HoXo20ZjrEr2y9X
	SjLfR3g3xkDgP3hECH9Amn7hri3QmAOJkV8mWOKNPf0FG3gpUKQbCAZmstUbd0HoyLBeANP/MDB
	yeAOaPOCUA5wO2CPIwESf
X-Google-Smtp-Source: AGHT+IGFh7XSvm1jmSq5I6nF/CZdeopZIBB37Nq6xs75hcHOkaln3WatQDx6FOTZQCdDBErB40YFkw==
X-Received: by 2002:a17:902:dac6:b0:250:de70:cf9c with SMTP id d9443c01a7336-25174ff62d3mr2891525ad.47.1757110935003;
        Fri, 05 Sep 2025 15:22:15 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea628sm33047585ad.6.2025.09.05.15.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:14 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250819131651.86569-5-krzysztof.kozlowski@linaro.org>
References: <20250819131651.86569-5-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/4] ARM: dts: omap: dm814x: Split 'reg' per
 entry
Message-Id: <175711093408.666031.690873725302943205.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Tue, 19 Aug 2025 15:16:52 +0200, Krzysztof Kozlowski wrote:
> Multiple entries in 'reg' should be encoded in separate <>.
> 
> 

Applied, thanks!

[1/4] ARM: dts: omap: dm814x: Split 'reg' per entry
      commit: 46179394d4e45d561a2c0185774c2f7b88fa7c14
[2/4] ARM: dts: omap: dm816x: Split 'reg' per entry
      commit: 7d7df1bc644a29e880181579994bd2da9fb1a6ce
[3/4] ARM: dts: omap: Minor whitespace cleanup
      commit: 9df7366a29192f860e9e35a258f0b000b6e4a754

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


