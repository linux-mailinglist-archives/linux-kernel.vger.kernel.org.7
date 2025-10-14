Return-Path: <linux-kernel+bounces-851728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822BBD726A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006013E10B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A02AD2C;
	Tue, 14 Oct 2025 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkbHR7kT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1D3081B1;
	Tue, 14 Oct 2025 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411542; cv=none; b=HE37SKxWydtWLmYl6elM4CpLPyqu0UdwZmIlB9Gmdkf8TrhWYU/by3FFXszIU0M1uX9QgIoAhcMRNZre1AU6UoHRomUaV0LciVKfhCEVvv6cEpzimd0ncI7ARVL3C3hgydRKIzhc8oVQCbt29I5o8Cj2UCVEY8GZrMej/mabOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411542; c=relaxed/simple;
	bh=Wl8ZTHg5stOwe+WQ7WFdplzC0h58N4FuSj3zEehF9Xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyQ0uu/4LfCvg2HpS4ivAIVfeOaYGkxdX79wJ0OKTCq7YW+YdnzW7sesuTS1B04kzYYYkAFBeHsQeY97wx0dNemCwEQ0P0MgYDtp6g5wZtS7parA2MDx2Um58CnzqX9Vp0pZr9woeaJwXJQjwe44CZU4lcLLx8WMo7pxqPI/SFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkbHR7kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9398C19422;
	Tue, 14 Oct 2025 03:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411541;
	bh=Wl8ZTHg5stOwe+WQ7WFdplzC0h58N4FuSj3zEehF9Xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qkbHR7kTwiXYWvQ/fqj9y5/T2xFH11ApqwV3le2acP+rBlVlsz6yhj3XtmZ2BqTVY
	 inL5VcNcNrveffFMR0sYm32gZgr+MW9TtSilPvPoS++y5WlRM0caIxQD0y0ndeAVtL
	 muBruj/y6CEVxVgAXwu4ZHGommIVioG0YkJTmlKjO+C9gV910eoZ4vv8tY2FGSD+KA
	 L2Pe/RtUuJOURIWlaE5vXfPDIlU4pcelXSprDdhNvd+7CyZyQJw/er8QRzTd7NvjMQ
	 PPHO5dp1f5HJHbtQawmcz7CpNAirurNb5hspUPmYXkEzHMmiiG2e2s/IAG5g5NnJEh
	 zD0skIu+s1RIQ==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 13 Oct 2025 20:11:55 -0700
Subject: [PATCH v3 3/8] dt-bindings: riscv: cpus: Add SiFive X280
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tt-bh-dts-v3-3-9f058d4bbbda@oss.tenstorrent.com>
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

Document compatible for the SiFive X280 RISC-V core.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 153d0dac57fb39d39219e138792f4cb831cb88dc..afb8533f6a081bd9b91e13e30185f99ec2d5dc3b 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -70,6 +70,7 @@ properties:
           - enum:
               - sifive,e51
               - sifive,u54-mc
+              - sifive,x280
           - const: sifive,rocket0
           - const: riscv
       - const: riscv    # Simulator only

-- 
2.34.1


