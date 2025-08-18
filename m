Return-Path: <linux-kernel+bounces-773191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BEB29C81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD91172E89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED42304BD3;
	Mon, 18 Aug 2025 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTy/g6HK"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7492E283B;
	Mon, 18 Aug 2025 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506624; cv=none; b=qZLMABi14hP1tsrT6QAC9XvX0dlzVGd7WcCSjD71EMyZ2rF03HwkFLkThbh8oTN5wCVYmss1tf5tzV9kLfdnaLDm1zZOk4nQoZRaMM85OlOx4Kl/P12l711PX0WkuecAttbN9ewjQ1UE37VknxTYayCzkJZmTMIku28uFJ66wdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506624; c=relaxed/simple;
	bh=wfeQYcQCRdUqIZWllk2wZ5t9grHRAxtFZe3NBrLJiwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hG8dPMLhUWbbxIjDYoBjaVvEMwxhd1kzQCC2uSuRB4XCX4sm0ad4n22tPZUXGd9r0nC3sBFAi04l5hpoIVbR5GBJ+Mi9BLevby2OR4dAhbCQ36nvIxjcb49Fvta+FPD4NrQlxH8PeaS7+DvgZDW4PaxICK6hGUhOrMawCmBctuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTy/g6HK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445827be70so42124155ad.3;
        Mon, 18 Aug 2025 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506622; x=1756111422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSMLqQCi3JFRl+5II1bxu9Sm2VnKzJTs6Ar/7xglwSU=;
        b=YTy/g6HKjXsxSN1SUMLiNIpzJ3qML2H0VT3eG8Mk/124UjjNWplEjR3UA8KfIdDHlx
         xE+OzBTAg4BO6KePUxMVru6BiRCWCtEgniyVmRM83ouaOZ7nf49qWj8hZNWlmLi4WDJJ
         uKdh77IVr+pWown373QTazEwhAQQrGd86ULHmO44txJcecnvhO1OAzZ/XyA9zkXC0u4D
         DLdYyLKjt2g4A87X0eu98ac8EDmHQDQVOpvUZMqkDefXaqwqQ/rg3e1C5SSrXP1MBybl
         qY+v5FrS2cLq2e2MBPzv5A28RagpXSOt6zyLkfOyiYET49o0WH4/1CoW07/EgNZe5Iyj
         rkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506622; x=1756111422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSMLqQCi3JFRl+5II1bxu9Sm2VnKzJTs6Ar/7xglwSU=;
        b=lIrQJDO3M56Tpyv1xzWr37tFzygTXqALgeRNZzwD/x/lliWNpEgibBoUduWP5Ofr4z
         xFF/qawR3J1hHzsd8k3ATs2mAhXe4alSZzNCWRSXvvZuzB7iS9jWblH1eFWyHQqh1Qw4
         I9pIzRgdbrwc9+xhLoOFZ4UDJXLhq5G4VTRDT8qFR+3zanry7+RMXGcfFMBl/3hjuJaq
         W49Eb9IKxP5JsVIuwYc1iwE0ph3lFJSeZTk+3xda7Q/cGzZfuqlENhP5WoSYAYuWNlfr
         ngjeVLEg4xg7DSGpxdwfHRx7OmDtD+QE54fAEPVh8IuDPdP4cC95KsDr3MxfFGLFcueB
         vFjg==
X-Forwarded-Encrypted: i=1; AJvYcCUSaI5XDHyH1e2Ay3bDxGTSWu2aeEQeK09XT7Fz7dsUtPcVKmw3eaIvgAga8IppFfslITaQOWJTb0Rk1WuK@vger.kernel.org, AJvYcCV6KmL/McEOegfWMpS1zvhgAI48aStxAMxfFX4wtmtSh46igPohDHkL3+DoibukY2gC6ROHEZFRS4Gk@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4hJWdinSKUDOZAnH22kcvdSu2aXqUYzmR+VhQXNHL6mAXhGj
	QmkhcerVQMOOLQMo1BJo4/HqW/SCONeaI8vOjfcEYv5GmDaRknfP8VVe
X-Gm-Gg: ASbGncuL+OHFKOt7LRvD/40H+DD/sHbsz7RcAiGulESP4RZ2A/q3BKMcGeYjZeUa3qU
	zxo/rMZyRNegqm99DCbuo+MnJ2sgMXwWYDfdt+XgOsi3Hf3OAQd1AfPxULskOYoi0ukqw9Nm5qC
	krIh62hkxh0PvzsQj8h0sZ/DIQ2+iUPcuoNFJY/Mx7C4E0TUPGr5XlN4oCwLeNW2eqFpXEcFNuA
	aoFMSSfBJOvtoTU6VRIjj5IV6+y1Jrq1JjqMoFcoHEjMug1SOagf9rv9m1ncA51gYxE/cAOr0gr
	IxE5QN+0Af/6E2xP15cy1Z9yOP0g1DimzPhMkjRKzU9Alsm5ytYAfeqvjAdkYHaljBKn0O3Ft+n
	+bjRMXoTIb7+SKIOBd0t4PL7McbHoEgJE59ZrWJoUZPNYLB4=
X-Google-Smtp-Source: AGHT+IF/h6xzRZDylkBa1DogMzbFZ9ZNolM7ThCwkCRwLY7MWhdX0t6RGaQFVvUpBph9fcpGuIpgGg==
X-Received: by 2002:a17:902:e549:b0:234:d679:72e9 with SMTP id d9443c01a7336-2446d5b8566mr181472805ad.12.1755506622219;
        Mon, 18 Aug 2025 01:43:42 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:41 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:56 +0800
Subject: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wfeQYcQCRdUqIZWllk2wZ5t9grHRAxtFZe3NBrLJiwM=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelpFr7oTbmVaqjHTmHzVQtKtTAyaoCZyIV0
 OEs8q6LnoSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JN/tD/9YeZd1u82jIKk1o5aqzHcZaPiNzKg+Z8D6TaUSqhBLL7SGu2a838sevRrqwkrDU7zLaoI
 NCBVXOvZdrQiGZppjOMBYORwUy/a7Uh6KguUxykovjG8WacAQ3YOG5WMI4YLNp25E/F4iZKqG4g
 bXdczMVA9rQnNTvzXJNknC/PAfCBHOHA3ltaNyToYPHcgtp33lVD7ob8TFb2ZUNfSsOiQ7b5tB9
 wgPDPrjV7noCvwZBkJXl4GGLAyWrZN4jY7GPjEBXK8555ARCvnxLVIDfDgBRFSRChBA+rrfDoTY
 OQ78//CizYG0morb5ebeb/yaHmFqPSV1vUgfJIH5rkJ3IkmgmxT9ayoRkHROpAGEYTo/4Mw7yq4
 PBJHTKDLLR2vrZ8ss+K5j2GhiPyuU+/bEUaLxaL+lTKVM+z7jgJh4MeWefGyDiJA2KlLrF0vNne
 e9mFmfbexhzoU0orpmmRyJgqoU8FFa1acrsQxjqFhrSMyAuHe9bnlfVB7aOWEy+NFqUQkKdtXu3
 M6jjXwXonWLea08JMf5edO5CQ43opJy/eEHPLzZiVBUCCFBXRDVhf0zmriUvLaQA6uTpu0GinBQ
 DOGBa5ptbDfr2BsNhfKWIX3adcZ+ApxFpbR4arO3tIaAaZsAX/7ibE/eQ5p8p+qrVPRnb6XPRxu
 jAf1llI0PaMFEyA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..95d55ec688779bd52b8aef316a4c1ba7b7449574 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -29,6 +29,7 @@ description:
 properties:
   compatible:
     oneOf:
+      - const: apple,t8015-sart
       - items:
           - const: apple,t8112-sart
           - const: apple,t6000-sart

-- 
2.50.1


