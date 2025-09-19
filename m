Return-Path: <linux-kernel+bounces-825168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B7B8B280
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D0F3B0F17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C353233E6;
	Fri, 19 Sep 2025 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgT552HE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F4313D4C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311777; cv=none; b=sLxOfLzbryo980tX6o1QMvB44xOvuoxZECfD18zB504jL6iwvq10eT2YWuPocKvBmcHknFt++i9l33qVpq+aLwyOopg4FPlw5faV4f/L7OWjzuk2MJM+jbb4keW3cJnoLUVeDzbVd1h3tn4YssFLqd+K7o1YSIa1n1YlacISLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311777; c=relaxed/simple;
	bh=dDkSkpwtoZrTlkFZMAI0mqnwSlbEy/nA428w4GDe7w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzDk8ZKtY3CEYq3G2kOyz3FFCl4ssqVcW+PeXCaG8y85x58z/M4Jy5dlYKuGmZl/wxFx1sb28luffYAQyHHJ8BYFpvBNajdx7yVgOwDfytU39cISeuRUtI+GhMJJGdWheAt0OGb0cW/+HrzBrSWCvXORymiaLXXZv7cYmWf0j2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgT552HE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4694ac46ae0so9086535e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311773; x=1758916573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPY2Tn2Mb7JuAb06hN2e4t/ofroDDllAnh7eFZOr6yY=;
        b=OgT552HEXsL0NOS/zbihPc7f/G0kOS2h89v6j1oZCCKUmS6bRLIfyWKBvA9kNtrjWu
         tEIDp2rZ+YzJPC2Z1d3q0rE0jtd9QaQzaFLI1SQjfZVxfl9PBDWblYk2/u0zFY4DXg+Z
         gWcFD+ya8AanmYTJbYUmuoVhGVFi59dLIPNoFX3Y3es2QoblVOk0sLVsye8T/uOLcdO1
         mbLpMRqo/hxxWASFPeuMZSOGKIW5Xw/7z2VnA+oolo1Pcg+XKqzUSIB06H9Uw4Q1fvSo
         Kr6gg67w/a55kVclotSzRGBb1EShrO2fd+Rpya+GLDKZNjMlsQP+TYHm/NjjG0Qlw3JN
         08VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311773; x=1758916573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPY2Tn2Mb7JuAb06hN2e4t/ofroDDllAnh7eFZOr6yY=;
        b=We8xi3vuh2rhpUXMrBiDvBazAARZLw4tGreCke1rx2bwLbr5NTSCnB7AXk40TeTVXB
         cR9uebzh4qQZqwM1WeBPc0QVSYj64zVM91WoRkQijClmDm2nnb4ZDPyIcuTLKUfECPVt
         WqytBoDAkaDeCVznhhR5ss0CUU+4nOGo/9Kf9MPWWImc3umpvK/tdbiIYoZBuCv4hhpF
         8A8+F7uEFMq3VWiWS+eUSc3xN6HTu7jSZa6yDx47cvY525DAMu0/ROUDLsxllu12CuSG
         /tRyMmiW7FMmU2MVRGZogd7QLRdL5fXKneN5yWWjMrYTf/IKA9YMhteJ118g34dgUTOo
         ZjTg==
X-Forwarded-Encrypted: i=1; AJvYcCWyrOtroGgmQKTE+ulQAxNRCTb9/jPJ9Xymyb8HYIrerNzvZdR9dhjvL7esILUHTJy49O75Iy5N14vyAhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnIl3Cfmss3B5pXLbDvvM+LPI9i01UiBj/vbv+W7cj90HWYly
	Z59+2pLHNDadrz98ZMEXdQrJoa6DF0SCP4pIYDnmKTkIdaEmjrpFIjkWAdGEGg==
X-Gm-Gg: ASbGncu48iKz7LkvY8JLiJZyR48gzfL0YpsgaSTxUWpGZ7BXENFsiY0cl3JoVNTTXqV
	EfrNhmU5fon9qdy/wE9aZ5xGKHVCUke7U10WKXlm4Vl7g1jKTjaC9shT2Innagt1aYHe5M9h9rL
	WMxkAwa7rr3qSuDIxQtW4QpgCn8P2kVP00gHD0LXTCz0U/XCx/5F7cqDNP9Ina16LgwolzUdQbO
	Zlr3Q3gqbzha4ry0OhH2M1BAYvU0o4sDm+7Z4ZNuWUPvNO5VpmM4k1ngb52aL8NYk0c3k4vyV7H
	+UDVgewGwk9i4QlzXVo1SwwMdvkNI3t6fV0KRVa/i3eedNzDeEakvrTuZqmq/NbzoTPAKtyZvz+
	uKQyDKQXTeGpULGTQSrI7+vkH5LcrOvZkaihAsnl9wXss
X-Google-Smtp-Source: AGHT+IEgTiTJuz94ag+tJSft9FOBLt7CZgjwjCyLiyY35QFZoa70BQ/zWgPe1wUsBzivSfwUjFP2YA==
X-Received: by 2002:a05:600c:4baa:b0:45f:2962:5ad9 with SMTP id 5b1f17b1804b1-4684c13ebf3mr26459675e9.6.1758311773308;
        Fri, 19 Sep 2025 12:56:13 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm97025485e9.7.2025.09.19.12.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:56:12 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 6/6] staging: axis-fifo: drop debug print of remapped base address
Date: Fri, 19 Sep 2025 22:54:00 +0300
Message-ID: <20250919195400.3180039-6-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
References: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe function prints the remapped base address with dev_dbg().
This message is not useful and printing kernel addresses is discouraged,
so remove the debug print.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 881abd61cefd..d15e2bcbcacf 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -594,8 +594,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	if (IS_ERR(fifo->base_addr))
 		return PTR_ERR(fifo->base_addr);
 
-	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
-
 	/* ----------------------------
 	 *          init IP
 	 * ----------------------------
-- 
2.50.0


