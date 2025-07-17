Return-Path: <linux-kernel+bounces-735003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2E9B08950
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6C6584957
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89428A703;
	Thu, 17 Jul 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3DjxbjH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83202F850;
	Thu, 17 Jul 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744596; cv=none; b=sFHjsqCU5Jizq9z2uw/okLSu/8Ed8Wfvc5NQGO8n8i+KSI1/AsaJyP2GwEn9QGwJvv3H4qMUlQ/varHsMxbZB5QfPcy/NRR5KNGQaYZb04a2Ate48rcntcJefU59dVvsEN4HOYug4+jNC7QmC4vwNNtrT1CX2wo2i80su7UQxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744596; c=relaxed/simple;
	bh=BSK0uIAcmO4oPS5QlKIFn6TVQZfBtcq3Y0E6j9kT5u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A2CHTVqnoqiHS3pbP1vuZjfsJZxKcFHMbtZF33l8JMXGj169+e/jtKk9jltqSS6sgpuyijJkrXIcQIuxyZOU+zucOK3GNEWlALRfkyfPGsbtqrKUXeLYYRBXgTVSmi4fCs62Q42LtM59B3NlXMds2rc7+PjOYMdHytyoPftTGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3DjxbjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C367C4CEE3;
	Thu, 17 Jul 2025 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752744596;
	bh=BSK0uIAcmO4oPS5QlKIFn6TVQZfBtcq3Y0E6j9kT5u0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=k3DjxbjHiBnXKDWDbeU4sh6wy6dGKnkrK/K90bPDsn8nRdTPYMOXN1M6NCCcWFvGW
	 X4L36ehDXoxdW0teWmyntC04XTzyKOFN2GYkamarDOa1Um8qOIDcdMEllBhKbTJ9sz
	 pEbJ7GVg2EmNQC7kvrahZvzw1OFuCYGQbH3FdqFWKgvsNEXGY/KltIdGc9TNVmA8iy
	 0a3CoFDsru6mp1vdBlWo7Dn+OZhXjUpN98IidcXDyhnwiJCpuoLbiBfCTLKsrExnGu
	 QoxXZ8dagNkcUh593fPM1igXd914U0Nf7dhc0H1HPrcPdjkNK9b3NVSPhzdfbI5Rro
	 6Hl7CoAgQJYLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2204CC83F1A;
	Thu, 17 Jul 2025 09:29:56 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 17 Jul 2025 17:29:54 +0800
Subject: [PATCH v2] dts: arm: amlogic: fix pwm node for c3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-fix-pwm-node-v2-1-7365ac7d5320@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJHCeGgC/3WMQQ6CMBBFr0Jm7ZhOY2lw5T0IiwoDTCKUtKZqS
 O9uZe/y/Z/3dogchCNcqx0CJ4ni1wL6VEE/u3VilKEwaKWNsmRxlDdurwVXPzDWxKO2d9fUykB
 RtsDlP3JtV3iW+PThc9QT/dY/oURIeDFKk7WWR9fc3PLwk/Tn3i/Q5Zy/MEzEaKoAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752744595; l=1176;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=Gl5aQb1KI68vaz1xI6GSSxa1gnslD6ZLVXgkTOwj19o=;
 b=ndz6krIm5rTHcF0VCgZszdjiIhZ9+NkgcPqV41Y1+BuN0ax4ZI3OVdxiPxYwolQ3HkunwrNXV
 jRLiAD5X/tdAi+pBzR4xvpRvheVKtmMezVlUdfm5OusW9s+D9+EZ2ya
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Fix reg address for c3 pwm node.

Fixes: be90cd4bd422 ("arm64: dts: amlogic: Add Amlogic C3 PWM")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Fix c3 pwm node reg.
---
Changes in v2:
- Fix commit change-id about Fixes.
- Link to v1: https://lore.kernel.org/r/20250717-fix-pwm-node-v1-1-45021777efa9@amlogic.com
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index cb9ea3ca6ee0..71b2b3b547f7 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -792,7 +792,7 @@ spicc1: spi@52000 {
 			pwm_mn: pwm@54000 {
 				compatible = "amlogic,c3-pwm",
 					     "amlogic,meson-s4-pwm";
-				reg = <0x0 54000 0x0 0x24>;
+				reg = <0x0 0x54000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_M>,
 					 <&clkc_periphs CLKID_PWM_N>;
 				#pwm-cells = <3>;

---
base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
change-id: 20250717-fix-pwm-node-61ef27ba9605

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



