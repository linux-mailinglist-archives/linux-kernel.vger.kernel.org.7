Return-Path: <linux-kernel+bounces-859174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67619BECF33
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 427C54EB4D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E352F60DF;
	Sat, 18 Oct 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ2MQRYL"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBC62DC355
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789529; cv=none; b=nt6deCC+oNZ/Uf399GK4pkQ6ee/lMx5NCAcwkby8MmXLV8GXUrVODduSomT3qirIC+vuaVn4ojbyTpwpNG+AI/Ix6Ve1GJfrE5HsBxEm2VWsTzB8t2OSjKvVLJTviY7/XLxyMru4/yIrswWjR49SI3OFPxnAGzNd6d4oVTCgjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789529; c=relaxed/simple;
	bh=icm+qgwvmlaIKVA0+LDLw72vpjzysCjTHSxFdDTSB1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0KA9wCOMEMQmcFZnYHdMA+iqRUrn91nzogYJMhOQDTaTX9lhAiQraMasoC4VATF0w7FHtbyg75AFC2GKsWselatHOAkpcDgebEJRnTNAvr5m59aqmZfG+oQKcwWmbNPoUFCtaFabEvl3MHLkchpprkJOPJ7D+WtVivOKIcl5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ2MQRYL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4271234b49cso140068f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789526; x=1761394326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTxzj/ZNzMCl2AVIVbzHV200aF3vcZBw8Pj3HONtytU=;
        b=CJ2MQRYLLMsPJq9nsKjEIO5lHAqJ7/rocDB/FyyLd2Fy2O81wMwQIru8UzO9teiFQi
         7/iqOCXCVJLkGhm+eh8w0CZ2RqkN3ZNYwyxILLFmbTK5NC4rhowgFRpGdH09QMYZctC8
         0ASVCB64mq3fmZSJLZ32zxdcT758r0ImPpyKu/vpWa54ic0sepzpr/5mFwOqmfrWh8CH
         YcI/Ff0yO660N/bDyOD2ltkkvVbfkPpQ0MHi1Vgde2QnOdQgUcUUhORXoYP5Kmz2g2Jo
         UdT8Z8aCwWLw7jkbVyQR545cisxqlINY9gi64zZcyO9Gf14/aVjRbN5lvCYll5XSSpsQ
         FMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789526; x=1761394326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTxzj/ZNzMCl2AVIVbzHV200aF3vcZBw8Pj3HONtytU=;
        b=CHNBydeEQ45juygO4AyWSGE6MuJlmbW1X+zlra6cxl4CQDIa8+lkSyMXM8YuTNkZ2U
         WeKmVLNUpwuwPqnbhTIeNWLFfo07BG1tbgn3sOgah0/M/mNjb/2xeVGjulkZDGdWN76D
         u4BdDms2X+AjdTlPBBQPBdHjEcKZOkRwtDtJ5nTjYM+z17c9Yon+zXVRlDHjs9X00yex
         UbUCk6WpMN0ohozCcHtUkZQaitHUN4l/658gaicncRT18NqTRFXJSzP9nlvF/XiZIysA
         fQyLq0NBuCMDaA8hHMjq81c93rIrjR9jVQX2u/w5Au+5/rE4mhK7u68CwSlcWnUiBrqI
         G3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUiVNilm1Vgwjpizr/spgiS86JEl3mfj3MbThfFGrPQh7egtX9CovbSKb4Gl9g9v2fKPXNIhSy6CDXj4ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjazDEfoU0CdhIxdr7P6dXOqEoX/Ib878iS+MgqL/H3xDlWVz
	SISyEDWujJ/+8fR8vOe5L8IgnAr6gJhyScwmQuW/4C4okMws0xtL7EvVS4FzWHxl
X-Gm-Gg: ASbGncsnND3uFP1eFlic+9vsHStYEFZN7eOAiGp0YID0+Skr5HIOPgRYtb56lD1dyJm
	VDkzoc4qRL6uQkD9Y0zGzJLMiZuUtSWCHytUtaqGI3InQJGCF2+t+g0thxbLCX6vdcWSxDTvSE1
	btgDnxm5yYIY0botYGegxks6HYBJ8N43UX7zFBBky6jMrYdMTVoKktJHL9MdmYEEbXaezY7SawB
	u3rhNEX96CuSA86q+6piPmKWm+Uixiz3yJF4bMuO5Bcft2IiuisQrPdWyZkuvtem7NZrzSiJnRp
	arWk+ojHLrQK4JCH11SDtbIWkw9lyWvY6Y+Nz5XVQG89fG0MVrW5biNd1NNSaycQxb8RV7LAZg3
	60CpfNcaD23vPGL7vpgJy1sU4a4+8t2cFQNHOH0n2Jp+aWDfctNWyE3Y33corvfou6j/yjDHpuY
	W9t1i29NpuQqXLzly4kouQvFZ5bhEqzHsdYyJK40pRlEUX77Nb+Is=
X-Google-Smtp-Source: AGHT+IE9WrMpGHlOtq7pCFaMxpNHBwkBQgyPgdXD8PMj1DfIilZHD1dWISX0v2wrGK83GpPxksi21w==
X-Received: by 2002:adf:a3d7:0:b0:427:7a9:97ab with SMTP id ffacd0b85a97d-42707a99873mr1610059f8f.10.1760789526007;
        Sat, 18 Oct 2025 05:12:06 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:05 -0700 (PDT)
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
Subject: [PATCH v7 06/11] dt-bindings: altera: add binding for Mercury+ SA2
Date: Sat, 18 Oct 2025 12:11:50 +0000
Message-Id: <20251018121155.7743-7-l.rubusch@gmail.com>
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

Update the device-tree binding for the Enclustra Mercury+ SA2 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 30ef03c53d73..72cf04b22a08 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -62,6 +62,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury+ SA2 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa2-pe1
+              - enclustra,mercury-sa2-pe3
+              - enclustra,mercury-sa2-st1
+          - const: enclustra,mercury-sa2
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.39.5


