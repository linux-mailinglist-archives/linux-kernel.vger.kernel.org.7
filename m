Return-Path: <linux-kernel+bounces-734743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A1B085A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4FA7AFE52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75DC218AC4;
	Thu, 17 Jul 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="KNC0WW5l"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E25219A79
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735493; cv=none; b=KSEHFD3ja6J4MZQBkUiaC0NsxokO7FKUZuzFpEoUoWV0cz8+Rfl7FdwWlTUrBf7jNwri+PNcMq8KnU4dJC0L3vD7nKAjU24cCjh8B51yS5Fs4XVjMnGSllyPGDSrd5VM8mm/DYON+r24b/z9VXbirsNoGNO/oRwExXBcBBveN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735493; c=relaxed/simple;
	bh=Q+ZY9xjBuqQxqenQY7jqiguWkAzHexyUMMWNBcg78x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl9B5vv3q3XXgvXtw0a5ZN/mmoOLtSwQ0GZE4otFqXdgt8HIIkJFJHsrRGOLvP7GQ66afKwBgrNRjppepnV74OCyE3g5cfIoMF7A2WYWTXNTt0iCAofE6PUn3MQD2LT89zX2HBMTUWaQgckpgq4wasrxyfiGr4X9h8pAV2Iq8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=KNC0WW5l; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b52bf417cso490244b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752735491; x=1753340291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRMZHukFq/Fz1BxRKYe9su1Usquvr1NXauedg+WKKBk=;
        b=KNC0WW5lKIGiProZ89bpfgdUA9WMenmyuuHPj81FuCYn7dlxTTePY8kAgQivRCgfYV
         w7SLa7HgTzCsnL81WydF4NvdXVicO8syIsyniyWJkAqattprtTN03sbZU/tqay18ZKZ9
         b6Ljnr14nIxWhRQLLK3dqpUzy7yzlFFxGRdNf5TjT0F9Xt+dg2VHcwivfsgvzplYWqWY
         KwbSBnqzneBn07Po7H6rYbnXPmBXOAU9TolXEP3vWxwhkO6Y+6vcaH4LhsrPYEIeOWrm
         j1O/Xw+hC2ZF+CO+yecPNfURVN5jPi252lshtepCpsF9YllcpLpwbwsbj85b/GQCFAZo
         Y8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735491; x=1753340291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRMZHukFq/Fz1BxRKYe9su1Usquvr1NXauedg+WKKBk=;
        b=u8Rvr49IPTidp2ZlFUowrPDcgn2kQYkW5d/8bWlr6DkwP8CPpRQzQnPHbh1zxS/Pq3
         XoU8L/Xt6dK/QVpUJrqqDOYJnxKrwLI08XpOdvUzi5P6G5q+aknfx4PRrQOcp3Ak/fQw
         ecigxELek9CpO+WKW7kK9fk0rmifMb1XwkxuNka4I7dHspImyDB79j6iOz5ifrEq3szq
         NrcWPPuvO+NQTo7H0WzUE9i4VcHjLWVaJDm1B3u+xQIs6P7/cuSlCGGifDLiP2OXKA2I
         7Cl5NgZzLNWZNXQi1U2GMZ0/kXGixHq/mTi1/AnzVzPKKiq6ZT+7YVyt0kbod9a5trVz
         2p6w==
X-Forwarded-Encrypted: i=1; AJvYcCWO5AirrRm4BOJLfHoZ5TB5wYPkWW1HrhBMmz/DEOQOG36md8bIGOysgfZu8Ttu454g/3AMfS8Ul9Yw/OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMx2XWe1Y1lIk0utuPSClipjjQBw8v0GwQKrh+2CXfEYVM4uZZ
	XW0Y6UzATD3nntcUeSIQie4KiedsupiynoCWduOOBNzc3V7avpcJFWGRUh/aTZUDnxQ=
X-Gm-Gg: ASbGncsN/mNcocrh2iW2N8GMex2ABpruJCck1sCCbDp8qPQumnro6bTqIUeJk5pANj1
	NjjgbScqiiNLPPW7n/62ME3Vnbx4ldemJuwTDLabmpLLu7/cX0GvR6y6xwyqCcAcT6dIQ5/k4RV
	YlQtRJMsFCO1nsO82u4kCqqntWjfTc/Dw+j0YoIAIS60F3RRDB4l4qBzuh4teyo1efC5r3M3jXm
	m3D6tcYU8ifpe8N2ux56fPZa2odz985cglkouTtktHUvRN71w91aDH1/7BjeMMnS1wL0VBQRkem
	EF41FiNTfNp8WJHlyVvZwJaNtpdKrSX4MKuubHmNDeIjBeqtMWu+XvGoakuEpgvrdjU3L2PvlQr
	H8gd5z3eck64rvsEgK2DVnFgt2W0wznh0vAIB/2JLzB9NrTcTMXNWYw==
X-Google-Smtp-Source: AGHT+IEliMbgtuTCQXNVVOMflDMHgY0pux0knysFK+gpotQ655Tfx39EtFZBf6v78DQtGzuRTvmzQw==
X-Received: by 2002:a05:6a00:170d:b0:748:2eb7:8cc7 with SMTP id d2e1a72fcca58-75724677639mr7982430b3a.21.1752735490724;
        Wed, 16 Jul 2025 23:58:10 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4bc51sm15157293b3a.116.2025.07.16.23.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:58:10 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	diogo.ivo@tecnico.ulisboa.pt,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v3 1/4] drm: Create mipi_dsi_dual macro
Date: Thu, 17 Jul 2025 00:57:53 -0600
Message-ID: <20250717065757.246122-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250717065757.246122-1-me@brighamcampbell.com>
References: <20250717065757.246122-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create mipi_dsi_dual macro for panels which are driven by two parallel
serial interfaces. This allows for the reduction of code duplication in
drivers for these panels.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---

In case it's not obvious, the indirection between mipi_dsi_dual and
_mipi_dsi_dual is meant to allow for the expansion of _func in the case
that _func is also a macro.

 include/drm/drm_mipi_dsi.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 369b0d8830c3..32da8861f9de 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -431,6 +431,30 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
 		mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
 	} while (0)
 
+/**
+ * mipi_dsi_dual - send the same MIPI DSI command to two interfaces
+ *
+ * This macro will send the specified MIPI DSI command twice, once per each of
+ * the two interfaces supplied. This is useful for reducing duplication of code
+ * in panel drivers which use two parallel serial interfaces.
+ *
+ * @_func: MIPI DSI function or macro to pass context and arguments into
+ * @_dsi1: First DSI interface to act as recipient of the MIPI DSI command
+ * @_dsi2: Second DSI interface to act as recipient of the MIPI DSI command
+ * @_ctx: Context for multiple DSI transactions
+ * @...: Arguments to pass to MIPI DSI function or macro
+ */
+#define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...) 		 \
+	_mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ##__VA_ARGS__)
+
+#define _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...) \
+	do {					       \
+		(_ctx)->dsi = (_dsi1);		       \
+		_func((_ctx), ##__VA_ARGS__);	       \
+		(_ctx)->dsi = (_dsi2);		       \
+		_func((_ctx), ##__VA_ARGS__);	       \
+	} while (0)
+
 /**
  * struct mipi_dsi_driver - DSI driver
  * @driver: device driver model driver
-- 
2.49.0


