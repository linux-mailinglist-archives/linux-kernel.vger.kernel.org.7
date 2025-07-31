Return-Path: <linux-kernel+bounces-752640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA7B17894
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D234D7B6585
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C826E6ED;
	Thu, 31 Jul 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEnhdNz1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70701267732;
	Thu, 31 Jul 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999003; cv=none; b=mAqyODST/HvQndNEhLOcOmgg2kgyx7JO9hXJRHBnB//wIbT5bGUTVc9Qvd4oyXisnBuwegSgWIEuolOq6m/inrHqFiv78DlIlxqbiX8hcPuXDPPu0A2T8DidKMubaOzGHCjevJSjj7sxO7PuXt905ZSpjobvmK/fthL2c05rFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999003; c=relaxed/simple;
	bh=tcc6dN9pryCviFdYS8kqyFOsLSubqiCbyx2al6cwOPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvkO9gehig7R/K1ZXUSCwrlCKRV5T9bfaY/OUJXGq74eu4FdfYrFTTL2UZv7w2aNcONAsGalPKN9YVyzUz2fIYL+Y/xzi3iycab+mSoFMGfT1W7oj+ljdhecpcDMlAx2dEu+vsQb6/o6rVPReBPBmSuLm4lgTxXgqvZEq4cjBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEnhdNz1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b79bddd604so692709f8f.0;
        Thu, 31 Jul 2025 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999000; x=1754603800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaU8Mr1UR0mq2VfC3Szstcef7WFJ3UI069OoWTPISF0=;
        b=LEnhdNz1/fNoz2Qmr7G8GRl7q8qJOS3l99TEKtb858CjGAcwZez/5c5Emrb7OUzc6L
         u6XCXXSvsM695f5inoxygoFjZiXcvIPrtYrgGH42EDedNx0nhw3XMfK7ZrVfkhFFUeaE
         nQIZmQPdZMas93BZUYyrGjv0qj+SU/46WlRHEHgyjrUtiJWbDaCR8XhNCZmowFMa0Odd
         Gr/w8QaGo/45SPk5Z3RCbKVUNEXjZBdpEPsWcFaXpSoB8XnpfMppu5Nex2dvV5AIol7H
         gXGxv3SB502pA/aJszbomR3s1M85/5/jUOWJ5MvaUGbqmgAJBJFzBXcww8nfZPyXA0Kl
         mQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999000; x=1754603800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaU8Mr1UR0mq2VfC3Szstcef7WFJ3UI069OoWTPISF0=;
        b=XbOPyUnpkWuPbbTkJisf1B1TreXVmO45FIDcx+TKckX7xt7wLJuVD8N28PwP/Iu9lo
         YZbtq3n3A4QZ5yYFgKUqlLzoN074Aot5CkcuepJ7pfYl3Llv8I866lSeCAd2+twhPcll
         G/b39R0u8Xh3a22lBAZPhxlrygAr2vq7iZjjzIxDTAtgkyu8CYP20zPfxXBszbuGpUt8
         xIEBm+XCA6Y0v+AL8flaxdhLAMc6drZZcYnoiL7H75zwhfR++JncWNGaLaiBvQRTYN2o
         Uc6uFcWjawzzuvVB/l5n04H7Sjwl3lBbbK9PZR1bTL6iJm0fgcNo+RQFeH6+CsSUxoRU
         AsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZRlcIomietvU/9dkbh6olc/wmqzVEGLeU6lMlDoj6qXfM3gb94fyQnVOHUMW9aNIgRj+HfaCNW1kiCOpn@vger.kernel.org, AJvYcCXDca21+9CeZoP71DokvImPVaLwrXeATEmtLs1hWVxUCNM8uwq6gWczKPGNREZWvXtWr9PXNiKOlM1i@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaH9s4/X0QZCPX3h2VEo+eIIboncD3w8n9dtoV2MmQo08wDvE
	Bdrh5FBCriVrQObZ6fkNMO2+Hcwe4N3w39JoWTBzvmVNRWYbYrw0vuY=
X-Gm-Gg: ASbGncukqrvaTiMm+blNlV3fCcYAxI38ZpCVCzVYVRpq0Ql7sMAaM4iHXLt8lw62H6J
	Sk34v4MVOcX3FwEkLhx3U+bs4xFCZGN3U94/xRtPffKB+h0qrC1CNXxheZkNonKjviyLLgO5ry9
	c5UE85vRGKzOF3PxgqBpjhMQbmeZ5YeWg+kkJd8lzaFW0WFu7t+Wevo6TAU76+dZGzjTNqkt/vv
	M9k1G6YQfGECzRSxRtnQsWNucjRS3syVUReNYmZA7ZvQocSEZIBugkQGPinvm3iuaUU5pF+4hgC
	/Nea3N0vYkl741/8HFYy7pm4LwsCXALLlJA0jlTX5JcXbZIQyAgt1MalP6tia716yjQG+cTrUjF
	2jTQ24Pe6tThVEkd+oALyn6IRYuGGIhHmqKshYz16
X-Google-Smtp-Source: AGHT+IEWRM0eQnY2E3e7z3gwrOAVP9wzgLtdNFzkY+6ZwWTgcY5DlQcLCnYF7CBwQ/f53uM33TIBWQ==
X-Received: by 2002:a05:6000:3101:b0:3b7:6804:9362 with SMTP id ffacd0b85a97d-3b794fd7b4dmr6256398f8f.26.1753998999649;
        Thu, 31 Jul 2025 14:56:39 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536abb1sm86622565e9.4.2025.07.31.14.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:56:39 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: samsung,atna40ct06: document ATNA40CT06
Date: Thu, 31 Jul 2025 23:55:09 +0200
Message-ID: <20250731215635.206702-3-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250731215635.206702-1-alex.vinarskis@gmail.com>
References: <20250731215635.206702-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Samsung ATNA40CT06 panel is a 14" AMOLED eDP panel. It is
similar to the ATNA33XC20 except that it is larger and has a
different resolution. It is found in some arm64 laptops, eg.
Asus Zenbook A14 UX3407QA.

Raw panel edid:

00 ff ff ff ff ff ff 00 4c 83 0d 42 00 00 00 00
00 22 01 04 b5 1e 13 78 02 0c f1 ae 52 3c b9 23
0c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
88 00 2e bd 10 00 00 1b 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
00 41 54 4e 41 34 30 43 54 30 36 2d 30 20 01 7d

70 20 79 02 00 20 00 0c 4c 83 00 0d 42 00 00 00
00 00 22 00 21 00 1d ca 0b 5e 07 80 07 b0 04 00
e1 fa 51 cb 13 b9 3d d2 0c 01 45 54 40 5e d0 60
18 10 23 78 26 00 09 07 06 03 00 00 00 50 00 00
22 00 14 8d 5a 02 85 7f 07 9f 00 2f 00 1f 00 af
04 23 00 07 00 07 00 81 00 0b e3 05 80 00 e6 06
05 01 74 60 02 2e 00 06 00 45 40 5e d0 60 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 b0 90

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index 5e2ce200025f..ccb574caed28 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -21,6 +21,8 @@ properties:
           - enum:
               # Samsung 13" 3K (2880×1920 pixels) eDP AMOLED panel
               - samsung,atna30dw01
+              # Samsung 14" FHD+ (1920x1200 pixels) eDP AMOLED panel
+              - samsung,atna40ct06
               # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
               - samsung,atna40cu11
               # Samsung 14" WQXGA+ (2880×1800 pixels) eDP AMOLED panel
-- 
2.48.1


