Return-Path: <linux-kernel+bounces-783540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C67B32ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13AE17A298
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ACA265CB2;
	Sun, 24 Aug 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4QLhGvl"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C019E81F;
	Sun, 24 Aug 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027661; cv=none; b=qZMQvt5++x3eDh19uC8qNzkhb3SDQe1P+PmpnffZXkiLWYU3VQ80W3hz+U++vTrkwJyJg+rmQT7wOxLqYZTxnMJ90mWdoKWX5Hq36Fyvx4JBXhaSx7svxEAhzvKsH+9YSGQbuAjl5zyNbMNHtrZBHbp8GjrW5lGYWS/K+BEii4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027661; c=relaxed/simple;
	bh=Yjs5VELuXzugavuZ2MYDFB7lDyQ6YMgi2xeSBBjSkdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyP8KwDYL2pxsBytBea3FDSklkLsNEwQxK2uGfuY2JSjnw8dd81AZi3pntKiCgKQzD6mdoqiVRccW8GgViw2oDoH1DwPQs8pNbs/1SBAwbTtEXn84eMR/zS2DUaYDdd+sLL/lyxQPpex6opNBna7Y+24LHWU5xZqFxi4ciE3lrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4QLhGvl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c638ab6c9so15611a12.1;
        Sun, 24 Aug 2025 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756027657; x=1756632457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZbRg4EAl+//ILxj7dao5FHZeWZVMErRSC6VDwPgGXM=;
        b=X4QLhGvlObVcYH3JSTdXzEYpvtx3o+V/5yrpaKknyAuEYqs8zVYBW44Eucs/yMj4C4
         Tv8erU1JNzPRnkfRGbT/cqYuqYc94gXdQlo6nOeL+mGUHCEP1O2C2gbCuZaJbk1VT5xn
         1EiZdo1/RlVu/mzhbmwMoT9xrGn+o1V0jIjVxjmW1A5XEc/sah+dEyVFt8wzDCVV4jKl
         YeeWLrHcK2nVLyt8WQqRDrV/rR6Au18zT/TXXEzBk7zH2wENawufAEVxSsyndj1fbuDR
         +QM8M7lXq/ahZ0ru4+8m5BcF0+i1dzNuBn/4yhVlWMwLNxkvbwjOrI+zWpQrAzV2Yp8W
         XjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756027657; x=1756632457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZbRg4EAl+//ILxj7dao5FHZeWZVMErRSC6VDwPgGXM=;
        b=AZOi0RTLFgHX7xJAvRAHuYH/pf1VsP/bSnLHE6S8KKE8Ra/z7rfTa52ph1Tg8fsyjT
         aUzQPFByo0rQIZrGBKbPyEbmjBi/2Hk0LEdnVJnqcg3CPaCfX/RmPfR3TEtusByJvon7
         qYRw+gdpqq0ycjQboT8FVPnrx26mH45yB2UURn+owhTgo+S1E8j4MIrhFE1qM4CySO1j
         Ddw2dNkdL+lCmCooLONO9WZGKcvP4pyKzilkPalNbQwQonhBtHCRqB/47TiQHhRprF+D
         ZnRVkJ2m+t+tWGRK77CX8l+dfRjwoA0g/zKDXI6ES9dwTytFxqevJs/uCgVRoRa6yt2u
         LSRA==
X-Forwarded-Encrypted: i=1; AJvYcCV/PAvhsTY+hY3uX4e6gkpik/Gkc73UjLbQRssjYn/SEKgq/X+B1UBA4WPMOOJnY1lTsW4fcJqPvRTdQVkx@vger.kernel.org, AJvYcCXNtVhFFlJvR/NDE1YdazrT58A+UorcIn5yPlM8Cb2A8EHrWrRKknM/jlJst1O1+pV1+uKJig1u1lrR@vger.kernel.org
X-Gm-Message-State: AOJu0YxV999rKk//PVsf2n2O5gPoHOhNGTsnR4n652ZsKwhqhyiHKe0T
	2eYSJmVx4wF+meOu00aM+eRu70cNUSFX5wbs6VF61qHQGtuo4c8btUVp
X-Gm-Gg: ASbGnct5lDEe/M9GqBRqwLtFD8Lxce8C/t95Nlz7/wn5Csg2+rEu3ZLGugfA5zPzl8p
	xDXTcJZts83rQqLOgBgH6GNOoeIsadcX5f6lgSZmjy16eTZueC2pg8zW4xbI11GU6WugVBqV3UU
	/8Ai6iudHnl80onGMHc2+imfB212NOJtl/bhI29c0TH56gTxt54OC8sv+5Kj5Ix3z+KJZvENWbd
	XXO0RVLc9HIgy1eegKgcXTGEoYO1Le1cSdziKJ900sH7YE34XfaX9EsJnj9myOXJPI64W+DeU0M
	joEKcKMuUzhJ3lNLkpOyIHrfd9evzc+HCStzCPxBVwBYlGphO8pt4NSuKIJxqg/GoSW+Uh5MiY1
	RGnOFxQrgIpcpfg==
X-Google-Smtp-Source: AGHT+IHm3C4SB26ld3hs/ov0b0LmAoYAAxWshjWqcnq1DJJdqforuWTyDnkwgGX6h1mxJDWddM+Vlg==
X-Received: by 2002:a05:6402:46cf:b0:618:229d:707b with SMTP id 4fb4d7f45d1cf-61c1b45c5a8mr6244590a12.1.1756027657455;
        Sun, 24 Aug 2025 02:27:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c316f503dsm3035391a12.31.2025.08.24.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:27:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
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
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3 RESEND] dt-bindings: display: extend the LVDS codec with Triple 10-BIT LVDS Transmitter
Date: Sun, 24 Aug 2025 12:27:26 +0300
Message-ID: <20250824092728.105643-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250824092728.105643-1-clamor95@gmail.com>
References: <20250824092728.105643-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Heidelberg <david@ixit.cz>

LVDS transmitter used in the Microsoft Surface RT.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 6ceeed76e88e..24e89c1d0c76 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -33,6 +33,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - idt,v103      # For the Triple 10-BIT LVDS Transmitter
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
               - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
-- 
2.43.0


