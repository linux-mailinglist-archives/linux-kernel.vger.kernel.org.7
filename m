Return-Path: <linux-kernel+bounces-804756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD5EB47C97
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8271C188B6FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D8285C97;
	Sun,  7 Sep 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="CBA1qJ0G"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D0189BB0;
	Sun,  7 Sep 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757266234; cv=none; b=tY1170g2BgCEPtWxcGpL4Vc7KsBYd1OqnSnQigO4Rsze7mowO3/3wlKssIwJsLQxVqsADXqUEhN8VwSihN7RO0aRMurxC9HBnjscU+RYukfzOAHgGf7ChtLJdnSJzkUvJ8ct5O/+TvXxS7IjamgR7qrAPpAhD8M/klTzb2kv4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757266234; c=relaxed/simple;
	bh=tDb/tbZZmqtpCiyGWfZJtOsDkSFN2UmZvKQ92VxC1lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxHKNBOlLi993gLECo3VeX00KUntfsO9P3tqQcsURWvxrmH2CmbMFX7q4asXyqLd5xVPpT2wnHnvNar3Twwo+CJx/ZofV7dV0E/2VlEQt5mkKvKY4MA0msct0iMDoAYUiIGICFHShIxKvuj0psJdywtJnGcJcdEZ1wRZCxc5QxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=CBA1qJ0G; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=j5qAC84QQZ/QIIjMkOrBJNSXRAH+jqUUh0eQKO1pdy8=; b=CBA1qJ0GfbxgilebHgXux7lmZ7
	nwcJPJjaROY6R8w5t/mGoF1q2Td9NX9rbZJQoAE5+WP14SfZDQxwabDgYnokyLpXlH+kBsD7FZq8+
	FUKBnVXM6qnYv6mRVxzDDkliut5mo1fPX931hdaDVA+ePeVWgx49n6xDfLjY+ibsgWu0WDadLhpJS
	n2VaALtZw+t+jCUQgcYSA3FqNHlMu2ReG4zNeW6uiFu/gkJYDaOuX/vmME1dKfKt0NMZDwD18ZFuq
	oXQkYDKTCcSZ+tyxxvqCTrhK9sluU9WxBWbHzcI7end+NWMgo97AjnEeqvsjIgWoFpFfFaVW2btso
	+HRH1KoA==;
Received: from [61.8.147.163] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uvJDd-0004Ii-Be; Sun, 07 Sep 2025 19:30:25 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add vcc supply for SPI Flash on NanoPC-T6
Date: Sun,  7 Sep 2025 19:30:12 +0200
Message-ID: <175726620391.195224.7684283599123514872.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905-nanopc-t6-spi-nor-v2-1-098b476d9509@juszkiewicz.com.pl>
References: <20250905-nanopc-t6-spi-nor-v2-1-098b476d9509@juszkiewicz.com.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 05 Sep 2025 21:01:51 +0200, Marcin Juszkiewicz wrote:
> FriendlyELEC NanoPC-T6 LTS schematics shows VCC_1V8_S3 being used to
> power SPI NOR chip.
> 
> This fixes the following kernel message:
> 
> spi-nor spi5.0: supply vcc not found, using dummy regulator
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add vcc supply for SPI Flash on NanoPC-T6
      commit: 41194ee115685ec2dbbb80e20d1090cc3a4c64d8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

