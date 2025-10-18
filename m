Return-Path: <linux-kernel+bounces-859172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF19BECF30
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8A4EA72E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05CC2DC76A;
	Sat, 18 Oct 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNXybClD"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B82D781E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789527; cv=none; b=NkwFxMxyb2Xff17JRQsUn99c0M7rrqaitQ6AQ4qUeh/7ItAo4OSNvtXImyW2Pr1K3kOQEkZKKZZz972C4u1KNRDOFHuQtKGeKET8f33p43RsHFkhRWaGirJSASp1J/JEuHRUiO5HBCaH+UqEZoV57z8SBpUQnowpA1Hw3bNvPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789527; c=relaxed/simple;
	bh=p+HtOliJIpdvfgNiu+HTRNqZsxXYbMjiU4izC6ySwGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzhwZfvE4V24viD2N9UoKFIjjB7a5wEwn8CLPf0czQgsa2XbN2f3+wL833Iywl4UJ0cPRcaeB101RBDvFoKZjwh4P2X/ozZhTnmuCSqT3C0l4wm9D8TVoNkjvtPDgAIU9mjCgTiChD2zgm4QUCbUck/IjK+9s+lQMCCWJzUYibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNXybClD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426ff579fbeso322001f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789524; x=1761394324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8NQa4L4CG7HoZPqJ8Ok32X5AepFgS3EiKF4/VxGY/g=;
        b=kNXybClD/Y6DTcupWiSQR7DYWza+FhEG/c1SAPMv88FHPMUrqOcOf0InhbtSS71YoB
         ahUJ7Yh11A15pUM7LPJuFqAWfaiAABtnHgoy6lavvb2udghF1Q3fqYuvR9KmnKx6Suxs
         dOju/741mf9zlyebSC2mUecPgzeQLFyVmbU4DBlvio+mO/xnPiAGoMV2pzXoyrWzveQe
         JzfPWo3GNenduB+VuRaRbaEjLgHfDol7IZnxg6l9x8dAmJiU7qahTC1glSQRIgaym1O6
         ykV0xzx4srN8uX70nK7hCYdegTBuvKOsYn6PYmpTjZoBvHgBEjXbrJWu/EjMF0Jky189
         SftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789524; x=1761394324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8NQa4L4CG7HoZPqJ8Ok32X5AepFgS3EiKF4/VxGY/g=;
        b=GLT60RlrIKn1rUinc0nC/Zec2lVefxNqTx4oYhKmcgTK4ec1v/7zUtj/F9EeWo+/um
         G2eZDmTuOQaMBTeeT4GAEUTYV42I4DXooWPExHsTeYUI57oVipXnxPy308+BvQiCyvJ9
         ErBdEjMmTAOB8m9o3D7RhyRRUlUNDh4kFMCsZFGIVZ5P/Q/LljXmYxeUzmUG8Xf9mraf
         uUCwXfs9rltSK5SLTs82o7KpySl1MBP69CSZGHQ7XWm6ejv6V4HWV8iv0bN8KJ0yqpha
         R3MBHflJIVNRlIzr6Q3V7KFomR9K+0fTtIcXRxwy9MozFPf8b6ulCvwOKxzRDiHeg/vN
         al8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQq1iERBpwNYiT4xJUAyzpx1WDA996mldJdkDy3DWmwc9MFcdoJ52k3QR63nVqrbrlSmeJZOJ3Ws5RdAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExkL1saQ5Jf+Zfnilh6nn11OUwThLMDKyvE0ofMIQNM14JGDs
	K0RvXxCXmw+0FpuqPMmh5auQhBdYlv22/dAQAAN1A0pzyu3Gu+Xpt1eY
X-Gm-Gg: ASbGnctyxCJRK2WfaPKV1Et+ui+D9MzLk14cMAoi33ZC/YRjKaJDRJFkXWjbQzlCGeN
	J4q49bE+STXnuuc9r9rm/Y6iav2kqRj/VvS6aCnBAbdvFHFufIBXXrjokRHOxanqaIpT0PGU4Nj
	DFgijLWQFbRLb85HaKHEorcvAPejDnk85XqPjYRZsDLAxw+eRI71Mk4ajZocKy9NACNngbGcPpC
	smX/LM2r96Xmq0iD0lGZk0SMFEQB+CiEb/oO+rplGnFwkRz+MoWZJUj02MBuY8J6MbG76YBttbO
	BcCajQGCFJG/QRm7V9HkGxxJ1/sOUjjN7cyHm+BrR7zE9sA21D4TcDUP0ghdC85cI+1o4u0c6Gl
	WcIPDINiES1UUc3ubDq/vDWJB8phmX5MD1JgS9OqBgOAgZpo4x34Nsf5LcydhJiPnmwahgUqKVT
	ssQ44EZi8cTwsHXzG98MSDl0MrIPCsdcoE33SociLOc7XKWtYqRpw=
X-Google-Smtp-Source: AGHT+IFMimUuU6vASBX3/3Y6ZmH+XpYxSVsS9ATmgH0fnw+pTkO3H29jtTRlJ2kDPv6y0tyObHaGNw==
X-Received: by 2002:a05:6000:181c:b0:427:529:9bbb with SMTP id ffacd0b85a97d-42705299bdfmr1908900f8f.8.1760789523682;
        Sat, 18 Oct 2025 05:12:03 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:03 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 04/11] dt-bindings: altera: add Enclustra Mercury SA1
Date: Sat, 18 Oct 2025 12:11:48 +0000
Message-Id: <20251018121155.7743-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018121155.7743-1-l.rubusch@gmail.com>
References: <20251018121155.7743-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DT binding for the Enclustra Mercury+ SA1 SoM

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 30c44a0e6407..30ef03c53d73 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -52,6 +52,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury SA1 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa1-pe1
+              - enclustra,mercury-sa1-pe3
+              - enclustra,mercury-sa1-st1
+          - const: enclustra,mercury-sa1
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.39.5


