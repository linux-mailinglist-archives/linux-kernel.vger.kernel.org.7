Return-Path: <linux-kernel+bounces-851731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8193BD7279
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2BB19A0B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34BE30ACFB;
	Tue, 14 Oct 2025 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWKjXaex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099C30AACC;
	Tue, 14 Oct 2025 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411544; cv=none; b=ty5V5vV3T3BcnfZwkGFyLg0g5tEMcbAEzpPk1ev7JOTov4aYhuxoNuZzhb7H+0i+X7QxZE9bFo6FtNruRfdFuxRR4eX1dalmbDV10TyvmYNDyPL8O7zZNOB6abbkJy5O7yl8uOCpspXCxrdUmnt1NPAilPyAdyJkqSY+MI9cmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411544; c=relaxed/simple;
	bh=cYt/1H5KZmPaIkaj1fyz9BSzaYf9P5vSg62AHRDKvwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaWsraUUQl+/3OcSnocvKG7GPyzk1a1ymbXs1Cre46X5U16Pa5FsNtZfm4Ozkft8g3R3kIwfNXYaoqCDlySqy0v/pCqehuc8c3XYZ51YEUeJRFrn5qe2mBeEbzf6a5rnBjsiwX7PeBLMEhEHXFJc4IUSmShViIXOO6SiMGdZvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWKjXaex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DC8C116C6;
	Tue, 14 Oct 2025 03:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411543;
	bh=cYt/1H5KZmPaIkaj1fyz9BSzaYf9P5vSg62AHRDKvwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BWKjXaexVqj8Bcmsk5LKUhpE0It/84OYL1bN5vgzgHKCpGFdZYdQNBPm635U8xebB
	 vCxjvR52e1HVnc1onUBvEMxPRAbvtdmxMGVjy7sdvmudaMqaiynQuL+9gVZab7oqI7
	 rWnKq7PP7+w02+obUmFGtS0l10P31bofgJ9x2HtpK5kRk0qYANHuXGFHHGRCe+2pJD
	 ugbmZ4rRGUaEgeYgQIq8dtbpoNZG0eVep8u3XOYGQFTqZTRWkyB0eup6RJOYL/JUKf
	 KbGkWL2n0yeW/XC/n3Nx7uOF3FMiEDe59617UtZbHw+HObxdImwo184msr81LsJalS
	 3XhIxauylno4g==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 13 Oct 2025 20:11:57 -0700
Subject: [PATCH v3 5/8] dt-bindings: interrupt-controller: Add Tenstorrent
 Blackhole compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tt-bh-dts-v3-5-9f058d4bbbda@oss.tenstorrent.com>
References: <20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com>
In-Reply-To: <20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nicholas Piggin <npiggin@oss.tenstorrent.com>, 
 Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Drew Fustini <dfustini@oss.tenstorrent.com>, Paul Walmsley <pjw@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@oss.tenstorrent.com>

Document compatible for the PLIC in the Tenstorrent Blackhole SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index f683d696909b9da302c53a64f6332f6251705c0d..9886b7d73d3c4987a5983b2578d9f17539b7fd25 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -64,6 +64,7 @@ properties:
               - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
+              - tenstorrent,blackhole-plic
           - const: sifive,plic-1.0.0
       - items:
           - enum:

-- 
2.34.1


