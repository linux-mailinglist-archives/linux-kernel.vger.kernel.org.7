Return-Path: <linux-kernel+bounces-826028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C187B8D5D2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97847B1EDA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB72D1301;
	Sun, 21 Sep 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCJeVOV5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD22C2356;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758436864; cv=none; b=EBZAUah6pfzoQjyjK9bfsmcRBqHBPn+VyATGDiJVIfnBr2hdHXsiGwkmPKIeGr1skMXt20yFWYGX3LpWhB5u3ynPoIPBvuLB+En5TDWPU5SrTl0v5CF4HckorPjRZDLwwT4Cl4tQ97/RctVb7TeU90fXEJ30SG7ZAExVD/F/XyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758436864; c=relaxed/simple;
	bh=dhfVENO/WdXQWcs+avMXF1VtV3LhiSDOc0FjGu56Qg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPgpTQMldDvGEO5pYDiAX1dWBDEIn0UA3QXvbA8ZHxanzU0X5l2QJ0SwxjD2kPDYwLtQjHCrAEJP0J5XpAKY9YuyeQjicHwoB5ouiRv0SCxsiRhtGRwHVRjVUfQGi3CUsvTEcGSKwkdiZcNl4Tr/jw/XSB6AhcgucAIvgFTroJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCJeVOV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62D1CC19424;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758436864;
	bh=dhfVENO/WdXQWcs+avMXF1VtV3LhiSDOc0FjGu56Qg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fCJeVOV5E78GMpfSrDO+5SqmPknC/76XDxsnmTWMnjuVEyyUu1z+1VgJ0KdQ/cpe8
	 4o2lXwEz07iTrNlgBGAwOMxCakgPm0Gyvp09HJ+FYE0sGGMuneWLr0LGdhiPWqqBmf
	 Fp139ZSHzC1zzvEl6HnqQd3LSbkBwDF8L7YN522VOGb0Gm9LWLOY6hbsLvlqQRsOwk
	 W7z828sGYDz3atd/ac2b99rVS7FsxCLNoQUEqelQYwZDyVNghp5//oQglWYfmOpN7j
	 B45V2TWLbG2uqL2iDMrMtse87ySt/14OYFAYJdvX/bfO4qBifRFNr3pgg7uX3sjT7+
	 rljFKI9g8fvwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA22CAC5A8;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sat, 20 Sep 2025 23:41:06 -0700
Subject: [PATCH 4/5] arm64: dts: rk3399-pinephone-pro: Add mount-matrix for
 magnetometer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-ppp_light_accel_mag_vol-down-v1-4-c8bbcd3e2e94@gmail.com>
References: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
In-Reply-To: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758436863; l=1257;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=FMbYYcUYILGIS56uTIKITyMJkrSy2nzqxC8XrG3nFVA=;
 b=A72tkwED7UWPX7kbrO2yP0e9d/2nV8pTFRVsiT0EQ+eXujO1omM2FspnmfGQfI+4intgbDxxY
 6RIoKoA/V7/CGN2DyaGKghgFZoy/C0EPnEMmKTpIuTo+On3q7kSNuR/
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: "Leonardo G. Trombetta" <lgtrombetta@gmx.com>

After experimenting with the magnetometer on the Pinephone Pro I found
out the mount-matrix currently reported by the AF8133J driver is just
the identity matrix (no rotation), which is wrong. It would seem to me
that there is currently no `mount-matrix` info and that's why the driver
reports a trivial answer. As far as I can tell from my tests, a 90
degree clockwise rotation in the XY plane would align it properly.

Signed-off-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 8ff64004b0a6e3b472077516ab360c29852d7c9f..9442ca4c9ae47d639ed6139c370bacf1bffa65b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -561,6 +561,11 @@ af8133j: compass@1c {
 		reset-gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
 		avdd-supply = <&vcc_3v0>;
 		dvdd-supply = <&vcc_1v8>;
+
+		mount-matrix =
+			"0", "1", "0",
+			"-1", "0", "0",
+			"0", "0", "1";
 	};
 };
 

-- 
2.51.0



