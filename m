Return-Path: <linux-kernel+bounces-756636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11668B1B71C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5191895DED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0727A122;
	Tue,  5 Aug 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gx5mqEmL"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12818FC92;
	Tue,  5 Aug 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406345; cv=none; b=lXJEbmaUiTpnem8WaUO/PDxCJWgmnTBfgLg/YqEXy3aaqZe7nRjHYeA6ZPi5lO5qqBv8p6zGTiNWD7rXxZzRfIAc6hnqPoRlluqGGl1mZBSOkcb6QrDiWQ8UK6h1Hegz9Qj6vC3PhsDxHLqm48bOWdgH6IPsXexBcSfHkk0fJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406345; c=relaxed/simple;
	bh=81PMYlqM/y1cobIvGWv6NmLT8uHoL246gy0zJP1C1Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCt4eQbn43OdNE+75/YfGBvP1mNA6kU93H9f6hIwFInwwO9WxWxkNMvCyucraKrVtoSU4XfrvzQMQe3fV5SHKHr3RCYJ7RKJfDSrls6HUEzTiarnn2x2/ZDjEBF9d2OJrGeQVCCdxAKrJBTrTcFYo6NGLc5BgBYTLrwDLKmhiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gx5mqEmL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4D785204DA;
	Tue,  5 Aug 2025 17:05:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wv6F2cCIqU_R; Tue,  5 Aug 2025 17:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754406342; bh=81PMYlqM/y1cobIvGWv6NmLT8uHoL246gy0zJP1C1Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gx5mqEmLGTRTCB8WYMPylE4e1nEcEm6yYwA5XL6b1xbrYLzSwrf9TYrccQENl/2iR
	 0mRQ9MinmqsNus88RQ/b3s0kxKUo6u+1mAdCyDB+VtBWk2YQWacpZa4OoGRYyvbnwO
	 vyIwL2K25PzWkP5RFLhM//JvG/VEZeJ8hlvrTE6Do6eu+coE3Lcq1JTonAisfYodRN
	 Hu78ICP2j0adzyFj87Yq0Lwehw7dU4GQxmOUCsH02jGdIvaOyxTRF0rN2jqlLTj4qu
	 a6I6R2QB5NV5wo7QxrmVZUTjicHeIf/mJbyWEkbEhx/CAGnJu6PopZyZgQgsXFN9Id
	 oLRyc1zhbrhUA==
From: Yao Zi <ziyao@disroot.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 8/8] LoongArch: dts: Remove clock-frquency from UART0 of CTCISZ Forever Pi
Date: Tue,  5 Aug 2025 15:01:47 +0000
Message-ID: <20250805150147.25909-9-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-1-ziyao@disroot.org>
References: <20250805150147.25909-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The property isn't required anymore as the supply clock of UART0 has
been described.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/loongarch/boot/dts/loongson-2k0300-ctcisz-forever-pi.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k0300-ctcisz-forever-pi.dts b/arch/loongarch/boot/dts/loongson-2k0300-ctcisz-forever-pi.dts
index a033c086461f..1bdfff7fae92 100644
--- a/arch/loongarch/boot/dts/loongson-2k0300-ctcisz-forever-pi.dts
+++ b/arch/loongarch/boot/dts/loongson-2k0300-ctcisz-forever-pi.dts
@@ -40,6 +40,5 @@ linux,cma {
 };
 
 &uart0 {
-	clock-frequency = <100000000>;
 	status = "okay";
 };
-- 
2.50.1


