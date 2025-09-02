Return-Path: <linux-kernel+bounces-797453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B02B410A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEF11B64010
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793126B2CE;
	Tue,  2 Sep 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIDtRLq5"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE623B0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855128; cv=none; b=gnzQXvSWefTnkO1INep6+DHv3Ibbpqrf/Lcup2Hai6oFQ6QXGAwww+9937xcV51YKG84JglHvGi8hoLacaCBjdIzn/28F4rbMpYhSYUJD7lk9EC0zlVvJruFkIi//NhPCFtGS1kBBxOv3CyaCyDOVdvdW9Yy2whFxvv9izhNJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855128; c=relaxed/simple;
	bh=DHIRcSjNYkkeZal2/Ftm/kW4UH9+qxeio7IeA0GLikk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FVZto/WbHZC2lkI/LzKf3VotflGznq+xdx7pSWfVWS03CxUYY3uZoSj0nrWsKZ231Fe2URhJF7kz0TcdgkBPlIxR34PQkNMF6guenSKxR9lQN+RAQPjo93+pFyoOm1blzMBsGLjERCuou/m0jZ/EtPhjtL3enGFV7l0Wyu15D6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIDtRLq5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f7c0fb972so2830624e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756855125; x=1757459925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9kwXaFbFvlFQupGQX/BTa51kbFae7eaQ90Po3EqnDpo=;
        b=FIDtRLq5hKHpl3RDemNnu40u+FYwnZx26eg4X/dLXyVZDEA5bd3gzTfry7GX8KAf3h
         QjTViycgta+7pdu9cLNJnmWirhPW2Ak8mBK7kAY0PhPEQGq6gJsQOcI0KBy0mqiGoYD/
         1uSPKeoWSHk0XCtq8dcGE0ybawUhenht2GF9FWauE9V/5JsfRavtNTcc49jVRH4YlJVG
         P4mArSsQu9Ru0dNTBKDxkFSot3w73rj/H62XU8dnL/SWK1TcSW6DNgQtjjZsfLBf7D4E
         93nYtLFybhKneKacNHiGtsqmfRy4NhrEFeE9Dl75Jdlk9ZkQroaex9PjGHqRr8u1Jh47
         uRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756855125; x=1757459925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kwXaFbFvlFQupGQX/BTa51kbFae7eaQ90Po3EqnDpo=;
        b=aEY/j7/COgN/yKc89qJ2GTvKlubW66U4PBaUY107+F4VIhGQb+crWE05UjyRmcb/J+
         dPhQPzAdZBIYDLb69beI3b72rbgRt7V5qn1pjZiYHwXise69wvQXS3Sl1nTMi1YQkK55
         PR2PPHCmAc/T2bea2wxByyzlZprlpY8YMOpIB1F/O3+gm0QB5Y3jPFZqT+eJ8aOaHUmD
         h2/hnu+GvEAy8QJPOMUoV5QMLXGclOCUK64dJMUOp7Jc0mBdsFYjJYbwWiOMVDTBFMZR
         TKohRtu62/8HIfZcfoJutnZfiPHVkyo/vM18SWlDYXicTeD3/xJzCjiNPCID26VsPa4E
         XzQg==
X-Forwarded-Encrypted: i=1; AJvYcCV0lDYRqJOMbkYdgIf/kt3MCednyHzxOgmgwlcddi8R29tUIisb6iAFidwKxFRD2SGaFBjzQLYk83gfdhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJqW75806aSy6LX/OET23fzZQIo1jG12oOjidc91mCuQc45Xj
	qpUJ5lOZi1oIlZUBNINFANcmqpbcNC/2fTqzBf3Q+2mjrPefvQEzSwlz
X-Gm-Gg: ASbGncuT33L7l7scXjOdhm8tRjiadGvWdXes2JE0TNCaiIeJRqVuovDlKNQunVLBCXP
	2jloj+50zyReEdtNDG04ZjLiFQfkmux6ka0KspqfqrwhlzyZ9aCzSuSCpkzMb+4LwTd8ucHzeiG
	t8NLBqf/0LnJC5mDI9oKlaDyPwxLdIqz82kceHYUQ0Dw9WQtUDgWeDzE3XE41P3J2SleeuIu8K+
	ICed7bwQGGeDtqziYNV0Crh1kuzefSiOTDPp+AU71TSt0Zfnf9h8i61u7BGSPsNiYl12C9rGvFQ
	8PW3awfdfxqhUJ4LPmx7VWsslASjQHI1pk97kNVhkAmmLotCcze0O5rDexAN+ohySkQDH5BOlbV
	VHTXMMS+IlidfsZFdY4rTM5MhBzcTA5xz4xg8LxObY0A33RdUnQan8g==
X-Google-Smtp-Source: AGHT+IFHRjeiC4EU9z0f/xmR1Yb8S558zLmext910mqB0q6dsx94jDM34IKWXBfUF5Zz40is5NMW/g==
X-Received: by 2002:a05:6512:6390:b0:55f:5580:e3d1 with SMTP id 2adb3069b0e04-55f709ae969mr3313573e87.47.1756855125092;
        Tue, 02 Sep 2025 16:18:45 -0700 (PDT)
Received: from vovchkir.localdomain ([95.161.221.106])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5608ab5e281sm105674e87.18.2025.09.02.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:18:44 -0700 (PDT)
From: Vladimir Yakovlev <vovchkir@gmail.com>
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: vovchkir@gmail.com
Subject: [PATCH] drm/bridge: lontium-lt9611uxc: disable audio capture for HDMI card
Date: Wed,  3 Sep 2025 02:18:18 +0300
Message-Id: <20250902231821.2943-1-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LT9611UXC only has an I2S input and therefore only an HDMI-TX
audio channel. In this case, the capture channel must be disabled
on the HDMI sound card.

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index b17483f1550c..79feaec77afc 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -562,6 +562,7 @@ static int lt9611uxc_audio_init(struct device *dev, struct lt9611uxc *lt9611uxc)
 	struct hdmi_codec_pdata codec_data = {
 		.ops = &lt9611uxc_codec_ops,
 		.max_i2s_channels = 2,
+		.no_i2s_capture = 1,
 		.i2s = 1,
 		.data = lt9611uxc,
 	};
-- 
2.34.1


