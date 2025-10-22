Return-Path: <linux-kernel+bounces-865201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64ABFC8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7446E2663
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C734D4F7;
	Wed, 22 Oct 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Rfg1z3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873834C12E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142896; cv=none; b=P2z6II3Ge85VlfTxXdfDCSth+Y9OzCmzakZ1+oO3rTRwpBf6tlpigzs5P4714lMYofSgAZt/IAqFy8FmcyIRu/h8yvdDOVFylw7KiD6Jr7O3ghoH7h5f3YwB25TfPOWq2SJkJMjhme3Ot+roIQF0u/D6+IgtmxSWjTMHdOMPHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142896; c=relaxed/simple;
	bh=a/48XUdptj6+42+EZNzEr2TY6pY90ELY94jo1ZmZXkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAqqj919nVqONQdoOEj1xEWGhyZ4eOJuUShZBl5llEdx485PPlNxB8dZGnJjSC9hgrRzsphgJIdmuq86HAi6wW9LGWlE/nFHLDCCpFH6Z4ZU2istOWYAJWcLP67K12Y4uDvvxjlNo/vEBKt0ku4w/Q1Hn61bqupd9WfsUytPGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Rfg1z3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-474975af41dso15804575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142890; x=1761747690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enLEHKOtNTzkrWiTnMIts9Lyjvegz+xp8xyikQdOjDk=;
        b=L9Rfg1z3roHTXQIeRfpqzNjizW8I2jNJUkZ8O2E2/ErB5LKiaGbn1lgE8KYfKaZj+t
         rBUlHpu6cWuHqixnlWUmXqUEVNgZX8U5RhlYQwBHFRBG9Quu0gwQh8yfLj9YdZ62RVmo
         6q2Du0YHLztR9zN9Ne/HCLMlyFJhN3sfYKprnmXlr40jlEIh1j4PDAAggD+V6OaoLUaA
         Dpm91pbsb2RysUdk8qEl2RtDFY4AwR7MIbLeiIwZ5QSUvX1y7QpQ+OwWMd22w0DnzGcX
         I4JSKWgPV9sHmdReCcDRjEXmWtKXAMy53oLSfYCRBhNkH7hhsZYekmQHD2pdiRzwqjdW
         blJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142890; x=1761747690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enLEHKOtNTzkrWiTnMIts9Lyjvegz+xp8xyikQdOjDk=;
        b=AwvcKSdG9I9ZxuvfEx/RWsmx2NGJwde+L4TGrJEHFZIqEwL3BCqnjImQEWc4Sw6+CI
         9Z0hCfExlzZstela83NFOFP3gZDqL0my2ztm6kEJ8TQT3ktqEc04kFOtg2ImKWnWkz9s
         dOvs6QMSKSUfOlR9GPt4Wu4tf0/qEUFn+dDyjNk1E0q1Nokwx6+UoG4GZf/AFgEzMHx/
         LZ9Y0pa1w++3M5jy/nIvywxmXSwwGtszYIhAlzXyNG/Qvf7s24NCBtZrOi1R/j9LiaFw
         doVRnGw17ADLHGF80E4SJ3JticXWO6Xai0xBcjucy72FbsFfGXk2P6M5GMdR2lFV+u0h
         95cA==
X-Forwarded-Encrypted: i=1; AJvYcCX8JhduCfoHpSxb5jUYyeVUugjD4KtEb0Ymoyth3X14FBgyUuY9MDjD+cihMzkXVy8Y6YR59eB/Q2SwD64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7x2oxDcsGPVOlVZGm9U0RNdQQ4Wgx9DbVWjXn+JJ/VGi4Vc/H
	NJbweqzRYE2RhuR5syryoqCncwhndoxca7bIo3o8QOIqqzinvJ/AuaEI
X-Gm-Gg: ASbGncvHX5RRo1EiVXjWUESwtinxF0zdPtTKV3qrhjKl2hbNebxOuPVA4Ra7Wwt5yDJ
	dhEB+O5C58Vnhjv9rw4DdstPGy9cTMNKoUlv2HzQy2oO3PHUX3ALR0y/toJH9eoIpbnG6sC2p4E
	ZfZpxvJMMHLJihBhxfLEJIXYL5mBeRxwUX255afmEw0Q9Yf5VBnjUVmgh+jWZNyWxF3oaGlZ6yk
	MW9VOKrKC9LCKYJv+wYuhyIL8VgPQjhbuFemZ/RO5od9ZlKbyQtjBDgvll2Y4aSmbqSYBVwSTgn
	RmdPnpH16RX67NMSzrv7uefTNwdOLw84z0utd4aL2kqsHNofd6u/7e3EKes36CD1Zj5RN98Kl6T
	2onmLWjkkAqJtzTRP3yS4y9RWqucgaNGb8ac/xVebemGw702HCgg/fKK7npPo11yO7ItwhUcDAr
	blQA==
X-Google-Smtp-Source: AGHT+IEfaZa8UfXSJQcTxYFG1UWlPPha1az3qIIfBFq7rCGZuYKGo9sPXz1gfue5h4gMcahe1PnCTQ==
X-Received: by 2002:a05:6000:2911:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42704d7e987mr13185292f8f.1.1761142889835;
        Wed, 22 Oct 2025 07:21:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5 04/23] dt-bindings: display: tegra: document Tegra30 VI and VIP
Date: Wed, 22 Oct 2025 17:20:32 +0300
Message-ID: <20251022142051.70400-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing Parallel VI interface schema for Tegra20 is fully compatible with
Tegra30; hence, lets reuse it by setting fallback for Tegra30.

Adjust existing VI schema to reflect that Tegra20 VI is compatible with
Tegra30 by setting a fallback for Tegra30. Additionally, switch to using
an enum instead of list of const.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../display/tegra/nvidia,tegra20-vi.yaml      | 19 ++++++++++++-------
 .../display/tegra/nvidia,tegra20-vip.yaml     |  9 +++++++--
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
index 2181855a0920..dd67d4162884 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
@@ -16,16 +16,21 @@ properties:
 
   compatible:
     oneOf:
-      - const: nvidia,tegra20-vi
-      - const: nvidia,tegra30-vi
-      - const: nvidia,tegra114-vi
-      - const: nvidia,tegra124-vi
+      - enum:
+          - nvidia,tegra20-vi
+          - nvidia,tegra114-vi
+          - nvidia,tegra124-vi
+          - nvidia,tegra210-vi
+          - nvidia,tegra186-vi
+          - nvidia,tegra194-vi
+
+      - items:
+          - const: nvidia,tegra30-vi
+          - const: nvidia,tegra20-vi
+
       - items:
           - const: nvidia,tegra132-vi
           - const: nvidia,tegra124-vi
-      - const: nvidia,tegra210-vi
-      - const: nvidia,tegra186-vi
-      - const: nvidia,tegra194-vi
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
index 14294edb8d8c..9104a36e16d9 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
@@ -11,8 +11,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - nvidia,tegra20-vip
+    oneOf:
+      - enum:
+          - nvidia,tegra20-vip
+
+      - items:
+          - const: nvidia,tegra30-vip
+          - const: nvidia,tegra20-vip
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
-- 
2.48.1


