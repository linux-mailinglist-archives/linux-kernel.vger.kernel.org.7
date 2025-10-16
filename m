Return-Path: <linux-kernel+bounces-855857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A6BE281F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6760D3AAD23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B92D73B6;
	Thu, 16 Oct 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="i1NvkA1v"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030132C325A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608253; cv=none; b=Flx39D6q0EZ4+3s49W2cIKpHEjXT0TQiKwSbSnux3puwHbdF+ljcbfp3t++URSOIjx5D4Gqlycm7BjjEHkUj+/eLk9as/LgGo+XByRb9CnMiHI554p5QFHhcC9oPBUV95aATX6HimBKj6GSSHy6sYL44kfA853SU2WPzPcw9iMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608253; c=relaxed/simple;
	bh=7Lbjvpdb5yligdenfDwhsEudYnuXPAhol6Ou+wLn3aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MalwulzutfTzTVBUsS/qEMnWhQ6c+9JXkbnnooIEOLherSz05L8MW1KGxna/FLXoDh1LdhMVZ8fb2KyE2wl7RY5bzhRlJpsINZBiCSHz0FYeh4EFVvzeb+Xcp6yg7niJswGgGg7/2anTTEhJMRkwfyVFZXTwI9W77YSXowrp8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=i1NvkA1v; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso560757a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1760608251; x=1761213051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UqL1IWSrCrB8SZs0M+f9GgpD3kKZ3YvqrOYctBtGCw=;
        b=i1NvkA1vXb2EulrOByOhhsi/a/G2QMW88ej/aXfZf8lRFHoAfH96CBWzV7yQUcr2Ay
         TlgEzvW0S7PtJeNHYxQUhxxLeuUBdTQtJ18xUALj7YZz0NTtyZmvF/QfL0Wim4uxiwDY
         eXYSmR5OFQotnAbc83FV102AHLKWkQY1hjyXWfBXa6HPE8Lq7g743+Uy0d2bsgF1R2nW
         t9HGZiEbDi08zDSLLI5+d3BZeUwZccfRLgEnF3KwLobFHWzvNQ2zL8b7P8O64Ri8OFLH
         3EPWFkDrwZVP5Feb3OZ/wE30QGQEUfmSuGa6cT8YlIeaQ9J4lmatspPM45kPRCo00jPa
         t8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760608251; x=1761213051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UqL1IWSrCrB8SZs0M+f9GgpD3kKZ3YvqrOYctBtGCw=;
        b=wLsvKzWCbY2zmidmprZS9sCIGSPlHWnhjz/i8KFBonOhvdqPb+7l00HxC/hW6dCaVq
         FKdAZgwPbr4MwKXKf6GPLg9CvLOO1vZtiV7POQxhyqBv4UBiS5AJkmVts9MSbksRrLdX
         ASxalfuP0769NK990+NnzrB4xfinkGiPbDb8tGRqCdf5p745y/AJ9REdVLOyyXKc9rY7
         Ta4IKHJ7fNyXkqOP62rVnb6tOmevBoQ4Tdl4RjHhXZYUDKdOJ3iFbMvzZe4NEq+21Hms
         IL6MfdMtdEcekKeK9VBcUdN1q5CUr94zePZnnM/nFVsSYgolj6pgtqer2b8mCTkLsx/o
         lKRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfbazppA3lL8gZaHc4c8s30MOtmQGepZGVzUIdefmZUI7OLh56aCSEK80VikhqtVML09Nw4hbal4x/a04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8xkpOd9Z4QFaprs4KejglQ9ZZCg1nYED4siyeu8dfxtjygOQ
	fKpXTxSmTscdyp43PiMZ1FZgTnfszN6GPul923pIpPv4gsrnn7wnwYzaSjybBJKjRpU=
X-Gm-Gg: ASbGncvYpP6LjdC73xwERAsVQuPk7keYwS1UJZ9qXZhiKKiC2mitrjVrRVB9sWUFKzu
	4XcZqrgP94gPQyBh3L18/BxP/0uvr/PfG0HB7m0+V4Mm8m8YNTCGz9Axg5Jxu1r/orTMwavhlRI
	6yyrF3cQC63KthQWkILuS1NQTOKJRMllUc0O+lX+10ye+EXhdx+xxb9Kq9yKAD+jNUOiojxeyH9
	eirmqZOSMAq2uKwb6wh4aw8VgEOy1dpA+Wa5t6KuLB52EBCAyA3JIsULQdoYT95br8DvVp9Jja8
	XjTlEHXFiL2dYzDXvwD2sAwrnNY1TnW3cSUW8vc+SzcBKJCevRKV/kjfHexEixTcVDyjtKeKnQg
	4uVy49aZwbMPpv729i8UqrBFehZyfywvdq2vPzcvUaux9koiNChfZEc0u/Q4a/+5tuwUOBu/bMq
	oP6G1eTe/SX2bpAgrHlDgjlgUbLwiYkCC+XVQVy4KbG8PI4cf5vb6vHeS/zg==
X-Google-Smtp-Source: AGHT+IHds62hDOWB8Db/Nb46keQgSIaK4qyBY+XsAGxqUcA+ucqFv6LqUgHKR4GZ/2/Bst1JZdDjzw==
X-Received: by 2002:a17:90a:e7d2:b0:32d:d408:e86 with SMTP id 98e67ed59e1d1-33b511172d4mr45695437a91.7.1760608251293;
        Thu, 16 Oct 2025 02:50:51 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6519421sm1272402a91.1.2025.10.16.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:50:50 -0700 (PDT)
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
Subject: [PATCH v3 0/2] drm/panel: Add Ilitek IL79900A controller and bindings
Date: Thu, 16 Oct 2025 17:50:41 +0800
Message-Id: <20251016095043.1694736-1-yelangyan@huaqin.corp-partner.google.com>
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

 .../display/panel/ilitek,il79900a.yaml        |  66 ++++
 drivers/gpu/drm/panel/panel-ilitek-il79900a.c | 358 ++++++++++++++++++
 2 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-il79900a.c

-- 
2.34.1


