Return-Path: <linux-kernel+bounces-883806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E9C2E7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBCE189AC1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68030C345;
	Mon,  3 Nov 2025 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="o+f45nRf"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3921D3EE;
	Mon,  3 Nov 2025 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213775; cv=none; b=IuJX9aWmsoC2/eWoVoMOkq1jsXgC/eaEbEBK8QXRFyoL0zJJ1n7Sx4PkOROK3oDdR8iKk2yqhW1yPCgr5GijYBp4nUCeVlRi0x8bjtULgRtX2vBbzVu0u6i9suIIqh4W2oLTjsfEhscjPSv4GrBuFniIEuT+IBE7TwQQdbxH4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213775; c=relaxed/simple;
	bh=ioPmPketPP7huwpvVSdurjgyzIifVeb4CagToeUmVNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnWKUJuewn1GPwSuqpfVcFMtIabdeWEfinxp5v3CRn60n4V8bCSvfi97QC8tb6hrwxtP+N6eaW7av43EHosI0ChXpAwmMkTnRD8uYmcjfgQ6/OuSnnIyXTqMmZZ+HIFgVhfP3zp41ipylzWdryLyzm5oEcm5wt+9K4Dyl+tm9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=o+f45nRf; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=ii4Wm1oN+7ZBem4KBM1X5oSCmQ/08wTBQQRe6TYQrgE=; b=o+f45nRf49jrGiIn8a+5gArCjm
	y4UywFYHlXbd6Dtu+UBCWdvTnIvZpHwX1zKfJy8gQgkdLMkkVWNpD7wP6aRF0RHP7cdiQ77B+3Lu9
	IJ20YhE/0v1l6O0zqfhRaQ6ZX78DGIZOu+ngY3wwgmuczEm2BsMTnQeJ+RB6vnAHguCxJkZhCN9Go
	9SPcsTnxFB1cnumKEuwJxLkX3gTbUpeq7Wu5zOWHOnVkOo8RkcQn/7Y38zdnRfyTLS6SkbnZDChld
	ns8Z4iz0Z6Ys+sfMwObGRvU++VOIwwkJI5ln+GWefexE7lbULs+hYeas7LgR4CuAS735aBaFB4s5m
	E+B357+g==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG4Ij-0007vT-G9; Tue, 04 Nov 2025 00:49:29 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: [PATCH 0/3] SCMI clocks on RK356x
Date: Tue,  4 Nov 2025 00:49:23 +0100
Message-ID: <20251103234926.416137-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This cleans up the existing use of SCMI clocks on the RK356x SoCs.


Heiko Stuebner (3):
  dt-bindings: clock: rk3568: Add SCMI clock ids
  arm64: dts: rockchip: use SCMI clock id for cpu clock on rk356x
  arm64: dts: rockchip: add missing clocks for cpu cores on rk356

 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 5 ++++-
 include/dt-bindings/clock/rk3568-cru.h        | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.47.2


