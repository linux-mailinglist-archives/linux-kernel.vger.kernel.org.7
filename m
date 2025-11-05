Return-Path: <linux-kernel+bounces-885886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C56C34226
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723944EB0F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E472D12EC;
	Wed,  5 Nov 2025 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DgCzKiSc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FB2C21F7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326334; cv=none; b=F/GEtx0IfDGAgXJ6oVuO6xyhCaeGaHEx08+v9LIBywjh3g3pSPsUoN9JwRGVJWMzsYZAOTlgiU4Kl0dzbVDezF7fErOZU7APB+jmzJGdz72To2fgYyO+MopD2sQFaetDn6zlezkmAp9xX7NHzIB9v5LPZ5KKS22NNoYCZXpQiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326334; c=relaxed/simple;
	bh=1QQSsgCx0pgNxfx266TB1Ixb7FQzknNZWiWyH5+V+II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ4UJE7zrzSoy6jxnBGXhC2CsTl5iuub/sZFy3vnw70wBoo3/uYZ9RNm9Hal1rTBtybGlRwlVJnKmF92N2XCNOI++jYlVNh/2nwhJyVVrvJ2fQgqU3yNfHTgvK6o6drJWGMz9W/5Y41EUlI7kDgXJ5Twe1Ehsa96ZDB2U/UqZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DgCzKiSc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775895d69cso6809425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762326331; x=1762931131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWgmb5rLDQozO3OkIX7jSbLmOOz2Qk2T5UHmoC6vWl0=;
        b=DgCzKiSc542Tw6r83Wsu0mmw4me6T6sZQ75tOsUv+A5DA7X3OgVAKivI8Yd898lWZr
         zl2xo+OXCghL1NFi3n7Q4gnpseYofTAnYJywUI/6dZEJHAvmvfqzvHFJFswbQIrQDc1B
         I+ImacKiTIQ9Jt59tK20yf4R15MSS5q4pX/e6GtHNeSzh8oLkpgdLA/T9v2GBgJ0A5hS
         +AOEIHN1cKh9YXtT94DHHh/5yWIZdX07w/qbIQU9pB4ElYMhfRZ3QWYFuZxC/DKG1rnZ
         amSrsScGeNSNb/z3pvFSQSP1sjzLMhYyN7RH8RN2gq1bY+VUc7VQj627JWQlIxCPZRXM
         HmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762326331; x=1762931131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWgmb5rLDQozO3OkIX7jSbLmOOz2Qk2T5UHmoC6vWl0=;
        b=wOdUIgujKsmbxrdLKkHe2oUs8jet5HxyeDH4UvTxqVQm9qfkgR0DFdNARLBtn6DO/8
         WquTO0lnvUb33SpKmW5NfmlAHY0IfDEHRw7r2v7v0lP7KanBpgnCps5uHqUIs4lfs2kC
         +LBFHiYGLKh4nrtiGURv8UcLNXsRSPOSq34nDk3I7CnKDAckedW4Jb3GiECVMxOs7auc
         orJPv/byUYUxUEhZxqm9pgKJdBaWMhO6vGsIul6pfVzRFSAjnb/Ui6D6Il+/xQ3lxLQM
         1QukJuURPQOqAmSub/XXEoMy7/jj9c94ztjV5yVvCDVrU9D38b5Y3mPpsAUIejewhdHf
         d5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTMfX+ebbWfiz3laxjohaMqsS8mi7PJ6qJ+FrnO+1UPFYA2nDkQuSxRReLnh5WKdZrus3GSOSq++kemig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCTr53bqXYeeGr69+FAGWPCWDadFeUdXCQiQ6HQ/riIS8A55Z
	5YOTf0k/+5G2jg7+xToDhq8EVY52tHN3MKnMXT5vxls6trWWqpQ9Aa6JVm1LxFHcduw=
X-Gm-Gg: ASbGncsMYfddjjmlIDtA7CF1jGf+bEb7i7XPyOIqrnqZTv4hjbNrs+EcFHUvAG058qp
	tLwe0f+7sH9xkeOvJEvbluI1YmcMoTgyGCA63mNzzbSpixcGEzh8cy7/GazVwEZbQtyUWDQ2RZ1
	CqfEyiFnXYkk0+iuRow4rq224T+zYvsNe6zGbDRNagZV5FxTSg0xb3BNFVo2fKsgr0EfkeFtyKc
	dI+Y2jRafpzfWVnB8HwdkD6vwSo8bWugGl7sMbO4Ywnwh08vqw9IDurmarKoGD6pc6DMW9C/sTB
	wVhnm/859qnIXKhg2UOiNd4vCOACCLBBN9lO7M5TVJntOb3p/UZw/8+b4KHHJdnCbP29toJJpbb
	vDM7siryYo7spLGWuQxJBVHeugXThSPCw5cOhNCya1jBYOZbPK9h/oFEW5DOAIxWm6KNCoWzFem
	qGuTb1OhWzoofsXBcPd4gSGRjkRGK4lA==
X-Google-Smtp-Source: AGHT+IGHtHJyD2g6rt0y70oaDzsqfUtCB6NnQuYuLGZE0oGBZ7h1WadLlOHXsB5m7u2aTePpukReqg==
X-Received: by 2002:a05:600c:4e88:b0:475:de14:db1f with SMTP id 5b1f17b1804b1-4775ce19f93mr16644565e9.30.1762326330668;
        Tue, 04 Nov 2025 23:05:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc96edsm30520685e9.6.2025.11.04.23.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:05:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	john.madieu.xa@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/2] soc: renesas: r9a09g056-sys: Populate max_register
Date: Wed,  5 Nov 2025 09:05:25 +0200
Message-ID: <20251105070526.264445-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105070526.264445-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251105070526.264445-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Populate max_register to avoid external aborts.

Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/soc/renesas/r9a09g056-sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/r9a09g056-sys.c b/drivers/soc/renesas/r9a09g056-sys.c
index 3ad1422eba36..16b4e433c337 100644
--- a/drivers/soc/renesas/r9a09g056-sys.c
+++ b/drivers/soc/renesas/r9a09g056-sys.c
@@ -72,4 +72,5 @@ static const struct rz_sysc_soc_id_init_data rzv2n_sys_soc_id_init_data __initco
 
 const struct rz_sysc_init_data rzv2n_sys_init_data = {
 	.soc_id_init_data = &rzv2n_sys_soc_id_init_data,
+	.max_register = 0x170c,
 };
-- 
2.43.0


