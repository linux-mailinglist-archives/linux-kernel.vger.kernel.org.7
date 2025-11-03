Return-Path: <linux-kernel+bounces-882564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88EC2AC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5F23B1670
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F072EB5C4;
	Mon,  3 Nov 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giLfoaBn"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF542EA17D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162438; cv=none; b=fDXNA9hsPbbf18RPAxeXfAcwoiuN2MmkaNg2CPwXNBdv/P40ieTkgl0AuCDNckcipOO23noxMxpXXGwwqmXaTsUv85075zoaiAsaZaDdiZO9e0dOvX29r1ufT9yNvMK3TVuymqUioL0h7x43r/9Qvt2JPZuRBWzyXQbmLdS4cLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162438; c=relaxed/simple;
	bh=D4T4s3SNgWEGdSKy6+YGhcgGrNqzcT9NA8JLZ8xPMUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iu6LIp54hs+hfX29lEFny6K5gLrQsofx4FdzoBbWMbz0S2VPGdCsS+ATbd8XFWmm3a87JwM9ci6/clskmQdCXqnRsMVx05vIZDGostghUM5/PL8GfASQvSsLV66QXObUaPGXh+YjtywPLQHnpviqNBlkO4pi4AxxVt8c1VYTork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giLfoaBn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so4079955a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762162436; x=1762767236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF3tE7PvrhPTALHjWZmN+099uKS6CXrFf6F9PXA5mFA=;
        b=giLfoaBn3QvlAuOoAI4/tVlTuE8+aF8J67YlB1jURAm6U+CW9owCkDJkhKK10XalhQ
         PZPOkeN3QlUgr7+aOFHwglOhEb0lR/3GhtRLlt/pJDCRXnq61TbiLVXH5R4phtWkDs0/
         bgDQXGOZHqCuyR5EcJBfkzGBFLcnnVPAKrJPV9rEgUrqMFBo/8R/aJK2FP8Brl49zUQw
         msPwbxKTCdw8StJJvilMApUorXyJxySeqzxTD2xfBy0oqJHZa984jzqWc/KusJNWc9aA
         3zROi53m9/jB9cBWQ1PYgba84X1jIb+sgLHkL+dpsbvXIl7TDP350s7maim0OtdbDuUo
         gUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162436; x=1762767236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jF3tE7PvrhPTALHjWZmN+099uKS6CXrFf6F9PXA5mFA=;
        b=Y/BBpZQFewTkQ5cnHpNcp8UxC5mWioRMSEa2Jk+lCcbICsYI0vPxm66SpGx3xX+8kD
         nCPUuPpqVgSYL22TkGV4pRR5VJ0W8TMlv42VAFtoS1gVY84SCUAFcttCsp8+rM82IHc/
         ZlD8/iL6jl5Iqlb9Hc4osbUG6TzSXxUVlf4eeG2YHNfV9112rZUP9P5YF5HxRXAQ0Eb8
         7He7/0kEydb0DF8MCfZaUNT2jgwkUGtrMLTjJE7cC2MBTS3w75sLqtpRvXvmMoe9RNO7
         hMeKizDxppae7EgvYFl3jGpl5VhL32qkC+HCE3oviPPJ0Gs7A3jy5bFOjHEUZXlQ998U
         +iQA==
X-Forwarded-Encrypted: i=1; AJvYcCWdk25/ADYA/VAJfk2Gr+qp6lqK2JYuEm8N0thHCuy32sdWSX9FSrmW7GAgLG2nzI2u1nAe1DsJ02+7WbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+A2g/6pbFvjzI6M+bbcZ5q88SxJszIym3ATrKmI7170sQoHO
	Ufku/ygpHT56xz8OP7LBU4s17Esqgi1DFwTalnnvAL9J5LdrHeOEdjaP
X-Gm-Gg: ASbGnctmp9XTyKTLKyTzxd+nBRJU8mxsWQ4np3rpYVxXNmysQ+xX72zjSYxjIh8po3O
	jQkQ1IpRveUiRJq7M3g6+1601iMfPhoStReKJ1xQqqbZew6D3RADeB79UtnhxDiKu23gO2V83JM
	uneBWg6M4nXthV8nAB2tTJ0bFz/j2fQg+2gvEEC+ABIJgE+bo0uPDqwL+O8vZXMwlkFkbGMZTF1
	KNJnZneworhumrLdqQUpP+CgvdIUy8AjJXfvYWv+1XXXD9FZV+W9e5fhVRVgRmvADNaF/hHoYAg
	yXwwEA+BE2Q4G1gN175uknRJ9hq3V6xPpwlWoos5KNHqjK3jX3bJ9eFhpptocaPhyOzSpdkpRo9
	pGv8XGm6ClCbOiR5poTtIpbkWQmauIOHHnomgrurJF2t7teF2LYlUFZOVUu9cg6hkFkmNhljzW0
	VKwJN1
X-Google-Smtp-Source: AGHT+IENCvGrL25P0O0Fc+MRrko1aTk7mSWYGPtk8oKD7ItaFZLfQ0P2sXgV2rrZRmkjGd+q+PpjRQ==
X-Received: by 2002:a17:902:f606:b0:295:7423:530a with SMTP id d9443c01a7336-295742355fdmr75326455ad.29.1762162436497;
        Mon, 03 Nov 2025 01:33:56 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ea51sm112351435ad.57.2025.11.03.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:33:55 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
X-Google-Original-From: Peter Shen <peter.shen@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
Date: Mon,  3 Nov 2025 17:33:19 +0800
Message-Id: <20251103093320.1392256-2-peter.shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103093320.1392256-1-peter.shen@amd.com>
References: <20251103093320.1392256-1-peter.shen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the compatible string for the Facebook Anacapa BMC
which uses an Aspeed AST2600 SoC. This is required before adding
the board's device tree source file.

Signed-off-by: Peter Shen <peter.shen@amd.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..bcb874ebd9d2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
+              - facebook,anacapa-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc
-- 
2.34.1


