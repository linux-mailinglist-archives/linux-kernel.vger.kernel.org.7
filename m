Return-Path: <linux-kernel+bounces-796458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5518B400F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D83B207E62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616B29CB57;
	Tue,  2 Sep 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfBaZMMl"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF729C327;
	Tue,  2 Sep 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816901; cv=none; b=gMEktiUBIrdDAPAnJyaBeZIHdiOIsTJhBsPNdjNA4Sb28w/iNLM4kz9e1RjirzKnUsNXs73JSDWXz58w9zHlLoA8M/sTpQnzVvnZh9N8/OWX2VWDhlE4c7VnW2O6HoBr7mfLjEVg0zgMQnUojuZSaUUowr0RMYMuduchQ6xHeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816901; c=relaxed/simple;
	bh=0tYdvKx1V4VHG6cL0RUesihNWdIFU1uuGGjvUEAK3XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EABwWKgHIJL605qIoNnroKWGoRY0wiCVZy/kCsuy8XM22XkZRf2xSZ3LSJmneVj3uMm5Vl89jjP9cYUgHt+N6NdSlahOP7FUMuIHW8a21z82eQ+QKkTVuH9NZgc2vfugkhqXx4Nr0MUXmBQfvI4hHXhuWV91o4fF1njcRsKwbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfBaZMMl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3d1bf79d75aso1055993f8f.0;
        Tue, 02 Sep 2025 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756816898; x=1757421698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bLl+JLjIhJwlWgN4ocOU2hzq7YznyPeqJKD3znSlmKM=;
        b=SfBaZMMldjfu5JLuIpiz7fWiZXA1BMEJtxjlNbtX/gqVnRnZxUfk2jhiLYy1TQyR09
         LU4BuhUFdu2+NRKhj5XR+2qN8xaZcZyIIndjdeQ9DQq4qLDFy9ZNWeJNvx5e9edkdN/d
         Sr6SPZj9DDHl8d/89Xf6/jGXX5taIGJ4TM9BMBtZr419/VHFhDDcfgswwL2J/1ZVjBUc
         qYaAEXGrT7NDSFSkv+gS8yHv++B0gcmkI/Pn5nsuZSTm5SG+gEdZN60kURdi1W0RFKtj
         K5Nwn2yTRtJoY3hnnYvdbzZQpvLPl9mrQQx+O+REhEUB/HhwILN+L6rPzvFQzyDtIM0Q
         RBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816898; x=1757421698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLl+JLjIhJwlWgN4ocOU2hzq7YznyPeqJKD3znSlmKM=;
        b=TDvtDzwQix9JuLFoHTCKzVX+jnfrNY/cHg5ADDbc99kdAeF3R3VdWES2WcSUjQwNeW
         CU13Slz2rogf7Sa8VUfR5fW+m+FX1Lk0zP75Pgg9AQNLI/3Ml2LXAZzd/DlHlthJcoRn
         G3WJlmigCGE9ovtDShOdxWBCmOn5wXh/RiYriW29kaq+b6d08OogfGrDsdO1NPoyT1rV
         xIz9sZIwIu/nnJuUUcLx59WI9vySoie74DBRWGpGauU1gMmxc+Pgbe/tEg2CZJelM46b
         5TtG9lVKF4YISPSieu0PFyTfprDld1vhzw5d0g7/PZQeHA5IuJn2YYlb4AgRn83o6hCC
         oGSA==
X-Forwarded-Encrypted: i=1; AJvYcCV++vdk/GObuExOQmb7XaET4PX9QOA8CsmT2DIespKLzlGUwni6AudKzePDTB3ZAqRjLj9pY4xegPQ1Nfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxio78Ia4Dq9+Yuq70feCW9M90eHCUK6MdkDhGWSeQW31P/ZB6x
	KHqNGELakL+vIN3ufU4zyXiVZ9gwwnwlBVNE1CeMeloWbgTZ1+4hc9gT
X-Gm-Gg: ASbGncsFSj4J+L9v1HlgR+vykQ3d1A3sJBcCVu/itjX3b4jkoYDWJsATcV/R7/+LX+R
	ts3KWLzOwhkQSkb+LkWnq5hd3xBDVSP74KO9Fcm37Av8GhTWMWnT1KjuEY2GgLle2ZOlZJfvbd1
	FNFeA4P8RG0GvK5ryHR/NCfPRZXcmdf9zmA4ath1teqrzOq5+MSAYmTVTajWV9GeyLkREytYclv
	i29qyJhK8IvxXt7m2MnDUzPuPl+jsdbOwwf6Zshgk3+99/wmL0bskQwDSqsxqOr6m08FgPQnyuK
	YmS5tEG5xCFmPXsZ/U7N9ziyzWYxi/opbzhD+3f/vGAqYZVYiXv/YBSwGebFQbCJCns7QZCVVYy
	MyijqwABcC8zGhNgd5xb3buzAo0gYvZU=
X-Google-Smtp-Source: AGHT+IEz5I9J4HFpTbmwM96KDxKRFH9y58DSSHqyixEB5HxWInPxE6QIjGk6UgfMHbUWnP2ymlC0Og==
X-Received: by 2002:a05:6000:4020:b0:3c6:c737:d39f with SMTP id ffacd0b85a97d-3d1dc5a5641mr10228606f8f.3.1756816898145;
        Tue, 02 Sep 2025 05:41:38 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf276d5e5fsm19738997f8f.27.2025.09.02.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:41:36 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	John Clements <john.clements@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/amdgpu: Fix missing error return on kzalloc failure
Date: Tue,  2 Sep 2025 13:40:50 +0100
Message-ID: <20250902124050.2628822-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the kzalloc failure check just sets reports the failure
and sets the variable ret to -ENOMEM, which is not checked later
for this specific error. Fix this by just returning -ENOMEM rather
than setting ret.

Fixes: 4fb930715468 ("drm/amd/amdgpu: remove redundant host to psp cmd buf allocations")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1d6e1d5de8fa..3696f48c233b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -448,7 +448,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
 		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
-		ret = -ENOMEM;
+		return -ENOMEM;
 	}
 
 	adev->psp.xgmi_context.supports_extended_data =
-- 
2.51.0


