Return-Path: <linux-kernel+bounces-872854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5EC12341
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5445801CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12D21772A;
	Tue, 28 Oct 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd7Uys33"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9493213E89
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611954; cv=none; b=fCOSfr8StGPN8Mgj/s9TGSjeKtc6OTJYB757WtmQB4tW9MZIoO8Diafec0m2hKTl6KYDgf2GC7+zQKvs2YVa5M1cRsE8fpw9JkfjABCEkPI+FYc81YZLMOl6Z6sOIN0JntvaSuNurdHkziuVqvh0Nh0288pKCNhobEoRZFTyeYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611954; c=relaxed/simple;
	bh=la5GWOA6va8nayPbgB6XzEsfdMULSOIbIX750WJpME8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r53GLqmEyCv0QKjrPmQv93SekuPHHlk0A9XDxgGUjzDNjAOPTDraYjwLJc4C70+na1dyShvb47F8kd8h88JIG8HWNkfPcYp/h33xUPkqQmIQJ94uqJj2HTBIwPYP9RUc4MLj8Ad6tzBRipDWgA0eswHO6JxqdGvl4WSKOPZIlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd7Uys33; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e074dso55115265ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761611951; x=1762216751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKnShh97FzAXK9uF4JYbivS+DlO0bX3Ab4FUiZA04Ec=;
        b=Jd7Uys3332NzH3gW68MsGFZuLQdjCR7Xk2WC6g+D8VgFl/pwtT9aiPeVYGIGxFsG8m
         L7KsTU3w7aqsK2C2ibQFzYpMaUZEJ2SEsqn1q4IEYG2WmgOEud1D6nhLMOtxpBz3P2nI
         FfpxSrK7wcg8788QMivL2aQaBCxI/U50Ws9h4oPYu/PE7eocQxLiP4cDhSLcstq/qVCI
         j4hiBRuuD4NhR/7xv7oMnbfiZNrr7xR3fCGXdIlztyY3PoKc2F2nmJFmB6+YCGHuu4dB
         LJFCxq63GATxdpdyZyUmJIOYYtKStBeFd+upd1XVEFtSR8PndLkuWlyBmp5xB5qyIARk
         2nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611951; x=1762216751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKnShh97FzAXK9uF4JYbivS+DlO0bX3Ab4FUiZA04Ec=;
        b=FuiNHDVa8Xjr/OPlicHr4e7CI5yVwvvbfxQOFb5umpI7sgLIRAI47r77epJmXuWJ+j
         dbxoQDvJuxIMriI8DQ+6IX+x3wRSeibe4fi+gMhw0gV0xo2T5qSJOL7HaUbZRCK6nm4x
         uW7JbevZa+JVf330n+xBlGgtaAo8kk1za+LtjN6EwoLKxMs8d3swVMMHJBHuwX281m4N
         TcCD1P/nDxdYFRv64ScYFPIiMZdHdOVpQAVt8tNXU5nCTIksYTZgEt3Asg/H7poVupnx
         uoQhU7Fs1gkuRSxe0isO2QCU1CqtlBGCu6Qo+mWAjXa+sJq95xeJpBzLZo3WMhjoaeGg
         4fGg==
X-Forwarded-Encrypted: i=1; AJvYcCXW8QGXULJEddjmM8fHl9YmNNw2fLRbWA4iJ8/p0H4FL7RaXrZjofsrYfXMSuSxKO2oI/PJ8SI7nSuSMxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbVi7Fgmz837c5LR61MD4udCQ+usvnEuZCOo9SBRZptfUVWuV
	GXg0JEcWK1NVjzxizGj42/xoNX5xRbF1rXhZUt5hH/8m/lG4d9S4ZhvB
X-Gm-Gg: ASbGncszMicHjD0kMhH7oYmwnHHgScd+IhbioRX5d9CDLYABlmmJtW8GRFqRGeMFT4h
	1RdV2XkK1XK98EAjD5UfB4kdGbZ3jh4S6ASvlBqwCvxFSP7qk78Pu0ynDz6lzArJc9sqmOqFoYR
	didjlwI7fh43todPEClmQZI/MfbHnt9yz3jkkUE6M/5JtpzuLWz5uWrXR0LwGMNDbJrhM5XmCRR
	tOMxE37/UG6xdP7d6lntOEzhnIkC+SDO8jDrEXZ8VM59pxGXdPVRcVZQsKxp/XW1QouJGB0Narv
	fEqVX/BN5tr02vh7FNf24ODHbDHjeE7Ph5Kn16XNjsKR88RF6SQuAhX2vr4pbV/6u6FI5DY+BDG
	solkpxNklhTFHZPBW1PqthBb9eIn/UYhQ2ZaEbyLw9js+Nmln9LGwwzn844PL5TEBrKe3X8nFiF
	I=
X-Google-Smtp-Source: AGHT+IGDgRzXqJUJJkrtAaCEFJyXOr4mEl+07Z2j/3J+/i5aKBpQqqv/TIGwi4eyT7fk5HkXcUBq3g==
X-Received: by 2002:a17:903:244d:b0:24c:b39f:baaa with SMTP id d9443c01a7336-294cb65f7f9mr16976795ad.49.1761611950502;
        Mon, 27 Oct 2025 17:39:10 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e7039sm10005885a91.12.2025.10.27.17.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:39:10 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Tue, 28 Oct 2025 08:38:56 +0800
Message-ID: <20251028003858.267040-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028003858.267040-1-inochiama@gmail.com>
References: <20251028003858.267040-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the ethernet controller of SG2044 and SG2042 only supports
RGMII phy. Add phy-mode property to restrict the value.

Also, since SG2042 has internal rx delay in its mac, make
only "rgmii-txid" and "rgmii-id" valid for phy-mode.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index ce21979a2d9a..916ef8f4838a 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -70,6 +70,26 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sophgo,sg2042-dwmac
+    then:
+      properties:
+        phy-mode:
+          enum:
+            - rgmii-txid
+            - rgmii-id
+    else:
+      properties:
+        phy-mode:
+          enum:
+            - rgmii
+            - rgmii-rxid
+            - rgmii-txid
+            - rgmii-id
+
 
 unevaluatedProperties: false
 
-- 
2.51.1


