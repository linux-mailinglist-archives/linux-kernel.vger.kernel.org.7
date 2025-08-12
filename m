Return-Path: <linux-kernel+bounces-765405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AE7B23238
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C2A7AF7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038E52FF179;
	Tue, 12 Aug 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nefw9OAd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD03F9D2;
	Tue, 12 Aug 2025 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022472; cv=none; b=Hsdon3kHTjV1x9znQd+dZBGA1I3TMSHHyxjP8oxM0AdznmaQoNUPckSAHY9G2PVXX9LopIodJmzb7NxVNeHou0a9UN+zksREpYJ/Y8n2e5GNUfJA6BQKaL9eJyWQaXGtUykH+iFEq2s8DPD9Sl4Pcl93giy/8RL8f+MNhT6mwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022472; c=relaxed/simple;
	bh=vv5WWQsKcgXklEsLQU+79sEsU/qpm/DDsW6JAVjykqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dj3HShGT2ggT/CqN6BDWwYPmhUun8LcGu0jj6GxU/+kF10qZ13xv7R9SbuDa7J5KTsI8MikyG81HoBva74YzTGPKhqvwINpPS209j5/EyoB3XzvGzejwmzpCjc/QU1Vym8boac/8cevcp2CKsSz/eagXPg4LJLJB1IrSMdUo2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nefw9OAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E128C4CEF0;
	Tue, 12 Aug 2025 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022472;
	bh=vv5WWQsKcgXklEsLQU+79sEsU/qpm/DDsW6JAVjykqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Nefw9OAdn0UlWpsDPsCCTZ7yPAOv1dumpJMJsj83LZ3t5quasCXoRjoe9uXcx0JnM
	 FMyrrpBKFnrYvKtVd/Dxe3pOoK8ghCVCWVAGm3R04SC3QOeGmaQvoIRWP/TEpXs7c4
	 xp5om6lYB1JNpS7X9j8FUqk0xJBE6v2cDZ7Hcrd9WIp0vtcTKHns5rw/AxRE+xbjxi
	 eFKhS2GvejfYqrM/YzeXVq0s92FiPKbfjfO0oif2SwZtPe73zaI5zJUCXjbP0rny59
	 u+9pmOVblqHFehSp6xwHfpGQrDRopAn+5x4Q6woXC3em70OqTNHwJMdjPRzWnmUkGA
	 CIQDP7vpGskzQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm/cpus: Add missing Applied Micro CPU compatibles
Date: Tue, 12 Aug 2025 13:14:27 -0500
Message-ID: <20250812181428.69490-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"apm,potenza" and "apm,strega" CPU compatibles have been in use for some
time.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5bd517befb68..bb1ab514924d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -80,6 +80,8 @@ properties:
 
   compatible:
     enum:
+      - apm,potenza
+      - apm,strega
       - apple,avalanche
       - apple,blizzard
       - apple,cyclone
-- 
2.47.2


