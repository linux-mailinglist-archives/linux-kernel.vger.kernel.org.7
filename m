Return-Path: <linux-kernel+bounces-814081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A067B54F00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C11CC31C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4330E82C;
	Fri, 12 Sep 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7dxhjpr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC430DECF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682795; cv=none; b=MzNvtn0bY+ZT5OsvLwrY+DLnb/2zaxil+bokcYqF9FFmha8gOyT7bOJJQwABkfn4BZCqp38ErLelHSuLuHsONebXmK9lcV8cthgyMlrAX2GKWqBCD7viFDiensDpWs6QdxmXv2iY3hCyCIKPgK4KBlsqyGZdNZ+m9yhzm4NiMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682795; c=relaxed/simple;
	bh=zDxzy6kp4ylEzSSnp4BJo+hrkNtna5+yUe6Yeev5icU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYvRyO0CWf1FUCTmYm1iONmx28Mn12FNyVn7ATPkM6qUvGvwWCQ7RPa4fFzVqvz+pKrrR6JWYn5KVV+sJFEQvJDZpgvAyN0VFQaiaXcsd9c/TeymgGsW+JhTFd/Li0juEUQcYU3UGKiLo8E6Vkpc7H2tMpCcMhZZEnHVVKPnr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7dxhjpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E498C4CEF7;
	Fri, 12 Sep 2025 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682795;
	bh=zDxzy6kp4ylEzSSnp4BJo+hrkNtna5+yUe6Yeev5icU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7dxhjprLVqy14SY2I2X/bZy001rYno8uv7HccEI2XdfKseTTmC6n6CDA+pmPF8n3
	 j2VLjZMZ3xfI3oBtez56Al+PFYoGmyhh+QxqV0C3JvkY4B9xIn7IykM88nSIbRj2ad
	 2MD0+VZXH9wVsqtt1vVYTwb0I/YlXHo8JiRrInuDqle6ULpvlFiGoavqTatyIhG1XJ
	 jGO1rv2NDLtHsYJVH2+e9mug/S9Sg5ac2eXBFae8ZE0v0dch9TCi412+AGttyCtJJc
	 CWYqex8m7Q0DiVf9Ha8IiI1MDBO6A/NZjt132jnDqOmdel/EiRKSt47MKWp/iJMbwF
	 GANeUcL+Oib/Q==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/4] dt-bindings: misc: qcom,fastrpc: Add GDSP label
Date: Fri, 12 Sep 2025 14:12:59 +0100
Message-ID: <20250912131302.303199-2-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131302.303199-1-srini@kernel.org>
References: <20250912131302.303199-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ling Xu <quic_lxu5@quicinc.com>

There are some products which support GDSP remoteprocs. GDSP is General
Purpose DSP where tasks can be offloaded. There are 2 GDSPs named gdsp0
and gdsp1. Add "gdsp0" and "gdsp1" as the new supported labels for GDSP
fastrpc domains.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 0840a3d92513..3f6199fc9ae6 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -27,6 +27,8 @@ properties:
       - sdsp
       - cdsp
       - cdsp1
+      - gdsp0
+      - gdsp1
 
   memory-region:
     maxItems: 1
-- 
2.50.0


