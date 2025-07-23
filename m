Return-Path: <linux-kernel+bounces-742139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB22B0EDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4247596007F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3ED286409;
	Wed, 23 Jul 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="oKYB50jh"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8D285C82
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261047; cv=none; b=skI0fTAQhP3pxQVZVnpu0/hbJ5wx/YR9v8vtBiOKgCIt8ldOu1NuKzboTqRYowE2Lr5jwhQxZJGDzCYcbOneNZV3yVbtD98lyORl2fU7Sj0FrGtJXbpmx4fBuLInIrwGumZBuw5h8noBRuHHwTvSKO4wxBBquAsZeqBGeXrDZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261047; c=relaxed/simple;
	bh=8SCowtYA+H6rspvke1KAUKfarPLg2f1jV6JRWecdiKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG4VmAlYnlITxoPqFltCxi4jNxHhMNGRJh7YDHxzE0DISCtiRBanmo5zbDL9vBM5UxWlU0z3F9Fnq91SixaDZo9KSVCkxirpVHQVixakobFPmbICUyGWh7azuMG/FxvkJ7mfj0k+0t7j1p58lmRS+iO6Quvfmr+2jSlD1av1VTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=oKYB50jh; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753261045; bh=VYMDQe/mQ1kKIZU+OHkaA1YB3avFSOAww6d1p3lXtB4=;
 b=oKYB50jhdb+cA//GvTZsGhObw3ijqgaY2ePFWT2wnCHjUD11HD4CjOKPcR+gsf+euwp4DnDLD
 JI3M/tjzXrlyQQtCxfCBDUEhMm8cyCa2jIbKjDVEQl5bWNiSSJhwhbwzTDaLJrgl/lCjH9YVhOq
 PUuI0wbhpWwwWv2SHhQUUXhrUYBf+Qb3XCpz8EoKNxvvxxAQ12Y4yFCvjQLrcv3lllEkB9y0cld
 ZUfpV2RjLVdDn1cfVrvAJn/sKzEdpgrQO8qLl3rAy+zMSGtVp02pajPpoKeLKqpHr9V0cCkM3bu
 JaUV83Tx2NLLmeUS7A22yuhItaAydHTtNBCTK+qUTt6w==
X-Forward-Email-ID: 6880a3ed144dc4a5e5baee49
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: serial: snps-dw-apb-uart: Allow use of a power-domain
Date: Wed, 23 Jul 2025 08:56:46 +0000
Message-ID: <20250723085654.2273324-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723085654.2273324-1-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UART controllers in most Rockchip SoCs are part of power domains
that are always powered on. These always powered on power domains have
typically not been described in the device tree.

Because these power domains have been left out of the device tree there
has not been any real need to properly describe the UART controllers
power domain of Rockchip SoCs.

On Rockchip RK3528 the UART controllers are spread out among the
described PD_RKVENC, PD_VO and PD_VPU power domains. However, one UART
controller belong to an undescribed always powered on power domain.

Add support to describe an optional power-domains for the UART
controllers.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 8f1b7f704c5b..cb9da6c97afc 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -108,6 +108,9 @@ properties:
       parameter. Define this if your UART does not implement the busy functionality.
     type: boolean
 
+  power-domains:
+    maxItems: 1
+
   resets:
     minItems: 1
     maxItems: 2
-- 
2.50.1


