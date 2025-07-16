Return-Path: <linux-kernel+bounces-733645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71193B07753
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68D61C40136
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57F1FBCB2;
	Wed, 16 Jul 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkVlO+4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507E14A09C;
	Wed, 16 Jul 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673656; cv=none; b=mn2f0I7w0W5YDQ+ts9ZuSqHcfaZrGqIq/oB3uW5wQPMq6zG0lX3BLkzbWuH4RmN20dK1d1c1tYA95K7ICkO4sYMBIHXIBC3LMA2Nbp3gejpuGJGvLYUdeFJcfEc+kvp/Wf/ZnHO3Sp4HcGWovS7QDpvTnuX0aZchU+b9J8U+9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673656; c=relaxed/simple;
	bh=ckGXL7OnCquHJZR35uviuEeY5gCHUP3bzsBXwXjI+0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHDQcjgjxeEFm5TOeJ+PAvhx6gXf/7PPL2ksivi/b0Pb1HtFrittxRyz7PUbLiZURP96NkGNfuyY2MaDKlIZIP0yOrsr0ZMD2iGcGhRkV474+FIiYkwDPZLuh34i7lsTmUXC7URDS0Gqq8rf8jnLpv0q8zGEmxivK54wg94/IzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkVlO+4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AB3C4CEF6;
	Wed, 16 Jul 2025 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752673655;
	bh=ckGXL7OnCquHJZR35uviuEeY5gCHUP3bzsBXwXjI+0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkVlO+4N70vvaOR4LcEIwuRDgywvGZlQ8KIUGL6gjE+HG/mYoCESDTgdxydD3imtN
	 GdVmDJbiLXzxi2GPhVouo8T+u82o9akf7XpKWC+Wk+KBpD4mxFTs91/DfTT7OdIUKQ
	 oT4dvON4FRQrVUrmlxEtxVSlAAutXlGjrdsPpOmcyupVr/Dz+IVWsbHkIRlAPMY5f2
	 EvkGsv4AS+RDJwUIYgS3bhIpGBcsqf9b5byfpalMkeS2QOy2bYcl9bD+7N4+azH+8S
	 CiImB9iPu5oR1yv4fVw4WtHBuJPCWCI1x+6+CIa/frE2fgil6KS5H8A9Kg+f38mGQM
	 bxvyhFGJ5iLKw==
From: Michael Walle <mwalle@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [RFC PATCH 1/3] dt-bindings: gpu: img: Add AM62P SoC specific compatible
Date: Wed, 16 Jul 2025 15:47:15 +0200
Message-Id: <20250716134717.4085567-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250716134717.4085567-1-mwalle@kernel.org>
References: <20250716134717.4085567-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AM62P and the J722S features the same BXS-4 GPU as the J721S2. Add a
new SoC specific compatible.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 4450e2e73b3c..bad3e412a168 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -23,6 +23,7 @@ properties:
           - const: img,img-rogue
       - items:
           - enum:
+              - ti,am62p-gpu
               - ti,j721s2-gpu
           - const: img,img-bxs-4-64
           - const: img,img-rogue
-- 
2.39.5


