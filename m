Return-Path: <linux-kernel+bounces-682640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B2AD62ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E63189908A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9562BE7CB;
	Wed, 11 Jun 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gs0kdU2g"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA39294A1F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681786; cv=none; b=DNvZIeqk7Re/6CC2Dtsu8Oli/fV99sQp/EUn9gxbtD/1Cqizp36sNhyLQoJSgF2ABYJOCZugF74P+O1EEiy0SLnk7V37wLg91EWtXXxlQ/r/kJvzYG0KFmGIcUFxNt+PFUQL+ebCtJ61/+bjIOR+O+N/iaZWl1aYCt3GCRz+h7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681786; c=relaxed/simple;
	bh=+Al+Scx0CuEWvmKSaR9FmNdQ/zr1q9Yo8+2pHc+n7jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUEwIbPQd/48f4F+iP+rI0Ng6VsB0NXu5lo2A0a6K+Qu0LP7DqaHTxcaDRk31+YjmKswzcxTzrDvEhe9dlH4umORnUfimOdA5HGTT3apupxZeua3TnT8XWc62rUOV3wg4eJRC+DVhf0R2C43QB4UI9kxWeBxFcDytSlU+0udg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gs0kdU2g; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-404a5f4cdedso100890b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681784; x=1750286584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8QCKzZLzA9c1boYxiH6Zgd6l2s0DqEIDVHfSqU5zrU=;
        b=Gs0kdU2grxnaK0xZoMKsrPm+yc8wZxzSdebYDcdNuKMxM3Yq9uPjx+eoXX/mBRuzF6
         M7hsdR6Mea0nPDvfYaOf3uCpK1/LqnP+NT6swLS8cSnP/Bh8O0fTsn31bbXpWxXxtd1F
         sAOnJUJ0P6r9vEwAv9XDTFDSccdz2FxzsNsfQW+DplrRTMZ3OkeSle5P+Ml5wqTRrgih
         a54l0BvWL5YwUdWf1u1a7YFq3qK/JfGQerdiz2PskcOaLOIwyiWJAZBTJuaBssWCSg+k
         h/YDob/vU5gViDyanKqZdhyCJkXQcVd16G+hPnzGHvB8u6TIQv2XymClVYTznPiUiXv/
         b4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681784; x=1750286584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8QCKzZLzA9c1boYxiH6Zgd6l2s0DqEIDVHfSqU5zrU=;
        b=Q/MAIk3MzFKaNciKiMe2DtCfvhj9PxO73RCT+z7w6SK/FuTpyNPJ0NAS7yHsj3sl42
         5i3ff/Mg06yVobl/77o0xLfUxORvUdpzIhACbapXswJ2O/pmrwzg9T8ND39z8ngu5XZA
         9G16HHUiSMh0OTY6hzjn0J80gOmpjtvPXrs7P1U2UHa8YR5ssMhXjrbkLvTx8K4ToS63
         3muMsceWbHBOXh0G5oLT/ZN8cCzPMZpWxpQApPcesTewXiJzwslyMM+q3Ph/tRNCbAa3
         EdWaOyHvDaw229fJTtKYNfJ+XfBRhisPnYPkVU2etMziKNLBCUSwNLbirWdLQlbiu88o
         xuig==
X-Forwarded-Encrypted: i=1; AJvYcCWOsMpQ4SE+KgXxFk1sA72HKncvpE+fWf96xnKQNgPiOf0K2zFCw70OTzhgHeCJYLx3VXdDb3a2CXEMk0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TDtD5wpPV1NdJc1tpJFeYoJQMNcRWTBbpOhoLulME203hm6a
	1fagp1SKhDDimH3Bs0fYliUdYrxJ+OfkKlopRKUdto3+Sj81rHZ8szO/BsCzZYYbOtI=
X-Gm-Gg: ASbGncs6FSPeHzY8qlJ3Z2zSgqeGEekicFi0CksMGfXaSPPwnhQ0wSb5uQ6mw/xSraG
	0FgoqcIX+mGNfKNbnejUf/Y9aijUFgh7hrNFPgrZqAdOQvpjldiLZAhJpdt9RaU6l0pEgzoPnGW
	IGCY/XlxhFaUFcl2PtXMp8OBWIJS7lpW79NEJDrrjIuoEsYo/Z5DsFf4RxcWFWSQab8uiY766jT
	SemOw94srhxQlIgAdZSrpK0nhwzaOQ8CE/nnLrYevMUF/gU5a9G8puNVdKgrA9ZpoyVTv+VWcJ0
	NiOAtqonFQ0RcGcTiDDDwDWOUqI+iHbW3m9aU/ZboxrIAI1gusmVRmYXGyttdciYt/vz
X-Google-Smtp-Source: AGHT+IH53kFC4pQ00iW8frMOPsS2aW2HVSZ9BOgRUzZQwvvNEv752UPhJnf5JrLuBhq1/flY7pu0bQ==
X-Received: by 2002:a05:6808:164d:b0:401:cd6d:25e2 with SMTP id 5614622812f47-40a65f92499mr1064493b6e.4.1749681784031;
        Wed, 11 Jun 2025 15:43:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:43:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:17 -0500
Subject: [PATCH 25/28] iio: pressure: mprls0025pa: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-25-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+Al+Scx0CuEWvmKSaR9FmNdQ/zr1q9Yo8+2pHc+n7jQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgYqU/X8zadeXISux/OIM8m2Cz7MRuRxATYcV
 71OkLQHQ0+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoGKgAKCRDCzCAB/wGP
 wHHRB/sFQd4QvOKtJlimYNNmwLWT8x571H1gIrBjRcfNuzvQddwOXZULzkxba8/Lj/g41g9T0Fh
 uwYOV52qXTHRasuWN6cTVSBSNo/K+9CEGdRWSIUqOF141Ti3/hm7iKloBYRHP5KlfhztlEVvBSO
 UVlWPLsr8ndFwcGj/M1lNwTZENm/nAXlochyQYMHsX7ojshZQEm2BWXiUnTUrFdv6Yr3groQUyW
 dzkx9EmFcUYCuxAkx2sdIPfNCMTKAlUp67GEvcdCf9xtNkjY6Q5G2NqrtGeYmGHS63CmPwJtxYE
 NWy1n7x6KNDIiXYX2AlAAOY+bvwSYvg9fG0jz0c2dypLa1eD
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

The initialize of the cmd value is trivial so it can be moved to the
array initializer as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/mprls0025pa_i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index 1a48f8d43d716b28b8fceb8e1a06d63a73a74a86..79811fd4a02b370b3fde8bd67a5115a3934f8614 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -44,10 +44,7 @@ static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
 {
 	int ret;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	u8 wdata[MPR_PKT_SYNC_LEN];
-
-	memset(wdata, 0, sizeof(wdata));
-	wdata[0] = cmd;
+	u8 wdata[MPR_PKT_SYNC_LEN] = { cmd };
 
 	ret = i2c_master_send(client, wdata, MPR_PKT_SYNC_LEN);
 	if (ret < 0)

-- 
2.43.0


