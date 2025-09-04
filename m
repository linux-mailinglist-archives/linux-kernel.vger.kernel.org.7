Return-Path: <linux-kernel+bounces-800855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A1FB43D04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D6C1C80B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CC9305074;
	Thu,  4 Sep 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL3yJb1l"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAF3043D7;
	Thu,  4 Sep 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992184; cv=none; b=MMjDwP+jw05gXO7TO9LsSEYmMXIEBbYWiSjnKe9LSG8SfPFkbvEeufJBHVbNAZ5s4cxOJjwB2994SidI0XWkH1U3WNqnxnG1rEFJp2aZTiEFNQMpg4SrsAB1EvDCiIQcDhh5XkeKb8le3RVQ5dkv8Xso5fEWXL1YjqaSW7iAk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992184; c=relaxed/simple;
	bh=Vh8pONNqdH2cxr4ASVNyZwGHW7S+J8hy1ibyRDo+Ft0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1re5A6dZ/4Zbj4U+r321zOiCXYV7JriIW7E0ncX74zW1IIGI6yisj46Nxv7lO8otAE7Z3cSTRJLAJjVexMJjHwgesmXqKcuF8xPItPkdPuC6VdzEylGboHBKSoewYiBf0GRS3JZCxzb17y0YXGqA45NbzQv6Vj0Dfz4sRAjU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL3yJb1l; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042cc3954fso178972566b.0;
        Thu, 04 Sep 2025 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992181; x=1757596981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1TbylZkgz8Mkd/dwqE0/Jwk1LwcVvsjwyovQ8CGLbA=;
        b=dL3yJb1lbILpDDZ4zfkUxKEFr3yVwAsrFPnSLyTLlEB3X4SbBj50gLGKuK8H6mClxI
         avsedHemm4fZEqpepxHXzN5sIuDl+ht1zyBrT5+TT1WdoKoRQPPkibRYYaT90Fbj7dHp
         R/DYyq6VLCA++mIJ6IH/rINB+4gBFEXH9Upy7WxCUMk9Dzx4hRumUCOqH18JN/kK3FRo
         BG7geWeY8MsZZNUUYu54IaiNvQT+5dUqH/miUUwcqZ5aMfZIINov7Ml1kmU/o9Jle0xE
         yGqWHm2jbWYnTGhscIj5kLPZ+VA9/zrBsz+rn2TY3nUY1RFTfZU0DU2CQauR994DI+/c
         FFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992181; x=1757596981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1TbylZkgz8Mkd/dwqE0/Jwk1LwcVvsjwyovQ8CGLbA=;
        b=AJGGKDzu3LQiHShqCI+k/TXyTNuNIm9YfDg1/GxFEL/OGA6pSe34M8vx9LajI6EZp2
         y7a8+ikBbv99V341M+YKUdkyOpq8xylTZv8qGn4mZMlOawsX6xh7r0m1h7kaN30bl6to
         q4ddGgWxfed+ieTXh8H6NZe8rIlzHhQNmcCAAOn7NSEW8MJcjJ0B7GcEQ6nwFAYLsspW
         oFVdiYrHr0Ndp5uji2pYRUdclL3la/hNn7Xymp26kNu0JCDB3Kc9Z9sOi2K+Wkd+EjNF
         RB83vRsazRwkihXIfULXzwS531GtP5ogixisjWRQOtxAhMQDqi45BmE6JdtvN9jB4pL0
         U61g==
X-Forwarded-Encrypted: i=1; AJvYcCXD6UCkxdVBjfYKrL5QYs9JzuLMOoWJ2o4KfviL52s0FeoOHruNKfjjVV6hC/kHwao47p50ODkz1Mzb+so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv588cUQdmw9+aKStLZrcMlWUfHVbIaesIMUG1pyUe6yfxgLHm
	fD0EoLbtY+ekwArZ486IIfktVP7SMbbfHmhYsvwxwM9CVeYH7KLtnDJzCj173fNDCMo=
X-Gm-Gg: ASbGncsVA8o/4hGL1lHXgibV8isM11rKdVP+L/EZY/yi/kAavF9HIo0BgoErBEUa0o1
	9UqSpt3mYi+DzhNToG2BNHfBLznfjm4Bmlje1+8LMUygsv7h0YCDKF5UpNFWeOf2AuRFOjdioUK
	xUHbtzVUl5WJBaHb/muK+rLrq2KgBWUwTjkFAaW1P6qfBEaVTejOCfsMsPTo+02hfc5H3DH11hM
	DkdFnpbfl8Y2FVkLXcdNlWGWzYiBMP3imYVMXqmEIWZ9FmK7VdhJDY2aOvGXYzXV29GTKsxkRKG
	eZgAY16h/HH+diarZi3Jjm5axIC88IOndr0JZj3t9+mNH4zdsbVZpP7KUdvcMxDN/4ln8xR/eTw
	ZG5qNfGYSAmN5FTXP4ZPDSl6/n9AddozuQ5UW69ihTEH5Hq5JEE3cRFs/LmfAfqVNKd0ajGP95h
	PfUMN1UQ==
X-Google-Smtp-Source: AGHT+IFsHDPw3fDw7XllG3WW2ZlGn/8p4gGWD+NcAtVtnkOeIC8iERIkVgfcdB5iX6oKNeHXenMzdQ==
X-Received: by 2002:a17:907:7245:b0:b04:76ed:3ff5 with SMTP id a640c23a62f3a-b0476ed442bmr448933966b.40.1756992181086;
        Thu, 04 Sep 2025 06:23:01 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046d0b0135sm372121966b.73.2025.09.04.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:23:00 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
Date: Thu,  4 Sep 2025 15:22:28 +0200
Message-ID: <20250904132240.36819-2-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904132240.36819-1-stefano.radaelli21@gmail.com>
References: <20250904132240.36819-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
and its carrier boards.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Added Acked-by
v3:
 - Change compatible string to match existing mainline format
v2:
 - Add symphony carrier board compatible

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index e80c653fa438..1cdb6464e920 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -106,6 +106,12 @@ properties:
           - const: toradex,verdin-am62p          # Verdin AM62P Module
           - const: ti,am62p5
 
+      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
+        items:
+          - const: variscite,var-som-am62p-symphony
+          - const: variscite,var-som-am62p
+          - const: ti,am62p5
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.43.0


