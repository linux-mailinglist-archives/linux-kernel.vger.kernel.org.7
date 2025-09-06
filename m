Return-Path: <linux-kernel+bounces-804005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A6B46898
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4071893D81
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836D23CEF9;
	Sat,  6 Sep 2025 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHzbtpuZ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A62238C0F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128829; cv=none; b=Ht1Yq6V/foAj9o6l+F/Skjle/bPl6OZgxxdOErdrOzBBk4xPfZXjFXPq0RSUFl49gxA0AlkY4VigV0WZ/xhxPQ16h9uTqqg0MrDey11oSmessKerKzueh63Shj3hcfEPyrxfKpBQrgA9JFi+t+B07FatQIwqIltoRqyBm3DSV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128829; c=relaxed/simple;
	bh=4nntbxd9QhxEvmQibcuTIkC0BAC5Ve0dSQ5OC0TBN9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2tUXKTemd46PHU46aUto/7O+E38nsyfRNAIS+hDmfWJbM8i+tybfK/qfW2GbEfR5no3YsohOjYcxsXGlGw5XcuvV/u0RzGpsiIFKTN4YsMBSka/E9++01moyelnpLYwEch3Qe5s6XY3lctb+s4O6mBCtIa4ZrTk6qvmw2mq7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHzbtpuZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2509519b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128827; x=1757733627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkyhEF1uSyF+/KrhAZe6tTEv+I/fUAI0IzZh62oGhRI=;
        b=dHzbtpuZ7W1z5SBcxodd4WHx+irDl8bDzeyeTpi3HbpFEHrM+0jg+yPyVKPPnSh8me
         iGxGv+bgGEKuYVI/0kNiv0J5l58IPO6VTg7wpWDed/Oxl4RaakpvNlb3PqGJkmyPQ3cr
         4W/Vf60NIGy9m1snpwruhzH3PnG1Y4ADTEY4OMTCMzrXwtcNkfln/RVQLwsUT5I3D2bl
         Ry3MMODoKoBj/ewGjV7yrt0R5ZOvHMGJt/wPd0b7PSQ5fzOfCduqDh8YyQql/ShkEOrb
         s/UOTdsOkRkHafx3WKXV4PkWvNtDn6IeOL24TNg9JFs/1K8Tx0yNbHJPPDzd3hEMtjhT
         gbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128827; x=1757733627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkyhEF1uSyF+/KrhAZe6tTEv+I/fUAI0IzZh62oGhRI=;
        b=kKgHJszzTGuOIaE5EeXhhmYD6t9bCf5fBJlHzkyBgVERXHiwtucE2vVHXSIhfe4IrA
         xZPEAtsF2dSRxAOUJ6vRQXKOhz2AdsndnvDWmDMV6BTDrH85HpE8wMRIWb9cBGmmD10m
         nJ2iJLbfydXBz8/r/d5ROu2lTC7FzKDHw/Dobeqyl3WcmSn1v0u/HeQ1JLUZ+GwZ7zdu
         DEGCwHl2C9ld1hDMje5dSqeoo5GPUgyKUKDlkSBTlbzJL7N2dfoZH1uopVz8u/ze3EdH
         L5HcSgDNZoPCZn9m561lzSLPuBiLYYxOHXe75MZX2ms+ecywBIKZ3Tu0uHIbQwc2scic
         yNwg==
X-Gm-Message-State: AOJu0YwxNEKZmszbLucFiZ/ysHzJ1PK6qU0JM5Tj/4vav8pUQqp5R/1R
	b4eaKg6tUSnn3IFMMY5+CDpkASJ9P9IYK19uMuR+ozCqLsAQ587lemWvAZp1uQ==
X-Gm-Gg: ASbGncvPPjPvqRL3ImVO7K7mrg0YUIVBeJTclYlCsL42a6IWZvkU/8BS6xEsIKt0Afx
	UywwL0Zb2uHMv8z3FFs5zEMAtphXzr7BFwq3va+xy5XnWD43LY/N97A7yMGQ7hF8DMLdfJnOySI
	BkQXA3t4ivDD26AtcN7QcgWEIOVMTD/EVukjxsgQOXlVwBvG9UBAi/HnniM7JCe8pbBF7RDpzQK
	E5p9U5raiWoiJUxx6zbOW5Ul8TMuM+AhjnmyCE9wEJuTvLTbduIKzpM3hVHwB3pg9qNbq7Gv0X6
	V3+FzgWDqUZ85GIRXWPT5hbA2bGo3AUgg2hPby+67vbmssGC4hKlSuBLwtkTvRJ+GzY/7r2HGlO
	VES/ISPWehLZpniqmc/8iLSLrBrhZ75mwm7/kSBtKKrg6wn4g793S5Hm4D1Yra3hattaN
X-Google-Smtp-Source: AGHT+IGJKaTuisA/PevSrhEJ1uewTsFYjs8bLWJToNuJxXcj/bCdRo/jljKaUVEWXC+M45ju99hKHw==
X-Received: by 2002:a05:6a00:9162:b0:76e:7ab9:a238 with SMTP id d2e1a72fcca58-7741bf66911mr6337232b3a.15.1757128826579;
        Fri, 05 Sep 2025 20:20:26 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a090c77sm23093074b3a.0.2025.09.05.20.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:20:26 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: maintainers-if-needed@example.com,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation
Date: Sat,  6 Sep 2025 11:19:55 +0800
Message-ID: <20250906031955.21338-4-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250906031955.21338-1-sef1548@gmail.com>
References: <20250906031955.21338-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "Intergrates" -> "integrates" in documentation

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml b/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
index b1ade64a15..1705812f2d 100644
--- a/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
+++ b/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   NXP BBNSM serves as non-volatile logic and storage for the system.
-  it Intergrates RTC & ON/OFF control.
+  It integrates RTC & ON/OFF control.
   The RTC can retain its state and continues counting even when the
   main chip is power down. A time alarm is generated once the most
   significant 32 bits of the real-time counter match the value in the
-- 
2.48.1


