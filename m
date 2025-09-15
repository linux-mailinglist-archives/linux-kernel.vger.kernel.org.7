Return-Path: <linux-kernel+bounces-817716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DB3B5859C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406B83B100D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A028C009;
	Mon, 15 Sep 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o1sYXDm4"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F528B51E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966039; cv=none; b=T+vjYHMYRLC7kowqKLJMJaE0B0IpSMJT6J5IRtYfWr3rBn/UIHncgPzm3cX4g/JN4sUEgkUT6DIIjw4Uo1zWGXb3tfpNmOsOjyFCuuCZuYA1LZin5TQQ+i3aGLw7HK+rp+3C5oUrGx1T5b/LmtomPt0Kh6KTUU8a0G60sZOAMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966039; c=relaxed/simple;
	bh=osi8lZqw36mnUV7ANOU6dNqrRojLcplRBpUBXvUliAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UY9ZAxOX19AuP2BZSKXfT5PC69FFF3DNcyV72jwfC5AvOLmUjE2+RPrh++VSTJvQFjBmbSoqyXpnmb/RZvK3Kr1yMI4L4WDZFwy3JRdwufs2S90k/ZloTf7sHWfdyu0TJFInARvkFN7t109lvHiZhOTE5o5ZR4SAXJvbgJQRuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=o1sYXDm4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3414754f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757966035; x=1758570835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmFa+COnAgPwES0uM9A7F5hfXb6EgxmAXNl0CdhTVj8=;
        b=o1sYXDm4EQHgeqE+sUlroS/wcNcfY3037sJ/QaR2P1jC/BwELsjryPsBoRhFa9CwJk
         9yaFLCuL+O3OdLTp8w9oqoCSOl1heBgVFDcivlnyq28Z0+V76YESjJoEnUPjlhUrFVC7
         pIZm5H2d9dWIKWkkZRAaFdJkvku4uWST5B6p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966035; x=1758570835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmFa+COnAgPwES0uM9A7F5hfXb6EgxmAXNl0CdhTVj8=;
        b=kUW3OAG0Zjuo5qFNddHXeG4JdK+ObqD7W07TumNEWVWYw5oNJdkiYFCQn7fUGbPLzL
         eD76XMe1EDDMc0YXZtulfqKo2JlM1fHllWOV9lsCvycagQiNX5VWPP5DaQgEibvHe/IQ
         1vTcMpXl42RLyxpOlPjVms1LmAtKd8lVDUV/VDuzo+ovDL1kAWXSQMwdijll7LuBJhoi
         /tOg+W0BW92qGnwwlFRNhUEkZ9twcQmWluZlQtRU55w4nj7FiDn82TVE1+P/HkGbTpWu
         mmyU//4kkc9+hNyy6i10mubno2v+7D2JcrBHl+8W9ma2NU898Gs+Nx9wVbJbrVT49Llz
         mMwQ==
X-Gm-Message-State: AOJu0YwBmpyPgBQu/EnyGDm6p27yaVP8RERfS9Aktlqej/VlshszQHX6
	MlqLj0RBDPgaAXCnlQfksbrIskHBbW5o16fsL6b2RCLoMq9SCbOntAeOepxp1qNrLDmh/8apPPj
	ZeiNS
X-Gm-Gg: ASbGncv/ZYB0dixEGmyU2XQ8aF0OjpiX55zfc/H4+Xje9qdNawJTuwiTokQ6481cAk0
	8RBMp2lYG5j8PTuHwkfA7ZTx9hqczFGyL0og/N5ZjprrgMycogQb7qFJ/iH9DPckQPAJRa6laTs
	xJlZhKW0BCRB/bW/J5os3RuyI/m2MKkL+U45pns+sgy4kdYnNHJCO5bUNBgdW5DdDHxop9g3g8t
	VFpr6xhnONKU2LX0B6qvHAfi23pfv19oVRMVZTNb/ZuanrqvSjiiDkdYlhnD9fFmRAe3jlLcKpZ
	uUw8QdDaDASr2bs32eiAOQopL8N2KkreIA7e0pyX6qTA/aWEQKcWOeUsLjj9Vk86x2ZimzUCDLW
	YYh9qNP9iwiR70sXAs3MUNtTeq5f4PaqtLhdBVv+Z+Y25iwIUvIIT6PAhvbQok3u6v10GuQjWSS
	gGTiaR1uzf
X-Google-Smtp-Source: AGHT+IHgPVqq/VbNUTCtXpuQZBf5oSQihvNkja9owWSYGdvunXVj22DIYhh2VXxExfJ6E1JEJCRPRw==
X-Received: by 2002:a5d:64c9:0:b0:3e9:3647:baf0 with SMTP id ffacd0b85a97d-3e93647f7a5mr6656144f8f.50.1757966035186;
        Mon, 15 Sep 2025 12:53:55 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32640f49sm530985e9.9.2025.09.15.12.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:53:54 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: touchscreen: add touchscreen-glitch-threshold-ns property
Date: Mon, 15 Sep 2025 21:53:05 +0200
Message-ID: <20250915195335.1710780-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
References: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for glitch threshold configuration. A detected signal is valid
only if it lasts longer than the set threshold; otherwise, it is regarded
as a glitch.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Added in v2.

 .../devicetree/bindings/input/touchscreen/touchscreen.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 3e3572aa483a..a60b4d08620d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -206,6 +206,10 @@ properties:
 
         unevaluatedProperties: false
 
+  touchscreen-glitch-threshold-ns:
+    description: Minimum duration in nanoseconds a signal must remain stable
+      to be considered valid.
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]
-- 
2.43.0


