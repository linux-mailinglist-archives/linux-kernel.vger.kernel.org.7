Return-Path: <linux-kernel+bounces-851598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1964BD6DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA3C404C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA92D77F1;
	Tue, 14 Oct 2025 00:18:13 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350D2BF3CF;
	Tue, 14 Oct 2025 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401092; cv=none; b=qsGvPc2SgNehVRsFZ01QIFC7OMxc+LrfEdieYclgrZAbnvXxaEgrL3SweRILjNkZbaBIy6m+T5fnkBtn1tNltyDBtM3POTVx/kS9JRPSTgqRrZboy0pM4D2GDhLlxmpbKiT/dgXQw57q7+fJ7lm3OdNRh9GKFDEF3MS7+mCyMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401092; c=relaxed/simple;
	bh=dMe29rV2C8DIvpYQosZ4uZQ/K559pFQf7acE7cY6i80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7xFqwP8qqXoUrfOjJf9IfrDKnU1nZsA1BtdJQBYmNfham9se2D2DCfYnbgZ6vnw53DSedUHQ/U4E1kJzkauv2QcRRDBafZmnPWhVoboi08WGRAyMyAQDxmx0K3B9vpU3JbmF+0BgNC51cVgQYX4kBAFsBNhuvlCqYMBGNnkdE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.147.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1837A340E9A;
	Tue, 14 Oct 2025 00:18:06 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Aurelien Jarno <aurelien@aurel32.net>
Cc: Yixun Lan <dlan@gentoo.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v3 0/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Date: Tue, 14 Oct 2025 08:18:00 +0800
Message-ID: <176040093505.976672.8840719266527899813.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926175833.3048516-1-aurelien@aurel32.net>
References: <20250926175833.3048516-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Sep 2025 19:54:36 +0200, Aurelien Jarno wrote:
> The BPI-F3 board has a 24c02 eeprom connected to the i2c bus #2. It
> holds board data. This patchset adds support for it.
> 
> Changes between version 2 and version 3:
> 
> - Revert the name change for i2c2-0-cfg and i2c2-0-pins, the second cell
>   is not a function number, but an index.
> 
> [...]

Applied, thanks!

[1/3] riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
      https://github.com/spacemit-com/linux/commit/dcca2287773b69201b756723e8d45b6b8ad81b34
[2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
      https://github.com/spacemit-com/linux/commit/bfce75e2345fa1ecbf046e696994132f56d6db1c
[3/3] riscv: dts: spacemit: add i2c aliases on BPI-F3
      https://github.com/spacemit-com/linux/commit/859ce3828f0b462e991c24224390def4c8fea673

Best regards,
-- 
Yixun Lan


