Return-Path: <linux-kernel+bounces-816156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D75B57049
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD216C854
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A17284663;
	Mon, 15 Sep 2025 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1RucKmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9F284B36
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917841; cv=none; b=LLIGR7q1DJRsu0xcDy/dSMqKAp9XapUHuxLO7xzl/T60NAck8bSMFtIEw98qH6ZCOgb9ZcTZrSmOgsx1bjN81EMQ5tKoNKjyLftDjGgKG1VBMAdEOheIzuJXfuy/ug4Hxp30wD8ag5wU4JndeED6b+61CYtXGnkd8raEdjyw+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917841; c=relaxed/simple;
	bh=ht03jlqLtN1+50q+yrJO7Nhcw4NQZ6+dmocueZw8+Dk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=l9IMnYOWsf7mbAenSyyQGXmdgNdq3z3xMB7btb2wgN83JTL7CNjRE8e4yCfx10094q9J8b+pGQyNTeYOEsQVsdYklZsN+GPL/seFUtqn+enoGiwKDwyaY0kfpQ7f+r+UjPe13ODbR3Wkip8vppVEZtqnu5aWfsvZuj0ZcPcBL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1RucKmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8364C4CEF1;
	Mon, 15 Sep 2025 06:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757917840;
	bh=ht03jlqLtN1+50q+yrJO7Nhcw4NQZ6+dmocueZw8+Dk=;
	h=Date:From:To:cc:Subject:From;
	b=U1RucKmjoxN/cmf2Af3pxmFk9IofrFb2rIjADoVgLk00gNk1Q07F+9Nh8Id1S6wf9
	 svThMM4ei2Livt7Qhj73xxKR8fYgJ8XMazE+upzo9N/9RQM3NjwxQtTFb0zDnGq104
	 DbN6GwNxhSqKjk8uCGH/Ma2ax1CrrW0Ps50On/eHnFBRXHrsVBF3H3XoEpb1jtEihy
	 4ivqTWs4uH8UOJwf4EmoGU4C4W9RAD08hAOXoXRvTKkMKFopPFpvB9I55iiXugYoNQ
	 bHDNaTwpK+hCTQByXhpt3lS2W3Xa0Z0Nb4ZFYRPvg0MRPFDokzjIJXxMtYYtylnPeR
	 mePC5Uif8UpiA==
Date: Mon, 15 Sep 2025 00:30:37 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
cc: paul.walmsley@sifive.com
Subject: [PATCH] MAINTAINERS: Update Paul Walmsley's E-mail address
Message-ID: <4a3d959d-56ea-36d8-029d-141e7820279d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


My experiment with using corporate Gmail for Linux kernel list
interaction has come to an end.  For my MAINTAINERS entries that
use that E-mail address, let's switch those to use the k.org E-mail
forwarding.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---

Unless someone else prefers to take this, I'll plan to send this through 
the RISC-V pull requests.

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..ca31f34ca79b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1772,7 +1772,7 @@ F:	drivers/staging/iio/*/ad*
 X:	drivers/iio/*/adjd*
 
 ANALOGBITS PLL LIBRARIES
-M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Paul Walmsley <pjw@kernel.org>
 M:	Samuel Holland <samuel.holland@sifive.com>
 S:	Supported
 F:	drivers/clk/analogbits/*
@@ -19292,7 +19292,7 @@ S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
 
 PCI DRIVER FOR FU740
-M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Paul Walmsley <pjw@kernel.org>
 M:	Greentime Hu <greentime.hu@sifive.com>
 M:	Samuel Holland <samuel.holland@sifive.com>
 L:	linux-pci@vger.kernel.org
@@ -21652,7 +21652,7 @@ F:	Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
 F:	arch/riscv/boot/dts/andes/
 
 RISC-V ARCHITECTURE
-M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Paul Walmsley <pjw@kernel.org>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Albert Ou <aou@eecs.berkeley.edu>
 R:	Alexandre Ghiti <alex@ghiti.fr>
@@ -23103,7 +23103,7 @@ S:	Maintained
 F:	drivers/watchdog/simatic-ipc-wdt.c
 
 SIFIVE DRIVERS
-M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Paul Walmsley <pjw@kernel.org>
 M:	Samuel Holland <samuel.holland@sifive.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
-- 
2.48.1


