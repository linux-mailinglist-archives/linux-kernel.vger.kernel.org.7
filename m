Return-Path: <linux-kernel+bounces-827417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4AB91B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D307A37A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520C52367AD;
	Mon, 22 Sep 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="s56TM4qe"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2E2030A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551310; cv=none; b=nJMTMk4sbpuEXbvVqhANgNsoaB9Nk1GJtur7oiUflwOzsYYeFFphjFKgJsM36mBzVVksBHegWh+WlOInSJSvEasui2O8lxjXAQNQsllwxqPcOC7/3uUPrrORg8/UVw68SXxeT2zBP0B79zUBnDacaGvlt4L1rp8fy4qK9/Sa3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551310; c=relaxed/simple;
	bh=WjiEYvRTCyxfeXoMzLNz+6hZB9UNJBt8nx03rVJu8nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD6tVY/qU37CdzmPfjt5MBDzUxbjEVHgjaMHUWwaY3O2GVGq2+8g0xeM96HqCTIjqbRl544g2DH5rPCR7Fw7R8qQQATYrtLDoY2fZJMBqulGsL2wq0jg1UGblFi/WrI9ABR078MhbDJQVVcSXLc7p9ixrxziT9CPI2iGAfe7c04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=s56TM4qe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea5cbca279aso2955391276.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758551307; x=1759156107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eewXiWrdt+FbwB57GPpi0UiTga4wC1/IPQUMFS6wi8M=;
        b=s56TM4qeeXCWzJugd3y60mw1wgJh50YhG/qVQFlvcsrMHCZxp++dmvZ9vww8FT/C9E
         izH0ZyKk5y7mdzjLBf6CecUpmbfI9zMvxe050Wz6hwu2oq/WTytGTNdVuXGv72bHg/Js
         +A8OM1DcuOebyW8FGSD8ATk45ALG3LohDZSCP2zjThZ4xuEGLng9WV20TzKUR76YNHHj
         x1zNphmhi1HYzMU6Sse02rBO25uM+QV0UadLA6Bmr6zQaebcZeAxs3wKrF5mjD2iqDIJ
         cL4x82YpEAW5MfbxHYXeAXRvya+CYm/00SjmRlSyuhyQ1+FnL2njYnwJygPko92CAc+e
         i/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551307; x=1759156107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eewXiWrdt+FbwB57GPpi0UiTga4wC1/IPQUMFS6wi8M=;
        b=KdcDppvCEU9FWdzFPVxNnIvH9mAtWORQpHHzb02Vc03pYIIdXsMHRabTzD3QEsZytx
         OffC5TkUxrv5rhYzGyWrii8ZFm0Uvb5oXbdWAlHVgECFqAGY8cH8mkalcUBjFEEDjumQ
         To1YLz5RYMgDF8JeeIvZzJo7jHrz8Jj5qIDjj2vPThhe6fyvCFV7zyZp7jUh/phGBeqo
         AHl9J9023nUtcDaRP+e4PsB0ZiV7Psdkuoip1v91hL/k8XrpCTk2X6ByneCF19RsWwUH
         fcU/kygQcLl3Vdx3t/WpAF58AKSvWY/c8mMTuoyFvGEQbgul0vwLOmH3Ya/rF2zzFt88
         aCzw==
X-Forwarded-Encrypted: i=1; AJvYcCWOu6vNciM2DgX1xXfwqRSMeI1xAw4qroEwM5luK4Sf2Q2+yKNbGeteTd1SeIw0yu8vtEEaCdeRlJ0Q0VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvyHJcUGZZvep0Ii4ot0fRraGWMPsRofF1s8urhMYQw5VvjJag
	ubZ5zqt67WIv0p7M8WkWUg90PrPJx3KuK7JLHeRiSFAZSrC0grfiAGHV9ZZ/FN1QasI=
X-Gm-Gg: ASbGncv7eQ0ROk98wfX0+cfJ7u+PhgXPkKICLXzsvoVbYyewUei717y2dgbgOljycGy
	3mo8hkk0xAGMV3Z6FngIwb3b7YVFd/HZgb70Z86rQ2sEEGPWiP8151xcW6RmUnv5Ec/k7nM2hV3
	Ic5rbfMzprgicfZSz3VUoOavo1xlCSl3WmBKEht+TkVhXansbAXuTxwEd9xdvspvo4u4GkG3Vy2
	pBHmx9uoOd9BRmlIj6jFSXR1ObCgl7lKLT8/lEXlGgXS5D7bk/CfoLJpVPf5trHcPsHBvzpG88z
	n6HOcLIaDdsB+OLWaBG3bSbcsrCc2DW4H/GgO/RuGxvjyqOc5qIkBuWTcIy4jRP/yO8XtHet2by
	iZWBEs77fJ1xg5y9FBWvohSXBzmsPvuyBGf8q5V2iAnzP9B6E4bQmzA==
X-Google-Smtp-Source: AGHT+IGe1b5Wk7IhRgrAniM5ARhlxshEkqecWedZ3KolyU7DGRz+jN3Bmhlp1P0FYWC7jo4Xqzkgcg==
X-Received: by 2002:a05:6902:400c:b0:eb2:ae14:2fb0 with SMTP id 3f1490d57ef6-eb2ae143ba9mr523177276.29.1758551307294;
        Mon, 22 Sep 2025 07:28:27 -0700 (PDT)
Received: from fedora (d-zg1-232.globalnet.hr. [213.149.36.246])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-ea5ce709efdsm4163124276.1.2025.09.22.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:28:26 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	steen.hegelund@microchip.com,
	lars.povlsen@microchip.com,
	daniel.machon@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 2/2] reset: sparx5: add LAN969x support
Date: Mon, 22 Sep 2025 16:27:29 +0200
Message-ID: <20250922142813.221586-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922142813.221586-1-robert.marko@sartura.hr>
References: <20250922142813.221586-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same reset configuration as LAN966x, but we need to
allow compiling it when ARCH_LAN969X is selected.

A fallback compatible to LAN966x will be used.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Drop driver changes as we are now just using fallback compatible
* Add missing whitespace after ARCH_LAN969X

 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d4..59245cd0c393 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -170,7 +170,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	tristate "Microchip Sparx5 reset driver"
-	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
+	depends on ARCH_SPARX5 || ARCH_LAN969X || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
-- 
2.51.0


