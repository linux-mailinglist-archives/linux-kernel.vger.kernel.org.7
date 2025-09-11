Return-Path: <linux-kernel+bounces-811359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75587B5280A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D54659C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AD2472A6;
	Thu, 11 Sep 2025 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="aWJfl+fH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5eWwZ8A"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C023A9AE;
	Thu, 11 Sep 2025 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567443; cv=none; b=UWikWGaScH6M29V2/KHs4KvmsgZNic9s0JlVkfTdJCLCMFPcpXA558XNFLASiBOLHrLZVkF5OwprSvYo4u0fkvzscKdncWFwkno6CLf3TbkABB8Ni0mQ3FAD1EdHrJKeYMp65rE5ZABHNrTXwMrRLzEf6vS7IMxI3ASYwGg6aR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567443; c=relaxed/simple;
	bh=zF5CVd+mMJR22RbbUx/8hpHp2C7UBBt5yJVuvIi/5bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7olfghGHCKF946lwMzIsvY7bKgLImhere1nUDP3Nwq51wxGO8yzDePCuBdnyaeoGjUN99JWip1VNP0dPpRyzJUPexxV2O0e18NohV9jy4t0vIUnRdZqEebsswXwL+g9q1kBZ6a/BZllCKp7pt+Q5N8yOn5PE5andoIrSPL02YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=aWJfl+fH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5eWwZ8A; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D22827A007E;
	Thu, 11 Sep 2025 01:10:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 11 Sep 2025 01:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757567440; x=
	1757653840; bh=96KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=a
	WJfl+fHaZw/mD4A0YC0DDJOpn1RfQz0b7oDnIS4Cn3YT3DDGOx1v3BByvwdPLXcP
	+94DKx3Fh/JjnNsB6jXkxua4CtkmOxh/EnQIe7ZWMUOXtZRMFZgHCa3d4VZodkTG
	XbR5AsAnmigWVPAXoAzig/NGqJVf64wNsxz+GlnFMm1Ty9vjOHuEdrnCSYttsYtq
	cmnk9E6JasQGtKBQqp4NAbrRIIIkEUC8UuBj5ps6DyegFCzPSuSXCN3zw5kFQaMc
	2oK9HdjqR4YdLlAEEWEvpR9rd4GEZsRm1WbL4uaSJFqRJVPYdh4R8JXvN3wmKvCu
	Fsy3ZH0GSJY+l3QnQsqfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757567440; x=1757653840; bh=9
	6KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=a5eWwZ8AqMYi328tq
	iIvDYEDPtfp3mQWa+Ur0LcAfvGgtr6G48aA2a5dpxgopXrwMUltqxefgRE2wuFeT
	sAbKmsVqOp/S9wLOfHt3uS6l0bGHtupsiAQ4vF6H8jVoiASXvVytbCFI5XksTXHk
	IsY3p0my2Vbv31UyY2tzdI4iUTPrtoFCjcODDIZrAWZZfDbTuiHF4oepvoGz6j3g
	HONVJC3JG2ph7IXsJ3mdzKFDWJUB6fmGx8wKQLtuv9MLKdNj0JhsIntklBrmfT9c
	MjKsXz9t6sZSUptQsJoVFBeQOdpaWdsTQKNjOy1SLs95LlM77y6h2xJ2Wv0l+OdU
	58thQ==
X-ME-Sender: <xms:z1nCaD_CB9TG43YGVAaneaxCdz9KhcEr3RcIWQnDAxciVjO4WQM_Rg>
    <xme:z1nCaLi5F7EQmXnFqM7CBms-ZCtCQ3RK-pWgOrzaNR2TqChYVw5ENhdYnwCjFpRSI
    u7DlPjowmdbskiEbgk>
X-ME-Received: <xmr:z1nCaMac5kXWQ45oq7PRamOF5asNHOG-_IZoNxaloIPIbiJXrivhNkV-9Hm90zzjKqkUWvyACeig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeegffeuueelvdeggfdvvdfgtedvudfhfeekudekieektddukeefteetieefvdelfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvg
    gttggrsegsshguihhordgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtg
    hpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgt
    phhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilh
    grsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z1nCaI_hQGFWsU1qhnus-fPH1BiVd5n2pZ_Kp30_EZkcb2lkKSZn8g>
    <xmx:z1nCaGMapetGo919lVEcimdrpT_GODRNIXR9zZnD_30kFk0GvaYUXQ>
    <xmx:z1nCaNH_QwPvHo4_tHsqUzADeYSQYcFeMtjkoL3cUO7e8Wq8x57taQ>
    <xmx:z1nCaMy_Dli99A6M1XEgLcse_mFu7OdQRgWgNS-Vv-WvwRly0Mb9pw>
    <xmx:0FnCaFKkG9-3-SGs-M_ZnmneEUZZrdSaiDxquyQdUm_MhLIvZnLJLQju>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 01:10:38 -0400 (EDT)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
Date: Wed, 10 Sep 2025 23:10:04 -0600
Message-ID: <20250911051009.4044609-2-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911051009.4044609-1-rebecca@bsdio.com>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document ASRock Rack ALTRAD8 (ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q)
compatibles.

Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..7d5c6bfaeb97 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -34,6 +34,7 @@ properties:
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
+              - asrock,altrad8-bmc
               - asrock,e3c246d4i-bmc
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
-- 
2.47.3


