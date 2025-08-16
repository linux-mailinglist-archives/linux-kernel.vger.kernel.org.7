Return-Path: <linux-kernel+bounces-771872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC351B28C79
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94393B008BA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B7245014;
	Sat, 16 Aug 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="TJbQoUnU"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81845244691;
	Sat, 16 Aug 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336774; cv=pass; b=thIg7Qn6f0tV8yK/RcTzlLJLYLU+q/ZOsZIuzCQvL/ZajP3hePCZPiC7v3D3vEYHfu+nXvLecaF7YrfUFmZGLxscvT6X9WHuYVeOyT7KnfRsBLH/izDFTAIjO7L8hsPXSTg6DvZA70wDNUXrj6wsL3FLkZC53F06lR7oMpCNjqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336774; c=relaxed/simple;
	bh=SQaJfpbOWhDFxw/vqH8oWMx6lny/nqo3qGy8Iir7Id4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSp+CimOxob2BsskJhL0nMfMA1hObzMkkGWgscOh2HrxPBbskgAjb4GXsFk5LuwAC1ws8AMft8WWMK4ZhtggAYoTFzCYE/Ay5Cql5Sk0OQOEb9z3Qi7gAQnE5QuUZxwlPrACNbVW4z0obO3xZpG5l7/1EkXjEbjwg30lwYqOhFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=TJbQoUnU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755336761; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IFGvuJ8lvQ47tTBEVUAdX0EMfU/jJwqJWgb8t5ai1WOXnBahXZdDgaoHFvE4iO5Bjih2/RCmP9sryRNonbVtHi/o9Wnjs/GFUCnoCmnVLhmLfaGAAxag7zcPJGaK/8xtakV3j+OsgDUG+GgHKKnPJ24E1NdNV/icABhnlWNvDX4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755336761; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=676VaJ+6XPJQ19N0s+B4LHk5NDzXy0L1JDDJG1OA/hc=; 
	b=JYAOxKura0Xequ9nHFeVceG9RduOk7u37kRuqoZVGIQ9ICQMlr87YDJm5/2swFZH31UEJhAXjIZ/3rph0SaAP0akjdgsDumUfdJg3mZF6/+X9Ngb+QpVtWGjdCa93uuyGP0jxEbbhhVvWYZdckLyUDoMOwBQ5BYj0w/Qnjdl7QI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755336761;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=676VaJ+6XPJQ19N0s+B4LHk5NDzXy0L1JDDJG1OA/hc=;
	b=TJbQoUnUoRMVg3mCyf7lnga9ZABZn9QuvnZsd0MdJYuL9fscDUIDMcoTLozPeJAl
	wI+L2e/ztO2AGedGaTkFPOV/bFGFtDraPqldwNY5vNotz6A4bcZksrGBI4A5sHM0uYf
	EwibAL5fN/qBduk2IIbhzEcu3c+Oj+N3F0IpEmCep6GEf+M4arv+HWMAeAsKYk/Aao2
	rBD3Hk7qxeQps/8Fima92PhMOAxGMSp7RVzi/DKit9bbCGpOQzBuSPlQYvmDcDzGGWK
	xdGBNpvqTBZC9XcsWnF5hpxFeTcBEbtD39QHsphVbpWuaUaTDQVC+HD5rYj95btEVon
	9uKs/BaPyg==
Received: by mx.zohomail.com with SMTPS id 1755336759129283.67420191087547;
	Sat, 16 Aug 2025 02:32:39 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/3] riscv: dts: thead: th1520: add coefficients to the PVT node
Date: Sat, 16 Aug 2025 17:32:07 +0800
Message-ID: <20250816093209.2600355-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816093209.2600355-1-uwu@icenowy.me>
References: <20250816093209.2600355-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The manual of TH1520 contains a set of coefficients a little different
to the driver default ones.

Add them to the device tree node of PVT.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 03f1d73190499..e9c81bdabed8a 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -676,6 +676,10 @@ pvt: pvt@fffff4e000 {
 			reg-names = "common", "ts", "pd", "vm";
 			clocks = <&aonsys_clk>;
 			#thermal-sensor-cells = <1>;
+			moortec,ts-coeff-g = <42740>;
+			moortec,ts-coeff-h = <220500>;
+			moortec,ts-coeff-j = <(-160)>;
+			moortec,ts-coeff-cal5 = <4094>;
 		};
 
 		gpio@fffff52000 {
-- 
2.50.1


