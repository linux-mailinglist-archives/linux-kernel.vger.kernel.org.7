Return-Path: <linux-kernel+bounces-793596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FFAB3D5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB151898E83
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36970248867;
	Sun, 31 Aug 2025 23:02:22 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5E20766E;
	Sun, 31 Aug 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756681341; cv=none; b=JmRBjDjeV9+bE5E83YG5Nr8pS/QRTM13J8CvorFge9Xh5FXzFoFXQ8t+9bJkB2NsWy4OVW0+79SZgFjoAGRNLgpqO7K3wtw4FsLXkIOp9lLCitI9tGePN3yHWpysDVsKDQwEF8SYs8sIpmajD+Mp6CktwQM61hAEY59McXJ1Ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756681341; c=relaxed/simple;
	bh=3LyvE11Qu5pSGMb8tir6CKwHeC6b4jd4BDYEPmgpdgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx6MchJ/CjCBvN4ngOaoG+juuIcTQ+gLjnlUc24NRdQ31AaUVMbvsVsMXwMOg0LCTpoflDsMGEeH7vVFSoDD78tKZ1BnWps+Cq8IIlZgZosGnJCmuW1/BZphz5ySnGAZu8KYalFB8Ty+sPI8lf+pw5wDPQBQtE7FM7zWe4J4Xlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 0D3A2B22030F;
	Mon,  1 Sep 2025 01:02:15 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 4/5] dt-bindings: riscv: starfive: add milkv,marscm-lite
Date: Sun, 31 Aug 2025 15:59:29 -0700
Message-ID: <20250831225959.531393-5-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250831225959.531393-1-e@freeshell.de>
References: <20250831225959.531393-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "milkv,marscm-lite" as a StarFive JH7110 SoC-based system-on-module.

Signed-off-by: E Shattow <e@freeshell.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 0713edb687fe..04510341a71e 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -29,6 +29,7 @@ properties:
               - deepcomputing,fml13v01
               - milkv,mars
               - milkv,marscm-emmc
+              - milkv,marscm-lite
               - pine64,star64
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
-- 
2.50.0


