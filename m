Return-Path: <linux-kernel+bounces-836391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD6BA98FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055561C2E54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701BE30B511;
	Mon, 29 Sep 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtMI5uC6"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9D30BBB0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155927; cv=none; b=Dlop+dMvcpKPMiwa27DgD9SeKWf6isS8zWP6LyZTKgQwEpCNlMnRm59r7zBXihydT03Laz4r3ZeTeuwUJfwCQcuvysK6ABKGAschcp/lQjlPEKwb1i3bxOhYTY5GpibimeD4XRP59Ir8LkEcCrXoHw1jdK43Ct5BnnpVSNgXWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155927; c=relaxed/simple;
	bh=kebRgWgjU4+QFooisivlKuz8gUSdZe1BvseOgEZtkVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHErfD6bW54aAMZb7na+dowfbXrQCs1L7oXXsypqUzO/R57SMgiVgYUkc2NGadnGXLyLa2JEDTZSVUMGQKmALJdbtZ08Iy1IzCeWN4bL+C9VJ3M5YWureDnLuuL1HYHHMTYzCyMvuz2DD9Y/Uj0zxlYEG8V5s2yN7HbLqpURJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtMI5uC6; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36295d53a10so41820361fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155924; x=1759760724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh9DAofb5pc+fYQ7Puuw943vV9lmOx/AYaxuS09pAW8=;
        b=WtMI5uC6qCIVL+3o2yjaN6GakQS4dQ3ghYq8AoaubFoji8dLbIpE8VDiyg+FQErxwj
         rzKjiSrQkBkD3dlT9FoQASO3jYm4mKIR6ip+XqpuWbz1iSV9ZxKPdTEYPPNieLkpj3Zo
         pRg9UfsfHdGbPQEmaXuv7fet7SM87LTDGlMD3SbuDXXwz8h2BcENnPVAyFRvH41JDsnu
         5YaJy2PEMhL/ooWI9OjlKNejiSnB9uV1CrRXAfvTK7/3Pi0FwHLilpjeNkcJWfEm96S5
         qHU5ManElj/irIG+7Pi9FcFA16Uel9aWRW0k8BpytK2a5mCw9B42LAXZ4/2X6Ud3lfed
         wHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155924; x=1759760724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh9DAofb5pc+fYQ7Puuw943vV9lmOx/AYaxuS09pAW8=;
        b=SU3olGkAyw1hAfqZW9cC6BZmCxRhXrfsqmsHXVul8mOq9VPNMp3QUH/lmiaB6y/vxM
         jxZe9/OFnFUQPh+ezXHyRDPMCj3VdvIRrXdskla5OuWEgWUoEChOgw1gbnxADrNkxyDY
         hJoANCIYL519kZbs42Bs2uKdN+Zg3IyjE9oF38uWkLyThMrhgEfscNuSyd4V7EjYduY6
         n5x/fpuI+kFIOMSic4w2j10meM3P/EDJAyF61Qe6zkh/98wH5uyaXGQfYydM7jQaxMAH
         TJarsm9gH/DIfqWeB1hsM2iLoGWENxmStpPOJvyTfjnYsJKzkDQAdjIn1OkdHU/Il0VU
         w05g==
X-Forwarded-Encrypted: i=1; AJvYcCXRHB4+JSvMQ/wb9snqcpI5gXsEgSHyy0jmiTqZHzFa9KFw+AO0VFMUnTqhh7CxEd0qwntua8bKG/FhVig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFkhfHtun5i6/Hdyv2Rhee5CZS9KON+qjGUFCKvEyBVwpYrES
	AOdWHh/U3iXdta8xKbK6vxWgzBknB7T9qw84/K8c8AAzxpWiB6wPkM0e
X-Gm-Gg: ASbGncveUe4OwWaMhGuzdl+S06kO+tqOo1Fo/Fqr4JrqtLPTfGBIhyJdGALwi3U2K3u
	u1WU62rVmy+7YxowwxqWgoso6kxyGxHrhngvU+bNcN8bNX3N8w5RI2FYMcuje500qjTLrWFiI3D
	HyX/wGg9kKF2odJFJTa/uNt2MkwvqkKLUiHnvlzQpwvb9yA9PXic5g4atJeuXrc0qAqZlTPxSI9
	BcXm62Gn4Ctt9fCE/O+Cfj1K92HLIiX/paUchw9uuFAVhLl7xw7AZS5hSLeyBnfhvWjHo+yd9j8
	580/wQMiQjaYj0jxKt3Pc1kvJvJl7MwaWEFaAOXASN/53tJ7Z/PRDRjIfCnAAFEmO9d4Dp04+gx
	YcocVvjjONLk9Fw==
X-Google-Smtp-Source: AGHT+IHN0V6Vi0aPAu1d9d5AS3VfCD+ATABqrtHWzbt7i5cNrr6oVnwEDNT3Dh/t9jYOyViBE3w5uQ==
X-Received: by 2002:a2e:be15:0:b0:36a:6540:3ba3 with SMTP id 38308e7fff4ca-36f7f932d9amr49253481fa.39.1759155923254;
        Mon, 29 Sep 2025 07:25:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3728c23e6c1sm13201001fa.52.2025.09.29.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:25:22 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
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
Subject: [PATCH v1 4/8] dt-bindings: display: panel: document Samsung LTL106AL01 simple panel
Date: Mon, 29 Sep 2025 17:24:50 +0300
Message-ID: <20250929142455.24883-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929142455.24883-1-clamor95@gmail.com>
References: <20250929142455.24883-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Samsung LTL106AL01 simple LVDS panel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5542c9229d54..93ddb3823d3d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -268,6 +268,8 @@ properties:
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


