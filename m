Return-Path: <linux-kernel+bounces-855207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F42BE081F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2EC1A236AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3F30F95E;
	Wed, 15 Oct 2025 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsF/mqK/"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175430EF9C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557477; cv=none; b=ILqwSRKAA8abCysMqjuAO+0ofAGy53ixxmpL/ryGDpSRizhI+GplvOd6bgoDIWN9s76mzry2Sk8SZrcQQHqelQA3W9O269mUrHQXnWoGD3CWqq/sZcZy/3ZwlYsPqW3rFtk0qc63CRaqvlMSyDnw7nH+juyHr9MpnuClCIfGpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557477; c=relaxed/simple;
	bh=icm+qgwvmlaIKVA0+LDLw72vpjzysCjTHSxFdDTSB1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fc0U0jCjNAjxpdBtq3VYyLXm9iN+t76JF1B9FbcPlEUpawIPZEDqens0IeY++ypCUhzoqIqJz1RuTxY/ZcR2zXIdYHsUk39Ko2toN2Dpz4hMr2TxwYP/klIxEXmS2AzT/xdLsucJpyKhFl79dy9th4IRJ6aXFbr90Qwn+Kb0yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsF/mqK/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e33cec8edso4942825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557474; x=1761162274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTxzj/ZNzMCl2AVIVbzHV200aF3vcZBw8Pj3HONtytU=;
        b=UsF/mqK/A3aQYmmZTTpQCNa1gfrG3MjFuCEVGQwRfvFNSpdHSOt+n5PhOPUK/IJ/DS
         z5LNYTt0BmqwZAPRiBZs6Cl3YlyYpAAz9PdDIjkOGLDCTfdt7aqyG+6JjP+gm45DqOyx
         kqUEMhUdLELc1JjhVXXP3ciFzAvpn7JX96L2ubOuFNQFmB4xcggr6+4qb7mEy3GUiuo2
         mX2pXpyCV0+lJ1ZlSvR7dAc6JTA98zB7yLymDTU6oZBD7vNeLGDbiTaHyAbjCQy9QPPE
         /Ilp/wvcKvE7n34YJNDRgzBshQy+v9OT3OIOVhhnN4W7a5GBLEuU0r8sylwAYQTQqbnQ
         cdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557474; x=1761162274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTxzj/ZNzMCl2AVIVbzHV200aF3vcZBw8Pj3HONtytU=;
        b=pw9y65y6g80+7yXmmOGnbuWnlaizO9SXwLvuzJuslXgByG8wPnWNltybKD6XGsKsYp
         XkkvSs9oWiyrwzFiPv25/Oj4kS+aw/rOb0BWo9AXS7iBJUFesTC5hpaQEPBW+CEEf1GM
         KCpMYQQiNWAdVUj+kIVM9ECR1nR2WrqDtSSK8MURIKKiCIs1moEEnCU4Ykzahpkvg/rr
         puIMghp/X+Kn6IG+Pf3wR1Ys6/zm6uiAjIvUKy7hLTfa4M/8cr4KtTgeB0Mc/ldsPv67
         fF6RXlJ6Ie2i7/cVzkrYdQMZmtPJauyWT8j+V35HOLj+La07B0FhI/eT0IPCSbyrMm+x
         odSA==
X-Forwarded-Encrypted: i=1; AJvYcCVgcZtTZAQqHKUWexon00AfYaZrjT/jJ18Kdq3+HQUR1SYgvnr2QO6eI9l67pFpZG2x1Gb2D9OaFSZMzRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W4ksbgVIJnSgLkVzMz6DCkvH3MkvmtfO8en2UmiK9NlVBohX
	laj5GK2jVgz6dWhvX3LKV7BT+/iYTymYsVvAB/pif42njw4MXiXRySxh
X-Gm-Gg: ASbGncsDJBjFgvaLQJWUUmtpBK2WOef8dFC25Vk5/BQh9w1PkyVVoHkpQdMp8XiE0Ty
	8JdTLMQ5B5LkmX8vyITE3oMN8S5ohUt5xhTVaE+XEkC9joesq5ibyT3+jSYaVqeKkJ+DjtBaWe6
	9vsJcLHxVNRobRvvEd/t2s+eF9gGbwuHTojBGdgEcRnKn42zIs59ROU9l9ODcJx+xNb7z7YGaJ/
	yUlA6i/OxTmTVOWznL8YQjZFsnziDbCeUIYX7HpJrByU1JFccNCrxh8pE+bJDxLUYfOygEWStsG
	rvpYSTCzH1yx9YXHb//0cLDwp12ASaQhcAhe4fauOVU0SpYwJEsonaZGCFgF5tFfoLpK7ri4537
	08PMNXElNbKsLgOl7w0yxsq907cen0mud7tOMZopM46h2EISODhN0KOUnOvZlIVu/J8lRJaa0AW
	HUsTBnHcnUkecHSYvY3QPKnY3z
X-Google-Smtp-Source: AGHT+IF4xGlkJcRA3gQGyAd6Gn9TERRg/c73M+cIvYIhWJxTPQGwRfocOPk8PIAo+UhNQw7AN0G0gQ==
X-Received: by 2002:a05:600c:c162:b0:46e:6778:c631 with SMTP id 5b1f17b1804b1-46fa9a214c4mr121265175e9.0.1760557473859;
        Wed, 15 Oct 2025 12:44:33 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:33 -0700 (PDT)
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
Subject: [PATCH v6 06/11] dt-bindings: altera: add binding for Mercury+ SA2
Date: Wed, 15 Oct 2025 19:44:11 +0000
Message-Id: <20251015194416.33502-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015194416.33502-1-l.rubusch@gmail.com>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
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


