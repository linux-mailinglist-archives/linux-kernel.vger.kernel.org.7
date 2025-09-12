Return-Path: <linux-kernel+bounces-813282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8FAB5431C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F60FAA171F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A22857FA;
	Fri, 12 Sep 2025 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAbFBBCE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246942750F2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659401; cv=none; b=Sc+tZZHh5w1eNSzf1iArTjypQ6N86ScNQaJP88Bfj1yFV989q+xxXgGRKf7VklQYZTdoCXykzhO0xoPts3ffdOk72HYiWRp/EwzQo/VKoewd0R9BAX9KDi03KGBYJC6MbsnXmmqTetuTqvnq905lt0AUpWDEFsorBnK5iRw1ysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659401; c=relaxed/simple;
	bh=hrp8hJwCv6JtGRmkoW3+4i682foozLoyZ8LXR/WT2hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHava0uBh7H2qOhUqIKYGTKX4s/3BvHn3FXOakUXDBDs1O9bm/VoHuzR7Olv/vwikc4P7C9h49DbRMT6n6In5lZx7xfIaKJcI4kDA96TSCV5i6CUqQHR9kqN8Ch/LbxLNWMXsr3Gbgw7GGOLYkLUIObydkjQB4wEdjZQ+jF0O/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAbFBBCE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f7c0fb972so1599300e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659398; x=1758264198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/e6a4r5HwdADWqt2gxdEiy8yhSw818PuxVS+VjAKm8A=;
        b=nAbFBBCEkrqQmoFhdT+1kT9udZDmUlOabmbHxQexVc9tNaeZ9eVrwzOBsRUTbSAJ1e
         estnDEk0B889g9AqELk+iMhHfACJtGAQdQWREngq3ZitADVmW8sKmEKcKGqsR5uayERp
         M1qb/5Z/rZMPeDPpynCI1a1bPazyIYSbk36fFlIdmjTsg5iIVIU/cqET7Tr+mSNAzY6h
         wctjhTWxCy3OkvY5dcYlEaaRTwmjF4WVMR6p/7hIwJxOpcTRtXJy+CLhHMW0yBjOp1cC
         Q1NNsHYfDC5ZMR6bvy/chjYQ39gH7QWCxO0OLjgADvizFPFlghp3XS9rAyqGPxKFoFq4
         KriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659398; x=1758264198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e6a4r5HwdADWqt2gxdEiy8yhSw818PuxVS+VjAKm8A=;
        b=oQVphbIJCMQCvIKVPOY9KQ/pNao6bZfRoZB/05ndE0rs/NCrK0ncVPo9cyAJCUYuj3
         87amQ/0nEIw2btp4LGPgO3DJVkU2izd3vyfMA8x9+U4EPIZN/KWKRpzwiF5mQfoB5bKg
         /p5cjf7gNgFGPd01tzJkwqHlpGh95JDvUxV6QGf0X29XshoL7xNC37EeOZAMb3/BzDyf
         p8fOI9cr+0V8V4eV89ICE4tZh6qJiraR1oygF0ZQtbPWoUfa6u1EWK2ixSJqx4x74nhv
         tjwX9vq0OIBnVnMwrbdhXVd+X+PJ7tMwEFMaakCq3zrlh5NEhEuOC6ImKAgQ163D6QgQ
         nEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZQdLAI4KUh25Md+1GGvRL2yitQN/fhOY8fPFPKOW/0a031yazM41iPUf9BDcnWDGAyealnulOHip6UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbO2Mvm3rUGWpAq/6GclrRpVcioBPFTuEAl/jIP7qe9NpHNbN/
	ZvYY7ucLeHJ9KLOyG8/lfSD2/j7PvePzZaMSxrRlhWKjBgP+wjnMFLF/
X-Gm-Gg: ASbGncs2vMMXgxNa4A48o5bbz0FYHaqqMYBR1+o/qbz6zJV1CGXN4l+LTXT1hoXlzLb
	rhr9oCZHIP1Iv2Nm9YSKiyX/ivoEiZU1khvhnYp/spTp3RlyZieaci5rE+rU2BLxgfCZ9vihuwf
	hZURHb+kom0sdJ2HaCNI5lHkLaIItqYgoFySE69WPRBHCk1FZQrz5FJCqt51drXqqg8wUtZSoKs
	dIq7fp0ooEa2lCkSOK7Goth9osnv0ZnaFJN3sTfx/BSnzGafGK4JlawaOa/HBr8g9WB1MyA7W4E
	3AIgRElw/7x1iHeGI9JOZchxp38kdnYo3rn5DEMtwb2I3+OjDnldS6YsKEUv0Cc3Y1ykPDR2POI
	v3ihucLhfbxDlwA==
X-Google-Smtp-Source: AGHT+IEe0jkCS9U8WkTjVXPYNmZSLn/syNXqorRteuFNbdIlDVO4YBhxkuAG4CzXjByN5DDqyt0+Lg==
X-Received: by 2002:a05:6512:290e:b0:55f:4efe:42df with SMTP id 2adb3069b0e04-5704dba12c6mr472968e87.40.1757659398015;
        Thu, 11 Sep 2025 23:43:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e64bd15e6sm917403e87.116.2025.09.11.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:43:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] DRM: panel: add support for Sharp LQ079L1SX01 panel
Date: Fri, 12 Sep 2025 09:42:51 +0300
Message-ID: <20250912064253.26346-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sharp LQ079L1SX01 panel is a LCD panel working in dual video mode found in
Xiaomi Mi Pad (A0101).

---
Changes in v2:
- adjusted schema with ">" and dsi0 > dsi
- fixed copyright from Nvidia to Xiaomi since sconfiguration equence is
  based on the downstream Xiaomi code.
- adjusted commit name of second commit
---

Svyatoslav Ryhel (2):
  dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
  gpu/drm: panel: Add Sharp LQ079L1SX01 panel support

 .../display/panel/sharp,lq079l1sx01.yaml      |  99 ++++++++
 drivers/gpu/drm/panel/Kconfig                 |  15 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-sharp-lq079l1sx01.c   | 233 ++++++++++++++++++
 4 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c

-- 
2.48.1


