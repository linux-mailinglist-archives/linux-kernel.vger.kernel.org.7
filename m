Return-Path: <linux-kernel+bounces-780259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C64B2FF97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C513D17EBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99992848B2;
	Thu, 21 Aug 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/7/+zh9"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75C26CE3F;
	Thu, 21 Aug 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791857; cv=none; b=WHiCZeQzTblIHsTe2YvCzGwcbK192o8v7vzNCiesYt6ltc98Fk9e8bU5ycF8ezYBO9J04ud7K6pqjbUCW5l++nsnMH3MI6LGLuHEwUWb9+jWMXsIUi3HnsqJ8uHrdGIPDf7z6tPkZavgMiLoDdzsRiSC9IOgsTF7n5IKjlinnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791857; c=relaxed/simple;
	bh=v4OiVJFsSwjODAdi15xQbBcLXhKlJm7rChMF33HLKjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYpgbY0BfC9hmlZ/D7sQWRZh2zl8uf5gAAjm3IcqSKv3P9wFLKWO7d6r2Yfqi6NJvLK0muisEZ9zvr/W0EjE8aPmq3rFSNSvKEjEYCS2CYFbjl/R0L0waKXIR8r0R49sejJaHzHIO0/JWzkZ90ntckVPmEEf5k6Bitv2j8gSjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/7/+zh9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so1490254b3a.1;
        Thu, 21 Aug 2025 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791855; x=1756396655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+TLtxQE62J5KV0O9wYqUJlCIzAdogQJTkJBjLbCxYg=;
        b=I/7/+zh9qo0vydxngHy8uS4N0jawPy0n28RVXfmhfY5mlkGoPWZb++c6qYxXcDwxTh
         wL8DiswLmcoPN+KW47sVjavRBbBbKYJoyMy+DDPD9F84ZpCWNdq/zcSl3if/+WtPwQzm
         plAMZcCtRpZg18c/NJJloBZph7zAD2nMaDodXDUhqrxqPkqdcP0B7b/gCj+PeA6VfkZE
         m7Bm3CygK5FDlrMaHxrpqIRm6RH1QJzBR5/RLl7FC/RrHtkrkFiDH/BvINJyWrEQCDF9
         t6jIeSwTLBXxIIDLJbMyofgZ6GhWFHcIr99De7HPn2iGKYgsH4uCI5ZRqkSb6vQ5Ab/+
         uzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791855; x=1756396655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+TLtxQE62J5KV0O9wYqUJlCIzAdogQJTkJBjLbCxYg=;
        b=PATmznoLjpZBweL90lN5FNUggSN1jDhWbEM2G/xGhnPildLKwMYBw9mMD2txQ/3sds
         Wp0h64H04qZYPV1InISfZV1kcgMdxcFob7e8PhBZDd1S17HN8cE3npc9rbZvZjWsXUVb
         xDkN4brQAb+5VnUsTTa+hiEhRYB4x8ItxOqztkFVgfFYNZ+Ojgah0VyqQv3HfZ+YaiTN
         ieeErz6jQh3/BUblWI/YGblOpjq7Qx7ifc8eOpp+wsnq7I7r7q1LglbPMwcJw0TGITn9
         HOfj0jMTB1kFjovqH5wiOBr47G+mA3Pj0ZtJwndkx6cIpNfV9qLVMjrq14x6+IDt+VEt
         dPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Uk2mxefXK60cNgXoa3NtYixDPsR9eF4aZ53ydqH8xgNEKfjsKxDJ6cpq+36YWzHK4enknMG88dmjjg3z@vger.kernel.org, AJvYcCXgPu604tZueJTfsT3udtODhnXG+yxCMTZipdB841VIvmjReewDl0P3DoinY0t1rsuJbIFWvewqsqi0@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxoJqSCLZMBXzRpBtLZAHAmUoYNJtxGvsv9n+AgXbxLfHWz9A
	og2ZmJ9p/6lDyVghkTyMo395NczY8y1mxHzwNNMkVkyLO+f3J72K34D/
X-Gm-Gg: ASbGncvzUR7Jq8t1o6cFmy6i5nuSFLSSpPxE9QYu3A/njfu1/lRYfJSO2wbtY80qfMT
	YPwbAPLZx4UOSF6v3uxRim/4yEQq0tM+BPLxVPgAivsZP6uWuyML7FE/+rDlGtNUekqlkHINlC4
	RZKbjWSnuvwhGgFsYnP+d3llnBTE/DrQuE8MMw2LyOH/D+p9fFuwD1GG/S1PzJfsszJ+eBImv5W
	bpcgWl9wyfdL1OSmu4d85CGnAt6LyVDpWNTEsRHFvC9lB0XYE30ewYqCS4E9oDM2AeCVwOOd/77
	lMhptAvtxAm8QQr21WCIk8fdvDa+JfEf2tphxBd7VAVGfrQ4El5+IoezQ4Slro6cZGzdUHM996v
	K01FZZe6JiaZ2JHY5IFlvSPB4o3iWQwpngvAwpcTWilXTILg=
X-Google-Smtp-Source: AGHT+IE0wcnJHKLEW1RO99lnzrgpQRtwp6zZL3gPMRllIkPxphhvBCZH1jAgYyHmbKF4OaX4kboVfA==
X-Received: by 2002:a05:6a20:3d1c:b0:240:1d13:ccc1 with SMTP id adf61e73a8af0-243307985dfmr3463057637.11.1755791854959;
        Thu, 21 Aug 2025 08:57:34 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:34 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:40 +0800
Subject: [PATCH v3 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-3-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=v4OiVJFsSwjODAdi15xQbBcLXhKlJm7rChMF33HLKjg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUF7nwsx/EDWK2zDtfXq72ykV0AI3cjgEEV
 9AO6pJUDl2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JPjzD/9ULBgNc5mV2zbwjOSGof+wpPmRDRKVbasRayoFp2Fx2wctI/7F7cyPCE9Vb3aimuNSW0U
 pm77OfK34fZPTWk1BYskORnZHyFhJ2xQROrBFLne7E6gwWbuMLUpjPKZmfWoAWE8lIRwLVTyLku
 hENiMjSDmjT7t0M35bgMOWz40E5Dq6i+tRtnIXcvjOzQJJDG9Ir+ZrIeTAd4vEbv0WPmctsct/V
 RsIJ/+zK3gDLE69ojf6Xe0HbaxNvpG9sHtNWnOQF95PZlahElyHS/2LPkPkGkcOpDInKxIjrY30
 UjZ5Mqwh4TTQW3MZLEC5kMcTxtLUDCVE0UJF/duROcUkeNU3yBuBnq0yrHGctbrNIouX0F3zp6p
 86G/vg3AXEg+UfoOz20jaB8X7S2FWgMdgS1EL7pL4zs+QtFMUOn1Ow18Pb+0R5iOD2AWMxNcqB5
 znSdFSuFwV649uwTBtLSrsBksi3V/C6HVYCr8jM5/MXKoReGZqVv6P8CQL9LDGmm7kdWcyDu744
 VDoxJK9wDnDuMojz046T1LbYdMfyGOkrBWJTKl0FLP3wM8BRu5GhXZi+2/7a5Vl6lWzi1fTg/+a
 TN2vlU5yiz07qwLCsV+1lB2m36dMV+/4uX1V5KpG2WklJxNn+fcBEXJ9ZWezH4wtk1Uw8QCIzrk
 dG8n95wcQFyR2bQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..c8c62f32988238c5dab93bdb04cafcc41129b423 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -34,6 +34,7 @@ properties:
           - const: apple,t6000-sart
       - enum:
           - apple,t6000-sart
+          - apple,t8015-sart
           - apple,t8103-sart
 
   reg:

-- 
2.50.1


