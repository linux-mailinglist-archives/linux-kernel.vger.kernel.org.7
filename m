Return-Path: <linux-kernel+bounces-851727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C026BD725E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03CC3BA0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C39307AD1;
	Tue, 14 Oct 2025 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2jdChqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463D3074BD;
	Tue, 14 Oct 2025 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411540; cv=none; b=k9R5d2eBEAz6G/FlyAW7vAfNC7hoa9YqnQriYg0J+TMGj9rmefKvZS32l/vbMCAyPAR2kc9FOf8Ss2BVoevAVHij9h2Tv7kCaEj6d4FoDTFiX0Zzr/ErTDcXBtOWrohDfD0eq+W8AxOMoWD1uy93Sh6BgEH7ZMWYED8LKyAq01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411540; c=relaxed/simple;
	bh=Qxx7Nu/jiOa5nZTb2hgXdJjolteFiTKWPAx4vNdsclM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVPadKM7v0HkfkM93CAXVHIWZMROHhjWvIbGJBaN1rIpNbgBgePWYZHqPL08reQBCiijQCdGos5MmOlSPCkVv+Kmvsq7hPrvrooYGArzz/23DLNe8RNJLKPfrWE2p/SNovKHK/sgom2yv0t1SIuc/RD9Hal3h8XCFR6FEAjXKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2jdChqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5B6C4AF0B;
	Tue, 14 Oct 2025 03:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411539;
	bh=Qxx7Nu/jiOa5nZTb2hgXdJjolteFiTKWPAx4vNdsclM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O2jdChqk8evemkiSOkmk55bFFAlQdcsvqKM2OoAlYIGGHt7+FluSCyMg8HXMAn3Dh
	 giW0Olnan5P+IhT/mXSZSpUx5vMbnx0A++HcDceVZ8QrOc2/WiuGCiMumJnvStBAbT
	 kqF7Tu3MtSRTPkUDDOwu30UHlBLsENDD0jZhsfXjvLh0mUKE763hBTyw6zEmn6DHwA
	 ELaefHd8p913R83C6KHAtk5tqr3NgbjLaQ3TzxeRze5hPyhNijbTdQHcckC1nnlKa9
	 ZxPARUdj54IJYBNr4M4n2dZQX+lXn/VR1e31MOkLpSGv2pP1nTHojL84/0l1/EZ9p+
	 IFBPS4KadQrIg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 13 Oct 2025 20:11:53 -0700
Subject: [PATCH v3 1/8] dt-bindings: vendor-prefixes: Add Tenstorrent AI
 ULC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tt-bh-dts-v3-1-9f058d4bbbda@oss.tenstorrent.com>
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

Document vendor prefix for Tenstorrent in DT bindings.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba9e80127bae0151af157879fe3070..21921be22207683a9c1e2248d0de63dcde867648 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1610,6 +1610,8 @@ patternProperties:
     description: Tempo Semiconductor
   "^tenda,.*":
     description: Shenzhen Tenda Technology Co., Ltd.
+  "^tenstorrent,.*":
+    description: Tenstorrent AI ULC
   "^terasic,.*":
     description: Terasic Inc.
   "^tesla,.*":

-- 
2.34.1


