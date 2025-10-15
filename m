Return-Path: <linux-kernel+bounces-854671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875BBDF16F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1327A4843DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13328299923;
	Wed, 15 Oct 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoU05Q2N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6913283C89
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538681; cv=none; b=f8GB97qz4z/moMD/n4wl9MEtAC0R3frmUMI9v0C58b9rjhvj3qx2doSATKx6X0eMUm+H7EfGd41RkMRafvxmmb5cDWTUEZoGzCvQBvfq4S1WQbqIZIxhJSodC55dndkpIj8yt6Ii7f+4dS783JyEpElWHpbjkwP0KNJ+pA9lREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538681; c=relaxed/simple;
	bh=GwdorghP7pkx6jrL0xNhcOjrQ7rW+RmSi107hDe95KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2mo8TgLy+BHimtzVqWZIvusfwcUVfb5qLYwFKRGXbpjmbpoz205/EYz39mSo7ih2nuJWru/XG4lN44s0cNfcO6H0tut6MUqbfqaAk0IXMT95zEI5P1KDzrsjBuL0hn6iSKPaB95gYAYnc0GEBa3K/NKeVZqz3Ngm7AJHhYwNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoU05Q2N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
	b=OoU05Q2NP4VYdMY/UfOkjhLUNWh6jl0ik/Kn72uD6WKkwcwzYLv6qP02M8FGOBR/+mNCBq
	i3fpZ2Y3GPF6L7hbScy5MmPiRhNjMLcJ9rPJWI7MfbGsoctohzWbPVg6hYVPo4UvFk5KUt
	udJAcRY1XUtVocHO2gcsI2rDzeCmJoI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-8-4B47DOPraLO92EJL_DMg-1; Wed, 15 Oct 2025 10:31:17 -0400
X-MC-Unique: 8-4B47DOPraLO92EJL_DMg-1
X-Mimecast-MFC-AGG-ID: 8-4B47DOPraLO92EJL_DMg_1760538676
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e39567579so33258455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538676; x=1761143476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
        b=gF1JMTtuJHmHGWu1qfveUv5sKooisGYLPUtDgJ0G7zp9FLO6qLADEsp8Tp7MK9n7ie
         qKTtp4uoJlywLx8VaLrgHEFYNNi32KSQMdpPCaJPfPnI5/oAlmlWltJWpMyO1ByZupYZ
         IgX0WTRlsPPi3gYWCrn3NLuzccs/mYAkyAKsq5hBx06oj9/P5PBuPXUxnOIim3DfPfWn
         RDou/A4Ek39aXX2Zt2BD66OmyHmbslohMlQa8BJrO+f9XTl0ICMlU5SSw4gLtgDrqhtW
         piWp1Kk7F/Ky1s5RjCoN7GSs8YHqnfwHfOp9TsKp70WLVzZ9JQsy6ZI4PSeif8aEMD5D
         /ipg==
X-Forwarded-Encrypted: i=1; AJvYcCXACPUiuf10dGyANUOQvqwtvwkyh8lL4FG+O+e5lx+I73bcS1GtPnpefIByEgWsVOiHlLXVu3f0SDZjNfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMt9PeiqjJ2iXbD2Ibb6itqSvT+zEMBPw7N416R+/1pqy7N3H+
	XqfvKlkC/a+tIPJJA9P1Fs32FTVNEgr2J9CO0J7QpzGQNAj9ab0Wo/VwQrr7qnN4Ox0B9tRCwzF
	jd2/oGY8eoNyfXOO6IDNcBZ9zhiDyWvxJtziVV/ekBadc1/DAyarhad2xzlMPO40cIg==
X-Gm-Gg: ASbGnct2qN6e3XIsAKEhEf5RicFsQegO1T8mnVpq1nubAcb/04G5KTYEnyDjWfJsMhR
	jfC5vhtiQg9oh/uMKJmvtImED73h8E6b5ggpn89n3MEImE5/2ku5TCGwrZI93omJDGfxzSH2Qq5
	yRnM8Iu+Beopnf55trjSyeCANHoYhz4DsSB1j+YYnlmXwlSw8dCBG+iO8foFR5rxpSmtSK1OShs
	hFjP9/9EdVVOu7hOHzrvrUEeo6jI31B8ZyDfJdBkTeo6+Wzk4UGAzl0yRmjUlaFstfNbdBHKz0f
	VLwXN4nF20hrsjTYnfml4U+XutETQZ52b1htwxZTLKPRgpUxfEfHWE0=
X-Received: by 2002:a05:600c:1e87:b0:46f:a95d:e9e7 with SMTP id 5b1f17b1804b1-46fa9a22e8cmr198824145e9.0.1760538676172;
        Wed, 15 Oct 2025 07:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbhbPu7WeSNuCo8Nsr9nlyoHz+U6/8eNZskwKh5mPgPSo2143HBfoEIRLP8xrfsw2uXJNMhg==
X-Received: by 2002:a05:600c:1e87:b0:46f:a95d:e9e7 with SMTP id 5b1f17b1804b1-46fa9a22e8cmr198823865e9.0.1760538675703;
        Wed, 15 Oct 2025 07:31:15 -0700 (PDT)
Received: from holism.lzampier.com ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c02377sm32617005e9.6.2025.10.15.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:31:15 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: devicetree@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vivian Wang <dramforever@live.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add UltraRISC
Date: Wed, 15 Oct 2025 15:31:05 +0100
Message-ID: <20251015143108.441291-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015143108.441291-1-lzampier@redhat.com>
References: <20251015143108.441291-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for UltraRISC Technology Co., Ltd.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..887bcb792284 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1642,6 +1642,8 @@ patternProperties:
     description: Universal Scientific Industrial Co., Ltd.
   "^usr,.*":
     description: U.S. Robotics Corporation
+  "^ultrarisc,.*":
+    description: UltraRISC Technology Co., Ltd.
   "^ultratronik,.*":
     description: Ultratronik GmbH
   "^utoo,.*":
-- 
2.51.0


