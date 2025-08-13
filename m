Return-Path: <linux-kernel+bounces-766421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038EB24669
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E44E885812
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6D2F49F6;
	Wed, 13 Aug 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpw3X7p1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0192F49F0;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078830; cv=none; b=pHhLjGu/mkfQSeWW2ktWxsEubrZQlNhAlDlcUALGIlAq6qc46kA6KYQO1Mqsxhc58cBg08XSVGdJbaHYjNy8tk8YfE9eX9zLaWJ8RkhPn1u5xSKhyiS6QxFcXtiemW1ycz5kY9Afgcudj9vPkbVu/sTejX+KcMdrQ/7OvfppPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078830; c=relaxed/simple;
	bh=5whLMpPXnChjOuPWhWWpR+lMWG7khfLx4YWLL4J+Wzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwEQK74qPMfWWN/UAOWYivZxR9PQzvOgWguB6fx4yBF+WL4A8cQGaxkMdXGi1jWBXzJ8jb3JpOxW7YwQwHWNeFLu5YKBrQXdF+/9w2WK6U5O8S98hvvNgtXJBjYmdM6j/FbIkuaWr7d+cftE9q5tb0iD5751H7VoKfdpt6/Qs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpw3X7p1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 320F9C4CEEB;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755078830;
	bh=5whLMpPXnChjOuPWhWWpR+lMWG7khfLx4YWLL4J+Wzg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tpw3X7p1c42oKJDTGdTcWbbw2q8YXPQFHW1s71kCnQmYc4rJgN+CsvJUZUw0hAi6M
	 MaUGipDI2Rjql83fIRQDL9oybV2vaffMHbGd+I6W6y2yn20Zy0ZXOE5Vuoq2uZowrI
	 CG8TrdSe+lPAy324oYVbEExJwDXk4lm3nefKm7HYaUH2zImUWapyFH/mVmaTMzic63
	 jVjM46I5gLyRvmq3nZrmw6H5OQeuyIcIc1fzFXAiNEIJxgtTUdXsc8QpqBy+SJhIpm
	 lCWZdSaPnQ/c5v7WtSKI5YuHyBevr8na/pSzwfBRD3uuDhXHt0saBfUWJFikMJeKuZ
	 zN9QsA7gotm3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC6C87FCF;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 13 Aug 2025 11:53:33 +0200
Subject: [PATCH 1/5] arm64: dts: apple: t8103-j457: Fix PCIe ethernet
 iommu-map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-apple-dt-sync-6-17-v1-1-209f15d10aa0@jannau.net>
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=QgvjbU2+ige4nQSRScXv7jFxB1PnyJOY3TFJi0m6MY4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhow5CWv6+d6q8iq036ssZ9k4a2bJc/YEiR+rncWEAkSZp
 gWaKkp0lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmMj/n4wMv71Pm6wznqqQ9mvb
 XdEah0w9419y0ctvufp4tH5hWPGqgJFhZ8FUhjc1l4wWtbzyUHm0Pv7yUr2OiAte+2/dCN/zWOw
 PEwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

PCIe `port01` of t8103-j457 (iMac, M1, 2 USB-C ports, 2021) is unused
and disabled. Linux' PCI subsystem assigns the ethernet nic from
`port02` to bus 02. This results into assigning `pcie0_dart_1` from the
disabled port as iommu. The `pcie0_dart_1` instance is disabled and
probably fused off (it is on the M2 Pro Mac mini which has a disabled
PCIe port as well).
Without iommu the ethernet nic is not expected work.
Adjusts the "bus-range" and the PCIe devices "reg" property to PCI
subsystem's bus number.

Fixes: 7c77ab91b33d ("arm64: dts: apple: Add missing M1 (t8103) devices")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t8103-j457.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103-j457.dts b/arch/arm64/boot/dts/apple/t8103-j457.dts
index 152f95fd49a2118093396838fbd8b6bd1b518f81..7089ccf3ce55661f3f83810496daed40c8199189 100644
--- a/arch/arm64/boot/dts/apple/t8103-j457.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j457.dts
@@ -21,6 +21,14 @@ aliases {
 	};
 };
 
+/*
+ * Adjust pcie0's iommu-map to account for the disabled port01.
+ */
+&pcie0 {
+	iommu-map = <0x100 &pcie0_dart_0 1 1>,
+			<0x200 &pcie0_dart_2 1 1>;
+};
+
 &bluetooth0 {
 	brcm,board-type = "apple,santorini";
 };
@@ -36,10 +44,10 @@ &wifi0 {
  */
 
 &port02 {
-	bus-range = <3 3>;
+	bus-range = <2 2>;
 	status = "okay";
 	ethernet0: ethernet@0,0 {
-		reg = <0x30000 0x0 0x0 0x0 0x0>;
+		reg = <0x20000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 10 18 00 00 00];
 	};

-- 
2.50.1



