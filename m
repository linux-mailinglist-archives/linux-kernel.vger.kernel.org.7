Return-Path: <linux-kernel+bounces-808267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA49B4FD52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57822541BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181D34F489;
	Tue,  9 Sep 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0htYoHK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90953343202;
	Tue,  9 Sep 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424686; cv=none; b=Uwi+cIN65NSQ/Y8fDzl1bhdplCh2OlO8YyqaTmTN5I40XaVVQy4CxdvVn9ohxUw1e0f+WOe3pLEGSvl/WvhclhewIpY7aiUPxFa67NtAS4bmJfJbP0NqsoxlSkI58Bb39obUPeJlw67pDqMg+RwAnxq/M3sIa1tcMAYkXB8hTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424686; c=relaxed/simple;
	bh=74jqY+mnMXvKdEQRbPvlpFxLgryx3h4uviT6MmtE7T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLqgxMEqoCwQloAEUGMws05P+ZoqNEcdMYSKrwajgdR0e3yXojzyaPyKq3JT8nnzHUOC7NEEhEg9uBHVX2KjgllYjf4uViOiHCNj/SgHqXxoSxYKeXuJJmfqYaqv7edCPWCFTld/gW33SmdZ2guwDbIqrDq2+qHOgOI032lvArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0htYoHK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b52403c47b7so1085660a12.0;
        Tue, 09 Sep 2025 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424684; x=1758029484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgSML/DthZavsnlbDnrmGiAVx3wcugzJPKg3K/xvLk0=;
        b=S0htYoHK2z0BFPygbUjozuIj6y8CpLv+1YKyCRpJvbvNd4xsw852atzs/pqEAjfd9I
         mQSmrKFslcOEuYNbihe5UgC4dAZPmxrz/EpKNCgFyogcqBZRvLv87mkhdfMptWaO4Owd
         C+RsTbp1d7sKYsLYB25KSZTRbyjlA0WGtr9spxuhSJ9uWTxFJwmVpoUuunRzYw7IBcLY
         Ao2AdzsvjHha4tN5GAIS0PB9lAIlFZ5tEEn7N8+QtYB3cuaM+VwqWbYrCq0oVtbutoX2
         i7LdDqmOGL5Y37Qq6lFxRbTcjA0at4qYD3ud+Yesy+iFdslmyPQi3ZCjhlOe+5vKNuNr
         2rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424684; x=1758029484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgSML/DthZavsnlbDnrmGiAVx3wcugzJPKg3K/xvLk0=;
        b=Lbb/XesBaz+9VTj42fv4YUteLSSaeQ+qFDBP/2NTj9yEv+yvv0CuxNjIy2F2QWf8EM
         UhcEtTnMi36oTSTfyLJQpsSGFAu3EV2w5M8SJA224XiCLxKTCtpF1TcTaN/+CUOrTt12
         y50wWitJ4wOkxVHtr9B41CYIkDtHim4wmo+mLW6TXX/vneqPKtRioIbzCbc5tlExVwYV
         yrZeK9Q4CrHWwQ+ESGPukb4++M6WDi18XoJW3jjaf6cOP0fVGXzf4JrYen98ugg8Gvex
         /43SIdg+fHCr6bmOz3TZG8XOs79p7fCO+2ALBxiakgrgU5cDgRPJQ6MbfJd7E9tSZm5b
         +JEw==
X-Forwarded-Encrypted: i=1; AJvYcCVCOH4ZS5I9RN6k5RLUcTYZ1SDX/KiN2zsF/QcSMgucQWiTwIuXL9NqDCtFcmOJA8qCPt4f+Qfvfhup@vger.kernel.org, AJvYcCWwcYOd9E9wCeZEDG8Lp/wPSHdKSt19iy1rBRtCpqDgE9q4ibv3xe2oNj+Eq9pc9KpO9z0gYjbkbSJqlCyQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+gSnK+GdyMgk+bxGNpG3pAyOJpCRasFcUgZCjgvN4PNUsd2T
	DjSrKW5e3PNYHCp2K93BV9imZ4PLG8GqzXsJommUvC3sZewxm4/B0PDa
X-Gm-Gg: ASbGncuFvQriKjR2HzDdLtBURsQMjsSBX5fbAw50icXXU+SRVflAguLHRqRg+K43OrZ
	TXn4azo4WzvINmwfXJakXd/u+llnNifxVEzG8mIH7QGmzYdXfYka7MUaSEGPavVGNSrmPtcv5NR
	NW1xsc0FbwRVMa9k7i3Z2eyBgYCxHnHpTOq/xbC8rP+Dk4W5QW8Utryy4I1oLlf7nRXX9GKSYZl
	9qXZTNuwy1d5DtobpsKBDKHn3hqtNkXdl/981wGMbC7ouWQ75cjy0n3/76/ZbBMlF4ZVEw8ufJE
	i4vbC0bVs6RMt/MFP8TV+0BXUL9FIfmF3JeRN/IifYtzfsYnL4ZkvOCYkkUNi5rl5k4BH/AWuN1
	cfmKznjRlM6ORPX42+WuxZF91+OMc0GaEFz/hyRG3Vfdjl+t4JVo=
X-Google-Smtp-Source: AGHT+IFh0492S5Vla97I5jRBRsyJDDPnjkq7JJGcXNqhS9uUo8pi3cIay9te3rObVGyihMKVHOaRpA==
X-Received: by 2002:a17:902:da88:b0:24b:1b5f:1c0a with SMTP id d9443c01a7336-24cef93b49cmr202420885ad.21.1757424683650;
        Tue, 09 Sep 2025 06:31:23 -0700 (PDT)
Received: from localhost.localdomain ([240e:3a6:1c4b:13c0:db95:4539:1490:64d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab173060sm810778a91.5.2025.09.09.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:31:22 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/4] dt-bindings: phy: rockchip,inno-usb2phy: Document rk3368 usb phy
Date: Tue,  9 Sep 2025 21:29:57 +0800
Message-ID: <20250909132958.26423-4-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909132958.26423-1-cn.liweihao@gmail.com>
References: <20250909132958.26423-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for the USB2 phy in the Rockchip RK3368 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 58e735b5dd..6e3197c168 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3308-usb2phy
       - rockchip,rk3328-usb2phy
       - rockchip,rk3366-usb2phy
+      - rockchip,rk3368-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3562-usb2phy
       - rockchip,rk3568-usb2phy
@@ -192,6 +193,7 @@ allOf:
               - rockchip,rk3308-usb2phy
               - rockchip,rk3328-usb2phy
               - rockchip,rk3366-usb2phy
+              - rockchip,rk3368-usb2phy
               - rockchip,rk3399-usb2phy
               - rockchip,rk3562-usb2phy
               - rockchip,rk3568-usb2phy
-- 
2.47.2


