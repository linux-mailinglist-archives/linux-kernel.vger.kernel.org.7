Return-Path: <linux-kernel+bounces-849987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29216BD18CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABECE3B5387
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC92E2DCB;
	Mon, 13 Oct 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1rBkwCX"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D32E0412
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334980; cv=none; b=L0I0pQ2PHejHKSc6fy6W25gnwJ4W+DwMFac9OGKNGBRkfdw3px/52O5T54tYs+HWhI1TgBhbNGsYSsGeEEQTpFvkCS4A28hm158E4hEH+RDK6u08gbteaViSxzVNcIpRAJMvweRkh9NJL3UG5lF1EiFP09Pf9JIXzpGoRmUgvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334980; c=relaxed/simple;
	bh=Ubq1KrUSxqn44bDKjL0Tglob05w52CADvwCDYj5e0/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdExLeITA2ABJgBNs8VI0Eewpxr/gyZ9JRNo81mMAaJNz4gS7WwvHBo9TozdyhNR/W8oNMqqRtw3U7rwTwEje8qJwB9Qr02nl8UZ46j35SmUD4L6HpeRANlSWjaMg5YKa4gkuNsbzwU5+899P2WDqj7/67J2yWDeCUrSR4dILuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1rBkwCX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b40f11a1027so684079966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334977; x=1760939777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NlbLfnaH1AYI1Kzf2XAYKDUFV4VkFnG/ReSb+d8FKY=;
        b=k1rBkwCXeLXShaqNl2H07favUJB0Bs9fucWoCkMS33As1pi6vmwWoYfQbHDAkqKANC
         nFF6cm9LlXHiNp5w285FUleo7hIsgE5E1znq8ufhzLmdHAZfSVQALm2HsfTt0GK2GkcP
         vDnrfWscc0BugoOPmEdsJAY9ZUK6Kk+pNlsQom5Q9mE7DrBLip0O4h4SauLFfOdDl6hy
         R5MKqyA56BfSukOz9vZ231YqHiJKjFmbPqpl//1HSxOmoCTPkx6hPIGxij3dRMpQ08iW
         SILM/ptCjp42NIpIXPTFCTiEOGKHJTAoaErh2W3BBz+QTebXkGFFTV9V5aLfwDCkKveH
         ZahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334977; x=1760939777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NlbLfnaH1AYI1Kzf2XAYKDUFV4VkFnG/ReSb+d8FKY=;
        b=Nh85j5nOT83f47vZFOhWbbY9X/HuLYQjXUBRioiaIDV/82SY8x6kBhJ/29CJBcn4KV
         hfqGBHGTw36sxxD66zqZnvq9qcu1ObHrBpK8X7bv/Snvc0xx5pUzbfYGAhWi+9rYXa8n
         JTkh4mH0WvxtHrc86mWkCxxfEw2PGX/c3gaJKdoSmjOjtYwKp2OPfISJyui7ip0K3vcY
         CGNzwIDl8LmnrGWqmAQMDbwwMLvPmSGFmJi3xJMARx982aSbd+zsWb8W890zMn8TYDCd
         utC6ktJZ0SOOdANJMiH7P1EoP+JTVWZE9M0iquoXK5hnQHcmjHnNhFxbtuFKCjrkNW5B
         1lUg==
X-Forwarded-Encrypted: i=1; AJvYcCX01DTshJ7w+YA+hN5sovbNhUvxQ3bap1mtFB4OTkmKhPmDtwvtq5FCPPYi0orG4HLoY2cUdjVwWM6E59g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvCP4XDwV9Y0/B4EimSRyMAZOxiCtcE0QfO1SgOkVwNW2fehy
	0gYySMiFiNvHDgwA4PA6ZHLAya9R3I0CooRpMO4HTDHR6y5K9PLryeNV
X-Gm-Gg: ASbGncttcu9n0Jh9xIKsiX14ShyiWTve8Vv+qDu7aFuEi90x4m2UWwlCdRk96iwWrOA
	iEqH+gN+Qp1f5WAIpN3hoSs/jeAd6L+g4R5HrQwcP2ugVKV/fjd79EXzMxjR1uFqrFAgw2rqY6I
	AYi87lKKsAQ45vUHGgGWxBNm7qjpPD1gA1Y4qyI+LhP/uqLzRgu0rsCwOiHFxh6ATahG82ktjh+
	XVG0mhkrLhxpGF0+MuTTCBuCDFwCGT8LAEqXWIpsOawSNn9dN8O52lmC7tFnUp+sTugGxQCM2Zm
	D+h9KgyHhugyq56LIJDXVZwMTlN1AdEzfmo8uSDvWncasPD8TB9G9jQXyA1DmXvqtqiIi/3QJ5u
	pEnLPqZTRg9zYp7bgc2hK0V+sovi2uwHfjxCeqjs2YgmxzfFoWXZVvw==
X-Google-Smtp-Source: AGHT+IEgUNiVYk1c/l0uwnmFrssSP9QtQ4ZPHREFA23q3yikEOY1+LgSDt2qIqexeuWomC/l9La4Fg==
X-Received: by 2002:a17:907:94c3:b0:b40:664c:3317 with SMTP id a640c23a62f3a-b50ac4d69f9mr2061549266b.43.1760334977303;
        Sun, 12 Oct 2025 22:56:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm860912566b.23.2025.10.12.22.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:56:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 4/7] dt-bindings: display: panel: document Samsung LTL106AL01 simple panel
Date: Mon, 13 Oct 2025 08:55:39 +0300
Message-ID: <20251013055543.43185-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013055543.43185-1-clamor95@gmail.com>
References: <20251013055543.43185-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Samsung LTL106AL01 simple LVDS panel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 4a5ca013d0db..adb244460a09 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -274,6 +274,8 @@ properties:
       - rocktech,rk043fn48h
         # Samsung Electronics 10.1" WXGA (1280x800) TFT LCD panel
       - samsung,ltl101al01
+        # Samsung Electronics 10.6" FWXGA (1366x768) TFT LCD panel
+      - samsung,ltl106al01
         # Samsung Electronics 10.1" WSVGA TFT LCD panel
       - samsung,ltn101nt05
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
-- 
2.48.1


