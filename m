Return-Path: <linux-kernel+bounces-853017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20886BDA727
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE74219A0AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729A630149B;
	Tue, 14 Oct 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXX46TRg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269153002AF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456481; cv=none; b=tBa34GxP4QkegJF2aftZJgdg0ay+1ro20S6VfkUIZFC396z+360Yb84tEUX0j4JMSelRU4GXm8pia6KS3Q0GXs3X/Ej1qdZCihMOs/j4lmKsuAoHHV9PJBfI7ews/E4kH52iJjvkmoqfMbt87Bq5Q58kF8huj3URcIB+AgvmTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456481; c=relaxed/simple;
	bh=DnYT6cZW9fted2smgmfWq/pC9oS6v5QIKBy6JH4IASs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXttAI/bWYMInTxlSa8Kk0qC+PJfgMRpfREJUDTx96ewDG/PA3iQW7+cdl6N24+SMXX81GHZ2SzPjNKAUs0KjVSJmywBfg+/xDI4hKIE3jo+jUP1HaGLpZch90FdHC/UICyqByUoxZNTEocQsY5A8frnGyL842U/QIZ1xbqV5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXX46TRg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760456479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTPFzDA4gqnwI93ROrI2z8yAKdVU1tIGagUjigwEBZY=;
	b=DXX46TRgULhjHQXLKDU9FQZVoK6eDiRirJR1s4/oRtI4lLABRAnY5m/28aYkUXFXXd7sQb
	9Fb/yM0kvzp/K7+iYbr9nYgxjqWdN22YK7Wq1sN/MUWMgCjvNaSh7oUjLDrXhr0vRYWPxV
	Moe0TZHIY5llELOu9aThCjfgMTX7ZPc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-QNcMXD8GOOivz1eu2wJXfg-1; Tue, 14 Oct 2025 11:41:17 -0400
X-MC-Unique: QNcMXD8GOOivz1eu2wJXfg-1
X-Mimecast-MFC-AGG-ID: QNcMXD8GOOivz1eu2wJXfg_1760456476
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3d525fb67eso702323966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456476; x=1761061276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTPFzDA4gqnwI93ROrI2z8yAKdVU1tIGagUjigwEBZY=;
        b=Cw/yKDuHLwPXG6SSmghe5s4C0QChbYd7zNAJfA+COTQh2kOcV995RhQr+1FBc3bDcr
         18Og3G+m6xY5bb3+NT0nLcdVQoJ9sxo83vwcbFy+/PghvmeglOUS/bHPzRZjd05wmTQJ
         cQaz2WW0fYB/dihhe55Bh9DsKFvqjAZBt32h3j9hryb+opossJ4+HsNVIbHSXWQtZV84
         LflzY2jgV8/Bj7A80m9NdwBF4NKVekjeiHZNQb4MbyRO/aHoqGVrUF21ilgmYRb6ReuC
         wVFgvjUtQ0WQNPcHvW14Pg40KUlnOcuBAx8CHGaRpnNJjBCbTZsEP8TcxuK3dsYwS+Ts
         DmUg==
X-Gm-Message-State: AOJu0YzO3rsTNY7hA20P4ovVoTgPLjNvs8kQRfunuQbc4pPRB7ZDxIoJ
	wfyVoSpvAALMnfCTIjOfS/QuZYMp66pWqzVw/Vggyp+6qwz/KzTos0Za7cjQyvaM0FDv1QPa1ql
	5OZVkXl+nHuhqEVODbI0Bbhz1EfgSRBpuYITnAsUtVxIJp/GMziNTnQWhteCWJX2nu26KWfxc9H
	l7/iJ15jEt1agswLR0qYE5vsWUSvrSJnsgSXpLo0m0ehTnmXS7ZG56Lks=
X-Gm-Gg: ASbGncvkO0LwhjgUwuUBGgWVI2Apfrz2XmvUeHV+HTIvnavdCEg1aOGtdwA2KsfvH8K
	aIojFsXRCEjoLhZRujKc0cNJFn/KLY/U5JXgz25woXU6kPZlD4lRyKwduQZwMO3ujHaz1wiqGbj
	AVsYBvGaYYfERcQ6V/r/JOsHg++iZxgNpjPCBB/eVjruahxsKMv6vqnUjFe9H9klYysFP6cLWLg
	uj5CrGNmJHEUZbui8BpxhVE/02XrdzEMF5pCunsKxWyvMq5L29N+nHnmPgn/Rd2kInJ6/Q2nAko
	1tlGEEfpxqTfw4PI56M6eJpk7/PvGC2Xn2z0de/ZcmXs69ZUEw==
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr2628104966b.41.1760456475884;
        Tue, 14 Oct 2025 08:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfFeX9/H7k1uzVn/l6kjjHIirn4aGl9X4QusGUQ7kYgf87fvv7Z8/GRDPfHH8l7QuEqSTXEQ==
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr2628101366b.41.1760456475461;
        Tue, 14 Oct 2025 08:41:15 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba45b3cbsm7897866b.40.2025.10.14.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:41:15 -0700 (PDT)
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
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v3 2/3] dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
Date: Tue, 14 Oct 2025 16:40:56 +0100
Message-ID: <20251014154100.168236-3-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014154100.168236-1-lzampier@redhat.com>
References: <20251014154100.168236-1-lzampier@redhat.com>
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
a workaround, so the driver will match on the more generic core-specific
compatible (ultrarisc,cp100-plic) to apply the quirk across all SoCs
using UR-CP100 cores.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
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


