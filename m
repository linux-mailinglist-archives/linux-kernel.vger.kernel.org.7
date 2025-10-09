Return-Path: <linux-kernel+bounces-846476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B9BC81D2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1F53A76D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281A2D320E;
	Thu,  9 Oct 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GChLELLm"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC02494D8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999558; cv=none; b=cwKvIHFiCwaKTeSXenH3sT2rSsHAWHLxphuujxswooVxW7HDSms5e4Lg2m9tKLhxMJ5SR4URKiJ356mgKydUI5fW8XkzMzyZOaZOYHmi7Lj5Maymhgke88uBfhWsRRETXjv9EVVky9Mt7ral1hO2/oVhbPiy0hfNspNJfn+0JNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999558; c=relaxed/simple;
	bh=fxxAVmPJGca8589Kqpk9mJo76fAFnptROiZXxjqZbz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOl6ZQeWpme2Apw4phbGDlQWN1kLolPYldXrgeBidCNAtr/RU+nMyMfEKPQSJ4ThqctO5vvFRB7WyEthr7zcr4vP/7XpB7OJT4cbInxmMd+sWHGeRDGt1yhY3EjPX3pqmXcHZT77XjOCf5edPfmq7YFBrRpTSqhYPDKN1IM54mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GChLELLm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78115430134so495413b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999556; x=1760604356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWDW22d1KEEhzhYCQi/m5g5KGiHWCtagl6QTEa0SdVU=;
        b=GChLELLmENV/QSJq1EFrLgQdy5y5oJss/HMsPyb1dC7GHzHoG4VX/MCGWbzJwtQNHn
         ij11h1S481g7c0LDuIVaIygapiatrY8GcqC1r3yAFOGG3qSEFJI8Lz6l84T2WpfX6xZ7
         GCm8oC3WMNDKRDOYGy3kQ8SJ7eiAgdQMc7LwF0GkYxCk8MSOtPUYikxKhA4Gjull0s2F
         lmZ9wY8Gnn9XjhcmuFE1S90Ej/itvZOCZsHVQ1pIauRCFMZIRt5KyevNzluSqg7+xXSj
         fD+7uFpm441ot6vQHgFT2H/d+PcHn/q6VUeuMiw/x+J2xXdMtTSgE1pqFZw33GIO6DV+
         IgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999556; x=1760604356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWDW22d1KEEhzhYCQi/m5g5KGiHWCtagl6QTEa0SdVU=;
        b=RC9jG7ZqZ7EYU78qkQPPX5c3WHatGDzVEsFi6/o97mbHy4OcFUbdO2RorvK+OYxYWG
         5bE8FoO9ynh6q7inhWTbYFPVFj72ODjnVd4AJCuMQOLs2C5DAo9dx2huBNjx/6IKY5kP
         w1msN1R0pDgcVyu8Y1cxKkyoxamczZYxnyKhhxB2b2uYb9EiSf9guIJGRaYgzZakXaPH
         7dYDU1d3b40j1k0sC2qUotK4v7NQXuXxfWTMxcUgBUY3nADc2Q/mo4moxUeSCXqigYoI
         fn3OHeFhNk6kEE3iel881qWmYLlUmP2mf/w4V6v7RIdqdjtfkX1EV2niTKT90Hvzs+e5
         GRuA==
X-Forwarded-Encrypted: i=1; AJvYcCV8pm1JqEp1YvD6OLmz7xDqgsCnn/PwH7UJ8Mjnc0YWT/2I3j0V+OTvmm2nkeSvE+OHqSOteHBJVeecqIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7ogRgh1Xvfolswy/joXpD6l4sJbr2Qho863IsRYvyzEO/dJy
	SOU/FhJ36RWyGyY2olNgFyRFPtuTTO7BAUzQcZdkQXylxnpNU3pk+zh6
X-Gm-Gg: ASbGnctBw9jqUheN5Kapt2ndjCmRKbcxvIkt1sKxkAWBFhoGckJm7zMQ+cN6a5VtCva
	2+o4wBqt/r2jJN39NSfTTuNiVEUnK5aKTFadphZYUQTkzDJ6zPdm8UHQyeir10fZO4BJXUdhVEF
	ObrXI8178iYY0EbQsBqU6/YRNmSG6oun6z3yyJGw6nsmSzAN/or4esfYKZ7KuCKQ+wK/r4fH26C
	2QuqwVd84bXcuSCY13KAA/lM9hAPZmE9eA2tExJT6k1vv7IYwbGjVF8gR8BaktYk1DTCoGzDVfX
	q+Nj4UI4jCTOIbxFQoo3pQf3i/Nk7RGvsUwFtdaozFzy8Z+XtBKfzxk902jEcVV+HduPNwUndEV
	oNEcy33R8gE8E3v+5Aww6D9BiGX/QNAUrI0osIqxYmBHbFqJoLMa1LnkXTdSQSMyzSV0tuwabwq
	O+
X-Google-Smtp-Source: AGHT+IF7aFFcCzQTmIoHc4LXKvok/D+zEwjkzlIMaULpCLdJ/TR+jbfCMOyMxdkX7CTceRanUDdmDg==
X-Received: by 2002:a05:6a20:a123:b0:243:d1bd:fbc9 with SMTP id adf61e73a8af0-32da8462b41mr9009265637.56.1759999556317;
        Thu, 09 Oct 2025 01:45:56 -0700 (PDT)
Received: from localhost.localdomain ([223.74.108.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e1bf7604sm2130924b3a.55.2025.10.09.01.45.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Oct 2025 01:45:56 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com,
	andrew@lunn.ch
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Date: Thu,  9 Oct 2025 16:44:15 +0800
Message-ID: <20251009084416.45542-3-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009084416.45542-1-jjm2473@gmail.com>
References: <20251009084416.45542-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 is a high-performance mini router based on RK3568.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..ec2271cfb7e1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -726,6 +726,11 @@ properties:
           - const: lckfb,tspi-rk3566
           - const: rockchip,rk3566
 
+      - description: LinkEase EasePi R1
+        items:
+          - const: linkease,easepi-r1
+          - const: rockchip,rk3568
+
       - description: Luckfox Core3576 Module based boards
         items:
           - enum:
-- 
2.51.0


