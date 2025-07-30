Return-Path: <linux-kernel+bounces-751132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD2B16595
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D98567358
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF12E0B59;
	Wed, 30 Jul 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cWJeAvWz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AF2DE6ED;
	Wed, 30 Jul 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896874; cv=none; b=pzpj8vwtgUs7q1aOyb8w4RXTvUt3m8jRP6aEuLdwDvChjByeKVFIvBbua1VeOPmkzt5fYgyQLHp39iZ4JDsq/jVJdvV9tt4iSI8Pe5RZeQZ5ZETVDsSVwXUQyb8mLxsn/A8A2g+f4XHT2afdutzsvd00YhX4ekoJWeCPqufRPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896874; c=relaxed/simple;
	bh=DyXz61zWbg9u6WVhMVh3kLqHWCICKJ0CP/61XJzgSrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwGm/ff8ed3y/7JjtH14f/f6/IKxZyzwX5xO8YwIqOZWsY1nKdi0F0J/hal0THxiZMDHPIuxmbU/q9sqROa9BqShsVBQsbnslvRJ9XGHjfJnpQ/g5khOzgdG0qRP6ilJxjfI+wsBpajAvWJbXiPzDe5UeKLEh7uuLz07Q6GamHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cWJeAvWz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=CI66QPIFtAs22mCTOpGnPQ2lw9b7T6vMF7JgaVTaw+M=; b=cWJeAvWz6TwwUZm4kL7UZ/uNoX
	ByVs+JHUkCPwick/W1bK2diORzeX0PwO2RxeP/UUitsBnHsMZRbyH087sZ6Bc/cDNTU3accNxrjpn
	T4FrPhsALgbdBt/Lb9a6D7fFGLPq3LH9eCc17ndKfkLh6J3VPqiH2O4xjRdcK4CSGGP9SMVUuHPYI
	bdmkEfsHRTSKWfnrrYA2Quw6w8p6SS6au4hOyNQNI/Y8BnTR5cWxtvgUO63VYV8cnbjK9U0srbxWx
	L38ysp2tDbpe46xhUGAr+QjYdrhb9fpuH7vhzy97Acy+TY9au7sGYk08m/huOAHGKBSueB/cERKid
	2X3318zg==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhAhC-0001cx-In; Wed, 30 Jul 2025 19:34:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mfd: qnap,ts433-mcu: add qnap,ts233-mcu compatible
Date: Wed, 30 Jul 2025 19:34:22 +0200
Message-ID: <20250730173423.1878599-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730173423.1878599-1-heiko@sntech.de>
References: <20250730173423.1878599-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same MCU is used on other devices of the series with a slightly
different set of features, like the number of LEDs.

Add a compatible for the MCU used in the TS233 variant.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml b/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
index 877078ac172f..fe9e06cfb933 100644
--- a/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
+++ b/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qnap,ts233-mcu
       - qnap,ts433-mcu
 
 patternProperties:
-- 
2.47.2


