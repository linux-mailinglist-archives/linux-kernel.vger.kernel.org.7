Return-Path: <linux-kernel+bounces-835196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9622BBA67A7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2D3BEFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39B52882AF;
	Sun, 28 Sep 2025 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wxArW5BH"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABBC286D64
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759033074; cv=none; b=Pp/Z6jh0ga3eGBVc2+jukS+gLaVY+J6FmJd3QPRu69DPtIScLfVpgbtlOP7EUOmvV0LANuYzMbqSSr2Z1ncZiQ74ppOo0T0qnaYJJIzKa52kvWAZXGPDEYskzUC+FWf0BhBuwkJ6oji8q8/CDbtuDi/JnqD9CwyFg4wzPSzFef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759033074; c=relaxed/simple;
	bh=7ScxQgggjOuHKMIReXIccrp9nn1eRhsA1g9GsW4DL/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTftSnHgnK75c8cWdUz+zLGrs9UjQB7DgRMYMwLxBCSREbDLEcXmTYE8HaqqVokdpSYyNixzI+5vn9f3koW3ZVcWk3TkyHyl0vQSy4x9iiahCbR2mZgGRyRDIGbd0x635A9ilrb8EHfoljiB+mQomcsIkf2kWB1LhbYyHTRRpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wxArW5BH; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759033060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hnJ9V2+O/9JNd2svkagPx03LH+xVK8zdgO2LOELRXw=;
	b=wxArW5BHqHrxBGaM19jgFpgoUBXnZ+ZDkD1PecV0WVtZhck6LzBCfqGvmv03vk2YBaneKs
	j3OrYbCoB7CNX+Mq4wNzGukhqvGNRyu3IBzdXfF2ixCFhi7+KmgbXNCajnCxgeoMnFZ6Ep
	YG/5Xn2i073rUlLgbTuHXko1AMhXehM=
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Date: Sun, 28 Sep 2025 12:16:48 +0800
Message-ID: <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
In-Reply-To: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759032880; l=1047; i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id; bh=Xa406oxoTdde1q8R1dFXjFrJavfAJIsCzaruS6XW7Pk=; b=v7YS7SlCqtK95zADSi3ZhQBZX8b7uh2sBKjUxosZ8j8HR4AfRgvrSaKGia287z5Mgn8AvBu/i I3kQzd2ZF5JCX2w0hGBHP0pRfcGmlRti4+l3Ce2qqdBRVEA0ytAKhza
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519; pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Document the compatible string for the MusePi Pro [1].
It is a 1.8-inch single board computer based on the
SpacemiT K1/M1 RISC-V SoC [2].

Link:
https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf
[1]
https://www.spacemit.com/en/key-stone-k1 [2]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index c56b62a6299ac24d3cdef7edcdfc407dc62a1846..52fe39296031f21d1c28c4f1ea5ca9fe28caf45a 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - bananapi,bpi-f3
               - milkv,jupiter
+              - spacemit,musepi-pro
               - xunlong,orangepi-rv2
           - const: spacemit,k1
 

-- 
2.51.0


