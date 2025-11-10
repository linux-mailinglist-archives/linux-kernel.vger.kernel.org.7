Return-Path: <linux-kernel+bounces-894242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A438DC49929
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C6E18842D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38E33FE24;
	Mon, 10 Nov 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="sLaXz4b6"
Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93654333730;
	Mon, 10 Nov 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813540; cv=pass; b=SF15kib+J1D3jqHRut2BtOZEtUAoS3wCYUWuHX1hfLF5fz/yREl4zuNfC/5Y36mTWXw/CsXeViU5+c0kz0Wq6cvDt61I044sQJrt9MHCOVaROoEVkv4VyTfSe4CCKxI1LK78kbQ/ClEMflKRTzY5QunD4I+Af8cb97yWTZge8e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813540; c=relaxed/simple;
	bh=CiXjRnp4/+6UB9oDhNwLpZHPknYGlmH/xEkMUzF15NQ=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=N89ydReGhG5oDV5hzf3WGuBfLVHqVIziqkNUsbX+lyqANEawihFM/TAinKsJwqFQOEDWmF6Ay4cmxaR7CXrrod98MYQ1/oskrB39B2gOj2w7onXS1lIMqLVjDCmYrbrrJfDYE/vl3Fg9Y5YTDmgGw9voBljpJ9ebsjx8bLe8o9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=sLaXz4b6; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1586E721F04;
	Mon, 10 Nov 2025 22:06:54 +0000 (UTC)
Received: from fr-int-smtpout26.hostinger.io (100-123-217-111.trex-nlb.outbound.svc.cluster.local [100.123.217.111])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5F9B3721F21;
	Mon, 10 Nov 2025 22:06:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762812413; a=rsa-sha256;
	cv=none;
	b=P0OmOKroYME9rn0jlx/I4YDK6spwy3J+RhPoAPcCUhRIHlq1iNPHQ1nG9xA1l43zShFBe9
	K3vUrh92hKMOTvODFwwgITWMt5ELBu8ofKye78hJ5lIucFJ6AV6lWXHvntcCJ+sYx+oWfe
	uuwGS/rs+V73IXEMP4WeuuDdCuvAUarvI0jhW2fweZfwlpKCa9DOugRcX9arP8DIDBf6le
	UB78gDy0X+DOFuo/kpQPbSGZXtQI+JkEsf6jpzCoNnF+/8fPzYurRBGXKPA4qj9WIUY/SB
	xAENP/ChDWyZ+HhJmuzMRPJwOjBm1OYQHy8jhV59HnW5ANucHU/TuDsioK9NBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762812413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0Kc2cGqghawWgDT4UIWY86Y98oRPWDu+9tb+KQMDdQY=;
	b=JQ4XtvB03vG/i0YphL04NoIYXtwQdZx9yRlxCHMbBtN9Vgz8lk8cDA9LErzoWQk6+Krm/O
	6se5aoJZHWAgwNQeT+d7nn4tsFSM/ky4NPlQhiuTRi9Qpwf8gRoPLNZzP18x+vZiZCvrs/
	Ir3Wfkho8NeUc4hU1B7REb6n7Kzc8QH2w2521zEVoD9Y2HwCQj5qdgp1OAQVItW1SgWDjW
	nkCWQ3LHykS2MdBnqEA0VFJlF1IePm8wAhI9Tphq0SAL8wpG69OjvKgIC4HGGJ1sWfQ1NW
	t88z+z0ab5HsG0RHd/4Zo4AyqiRg6zuVdUm+JnvF5pTrcfHbsCJAgma0M9+rFA==
ARC-Authentication-Results: i=1;
	rspamd-77bb85d8d5-srwqq;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Continue-Befitting: 0cab41722ae4e3b9_1762812413903_1501683741
X-MC-Loop-Signature: 1762812413903:1491620757
X-MC-Ingress-Time: 1762812413903
Received: from fr-int-smtpout26.hostinger.io (fr-int-smtpout26.hostinger.io
 [148.222.54.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.217.111 (trex/7.1.3);
	Mon, 10 Nov 2025 22:06:53 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:31e9:b9de:fe42:7704])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d53fc6lmKz1y02;
	Mon, 10 Nov 2025 22:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762812409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Kc2cGqghawWgDT4UIWY86Y98oRPWDu+9tb+KQMDdQY=;
	b=sLaXz4b6B5pmJ9QPNIOp4xc2yCHCIBis4XEMNHVhTwqQqXUaCF1U9VrTXdcDpseKurpuw/
	cKDazQJMdsxOfr+N+ZED5mLk5UM2kU8cTznckQrDqwZSO0GzjTo5wz2ZCese+hICIe88KY
	+TMw/eachL4HF2aOop9V5PwVPsy+kHsd6UVU9dJIOM8lyNipzn8eOX3WlvzStnnQCbD6xj
	fhPFlRScRwHpF56SalcfIc1auFITj5MsQL3FR+Gu+/+4vmbVJRh63QY8flJiqTstoF0rlI
	x4GK2aDeXIYHZDA/6xVG5fjErCLNeqqPHsYPuFtgUNROGHdZCMLqofWroLsexw==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S board
Message-ID: <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
References: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Mon, 10 Nov 2025 22:06:48 +0000 (UTC)
X-CM-Envelope: MS4xfKP0gciVqc2IA6yni3wIkwZuDcNJkZbkAZhCjphAKff66NAq6961DC0WcO0J8Q8w9WXhOvqC7zYR0XKq53ctAvp9tvKLqhcHpsufdoY/LtCUzvmCUIUn Nu5qfkiSPtZfqI5k31+XZ+QRQ2lz81v+9WXYIKhpnhxuXIBd5i45VlZ5Vwlh/CB1XICBNylW7T05VlV9uYfnSorHDR7cken3E3F09gwXGttBJcJu0WbKa1qQ 1LPtmoLHQ3eWwB7DB2c5nRSHQHSzvb/mZYW9UxRCpiVVH9OEWhj9nDDEoOPd+d4N+VDl8m2WCf9xdHejyHzguM5V/47CithR1ph60gPYNxOW1DaPPwNUsm9t pfpDs4wkMiHPOWErEr2/gmDpSmL8uL/tJXaL5UJlXyBaV3RrBiLYahyXUMY3jH0thZrGXt7JULGH2Ea8BWyhZ+2HtbggE3ytxCsRtxWdllbXem5wsE5zS37+ jDvtCs1stNb8QvT9D4eYLTaRiT+pAn7qWG3SgqSR0raA5IZU+nXIojg0e2KZf4AQUUuvLzOOFBq6+XBdlYRkUE/GYd/X/P7/NDi+Lch/ddyvfTL7+TjrAIFz Cbiec333lkJhWK5bss1GXoBKEubuh3rOa13wa3/wv/CpSmhWQdPSmF6e75Hpj4zPKakZg/ZYOdUwgTKIbiP1Lc7aePzVTbOA5ZFSr3hoZfrEiN5RseS3UZ3w b0JDSZRW+lI=
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=691261f9 a=6hOvbz5PeP13GDnUra1LTQ==:617 a=xqWC_Br6kY4A:10 a=5dAzR5NRAAAA:8 a=lv0vYI88AAAA:8 a=d70CFdQeAAAA:8 a=ahLzFxuTVLoCwVWoPR8A:9 a=9STjDIb-X-UA:10 a=ZKAZAlVgJm32z6MX8p4a:22 a=9qqun4PRrEabIEPCFt1_:22 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Document the compatible string for the OrangePi R2S board [1], which
is marketed as using the Ky X1 SoC but is in fact identical to
the SpacemiT K1 SoC [2].

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 52fe39296031..9c49482002f7 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -23,6 +23,7 @@ properties:
               - bananapi,bpi-f3
               - milkv,jupiter
               - spacemit,musepi-pro
+              - xunlong,orangepi-r2s
               - xunlong,orangepi-rv2
           - const: spacemit,k1
 

