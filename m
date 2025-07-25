Return-Path: <linux-kernel+bounces-745309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE8B1183C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B9C7A6582
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469628642F;
	Fri, 25 Jul 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="l92bYtDH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tPjZmlfQ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E3283FE9;
	Fri, 25 Jul 2025 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424037; cv=none; b=YJHPzjYhkz6nYV+AlzXVK0r8+A7vvE5RnRCVulJineUpVQ6iHKB2TOEpeRSxYs5azCg+EFir4DYoApadFVzYzWoILcIsG8JKH/LfwHHAY0v9Fz0GSkf42aCshN/yKyE6MOM7qu1UK6GrIr+UhgLBx0Ize54yV6JEg3lnIXuRSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424037; c=relaxed/simple;
	bh=w6XPdfaALrPgoTOEcPhiTgCU/BLJdIcPBFyiTUCZOqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnB2TS0hyuJh792QxrsiS7ZDxvJvWKQz+/P0uQ56IYwGlK9r2u0ZeEx/4rZIc8IZbMY6NlTy0Dw8Vuu1VDFjnlMlYk34SKlJLOBz2oXkCJyflCMj3ilImr3ovKJoQgXSJcM6BXTkrl76jfTK6pCbKKBZXS+AKjnm2w3AGTPoxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=l92bYtDH; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tPjZmlfQ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424035; x=1784960035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3Bo7hwgkDBM6nqKU7R0VFGIv7EhhZBmURTkrOYhE9o=;
  b=l92bYtDH/WhQT0n4MEpCv9AVGjh5Lv4j57DAHTIP2Jr9bFuf0OYdBlmt
   /fVvoZ0aIGUIhVRSpDhOMmjtBz+wrZHuJHPwbomMiv2DUWu38YexeiY3c
   /tOCPZxlyMt4m17gujIf5AbT6ZnGayH68ELiMy/bNIV0hxSfC8edmcgv1
   21d4HIYscxiW6OaN2Pb4Nd4FPkGqI4YsAKHdCP3PX0iebw4zl4vVIf89d
   cB34rIZep7IwFwER3ZCWJcJ9oXPUwy1w0acubWMMW9f9fxysNYkQMm46a
   EHJOo6CHiax513TqRKcz+D2PddxmBZ/Yy2CU4gVhUttnGWwZ3CS8skrj/
   Q==;
X-CSE-ConnectionGUID: Sr/Fpg8eRuKrji1bB1Ka4g==
X-CSE-MsgGUID: FPFU0K1EScKCHT8hl0Ybvg==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413013"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:13:51 +0200
X-CheckPoint: {6883209F-2C-FE216C80-D1ADDD01}
X-MAIL-CPID: D45E6833F87445DA0169DEC968CF19BB_4
X-Control-Analysis: str=0001.0A002103.688320C0.0081,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48A08173634;
	Fri, 25 Jul 2025 08:13:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3Bo7hwgkDBM6nqKU7R0VFGIv7EhhZBmURTkrOYhE9o=;
	b=tPjZmlfQrUB7YMY0hECYInTJljA9+8ujQYRO96v2k9rxOOQAr8x7IK4WOYEvosAf7g6JOL
	DOe4gotuafO5vMAlJuVIICZUVfQVLaxJ5QnZVjqc2iQetJm6LehyiYNWK6pakt6JAFAtpk
	1h4eFJ7hMI2nJBqircN2hD+QYq1pVr1vvdkiMJjoJHyjFfK4tLnA0DntcSr7hgVCfdE4Or
	2YyW99TyQExR/Genlz12o+2KWZuKEPjyOXaSLuon5Zrc8xlNvstjMAeYASe0EP0k9F+DK0
	gfFHcD2WYAKOYt95VqriRGgmyEiJEIrMxHvXcmbSO8qkh4QfIgCIFgqQb5iWWA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ARM: dts: ls1021a: Fix gic node unit address
Date: Fri, 25 Jul 2025 08:13:26 +0200
Message-ID: <20250725061339.266125-2-alexander.stein@ew.tq-group.com>
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

Although the GIC base address stated in RM is 0x1400000, the first address
being used is 0x1401000. This is similar to imx6ul.dtsi where the
GIC base address in the RM is 0xa00000 but 0xa01000 being used in DTS.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index e86998ca77d6e..fb44c76bf1d17 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -96,7 +96,7 @@ ddr: memory-controller@1080000 {
 			big-endian;
 		};
 
-		gic: interrupt-controller@1400000 {
+		gic: interrupt-controller@1401000 {
 			compatible = "arm,gic-400", "arm,cortex-a7-gic";
 			#interrupt-cells = <3>;
 			interrupt-controller;
-- 
2.43.0


