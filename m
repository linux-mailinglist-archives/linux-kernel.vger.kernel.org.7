Return-Path: <linux-kernel+bounces-815335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49159B562F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0AF562AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A026059B;
	Sat, 13 Sep 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC1xCqiD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CD1DE4F6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796139; cv=none; b=aiYwWN48KrjyVuSBS8kvII8YTucdlquQwBCgJC4iCGqBkqCI7oZAL4+ICVpLSFQ6DYn6ZU3NAN2nnLAx6yM9anPSDPUdgf8xIyc4VuOCqVr8Ke7INvJIRGlVoYD8jDtxbuCi/M0+Mt0lUZhhAOfg9J9tGU8eD4OojG1Xp60Ty2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796139; c=relaxed/simple;
	bh=/P/qxo+yyhtCd2WG67Ww2v62Ig3zgNGIDT8HLN0TCu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ut8OpN0zQvoKOu0+8KIW3wbaN2KART3tu59ywrmHenw3UDsA5eBT0Yyk2YWUhrEwhBIw+OkF95LoxnHANtM/f7fcf/yIWCqYKAVIqrSeXWaG2jY7MHAbreAnTWPd8QzeOWMHb74xMNySUmcSt9cjFnf4UxZd+nmdliq22z38Il4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC1xCqiD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso2381241f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757796136; x=1758400936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+lV53uizaZ+F2RLP0bqdZS+lXR7ayYbIemsvFkoydw=;
        b=HC1xCqiDsq/nkeyjy2UYQ/V6p1+8KmjFTZFtjIq3HX9PqcxX8Jf+fetCBMJEcogR3s
         vTYPT+lPmsQW+lDYnPy1y4ttm33u4cRcr271XIzTn1u/9FpmMrHISFbqcKTNJMquNWee
         bPB09BjJY44nUWnbNrlGmqCXwftnriiLbPDlyOTT0YUDDoW6Ku77YA6M5KL3gI7hr+B1
         lLojeFq1E9L+Zhi5wedwxRHC7UMzs+xpcYq5OccvtBT6ddhdL0uY61tHJC3An7wTs76b
         iq0d7OUhVUcFYZrh6Oyk0HXk8XStPP0WMkKEc9iuEPSq/fA+fX681R0EQojKcko7zstT
         Ol1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796136; x=1758400936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+lV53uizaZ+F2RLP0bqdZS+lXR7ayYbIemsvFkoydw=;
        b=XRmKAD85j6rvlTbuwapHpeSHy/xCcuL0fmNjy7nF7sfTjuZXcqepsqZbpNTgkoO2py
         GauZdnM9CPj9Qi49a+b2HdjXgDZSYwMJgLVT0dqbae/iKscFOcj8Wznxe/ikhu1Q2pki
         n2rwqG5i5+C1BUDhRtoYaxFla76paCAFwNKzeH42Z4jDRhnIf+jlARk6ecjzKEfYjA/x
         Q6zn9t5Hl4igOaPYK+uF0Zoagch6iruS08zw+BQ0E5T8Q8kKOUk11PcYBsxF2WiKeurH
         dK8nN4nhGkn62mupDdW4VRuMby1gYuaKGH+bf49MMhbzphdiITLXp1IFre1hdJasYP5u
         si5A==
X-Gm-Message-State: AOJu0YzKb/6UOYAV9Y5wbQ8qUhi13XxAdibpRyL3bW0YdOewS/UmFc5a
	P/3w/RILGrv2VuMTypOXn0c8D4Yqbn0TqKbXmWcz28vRRoQf3S3rzmIFJAKXi6jmRMk=
X-Gm-Gg: ASbGncuoV6XL71V0qzqjpph3QY+j9w7lRL9CMrHjV0yDd+J49VLrNUXtJfLN61L5V1h
	pRHgr+8kAWH6zI8aAmdrHQL9WPXKkrvqKtOljHFUeHrC2L7fSWKPt5VUz3JWv7vBzQTJfC5Ex0Q
	O588jHK7AIR+Yv5pTAnvGFH9FzWOmb4UARG1c4CB62bfSbz4lxaeGgFuW23sR70M2bbBnpn+zuf
	0a43p4YYI5ITvIZQJ7F4u9KVoKvzUO2ASdlVq+7ALhhJssdoZvDsbmwbfPmXu49qD6PUyrk7UlL
	H+O8hS1T6CkavDpCHd11h6IwJ5gRwVEspWDNrGbZjhAIY3rmsVhVgxSGio3JokPB6HBCouPF6Vj
	COdPXGBO3lkiBcLYQ/jEkd358rV2oRCe/qjcBrtUb341UheEDoR+ZgbErtCGxnxAAbnHn4XY7J8
	N47GRF3vs4yfOojypOXQ==
X-Google-Smtp-Source: AGHT+IH0uXG2lGFiqqlltX/cdJclGu6EeCpbeRw9akH3b1yiw6P/wxLThUCO3KVM56ssT1Ub693z0w==
X-Received: by 2002:a05:6000:1a86:b0:3e1:3b1c:2c13 with SMTP id ffacd0b85a97d-3e765a172f2mr5973449f8f.59.1757796135508;
        Sat, 13 Sep 2025 13:42:15 -0700 (PDT)
Received: from localhost (86-42-187-225-dynamic.agg2.cty.lmk-pgs.eircom.net. [86.42.187.225])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e91b2519d9sm2144423f8f.22.2025.09.13.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:42:14 -0700 (PDT)
From: Shay Power <shaythomaspower@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andy@kernel.org,
	linux-fbdev@vger.kernel.org,
	Shay Power <shaythomaspower@gmail.com>
Subject: [PATCH] staging: fbtft/fb_ra8875: replace udelay with usleep_range
Date: Sat, 13 Sep 2025 21:41:10 +0100
Message-ID: <20250913204110.24980-1-shaythomaspower@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Shay Power <shaythomaspower@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..edd467c6bf1a 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 150);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 150);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.50.1


