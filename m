Return-Path: <linux-kernel+bounces-837357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B2BAC1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD084826D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223392F658F;
	Tue, 30 Sep 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmQTL9pC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23142F5A29
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222019; cv=none; b=Xkm+QW2o9hQ4/Kx1SjZsxDmwATOR/NkTYrizYjnyXqqxVYFNetnFajmxHRaSUrK9dTyh6DdCCEzbx/7CApSN0RcMb+zDCytdMuYAdMQ8ffOG6riXC8R/Ga6MPExO3DSF3qllZKhY6VoC/A/mcc0QtZerB6KiZuv0WquS4I0kKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222019; c=relaxed/simple;
	bh=1ehExbLkMmNgsVXFhI/3vAuhpWWLmzmhuVgV7QDcaGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDPqVRfPhYRuzujQg54mVnGidOCjVS1HtGum3hicXIa7zwvVE1YJue7DAlzuA/1lu/SnjbfTAv5IptDedecyfdZX3XC0AyDUvmOghY3EVDWY56F6c3v7E1lrWxWPsHAsb17UfNnAx5TNIVhhHDoMYSm8vttt5i/gA7EI74inu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmQTL9pC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e47cca387so36852395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222016; x=1759826816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsYAjCVZTAgTbKUVHs9DAPmJO/mDOJAtaWrMK8+sbis=;
        b=dmQTL9pCbHHnJ6ezanJokkt4p7Xjuk8NPZvz3qU85ZVeRhNprRq59oi9izyIVMT2i8
         Pfz74DSzjGhG4ngzmUVHM1/sGT8GL4pD8c7FgG4JxsYDg93oRfBivz4nMGKZ+Uw9SbCE
         7ly2mRnhIqUIQgzn/2JcMavDOH3K1OCJLRTs+3UVOxkWnLfVybpWvZzDYwtIkFauO1OV
         3U5n8TeA2+GeiTTWvWWrk5zHfzd/AS1BAcdZoS0YilTuHU1YgypND/axQ471gyyNsB6t
         v+hcHaaakEZDV4oUH1FunaFNhA2JW4Pmx4KAh7KvMzMuCF27vcDQ9nokh0ednfIlsHQk
         UoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222016; x=1759826816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsYAjCVZTAgTbKUVHs9DAPmJO/mDOJAtaWrMK8+sbis=;
        b=Y4EuqHTUNDEfxaJ2CdnTmcdxC7gk1Vj4mdIMNDqmA3Yi+LRdeYiH0VkoYpr8o4CqD7
         uXnW1T/Y7fkpOmJL+u8CT6IFwTCZ5IuqfS1rZ36L4R3jhjNxDiCnSPj8wsrcy+tZvXK8
         AR1HZW7ssBXqnr3jNHYmZQdlRFDbFZxTjzokyL2VriaCqj0kEaYES3ali3VN+LY6tFDt
         zhRT8IlQyx9Y4sR+BOYlD42xKq7KZxfC0mTbp8Gb/Fe3Wr+WzpjqeweSjDASBh1D4flq
         9l6Wi0Zg1aa5eti8eBAmwVlIcOK5zJmu0ArEcwp6NBadnuy1r4Bg3liVp7E8VPZ1Qpa8
         OdiQ==
X-Gm-Message-State: AOJu0YzAAc1KrSsbyJfRB3wPsWgYMD5I6htebr3f8Gw6zWd0dKPOfHS5
	MpMfQvTPRtcg6b9A00s6dVlMfIUVvuPrHKSLSYje/3QX2lFK00IvwGqX
X-Gm-Gg: ASbGncvGGALewU9CgC+xhhGyMG6+zIPqC9zFyui331bJ8S0lu5VgtZYPsfruJk45/6n
	ASATzEZNqyFgo5PoiIR7y0bfeWd1yluGZlt2Cfg6XMyPobpgnrUDj1oKd8USXXTSqqO+wRzHgrF
	sJi6yNuIqrA5WLW45OWdkZShdPJGoMnpELKfS0nJa0CN4CIxhUg9mMQH36+MtazhzImN28PB7so
	r/Ko+OZ1WmcIqt76Y2JZR8GOvdsN/TJLfmqWOyyFEmY/a8BIIZ7J/IwEy0+5bpWaWx2wFANYSAI
	b4rdH8a8xWgQhD92drjJoFXMvwDlC5fheUiCb01BTtyWkEGMx+WUsrubGrS9CUP5UzoY01s53v3
	ttUxSE/hopJ5L4BNnxaCHBzZcSpERFpZU7VlEw8lOEsUcOC6Yh19XR16McWWQNgfx1E0y0y1Exb
	S6ofbRcleNfJpxcXdzGMq2ZCSR2LIu8mnqovBWSI/T4Dqc/AK7WhQ=
X-Google-Smtp-Source: AGHT+IGVQJJHamU6NUy4goartpYaIkfUJZ0iBlzOkN6u19q5qmKKBnwS/nG0zfk91bdRAJZUfDhusw==
X-Received: by 2002:a05:600c:1d16:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46e3292fea3mr191174625e9.0.1759222016056;
        Tue, 30 Sep 2025 01:46:56 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f536a3sm54098975e9.8.2025.09.30.01.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:55 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 30 Sep 2025 10:46:47 +0200
Subject: [PATCH v8 4/7] dt-binding: memory: add DDR4 channel compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-b4-ddr-bindings-v8-4-fe4d8c015a50@gmail.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
In-Reply-To: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add in the memory channel binding the DDR4 compatible to support DDR4
memory channel.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 9892da520fe4..866af40b654d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -19,6 +19,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - jedec,ddr4-channel
       - jedec,lpddr2-channel
       - jedec,lpddr3-channel
       - jedec,lpddr4-channel
@@ -61,6 +62,15 @@ patternProperties:
       - reg
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: jedec,ddr4-channel
+    then:
+      patternProperties:
+        "^rank@[0-9]+$":
+          $ref: /schemas/memory-controllers/ddr/jedec,ddr4.yaml#
   - if:
       properties:
         compatible:

-- 
2.43.0


