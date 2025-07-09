Return-Path: <linux-kernel+bounces-722682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D244AFDDAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7426D4E3505
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B811E7C34;
	Wed,  9 Jul 2025 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKYU7Y+5"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DB1DFD9A;
	Wed,  9 Jul 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029277; cv=none; b=iVB4w/3uEwNGxBRnMaVtePdl5/U78HGN0JduGseLLyjS3p96h4SoXLKlpEcrNF+rwCUFR3Quh6awmrRAOTIF+/zShqMQm3d966QQFTIhnjwG1z6qVzN9ISmoRbEfcoTsHErK6HYItIdi4YlOqnAhXUe2ePqDOLxmHP6S+oX9jTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029277; c=relaxed/simple;
	bh=udArArRWFUDbtjVfaU8tEqSMaua7p5ESx6VJBG8z1U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr3/nZUfoG7y/vBFa17uDPgqDOk0piGgpXK1II2HLXjdU3H+vljrbFFGozB72iqga3sgpzK1HVmAe7gQ0x8p6s/r/PXGmjnIIW0AFWoXClORVYNJd5+EeCURYbSJVegbbCtgipMLKG2EvkCF5/htXelHCsezkOclta80G0Ep1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKYU7Y+5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so3696668a12.2;
        Tue, 08 Jul 2025 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029275; x=1752634075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As9tTvp//yaZUYeaTKYibSaYF/FG2MJo7/aKqapg7nw=;
        b=WKYU7Y+5DDKLOL1rZwUkzjA9n7Hb4PTzfjid1MG0w/B/IgqHjJo9utxYtmiLP3tSNe
         8YwAVs0iYaxeZu0gLQGc/A0lX+8qHi/lTDDjyiCyhgXB4xnZfMhRujp7DvILcm275YiO
         Mai7aBV5XWVl4o+pADlBIAQ47NHB0Tr/pejjZkuwjooIav+q21rXmvoIExsyCRfkYVX4
         d+m5qCIqtpNq0dDGCvKPtMxgEzQoicb5wwnMQpI+7pql1zb/6DD/gCy/A7UNyLYB9obG
         4YsAj72nlQbwaSeYD1h3+gPgathRShk2+4XsSddyDbaOYVDQkQyglad2UgK8rXlPdU9p
         3qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029275; x=1752634075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As9tTvp//yaZUYeaTKYibSaYF/FG2MJo7/aKqapg7nw=;
        b=Oz3nFM0q8jVEOVRlYzrkjTC4vxtXBGk/1Zpq8V4g54zky1o60CGqdDXzUXEd6c5q/H
         NLU+s1cFfmE8jjWYnfXB51HiBTcA4sT0F1rm7XGqbSwYw3N2NFqOazlw/SxdPv24Ew4O
         pl9pYWzn4gv9KBHYKUHemtpXbtCIzbmeBvDxSDxVyowa3X9uAVFRFw4VWlt0W30kseiw
         VacLqCQgm/mIEGaeI3+o1A4Zw7ZDB5IN+bg8Gvge7wjlU9I4pAsRd6AdfeTGrG1eUsx/
         hStq90ZD3N1nYr2n6UiTRiiIrfVkLpIJXGXfqooIkQqKX52lcm2F2pV7YMhWuSV4maLq
         R4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUI37s6AGvfBAMvbuotWrWGhzC6nFuYGb3FlTXjsWGFqsFDNh0pEHru1d6shIVAHKOtxMczHhCnnCweIWjV@vger.kernel.org, AJvYcCXbdQwwF+DOwZjajUFZu8+DgDXoBhvkJSx9mc/kO7Rr4KHHfi3S5v21qArW5D+ppStEleQCLufoa1ih@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCVI9xpN0PpUfu0bD5Gbqpky6XKmUQ36lGLsxvORMMnHwhZoj
	/91qq9OaG83CRjrHYBIehh4g3N2hHlmK7VY+0RF0RLexgkdxtYSYgCSr
X-Gm-Gg: ASbGncuz/rHHOF97lO1WbpoxGxzVLC7n/VnhXtOJM/YQOWkTEYYktXdPVdVu0OnQNZu
	FiKhV8XYCldQl248CiiTQnjkPIIyjLBoeUCyfinqkvOrUEmwVvzpx7E4V/gZBlSg5XMAO7jDYyV
	wliwo9SNFcdUFQHuY9N3t21+QTvs4LMiU2mB00YbCXp/BEoxVuxa9l0pzKrkmMTId4LFNFkj165
	EZUnSrIcWyCJCclBxO6vBbbsqn4u5QJxPl2WdQWbpdEjyV+dtU+6tqn8KD3+HJ3Zxp0+sQp8uLt
	dHGQ8tq7yXOjh4oYJtLxtRQbSLY41TBcj92vy9KPJm1hbiCJXI+0g54hwN9kfDoPvGOiNPnGntQ
	jdYjGx3CvJaX/Vxk=
X-Google-Smtp-Source: AGHT+IGB5Um/wExt+ZkFY6T5iC8L1PVyN4uMxXVdQ3GuLmB90WvlG1nFqT5YFgxphQo9S7K8MIPm3Q==
X-Received: by 2002:a17:90b:3c87:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-31c2fdd15d0mr1623090a91.24.1752029274847;
        Tue, 08 Jul 2025 19:47:54 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b50e8sm535082a91.31.2025.07.08.19.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:47:54 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: reset: add compatible for bcm63xx ephy control
Date: Tue,  8 Jul 2025 19:47:26 -0700
Message-ID: <20250709024740.194520-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709024740.194520-1-kylehendrydev@gmail.com>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for bcm63xx ephy control.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 .../devicetree/bindings/reset/brcm,bcm6345-reset.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
index 00150b93fca0..b8a320bb1776 100644
--- a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
@@ -13,7 +13,9 @@ maintainers:
 
 properties:
   compatible:
-    const: brcm,bcm6345-reset
+    enum:
+      - brcm,bcm6345-reset
+      - brcm,bcm63xx-ephy-ctrl
 
   reg:
     maxItems: 1
-- 
2.43.0


