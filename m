Return-Path: <linux-kernel+bounces-858123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D347BE910B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77BF3B442C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D73570C8;
	Fri, 17 Oct 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKwdSTyL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9922369988;
	Fri, 17 Oct 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709092; cv=none; b=N88yp4fb1xwaXjcxEwOwVqr37TEHuw6qCh1wl072/rVn5ICrT7VUZbMlTMLNyi6v/kodhSaPzZUXQ4cISc9/5a6GHkvKopH1jOlfaHhj5d9Z3gg+P9MoJVeUKWWraQeBxRg9XINW4Vs2kOY2OfC2I07h0XhkZMPK6YjkZy2J4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709092; c=relaxed/simple;
	bh=6myU0+1onkLfNmV3H8649E5ZMb5R2wUxNQQxI69BaDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/vFX5KDr02Zldb3UWzF9LrcQo23+vw/XfDzphbYczNeudaVenh+CPTD0wuz4VCgXKyf+pUzm43b0rNzH8rbQigNiYCT9l6nqWK+K6xw93YtyBqovewn3gBEPCUhL2GVxJTY3CzSjzrfDPy8pL+C5T2cOG+RcHlzfoLT0ZECB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKwdSTyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23288C4CEF9;
	Fri, 17 Oct 2025 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760709092;
	bh=6myU0+1onkLfNmV3H8649E5ZMb5R2wUxNQQxI69BaDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKwdSTyL9aA6LVmPqqXt9W2DnIBqluHMaZXaqS9Hh43UXXecbkyISZp3rfb6cIgGn
	 T3FiUOTLh3eMaQVHT7nm/nLyzBtDGTVYl3SmCHvx6Q46OpR2cI6X1i3pLegjr0Kykp
	 pEJDqkkBiAKrXAbjQrIkRkVAPUySaJicVNf7nCw7urVxEMZg9tpLX67rIJLN0PzW33
	 iPKlx2bnVUA/KlxAy2PbKgXdnnu8U6t3zFXUaFChTowmJ7Ph+Sh6K2ybQ0CJ/p6dIv
	 6inc9LK3lqYUQ2Pj96Zfi1BErZJXJZKh1HjWm6fdkp2DwDzHz//hLIRqAJhelZYCao
	 IeGNkmzFpSuVg==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: arm: ti: Add Kontron SMARC-sAM67 module
Date: Fri, 17 Oct 2025 15:50:44 +0200
Message-ID: <20251017135116.548236-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017135116.548236-1-mwalle@kernel.org>
References: <20251017135116.548236-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for the AM67 based Kontron SMARC-sAM67
module.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 0105dcda6e04..2e15029dbc67 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -194,6 +194,7 @@ properties:
         items:
           - enum:
               - beagle,am67a-beagley-ai
+              - kontron,sa67             # Kontron SMARC-sAM67 board
               - ti,j722s-evm
           - const: ti,j722s
 
-- 
2.47.3


