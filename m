Return-Path: <linux-kernel+bounces-815366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B003B5634C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2201B25E06
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECBD286429;
	Sat, 13 Sep 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djWMGv+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AC2857E9;
	Sat, 13 Sep 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799066; cv=none; b=IfW5jbUmAA1CcWo95JiHsU60b84jqM+92JD1aILYvIy7t0OBWOTWAb4noDugkEgJSSwumOm1yiR7RQZHT3ycu41vNPAeOcPjWUfDiGajGQQww+3OFuQhlQyTydjq+jAVfMaDDXLnOxvfdHjOAxl7CFm18+psosv1k1OSuq8yGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799066; c=relaxed/simple;
	bh=thVTGezMo0pAosaN7Dx0/XK1CsqI2+np60A2VazYJJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrAsXmLmNg1CKT5WWs50iGLVme1KdFv/t9ofkO4IDvHns3GioTE5ku41yFDe+stYIxRUMN2cDb4FHc//wTzuCNuynAkDOdiBvN0uDN8E5TvKd/JyBFYU/uX/p2iPBya7ULY3Yv0XtksF7uSdExsPY0R9nvs+CRWSjgsKA73uI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djWMGv+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF399C4CEEB;
	Sat, 13 Sep 2025 21:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799066;
	bh=thVTGezMo0pAosaN7Dx0/XK1CsqI2+np60A2VazYJJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=djWMGv+M7mlviDGoufdu4MGlzmMWmRrGGGyR55AJrlkvEv1MWmLg03bSuJIEI6Wqv
	 d4k4EPkva7rPS9LfuviUDr2kMFhX5VwkyLG7HJuMws+/ZW5/HEggW4TTl+tnCd5Onm
	 grrHOiDMenDr2P+8ODtU+9Hrhe92NQpdY2H7vrS/tS5xMb7azBGzo5TcvoGXuujSmb
	 FdeKIvJddwzRPXZQni7O/ITseuVTLaaeETpBAubXh5ccMDETuzW0Y/MNS3L7WkU2pH
	 g0OAIp6GWdnGFkQxhLQcinBPjmu3DLz0GQfPKJPJ/uKgamqEJNXjFOioTRQ5h5968o
	 Lh2gpnkmjShpw==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 14:31:04 -0700
Subject: [PATCH 5/7] dt-bindings: interrupt-controller: Add Tenstorrent
 Blackhole compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-tt-bh-dts-v1-5-ddb0d6860fe5@tenstorrent.com>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
In-Reply-To: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@tenstorrent.com>

Document compatible for the PLIC in the Tenstorrent Blackhole A0 SoC.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc243011cda1fd45d739d34eca95c6e1ee2..c960a9ec17e9fceb0b754c21162e8730b12120fb 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -63,6 +63,7 @@ properties:
               - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
+              - tenstorrent,blackhole-a0-plic
           - const: sifive,plic-1.0.0
       - items:
           - enum:

-- 
2.34.1


