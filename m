Return-Path: <linux-kernel+bounces-875190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12215C186F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41239504795
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A580305055;
	Wed, 29 Oct 2025 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="WaevSnEZ"
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9730103A;
	Wed, 29 Oct 2025 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718784; cv=none; b=lKpabQuzWOJMdP7TmVZHyWvLsOojvn/ATp8ONv1HioxrtKCaahUMA24oGj0RF6x2igUcHKckOTQiDM5pK8hQOWr3coJcRLANTem4NX4gWQ9SxAm7ouINtm4TRGkygH5ARW+Q5h5MwwztnpJ7Qm89PrVyocTziXCDrUvXdA6SzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718784; c=relaxed/simple;
	bh=7IRI7cKE8uYS1V2bg4Jc9AQa03FWztuEHP3zHwMpPkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JrdmAfh2EuStm4mZOeLh5HMLOxuI//OioEEluGLjdX2zVfACk3jQcLocAMwSuwXLNMpfz9tRDo4oQZRvlAg7BUbAaPGpZk3NSS4e1a1S3zYEhrJWs19zw1bQOm6/Ky8jUNu40GQ6XAVnhdUlDnZPiBEUIE/RAtj3+mCdmVA6Q9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=WaevSnEZ; arc=none smtp.client-ip=210.130.202.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;i=
	yuji2.ishikawa@toshiba.co.jp;s=key1.smx;t=1761718745;x=1762928345;bh=7IRI7cKE
	8uYS1V2bg4Jc9AQa03FWztuEHP3zHwMpPkU=;b=WaevSnEZ3HXfj24etvWDWgKc9lE4EesOCOcvnl
	CoL6V9wTFkN3HcvOq9YlzcevVL1i4lrukjCarPdlOCTT9jM8EbjFRzaICvhcwZeRIQdCQ0CUa2St4
	t4lzP4vOs93L6Ea3cZMmBD3q7r2/YYIGSoAMYIah2ASyx4LhP/A8deqYX9/FFm09cMofHJMJC3QLH
	lco+iFVTMNouV6ubrcYQDqbOHrqn5J5cfmnlZVnYq9xg2VUNpRior0dejle75aFkg/stYarMI1AOK
	KJhHq5GdzkLNliCsCLqjkP4QNdU+cJRaYqBY85+GJ4v9RpHLlDvJB+cx5sPjgTYLF5muQ5p0Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 59T6J33j2256398; Wed, 29 Oct 2025 15:19:04 +0900
X-Iguazu-Qid: 2rWh3gygZ7fVXby91M
X-Iguazu-QSIG: v=2; s=0; t=1761718743; q=2rWh3gygZ7fVXby91M; m=wSwLD5HeGHQFTolYcdrp9j4UtZ4oS71nko3BIBDjozc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxHBZ5nD0z4vym; Wed, 29 Oct 2025 15:19:02 +0900 (JST)
X-SA-MID: 53851507
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Subject: [PATCH v2 0/2] clk: visconti: Add support for VIIF on Toshiba Visconti TMPV770x SoC
Date: Wed, 29 Oct 2025 15:13:42 +0900
X-TSB-HOP2: ON
Message-Id: <20251029061344.451222-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Video Input Interface (VIIF) module to the
clock and reset driver of Toshiba Visconti TMPV770x SoC. It provides the
definition of identifiers for clocks and resets, and the control sequence
of registers.

Changelog v2:
- dt-bindings: Do not modify existing identifiers to avoid breaking ABI.
- clk: Update clk_gate_tables to reflect changes in bindings identifiers.

Yuji Ishikawa (2):
  dt-bindings: clock: Add identifiers for VIIF on Toshiba Visconti
    TMPV770x SoC
  clk: visconti: Add definition of VIIF on Toshiba Visconti TMPV770x SoC

 drivers/clk/visconti/clkc-tmpv770x.c         | 71 ++++++++++++++++++++
 include/dt-bindings/clock/toshiba,tmpv770x.h | 15 ++++-
 include/dt-bindings/reset/toshiba,tmpv770x.h | 10 ++-
 3 files changed, 93 insertions(+), 3 deletions(-)

-- 
2.34.1



