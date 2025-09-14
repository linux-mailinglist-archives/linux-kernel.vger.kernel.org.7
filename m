Return-Path: <linux-kernel+bounces-815541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF06B567EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C91F1890EB8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12125A357;
	Sun, 14 Sep 2025 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1jkpTdU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8024E01D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757849392; cv=none; b=kECKMYp7BhqMgmx+gala08dmPlqhGgkQzZCI5J19GS/B7nZTycvgql2jYnwm7W6IxAJkAsWtufVl5nuyKVnp89uexI5TQXXCyK6dIAFEpNBRM++9aOn+wlnQiC2bU9JatH2MU72IwONtWqj7HwfZ8RFqbiQdH3oowx99v68UASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757849392; c=relaxed/simple;
	bh=S4TZwGLBK6/RB3hgr9c0AxbOfgqQiu+TmlFevlAFLfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw21rzAVR5P/G2BLPZeUPvdR9RCB1NHF1XdtdDwDSaJqA4BkdJiJPPV0pBhD9RJYhOo3OKEROk+UF/PHGl+s8EVICV8D0RUJ5o4JlD3AHcX0YIt1KbbnZzB1NPpFX4rxsmgEkZVCUjkVfjweuRvcq+UNGRSDox0Sykz9x5l76MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1jkpTdU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1541202f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757849389; x=1758454189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA6BwGFWueG+QJIiZVBMUSc9d4T3IHUstOE/1clnUIw=;
        b=L1jkpTdUunUksFJrSotZiAdDM33TF0D7UsEQkdbbgtXoyrX1XM3EZ9i6yT+C1FEnv9
         ASOOKcP3KMCBjzBvudhHmbAuAnNn79XJ1uNryxn1+oYyx3hz3AlV2fGgvea+EFKHoRGQ
         UI3uqt47rzxp8INB5hJyoWHFYyhSuO3aRZ0o9yxigEloYs8KEVWr9AkNADTR/KHQTehL
         M/HX/rFm0203X9xAoHOqBOBUGLqB0A92zep52OCwcXrYckwvpjytC7eK1+vwa1jRul1Y
         HA+I1/nSBvQRIHlApGM26XoTsXS9L7KjMzAm0a663z7iMCt9UZyYPY9Izhi/NWA6YoB9
         +jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757849389; x=1758454189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA6BwGFWueG+QJIiZVBMUSc9d4T3IHUstOE/1clnUIw=;
        b=AHtYhpKMHSAicedSZZ0EdiIETYQNh9sp8v0Bjd4sbWNgA88mv1BGNXkCAYVua6rqpl
         t3SsWYq2N0Y6CjOVLgUH081ABLjfMSJ+S+MHedgk3PDn2sdCdMLGojgk30FxAl2vrYFN
         LIGGIKaU7fBTsT6l6mxGINqPtOMXhh4QMJZkj5NiZOOgOPqXDZOiIRFFkelj16HhHHaE
         JhRopDS9N3eDkJwjGHI5qxYbbOFbHAXyzPFMUghihastGEH56612nwK+j0xskD2xBw17
         KyJESJWR+LXQe8/CYQP5LSyIt5Ns+cPGv6VFq7VFwgx6hOMqDuB4JSC5hgXjCdBizk1j
         Wwog==
X-Forwarded-Encrypted: i=1; AJvYcCVsKnZ1O6nXDArFTJGRKJbleR5mpHLAQ+LwbIQCQJZiis1H1spAivmF6tHR5gUrYk/pr7QJnq60Dc2ZTgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLecilE4AR1X/9wWK4JK/vcKY5uoo+z/Edrgc0y/7jh8uGaVnx
	dW+opWFfEtlJzdnGJ7dWtNYw7PtEjTFI0wHeIuOlXSRIxs6yDYkTlFzq
X-Gm-Gg: ASbGnctf7cER/l7td1m7CxOsz29yVSgHG9/yPs6IJecJ/0FtzGlEa3qsWTeLipw+D20
	a+a4Cw57O7vPM/X1ORmb5fKYZ3S9BfjSmlZq0JkY/DFWoOeSPjnbMzy33HdMxAtAYEBFbeDELoO
	tgj0lHb0ZlBG+QvKEFNoIObW8JAdcZCGGvFOdcBpJ2e2iF7s9XhHv9vs9KvSb9refkCBxTW+Azv
	5AEgpFpAUggdKo70Jshm/gJ6Lj35Bo5pdm0QtjWw2tujDFUufBTgqP4XH5iddngQepGmKbEPBC9
	ncNuQwNvTlHbmAQ+l9z+oSXWJn+6wutUvpNFWywb8TIDEe16iPpOcYHJrJ+SfATtOpJnop4Frhd
	iPM23ATW9aVoZhMfxqPqfAlZJxrU1MMpUPkOK4ImA71isYaQd/Z833gxVTL+vEmxii4Zhn0liGA
	==
X-Google-Smtp-Source: AGHT+IGyHDRZhIKdaCEmBZILWIecKug4YvVS1K+HM/kKk2Om/qzHCs838upA5zAOAAg9via+3MJt1A==
X-Received: by 2002:a05:6000:25c3:b0:3cb:3490:6ba5 with SMTP id ffacd0b85a97d-3e765594a4emr6092807f8f.9.1757849388568;
        Sun, 14 Sep 2025 04:29:48 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8346defd3sm6591268f8f.1.2025.09.14.04.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:29:48 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: hwinfo: samsung,exynos-chipid: add exynos8890-chipid compatible
Date: Sun, 14 Sep 2025 14:29:41 +0300
Message-ID: <20250914112942.2604194-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914112942.2604194-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914112942.2604194-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the samsung,exynos8890-chipid compatible. The registers are
entirely compatible with "samsung,exynos4210-chipid".

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
index 383020450..30162e55a 100644
--- a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
@@ -20,6 +20,7 @@ properties:
               - samsung,exynos5433-chipid
               - samsung,exynos7-chipid
               - samsung,exynos7870-chipid
+              - samsung,exynos8890-chipid
           - const: samsung,exynos4210-chipid
       - items:
           - enum:
-- 
2.43.0


