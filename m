Return-Path: <linux-kernel+bounces-867129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B5C019C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316DE1888D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F25325480;
	Thu, 23 Oct 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFOphPMY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88432142F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228072; cv=none; b=mOtkuR2x3FPFxThbNacbCc2G9uoZVVhm1/ksfznDGcGScxHH81F3fyOrWamEoAFjwFeTP+kZto8qBKzHK59E6UvM662obdIrexoLV33a36LRCeJT86LOi1lStdaq6mIXC10ny0QND6jQtkMUL7/OH5/pDNR0IwIG8yXZPmfxK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228072; c=relaxed/simple;
	bh=7nF+zX1/zT0vgaP6R4vsmssJvlMwk6TNzjt/SjKQqOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+aFfk6HXVTegwu2ARW67xIJi0NPu5G+igT4hSBOC9WG8QUr9Nr9cOPqKqOYwBq0JqFqkZ5xNy4XC483bMOg0HIwafcMPgJ44DxzfmSvv4DUh5XuwHoDHkXJeJuk7IRyQkg8srCJB452+NLl9L/hT/IWGBiI3IR8eFrScez+714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFOphPMY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761228070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSXzVZNzjEJV0QCm7fFsQIpGaaXg5MfSXavQS0cQlLY=;
	b=ZFOphPMYTPxLbRML82qOYN0jfz4aiWoEP8A8YOkWjbYjZCWELbM6SvFnh2KgeMVuhf433I
	WZdYfStVFkciGl2KbtQ53rddz1tJV7hvy92Dfiz3JOd1u3BN94WdClV8ObMWBoVA9TXBNo
	UVBBHr+IwztvqcVHhXDFhTS4XQYcXvo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-NYQppYQmO9SxB3yMxWL0Zg-1; Thu, 23 Oct 2025 10:01:08 -0400
X-MC-Unique: NYQppYQmO9SxB3yMxWL0Zg-1
X-Mimecast-MFC-AGG-ID: NYQppYQmO9SxB3yMxWL0Zg_1761228067
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-428566218c6so587957f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228067; x=1761832867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSXzVZNzjEJV0QCm7fFsQIpGaaXg5MfSXavQS0cQlLY=;
        b=Z0r06VOvN6ZBdU2LUKJYLKThWUfH4tcqhCzbFGn79vb6khQrKjCmtdWO+QIWdZyETo
         Qju6wpuUOJYlYCFfFaNpYShCOMSNdck1Odv3AN4fjpIdr0LsOZ9btRjpnEkn1SzGfr3P
         1tMu+KG+6+Fkf5VQVlfqF1zwstX1q1TnycBd88hjaPOjlztCHo6PjByyvvNCS7mIjxdt
         BZcsLzUZ+TJBIKiyN9dqMO1ddvkF/Y+VAx8Shy/y1RozF/oscoSha2BHW81Te6zY/LYz
         RqKBk9t8KKlhbzIqSa6MYFGRFIldl8OkrAKGN+zQ9nBkd0r1dMeRR1v2oBAli1syb+LW
         5RqQ==
X-Gm-Message-State: AOJu0Yy5wFGX31b5krxFT79AJaIKjO+RIpwIAk529qyy/91LGpYwGGm1
	yAEDUJMv0ksKP7GNoeYkTgQsSm8brBElbb0vXXRsGCVVA3VZcLCKju3xhjPmaKdi2gaOdsnVObw
	2qqBnhqC11N+VbqE3pbM+U2TghIEntOK9aVlimlLoOYWQlyb/Zhp9XYhctruwyJCy4rFuFJuhtT
	pZZY0f2ivAkdRgAeOUM939xJVoOK17jDmSRUl3yE9tYNs8EXZiHNsM
X-Gm-Gg: ASbGncuPJ++vupKXMFEvVKcWY8EVD17kJPTV0cL/e3mscm+kDQW6zWb6u21NAQTw5C9
	kHWjt7Wq84M9JZ146V9+4vMwKm3Px5wyzUA0RPsKNRBdKQam5EznggDFbrFfLioMSmOnmkxMFv1
	3Pg2BhL72Ve7KUrFrr7sRilEhVDiP1yPUD03oIaD/KAUwsLwOOn0lUGyjtudAuK8o2Nk5fiv+QH
	wb+r86tfukr1pML1ZcPfIRe2abw1s6MKeC6S54PVOu+ZR7FQ+fRFYgf2fVSsAd7F6oryy2ENQFy
	PStcNVpnzTgn46eIUI8atYbKItjEixwv9Rv8cuHV8wDCl7cPlPXQbySceX8H4Kz9XQqloIiaQmE
	0s6s=
X-Received: by 2002:a5d:64c5:0:b0:427:55e:9a5c with SMTP id ffacd0b85a97d-4298a04e8f8mr1738176f8f.23.1761228067050;
        Thu, 23 Oct 2025 07:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQN5z1R3xUC1t8+U1Lp9SBqdA78YpSkYVZfQPRbMaP928lyLVm0iuMC51fQt6oNyhBCt5xuA==
X-Received: by 2002:a5d:64c5:0:b0:427:55e:9a5c with SMTP id ffacd0b85a97d-4298a04e8f8mr1738120f8f.23.1761228066468;
        Thu, 23 Oct 2025 07:01:06 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm4116154f8f.30.2025.10.23.07.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:01:05 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v6 2/3] dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
Date: Thu, 23 Oct 2025 15:00:51 +0100
Message-ID: <20251023140057.204439-3-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023140057.204439-1-lzampier@redhat.com>
References: <20251023140057.204439-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Add compatible strings for the PLIC found in UltraRISC DP1000 SoC.

The PLIC is part of the UR-CP100 core and has a hardware bug requiring
a workaround.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc24301..34591d64cca3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -74,6 +74,9 @@ properties:
               - sophgo,sg2044-plic
               - thead,th1520-plic
           - const: thead,c900-plic
+      - items:
+          - const: ultrarisc,dp1000-plic
+          - const: ultrarisc,cp100-plic
       - items:
           - const: sifive,plic-1.0.0
           - const: riscv,plic0
-- 
2.51.0


