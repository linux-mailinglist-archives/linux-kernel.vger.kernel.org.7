Return-Path: <linux-kernel+bounces-745311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A32FB11841
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6E21CC5E88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F45F2874FF;
	Fri, 25 Jul 2025 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NMw6S4jW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VKgRbOBf"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC06285C9A;
	Fri, 25 Jul 2025 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424046; cv=none; b=RgsCbpAEoVyB9lpE7805rXvGM/ShvNChhiMrYOFa+7EjjA7fowMsEr0a9ND9zdqj73BECx9IgfJs84z2Va1fCyxQH+LcivyfnOfHLA1McgHc4/54Ruv3eYxBZ5PFzvmLbDgcV7YSVl4sE7Wd5+z7w8GxDidp75mTIDZa0Jc8EJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424046; c=relaxed/simple;
	bh=dSjyYIv+TPTElj8K2YAWFsBBTksvVTg5TxN8ZoyCTg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWq5URl4SvzweTR/OiOtv4d8f4ASYqFVWSMyN+6TxAzAKEUYNFeVVFZgoau4pRsHoY+77ospzyuRZ3NfeVKXq/vf+6ySk8QtpM72Q4A+zkooaOyZCOXrHrw9m+cqm8ntSe7LXv47Pj0/UZKvIpkqN/jEsSUekGZtl4O/vJ71Tbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NMw6S4jW; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VKgRbOBf reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424044; x=1784960044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3VeMp42ESkf25czww66+dfndbwWYSien0lEceFj2a4=;
  b=NMw6S4jWkx9gc2eiAl2Vc6jMSNY3RVaKH5ipMvQaKvYbzJx6X7oRMoQa
   T/qlb8P3+8Nu/0vWsnribx2/FMSbaXqVIffFAvoly3vVDz6Cw9rq3qUdo
   P1UAu+r7MxHOXi97OVPI3pZ3pT0hMmZrMqnz/q5u0yUNPrRiWN7+dt1yI
   hJsnKUszOOLRUQAoOhagAZCIdWTzqURjPp77YlJGDJVj7vGlDWSd4JDWM
   3sW7ZFHlQsQYZRUZjHt+g4BYOOp6+hotN4VIxohwg/UBjkIAub1iuUja2
   7kJqOqdnmF58+GRgv7JS7ZyfGMTj9k6WCsQlqtjkecfjPVNzSNi3G67Y6
   A==;
X-CSE-ConnectionGUID: +yqKvMIWTg29agj1eC1cJA==
X-CSE-MsgGUID: tea+HRQtRMqPdSt5JlwgiQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413019"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:14:01 +0200
X-CheckPoint: {688320A9-19-943DFC15-D71A48EE}
X-MAIL-CPID: 688F6B9749C3A52304DF6AB48DE50F72_5
X-Control-Analysis: str=0001.0A002103.688320C9.002D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0DBD17364E;
	Fri, 25 Jul 2025 08:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3VeMp42ESkf25czww66+dfndbwWYSien0lEceFj2a4=;
	b=VKgRbOBfAGLHAiOst+BvMDIRPae4Sw21OUFWKdsiZ+B6jRbbEiXbaCOxpk2+1tSl2t1F3+
	GIUKZIxVr9oo9ATsiGldxQ8U3wpImnymyOqe5UYPX1AXui/pydd9BZ9+CIeI6d86Mjj6c/
	OOW+aISgwA6C7PbYbBP7S+PawcKKmavZZNjS4RW9uw1MqXyYyCGeYeG9/U6ZkO9bMgctz5
	KfF83ZzWlRLbGeNcidA8iSVG3+oZWWqBzKo4PFosiPWordoouS278JjbvqBReX+Yc24Ceh
	6L9EhGjWzcoKj4cdMlkSnj/UJWF6GkIKG5L47u+GhvkPp7WTtVv7QW1T8sRNDA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] ARM: dts: ls1021a: Fix sai DMA order
Date: Fri, 25 Jul 2025 08:13:28 +0200
Message-ID: <20250725061339.266125-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
References: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

According to bindings Rx DMA channel comes first if Rx & Tx is used.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 74c5698e0b314..2351374c2e107 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -627,9 +627,9 @@ sai1: sai@2b50000 {
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
 				 <&clockgen 4 1>, <&clockgen 4 1>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 47>,
-			       <&edma0 1 46>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 46>,
+			       <&edma0 1 47>;
 			status = "disabled";
 		};
 
@@ -641,9 +641,9 @@ sai2: sai@2b60000 {
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
 				 <&clockgen 4 1>, <&clockgen 4 1>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 45>,
-			       <&edma0 1 44>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 44>,
+			       <&edma0 1 45>;
 			status = "disabled";
 		};
 
-- 
2.43.0


