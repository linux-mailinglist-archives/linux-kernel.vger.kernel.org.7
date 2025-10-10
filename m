Return-Path: <linux-kernel+bounces-848173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31BBCCCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 494404E559A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEF285C9A;
	Fri, 10 Oct 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlxP2ush"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210E26158C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096875; cv=none; b=E1oKlx/eeQNK2zVST1yHtifqiTe679AM0G4s8Nkyfc0GhNtUxHTLnmuW/Ntx1OJK7Iok1D8yRmgPW4wU2puJiatyVK+WBR0bAUu+oXH51NTmDPiVHwDEdNtePaDR5toEqF7UjXf3/fnw7ZMbjpST8omjsp1i9ZP6I5gf2KY7tNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096875; c=relaxed/simple;
	bh=j8Hd4Iay6zYNggN2mZzljQRaAldF0uuSlvshS+04klw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7PI1y6TYuk+BxRDRjCWKfY9XrKGkmEx/m+belRQTEH8Iu/X0lNZMnamrAY5rT8Qy9Ay12KxtWxiNVY+Mguct2pj6qXQ8T8BrHzJdMKMK1vXHIKMwt/5TxOmARL84yCZ3dzxKskhSsMQPBS5WfTQuycIWYVXF1sIyrcmJ6ld/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlxP2ush; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-28e8c5d64d8so18785085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760096873; x=1760701673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6G7I4yZCC3xCLDmgNXcqXWYF504/swrtgR3bZf+tR8=;
        b=VlxP2ushFPA/dhlY6hp1IuLoaC+4Ave2aVoW4rvssr3XZoS8/XqiNYadxWKo6KdywX
         O85lvh33daoO7gFlCTXPTchUYZ7SCnYox+bpmXpXZgaPE92IwehLJ7cWOwmupouToONw
         icPV20PQvwaW78IqPfas/rgxAwiBcwcHN9Hrk4TwaV2ZkhlfSTjZwOUx7rVE0Dl0jw9Q
         g1J7ZuSUWFL+1GoPTwa1lOO0I7/RIMXaml5e5MxOLT6DeM0upR3FGoQpd/9O3V89d/rI
         rQbZW117IjRQxlD933uHM+DlRoR8QgmwJRx1syger0cFcIksy4YcmHnZazR42sjlDkP0
         HQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760096873; x=1760701673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6G7I4yZCC3xCLDmgNXcqXWYF504/swrtgR3bZf+tR8=;
        b=TI4TBB7ijIj5DRRd3Y0vYxIsvu2sy5xDmZSYLVJCHw4s6wS4OOyHAkFbbAT43jTdHI
         tmucEp1vlJxSWFTY9ljGrZIPVj22Mxo38mDuQxhdrOoUrcxGCF1CZ6Oo6/FiUSpKf93M
         LsJAx5q1JWwmL1oTG54Hmnr6oRmy7zOTGZiXLCJMF4EUCXvKnwGWJlMeLTGWdprFFLBI
         2Yp5Uf+36HNQTGaMzIPa1jqQcvAF6TZJDIS/PNrJxNkfNqNngRDZYMh/MfLv2Vocm4W8
         brf1Bow/WE/8hGC8pk1GIGewNEKnL4l+4Wql9xwH5NpHJ7X/fdLY0eQdv4B1sLbHrThq
         qVQw==
X-Forwarded-Encrypted: i=1; AJvYcCVXa948UGsUzampVHudURh9HpINC4pHHe2bSGGkgwEOHzh7eo91/RAF4W3mcVmkS5W2Gt2epOfqHNcx3xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+con6PPHX8qZ1JOad1ROHgIB4qrh5Re2I2LEL4XZuweJSAED
	17tJKTDpSfWW/JsqYBchHmqK0s10Mf2by2hbyXjcbT6H52KLsY8AnVck
X-Gm-Gg: ASbGncuQSBRjmGz1fuqHiNq6B/XSjLmigfeFSu1mut2F30LPc3D74G0os0LfeWfg3Uh
	17VQAn8oxcNTI/9LursKqBXzSORDeLOTmDEZ1IG9wy/G1NUUswzZidaIpNzQbsOyhMhR/N5kIt5
	PZglkPGYTJikPGHem1JUDnODsdUcXgl/B4qnbqOO7lppUdDSfLfbGKIVxuPzjMQrEWhxLVNf+u6
	EsfowPK9ujHS2Gc1E/Evn/q94K3Jz4+CIQ1CyCfpSE5Wp00NQgjBTSCHOKzU/c98eR/Zt1b4uKb
	ZrnF+ZTqICU3tnNs2Z4nssasdp6XfoVFOTTV4iNxFh1Xk2Kri3KDQsh6mEQR41jYIIjElqavO/u
	eGO00o6eXScjN+X67Wo1VmfGiSumSKzB46otLTS4Ad3tDIUIxILxtOIXL/FysK8L7JoA=
X-Google-Smtp-Source: AGHT+IG0cfNJnLLfwDicVViuXeEoizTyF3mRCh0vPGnpWvLjbE/ACva2N0i9tIjdj0MQ2LPSn8nOeg==
X-Received: by 2002:a17:903:b4e:b0:28e:acf2:a782 with SMTP id d9443c01a7336-290273edf3amr116504145ad.37.1760096872925;
        Fri, 10 Oct 2025 04:47:52 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0726asm54956535ad.72.2025.10.10.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:47:52 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org
Cc: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tessolveupstream@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add QCS615 Talos EVK SMARC platform
Date: Fri, 10 Oct 2025 17:17:44 +0530
Message-Id: <20251010114745.1897293-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <qq4aak33bn3mqxd2edu6zgkkshby63mmitg7zqkly2rj4c2lh7@4s7sndb7e2jr>
References: <qq4aak33bn3mqxd2edu6zgkkshby63mmitg7zqkly2rj4c2lh7@4s7sndb7e2jr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding support for the QCS615-based Talos EVK SMARC platform.

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


