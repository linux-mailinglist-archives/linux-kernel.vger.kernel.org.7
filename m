Return-Path: <linux-kernel+bounces-814937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68564B55AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B62AC1F98
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3638FB9;
	Sat, 13 Sep 2025 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjMjPVac"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30401BC2A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722922; cv=none; b=BA/IAU6NIXFxDSCjJM1KR6SxID4RmPnofHoXu5TcCzm8m/NE8xtNzZE4BPhialpChew8qqLYCBXIfaN/6fKys2Dh9xGuIKvcsvWShkVYzqL2dOx1qq7tx4wadNzRVLLcYQF9GgwZgLQL+PsgALkdlgEJ8gmudJMEmqE1RB7XXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722922; c=relaxed/simple;
	bh=dT7fUD4yDpJecyQix7xo4zndYT0BdYTpZJTgjD9NMtU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkUpE+eohkBo7rwoOAUxE3ajHsy5Rxgj/pX87s7KuVnPEtgNjWvVGia23x2eTfQcQBJL2cMsVzAJ/6eJA5iQX9O2YQM85DXJXASru3COMz9kjJ5FSdi1/hLUQE0fvzNWwo2VdvW5IgRHmwuNgaPjxVkmsyolthMy7GMXkiO//Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjMjPVac; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2570bf6058aso32870145ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757722920; x=1758327720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1c3CBG/NboBfPVJVTzHzXXMWP+/wIvK4O9TlNT+vRDg=;
        b=jjMjPVacX1zy5EUyMfqHGH/qciQLXqXoJldm/elvuFs5Z+qnBfstrBGboK4Nii79cR
         xEcd3LUEPTWm2ZaVRkYxmsFmQXXv1Z1KIPa9b24muVIkKkzIaRCm1r9Ei1eg6JgtyCFj
         itZt/8uy0hjLAGupiLRin/HO685F4bwHs3cONaQO7w8/waniWlkT2BdEgbhtJsfCYruH
         Eei/ce4WMvtUqvg45DGTHQ0rCEk2w8XUK57sIMcC1iNW474l0r7WxpCpNXykfi0Pk5Yi
         j2ZsCLhtSsi1jEnx2rY1jUb639KGs88BeKFxKka0dfI4s5vl/IWF3WHdvRKcXkTjOB8M
         KlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722920; x=1758327720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1c3CBG/NboBfPVJVTzHzXXMWP+/wIvK4O9TlNT+vRDg=;
        b=wEQBV0QA0m4VkG4QW4R00hxQRnqghaOfK6GEUo1GKC8LKrg0ccIM6Dq7J5IT8X7VBM
         8jlK3fb+OhO+kTVsuojmLKbB/ePR4xDSwi9jxHk24kMW8cZKkPnBhK472wV5JDwViRNn
         fRwGc3sqQQf6SKWmOoNTzX+XQLKx5cHbG31zYVAN7xaz9Hk5kJtMHrd96WNuJGDc6OuX
         LY8KKexYUKgPQwACng07iQ9mXrTFED2Ys2qCrKnW/C3VR6asIw6qEDRMt4+ETFvkDry+
         5gBcaJVnhcna3Sk30sGzLNKqvi5s0lVs4IlPG4TghJhFF0Bu+hK8w8xOUQy0gNe7uKWE
         2RmA==
X-Forwarded-Encrypted: i=1; AJvYcCWf/fxGvg1yuFtEEhyLCTpLi/B17BDqs1FvBoqgKO3qu+Eqg6BBk6JZJHlnosWMTRpxmlmQ7gT8A2q8JLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2eBUu8DxV0GEjJ0qQObOQNkCbbcY2bfhQI8wm5fGMqQacD6Vy
	0QtKZci+evSTdQpc5zPX/Tma9dzcwTzqYOII/tpclA7e31TpX1nEIAme
X-Gm-Gg: ASbGncuBDkQ+r6tG51dHcCrm1AwTeJSc6dhj3fnGgBnPEktMGsUIaQcAFzwd8pBWuEj
	tffBklaUdr4I7pr3ZEPIYh2Il8ewoZOkUoH6Vp9Oz/g16waByv+F3YmoZFd1AkijfP/YWUIyuLc
	OBnU8By9hK1dELa6LaDjEaBRJFXGhb1wETnVdLvnfiUFT1B1gIB7T/5Sfm199K7gzOkerG298lp
	UF2HwpKufhAnq70vKmHOrL2d9c5/1dq4pDMMgy8neMrIUa7l88UdzXlJrMjig3dvs9SoWyT9Qwx
	/7v4h3SQ95nX680kZCrfx2CSHF7ZYNFSbrysW2WAcjBvS7j5GLt9R+PytXhVoTCdTIWVPfqtAT0
	ahG+vKJ8LJ+8cnK3wkHlU+t+4zFDz5bTdnf4yhTKqUBfo/nTr59WYOP91rEbXi9t3od15KUjX6z
	Z75ok3cgz53Q==
X-Google-Smtp-Source: AGHT+IF+nK5Fq9ofZfzYEh11WCYZrbZLJT0mADN5dCYbpAjIJMEjmIB/u1gmzzXb0gcqRVsJ1Y5rMg==
X-Received: by 2002:a17:902:f78f:b0:248:79d4:93a9 with SMTP id d9443c01a7336-25d2713422dmr52089335ad.55.1757722920172;
        Fri, 12 Sep 2025 17:22:00 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25c37294b4fsm59866135ad.34.2025.09.12.17.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 17:21:59 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196 compatible
Date: Fri, 12 Sep 2025 17:21:54 -0700
Message-ID: <20250913002155.1163908-2-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250913002155.1163908-1-olvaffe@gmail.com>
References: <20250913002155.1163908-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek MT8196 has Mali-G925-Immortalis GPU. panthor drm driver gained
support for it recently.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

---
v2: update commit message
---
 Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index a5b4e00217587..7ad5a3ffc5f5c 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt8196-mali
               - rockchip,rk3588-mali
           - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
 
-- 
2.51.0.384.g4c02a37b29-goog


