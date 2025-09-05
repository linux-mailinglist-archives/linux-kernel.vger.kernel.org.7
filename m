Return-Path: <linux-kernel+bounces-801956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186BB44C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563E84E387A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8774B274FEB;
	Fri,  5 Sep 2025 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4kY79d2"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEB25C81B;
	Fri,  5 Sep 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041059; cv=none; b=roZ9NOxu0NO6MWVqChuvcvQMky9Say7QtA0rxKzuiEnVYnDBvGPzJ2H1jQReIhwfqJ7FxpbsPe2qb4BCflkBHk6lhkbQx9h23Ev2kqMeZYWGLCxB8qUGCPPH6q7MnMpqogQzSEMsK1zKmpjwiWgcGPyBWw1bDElOj4Y3lT0+Cp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041059; c=relaxed/simple;
	bh=lvIrY2FRB+n49uDbGffgaHvmurtJEX1Eal45Q9qqT9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lN28rIsp/1O+N14i80nGrINj04ZFIucp9w/qLZxA1lNZdAAQ4SEPRSKlxoyJpEmC+fEfTV/rCL2OjH4Dy3bueCmGKgmQ09DeDwUAHERfw+b3rJscJD5qF9c0w4vrjSmuhCgW95HenVV/RbEU/Z+JWkkHENsPKRenSfPoBH+s0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4kY79d2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445826fd9dso20890975ad.3;
        Thu, 04 Sep 2025 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041057; x=1757645857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRp6UU6DIJUEvKAJ/87UvE/hlm1P5JGXV4jsx+n8jPA=;
        b=l4kY79d2GXFy90qj615wk/NiM0wa9ZegBUlBorMzHhdbeDAbX42iFlSPl421YcROj8
         mep05vkxR8o3z9/hHtgacYiTR/oLBG//XSyKhnu+6ameFqRmswyD+qQueAtPNjjjkRzg
         VRwGL4PShZFEZE00l7SoRYh5+tYqZ6qSaYth5tHhwP96a8Y6Ll2x3LvYAI+KHoypiBQu
         JX6W5VoEvYRjJe1fuvvi+edHR5MYwXB958yJjVR6XZFYVAuBEKWESJBNRU4vzxKHA3Q4
         yBb/nIdskvptx2ZCD98kCI2nlLLONom1q1Mr9TnvR1tAc8SjnxvC7cxbhUeeXBNz9HPs
         H26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041057; x=1757645857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRp6UU6DIJUEvKAJ/87UvE/hlm1P5JGXV4jsx+n8jPA=;
        b=JqcTWUIqpjEn89lJBDiWDjDwCx+7pslfVya0oBXF3GbzJ+nkN94f3BiM1RyxZKZixf
         7YNRBs8emVsciwoORoiL7PMYsZYJxg7ewyQkAo6tHZVYxS2fWGuFlr8SRTxTPvA4bhYz
         If6R7UeGn3bk1ql7GOe19hMeh5EyulJ/PNIf4OtmxzCu3SvLkGk1K8lD4+07TWgjYX7k
         NGpMrwQ4Waw03AhKqU6j5sdD1ZmZgfydmLFXpozfDXNn4H+N1q0WzySYcvdrsOPATWKI
         UJAPwofINoxYC7rB5wN6ZP4atfpRPjrmqsOIczY6H11Y8M5LEE/WUHJ7CUm7cpqxuDE2
         j6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1E2NCxemQVhhqB9hv8D1x7WoCBS0Zv2Il2tMXjX9qzGZ/6YS1mzVWnAQk6z7V8WjobgvWmxvHZ4Z9@vger.kernel.org, AJvYcCW1lwR2/AfHb4yb47n12INSCYd7PSRRiAbLuc1lltHOQR6EnkzbZhx+nFIQB+5cXV3KITmGtscI11VA@vger.kernel.org, AJvYcCXz0DWQHleflXpLfhw0/PcBKGPfPx1tYHNkDJXldNAnmuYtVrOblGgnvqyCn5LbpTGjx5qkcvtJ4j2pJTjh@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1Q0Yt1ipfAyyJ9fVPMWF6kEw4N/unL/743k2S8PhJof+d0f0
	5exK7+YuBl1JJuHz+mRBI8jwYD8sHfmv/by80vQOBpxtmbqmjYPTy8W0
X-Gm-Gg: ASbGncvX5Ddiy1nR/X6g05u+Jh/f2XrwnGRhoeHTi3jVLWQy0iEv4SISdWCM34fiAjL
	pPcRjqXMaHmcUB0+lKffBZYTo63+XeP9J5vIgdSvavJtq5gQJ7TqJnhhzfnY2a397Zm3rEM8f1c
	6vuTa3ZTl3h0ATb+mrF5p1eOURszkbGBnyugRioRc/6MDSNgvnWMUswDt19QqDd66V3F4wO03LR
	SR18IOAY8YkoZrl1RAeMvFNdvUZpFzgWjCe7lTh4WTlanV5kl5ssQpiioFdLMtha3myvBNZTE2J
	6UPjGrU7DBm/Uios37bDxmd6GvuEnagHH3oNBMXTvegvXTsTOi8BMTMZ47wWkEzAvUUDNQV/ywB
	c0b4Ua7Ycmm8=
X-Google-Smtp-Source: AGHT+IFbbE99ORndFVlnLgJhcnpGQSRKqSs/VqX+oFl4ShJ9SUdAsUmhzucQekk/6sfybVgodkOxlQ==
X-Received: by 2002:a17:902:e5cf:b0:242:8a45:a959 with SMTP id d9443c01a7336-24944ae5ff7mr282610105ad.47.1757041056691;
        Thu, 04 Sep 2025 19:57:36 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:57:36 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 8/8] dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3368 DSI
Date: Fri,  5 Sep 2025 10:56:32 +0800
Message-Id: <20250905025632.222422-9-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the MIPI DSI controller for Rockchip RK3368.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 .../bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
index c59df3c1a..632b48bfa 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
@@ -17,6 +17,7 @@ properties:
           - rockchip,px30-mipi-dsi
           - rockchip,rk3128-mipi-dsi
           - rockchip,rk3288-mipi-dsi
+          - rockchip,rk3368-mipi-dsi
           - rockchip,rk3399-mipi-dsi
           - rockchip,rk3568-mipi-dsi
           - rockchip,rv1126-mipi-dsi
@@ -73,6 +74,7 @@ allOf:
             enum:
               - rockchip,px30-mipi-dsi
               - rockchip,rk3128-mipi-dsi
+              - rockchip,rk3368-mipi-dsi
               - rockchip,rk3568-mipi-dsi
               - rockchip,rv1126-mipi-dsi
 
-- 
2.39.5


