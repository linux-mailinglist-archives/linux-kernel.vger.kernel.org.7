Return-Path: <linux-kernel+bounces-813301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8484B5434F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1949256689C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24C289E30;
	Fri, 12 Sep 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f26NHkxf"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188428A3F2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659932; cv=none; b=TPAHGSHFbEETW4T33Ja0NoJKEJhhydxKmjqCL+TGPK8myCDqlFOBN50Zr3E1YFH+s8UZ0Mk7lDSqsV7X1ud3CG4GkPBR2tSrOBuPYSsV3jBlvsC+HAy7BQKtQAFgnEDDifrwwRQ5ibgYGw5Ejpbh9XESdEjMHob5MJIVZtumd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659932; c=relaxed/simple;
	bh=V41BZQfbkLWW55oGb2ig51t9GDvirhFPE3G8Pk3DMsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QR3F9vdiT3yhNlYthCsr3StDPBxVl0mVmQBw2YldXKPgpr68OQxjA1nqj1eUsZnosIxSsyfm5OXhhNUN4mzGyFOH71Lbg43kcjeiGqVG/kPtT0SbXRtkQnOLircJpb432Zm/efhk7//zxBeNxFTOobEOffcL5Enmt4Eh80Cirkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f26NHkxf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336d3e4df3eso11433641fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659929; x=1758264729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reNiXcD7TudqB/sS5bFygtRC8HYtT+QaCqNOvCQ02Zg=;
        b=f26NHkxf9w3ejpmy5F2Z5fCcOevfdy38+JYmn6rfeWM/onGP180Ny7ImfeWYE84iPt
         /vxmNtKtRRTGWklf4CmQqeYpHdmAEoBb+0SLtiPpNqgkIpumQtMH9YIE1dlSVL0gHef2
         8HF4CMSBC6KYLBL+r5rBuWdnO6a9ioTbF6qBqcC9dZ0MvG59TYnUBnO7n0ZPlScfnkXb
         7ChFc9dkiiLZ82qtK1noPgg/X67YLXEzcKj3WoJCqPj8XuKQIgaXiTzSK5SUgtJW8ODH
         n9UdtlGA4ATxPEJx/AKHH6xv4qxYvji2NptxK5X86T3l04DWR4Ws+SYyu5DTBzeLUIaq
         8gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659929; x=1758264729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reNiXcD7TudqB/sS5bFygtRC8HYtT+QaCqNOvCQ02Zg=;
        b=CWhWDlt+nGeYchT6a400yio/2w6dbCnHaNRHUqvHCAZY3zyQW2RNNYX3jHsnluK2VY
         CQaJeomeb+hH8rRrdO8Ofa9/+0J8SlP0PthsOF3i5LoT3xyJ4AXOwXDyp69Wqrr1CgRV
         WVT7zSET8L+b4yhAOP35Nv0FdDR5uJnbU8rImFiZRwkoVRc9dI3OV688ZlOQFDN4Qud3
         8EAnO9latxX8Ey5xVMgOR1aI/ZdTPFgrG3xYbkU9p1PBOCWLWgeK1/yvUwvgWoaNbpXf
         kVDP4OXHDjdky7W+efRiHMsvuwZsGpSTTI+51to7kAoy3d5LwpZ9dszALIkpfCYOBMqD
         1ffw==
X-Forwarded-Encrypted: i=1; AJvYcCW8+2Inp6xcwU1VzOk3rL06iRQpqWZWjsGMXpxXuCZu+El7qmmRL10jkGwUh8KFE9JHrTTJgsyFTZPIJoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtaOPsxlkpp9GYxivfVvPu5lxLjaxdvwxBTC8n9yr/34lx5R9
	ZGPlBS8zIwowwPvS+vtGHvumsKICSnif0bKKzYgc/dHOtCGvVF2dHrEB
X-Gm-Gg: ASbGncskKKXnp9aILX0vBVkWiMync8idJjVp+CVcDGsoluiFg+ii7UlvNMyFFDkmrXk
	7b1g+rIoe/nF75kZSK91igsSSymccrUnN3C/WD3LPjoUOvpWM2x2JU0A/P7RAHd2gQuQ3NSwd6R
	rFHEpkC4LO7leiyphQR0aOr7Hu2agseJ1ZnDSfkgBVQdb3tyttS+OaVffx7K0BMNI0EoO7el6pw
	vDc7An2BfwX5Wafy8O90YFSuY5Te3uLj45OCVLXkvCMSFf+t750c722TtBubOx7vPWFNlcDA2k7
	4IL7HLBVlpzGLJGTi3VqikEri0u+NUhpOx/Gw5Ym7qQmchSSMLC0ThM/lWRdUWIZ6xMz4wJ4fpM
	iqu2AdhonGU3JtF3F1Lf9r1hO
X-Google-Smtp-Source: AGHT+IGn19z0xbyPOa9s7kRxYEyg1LgSwuY7k0e7LwK8I1bGyacmhk0zyrN8+bwF3af8FbUua6ViGg==
X-Received: by 2002:a05:651c:b0f:b0:336:dd88:69e0 with SMTP id 38308e7fff4ca-3513e12da16mr4691341fa.29.1757659929207;
        Thu, 11 Sep 2025 23:52:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c5d5a49sm7180351fa.66.2025.09.11.23.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] dt-bindings: power: supply: bq24190: document charge enable pin
Date: Fri, 12 Sep 2025 09:51:46 +0300
Message-ID: <20250912065146.28059-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250912065146.28059-1-clamor95@gmail.com>
References: <20250912065146.28059-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document active low Charge Enable pin. Battery charging is enabled when
REG01[5:4] = 01 and CE pin = Low. CE pin must be pulled high or low.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index 307c99c07721..2ea90e7f49b2 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -30,6 +30,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  ce-gpios:
+    description:
+      Active low Charge Enable pin. Battery charging is enabled when
+      REG01[5:4] = 01 and CE pin is Low. CE pin must be pulled high or low.
+    maxItems: 1
+
   usb-otg-vbus:
     $ref: /schemas/regulator/regulator.yaml#
     description: |
-- 
2.48.1


