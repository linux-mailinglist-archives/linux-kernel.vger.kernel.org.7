Return-Path: <linux-kernel+bounces-799645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02268B42E75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73B2566D28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F71B0439;
	Thu,  4 Sep 2025 00:52:39 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BD199939;
	Thu,  4 Sep 2025 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947159; cv=none; b=U0Bj3j0gkQv3ttMeWz/zc0Yy1OlK4CxgAE6BLclYt5EXf+KcmbneDBnJJnfz/pscpXZVc/dfYf+trZeixRzikK50CGzAJiE5+2SDG/7cNcHJST+/whADnqJm63D/4//jb4liChoAyuyfRXVwLixmzBS+dNFGfnxHpgr7D9UINEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947159; c=relaxed/simple;
	bh=QxzIo4Tv1rzxYmVE+lgXC8J6apeiQ9bSA0S3rZGUGlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUrQruw2qyu/8ybW/vagxGu67Qcj+doeWnSfncm/dc/3+D/MTH5YeNMxa2u/qfFDqmKYh1Eh9LUkzzbWUJnDwhAPSeJKOkwoN9o3szbhTK5eea0KleIrHd3FngZU0Snv0QW7vJPPjZONKHF7KwVDNqZ0mhHQJsnXpdhRGPfv9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.18.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2567C335D31;
	Thu, 04 Sep 2025 00:52:32 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: Alex Elder <elder@riscstar.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: spacemit: uart: remove sec_uart1 device node
Date: Thu,  4 Sep 2025 08:52:24 +0800
Message-ID: <175694709379.32917.16100695238119707451.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902-02-k1-uart-clock-v2-1-f146918d44f6@gentoo.org>
References: <20250902-02-k1-uart-clock-v2-1-f146918d44f6@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Sep 2025 20:26:58 +0800, Yixun Lan wrote:
> sec_uart1 is not available from Linux, and no clock is implemented in
> CCF framework, thus 'make dtbs_check' will pop up this warning message:
> 
>   serial@f0612000: 'clock-names' is a required property
> 
> Removing the node from device tree to silence the DT check warning.
> 
> [...]

Applied, thanks!

[1/1] riscv: dts: spacemit: uart: remove sec_uart1 device node
      https://github.com/spacemit-com/linux/commit/0f084b221e2c5ba16eca85b3d2497f9486bd0329

Best regards,
-- 
Yixun Lan


