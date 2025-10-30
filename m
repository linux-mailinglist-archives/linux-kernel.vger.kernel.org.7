Return-Path: <linux-kernel+bounces-877927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4897EC1F5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE493A3C60
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636034405D;
	Thu, 30 Oct 2025 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="QRKxApUr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D2344045
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817484; cv=none; b=kS5qqEPbLMzBGHJzWzXKFYSsOqz2Vc3PAfZKzPuE9g7b5nH8nf+Wryk0K4FpJ7OhkiJ9XEc7t26X+XpB/RAgMiXUuSnRvxvo1U1ym27v62uK8xqKDdOD+7tXs+10/NQZDkY4LxEl325RcZTox7xkTs8/bsAUsdSLLMRqceNz9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817484; c=relaxed/simple;
	bh=p0kXNgeMoGwWo0q1Nw9glAh2ZK/zdM5MygFl5xFS5F4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iiCEgTRMLcX0lHU6Qkr8M03+grf380UAvBXDAanBnMcfsCU2el2HQG59Xv7XujUISjV5huSlfk9hk8il9eDyqlLG/bsDKaO7qKCr61NF6cBcRIVfxGMT5CZg9M0DyCr1crE0TncxkXiIJtMha//QWGFRxcTxiGP9/qIkYqgtVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=QRKxApUr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-294df925292so6983235ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761817481; x=1762422281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUMWN07GOm3UETuex7a4WdCXyC4g5BU9lI+5N7mCsWI=;
        b=QRKxApUrwqP5Lucf/KS+AHlxWLgXR5bZBHP5Bg71B7+hVNbRu/TwcwECKLd+HztTyn
         c8pH+n/u2rc7KxzcgEQwoQwWe672jN9ppQpRpGJ6ZOdpSbIip+tWTSq7byOutNkk3OVY
         ajRt46lXq6gIQivULRXE7kDPItYE6j0m23J1varUw2BNppLtCl033mWht0hcbWhsKAgH
         lJ9BzdE7XEyo83TJ59p8K3k9xaBcoBTVCLNtrsZlynG/v14YZuS0gUvwBeVuRcZF/89q
         BOhfjeyXGSiNQ2c8EhtO5VPEXu/04KiWBN61U3/jiFJtOpnkc/+MH2yrzO3D0Y2ZAJFm
         JjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817481; x=1762422281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUMWN07GOm3UETuex7a4WdCXyC4g5BU9lI+5N7mCsWI=;
        b=w07Gbv17LIiAmGPewtmHzzJ76m/pshpZwaOfZb4ZZlDfHZfRVQTCIRuHqRLQXZQ9E9
         RN5cEIAYJfy9H1UJmjrl+oMtHTdDo/qob0CUUO5uO/XP9Q+CyFtXNB9Q77k5pOdZqvSy
         Ppma0VGNGMQKL0EqqNh3kqg52mZ1hi6DCZVhshzPDVfWKSP0yX6P8pns9ps1Hgq9/Yi7
         qK6Cq5Ec0ntLBsURohISXf7Lp98OudhlPua6f8LvA9Bj4Wuqd3zZ3I+4G8v5YWLt0gCd
         jvv+3jcK/JzBpYzqxZQ7r9ANz1LwewQOscVhZWt1EqqOZMaeTecpkq1BfD7gnEmp3oL8
         LotQ==
X-Gm-Message-State: AOJu0YyX2pK6Ayc1XLcF+iAXP0WLViVNRIyawOlbc6zO3//bsoLjUIro
	+v0cNdmF54bUii1E/FSsVNEV07JQfNjvA9i6nal7QnhRrS4IFetmujYdRWx5AqqP3TTXeKa0qyX
	H+SFEI0YojQ==
X-Gm-Gg: ASbGnctUW96CgIpPsy/BB3W3gsA5TRqIS+rSUnp27byFtZQ0ls5zsjWaiN6nIvsc81T
	re5eXRB8aQQ7i5kfcoGwtmaNWVeN7NHj77rMw4o9zv7gPyk+pTE2ulYogVUy/1oimcZ6GuUscOJ
	Bl2C8fYQi71eCO1RumMxRdEVB4q9NKKKF8bOIFET+UFqPGLqa8jJb5hymbtQWpW+p1bnF9UPQ+Y
	dxI3qBniLi0bje1AqKpmIQLEffEFhL6QrszGKUo/iGJlt2dLWy4tyMR8T+rkauebmvpt+LwSaWp
	1q1oXeeiMArSQQ1jc3+zlfSvufZCW2mB+ZxPPfc2os9nz2n42I2ca1ni9yJZFs1Sz8WQhhFDmoN
	dWpXvaPb7sETOrBj/mFuZEqT3C4Z+S3D2jbKHJw3lrK2Sx4rVpmZeFr0VZ+4SXRXwvwY0jeGpeh
	yVxDEjVLRa1ygmg358SIs39jt0IAQAqQQJhzS2/FVcNbw7PPhfM4deIKJGbrTxstbhWwKMpvUds
	xDjOA==
X-Google-Smtp-Source: AGHT+IGRBRkOmZGPU5EMzd9TgaTueUJvpQPPnxjEI1ZcWRlqn8hhOpa3io65WaXAJwks1FNKf4aGTw==
X-Received: by 2002:a17:903:234d:b0:290:7e29:f59f with SMTP id d9443c01a7336-294dee60875mr73492425ad.27.1761817481234;
        Thu, 30 Oct 2025 02:44:41 -0700 (PDT)
Received: from localhost.localdomain (61-219-175-100.hinet-ip.hinet.net. [61.219.175.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d26c13sm179027625ad.53.2025.10.30.02.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:44:40 -0700 (PDT)
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Subject: [PATCH v1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
Date: Thu, 30 Oct 2025 17:44:34 +0800
Message-Id: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sharp LQ116M1JW105 reports that it supports 8 bpc modes,
but it will happen display noise in some videos.
So, limit it to 6 bpc modes.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e2e85345aa9a..a73d37fe7ea1 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -250,6 +250,9 @@ static const struct edid_quirk {
 	EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),
 
+	/* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 bpc */
+	EDID_QUIRK('S', 'H', 'P', 0x154c, EDID_QUIRK_FORCE_6BPC),
+
 	/*
 	 * @drm_edid_internal_quirk entries end here, following with the
 	 * @drm_edid_quirk entries.
-- 
2.25.1


