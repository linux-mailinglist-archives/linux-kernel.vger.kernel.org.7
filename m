Return-Path: <linux-kernel+bounces-871120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75852C0C7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1410C4020DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106431618E;
	Mon, 27 Oct 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrWhnroA"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAD12F3C3E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554737; cv=none; b=hdUMKv6b1N4Ie2tG/oYudnHyy4b9I5lVVLCIGPFV3Hp3r1x4e+2VvNi6Jkk+mRXhP/9UwtEWq7tRECio8hi5YR6dVGcAlTCnkspCUIx6NkvE35NWTlIEhBmGBV25F9KsCPMlyM1rComUBw0UWfinNclU/ZoAQ5JAroAFFMbFINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554737; c=relaxed/simple;
	bh=ly8Hr2ywwPol+OOs8cEqDSSykysMh6TpsVP/PGQVACo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjDUc5sVT8WXlsUHSR3wxa6tkfuH1ZyJiEHoWL7gocWJCmgrEb5EjUB7wy4U8klBP7THvAqkxbVor6eHkLNZhvD44GqOXHN/ikIZNn2QUUhxEntKGygBD46noA8ET00VkSDho5+gEMnWjZOMJzLQh+6j9zKhZvX1vqjGij/Cb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrWhnroA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so3194952b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554735; x=1762159535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DU0KscrGihyZoXJMago0IWkiGUoidqfLwL76Wss1j/4=;
        b=QrWhnroAXJlnaAQd1X6cggmCZDoDH7RHA8A2ZmAoKtPCphlb9vz9UPcqaf1dHcGEo1
         fjEyZOPDELWIcVFSluUH8SiqDgmyUUGyZohlD/cb+VfG718TavzbW+UiBx0piw7LqOpm
         lEKAnlDOtCGB3M+Ul6GjA31wW+TjZZPJCtFo0ilYBo0gbb7aeClVajhz0vFXGbqNYyKU
         x0wiWwVS4NxmguXDKcv5ZegdZLHLriCfcMNEuyI9+qVaPzeURGMs80Kc50w+B3j+BoCF
         WVooy1brKc0tyMO0GO/hXmO/ZW+NiNp4p1sG4OlcM/VT83r37bLNxrp5CqnzXkc5OIKG
         VcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554735; x=1762159535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DU0KscrGihyZoXJMago0IWkiGUoidqfLwL76Wss1j/4=;
        b=OEArzt8M+n6O0kYKnHyqNGrR8AZ6XDGGq5OkM/oAaD/keOhk5xXFIE9iGE5rgXa4GX
         yWCwlKgH30CJxgJPZiTbwFubIv7F3RWO9OUTRHPdMUCbn6e184RKpajnZU+u5EsZIDwq
         pB9Uwy8QBYAKZA03K9zksiBScRGTQtTkyIxMZ73aLOdcqljsEqUEcCTep42ahrVhp7aS
         cyMY+IiH5kGRebFZBAVQswJk77eVVGJ/P17q2R4E0A/Mos7QfwW7xM29EIBC6fWdtRXo
         JjeeSQFmM8BNrPb/G+JyPMA5b8LqI9qavsDNKzKGqTbHtC47+u21E8s/HCRyUed/tSAw
         e87g==
X-Forwarded-Encrypted: i=1; AJvYcCVUla2OVrVXaharO1iTgU9bI33xjByJoSlrGGiF/5cJu8snaGPZBtnIcd33lYU/nde1wGHWsBatLBOeFYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMSOc42e4mUq9LLQemiqOSny4q9ZynURrQSKkMTEnjgbks5sW
	xk48E2Fe12WqIpbemHojdPhoWBShw+mFnd/SKDZ2Vf3IpUNsfL8nx2K4s+uXX0LDf7EHGQ==
X-Gm-Gg: ASbGncu3iSP1whS6a2QZxiP4MfMUz6Qi4BItVDoh1RpSMJi+y5HcapD2s77E0nyI5dr
	fZwLIAdzbP+NE3doFVauLZz+XCWGt9mvHELcfbdkTLjturGxnfF6N/rPj212VwHFVvRd5OY4nL6
	KE4T9BQDuC0pWKTZXjLYxznWbJvMab5WyQ7Ds2ObEjJXLcgIfa6VRrP5XkCH7feW24UqT76r+qP
	qlzPMXE1KTnkcWJvF56gi16O+RfrIt8u5t7lgfqjMJgsifZ8AKy7zBYGQzXBz8oa8wr4mUfUwfL
	7NFecx5FV/Y1x4f8pZFBEqwthDGtenEyakSTz1gk7fg1SAu+D6FHq4Ie1cupw33UVk3ZjF4Zj2M
	uJM5EsBT7HzLH/8wN7cY7zUaL1tGwtWNEfVx//RQZlemwS/V1qGlVVjVgcP7zMoKhq134pM7G61
	I5UUpSGvpFMvMSwcO+aWHjvkcie5ch8RAN
X-Google-Smtp-Source: AGHT+IFlSNyx/m40xKYC6OWXlqmRmI+SM7/L6vothAHVO/hXw1MzPva0O5TbGE0SIfNFUBdqckDGkQ==
X-Received: by 2002:a05:6a00:2d1d:b0:7a2:73a9:96c with SMTP id d2e1a72fcca58-7a273a90b4cmr13811317b3a.3.1761554735303;
        Mon, 27 Oct 2025 01:45:35 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm7300209b3a.38.2025.10.27.01.45.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:45:34 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: Fix reference count leak in tegra_dc_couple
Date: Mon, 27 Oct 2025 16:45:18 +0800
Message-Id: <20251027084519.80009-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver_find_device() function returns a device with its reference
count incremented. The caller is responsible for calling put_device()
to release this reference when done. Fix this leak by adding the missing
put_device() call.

Found via static analysis.

Fixes: f68ba6912bd2 ("drm/tegra: dc: Link DC1 to DC0 on Tegra20")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 59d5c1ba145a..6c84bd69b11f 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -3148,6 +3148,7 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 		dc->client.parent = &parent->client;
 
 		dev_dbg(dc->dev, "coupled to %s\n", dev_name(companion));
+		put_device(companion);
 	}
 
 	return 0;
-- 
2.39.5 (Apple Git-154)


