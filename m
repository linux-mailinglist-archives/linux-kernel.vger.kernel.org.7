Return-Path: <linux-kernel+bounces-789463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448DDB395EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22005E38C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6369C2D6E7C;
	Thu, 28 Aug 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDvY5K9h"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775C277C93;
	Thu, 28 Aug 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367405; cv=none; b=lxlVW7X+A9qi6+F+/tJSZ4zfW/hqcXbiECQoo6GzTJW0PxZ/x9+rUFb9HpndZJdy32IvCNcr/Uru6p3F+1rYWO6g5qiekilbFZ2eIQWb44Z48o3OAD1kpPN0EWwDnnPJKvfXfm90aRRZCQYCj8+puLbPcKZBZ+uX7EEW5tK46N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367405; c=relaxed/simple;
	bh=xMrs/O6EJnBVQGsgC0FYROP54LHFf82XlKCetaWrpik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRd1NA2l36PK1sLrSBh5Lw3/y7UMP6zt3cwMJQPIstOzafC8BvGwVaFv+eCatbsh8UiQfhX6DDzUucgLXd/e99eGa7d92qpMfztl8MDKtliqZCFN7DfeDP7AWjmx5eFvSWhSp9BwDdkiNDzIj+hvdr7Ojzh7SUI2UATGVT7P0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDvY5K9h; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77053017462so530064b3a.1;
        Thu, 28 Aug 2025 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367404; x=1756972204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=MDvY5K9huCkC+roiQ48yyht394E2XqKeLGUioh7sb595scLzHohUxpedNc3ltolPJX
         zFsR84IRNuQkjJrEUyn0WweL+owpXGmIRgXVgXDEBETUTXk1JNhrvbCS/WhPa50K/AXB
         UVK13IJRGBygp1+ShLaXA2YYH2OLhdPuZj/74JjGdMktIwPiCbAUeWeKDvB7B6l+x8X3
         Bl+H0jlFoy/hl8kGjTZkTpIh2T0ROOL9MMejKeRiL6p6qHoJ6PBtGUMTrgdyaxPvUbc+
         nGsV+taH+7Y+L5BkScrVTIsJBFpvam2Tre6Qsx3mbSDFd93yyQT9FKjpoPKyPjLdMqeQ
         tuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367404; x=1756972204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=aaZ2UGsX7Vpy9ZO8cNkGV1RJXMshQmOU9p3PIYBTdYLB1L+nfOCtzMwJ19+RjkZZjN
         uYes1vTiYqnVnaNxdzjGGPqR8D60xbIPa2eY/X7HwYEshBZl8ajf1Jp42oPKE8jclQPv
         hibeTbNHm6W1BdtRfjM2ipB9fC33q1FQmthier9CLUP+P3xxNy6Y4f7AmNn/lSbqnh5q
         MOBHpHGbs/EZ56B4lEDv27P7cviw+ebqMmTq0MZke+To6vm8jrl41Udt/1UyYo/BANUp
         nOiVJZpNR/yQe5m35OAwMoCNsHyoz9RTh9oBncw5tW87cLm5pTUxQMtcfiYh12Ar3Xh2
         zWog==
X-Forwarded-Encrypted: i=1; AJvYcCVGY4BYsJ4nH9FnAYzezKrWbN/fH/B3g8Qm5UisUXSnv0ZsyVRjg98Wg5Vn24Q49i2AKFQtyYkSBlFp@vger.kernel.org, AJvYcCXpN0NJlJnuN8eGKJUF8Hcu4wHE+FFZA6UE7oOh3QBGTNx/EUeLAePPHcwB8rHU3bujh6iPqAMpzhVMY3Ho@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8l27HGmgcVGruq4elb0rP5lC5z+XIAhjdx+wQnbSfM5ePXlc
	yA/mYxQlv7wJJkPImmAKIJnzn34JfmZ5+4JoZAQHB7+1B2tZ1RnSkPPF
X-Gm-Gg: ASbGncvhSdgnadfCR527ZJu4UGMumORluZH2feGdcXkXZc7k2/OUDJJ9mELsLZ8h1Pe
	M2sVZ74R/VY6w1MS+e5yEQsr4u9yD8BQptfPEEje/HHVQD4oADruCN+u32rkbeiQi3V9gkJa8NZ
	e3+3q+yBt3pTAchak4e3wjaSACcIhmvG8E0oiuG7MLhlqeAVYayh/A35rfBiYOEhV1O5TyejwWm
	4Pgjckang13SaBgXhS5v6bOLiorbXq3ZBMDm2D1gFY0pyegfPfGnV5rPKRHK3qk1euSXKzHlRMB
	hBXC5yzUnm2oZNSJDDYZzMbZTdPwscssquGVY8N1opYkqOQQnCw2y95Gezg09jdp9zQN7C6HmPA
	f6z1rqz/zyfwGbK21mUXHb83LNEEeDfuJFqKzF6o8TSj2Yj6MsaetgVDLPDAZYW8vXK1xxaHN4X
	Qdgss6N+1CjLoOUZPgEYfmCjwc6qIA
X-Google-Smtp-Source: AGHT+IF9eB9YxPbxJeLTBkKeRv/n32ThRlEoj2lAY3V0vAzctsoiWpW47rObnmzff3aGP01kwQzURQ==
X-Received: by 2002:a05:6a20:6a26:b0:243:78a:8296 with SMTP id adf61e73a8af0-24340e06888mr31347144637.47.1756367403511;
        Thu, 28 Aug 2025 00:50:03 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:03 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ARM: dts: aspeed: harma: add power monitor support
Date: Thu, 28 Aug 2025 15:49:51 +0800
Message-ID: <20250828074955.542711-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INA238 device on I2C bus 4 for the PDB board power monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..741d2d9b6d03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -373,6 +373,12 @@ power-monitor@40 {
 		compatible = "infineon,xdp710";
 		reg = <0x40>;
 	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


