Return-Path: <linux-kernel+bounces-852519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F3BD932B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 916BB4FE5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73D3112A9;
	Tue, 14 Oct 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuUU1FOX"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC63101BC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443360; cv=none; b=brqFuQt4iQf0/He4fHDfS0R1g+RSP2c154UroZGzIpMMact1DuIuQj8L7GDrfQEyG083nCzc2dNNUPbdsCi/aEaIwtNawHozXgtzYuDzUrzJmQG+X2jrtmoiztoTBoi+nTv5gSaqNuR0LaRXoZ1aFpLTkFsXqYvQHX6HU6ucBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443360; c=relaxed/simple;
	bh=j8Hd4Iay6zYNggN2mZzljQRaAldF0uuSlvshS+04klw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCqk4Kl+aDSzO2zAV+PLHgNeH4dE3WprwGF8GhkkQBDLJ6mVHbcnGWhrPZEmONGgaGAk2o1kgueC43E67L49wU4BTKegnCjV9cx0gkVP/XttvU0ahWH3Ksu4VdEb/5ddXwqOrv/giLKAbJFtVYfw71qRYjhOt9yPJPxf7GBkcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuUU1FOX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-271067d66fbso50949895ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760443358; x=1761048158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6G7I4yZCC3xCLDmgNXcqXWYF504/swrtgR3bZf+tR8=;
        b=KuUU1FOXPTNkARbI4s5wVdCXi1sYFgWo9BL/IB2vcX1vSh2QKfZtVW8eLyRum7SiNB
         yiXjNTZhsEugRcFjDIABImZ/C68+tTGOOLQ2wKbCbRR9HnVrpNzmEczaScIgkY07iMYj
         anA/ASI/rrp7C8CXyIGZdUcPk1rkMTjrJ+1Ua2d4TdAfmqYJIGWr/Uhcg2CSg3Ktapg+
         MqNALFIdDASTx5VE5S5CcMC5GwZvifWmv4RowNMrRNgJh2usyZBZ06zlRHI4vsvG/fj2
         vO1eLDhBVyQkKJlg1NUCeBEoobf8Qusew34nR9uocBBPjWSHGGj4eSX1VEk7q8gEELcH
         sa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443358; x=1761048158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6G7I4yZCC3xCLDmgNXcqXWYF504/swrtgR3bZf+tR8=;
        b=b4JbBJLCRBkMDbyeZNfl1TJbipWheGWIYRnxDRz3WpZFCCtXcGWesPYV4t+YBnEeNF
         qwBtV5Cn8SIqZZ5N0U2goqPxj2PcNlwZGXMa7idi6M/jxhmvJcfDTJD+8mHmFo7FgQ5d
         WKBXqlfDXA66fQrOtuhI9MIz+Edr4jTubQI7WwYSouBU2UBWsH93XsDXsyeUMb3QlonZ
         ItvAOGdriDq9NmQsuhXbYqTCuuS9WQL/33AdA4ImU+cg7OQxuEOlHbxDYCw92M21J4dA
         ZJf1hH5xP8YrSvLiotAHHH4EDMMrlpU6QjN6KcgSG8Dte9WK0vyelWaHPaYHmCrVzMRz
         WWbg==
X-Forwarded-Encrypted: i=1; AJvYcCVARYKY1FSOFYWhV652LCQJk5nKRwub9KGqb8/1pOeudJNnNe6CLYLSoiQnpRGF4nvEkPATzFNO83BhmiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlVux5QYHsEVUNoswJBqFOcU50o746AGOJC/LKeHok0CcwJQ9
	AJmNlgwNA9tJnb7Htdbo24BJSNSXUk0HS6tSG9+FTmztmEPo4pW651o9
X-Gm-Gg: ASbGncvhaYgz6En0fpkFijCf/CF68wU8UTUkFSWGQ1ki/xcKqrhsMaXpu8xsY85cEDY
	I4tFAcaeG1DOCweWJFLrGbDtX/3iCXZUyo8L8B6ONDPVCKnYkhOvkdMW2XuACr0HWJ5LT5SSC5+
	Ny0IrYud0mjlV8rwQBfCYoIstEM5CTX6f2Qa0KK0TC0diC1GVOdiQK/F+Hg/6sPx3xAwCZjmVWg
	4WtJ/80gUSkK2cIMuNfYftgY4hdNpSUyY0Gk3kngaHi1kr/iCPc7iSpl4111hcuIGa95lJzRhLW
	MUJMdiR0wZ2zsm56fh2uroNbT1bxmH/wrDrZqTyrUza3nMTSMcF3AJaS+KYqBJJXk+BiFB6GQ0y
	p8bdosKNBAE8mcHpOmrAqqEDq6H+ECG6v25UBmCfdFQDZ3N8SmmJ7i63Png1VRniJeU2Qg4VxwI
	R4gA==
X-Google-Smtp-Source: AGHT+IF6bVnGm+ESxRb1/rcaQKUyx2va7Y31p/cGXCJmYfYaOC9VWMsGgXgfBjvGWAXXsYrIVRnOLA==
X-Received: by 2002:a17:903:faf:b0:278:bfae:3244 with SMTP id d9443c01a7336-2902741e44fmr315065125ad.54.1760443357518;
        Tue, 14 Oct 2025 05:02:37 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f941a5sm162808455ad.127.2025.10.14.05.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:02:36 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Add QCS615 Talos EVK SMARC platform
Date: Tue, 14 Oct 2025 17:32:22 +0530
Message-Id: <20251014120223.1914790-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014120223.1914790-1-tessolveupstream@gmail.com>
References: <20251014120223.1914790-1-tessolveupstream@gmail.com>
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


