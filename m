Return-Path: <linux-kernel+bounces-847669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E6BCB621
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4352119E6B11
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A9241667;
	Fri, 10 Oct 2025 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="EYKNvOa9"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E830224245;
	Fri, 10 Oct 2025 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061430; cv=none; b=Rl30nDzeaG6WLDKtx+p2/reoLXNlZRjGj62Vhj4LV6tRGWCIeaD5H9nrxAfkEbxwB/9UYfDTkv4Zjw1aDAmJ7dwfRxAQhG+PGqzHbomzPxBwD+7Tbh5WHTcmYl96tWQNjrhS8gDvJU51e9BN7GpXmIqZae8djdeeDohCCI9gSUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061430; c=relaxed/simple;
	bh=U7VjtgukKmMhZ4cuasC3YXbNoOHhy+YexBytY8tYuCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjoG4+TQaTDBYG0dcbJLpY6GFyOYMc+9ZfafW6s/FnuWBKQuLcrrrQS0ZKf7HCtf+9JqNyQ1CIBJJoYuM0JegHG+wdl3I/jw7qX8dbl4RYf2TRR3/vspcd57uyUBZMrFPSck3XSd7GUMzlFvLoNG89OXGFP3hOSLgFDHyQacdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=EYKNvOa9; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760061421;
	bh=D/ZVGW0hNqbZhxwdszE7Ij2oSHzZLYG5bnLOtSUUxeM=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=EYKNvOa9HNJzdVp5pa4OihOWLO3waakDmLbJE2+sdkS4/Ak/XSLukpSSD5wgAnn4Q
	 tesAbnPXK4ZxbthuKOQM2aP2Nq2TqFwxDmgZagXoIPM49m89yG/X6zf1pFtcK53gD2
	 wyOU9szVrTJovAI5JHHBTMmesPBgCl9ZudEFqkzo=
X-QQ-mid: zesmtpgz3t1760061416t43febd1a
X-QQ-Originating-IP: 9769BgJ/clbn0uKZisrylxEVb6PrybtCFGhIQmMwEq8=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 09:56:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14237210305398404918
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 10 Oct 2025 09:56:33 +0800
Subject: [PATCH v2 4/5] riscv: dts: spacemit: enable eMMC on MusePi Pro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-k1-musepi-pro-dts-v2-4-6e1b491f6f3e@linux.spacemit.com>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
In-Reply-To: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760061399; l=799;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=U7VjtgukKmMhZ4cuasC3YXbNoOHhy+YexBytY8tYuCw=;
 b=UPp7YQsoKKFT1kvwameZDI1dky5TTwfUNCaH8fSP+rO1EntP0eXTJTH7KfWfffe41RQZlMdk+
 XBB2mi2R3rzB2Fw7HZs6OrqWAz4q+XXM7YaDqR6qDrtiwJkc2pgl3/i
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OCBj5Amv9vLxfoNH/4RsKeI5o9w4nFtvGDSh00wm/ZdzAY9Ft7xt8mc+
	B1FYCpMzVBmr3z2Nr8JFxaiWRlfW4BGSvX+S8U8WaLO4vgDlkh3aE11JP2RdxPEvXn8Ifkl
	x0EGLhO4Hu/LJIcBxcniSBwI4ka1B1yJPrUt+rX62B02UWrdLQx/S83d19nlDbmBHowb8UP
	+6qJ4s0CRvyaZaI3bU1siT/pEtzeRQNVRVWxCSO6kc760YJvYHhzKkFN+2BWYc6/tC7nCm3
	DjgpUWxlOMw3KKmGbtXDISc8KkdQw20V/tY6b8ANN8187pX6zFMDIOmJN0tlb8urtLy+E72
	1qtRDSErEI1MTbeCT0Rnrw+iVxaPZhyMuw/1qyogLNakgCXDe4vo59/mf0HNwTw09LaGdEn
	oP0gtaDI63DabmxmyNaVczzv9ARK5eU8coEHMvftsaJ63hxjG7m2JkWt+LuuDfugWdOB9zS
	TSmy/fAINCQfD3yWWTkAO9phC70PQGtaGXQ1GMakV98ByYynvZWTZI0Av9sFW2RHfNnxpkE
	2d8B7Su2+8e1sYG4fqHmS8zRHqbjx12SSmKSzstAMLb6fxGIpYC0IdkVSsFc9tRI0VLraE5
	a7C/BTHfmLTs6ccXp6L+rM3RkLWIlFegqrotEyl8uQvY2DcQN4o+zziYmw7EIWrnnk08O2w
	Nn0eFdwy/StExn9AlsccrlUwhYZpMKkbSFwaPRG+FJI/0UH7QV7WYLgYs0jVhu6BMD9i3sK
	Lh0uVUokNor0kk1goMmPWoa0+xH3mL8hQPuSo6ygfWibGdfyTxK9IGejuXFyQfHi0bbEQGy
	WlKWsSAtmkXOseJ/9mVPAaT6JvtDuXiJtnc0p2lFS6KsFPf/5IRyyZsbl3FfNid+TYviYQM
	gBSmlcXL6kmNfgAIWwjpzB3ID11K3zRAdCDB+vL4gV7tmWDmrxPXCKMQGNf65OciU3u30Xp
	7BBY0OTGk3p95hyW31WIC87pWpQfMFQItJDGfsjcnGSzfsr0FqB21mpHxLKKAg3cmHGxXCq
	UgE8E8GePXZ4QKBq8Zlp7suoU/qeii/7Dbhxp3n5IJAunHLPIddzD9YaPtuaiTIOzQ5LeLw
	15kj91QNm8M0QuYXQfBMmuwdOLhSddkpYYIfuonspxyVAN7yVdVChfwsWHhDvoXCw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Enable the on-board eMMC for MusePi Pro with 8-bit bus and HS400 mode.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index 7ca3375910a3da8eaeaf1a7d5398616d928aa875..89a35914710bfd15c6ad27cd8d0de7ccf62e2309 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -33,6 +33,16 @@ led1 {
 	};
 };
 
+&emmc {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
 &pdma {
 	status = "okay";
 };

-- 
2.51.0


