Return-Path: <linux-kernel+bounces-821455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC477B814C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91AA1C80E38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BE3002BE;
	Wed, 17 Sep 2025 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="aroz2qbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbjkGlUM"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF12F9DA1;
	Wed, 17 Sep 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132279; cv=none; b=rjf1xew+b3T/3WK4RurzJU3mzgfonjOwp7dQOvR5tRaQ9uv7x6eEgGhssdDfFz7pIWvAZ+X4ScMfwnIwyFegikarS3lvlhLOz5adUvF03MHYVHFnwmVrv8V1VZU2O5KFaioz5bIgITWobWIJOisnosFkTTXfB9oPPnjyGB4AM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132279; c=relaxed/simple;
	bh=zF5CVd+mMJR22RbbUx/8hpHp2C7UBBt5yJVuvIi/5bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hbs+5V+iLJl/8PS94FLsP9JRJtCxd8E3tw53VOM5/IiX1KFkFxBE0oTG/FI0P1196OMuSJCAX3GCHQvMsY31HQcQkCRSg3ggTw64OlVi7nXXRqt2j6J/ULPGYoRTq6YiYq1qOD8iU6AHlt5pG1KJre/n9iuw9KiSwxt3B4gt8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=aroz2qbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbjkGlUM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 36A80EC02AE;
	Wed, 17 Sep 2025 14:04:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 14:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758132277; x=
	1758218677; bh=96KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=a
	roz2qbLh39Uro22WFxx12+H1FjHb/XWmkihYk5sG0MKDuGyc8HsHXVaDQRi9X+z5
	GiJSyTWV/UIWmw+LU/MNMWaeT1Jkoad3QyudTSRmw8vulEyjMSDFtNW0+vxOioVP
	dz+OLwp8NMmatF5lIZYuvh/3oFIZ9CQvM53WE31hGupYhPfnvDG1feitmL5z+xOO
	lceZZBWEG3bCefAmggqFfeppT1IFZ8h1W/ytxFBGrPMblTJBfXs5syWIZEhgwpkO
	9gxp6cvZ3mDTM+NkdzB7PZIBsz4Do26OabZuCkVMblvnI6FViqMa8M1IexgNuwp9
	2GPfZptAWa/RuOmm4fnVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758132277; x=1758218677; bh=9
	6KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=QbjkGlUMrqFKvLdZa
	u+CtFuI4OHpuwg5j56jSE6wwSye0Fxe4/fyNzmtkXj71nOB1qC8BNseHGuXKN/qy
	O4ocppJWVYJCqzdMDEMQKVXlH1FmG/8K4Rq47Yq9YmdOTbuRvCVggHdRJyqxQMFW
	QJDasKmWMjtQjqGWRUcYTE2WNHNjZ+e2mjGpB+urGCxfEVqOFv3Y7ZztJdZlW4mA
	XoyS4DOHrF/QfOYAC20bxfqmS0LiSGSoW9uOaoHQLJ/42fLuR2gEocPJ/mHUiQuy
	c2wG5OYj8cjjufF1T0igoPg5urKs2usyzSxNy+A2cpx2Lrl29/2BBGX5IKyOeJ47
	EwvVA==
X-ME-Sender: <xms:NPjKaNmR8g1Yo8teh1NYvfw0se9-ozpCYVLg3qPsjDUfUH5zyL3u-g>
    <xme:NPjKaIAqKFEL9ghA-mBSHePqCnFRp76SkcSdjLdY2fjCI-MJSeKV9XL4gmWGdrIed
    ag9CvSpCc6ZCtvY6Nc>
X-ME-Received: <xmr:NPjKaGWDeo_WnyFZpl0THchVoNB9wbPQcj_yL33-cpnfkAh2Alo6TWZEFTD1mnuCwM43cu_MO0wZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeduvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:NPjKaG_po6iOZSwVj7Unv_8UdhucGnhD85QxYx2uO4TvKZ5CZK2F9A>
    <xmx:NPjKaIRbhrihadeXI61DN9EIlLEoUx5MG7A5yzfogf32oyj1htEz4Q>
    <xmx:NPjKaLQlqGOHZcshpRN5BQHfIn9gAFU6UM3gICiqs1oFVX0zYK8gEw>
    <xmx:NPjKaE6XZoUQoQjb_cjDkbFYoLwYuHUFo-ywJQWEyeNh6C0QUIk_sw>
    <xmx:NfjKaGX1ZqKLoEO6WEIINu7iwQXkNoZ7oujs4AO83-JyF2QDoTh4cRby>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 14:04:35 -0400 (EDT)
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
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
Date: Wed, 17 Sep 2025 12:04:25 -0600
Message-ID: <20250917180428.810751-2-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917180428.810751-1-rebecca@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
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


