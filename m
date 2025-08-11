Return-Path: <linux-kernel+bounces-762768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF6B20ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBE37ACA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391C1EDA26;
	Mon, 11 Aug 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+rXDI7g"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D71EF39F;
	Mon, 11 Aug 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920287; cv=none; b=T3KAEHnPv1pTby5AQUO5pbY+Z8cm242+e4dhT/NqWrNctI7YWXTW9MNBGMbGmjxcYdKj3g3Ty693VQRd0v2o9wT1K68Hdd2iiPmkLbd5o+ZOXho61ixtXr3izR2Ekf0FGwPzu2xkTUsNGMZIY8/LT73fSAWs7d32WF8S9Ia4b4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920287; c=relaxed/simple;
	bh=vsY2LxZcawhqMw/s5IJH3Qa/QDQv7w3VsaD857GZcqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5IbTTwZM+9nQGUsVhvhO/5WqwLEgf2do6IGHyONziOL3EmuqobD/KBR5AAUbNJtdQQBynra45YXx5odDrfD8JnsirMWsD3cZsMdxOzpN/aRsev6mAitRNaJZU6o+dkfhuSVDD/qGat8BbEyZG3+yYU0n26ev+9mUJcos4jMsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+rXDI7g; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76b77a97a04so3874313b3a.1;
        Mon, 11 Aug 2025 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920286; x=1755525086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=E+rXDI7gWrx0yfERwXW6zyQjEcjOxewC49qCQCZN51s+IHI5ZplDCYi6f9ygMXvsF7
         nbPAAjZ/WyyKNjDKv+I6/XoA3ehDAlKUklsRsMO49DHdv3O+kwPqPa90hzPlzZvHQlDb
         SHXiW0KJGF2MBoRyDnCoflJew8lokZSg8r5DE0krL5F1omlfzSCVJcddVW82WHmHwtdM
         CLVcEhCAZVf6apnO1YSjg+UIK8U9vPmdoIja4MBRnIq5qXhUGwaNHZl/B0FnBu79MUbq
         bCD6JYTEc+PtM1GzOaWUfYodMPDusr5AU+ROrFZ/GE2KLGFD5mY8H92yszoUPhZT238F
         m4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920286; x=1755525086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab/nfPMw843eKZIzh1MEFIjYGxeCe4JAvrb6z0G3ci8=;
        b=FuxPCcAxT0ReETGebC0pSA2+/vVJXJWPac0epJUe0u1SCjneMQBPB58bw/768SaUYr
         9L8P4Q24vl586bLVslO/h54CJEabs/H1PCVfQh9rfrdun+ptLU32MA6wRC0YnMmWIATu
         EGYjXw0GrffqcTDJ6bHo0glUZjO+B1vIKcPOO+6dnAL3YdybsoKW+71oU2B/gVvVsoj1
         HK3jT7xc38SpcCHBvfMNzqWXfIArRYaGFDxaOXI79LV07SNYdEGF0SrlWqrDG3wokIpx
         1hj0ZqmJZhX2B9Bw86kiWztMk6L4Auop89t2kDB/BJdbYfekI3uXHZZMAZ4D929mXX8B
         9JXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPuTuQ95op1nSJBCEAgqEF9nD5uMEc/53vyhFAeZCluJazrhqwPDXFil4Ecl6nB3rozv/+ML28TPSi@vger.kernel.org, AJvYcCUWSlB6gPiOeuodaLRm8Te0zjL4oEc/Zd6I/6MUiuVm8gVI/BWVHZRdh7vhBBYoEE9q90r3dfBQnTL5gxtd@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQY6acEWGd9nAyVKtT71NU8K17pcSatc8+BgXSJWQSjgXk+o8
	VXMJ/k4y6lzYm3xEXvcBU+JJQtnqVQvMjn1OCbwRqgpW22mDiKMGtxJt
X-Gm-Gg: ASbGncsWvi8cIMc4cSH9zWzqrM86AaQoSndAwYh35nGoKjKd+Wwh1tKtfzkKqebSoTz
	rMGwOupA7Ccg4tJXWIjqjqLMaPeaiDL1tf05KQv2ISBL5lDDfkAPrm3ALuXIjf0/kHsdNmKHN6v
	1hHar2vW9jvZZXc6+jrqgq8xMZt6d2PRoQE+ZqVt/+KeTrYkgTri/SF2eo4hiPcnQkjUIX/7bcL
	jvG57goKgMLHm9FlMTISL2y8j+WZkJWMBK2oyOkC8pjR5xwOLgh0TVuDsm0UNax7RZOad6gCBOg
	+3SBejoDyzhr6zFoAXQPloBR6WqbK1NW6VErdMAVva/Om9h5lK+zBpd/WHNFIIpP9sBhzJSPYDe
	cnlWrFycWRXlZqBjGriqXubwuJxD1N/yJ9D/AVBUd0Cy1aec=
X-Google-Smtp-Source: AGHT+IFww40/ClkPYxA7P/SDXLTgj031HhNn9dtfaoB7f1h4Mue1IW6LCE6otocYEXgs/2Rx3IFTPA==
X-Received: by 2002:a05:6a20:939d:b0:240:2473:57c5 with SMTP id adf61e73a8af0-24055160423mr20825244637.26.1754920285410;
        Mon, 11 Aug 2025 06:51:25 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:24 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:53 +0800
Subject: [PATCH 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes
 on Apple A11 and T2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-1-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
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
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9VCg1SNuFuRtQYHU7Ko65u2SjlDXr67OxKAIlhnOA/x9P
 YkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVQAAoJEAHKCLemxQgkVBMP/3AD
 XG5579GsnDv3PE0P38gtqmvfnHLEICpLLgy06SxvD9gt89Wf72i8W6pLjr2QrSMjg1oHxD0i8UR
 jjfw2UXKN/IgSe4jLH3loLBm1aLil8sAF7P30v6N7OEuleofgtcDs4sH+Xb1vTuKOVUllFKYXcF
 l+zW7wJYGcXoLu78dlryBBAx53zZ1IDjFh6UoExBhCN8Meikn85tIlyDM1XKYU2fu/AeUhCGBjw
 +iNQC7imeTw9GsWyQ8E5sftOFV9XkcDJnOA14AS3in7IJD8DxXCWDtXwPDwUXBVBGytTaEGece0
 Ogzhyp+d7EE+GEPBNGbuhr35SAozALWljqHhmf61mILsdozH2ANgks5tVF2aD1qEjGFtQFkjWry
 ZDWoAHASPCJ5T+sAV+jp56pR/1tOU/xnQpJ4+ELmnn8MMAxS5bDd7eKUMXkQHLze8tvnwFiF3vn
 XqQ/B+RaqT7KM/Lf2mGO5JanAykB50OuQX6ccnpeAv7VU15GHKbbAXXcssCnV8HQp43WwjDvkKu
 etjdjXDbL38FRe8qM8xYloXU14WYw0svs1nYorwUEssHYemtpIJ7eC1JxyrlXOeRWP1a2CPZBYc
 7/RUGQYSK9M01WXO1lr1Fbl15K3rfRH8FvCPdvTwknAJ+9N2YauKyzdeW6ASol54Dnb7R1zDkG/
 /DWz0
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


