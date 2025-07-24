Return-Path: <linux-kernel+bounces-744018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75049B106FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B855401DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159D525A32E;
	Thu, 24 Jul 2025 09:50:21 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83372566D9;
	Thu, 24 Jul 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350620; cv=none; b=sHZvKiTO+Fe+ECvNzC2aRmRtm+RFrM5OeEHndeyPJ5B2m9MchGp/fgCEZwUcOvqwaFwL1SZ0zupAEdy/2BuMQXfLXxzwdjJ47RQZs6ExeAOvw+XUgMWT2bXf9KHRzqrrSbfzSpmN55cRU/AJPb8ggIYhh9g5bqz1ciw7XZWvMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350620; c=relaxed/simple;
	bh=eKPwLC6suTl8LKR7YXTDenyAa+IsErU2lpYt4JIQZow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvuwAvCOg3D58zOOY9d3ux2ImdYll6weZ3epJ4ochsP/4f0YW3ZOT3uNDnyQSeb4oy97Zjv9RF/HKNUeNlNSFZEDYdd/tCKw8m6ONbjFKsYf2vQcf1/dzsXSGyoGLzH5CaWio3Fpz1G6uXzH8YtlH1XXJY1rn91uEOoIpu/XlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 7A16EB4D00F1;
	Thu, 24 Jul 2025 11:50:13 +0200 (CEST)
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
Subject: [PATCH v1 3/4] dt-bindings: riscv: starfive: add milkv,marscm-lite
Date: Thu, 24 Jul 2025 02:48:46 -0700
Message-ID: <20250724094912.253723-4-e@freeshell.de>
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

Add "milkv,marscm-lite" as a StarFive JH7110 SoC-based system-on-module.

Signed-off-by: E Shattow <e@freeshell.de>
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


