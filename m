Return-Path: <linux-kernel+bounces-812413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8ACB537D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C695841D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F2A350832;
	Thu, 11 Sep 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+wirtxO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C307343D8C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604773; cv=none; b=K99/9XEQKHSDMadjza15ShsPot5Y/Hf875LURJixQPb5768EzQGNHH5qAZlBUEOJjAmO9rDAYo7P/b1TZp+417KZC9WU6kP0wxNznr0OWBHvdFQVM6QgLX1iZN04yGJwC+aZqU+bFOZfjaBYOdBYQrYcfJ0EVFT1Z5tKV2cxIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604773; c=relaxed/simple;
	bh=9d5INW21jjr6oErj7y4Sti7BG3O8dXxCjtAuIhufDNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoxq11PeBfdpuALfuQV4L/XUIUHgNML8HGRZojL4F2UnIYc6wFhZQBrqRPnnfoe93zPsp3i5xFkvm6/Z1/TtYE03lCIwtNM/Peg7r6jHYEWw7RlAsBkwAmGkZ6BJLkKplymkPcf4ENtajKx2+zoi0ACzazpnY+m3AP/Z6RXgUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+wirtxO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45ed646b656so2825565e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757604769; x=1758209569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3axJvgEbFXgxfwL/zVY/UXD8zhBqiTBNfyhVw2O5KOA=;
        b=h+wirtxOZcmfcGFV1qt00csoureoSJAWB0UhFy5L2Q3B0L/z0rcYinbD3Nfvd5j4/X
         oaUU0o1jA4H8hKIO4VE74fM14ZQrcGllHA7ivBwEBqz4K4KYPZW/JQlUCbiAbUu0QJwM
         qzToOgJOU6eGR8xtOU89nJtF16v1tpGsaAG0A+ToaVjSnDK8/XhhCQGL/UN3ObGMYOm0
         OHKdOJiACoxgXZqRxHboU3BJoyNo7hx7Rl2UtMTZhB02XaicXy6KzlgJJs6GByibqlzt
         KwF/ca8R+/K2z6LxvdgVzHgrV4GrhzmnQ0sb3cugO9PzOQON//+6+qoVi6LRYHIvpqXH
         gNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604769; x=1758209569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3axJvgEbFXgxfwL/zVY/UXD8zhBqiTBNfyhVw2O5KOA=;
        b=rbsX7785y+xF2ErIlBQvOg8qZyEnZXXxgQ0t8prrlLu/O4BYHUvy30Db/l3M3jAYJX
         9L5Rhiqp/wLZyy/J4zzMEw5+1SaKnC+8lL4KkBRMv7p0j2ylxg3k/079vjaQmsb4vtGU
         GpReyTs77WVMmGD0JMuk5AuqTVZEuix/pPzxliWrzQYzxRsIsm9CvSulrlF0sYEWJ8Xz
         LVJIhbFvD7HfudO6k2JLA/Owp1HxeUjJuwc+DsaDCAu/b4ziKsO8Q4G9gKjDn7UsESvd
         sqZxexI9llscqqbkqBQvJPAwQpbvpMQNHpvcjgUf2WMgScAzlAb4knjZoLiyt2m5qaZM
         xfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr9YoqwaMnLZgF3ffN689u066hBtCgltsfUEwf6t/beGMIhOs10hmHwHkWKJQnWJ58Vsf548PCpRs8WTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLagxjZhl1ulP9IndT8p4IQNjg8qUGYa+YOy/Hvh1RPcZKJfB1
	1JOm3JsONwukIEylj+iRe6jcxsbuGtYXpKjXYmDqj1c8LGknTMcp4nC6
X-Gm-Gg: ASbGncskx0haYMWe7GcDRQsZXhF8We+8IhVFajlxM2t9qZSB12duDjjiW1F6TYGTLiI
	nvXo1CWqWML/00J7IrleiBFJoHiUdEqLafR6fRJXW37DyVtNri/crMhShxo4k6gYop80NNOpx2x
	LViBu1I4eOzzm6AcWG6fVqaWn6vlq01SoKSFxBF6mLE/UjAuUQrfjZeVF4mgnde32UAAD/FI6NM
	2EV1c9IaA5uEjfMi5SEyEqpiKWnl2aWRMocioa/QPvlQW4C4arHGfJDnSdaVnpqUFejIRb9CPiM
	SQVgmCBYEjSZQqr36stdHaiKQMhxcCTNcLmNRTNRzasNinl+g5kATG1yea4mwGTkh/Pn9e5iFrS
	jfoc51mWxJWns/sIAUlsDdUA44MzDj91lqRgOxu39yEjbKIaHt/B6ia6yxJi+QT3gJNtjYWiY5S
	zybtRJlk92aWT3S/IfyFX+S/5V
X-Google-Smtp-Source: AGHT+IF3BLIq3kR/6GHqEPtT2eBTcLlyt514cWOzH9fOkQVX2eOkZCeyPsb05zloZHpD/Z4ENo6UCQ==
X-Received: by 2002:a05:600c:46ca:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45de072e878mr165182475e9.13.1757604769028;
        Thu, 11 Sep 2025 08:32:49 -0700 (PDT)
Received: from localhost (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e037c3cbdsm29794125e9.17.2025.09.11.08.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:32:47 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: akhilrajeev@nvidia.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	ldewangan@nvidia.com,
	digetx@gmail.com,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kartik Rajput <kkartik@nvidia.com>
Subject: Re: (subset) [PATCH v6 0/5] Add I2C support for Tegra264
Date: Thu, 11 Sep 2025 17:32:39 +0200
Message-ID: <175760472294.2784204.8145431282909905411.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250828055933.496548-1-kkartik@nvidia.com>
References: <20250828055933.496548-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Thu, 28 Aug 2025 11:29:28 +0530, Kartik Rajput wrote:
> Following series of patches add support for Tegra264 and High Speed (HS)
> Mode in i2c-tegra.c driver.
> 
> Akhil R (2):
>   i2c: tegra: Add HS mode support
>   i2c: tegra: Add Tegra264 support
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: i2c: nvidia,tegra20-i2c: Document Tegra264 I2C
      commit: 804ebc2bdcc85f30973708835b47ee023a4be003

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

