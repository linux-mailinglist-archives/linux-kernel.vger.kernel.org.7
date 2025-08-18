Return-Path: <linux-kernel+bounces-773189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE008B29C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7549618A0402
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5330498F;
	Mon, 18 Aug 2025 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgSVI/DR"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E630149E;
	Mon, 18 Aug 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506612; cv=none; b=qpHd6sO+prRImDwTtXbd/QCNT96h+5GMnHuIshxTVEP3d1wksmFVPeQeFh3pS8bLmp9y4aWpkQ5vKxuIJEEJrpvtmWYqOTaapBpSmXYKQd27fx2h+uEwp3R1bSrhWTFuk5dU/VguEjAQH8wov49e/5vqCE9fCoDokdjfKqkoRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506612; c=relaxed/simple;
	bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqfwJwWDnGP2DdYwiaY7NNeYdB9U14xGDE0YqKh06SUCguQWRD23uS1J1EBVMbs9ZWlBJE5565YXYBKIEh1+i2tU7EbI0AdLZxKHAeg/ob6Av/fHen2Ce0iTpaJNvr7a4F55M13AI2wopNTnMgXIyESDoLNhPO08EoyxEeC6tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgSVI/DR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so2751370b3a.2;
        Mon, 18 Aug 2025 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506610; x=1756111410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=SgSVI/DROP7hPGzlrM5pYZMqGqn7Vz/mtHTmqXDnFcvPzV84vcL4RoDFIUroVdlet/
         vFGzk3+iicCaqQiBawgjzrwTrI3CDKg9ZfOoELwqdOaPtznwSNatVsF/jl/tsZA7b2Zf
         1wC2SBz9D6a447S2rB9D30n1hpBSrpZf8/CjzOgrhPG6OtXRVtGy9i+ziQDcym1+4ZCE
         3fHa1dhlLSm5PbFFPZLJrn7UG06AalVNQRfWluPIV2scD0TqeI16OguhOlrDBwSpGYIa
         3x+ScX3cktkDzyOTZjxcOjMOkpi/zrFsmynnRej9NPEhoKdJzlBE/W6+Ys91a5RmM0ja
         /MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506610; x=1756111410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=d4EoJF4RduTiyFcseR8lXTsjlRGR2u783PKGFXqKMKUxX3KLBEyc8KkeNKewbbbYnB
         XjaXiO+xiz+tm665bGID9GxC0svxZhmMfqKbNbd0rHk4FR1iKymkGCQE2KdGy+kfPMjO
         Wm1qIlC1xyFqIoq+WJ9oPCF8aCV1uxyk0UakeLLyjLvvKXiNKBLOOj1OGbHkiNBrCpkC
         zRGTox0oRtB2vvSGndzEXxFC6ruar5Gd6fKCt9Sd3Sg3fQvY7vT2BHbzdcvNEw5Qrcz0
         BwZP8SopI3FmT/FK6u3v2GiFXvdRc1oac9+oAhBhjWPkyjlaPqXm4x7s8+f0SeMYD4Br
         1dzA==
X-Forwarded-Encrypted: i=1; AJvYcCUUENJq0IzV9Iao4/HyTPJ3yj7ula6d7bs+dAGtFisjQzLr/3VngOXEr+sN/poVD3k0zDD9sRl+d+dX@vger.kernel.org, AJvYcCVgkZGjItf+iDDYVPbVMA1J5wOnIYUo32/+tARj1i6VsdSMBup5Aml/ZkuXnYPTfFIa/9CKoVIpb8uCT2J6@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVfm/escgrfLH7HVuXegHMUrJ3kQR0LxDbO2S8Wuq6su+kcex
	0+Ima0ZFBnS0DeG/QVA6vJOwN6B3rtLWYXkEGbvMqaxxQ2lu/17VybzN
X-Gm-Gg: ASbGncv/aR39TcwK5HabcLGLjxC3PSEnwxFuRAJjJTiqdH1tmzoa/bO68m/Ezns4puu
	F6YT8RkVZB9LordP6eBCZ1G1dBngiMETTwN3gDGUwbTfGbk2SxWX6uwb5bhyHFhBDKV31ngW5wz
	z0jB4VPs0Dj+AZHsBTuZi5eRtMyhtRPIi/XoLK6T8BtMqz1muNthry8ugPaLSgBzyjtKDwupC3p
	6iQtV3E9all0jiBEJX3iD9PSAyXUYd6yLW3YhwuvzRGvPzfjGlqIwpBjBpsqPaeU2dq3CfVdEBX
	BvPG+KaOUcTIFLZDyxeKH0bYUir/njkx9Zo3LPKdRtgTp5BFUPGwLdHHfBFMaufD1EDcDXWPes0
	vAuUMZUyYHJq4Tv3IudnkWIk+8g9ciP2vt6QwMnt3sTlLNkk=
X-Google-Smtp-Source: AGHT+IH3faNDzylzD0VDv8Y+qqSpzsBrx/M1k4bGkBOGU1VP2ePH7Sqk6RK7FHzo52EeYG4HYqUC7g==
X-Received: by 2002:a17:902:ec8d:b0:242:1ce4:e4f9 with SMTP id d9443c01a7336-2446d9c64admr141732475ad.53.1755506610186;
        Mon, 18 Aug 2025 01:43:30 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:29 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:54 +0800
Subject: [PATCH v2 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-1-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouekHBA3JNgEkbcxb1qrPDbRHzmVLLnTVmcky
 5RaLd4oGx+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpAAKCRABygi3psUI
 JGAUEACHsbI+FHcbJBapYoOszX5QQh6fS6dV6ukZSZpH5IJsuhx+4NIp7tg2wqpS7YRCuEjRQOX
 YJJx16lKWjQwFpzsR2omcDJfxqXcUA+Tm809iYgdkDNPSeScAGBi35AtLvk8KNbiFfzSiJqsHaR
 PJDnR7MVMOb5BK5nZdhPLXySqzEiZkvUxb0WPJDXZOJ9ErQygRKAkUPLqvBMb1MrGT78MhbwBi8
 Giwd6FiFoUWf/FrtIzXWZcEvuwIX29x3z6yqZAbG3eiPV3waEr/Y51xMPzw1zGVJQruMb6WYBq2
 tlZwPAv1Moo8n/KqnzswCvikGRj8mc8oGLkRjPUz9QW4pu0l9qbJ5yc/DsR4YRNeTUpPqCmNE9d
 P/YmSyW1dIjehZHUL/XjGW3LCG3zekN15tXLXATKCG5m0E01P7t32G4v0S3ngjLsLRM5jXUATSn
 jT1oKiGokPTrlyOCZummYN8+6YdVnJJnZezLFkRmKD0GICTrZCWyBF/fqxMHTKOXY8nEZUEy+3m
 j7Sl6vgoelGCbSa2ENOE6qoIDvMZAgWMsH6fafFmgmJNaytYz5WpwQzRMjrPqpfIJ/fXnQQ7laR
 l2K+A63zdf0GLp67J5koiVNxxGmAoaCwdtMQyyA+dGfWKAN40Je5L+N+PP0t9HyMSKaNPa33Lly
 XO53R8O4FyKKNUw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for ASC mailboxes as found on Apple A11 and T2 SoCs. These
mailboxes are used for coprocessors including Secure Enclave Processor
(SEP), the NVMe coprocessor and the system management controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 474c1a0f99f34777e1bed7fc0a34f89320a93b7c..bdf58f03b84833ecd93a34b91f6262d1706a002d 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -33,6 +33,13 @@ properties:
               - apple,t6000-asc-mailbox
           - const: apple,asc-mailbox-v4
 
+      - description:
+          An older ASC mailbox interface found on T2 and A11 that is also
+          used for the NVMe coprocessor and the system management
+          controller.
+        items:
+          - const: apple,t8015-asc-mailbox
+
       - description:
           M3 mailboxes are an older variant with a slightly different MMIO
           interface still found on the M1. It is used for the Thunderbolt

-- 
2.50.1


