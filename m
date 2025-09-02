Return-Path: <linux-kernel+bounces-795631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52555B3F596
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CB6205059
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D12E541F;
	Tue,  2 Sep 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0/WgrTO"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037D2E5429
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794831; cv=none; b=ODOYX4mGsl4bASDBtk/XvbHSHjJfCmj5nW0nC+2ALNNdKWv6A6zzbhAlRq8l6c3QJrxvVo5p/MJrpH4HTQsqPN+OkQydF5o67yAzky1BGJSAPg/3jPXJVcxF/6sm2bxHUf/iLl7hKRFSvS4+lXzh4Wn5CuBqMAMQaeTsTKjZmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794831; c=relaxed/simple;
	bh=nc1rQH/rYDotONc1ZBxpg++WUYmfI3UMVOV7TpwVu40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cEOn4C53+TiOQg4SiQuGBnY4PuEVZIdVg0f62oe1/F7wHzY7QBeYsSovScRix4JDPlgNwb9N1VW/MVBC3QeX3PxxEtOdlFQVjgIefgXAeSUwvL8oLSKR3ZrNIb27QH6njSSp/BM++sDUL9uZ9AXZM/sU23cMzKDEjt2kvVFFEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0/WgrTO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3cf48ec9fa4so2590415f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794828; x=1757399628; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amLWctIAuH5+/Kdk4fBpM4tmLqupAEviAibXHUsY0lc=;
        b=m0/WgrTO1BQscX/cyACNxSxbnz/ubCo8FAVm6qRaVJrcwpT4uKGtl2APTSllg54268
         UK63s4N0eQLgF/8P1JaFAUSoCzilxJylU7z3WQphizthMEfeNhuzKvp0jfVCuUd909PP
         5tFWKOSPKC40nsASz+NbIynews6SZYetBYwBBdG8Eo2v9z8UcOOf8MRYz+SinSEijcQp
         tDmTqQP4kNBdD6MptsaPKemt+FzkUG+4vlT77xKk76pzdUxqb+FelP6YcPwnBzttak4e
         xkFfVIgMo4MgFaicLO4zbMkNn+XmqDQa/rQFWamHEdObndg8WLdH/vH5nqhe8pIrwdiP
         wiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794828; x=1757399628;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amLWctIAuH5+/Kdk4fBpM4tmLqupAEviAibXHUsY0lc=;
        b=uQy8T2EkirozBY2VXxdhGe6lxwPlv2xSiKSGTgm2L/T/AcYm2q3TNuzFaxCLNuLUgA
         EyXpVQPd7Nia5QKQeV3yOLkg6NJQpGRMukhgxqHwKKjQgX+ApCQgOUjE1H+sSxNsAoGf
         HMAq3m4vWLMXke6nr3JU+y6XwXPXASWgpzWKSbqwwL2fwv2UgZNHzRBMtbr93nvqul6g
         COjmc7JJ9WX84C1Nv8aIODy5xoz6U0oQtG4bBQCQGlLF66CBghJmCg1XDzDqryv7GaCt
         Ysh+Hn2kNkd7RbtecdvW/s6Spdd5KZuViy8fSElj+rlTahl1jGs25umORbLPfLc2ZvMi
         Acaw==
X-Forwarded-Encrypted: i=1; AJvYcCU3B43Fks3GSGvCRDtH564YNuMQjAMyjGgTpOmcihj2YkgM2yv/nybgwfjAYv0ypZ0r3Yvj4ut6D0V8SHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIHb9o9vtoBfmXd9hQNE6ANZnjQTAYU7YiZnIF5V5ogzov0cM
	tUdZ/xTFWC4Ps3qarQw5Ea1I74/DCAx+lHsWqdOPkkuNi5DnVI2oYzyt0styRTZVjQo=
X-Gm-Gg: ASbGncvdISkRdGFGMXq7U3lTdPS7Bexnptlr6Bh8oNo8/lgBeU9yMEoo4Bpi7M1QMy8
	lZcT0YjaKuJUzQpERPNYAJavb4OiyMxCNpoJEP2xS+RDEEsBro3JBPvbJ4ICV93pzjsZdIyBeRw
	TgN+VpD0MGi16ojmfZhPrQU7VWHti9cUJju+kjZg9+xJ5VrDmfhE89k1NvrAaiH+jsy8nLIJvw8
	9effkdUBuZahGDD/CaJq1oHwY30oiUb0cgD7xKo5ATaJ8+0Sh27K85WVDeh0lN/0NSpJrekQEZ7
	eLOV4OH2270u6caI4ENGJCBXrxCRuvtVfNzt7PGX6ChYrYPCLN5g8w78uuUc45KEOqct06TVO46
	bozQz6YGBiVNvCONb0Vsd0PNihOI=
X-Google-Smtp-Source: AGHT+IHTaBzwQXFABXTkZLj+3H8VXua+1cr4mYcGe2aPMJa4T/6ZSD/WOz5v96oWEJ77tcsJ6WdpaQ==
X-Received: by 2002:a05:6000:18a3:b0:3ce:ea71:29bc with SMTP id ffacd0b85a97d-3d1de4bb61amr8138742f8f.33.1756794828243;
        Mon, 01 Sep 2025 23:33:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e7d23b7sm183255365e9.1.2025.09.01.23.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:33:47 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:33:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/bridge: synopsys: Fix an error return in
 dw_dp_video_need_vsc_sdp()
Message-ID: <aLaPyJrFsSFuqC1R@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This dw_dp_video_need_vsc_sdp() function is type bool so returning
-EINVAL means returning true.  Return false instead.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 9bbfe8da3de0..33be4eae2b20 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1149,7 +1149,7 @@ static bool dw_dp_video_need_vsc_sdp(struct dw_dp *dp)
 
 	state = dw_dp_get_bridge_state(dp);
 	if (!state)
-		return -EINVAL;
+		return false;
 
 	if (!link->vsc_sdp_supported)
 		return false;
-- 
2.47.2


