Return-Path: <linux-kernel+bounces-581096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F34A75A86
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324D03AA042
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93001D5AB7;
	Sun, 30 Mar 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KQb6/T0L"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F3322E;
	Sun, 30 Mar 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743347660; cv=none; b=RPPlS5joeObhFFoCU/tUMVa/+zkBO9Ea8nvU4+z+WP3GWNv6g38CYwyAl9P3QgiRq3Mc9gN19333yZ26UsCd7JxqXGsi3KG/PeQDwu5ixXLofPPLhiKAQrNvCxXrRQs8/3DGFnNGymEK7kKx+nFfIPCzftCyoi3Q+cpeCAj+v80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743347660; c=relaxed/simple;
	bh=0S0JVmGimss6bI8ZswfpiGICJS1c1WnVmILnqr4IG00=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ttCN4Q7PYMuKztvUG7s/W6ihq26+NLfp1Q5UuQTWpelP9xapWI4n7TJ6dn5Ak5z7iAoj9kRGLTPruCyuPHO+ApE2OEhJofbFIelCyuCoTtZiROCnXX3nMqe5ocr7nuupnjKXTvGWyv0bZwQLw1vnNa2kcgUsR/nCAjnlHrPVi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=KQb6/T0L; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Y0hXJwIBM2ilP1IpxE1erxywqM6MiP6xhnP3+D6gWCU=; b=KQb6/T0LmIv9pXO9H3PRz6FX6N
	Xmof7ziV00+01fUzmWuQspE59INEM0bnBRK2KcRPOUPe6l2TzJ4jOZtxnG+/ZHE+3d1pbTj5ghjux
	Y/gFLPWowAPdIXfWpNokrLQVI4DPrgS8C7MAIvqwByvdb6WHaa02A2zEo8cok3xX4QSVVNcFSY/WM
	vHLRvSXyve8Q9wYci18wrTlx1BxLFO1qQv8JX0Fea328MYBdGO/qYZu33p2p8TQW7q2aIqBaCUNDW
	ZDxeu6+WBwiUau65Gmm7bLFPS4IfavFAbqotQuvXYVRRtKOggCtdt0Zi4rCzh2wcK16wduSBeeFhp
	JKAy5QGg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Rob Herring <robh@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	devicetree@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/2] ARM: dts: omap4: panda: TiWilink improvements
Date: Sun, 30 Mar 2025 17:13:59 +0200
Message-Id: <20250330151401.444956-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add proper definitions for 32k clock and enable bluetooth
everywhere.

Changes:
v2:
  - extend comments by trading in checkpatch compliance for readability
  - remove one unnecessary newline

Andreas Kemnade (2):
  ARM: dts: omap4: panda: fix resources needed for Panda
  ARM: dts: omap4: panda: cleanup bluetooth

 .../boot/dts/ti/omap/omap4-panda-common.dtsi  | 39 +++++++++++++++++--
 arch/arm/boot/dts/ti/omap/omap4-panda-es.dts  | 32 ---------------
 2 files changed, 36 insertions(+), 35 deletions(-)

-- 
2.39.5


