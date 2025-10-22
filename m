Return-Path: <linux-kernel+bounces-865206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE7BFC936
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4090D6E3CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F334FF6D;
	Wed, 22 Oct 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN2k4WE0"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91D34DB7E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142908; cv=none; b=kgwuQWqQdeOKed7KeX7AFd/AyTktNuzgjuFfE3PBneu0XXTUAfGHvOZDQh0WDi9LZyLYrMMGuaZTw8OcmPA+9tTzkPKmdSDRImGjb+cuVRX3CsL5pS+N0CuYMi99DEMvphPJmpN8jl2TwsADqDR7zj0kN0+EXhtnOx77GA6rX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142908; c=relaxed/simple;
	bh=NPYq2prUDw6E4LwASXaQMdEqr6v2oIwItNqZJN/XQxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfQaY1Ho6c6A5fJdRRIaHfgSWwMfusM1Me2iYUI2ntFa7owrWpdfzzJyDco8pTWIDNIrwx+WzXjRqWAc4kI1XNzQoWqgzUgshPLyIh0RqZt3J9YWf4nD7wWpGmg8IhewKWFW5q1OZdCsjAp8JRewWomNq2sDLd0hXHcGK6EtoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN2k4WE0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so8897219f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142901; x=1761747701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgdj41tpB2VgIRDJrZCciZQ/xBBL1EcMgPyAyntTnpo=;
        b=dN2k4WE0ZY529zJSRBJ5ZwORqoW8KLeZSCDG6UUz7GYvoOwhMzgy1KeJ9j7hImNFYF
         6jgoUufnykUb7VrhHxH/ZbMkng2hRNLbLq1WXb94zmPgT7TBt1gYeZypt52aMSWdZn2A
         /nijUnNp08qxO3kNmhbsPtM1rZZ6YtRpStfEJITrlnFL7NeNBPcQxQrX09tmPKQOT2u/
         s+OHrFBQERBAlc/eA1zcXlLEhbwAo13Ju8WQ4DBjWVP6U7cE2wtMvU+GOUVJDwBNR3E7
         KyiRW5CeKo7CM6Ec+rKxfvq20nd6aTr6KFQO/Yy+9nbETsYnbb3kD+PZ/nQYEecAIMQC
         KA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142901; x=1761747701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgdj41tpB2VgIRDJrZCciZQ/xBBL1EcMgPyAyntTnpo=;
        b=gSV1PAhZzCHqar/kR0EvxJTN72TT8r62kVtrj+uSXSf/iJH8nLCXaWIkQzBBqbYhBs
         3fkHUkYZIRqdLZ51FgcmNEbkcdhz806VsqJBgtaGN+Z7JOKOmIxn6mWNWhg8oNO76seD
         f4RMNugwONtxpTjztFISjIVdkXOSBfGWozQ11LcJUkAvqGStTtlBJUWXqFucawyzo/5C
         EAxQBAG9r3P14yZrbRM6EKcdr7bomcYIWAWKJ53jzMQvrhMwFxv7e3LP1zFz5nM1Z2fH
         6rylMa/mdGkqOPLcuT/wy2zSxuwZS4dhnTRApNu5gobLuNJ7jjakKH2Vu/fOAaJbfusn
         5oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVThHWToxpGK4aBESKhSyQwZ0SrjtSwoUGive7Hkj6WYRNh4joMhcL+qhcU7dZo10Bc5UDAru4g2eD386k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTJwQUc9Eei5GRit7cv75feFqMKWqkVMGyZ3ownv/qTLiY+Kv
	VHpSFkJEuCE3HfLVn6v5XyK8hAGrqlY8kZrclmksTmOsJ2b7FnltFEBl
X-Gm-Gg: ASbGncugSwBNtVgli1ymzsXddXGLDkYdjh0K09bfCXJu+ZqcARsU5QhgxQwUDw9CjvT
	MKmxQ+CXO4eiZ/ADNX73GPOgI7dXqe6zYrOSFK5fsEd8wX/ztc9/6pDhCPKdyDtskZTilF1sSx8
	lbfm/18bH85V2FRe1I9hiIjYVcPlh+uAT1uDe5HqZ7bAbhVfoTcLFgAB/BmRiyrCrJvh9yUR91I
	nYPI3I391OJ0fIRWvp5RYMRmKxQZdGm6CTG9RSPw1wvft6DOB/QWqM/7yAjp80h5B7xENaz8jb1
	ggmpXddb/NnoI2g1YX8f5alsGOIZRABTBhG2gx6q597gni+1CV0+jGGckpbH7OJPQVgfqeuqUx+
	HXmwyp9D7IqUuWEjuR0HNEdNg4zMSqD32Fp7fFMI8Dc3IIMBt0rvd3Uu1mSPKoNuw+LcpABMABm
	PqdQ==
X-Google-Smtp-Source: AGHT+IHM03V7eJFt3Eu6ja1MYetjG461AcLXE4YT5HRjXzs799spnfwnfQrFSdx7t2nEB8DurbecfQ==
X-Received: by 2002:a05:6000:24c6:b0:427:928:787f with SMTP id ffacd0b85a97d-427092879c8mr10794030f8f.21.1761142901362;
        Wed, 22 Oct 2025 07:21:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5 10/23] dt-bindings: display: tegra: document Tegra132 MIPI calibration device
Date: Wed, 22 Oct 2025 17:20:38 +0300
Message-ID: <20251022142051.70400-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document MIPI calibration device found in Tegra132. This compatible
already exists in the Linux kernel, I have just documented it to satisfy
warnings.

Each Tegra SoC generation has unique set of registers which should be
configured. They all differ, hence fallback is not suitable here.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
index 193ddb105283..9a500f52f01d 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - nvidia,tegra114-mipi
       - nvidia,tegra124-mipi
+      - nvidia,tegra132-mipi
       - nvidia,tegra210-mipi
       - nvidia,tegra186-mipi
 
-- 
2.48.1


