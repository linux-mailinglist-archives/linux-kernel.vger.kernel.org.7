Return-Path: <linux-kernel+bounces-881101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A363C2775C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 05:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06AC634CCD3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 04:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F951F09AC;
	Sat,  1 Nov 2025 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="KTvNTpCn"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A951022
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969667; cv=none; b=cl5aIUSijNK4426JxJ6e7vP8ROmUgzrkMk4HVNJU/xstJ7zkIIIVtCYgaOk9W7iJuPG/s293OdkmYVsEo9Qa++epmhk6fgwdd+uIWMFqYnpQLv2oZoy2JMl5iVJ7swgCfwuwCXuS6xU5/752zlBrSWxSEOJM9fw9P90Ez0p+ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969667; c=relaxed/simple;
	bh=f3tRwY94wYfkGc/suijZkyKN4hKH9sRRpObMAYHy1i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=INxUWeT902hyNghwwRjgQuqWFOYIvi7F80dNg6fEyN+XMVazHxdVzeIFsVFDRqxGLoNLT1hQ2mPrTJ902jtRIE0lfGN4Snx2IwHf061NcGey2b1UPcOcC0jUgYFkwiMK/nttlD7FoSM/pREb7KEkA7SCbmUOz0zHN95xBtluvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=KTvNTpCn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso2311335a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761969663; x=1762574463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBf5/4PIi/TVU5oxmQ/qOw5ZlkbtFKWT8j+z39lbocw=;
        b=KTvNTpCnqSYMqZqxSF3fLXYVNOeeFJVDqFYI3msMlW1NlUWXvkH167F4sgaLj+5sgQ
         r4raNyI/uIno8LbyIuSqVY35IeLyFTD05gzRk+sUpOxENAgpc92eq7T7Kkb88SXcXIr8
         FHPExIF8Kx2dAi98U5SIhA7AOwTstFcoERtBwwJbB6RpT0+SlhAeTFYqUIy0tyvyJhE2
         laYqGxj5o3g6V4mJfGD0S3kMlIL971TqJ4D/8wRMqR5xgv+Z8lEYJfGhWCjCHN3pkeFZ
         DQO392jyLyEJJvor9wi1Tu1Sk/KUN5Ul+Ibi7uRPmQR9/Gp9kYkugHqKsOijWvomexXP
         /oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969663; x=1762574463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBf5/4PIi/TVU5oxmQ/qOw5ZlkbtFKWT8j+z39lbocw=;
        b=UwcCfxWA85o2wTxsDaNtNIQwhm3T8s4AB2BWodFejfXpjb5RvAVQ6qQaj08rYGSdLm
         J8Id0wWbwHpyPyXAa2sx6erjGo9GnnxF8NQQbOMC1nupYBXLKPZgwl5PyflNTCvJpusV
         b56BcaKui/ELfLiYEroUmngciBtshJTL/sbSUFIU1RTcfc8v4DyxBH2Ly7x+nOgpoQzt
         dudR2XxOT6FCIMKtxp31EYO20luq1tfsOUTalyi726dzTEdK1EZFbsxYgn1MFFAcEN6W
         h7KmD7dVZ82vuUUOzU0aQISns31CQxPQ9b2g4RVOiOcR0lzl7sbHxKgwkuc2vZiNHHIy
         RhJQ==
X-Gm-Message-State: AOJu0YwhcgkSUrb1ErxE0x8YtDZYTf2t/BQ1bAgZS4Z2miX8I5upI8Mx
	mtTWNpB9QGW1PqwtJ8nbxmq2uk86QoozSUHan7tmgOlKFzrc7Eu/vcaPcdiU0lwon+tOSZlTgz8
	XdFIFi1fROg==
X-Gm-Gg: ASbGncubRdNqiG/aTxWCjg3HfQ8pZ5e7WO2jso1MZiO94nlYZToxTUkzCVSTqeKsCrr
	51xFf23F+kPZgotnydrMyUZwQz+aX0lWc5jZRrmo+1T2WJhhzjAu4BHXAdIjJLkMuntc5SJhEKL
	RGmGLGS286hW/d86JLhUmwFloEOK23ZV5Qr38u8BIFLfT2xJLTSTpYQQGGUs1QC/rWyIdi6clMj
	+HZzHNxbHY/qLEJl64Ee52h2idGjAB+KxuKgsq4qCTNNFOGJfLCQiKhOxnTj5Lq9W4jk9EiLJJC
	OexaT3itVscKUat5QeEZ1ChrvEtZ5QfPMJfDB8QkiG3XuUJ7aXOZvU2tQ0EezbQk5nvLd0lXcEY
	kgebjlPGMaIQez9+jE9sEdgVoqCxvEjS0FuQwTZ+lE3rTmxeZtBCSyFHeicxB3Rd1uuhAJJLvdJ
	N3EQM3B0+1Zb8n0Wlzi+Ox/hicW07ZiXRT0aw6ubeyYO+vtE8vFBz0q2AYM/OnDOufcZsnBK2yK
	lzZowfpbf1gc4T/30y+EhBr
X-Google-Smtp-Source: AGHT+IGyIY45gXiMcurK9CvCmQ5ISfIMp4z7rdhImhGAODCiT+xwAiq16dsVlTY0Riz4IkD5f1h19g==
X-Received: by 2002:a17:902:fc85:b0:294:faad:8c80 with SMTP id d9443c01a7336-2951a53f50amr67105715ad.61.1761969662620;
        Fri, 31 Oct 2025 21:01:02 -0700 (PDT)
Received: from ajye-OMEN-by-HP-Laptop-S.compal.com (36-231-161-24.dynamic-ip.hinet.net. [36.231.161.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268b43d7sm40377355ad.35.2025.10.31.21.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:01:02 -0700 (PDT)
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
	jazhan@google.com
Subject: [PATCH v2] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
Date: Sat,  1 Nov 2025 12:00:43 +0800
Message-Id: <20251101040043.3768848-1-ajye_huang@compal.corp-partner.google.com>
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
changes from v1->v2:
* Change EDID_QUIRK_FORCE_6BPC to BIT(EDID_QUIRK_FORCE_6BPC)

 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e2e85345aa9a..26bb7710a462 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -250,6 +250,9 @@ static const struct edid_quirk {
 	EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),
 
+	/* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 bpc */
+	EDID_QUIRK('S', 'H', 'P', 0x154c, BIT(EDID_QUIRK_FORCE_6BPC)),
+
 	/*
 	 * @drm_edid_internal_quirk entries end here, following with the
 	 * @drm_edid_quirk entries.
-- 
2.25.1


