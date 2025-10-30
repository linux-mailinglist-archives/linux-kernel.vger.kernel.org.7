Return-Path: <linux-kernel+bounces-878864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4E2C21A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B33D4EC6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8437DBF7;
	Thu, 30 Oct 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue6HlFbQ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6B375729
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847101; cv=none; b=JNziIBxru9xS61GpKh7UFhOPVeYFNj69XYvnbnCvN/ojeDbeN18FkmyfDPxrnUfPXBVluRKSnHlJhoohpN4xD4gI9dVKJYaoZRAYmMVTF1M8buNKAdMoNFOz5rBYfJfEWJoifKVV/TV2YXvA8+pwenHAQnuijtMvh/GUDDQYfOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847101; c=relaxed/simple;
	bh=h/WB+hR/anHyT+SzoBQFwmDv8A8kpm7m3RVwaDTL2qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LL5taQMjiAWDluCvhXR0l7X/7pVg98wSpmRYVKfiT3UdAyXE9z+GPUVqfnItvIDteREDBuwqeWy297LhnmJb641eU48+QDp41YYjSVGxUu+uKttuYp50s23ix/tNpfcltWTw2n406Ipx5ada8hu/D3TnAfiDvPPa+AzzAMxrq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue6HlFbQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso18065165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847097; x=1762451897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpqM7R8t1LjT1e31UVuLTSZ7tEVjNoHsGLOYlh8Q1Lk=;
        b=Ue6HlFbQ8SrByoyiJdjZKBFdoL7coCuUelTMxyniu0aIjWwOG4v0R/dmqD7/usgFn4
         gKbjDEzzV1gaZdt13CGa4B10ug49ctS9rqbqE6eKGm8XfON4puoWxRX/RkmV0bqFTFU4
         lgrQNLqDUy8xsrlSFwia5d3kbiiH3AaSgRD97ov/ingswzvXA9Ey8F/7vV57X+FSUZqb
         e1dDanbEsFBfOor0bV3g2B8eCjHr+xuATVIV0E7vfS7r2Tgho0IvFBNwbMaObtrWJjLX
         eSBueea+2IUSjhMVbmsk8bi7yXki8tHkkXhwN07U5JHu+AJbwWKdLgFMNDtaKuXROpps
         S2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847097; x=1762451897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpqM7R8t1LjT1e31UVuLTSZ7tEVjNoHsGLOYlh8Q1Lk=;
        b=sAe+O42y0j5F/RnnzIAeyvtoxBJenMJKoWeAgGKDN0u6DbBz0cXlZcRNyfZFKPBwg2
         Dt/SyqQgaHzGLEpBZtwj6Jpr8LGsAum2hvoNNexFocWA7Lz8ln2Y8UXMNRruy7rYi9FS
         z632ItCDZZ1BEmzn9G37eX8GiOpyLyrrQlDp6wfbkist05C0NmgZ+WeJKe51v7bB7YG0
         NUWbU/Mofxpj3eFVmB10oN2xT/A3iTTAWY/OFaU7imx6b7l6XlBVAECmb3kChXQssiSO
         PzXxhmBgViaJdpfaJ75Wo1jpquyoZO1uL7hongcdbx+5gc8T5pRCJprrVZtV4VqeWFIK
         cLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDofgF6jIwo5RcDua5nHq+PUsKrBuwB4xH97ZkCZLBCzoetAPVyR8dNQcgD930X39i5HBd0kAZ0WM+Vfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSJIJY/9r2vqxm+mzjGT9zrLcIRWGL0Ovl0dEPvK1xHjtyFDe
	Ldu3H6vPPPjQ1eiWhtompqY35eR3QVfUlRK/rl9V52hJukqoBB38Hs0Y
X-Gm-Gg: ASbGnctQf2SRF4AMaRKhv5rFlqd0Mqwq6nbHp25fd2pZdLI8yef77cICkqEAEmdFgvE
	Qbw2xocLlpDOxgubM4APSjJ0sTnwjvlmDnpZ/pnrNh2/R9TiA3QCDG3Xju9k2wBZolDre6iivyq
	uIdW5zrOX2xHgDqPgFTLtPmtd4lGbj1xwdLHhL4Ns1O2rbc0TGBo07QCVnJMSV61Srpw40VrdIU
	JIiIQfiW3C3CP8H9l1byWTNmMQwXewlPhWi3+B2Q77k24NCblfNsXdl+XlD2Dhj+BVgK54pc4YG
	ew1/y0NjjyNQQoXdfkl7W6S+OvJu6RgZXNdjKk21pzIIYfEq9cVZe14NADn0VogXKLaltLENdTR
	bsKCBrSPlNuGRNeAhGioutx/DnBrAo9Me0I5lfBOEf+INjCVY3+OaRssMmKakAY+fCrrsASoiGN
	kVRWrotRrj0wOLxKr/a7V0O/o6XyOD5QAjU6ocE/BUhRLS1CRSSIAaDhqVs1QqxxwNL6byFqE=
X-Google-Smtp-Source: AGHT+IGYhfx2hhEnVp811r6o3+mVesMzRX0VxLwwsFF+Aubi9Ud9nfeO5K494LycQhg4yojLHmy/Ng==
X-Received: by 2002:a05:600c:3590:b0:471:115e:624b with SMTP id 5b1f17b1804b1-477308595f6mr6032205e9.17.1761847097374;
        Thu, 30 Oct 2025 10:58:17 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 06/13] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Thu, 30 Oct 2025 17:57:54 +0000
Message-ID: <20251030175811.607137-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e9345f898224..d07424caeeab 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3533,7 +3533,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0


