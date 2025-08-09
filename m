Return-Path: <linux-kernel+bounces-761166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9CDB1F52E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A26A189E783
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0C2BE7B8;
	Sat,  9 Aug 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUN1V1F9"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E721FF2E;
	Sat,  9 Aug 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752802; cv=none; b=iZ7mVlx4GIvU5nBjTsNe5mGrySGDO71Sdjp4Zg4hR5aef29B+fUcwSele74eRNI+iD7mD91FvC7Gdhan3CKn29t77KVsxJ4Kl5XfzkVxIEczAFoQzNxoh52tmYLy1W/eZrVzRAcPD7yj9BFgkeveZxLBUyaKkgkreyG0c8AeF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752802; c=relaxed/simple;
	bh=7o5pU4p99I6XEBPujE/xuqW5AFXdaGPuJPmbaPxwm/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gC51vLnH5MG8DbMDoS4gKaNOoTn3wsTZe3kYpT2L2X3D/nQameRtHaIIPVTKmIj/Am/njyQO4pYQGfuJGH2/xp7jZjFJB03Gny1Z3pboSIK6bsT6tcx3FlSgMqCDe5kjqtXfIbi6CaHtyHRULUVYIhp+6Fb1WbJFlbOOMWd36OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUN1V1F9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458baf449cbso29529725e9.0;
        Sat, 09 Aug 2025 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754752798; x=1755357598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOg4R1KuhdWp/38jFFNcKECI315gEQ8uWnT+lp4Ht0c=;
        b=FUN1V1F9tuTgwHqAEEhffKcoOUqBEHkR1M2f5OJ+/HQraOiVunM/QiDe1nOX0nnSiZ
         bT0ikfS40A5M2k4K32LjF9pe/22JnxnKoMvDLowcNbT4PpOgY0L7/GzHe24xsIHXUucf
         HJQ3pKx+zxOMUTkrW7wjVFBhW/vTU8sVY26lahNGjEjNQudEFqqBIbTgczksjw7sM/PE
         xvIbyYRKTwDKewy/D80YjqYmkvvK86xlHg+c8ztSQJQRvgl0E1PkfAKjVhg1cakv9aEO
         TqlsSEnXdGP49k5i66AQItarvSlTyakaHsuAIUYDghsPJ4Uw+y65ekov6/kkzP7te1nX
         xXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754752798; x=1755357598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOg4R1KuhdWp/38jFFNcKECI315gEQ8uWnT+lp4Ht0c=;
        b=SQIsYNM7O0RiNNC5d8YrTSU5xzXt1P8diXw90CR+1UnIEd8ZlXhHuRaH0m3PwM5W9s
         GXYsp13vYBeU9/81rKpR+D3RaUeCoXSFNyJrriEkVumnPhfA7wNvmkfLo4iMe9l+KDUi
         scO5FrRzDQbCY+IOPKD5B3RVbeQVIwE51ZsVhyot9HbtVOGxr8XWDuQxugfH81otbe6v
         tCaC1k1g2VloNDrIcFWHzu5ZyL0oURoMnjdRlRvkNJbUXkVdf4ZpWbEaCWqd7iYxCyCq
         ipJlRgNlD+SM0fSR9uUrHOP7bKeuo3hUUFLfcwprpkUEE20uWlnuYToaVT8SISdZi+TG
         slJg==
X-Forwarded-Encrypted: i=1; AJvYcCVXB3SkzMMrSVOU7Xnz5GvIXehxIMMRPnU2Fjpp+62RkUZcZ5GRXLe8/R8f8hjwji7cWY+P+bkfRGv9ToFB@vger.kernel.org, AJvYcCWFEBe09Kol3sh0LyKa0ROG14bmjVDrGsM4qGhO+z9B66gpS6pvlqu9T1+V8y1eY1PTZkC1dAq2fFKb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WbMFfFzD+P4pcrNyTBm12747GaqKJdLlRV9CcUOsh1FGN6wn
	pmwUhr+QNJ1PKKDVXsI4ws6auXwuSlmOcrYy+OThsHW2TPeMfvP5+3rDJ7mivuR+hQ==
X-Gm-Gg: ASbGnctAuNQgo1qjFtK6PYNs3ePcMXwn5OBfOnnZX9Z6+IeoQj8AuKNKfwC4HY5Gxeb
	Xjh/Ob2MMmEiE+th9tomVdvZMG0vJslhTnXQCUHzZBQIHVKID/0txx6Jczhwwv4TYMIGyR5bGaI
	rtLs9SjqWpxz6e0OJSNOWJyEssOMD2wUFJG0hFvGbGcvMNNCnHAlC9iDVtK+P0swqyUTEj92+7l
	UHeCzow1x1tL7DwITpX4whUu4fT8ZMcEY+0txRI6flfCQn0esTW3Gh28d41H3gLwskQneQAuRD7
	wt1LaYWraBiUJYEPp38hY8UslKsQnMDHZkzmPoLTlES3h2UkpQK0215+7h/QXQ7yrHY7MgfoITl
	37lQ+XJGnrqPzJVqBOPiZOjsTiiJS7SF5Bx5GnyhjLlkbLqQ=
X-Google-Smtp-Source: AGHT+IES1jq2fM3tWveTYs/QIRtGgCWAkhN+VqAfVsu2aXmV4iWoNr2OTsJp+aEKViqy9CHWvPgJyg==
X-Received: by 2002:a05:600c:1c0e:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-459f4f3cf52mr55505305e9.6.1754752798364;
        Sat, 09 Aug 2025 08:19:58 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:156f:b6b0:b8c7:9296:47d7:b0cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583ff76sm178748185e9.5.2025.08.09.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 08:19:57 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	drake@endlessm.com,
	katsuhiro@katsuster.net,
	matteomartelli3@gmail.com,
	zhoubinbin@loongson.cn,
	KCHSU0@nuvoton.com,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH 1/3] ASoC: dt-bindings: everest,es8316: Document routing strings
Date: Sat,  9 Aug 2025 17:18:51 +0200
Message-Id: <20250809151853.47562-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
References: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The es8316 driver defines several DAPM widget names that are used for
audio routing in the device tree. However, these strings are not
documented in the binding file.

This forces developers to read the C source to discover the valid
names, which can be inefficient and error-prone.

Add a list of the input and output widget names to the binding's
description to make it self-contained and improve the user
experience for board bring-up.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/sound/everest,es8316.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
index e4b2eb5fa..cd073dd0c 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8316.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
@@ -12,6 +12,20 @@ maintainers:
   - Matteo Martelli <matteomartelli3@gmail.com>
   - Binbin Zhou <zhoubinbin@loongson.cn>
 
+description: |
+  Everest ES8311, ES8316 and ES8323 audio CODECs
+
+  Valid routing names defined in the driver for this codec include:
+
+    Outputs:
+      * HPOL: Left Headphone Output
+      * HPOR: Right Headphone Output
+
+    Inputs:
+      * DMIC: Digital Microphone Input
+      * MIC1: Analog Microphone Input 1
+      * MIC2: Analog Microphone Input 2
+
 allOf:
   - $ref: dai-common.yaml#
 
-- 
2.39.5


