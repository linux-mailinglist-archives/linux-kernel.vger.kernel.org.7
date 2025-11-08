Return-Path: <linux-kernel+bounces-891246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FB1C423D8
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E6904E4102
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B41A1D63F7;
	Sat,  8 Nov 2025 01:30:33 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17A2E63C;
	Sat,  8 Nov 2025 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762565433; cv=none; b=c4t46oIOlQpD/Cj0Oy/8TlB9Yqt+OY0v6AuhS1MPo5Kf8SMxbfBQGTrhSUrwFKkbIVuWTEe3Ng6LZBJABn8xsJY2gH8+1yKO1gok+6n7f/ePdiVqTU39hc29pSSVYgED33zkzawqVrCn3sU7FW3T3njKPHlIjiOYymEPRiXbNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762565433; c=relaxed/simple;
	bh=aKkUT4Q8mS/5aBgMAAFiY20Lm/MC5KBt5eQW0Zxv2Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNcHwROQWBMK1pvbgruHOhFkEb3wQBC4sJcw2MkaHWhka+QUzneiLqjsRDP2xk+L4WS30z0L8K6WzkwMw7R5lJVgXcyb7wiuP2ePlYBaOfB/+2/RQg64WviMCjJMk1dKHjPfMxWvN3toUe4kjT6JPapV9T7KqQ8bmB8dMaptLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 38CCD340EBA;
	Sat, 08 Nov 2025 01:29:58 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <pjw@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/2] riscv: dts: spacemit: add initial support for MusePi Pro
Date: Sat,  8 Nov 2025 09:29:45 +0800
Message-ID: <176243100596.329363.7295947572215829421.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
References: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Oct 2025 15:28:28 +0800, Troy Mitchell wrote:
> This patchset adds initial device tree support for the MusePi Pro board.
> 
> Muse Pi Pro [1] is a single-board computer integrating a high-performance
> RISC-V 8-core processor, storage, I/O and expansion capabilities into
> a credit card-sized 1.8-inch board.
> 
> Link:
> https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf
> [1]
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: riscv: spacemit: add MusePi Pro board
      https://github.com/spacemit-com/linux/commit/2cc22890635ded33856e2761b780688f54a49393
[2/2] riscv: dts: spacemit: add MusePi Pro board device tree
      https://github.com/spacemit-com/linux/commit/0ee59934662dfb89b43a8392e64ac4880c2fca88

Best regards,
-- 
Yixun Lan


