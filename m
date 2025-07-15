Return-Path: <linux-kernel+bounces-732647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A8B06A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E111795D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342AB2D94A8;
	Tue, 15 Jul 2025 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB/0eKjW"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B72D8363;
	Tue, 15 Jul 2025 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623182; cv=none; b=LsW/hWn+g3c/YD44migoXyFim1qkwI4PkYSgKvkVkLCUr0fFYmG+9S2FBxapxaGzm+JdsyKBjeaPXIfWi1Vjeu4RAkdtiyoWQ35UPy4fEBYToZSPps5alsMIFnps+Ls/onboj5XHi37mtV1oWazgnZTI9gCxfAygz+t9HrBkB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623182; c=relaxed/simple;
	bh=QTOlSTZF0Kq82mSJWss7ezwKxAIbP68WstTo54BoCTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx/4ERF3uaByT5y80hIxolEDJk4mbZEkh+zjMut8dOgknDKF1UDDMKzc/oD3SFI5xQ6nhIixjqZUCsPMfkitsdMM0MMrn/221e7vdlNk3vCvqaQBaCpGUiR++1N20/mjunkbSDgHZt8RL0cL639oiu/btS4vszHqrC+9I8f3+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB/0eKjW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23636167b30so54477285ad.1;
        Tue, 15 Jul 2025 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752623180; x=1753227980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia4kDO95PApR4azhHYT8fCKfR9Mmu2+2qWFqN52ZBuI=;
        b=WB/0eKjWZ471lvjKxuGuVU3d1zKNpbchegv5d20K2Evc1muJSOKPR7Dc6lKnEVsVQV
         NB9/CeOER7v11SAB8V1NB07aRK39RMR68WXrMlGWw0yTu+0TBQDZ7HVCVNSUcPauW+VO
         iKwpB0nzhCyxmg4Lie501T8NjxD2XP9LxLBM8zq2B5WHdDfx+EMnAPcZMHc0SeFbOI8A
         pG60ZC2WVjX5EEksJAmHT8VpXdts7cE3Q9EvffeLyHlKZAgfAN7i/oeWUFMa/btyXaTE
         WXLY7NR+wGhWm4ofq9E+JrX3n234Psv+Jn2LAeGausC4OTiCD8EpsFrxkI/1ltHFIcIH
         noHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752623180; x=1753227980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ia4kDO95PApR4azhHYT8fCKfR9Mmu2+2qWFqN52ZBuI=;
        b=Yj4e8xymlF/L60xxATnfVudYFnfroTEt4sVpL/PXg+uByTLFpABJs/i85H57+ea/6U
         WZQcwu4hYabgWknS/Gytm856NRbX/KcpqTCoeDCUSZZTieJG2VvQcWkAX32rGSWIKGky
         jNvtFmpB89EbQjw3Rr/cHPP3N9nrEJW3UhAlMHSrs3PRpcZ+Msi/aHRaPlOMwyo+3zNs
         o8QUGN2tN/7VbhHq55WAEJT2CMPcAh44az1HecYQBnqE79hc9+2dGsLSFhPxICBcD+TJ
         ClW1xd8oC/FVKD0PlAfcXE3c1OacLon6yU7Lx1WwiVaVNL26JFtvqn6OAlVRfTNqEJT7
         Iq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQqLZlo/lvPfkz4b3TaFRb0A5AQ5KNxdCQYfYAKiKCChyu47lrbaY1UGXRfHdmB1zq3bPJdz5Zwjes@vger.kernel.org, AJvYcCXqESsD3fdzQ/XAReXjRJYVyyH8zAeQqUJjKy+DnUHQbh1n4PefYsRDCJ/wGNEa0UNrgKo1HltnTV5v5Wda@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoxn6l0Bff4n0HEgTdWWPA0zPd0ZywUqcYokU11XguFyxEWQy3
	3dPVnrLGfs47tCA2p6+ukR5Ing+e/i8VshtoYnW3K0JaCPwtwvRJx34hbnSQbA==
X-Gm-Gg: ASbGncvmPV+KF2p+//+m2QqjAtbM9d4JiTrPkpO7s+B7Bo0z66xOvD2kd0l6MI+idty
	CZ4ycZDJpX0mcXSmeEdbLM8oUz3cRJxa0jVm3RahFuEIq9gSdncbZQTw/FAzipkKFW5sVGI+YWS
	fWEHHVAlHlSOfuJF3oPYc/RmfiBLuLxBFHXBpgxSEmFO+4jGqmjTiYK8t5VGdAEpkBDYBwIKNiY
	qYKpCBsLS2qIyjrWWMFIoTutENfC4JW8WDmIQnIVyozls7SaxBerayDwp8Q+5zixMBcbJ+YhgwC
	dQaPD7/hGlaDtVcWcCw+HyTtEWiVKAeRlv8KQYTKEt2Qjb1ffl+SJHEoK2t8ehU+37iTHCT6eAU
	zgL1hnbbP/kBblIXsP9yjfipVe0kgI8nXP2JrTb7o
X-Google-Smtp-Source: AGHT+IH2nkjZvGwaTOg6LthZxZlbydbXVCADz5L7udO68b0LBofjPvbOA3Jq+0s04H391rwyayIEWA==
X-Received: by 2002:a17:903:228d:b0:235:ed02:288b with SMTP id d9443c01a7336-23e25730152mr8058985ad.30.1752623180485;
        Tue, 15 Jul 2025 16:46:20 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b28a6sm120031265ad.87.2025.07.15.16.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:46:20 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: reset: add compatible for bcm63xx ephy control
Date: Tue, 15 Jul 2025 16:46:03 -0700
Message-ID: <20250715234605.36216-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715234605.36216-1-kylehendrydev@gmail.com>
References: <20250715234605.36216-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for bcm63xx ephy control.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


