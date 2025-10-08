Return-Path: <linux-kernel+bounces-845080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4AABC3753
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1680C3B9639
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC42E8E0C;
	Wed,  8 Oct 2025 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmTd1OB4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D01F3B9E;
	Wed,  8 Oct 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904484; cv=none; b=K9HvOJz8I8YEI/i5X3Ee6SXoaUXW2e42F69uC98uStNMOrpkQ5wlevxNz5m4vTaBAUWDnAhtH/HBM0uG5sMLFBIflY7J+oUHuDuCKGaOxUl7m6Pcm5lhMTQw/olieSDBFBAYLg7GXjsIM4nXPRwKByICXkgt/0ya8W9GDUmybdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904484; c=relaxed/simple;
	bh=8rVARVTAwnQ6NUnob2aCJQPizeqIDcIbjWNLbok4w6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGH4xCTAAGy1eFSsbvEO4Xsb+l52NR0U+/Ko/ok08KqxEzmZzKJJXgYkRrRBUFNeUCn40IxqWTdRIW27+qrv4XaDUL9LiOTb8h4+8DAl8s91VQqhDaOAMcVsxrDbtSr7WBgdAoDLP+e//UL1g1+Qv94b8tfzfVcFkKDlQfZh+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmTd1OB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF1BC4AF09;
	Wed,  8 Oct 2025 06:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759904484;
	bh=8rVARVTAwnQ6NUnob2aCJQPizeqIDcIbjWNLbok4w6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CmTd1OB4Y0OTcrLx7J6hk2Dqhhj7WN7/OUNWbCHXsDXDLlEEtSqwSwxBfbwYKdv9L
	 +PELnMI3M5MkTgIcpevsi9Vm9XDSwY2aZ/wtRZb4ErLo3bVTOTCJIkfUq2Ci1Rzjo7
	 5rvlqS+js8vp10tWPM6EkCAjGhZ8BLyL9t3dB4MwITOIu2DzFpt/xR3TCfLrDfaDkb
	 DiHKKLTx74df4d9l2jO6+iYIcvwePvZMc7f2OSF4OzSJhKX8JM/HqZ+BNEtGRS3mm7
	 y1eylRx2GasqRdlWh/H2DhINxHR61YqDEdwfY9qpBiZZ8l/snYV/dDspwRTfdn/4bl
	 J9ZdKmjGlhIpA==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 07 Oct 2025 23:21:10 -0700
Subject: [PATCH v4 1/3] dt-bindings: riscv: Add Ssqosid extension
 description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-ssqosid-v4-1-e8b57e59d812@kernel.org>
References: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
In-Reply-To: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=fustini@kernel.org;
 h=from:subject:message-id; bh=8rVARVTAwnQ6NUnob2aCJQPizeqIDcIbjWNLbok4w6Q=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWQ8Y3r8Qc5S0Dgx+l3IV85ZJuln1x2cKfXrTv3X2WeNt
 p997LP1c0cpC4MYB4OsmCLLpg95F5Z4hX5dMP/FNpg5rEwgQxi4OAVgIn0ujAxHj/9NzWtT/jDB
 /YfojCrP8zMcMk5dUHZXr+XOTb68clkhI8NBhS0xv1IyQ1dVR70+ON9mbRMf209Jj75phzQVlN9
 PkWYEAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
extension v1.0.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index de41a6f074d3af2ceaf5293dfe75d16f43d416d6..27d0efe72e0fa436c0796550ef126f1f17c36541 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -165,6 +165,12 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: ssqosid
+          description: |
+            The Ssqosid extension for Quality of Service ID is ratified
+            as v1.0 in commit 5059e0ca641c  ("Merge pull request #7 from
+            ved-rivos/Ratified") of riscv-ssqosid.
+
         - const: sstc
           description: |
             The standard Sstc supervisor-level extension for time compare as

-- 
2.34.1


