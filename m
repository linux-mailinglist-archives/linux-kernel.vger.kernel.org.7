Return-Path: <linux-kernel+bounces-724891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9658CAFF835
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E387ACDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63E284B29;
	Thu, 10 Jul 2025 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWihGYQX"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F086334;
	Thu, 10 Jul 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123028; cv=none; b=eDRXlA02ebqCUb7xl8iYFgY6aqH/r8D/bw+J0O6jzBLTjbDc3ObxEB0UvCD3ris5vo6Vjv8x5p2G5bkXmCATamLx220pf18dQNSHW29Soi7yJV2MQquNOTsihMXUlRFRLh2KTcWv/v1cBIwDd2FoWowS2FhoIASxSYKep31QiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123028; c=relaxed/simple;
	bh=uwp0gpqeQVbZO+U9DueXgLMbm96HNfkTb66F33+MUVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgOYRzH1l3lVf8l5w2Oi3EhfcdkInsSFEmAh85IHEqrsE+wxwrKtzcpG+qCc6ki9U8LG5EC0wb/bs/R95qR3rNSDkS6FxF6lEggHLGPOgfrGirfP/wdVa48x88NVXsC+F05G2SiDz2We821//Q4wWTdoNhXoG4WSyzg79lrrc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWihGYQX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso590615b3a.2;
        Wed, 09 Jul 2025 21:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752123026; x=1752727826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7N/n4V1gD63xC4EXHv4+dlIpkFn7EZuSphI0w630ag=;
        b=JWihGYQXrpQAm3aC3fOabYe9OYepKV4B9HleMUatoduBZdLAfvHLj0D1ig5qxtMAXG
         VgHgV8Oj6qw9JGo4CpvayEnIR7S6jIO+z2xcqTGfystUGjgb5O9XoLWJxleMu3x/Dns0
         ODnLq8jPoFWtJFEl4iibPtjIJmWCIC1FydgMphKpDudY3kv/XH3bWP8ilOw4QHB/aQXV
         MZ2j0lbh2czrf8RimRkYmGAIYVzhb9drrzDQu0iuZVzALsM4vRBLEOLu/RTNRS0dPE+Y
         AmXamc4CVkKqOUTtaFzOr4yRxwbDpFO+8fdPXSrf756TjsmQcyh6X/nY0wyDyVX8PEBs
         A3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752123026; x=1752727826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7N/n4V1gD63xC4EXHv4+dlIpkFn7EZuSphI0w630ag=;
        b=ZP+OtQWjbFCj+5bBVOJFevCsH8GHl4PLxutWRNsNaEn56H8RVwQFhvLqbsVqIFYBw7
         UCQT2vYFItC7sqQkOEEv+NjseukuNNRWyI9dUg09zTRCDOj0o3yugYjn6nj+yCCu2XHg
         BD6xn/9IvRg0mQJwE9e5Pzbo11pMo3FL6yU/nMlmC7+R32i/990qK1KrDHj3pj3Cko8r
         6IgZZ9kWFAtGGcR4bkz2gfVXrntFBbVBzufUYxgIdX84y5W5l8gD3fSYMNYVbdfcUO9r
         P6+Fg2eSJy984f5oAU0D61Ra5D68qluXSPcaN2NRQeMaJiODGhccw7rwQf4cyaQ2kF1k
         I41A==
X-Forwarded-Encrypted: i=1; AJvYcCW8bDYi2xhFkXJuOLiOYcjfUA3QTqKfau7HzeRJG7LX013QESHlKsFK5DCX4kPRtZpxm2I5utn7BFdzeuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/Z8lGE6Rw5e7Lk4hn2fC18jsHZtAxwPUn8l/CTDCpdFoo0n3
	QbomgdVBOGuNz73dyVG/q+JbrJfPIdOCPDqRFV/qbOHnlEAL8nZ8OsPx
X-Gm-Gg: ASbGncttiWHLcYXhbQM7UovSHhfqpQqCr6hRKfZ+QI1mIA9M10STOmGjUa1m7AzrGTk
	PF/fkxXADsnSRqhabcLib4ALCdqoKGxgjQm9fr/u9H7mXK6wazq87MaDIZA53YQ6TX0NnHE9vcl
	eErzTsThgwa0XGDrnxZHxXA/basd4PatnU7Ed/13DZibg04eJLuQ0QJ6vPM6UwSG9cekxjKFLbY
	EABmPxv0MGWWc69qF4JCe0+EMZeJxbOteheMXJSMfr2F6Hr9XYHEw05t+LxY1C6xCa7m30OSUZb
	Pfx8p1dbGGRQm3EvDzRV1YS+x7Nr3hzrKucqtzqEhxW7/ShhXIZYx3OrGH8jMA==
X-Google-Smtp-Source: AGHT+IHuOp25kVX40AKI+YI7J3pVcWxjA+P2rjstauIuq/UhiYjgiNwjgAfEnySBXpD5cfDnLEReYQ==
X-Received: by 2002:a05:6a00:2d06:b0:748:f854:b765 with SMTP id d2e1a72fcca58-74eb8e84e50mr1962266b3a.4.1752123026300;
        Wed, 09 Jul 2025 21:50:26 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9e069a1sm850099b3a.46.2025.07.09.21.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 21:50:25 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] riscv: dts: sophgo: sg2044: add pmu configuration
Date: Thu, 10 Jul 2025 12:49:45 +0800
Message-ID: <175212292373.416883.8963674402175536459.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250703003844.84617-1-inochiama@gmail.com>
References: <20250703003844.84617-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 03 Jul 2025 08:38:43 +0800, Inochi Amaoto wrote:
> Add PMU configuration for the cpu of sg2044, which is the V2
> version of C920.
> 
> 

Applied to for-next, thanks!

[1/1] riscv: dts: sophgo: sg2044: add pmu configuration
      https://github.com/sophgo/linux/commit/111ecba7b1f884133c53847558a8595294dc002f

Thanks,
Inochi


