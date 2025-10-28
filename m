Return-Path: <linux-kernel+bounces-873068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3251C12F86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF0AE4FCE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEA22D8797;
	Tue, 28 Oct 2025 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly77EvW+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84C2BE03E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629583; cv=none; b=i5RKU0/hfP1kWtFk4/RW6+nfdfIYQn/3c3VHxlWGrVYKbksBkYXUBeLtNeh/vmT28wf3tSld5GIvZofFNdnpCZlDfNO1psJRQhFweXe5XCFRiAH9BIJ/tLTsj66Os3STRjQ9gQLbrLvQBxFVrmEq79105Ckvk/hOC4PNFIFNp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629583; c=relaxed/simple;
	bh=vN3JGKYOBAUDmMzE1usOMoD0mbol+a85CNP/t1Oi0OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luVUeyUg2RDTteORdawZMulIzpK2dTwFvpxqHz+Mu8DGPp64ySqeOLMB95Abi+nmU6MdO1G0V8xeSEEF4ZGI7LzM9r7oqMY2taRxW8aridpluWG7I9zjeVbsuupPV4SHu4tfUKfXAZLyJ9VCqnUgGfgEUCxn8bGqf68+UBYvbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly77EvW+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a226a0798cso4523875b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761629581; x=1762234381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAmaHM3BDp1VZW/oTEWfvvrOlAs/2vEDtfi5E2o6+gg=;
        b=ly77EvW+3mNfln0nUkEsYcgiR/hhfyRexMgN9GBlGFzwyENBl2VBKnmJ/Hjmk2460o
         VvyYm/qKoyE6VwxMxYDup8+Ni/OqWBmogfD6A4LUx1JnGcuV7Au38mo8XuOO0E/hm6zB
         0Z7QnQHiZeN/v9nLjnhAbOIzpB9TZ/0LtB+NKiqXdQT5MynMe4sCS0T747+7En5Cqk/q
         yERwFpikI9fXoTKW9tFGd+bt9wxgg2M014QRkH91IsrICglrDHMrMuNOy82vnMrxAEpR
         SdlBEM2Ex8ujLePrcSfU7ZmBAWni1jgYi1XScIyrOsUluYr7LQovpaE1vwucMsF5ik4I
         m/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629581; x=1762234381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAmaHM3BDp1VZW/oTEWfvvrOlAs/2vEDtfi5E2o6+gg=;
        b=TFRxyd3HViOswCmp5s8qLcp1c+u5wcZmTFswF08HiReEkHcYuqVSssTCu3t2WblAOg
         QWOXf6O06kb26k2guraTWlfLfejr42IYpDXKnu5RC5fnN1xEoFtlXXPPDtzbHZCHD3bG
         DUQbMmtQrnRD5rmzxf8QPfBk05ZnF6BP/dw9l/XRvstdWXxpW0BpTXROzqpgNwe0kkWH
         sybSfEewgjNmDSINYMdiI7gtI++myPjjsttWLn660OdLiL3bbuWZOY+7MT2zhwyaCV/Y
         +KbMPdBqCN54SeKEmiajrsI28PqsLas9ssjm0ktrs+uQdoZ7F4KvCB4PfPh19Amhkvng
         1SFg==
X-Forwarded-Encrypted: i=1; AJvYcCW0pVO2ntgVNih/HS9kzWIkQoddftfy2QHCRH200AzNDksLPhv7QdIngXz4jDVbzaJ56rupY5c9tHE3qow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5nxuSRJ2bBiT35OCicuY+MsgspkMDi4G7lPH7mKPAi/HwWgN
	8uSX8A+Hnc6w9zG4OZakVbBC8h4azO9dt0AnoumgWHPFISC7rHSHqfA4
X-Gm-Gg: ASbGnct//c95XLXVUh0DjXjJ1cPsCfZBKl3ybaUXAO7c1Fk5C7h4msrZe0YFQ1OoRNc
	STldIzragvP4z7pNo2s8Xi2wgBtZT9V/o67gt24eXJ0vWOX+9V8+uR8kHDnbYTpc9NVsCgLJCEM
	KCf7BVtvxDRAmb7NCPUAYKunp/7WEktchioE9oIZLnJPFuDGioWiFOKLp6bopIy08zMFDwIRQaj
	r26aEWf9LFqHSRdePLzIgSW8KWjmTbemVecrdubHX4aa/sR4NPOQGrXGqJDPnb3vbiheLzuk5Ol
	9oJq906bGrTdQq7fs53hlQHaE6atR/OT7LixiubQKV6680iphVzRd5Fop9egX4DhGUJVXeRSk56
	PfbJtkvziC3ZHfGEeSAcz12r5sHqYwy5rFW3D7sGX4kULpa1uW7g52jV8AO3Zdlc+yO1K2QCVzE
	FM4uBdoREWkhtMqdmF5lJhm8BIU+vdWS65BFvJ
X-Google-Smtp-Source: AGHT+IGtv3T6xzLRoc/T17G1G0UenDY4n08TE7oRtZCD01YO+/5ysGsK1isMOVRSEjqhKLtYZl35Vg==
X-Received: by 2002:a17:90b:2402:b0:340:29cf:2390 with SMTP id 98e67ed59e1d1-34029cf25d1mr1438708a91.35.1761629580917;
        Mon, 27 Oct 2025 22:33:00 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70645fsm10649477a91.3.2025.10.27.22.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:33:00 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: talos-evk: Add QCS615 Talos EVK SMARC platform
Date: Tue, 28 Oct 2025 11:02:47 +0530
Message-Id: <20251028053248.723560-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028053248.723560-1-tessolveupstream@gmail.com>
References: <20251028053248.723560-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding support for the Qualcomm Technologies, Inc. Talos EVK
SMARC platform based on the QCS615 SoC.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0a3222d6f368..a323be3d2ba2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -862,6 +862,7 @@ properties:
       - items:
           - enum:
               - qcom,qcs615-ride
+              - qcom,talos-evk
           - const: qcom,qcs615
           - const: qcom,sm6150
 
-- 
2.34.1


