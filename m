Return-Path: <linux-kernel+bounces-794166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE0B3DDB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F7A175DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8389C305E38;
	Mon,  1 Sep 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR+ub2ni"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911F3043C0;
	Mon,  1 Sep 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717893; cv=none; b=CA5upUs/2G3nYiWa7+5i6OIWQrlYKl68NZTGNx/WqCklehgCA28Qk7Mz6FlaNtHOenk1kJM/HUmyrJjQU/QZX8kYqfUSpeSXi5xofkR4Umfd58GBd8mVYu2Fz65sNgXtQ6Q8JpP+hKIlSaGAfaSrCX5erhYCJR0dmReLoyVM4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717893; c=relaxed/simple;
	bh=puuZh11dIWkP+XPsiPC4Q4cj2Qq3Wx7382nouSZl0EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SDCegubnxcCVBqI9s/BLdeSSvQDmUIreiGhIq5AdtHxfiZ2wbq1Qzky5NuzSpJffmgGPYPgCs1HJNHHYd/MJAEIP0mpO9GfaDu7zgED8Ktng2+NtI4ymvPAg1jAPZCXU0U5hcC3ufhTK2wSrbqWc1fZ3EoHqSBSWuqNYI7+8/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR+ub2ni; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7d87b90fso25071725e9.0;
        Mon, 01 Sep 2025 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756717890; x=1757322690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jtzlsr7MnFg9Y5VOjl2EoljPhue21WUatPCKKyRxvGQ=;
        b=UR+ub2niZRDT98Ic/Lw3kThNKk6kkDzsVuk1qIYX5VtInsJX2/wZgQtEFuVzSSLBJG
         bZQKvQBlGBpQc6QK62hNuLrIBmD2FFEEzyR4rV6dA3UhJQx2xZpfQac6TsxkTc4CgWPD
         L/yILUMdxreglx6oNpJ1GcNyg8UspGkFgjltuPcvrctzAyuq1pVcj1k5fwS9oX2Utvf9
         Ysrk6CSUn7fhTtmvgrKjxg4mwEQmcR7dh9xUEaZzUqozQMJGMkMRvvUz57QX41KnNgIj
         LrnD5t+Eoxam1+BP/0PddEsVCMN+jrTgD/2wC57JeEoAw6A8JvfmwjIiaFQXJkIs9Ofb
         uSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717890; x=1757322690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jtzlsr7MnFg9Y5VOjl2EoljPhue21WUatPCKKyRxvGQ=;
        b=rzVWfWvNhi459PttD420sTTnjKZAAzeYcFcpIQxa+nDADtR5iUGXugux4KW+CvaQ2A
         /+rSikpXK/BzFS+b+bZsquLi74b0a3R9aY8bNS9PBa7ur33RDkP5jSFnyG/G7D6r7YlJ
         9FOq2LII/9IQ3Jr2GyrR6kzZLAftrtCjpWgynqlEkc/4ZRg4PlDzfl7qweExi8R1PtKj
         vq75iUgcD+jh2Pp9sQptgNfCqcl/d4RVJ+eZIkQHUxDlQjG4Av2wP4MviG1/GMFQW3IS
         FyS4msYQZzt1dCtQdKpVFSKJqmhXn0L1O/wgw5HARoDATVdNk6x8baEJci7hM0219Fh7
         eU0g==
X-Forwarded-Encrypted: i=1; AJvYcCU2wzkt3HhlzFmzehn5AuJ364mNmVfPfXwwV6khOMqR90uX2iXN7Bb8T1FeQ1XJAso5RUihHR2Kt6S3D70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQpnrYhTUriUSgWguVYDzRX3UuPp7k+rpIOSik/qfkHkoEVg1
	dntbHluAao7mgSGvzDA+1HD5482buFpqRtZkL2FMVNRKjNY5WV0UGAs1
X-Gm-Gg: ASbGncs/TAz2H5kd4Pft2F9gLY0xf2L08Av8DYX8jqerwMO1MmwI5mDlR6QdwpK79Vs
	HkpsfNLPGtaZi9GhWoQ0WeTgLQDEm/iqs2iFTvs02p+Hesi73k/VA4ZdnzJt6Uy5kJCwMETXG3+
	SY2EkgPSnP3mNGk1Q5lcdRXrPc5k9bQXKL3lalVl68jVrOxIW+hCAo/p07i8nVKKwwj1nVqM616
	6fB0zsMaWDkpbisHnkcEhAljE1upOx3rqY+4M/DGX/AVXDTAxbCshSSFb4Qai0AB+oZWN3EMIpN
	ZjbxpHqQpYNseq7EFnBuZgkcFOYGry8tdp8ZwHfqLK7AG+Hj4TvulTgSVieessGqO3y/6w4TOoq
	gq9e9s17Y8KCIZ5VzoKfUbJGONXeWigw=
X-Google-Smtp-Source: AGHT+IF89HPh/W7gp3tyZa5ClRJdNdBTtpXKZrbEusjQ0tOtn6D/ZUDJbY4LvRTCQajkSfbWR5bnoA==
X-Received: by 2002:a05:600c:4f4a:b0:45b:8a0e:cdbf with SMTP id 5b1f17b1804b1-45b8a0ece70mr40139155e9.1.1756717890322;
        Mon, 01 Sep 2025 02:11:30 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d60d93b949sm4451045f8f.2.2025.09.01.02.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:11:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: andy.yan@rock-chips.com,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/bridge: synopsys: Fix spelling mistake "pixeel" -> "pixel"
Date: Mon,  1 Sep 2025 10:10:44 +0100
Message-ID: <20250901091044.2450367-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 9bbfe8da3de0..d9b9739ae3d0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1554,7 +1554,7 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 
 	if ((adjusted_mode->hsync_start - adjusted_mode->hdisplay) & 0x1) {
 		adjusted_mode->hsync_start += 1;
-		dev_warn(dp->dev, "hfp is not 2 pixeel aligned, fixup to aligned hfp\n");
+		dev_warn(dp->dev, "hfp is not 2 pixel aligned, fixup to aligned hfp\n");
 	}
 
 	if (adjusted_mode->hsync_end - adjusted_mode->hsync_start < min_hsync) {
-- 
2.51.0


