Return-Path: <linux-kernel+bounces-855205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D022BE0816
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35DB1A2362F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D330F53A;
	Wed, 15 Oct 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDvCVTo4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882830DEBA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557475; cv=none; b=EjQCuLkDFGoETLbR2cr4mHPGwAO7KXHZ0MPaRRvR6myNGI01KwWA86vjQ6tRiI5o9g0KlnNYWX5SlXwK0sVK7SUhE0eXSvFAGVpH3Q++SapvXUZnJDtWrX7StQ4Hes+kf2+W/foK5DNZn+q6q5Plg8tqcrJvXLsZgR5JnIZZKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557475; c=relaxed/simple;
	bh=p+HtOliJIpdvfgNiu+HTRNqZsxXYbMjiU4izC6ySwGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvHxQ5lfFDAkR5JooUMbb5qU0h/wa/Op2GP1eWs6HyL6xhF2W/bfm3WwNda/jD+OrQEChcFZq8jy7XO2hJs/mVJSD+R+aJ3kzJoNtkbtKEYmsIFluz4q7lWK0IBjunQalcqNIMX4chg4Gjg1fai+DnNIn9goXn9Hs4YNiixLKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDvCVTo4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-470ffe122b7so1252575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557472; x=1761162272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8NQa4L4CG7HoZPqJ8Ok32X5AepFgS3EiKF4/VxGY/g=;
        b=EDvCVTo4zg+MN0QRxza3cXPxLjAuZAPqFBUu8583Nq/VaUPiiVlzjHJTDoBPLC9vFv
         n/KrD1Peas9hYjC7nth3ldWJcE0yJTDEnnzTIRo0caPeUmerkQo3dROroG9MPd1Rxnhy
         BlIG4QRkNpKUpNwp2hpWlZi+K1bitSgSdISCeAew7CFkYUMtUfKzRzdWWPalxrbufKDW
         nZy5CWirK/0blb01+6Qus2z747nVI6TzNsff8HhfQiz7su94WC3n/lPPvgFmO5yKh2RS
         jpfMRXdFyMaGPWSEZ9MOq4U+RFg9qMQyiasn/JWp0p5uOAMYlfzQT2wjAskoFjMJqh2J
         4IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557472; x=1761162272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8NQa4L4CG7HoZPqJ8Ok32X5AepFgS3EiKF4/VxGY/g=;
        b=vNa/5ALKPEZM18sRh3tMitRV9uyMLY6WFkLNWjJt5t5+1mFXAREP0N1q+5qwk7cmcz
         vyOz4vAJ7UA1ik4XJwBpfsohzL4siGPNBq6ze62NPRe1Exsd6xQQAWNaoerY5rAQUu/s
         juUpbRz2TTRFwsX79eIPj20n2dcRKXpTJyFAE+8p/BTQ4A/yKKoaliJYsHJT++mF9775
         c5MbcdCsOyRTLFIhNRCaDjbqjBV4kvVEcSJmOozR7KioX1vJXoL+j22e6fX/ntrdntTk
         bk9MwEwpppropxKPgrBAmLAk7e1yi4f3pktKdb0W6xa6Npn2emolk/z0vnv9cCsQpKJZ
         TAiw==
X-Forwarded-Encrypted: i=1; AJvYcCUiN80fYlCWttigLbt7mvDzsIcY/vqu4W9EDLBP+t0fsprsrminQxHK1o/Vm8QNxLjPzLzjb9G49qkAwaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTQ7FxphFfW2riSzNnjpyfkQkxDiY6zGPKfZe7pP6/2fnrBKG
	KsYvf/TLhlmqzoB8EGb8ddI2X8m5I4LYlKSrT//acjsJOm+VQJqiXlGU
X-Gm-Gg: ASbGncvKxkpQdwhwayBKeUNBwnw3ZsZ60d3psXCzq5ZWSr0cIduV0MYdZBDW84XE6yo
	MjVzavWAnP9tHktPV4KnZm/M+wXNAHJYgKk+LS2mpGBd5RbS1zVZfmKfwKCZWPKQ9ekhTMx9Eu1
	HDrmT1nM0o7k6m0VF1xBVEiOLSlpwGB+7WsITCQ0RO+cd5M2b/RRWyLpPyGG6bEB6Cym3Pq6o1T
	byIpNoJLlXSaD33b4LTShY+qH3caLHst67DXAEZsedw7sUeMAiT6dWcHV/KTbkxWoQkeRAgEWqR
	TxdyQvVLvyMT2Efn7/7qRmITtxByxqpf2jUUO7x12QHM+Y7DvZmqLhh7mKWXmhTIV8opnhUNZvy
	pMfqj9byejDD3VxEM9uoUbf8eGx8LBjoIudEer72SnPcJYFOSMyBGh4aAopA0Z8YwF24YdaJDhD
	43siYJxVGDKtK93uadsv7KnYlJ
X-Google-Smtp-Source: AGHT+IGFbUp2aUgqC2NxxsFWUdzRUYNctiLbdeKx3VCMXkN/w1V5RXhJp/fp0x1EjgmVnxo0Afby8A==
X-Received: by 2002:a05:600c:c162:b0:46e:6778:c631 with SMTP id 5b1f17b1804b1-46fa9a214c4mr121264845e9.0.1760557471616;
        Wed, 15 Oct 2025 12:44:31 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:31 -0700 (PDT)
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
Subject: [PATCH v6 04/11] dt-bindings: altera: add Enclustra Mercury SA1
Date: Wed, 15 Oct 2025 19:44:09 +0000
Message-Id: <20251015194416.33502-5-l.rubusch@gmail.com>
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


