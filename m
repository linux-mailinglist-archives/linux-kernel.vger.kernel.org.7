Return-Path: <linux-kernel+bounces-761558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84977B1FBC8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214D51895897
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C941FE451;
	Sun, 10 Aug 2025 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kc1B0KO3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08481F4631
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851974; cv=none; b=Y71Qq50vYwhjE36E1h6TX8kgHBduR23ba5yAB0yTTkAGk/CaZhjeKgu46B0nsv5nE8KortW9GKpFfTpPJ0oiPaxIxmDudAX0JR8yh18tJOHTW+WZxlO/RVKF5TZgz61uuQdQJGOiRTFDvhg67mARwDIqLWbn1haJfyjPuj2xeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851974; c=relaxed/simple;
	bh=tpem3ugXEXY+sza7Z065QDPEzGqVly+Nz2CDIYGjz8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYqwXroQrkSWZj6pBE6m/mrNr1k9J+moj2nzyPMFRUF0r5+lqDj8+aR+pu7LkumIoFkCa5JxECnG3t4JywkqnBmb0ivq5Sbu0By+bqizMG4IHVC/BjoTUWL3tqUxgeLjbBi07HpGsXUS+VBx5ccvwKAH7Jpv0jJh7oPtcy/wtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kc1B0KO3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso23324375e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754851971; x=1755456771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=Kc1B0KO3AIEMZr4RRS+X7Ql1Ru3LFBiWy6r6TCgsypIMi8DZUXFL2PKzhR1vNnbcim
         gufTGox9CgXY3VvQC+4ttQr/b6Jmp/8Xa47Ct4kI3lQHcd3wqCT/0rm2Ck98tIDYKm2L
         TQpz4p0T5dp4bIi44UFL6ta5Hbi38lit1PNjE30wBb/zXY8l491VrtivtcQge/glr9mt
         iCDBC5pGVB/zGteJsaZnzgxUIflG3Rgb7x9WZuT7DcwPP6fsp3jrOMwlSPlqfyUyOq/W
         PZ0xplf4e32ibBYMY3F0G2KjQrLLfeKSb6TIaachekGAk8o201YMo2Qg7C09LMWhG7DO
         trMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754851971; x=1755456771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=EC3gmhYs//RYxE3LupXeGsBcQqkJ/gAARjDnLiHvIahSyDalZdn3grj/PS3qtR+Ap+
         gy88yhlQW953R4X64gH6fg1KHeI1cfVHK5ItrZegrQQB7C912V1ZWM8xOVbIH4P4wGPe
         FnL9tirv6if/Q5DrEFciMbp2G4X64sKVNmte3kPWGk5JdyGyKTKXIWl3okPc5SfhiP0g
         MFUruapJyqZFaGFGrUysqz52hpQzfg3+O/ZiVarS8gQZXAqk/mNohv4Fql60I65yqNjt
         a5L8fJjKYPlXpYLWMpNN+u3aKdEKtJqENNOtx4isvmTbyWa9wpsrEBQNGuHmpQuUxnMv
         Z4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXkd1YWVtFPuPP0b14vYHikcvR7Zso/ihSwQwMBgf93+OVZDVnxSKnTRzCXFUYL7FDd/HCOINb9La4WAj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxBJQQjUYHIfGmq33Q35nBKQEZBmSgLXQLPFMwcUQcAZVjhNG
	qUUHy4CHKreHq5952jR6Pq438MZmKcC5jbBRH91HLPFrxlOZgzQ75aZrL95/xv953zWz76HxyJP
	6A6Yz
X-Gm-Gg: ASbGncuN/IWpFPESv7AQK+1PuDbJ03mQ1P4HMIfPIQvWMAx9FK3VffK3ZsMfnrDu4ue
	cZgF+O5pXmQQVNd3JovKDaPXZMqATWLa7EKU8nH9kSfxAeQqojdUE766rnlXYIEalcH6NE4nZsL
	6sNKa4MNA/NOS7vuez8kWIiXBuvXIso7rOqo0iWwH9qzTF2D7XvKPWlIuKT0OmtOOuiSGhPr2ae
	4Q2C2cXijHz18kl0zIvS5XHOE3Pv7gs4kihXooCP0WYScaARuHIc0OJOw1b73u1G2pAhGeJeSEb
	MFr2h4hKb0S5yHLwsa3abhjqxw0RuvqbJgVNHsjHuVSh9OrX2+J9WDAHfRe8EzpKu/+deX9Tnsw
	VKU3bOxcrquA5biOSBYOe1sLuYYGc/xr6FieQvrzTLfsODK44
X-Google-Smtp-Source: AGHT+IHPiH3KOLHizWDnjfL+XzIReIg2rRjQJ1/ssMocHQ1ajNiUB1BrXhh5VbtJAuaEQ8OJc/8s+A==
X-Received: by 2002:a05:600c:4fc5:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-459f4fafcccmr81128145e9.25.1754851971156;
        Sun, 10 Aug 2025 11:52:51 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm319461145e9.22.2025.08.10.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 11:52:50 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v1 1/2] dt: bindings: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3
Date: Sun, 10 Aug 2025 20:52:17 +0200
Message-ID: <20250810185221.2767567-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
References: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 have a FlexTimer (FTM) available which is the same
as the one found on the Vybrid Family and the i.MX8.

Add the compatibles in the bindings

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml    | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
index 7f9f72d95e7a..c7a10180208e 100644
--- a/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
@@ -26,9 +26,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,vf610-ftm-pwm
-      - fsl,imx8qm-ftm-pwm
+    oneOf:
+      - enum:
+          - fsl,vf610-ftm-pwm
+          - fsl,imx8qm-ftm-pwm
+          - nxp,s32g2-ftm-pwm
+      - items:
+          - const: nxp,s32g3-ftm-pwm
+          - const: nxp,s32g2-ftm-pwm
 
   reg:
     maxItems: 1
-- 
2.43.0


