Return-Path: <linux-kernel+bounces-764107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201EB21E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958C0168827
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001C2E0410;
	Tue, 12 Aug 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jro6bT2f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pHx8zyjz"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BCF24DCF7;
	Tue, 12 Aug 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979279; cv=none; b=ifx43S4nVvF/U12noo81HVbHEFhUGWyXiEah4l/XT6FFyzQTTwhqKtXzJkdB9OJvU8X0vtMWEYH7FQyIHg01NpuMXBB8OqEMi80g5GJx/4Mhv60hgTjB8YRcXarsgsEaHoH4AFGF7HuXDZja+2iIBt91BkGhhdU4jV8/irmmsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979279; c=relaxed/simple;
	bh=rJdtDHuaEcSFxB8bDGOUfOgoDFidbUR4cmLJcP1mxPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+fV0soq78FtJLRX6MkgFKXpzd8vAhMVZCUlt9cMKdqDsZAzu5dIY2KJCqbOu+5Y6XBX1ZpAkAlqIYl0eSH9pPeSXv7lx79UUDVAXk+4He9iz7KLr1dr3Vb8VP02d4cTB5lrPnrxXrqF8t53G5BAbgD59RmMf2tDCg88NB+hSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jro6bT2f; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pHx8zyjz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1754979275; x=1786515275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6UYaNS6R1D8Ckv6wEelMONWEOHZ7DrIKmkHFZGHqi3c=;
  b=jro6bT2fWNBokDk0v9ImwU0V6J8PQBdOnT1ryfb38hzsjKmFWG/XYcEE
   ANksYOXEjHx0ydR9Sjf0PwwoW0oHHQzSHM2zpnv315skKceRS8D67ZE6u
   y9nOtf7PGiNzIEF/B5e4+4syxlEt6G1+48qz/8P+5EKaYlz+HIsFrcFkD
   RHKUYsH9QgDFghwpsVTjitkbb2+LjcOad1uxUZbE/77Hnwv7d6mBRd1tZ
   BgV5Ldm+FA/9RQ3gx9bvTxyUXvRSBTb7g5OrfId3rmtoIEbXJ7sxz6ZPz
   8IqZnuUdm7A8pWKyTbgxz2ylgJ+Fzk4TELNk/E6eD/veKWcyzptEALJWn
   w==;
X-CSE-ConnectionGUID: WDG2uQONQpKJQBzRerWUJw==
X-CSE-MsgGUID: cL6rkPBfRyCdak9cj7TLIg==
X-IronPort-AV: E=Sophos;i="6.17,284,1747692000"; 
   d="scan'208";a="45692354"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2025 08:14:25 +0200
X-CheckPoint: {689ADBC1-16-AD8F5F64-F0EACAA5}
X-MAIL-CPID: 752597014CB5397E9668695A756D4105_1
X-Control-Analysis: str=0001.0A002118.689ADB73.0061,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07D67165897;
	Tue, 12 Aug 2025 08:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1754979261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6UYaNS6R1D8Ckv6wEelMONWEOHZ7DrIKmkHFZGHqi3c=;
	b=pHx8zyjzAR22NvuN/y5hbVSg0PnJLGjbrseoKIy0Zl0sXA8UiN1vnEbytNEZIFkAaNE4HD
	ABR3BKJhO+wy6mt17wFL33bsmQfh/yD83Qhfa+CMN9E6SaocXEHtc3+JY0bfplRnK3xD8p
	msPrXlZ4gBdsknH1y4IusFq6RILRm9sGn3Utt71JmKgrYDMhMdpyPVz31jHA52NWrZvnZl
	uGRFEAcF6sp7Z5H3FrS26jC+1v8BUrpJuqTGerdCjz8Gba+70d9NzTC1FLUFG29xMk/j4l
	JtZyneByVLmlz/OVDWufxuC0S9NQUypIYpeF739hDL0ZRROGQj2f6SWehrS23g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: ls1021a: rename rcpm as wakeup-control from power-control
Date: Tue, 12 Aug 2025 08:13:38 +0200
Message-ID: <20250812061339.102616-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Invoke power-domain.yaml if node name as 'power-control'.

Rcpm actually are not power domain controller. It just control wakeup
capability. So rename it as wakeup-control. Implements the same change
as commit e39f567e1c38c ("arm64: dts: layerscape: rename rcpm as
wakeup-control from power-control") for arm64 layerscapes.
While at it, also remove superfluous #power-domain-cells

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index abb3e5ed7e027..29105773add7f 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -924,11 +924,10 @@ qdma: dma-controller@8388000 {
 			big-endian;
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x8>;
 			#fsl,rcpm-wakeup-cells = <2>;
-			#power-domain-cells = <0>;
 		};
 
 		ftm_alarm0: rtc@29d0000 {
-- 
2.43.0


