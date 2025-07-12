Return-Path: <linux-kernel+bounces-728737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF1B02C63
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BA21733DD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC428BAB9;
	Sat, 12 Jul 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwVZ7oVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DB28AB07
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344382; cv=none; b=acVaXic84jTE0+4mPSFdaSb2xrZNwudXnwPYhY74vjgOfcZVv1h5Qj9hNuy8WPKp1dOADvlzp4g2A7LVaVme9BvyxKf+ghSYc1bth38V06GbS9vPQnHnCRUkOjDLGLq1nopf5uPtvJCVytJxgmHNz1jLtaZZD0yuzoxtYVI8OSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344382; c=relaxed/simple;
	bh=kzjiOcuagds1KP21JyfFDNsCKJsrtbx98RqHo7n/RBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4ZYg1lb6F2J3BclCDWXRqaaoAdie550GrG4mUsvxiORIyanuOHjfyo6jh7JcfnPVAe4vtW+DqwNdoxp7Jw8xWpyhmz+nJqq+AE2T7lRIvhxaK3XZfx3ar5jU+LoyIM6KlaxuydaaBVGFEbYL8+7UiOJovUbbYIt01k6b8cw73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwVZ7oVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C3BC4CEEF;
	Sat, 12 Jul 2025 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344381;
	bh=kzjiOcuagds1KP21JyfFDNsCKJsrtbx98RqHo7n/RBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwVZ7oVTNAyROo1hXbpwaeLnm1xLLP9cOz6ZmekYGNmpvNsVZ3nj6qhQv+RLeRP6t
	 D+bCtYkXqnbudtGlKcjMuYMdruRXrRAPeGNbfwXXq4e4uODCZkSMDko3GSS+2/L4yF
	 Aa5r9IhnFZ5F923UXSgkw6c3ouNSkd/HwiDh+7s+mWUkbDZBdzyUSLFkkeLE+FWthp
	 SGylxzgGyIxXn6D/pzUCODRrIfQ1IdrVHnmoZwIguNTXutnBAkCESGrIepJyxgldVV
	 ObK/gMVlSM+Hoa41+5v58dw7Qzmn7zl2mZNmYLhDQBGQKDWacTksyr7rkh9fh4U790
	 W/1RPB3Ue7tCw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Sven Peter <sven@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/8] dt-bindings: nvmem: fixed-layout: Allow optional bit positions
Date: Sat, 12 Jul 2025 19:18:58 +0100
Message-ID: <20250712181905.6738-3-srini@kernel.org>
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

From: Sven Peter <sven@kernel.org>

NVMEM nodes can optionally include the bits property to specify the bit
position of the cell within a byte.
Extend patternProperties to allow adding the bit offset to the node
address to be able to distinguish nodes with the same address but
different bit positions, e.g.

   trim@54,4 {
        reg = <0x54 1>;
        bits = <4 2>;
    };
    trim@54,0 {
        reg = <0x54 1>;
        bits = <0 4>;
    };

Before the conversion to NVMEM layouts in commit bd912c991d2e
("dt-bindings: nvmem: layouts: add fixed-layout") this extension was
originally added with commit 4b2545dd19ed ("dt-bindings: nvmem: Extend
patternProperties to optionally indicate bit position") to the now
deprecated layout.

Signed-off-by: Sven Peter <sven@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../devicetree/bindings/nvmem/layouts/fixed-layout.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
index 9bd34bd5af30..b01567f99284 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
@@ -27,7 +27,7 @@ properties:
     const: 1
 
 patternProperties:
-  "@[a-f0-9]+$":
+  "@[a-f0-9]+(,[0-7])?$":
     type: object
     $ref: fixed-cell.yaml
     unevaluatedProperties: false
-- 
2.43.0


