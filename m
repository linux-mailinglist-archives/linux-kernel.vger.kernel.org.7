Return-Path: <linux-kernel+bounces-728741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248FFB02C67
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6F43B52F5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550128F51D;
	Sat, 12 Jul 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmeaUWc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173128ECD8
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344389; cv=none; b=AL/3b2s8UMD9wI8cnBsoYB3J4De//8Bs0netKhBMB9Ai6Tiq/+GIS1G4IHfH0o6X1suckXMPXLBth4AjpNXfF0RDJgbP5vA/NoPXAcmduCuH6xWt5vWFILAUvAhhr4FjXZGQWoFlv3kBjk2lceBMRMNPs1xaWdmZKtJZ8JC+J5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344389; c=relaxed/simple;
	bh=F8nyTk0rNJPdqCegfdhw0MY19z9vK2BbR010RYXVKYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ye0Q3vdlLxUlgdYnzZ3Oty07jfcKHU4f1hUWbXb4dLOlRMMpiomFSUdGKdOBURwXhrN+LbwEhowIisC2XpOIPRYFPbjZpGvc4zrIkr0iFt3630JF3tYGvuc2tiSWTQqv/BbHf3xYXqd/KrsjSPH0XEPlaJKBBYCfhlsc4z6yBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmeaUWc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B45C4CEF7;
	Sat, 12 Jul 2025 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344388;
	bh=F8nyTk0rNJPdqCegfdhw0MY19z9vK2BbR010RYXVKYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmeaUWc+JQwaoURi938YtjDhpzKJ2i+sFN/CcC75a7v/deRPH0WHEXB0EnkAT7xLy
	 H40z0tv/ijk92pTMmjyvEKPzuLLDo/d2vJh/Alx1fmeFoGCmwWLtfMcHtAGsQYLpxV
	 it2gxH50j78/eW616R0uKxWv+8y0cNru1g70Z/yks+NOqtAmGa/lHyUBxZLUo84w7n
	 RcbvQ6bpkOX+swCGVUyQ8o8G1dF0x+k8yDQtxLM/AbHRpCmSYUNChoPkvb9si9uHBu
	 S7cmJhgWkjF8TpAH61JGGE3HUEj3aNe0fyWdMOUx9bTBY8d1jKtQcKhMgmFPt4Vtg9
	 5vGAVWLjzzddw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 6/8] dt-bindings: nvmem: SID: Add binding for A523 SID controller
Date: Sat, 12 Jul 2025 19:19:02 +0100
Message-ID: <20250712181905.6738-7-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181905.6738-1-srini@kernel.org>
References: <20250712181905.6738-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The SID controller should be compatible with A64 and others SoC with 0x200
offset.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index 4424c3c5e75c..f67470b8a2ed 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - allwinner,sun50i-a100-sid
               - allwinner,sun50i-h616-sid
+              - allwinner,sun55i-a523-sid
           - const: allwinner,sun50i-a64-sid
       - const: allwinner,sun50i-h5-sid
       - const: allwinner,sun50i-h6-sid
-- 
2.43.0


