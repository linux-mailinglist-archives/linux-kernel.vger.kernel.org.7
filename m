Return-Path: <linux-kernel+bounces-744016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4215B106F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F397B17D978
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5440257451;
	Thu, 24 Jul 2025 09:50:04 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE771F4606;
	Thu, 24 Jul 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350604; cv=none; b=Pk3Yu+tAHQkIlEI4Qoc9JSrQr60nL751QALJNFsJMisxU8Kigu9eWCd5P90FyxTUL7nHPVXPdz9XQiigDly/zf+9e8lVOf0EFfKgXYZXtm4OXfAdeqgI+dG5vTc4AglKiEkpfrP117xe351dbADmSQEnEGohgikQCSgDUdpyIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350604; c=relaxed/simple;
	bh=Xdo8tfKZzksKN04rSDAoQsTANQVfalzQJEcOqWDB030=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIGE8f9QwVcfQ+GlcRqe2o0V+Scip2S0cZ7mP8QVvZ9OcTHHWrC6ZQm+liuW3wC867Dszz5TVrVZXYkLdFWg6o56GZnkMhDFf+YFRFshZcYHb/i3tTQJ93LvQec87q7moF3EZXjapafJ6OKa6pzaimqg4vvglb1NBROQDROZGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 0DD9EB4D00E4;
	Thu, 24 Jul 2025 11:49:56 +0200 (CEST)
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
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 1/4] dt-bindings: riscv: starfive: add milkv,marscm-emmc
Date: Thu, 24 Jul 2025 02:48:44 -0700
Message-ID: <20250724094912.253723-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724094912.253723-1-e@freeshell.de>
References: <20250724094912.253723-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "milkv,marscm-emmc" as a StarFive JH7110 SoC-based system-on-module.

Signed-off-by: E Shattow <e@freeshell.de>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 7ef85174353d..0713edb687fe 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - deepcomputing,fml13v01
               - milkv,mars
+              - milkv,marscm-emmc
               - pine64,star64
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
-- 
2.50.0


