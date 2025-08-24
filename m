Return-Path: <linux-kernel+bounces-783468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED4B32DFF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08491B26AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE144248F5A;
	Sun, 24 Aug 2025 07:37:05 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0D220F30;
	Sun, 24 Aug 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756021025; cv=none; b=OwMNhdblKxy4I/u8b8NPsK+vOGSce13TMFoQsVVhsiQnarnWq1Q15R3KZVNgC/AcJxaXO7dvx6TW62TRsE4qznbqBih32Hzr0EreCp4KaqEWyEZZoepWgy+IwXOWLXGzs/2iX2iiby0/HNSJTLC8m1qdFDrxwf4hd4DF4ZPW890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756021025; c=relaxed/simple;
	bh=nbh1fZpe36WdEto5iFgq2/Un1zMvq/DRH0ahJK8sLFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMRuFUxm73RF9HJBio/una65T4juPT31QE1Y+OZNaevV3fqfotx669bL6V1nc8tE6MX3tid6aWmnolSDBHDIv9XFHMX54vlTRCXV06+mtlq6jHFyIk4l4ULdymma/0H9Q4ZG+gV6G5kUmBqo6Elfggxt90OApgLjAR9AXyfPkVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E1311340DAF;
	Sun, 24 Aug 2025 07:36:57 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: spacemit: add UART resets for Soc K1
Date: Sun, 24 Aug 2025 15:36:42 +0800
Message-ID: <175602095097.196581.656734670747058634.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821152619.597051-1-hendrik.hamerlinck@hammernet.be>
References: <20250821152619.597051-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Aug 2025 17:26:19 +0200, Hendrik Hamerlinck wrote:
> The UARTs in the SpacemiT K1 device tree are probed by the 8250_of driver,
> but without reset lines they remain non-functional.
> 
> Add reset control entries so that the UARTs can operate when mapped to
> devices. UART0 is already de-asserted by the bootloader, but include its
> reset as well to avoid relying on bootloader state.
> 
> [...]

Applied, thanks!

[1/1] riscv: dts: spacemit: add UART resets for Soc K1
      https://github.com/spacemit-com/linux/commit/eba84c94f9597a82f143997bfacc75e5b27a37de

Best regards,
-- 
Yixun Lan


