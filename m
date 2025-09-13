Return-Path: <linux-kernel+bounces-815112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27426B55FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823B81C85612
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42912E8DF1;
	Sat, 13 Sep 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lzeFdCuD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0622EAB73
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755639; cv=none; b=tOBUtTzo9sTzb6ncrrJVBDMhpzJItG+rns9mn5Su+6YLMcFLvnO8kn5DtESxME4eZNkZ3c6mr4lMWl+ecew0RuNd3caqDf6XCrJ0WNM4+T/xTK39uFJ2mGZRZ4NFZIZ2+8/8O58spgO7/AMUSy7sdh7rKY19nFsKR3nAgvqoP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755639; c=relaxed/simple;
	bh=yrpiAloBhI4p4ZhNenjc/ytnMmXyltlftqvFi3+CYcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+s1HceWExdcFz0xhiR9cXCBOxIeP0i9LnQruQbAnGfQv8iRZGVm2IPQpJC3erwmtmd0mwAJvtmU7GWWPBDdxj3GDrmGrGynBR+oQwhjqOV3kQo1F52sjVa0LFIYCZphUgnIKE8d55XhdCXDUbnquGmo05vkBS7j1KuxkuSqbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lzeFdCuD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f1987d493so220730a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757755635; x=1758360435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN4beYZHw/m6widRTHsuro02Y0QudB0qsvA1rFXjFHs=;
        b=lzeFdCuDsgEbKjIVR98zhARXXwYK/iplkNXgoRMed4pemjP2Gh04mmEdpMgHxlR1Jp
         A4uKxckus2VcJ+iwaqOMNv3/37VWQ9GrooWr2q8ijihdM+ar8kI6rrsdrkdsM55B2014
         aoHvkos6C8PT21/tx1O/d/8TJcNOI+CaqltLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757755635; x=1758360435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN4beYZHw/m6widRTHsuro02Y0QudB0qsvA1rFXjFHs=;
        b=JhTvp9uXtsbLb09+3veqtK+nBIvBubmHvorlm8KD3eAEaUnhRg0SB7mQSITkCmF79Q
         e9C7FSTCe++kR3K/sro8NT3RsN/vCq6kKZHJCNuC3eSa8STtBhod0pTuEuVHYfyHb9y/
         HbYpJPCa7oxKOjCgNHOIpnSjO+0QXWTrSGuRJ4tfmawrnfw9VT+XUhFTT6+4QeslMSNN
         P+CPsTjRWzejcf6fDWkBSNPTK2l9jrVUFByvSfkLc5kfn2SINx9Yp8xVsjX5S/KfvAYA
         B+A4Ifsepng6mV2xyaQnV2E6nc5nXIxroybbZDsMWd+nBmaGcnRA1cLsXaLTqLum6N0r
         gwfQ==
X-Gm-Message-State: AOJu0YzGSAvCxDQUuSMCQ0SstHdKCY/mYzp/0q+jeYo2pcwcy+l6Sw2M
	i9TqJa12ndmxvlA4f4zmadfcdsJq8AXPoNDxDZpixsX50kLeeXKCqy5AU7e55kLuQsGwN1ADEuB
	vlqe8
X-Gm-Gg: ASbGncto6+ts6I84lfmLOYU/pUycl+9w24OZY5f8MRm1gwEFMujD15yVpdgct1iWB2l
	HEHce5OplO7GxA4JyNvjtdREc/BEnGd3E4YNU9IOw7KkIuhk8tVL2eiYTe9jP6xLoqNmIPzKEra
	xc6cbKxspgUt+LIyT8RMxh/emaQ2ZKhfYI7u0h2fez2xD94ZfOvFCqiVBRYJybW9IZh145/vUGg
	X3GAtor6mOgnMsM+R2EXUSS6RX1nJZ+njTDUgXK0tj8Aald1SJPfvcQBod6cAelDkHqvmL1V+a9
	f53uJCweCmJx0pqH9WQuVPOouj/FYIN90zTlRnMA9TObBOfnAhXLDt8trzHHQRLStFjcZ3j3xpK
	EUeVNHXd505473/WikhiCyagQ0hxgs9HTlQhlZ2JNNTH6RbNq6oU2C4eRX8jeEUn68qMUkBozpU
	r1VQ6HifF53hZAiCwKzxSZJ2gPGbVjOpxCOBQ6nulXbzjH4ivikuwnS4/qLCCVDfmpuQA5bEsB4
	p0=
X-Google-Smtp-Source: AGHT+IHv7bNkL/Bm3DVHJJzKvLokKqToRNVyhlC2S70s85D3t3Bilce6lDaE7bZNFEYk4zHC7lh/yg==
X-Received: by 2002:a17:907:2d2c:b0:b07:9c13:153e with SMTP id a640c23a62f3a-b07c353e3f8mr586848266b.2.1757755635504;
        Sat, 13 Sep 2025 02:27:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b33478besm551705766b.99.2025.09.13.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:27:15 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 5/5] dt-bindings: touchscreen: remove touchscreen.txt
Date: Sat, 13 Sep 2025 11:26:55 +0200
Message-ID: <20250913092707.1005616-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250913092707.1005616-1-dario.binacchi@amarulasolutions.com>
References: <20250913092707.1005616-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 1d6204e2f51f ("dt-bindings: touchscreen: Add touchscreen
schema") touchscreen.txt is no longer needed, and since no other file
refers to it, it can be safely removed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>

---

Changes in v2:
- Update the commit message
- Add Acked-by tag of Rob Herring
- Add patches:
  - 1/5 dt-bindings: touchscreen: convert bu21013 bindings to json schema
  - 2/5 dt-bindings: touchscreen: convert eeti bindings to json schema
  - 3/5 dt-bindings: touchscreen: convert raspberrypi,firmware-ts bindings
    to json schema
  - 4/5 dt-bindings: touchscreen: convert zet6223 bindings to json schema

 .../devicetree/bindings/input/touchscreen/touchscreen.txt        | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
deleted file mode 100644
index e1adb902d503..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ /dev/null
@@ -1 +0,0 @@
-See touchscreen.yaml
-- 
2.43.0

base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
branch: drop-touchscreen.txt

