Return-Path: <linux-kernel+bounces-891753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6632C4362F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F5EB348AB3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600A29BDB3;
	Sat,  8 Nov 2025 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E/WIEQuN"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027728C849
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643614; cv=none; b=PlX+X/jN8CWl8u4MH1mUR6mEDyUAfzkSNzWrcUwkcWd+N23WL5PZ9W4OCbuXktfQ1FXrK7P7ta9n1ykt4niOfrPyeJ2a7OOtM1FHrXwKGizEQC19GP6+SsQWzfq/IsVQnPd36rbEF/luOaiJ8zCVFo+mVktHnHSCALfkloqMAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643614; c=relaxed/simple;
	bh=fIhUPNIq43wji3Mk4iQYsn7ciQjs0jxKDfIN9kIEqzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSRZdgpjVx2ZqJjFrlGvR6oTu+LGEWWqWayOoJOvQH2whHtqhJq6tNMigpAovDmk355PNID4rolEo2x70m9usDkDboZxqt6/X0ddUJdlr2EGzL1q2QRpcAt5TIdU8E6TndsqEHHKH/NZwfuTdEltZqQZG4ENLGKyga9ZewyR3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E/WIEQuN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so3004461a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643611; x=1763248411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oO3j4actqzf2xVKKJ0nWDgX3aF/G+cl1rlsWPWa+z8=;
        b=E/WIEQuN6AcdfcsY/eJweh09/g73nbGarmoYlGt9et9k3fdFb2JjCYkc15ycb8kq8x
         rtkSUpkVZKqJBypmyqJ51CcBW4mnDE/zVyOdHwO6c1WKg820EgzPqLQbewE61nOqlHlj
         sOLu2hpmrNC2TVxIZ20AJxVzkACal9epbff06jkGr7UlXJadGRfSQSCVe6VpBd/KPTw5
         yPNyRzBxv0zooRKqXLAx1zhxKxn/x8Yzsxe/Qmz6qGuWDfuJhhM8fe6Gnr7N8yjS9oGs
         GLgF1DsbhVet+QCoCtdvGAYCp42Sfd2jn/3Khx9KQGb7Yf7xYBfWi5IW2vslVg6CtuSj
         X0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643611; x=1763248411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5oO3j4actqzf2xVKKJ0nWDgX3aF/G+cl1rlsWPWa+z8=;
        b=OJDZ4fNu+b99r9VYjbKwyus1Hb3ME/uz+8NvB24esyy8YoZec3mvWfW6bB9Kaizc6S
         PIo/3poZig3Z1lT+RLojQnmcbAAZk5UHDfXbUUUU9bMxFE2OoLaJr8vtR3UKieEbhVND
         6299Fa5dFBWDxNjWI+P2HHr0J386STQo1Cl2K/H7CYBPMt4fa7K+uCySggUk8wXLxnGo
         KFeXJEzv1voi2wFXhBpwvGb6Xrc+RE/CmBwKWJv7vrYiCQTOk0a/NYm99z8lgSPDtLX0
         OBBfCjVQMt3EiCKH1vSYNNVY4vbP8zBA9HaMNfEGsQb6QTg6xni/nvQa18ur1nHekxAj
         QPeg==
X-Forwarded-Encrypted: i=1; AJvYcCU0O99p4iZ5ANTlL/nYgPoGl0eNnwlZokcsGMdbN06EVb6H3roMpzgSVIWLNaNDbONbIWFwX4VLR5WM71I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3I4fZkLRigQTEfC6WxxoTMx47QGUNMw31+wBCJ8CyJMTCEtES
	+0q+FrvuUQ5BpjdoqEQ6EUdYR/SLtkv/iTjRqdLNc50LOX2GZO9NtsLU
X-Gm-Gg: ASbGncvZCySxQJe/qkjkEZoUjLa+skxwzjDxuTFQsq4AgTfFRLqOjtwecFP6la66XR6
	QQ6SMO4UI1FfeYTB6+N1lYnYBDuUth2qdhduLrtTMecdI9dB7dRVdYLlbGI5NtAU2x7+dXIiIsO
	cUobUchNms+5t1QgcmP/tyKTBeYHC8eiYgjJmPOG5l0HLwGFPms+DnLclEcpkotAx6DrkGx8DiT
	VmjgLwlhge+nEmQ5yKZI+xphFiDTDeArHs52dgsVc+9oYIjaSDGNbaefi2hrXMKdr7+TJAFHZqB
	X0QwnpRjkAYGO0yjIfGxfRJrXVjyexO81wIaO7JvAbcaa5k7zBCJ5+VV880se2Y+YygBSr+fc5E
	DHyKp8tTZ5M7IFDon/yI1jkQlDtOj80wxFKsaopM/w83eSZLceqVeDFEctiqi1WxEyB7FhjJugg
	vEtHs1mUVR0mZ4KVZGqGeXfKifLiBX/5aW+3ZY7dAs3kGQZYTUUupZcVBgXIi6YOgNkd8lF/zxv
	dby1xkeHCvCdp4sWoJ38hn8G0nyp7Y4Qv1DdwMXjpc=
X-Google-Smtp-Source: AGHT+IGKjmu35eL8DzEjWyR+sT9K1rO2NK/av8+BPsQU60PgD99LUOCuaaHsb7hf+eDzu3/wZf4PEA==
X-Received: by 2002:a05:6402:44c3:b0:63c:1170:656a with SMTP id 4fb4d7f45d1cf-6415e809ff8mr2471765a12.37.1762643611141;
        Sat, 08 Nov 2025 15:13:31 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:29 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 6/7] mmc: meson-mx-sdio: Fix indentation in meson_mx_mmc_irq_thread()
Date: Sun,  9 Nov 2025 00:12:52 +0100
Message-ID: <20251108231253.1641927-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the second line with arguments for dma_unmap_sg() aligned.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 052bcf8f32df..e8b63dc45dd8 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -436,8 +436,7 @@ static irqreturn_t meson_mx_mmc_irq_thread(int irq, void *irq_data)
 
 	if (cmd->data) {
 		dma_unmap_sg(mmc_dev(host->mmc), cmd->data->sg,
-				cmd->data->sg_len,
-				mmc_get_dma_dir(cmd->data));
+			     cmd->data->sg_len, mmc_get_dma_dir(cmd->data));
 
 		cmd->data->bytes_xfered = cmd->data->blksz * cmd->data->blocks;
 	}
-- 
2.51.2


