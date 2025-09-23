Return-Path: <linux-kernel+bounces-828742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D0B9554A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C050442A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97802750F6;
	Tue, 23 Sep 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNIQYjoF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97C258CF9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621156; cv=none; b=q4uggLA43G6+tHqaxAMDEeCgNGEawb75Wd695d+55kjM3hwfjWgdOehtBWd14At+pCKWS+PUeS/bMArh3N2WPbXGvPO+3Gd9rKj31xHU6PmyfvicTGvfY1NFahpBTcZ4jHe1OrdNZAooCQkegjkawieJNzOWG2EafXpI535Wuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621156; c=relaxed/simple;
	bh=0BnOPQDELNokGZZYmpRQ1cd8xaZrosaBnpt3/XVY0Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPGaoKnxluL9Ms/eRgpsyWEwAUX64wdTOdD7n9eLd21cZfEoImcl2GSUarEQNBJaq+RwnAvF7ZcZZrDQcmcac5lv9UvpmarJSUMDlh/LogFaD1WsS1PqlouJLoZFfu42CyaRsspDnNtHc1iqapj1RGn+/VgQb5uKOVUX625Y95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNIQYjoF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b303f755aso25303035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758621153; x=1759225953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LY0Z8Ik+ok4lx1moFpVF9A6wNG/8oeWUYiVAkRks1lI=;
        b=gNIQYjoFKSf8E9eM/ivy9Vxl0llSXIQfUtr+3IVKU/htxQZyJILrCaJoCF5jiXNoOW
         29SCLo6R5NK6YxhZYsj0iTKPIUXMlpYLMPojFqRSfHbpoGA6h2apoQ/hZ33c8L2WWTRr
         5ctAnSIW7KthhtCUe9DsHHGPITcGd+Gvm+CfSjL3+1yh+wWA7wF9wB0uyOXUNS4j26Jj
         QXfBE6DflSFY2mWlOLEEmmBs6HERGdZaX+tMKB28Pk4LyDcNAfTdTjfVD0inojmuz7KA
         HN2Oq4oPbqnP14Y5l/RHRo9asGKF1OYN0j34JlEmlMSGawyZ5wqNqcbyp0llHyPmQ8n4
         BdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621153; x=1759225953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY0Z8Ik+ok4lx1moFpVF9A6wNG/8oeWUYiVAkRks1lI=;
        b=sHypRZtbvkOX9e9sQI60XE1I8biJ1TYq53igTiMuh4JuXU6WLAi7uARKKRKRPllz/K
         B4I6ovbSVHKfnWw34lE+1rWAkwjnzmqTT4xEoq2FckHvZmcXEdP65Sq5E5viLh94ML8Z
         dXa0XVm2JD/uV24XXJZrCtwWAeSexVMTYBEBjCf5+7Rv8EfZdZr0Jubic1iUsz9rX66X
         3uv9pXYvJmucVZnK2MwLddm+sp10wix+Tyguf2QpdBxJowl1O/tNxjb0kazNUznrCkRy
         tYSKdnVgGJp3vPCXtLBsM8RfNoimEUYL+KZXV1VE1K3ILfigvuW/3H9WdaMusBp2z4lU
         YJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCV0od3kOM1L4yTY2ffHptQlzSWlYS+Yq9FO/faJ42k26DeyC1abketEt/hPW1aCu8GCMFEAfyikFvBQUs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxDYpEiCcmRFFtgb9C0ZCimS5AkT1uBBtNXVKK6NkFI04yQ+l
	hkID9QrtFtbLzl0MU9T2+jvZugSPgIbHbocLgwOTWxain5gaX++A6lz7
X-Gm-Gg: ASbGncsxYbEJ2b3VLhxdOoGVSXs9FuBA9iB+z5yXlr3qFfWPKXSiiwb4WEVnfJ58mh6
	009vzmZdoAELSQwna/iQDp2eX/VM44Sd+Gdx+xS7MqvEI9DPR+wBkfnY5WgrYhQ7P2Y/eKwg2xT
	h1Ll0CoQTF3eZ+xytkHxfDfNRqm+/gzd5wg7sVU2aclLgLBVLgTUrXHszS64oa31rcVb5ziHTID
	r3U48bCWJBDkk+S+AgfVb031ScgRs1C8OWfL0Ersubf+FmgmWv24WbHXKIaxtcv4IcZjaWsF1Rb
	mLnd2diuhGuViZO7LhwHa+wRNu5GHXMc2GdTfNwSQy0Oxc3uVbnPk6Su2Ikp6PdjVhTmbeQkQ80
	kHkxmBQL6jveFK46VFBeginpyYBupQ4yt1T2OBeMQ6XtC8KPOln4jw/MiYA==
X-Google-Smtp-Source: AGHT+IFsjWmH1yjZS2/W9w+zjAbYKelnR5zFxdIn1q1xM5jD5x8f4Cm37BnIW0kg5YVrR17ICbU27Q==
X-Received: by 2002:a05:600c:1907:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-46e1fb7ab54mr16883045e9.23.1758621153090;
        Tue, 23 Sep 2025 02:52:33 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a5d1:59f5:ca88:d11c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d3ab09b27sm86882985e9.21.2025.09.23.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:52:32 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] lib/string_choices: Add str_assert_deassert() helper
Date: Tue, 23 Sep 2025 10:52:29 +0100
Message-ID: <20250923095229.2149740-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add str_assert_deassert() helper to return "assert" or "deassert"
string literal depending on the boolean argument. Also add the
inversed variant str_deassert_assert().

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,
Note checkpatch complians about adding a new line before the macro
definition. But this is the existing style in this file. So keeping
it as is.
Cheers, Prabhakar
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index a27c87c954ae..ee84087d4b26 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -17,6 +17,12 @@
 
 #include <linux/types.h>
 
+static inline const char *str_assert_deassert(bool v)
+{
+	return v ? "assert" : "deassert";
+}
+#define str_deassert_assert(v)		str_assert_deassert(!(v))
+
 static inline const char *str_enable_disable(bool v)
 {
 	return v ? "enable" : "disable";
-- 
2.51.0


