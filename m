Return-Path: <linux-kernel+bounces-864938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FF5BFBE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E18A40869A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699493446B1;
	Wed, 22 Oct 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="r7+ud1JN"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC563344049
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137201; cv=none; b=XQPTsBslR/sppV2GD8HB4p8qo6ZHRHYLq4WnO+OC5dIvZ8JUMOxzURhU6IKGqfJWrPhnsj3RaQJP4VsNYIzfCElhsMeEh1EQB5GUA5jzMKQZL/lfP+pV/h3fZM4jjVQVVU/3NdEBqcvzXJREg+F8f+ipuCwTGEW6OBdXRKvpov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137201; c=relaxed/simple;
	bh=1SGorwE87TZA06wTMH8UPqXD3jRMotu6m8raSOuoLSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cnP1gceQt6CEp7yiVRLQzjxNnpOpQAWo/LGwCSUDS6agHo96wR1Yo9hrp/d1opq0rWwoKH0s62JUMeVrTJZasmtJ8kCYcI/1txI4J4huWgil5O1az/vPr0XS2jY30LbC4al9Hgvr405pSHbbJp7r/+eFkvNi1cICJR/cnvzvGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=r7+ud1JN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811fa91774so6080257b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761137197; x=1761741997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYmui300xmsOqVGhM5Jgeku6egbsvMIV9ovTXTcHC2I=;
        b=r7+ud1JNvmU5WNq4+gwcGTJYfoHxVVUthSnNma7nOwz9t63glCXXoBuv3p/1RUK9hd
         ux2/nTntwVGjQUN7momOtK7g1BfSASuAE3Kgo03hOwTLyIcrxozjoVEEwYHHRodp3KiS
         K7MybnoFLqfnCDPi+pzDOFJ5t3xS8ggj2B/e6hyn/Vm3BuZ8uk8zUmNo1HWghuWool1N
         ZC9L+rUjqNHo9KS8quHeOt8G7J5IHMskbC5k9aUMkeDHUOKLwFkLVNCQxs2KOuNoHXOR
         8RzrhaMT3ncUz/FOmhnkuc6G4sZStZhXNsS6LQbBOtUCwz0b4GqDfID32Q9oaR1SXcHU
         oqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137197; x=1761741997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYmui300xmsOqVGhM5Jgeku6egbsvMIV9ovTXTcHC2I=;
        b=fgGpgcKJo/DY4KghMrQS+skMw01GpR+ldmJ0j5nphwTP8oJVvX5dn7IGII9Yaxcc6c
         84NZTpV7KC8h9rQbAtehVs9zEbXfRwKFksn4pVA1R2HL/v/KO8Rwto0HIvQ3cTY0TG8F
         Qo7deqfa2WfrHsfQ6y6VidMAIQOCixkilXk6PrzK/dfPCWnyA9hOFXfsKca68h2ToEX5
         1cRVevpfachxbnGOMoYjuUz06GZjnQbDwTknz4H/b6HL/bDUihyESuzQDcaMvgWnw6S0
         JrtqcwDtZ5nWCDNccunE17QVR3pRScb2jbdzpJZ/5Qkiq8lsNysWJhfO7vUCFcJvQJB2
         PiSA==
X-Forwarded-Encrypted: i=1; AJvYcCVm4491i00GVgzqo/aJsDFlsi7VBiWVaBMidkhDJmZqP4xTQCXIj1QqbLNUqjCfZlZOQ0esJyuYD2Y9KxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNheUHMg/CtJ33GVgOrAXA3Mxk1LFjWDIx4CNQkc/PAnUSlPL
	ccp9kNFjqIfyKXBWSx2ogNMYGudVSsQNkuZTWF/JaR4wtcZ4yHV4HPrCb8yVxhTyypQ=
X-Gm-Gg: ASbGncuiVQL3o+2hnG6TlxQrO/m/RTweDxqU6jPDhykv7WRE3MyWuR7reDU9p9SsleI
	HKN9rJ2advDdxERX/xLGoGmIM5LncnhAjeF+CXdoM8DKDjOLtHx6tbQIkIGTne1AaCwKrAWHSn/
	U/BQqypkSz8N9jA2GJmG78IY4UGS9HeNUmxeLNYkyTkblrJpvKVaY5Xx6vtp+W7M7TQRqz5oRhX
	BfW1RL8h67VqU8vjFP73xJUJecod64ogpossuElbFyMLh7ex4IbqFqR1PVydhcgpNg0hbm+bPGk
	DxS6qnZA2wXTGsj3Dispxn9j5X4c+RXkmtSNNI7dh39oqCljnppaYe+j3PXS7YrODUt02bEVcVW
	ZL4SdgVJQKzoK1CJB9XsD5P8WawqIxrjUXv4HbEUev0nHLA/mAuXazolFIXw2s3+FTYJEulkL4M
	uMI/cCJABHiJK2SWzql7sNVN/xLnLEw3o+tb4jgOcLfGdK59vy1tpbkcv26g==
X-Google-Smtp-Source: AGHT+IGSJSxaOUKpYiZ60vtbFdEMCWPb89iyz1DbTd1qZJyxQRWM+oUSWq9CrrRKfdrQfK3NOdLXgw==
X-Received: by 2002:a05:6a00:3cc6:b0:781:239d:f2da with SMTP id d2e1a72fcca58-7a220acb30cmr24901864b3a.31.1761137197031;
        Wed, 22 Oct 2025 05:46:37 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e25asm14363935b3a.56.2025.10.22.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:46:36 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v4 0/2] drm/panel: Add Ilitek IL79900A controller and bindings
Date: Wed, 22 Oct 2025 20:46:26 +0800
Message-Id: <20251022124628.311544-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds device tree bindings and a DRM panel driver for
the Ilitek IL79900A MIPI-DSI LCD controller, which is used in the
Tianma TL121BVMS07-00 12.1-inch panel.

Changes in v4:
- PATCH 1/2: Rename compatible to "tianma,tl121bvms07-00" and update example accordingly.
- PATCH 2/2: Update driver to use new compatible and rename related data structure.
- Link to v3: https://lore.kernel.org/all/20251016095043.1694736-1-yelangyan@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/2: Fix DT schema error for `backlight` property.
- PATCH 2/2: Address review feedback (use mipi_dsi_msleep/_multi, move init sequence to mode, minor cleanups).
- Link to v2: https://lore.kernel.org/all/20251010093751.2793492-1-yelangyan@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/2: Address Rob Herring’s review comments and align with panel-common.yaml conventions.
- PATCH 2/2: Rename driver to panel-ilitek-il79900a and align naming and structure with existing Ilitek panel drivers.
- Link to v1: https://lore.kernel.org/all/20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com/

Langyan Ye (2):
  dt-bindings: display: panel: Add Tianma TL121BVMS07-00 panel
  drm/panel: Add driver for Ilitek IL79900A-based panels

 .../display/panel/ilitek,il79900a.yaml        |  68 ++++
 drivers/gpu/drm/panel/panel-ilitek-il79900a.c | 358 ++++++++++++++++++
 2 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-il79900a.c

-- 
2.34.1


