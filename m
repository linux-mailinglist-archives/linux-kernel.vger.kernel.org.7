Return-Path: <linux-kernel+bounces-825582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB0B8C44B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13D07E2E38
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBD276059;
	Sat, 20 Sep 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3VquYGA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED928246763
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359565; cv=none; b=saQrHS04Uu3dKcovQsA9kHd7QH4Wc+gEtCtPRAw5JAxQehCf1tqYLe/ymWxwuKdqk/P8pKab1iOZ3kaXp+qpExZdBlbRCqMQ1xO64dylKqOgE+Fo5rrAw4Qq9ABsxMyxv2EVF/zWDrvUssRxyTp8eGn7LQP/0C+Ea372UFBnfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359565; c=relaxed/simple;
	bh=t75zUsI42igRNRnY9BzosxkBDZi21FNYwOR8SS/a7xE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YolNBQ+5NL+JkbDQeuG8LzdtWh2WZFw272ZpDqkdO4jQzi9ehZ3rGd0cLZcKKbjQAKlSQa/oTuE1SrsSvdGEW4BoWUb36SpiNSkN4J2kaLePnfEqXdXE1QPWHdxtWX4eehee10zS9/5L2y5YfoCwqyOqN3Tu90E/l+Jid8JcqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3VquYGA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1304306f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758359562; x=1758964362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gusk5zt0HMd76bDL+pQKEW4NdN74ndDk79BJJ1+vw8=;
        b=Y3VquYGA8raulHz04Yh0JWqeAOHBMLJGgOq1h0yFUmfnSZ3PZSn003feoJEJe7xqEI
         U8DQo0lTcLP1FFQOFjxN2mkoWhHEMk3AfWEvbYzdv+5TQJ36oxzUHPOOta+wEiqnbU6s
         uOVU9OGFlQTv8jJDIKdGdd7+xmHMJjP7LNSHHmfLDCna44HdLmX7/CJzVF4jNWtL7F2j
         GBYnrdIqal0DScTmPlU36jhs130+ug1PkFQr7p9oR5SS+t41So/GGQWLoq5XJNd8rNOF
         sZe1y0CMBKEJ79CADUxdB+DmE8LbmJ2DNa3UlituaCLKF/hX4NId7Y8ScAyVS0Xc3jYY
         PoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758359562; x=1758964362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gusk5zt0HMd76bDL+pQKEW4NdN74ndDk79BJJ1+vw8=;
        b=Edaqe/uoo5hLuYejr2LdzSK1h3DfAWRVGielFFuiVwKEvtM1rtq/8qGsxzF0GjBlWO
         zWIdaNKAJZz/7z/V9EsByQyO3CaHJxeV/5Zqb1FM54ySpdLopjXB1xVaYq0lbWkRzdM1
         mLzmecRykmFbo0qCT2LVB/Cr0TS7T7rKbgcuE44vhjPLD02c/qH7kfraEFsYK0Jz55Y/
         lI0+3kvoXFclU5RFmRUcyfzr05DYMnnJ7zGdwW1fgUpJHbAgKP9y3o/B1p3H3GC4i5af
         W1t7VHBiC+yR0jrIbTUiD1QHBpF07RZioZHRaWwQvGUau2Oh42Z80ehmwIH6Ia5Z+wPq
         U7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCnSng+gJwTeInHj0bAYXn7K5HV8/8aejRcrKCq/bemkr/mul7V72A4ye8BCQrPcDRxQcAjNLJfPB8220=@vger.kernel.org
X-Gm-Message-State: AOJu0YyolgK+TewK9hpBe9SQy7HAOzUr+BYgnn4Sdtyp1/47jttPx23K
	YoK0ChWMyywn7W8mdMXcWYsVhqH40nxS6GtXd21GPuTRdy3sup7d2OID
X-Gm-Gg: ASbGncvy38dGVWObaZeSI0Ouf2u/Pd2S+T+sN63GRCkxO7q//yqM0AZ+d2c3T5Smb82
	qf3AtKmPpSpYPYdIYgbELUPIkf+2pzkrF2khZdCRPMmHAwTAt/NTnP1t27vdli+fZZjAnuvmOfW
	Pn8mrT9vUU85dl7tA3VqBK2EWQHHQn+raMH2I/UC0zWAUfUi+jGCkMd6lJA1wGlCMxe1PmENB3n
	U8vyQ7cP8MqO9xDzZKJdeWyLKR7CZYxhnzYcx7xTTSfE/S50flCl9pfU+0W6wRO3M9sbUxjY7YD
	WOQnQNimiUxBYi5lTmJWORLvzONHIJTOwa+ratlkM2cpTgMMki/W52DJCIL+RqdwYyPmBw7gJta
	2oPywpxOp6q7yCoBWeMDhMyJ4OCp6Z1uDYcYi0a5H1GsuoIrxQqzlTwaFpAjHyWyk9FZym7Zuip
	tuuQytJA==
X-Google-Smtp-Source: AGHT+IGeCGycSjOjMk8oko1TsOrOMJVtki4nnFeQ3rx2NoALaXwxO2K0x5BUb16MSvGQYr/OhAVjnA==
X-Received: by 2002:a05:6000:310f:b0:3ec:dc87:26a8 with SMTP id ffacd0b85a97d-3ee7c5527damr6050719f8f.10.1758359562015;
        Sat, 20 Sep 2025 02:12:42 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm6375782f8f.40.2025.09.20.02.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:12:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm64: dts: airoha: Add AN7583 compatible
Date: Sat, 20 Sep 2025 11:12:28 +0200
Message-ID: <20250920091230.17702-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN7583 compatible to the list of enum for Airoha Supported
SoCs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/arm/airoha.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
index 7c38c08dbf3f..6506c64af4f3 100644
--- a/Documentation/devicetree/bindings/arm/airoha.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha.yaml
@@ -26,6 +26,10 @@ properties:
           - enum:
               - airoha,en7581-evb
           - const: airoha,en7581
+      - items:
+          - enum:
+              - airoha,an7583-evb
+          - const: airoha,an7583
 
 additionalProperties: true
 
-- 
2.51.0


