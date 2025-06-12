Return-Path: <linux-kernel+bounces-682642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85789AD62EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2243A4611
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE32BF3D3;
	Wed, 11 Jun 2025 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bAhKF5nS"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F312BF3CC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681790; cv=none; b=lFYm3zNlrKEt49Lfl7d8U8ZK28bW8aqY6c+Jcqhf+44cgxMSAi94HuqJKj1A6Wi6F0OLdn1AG9P1xOifCor4wgqmMAJJWfENf0P+vRag19NhYVt1WJu1ZxhdsMYx3q7wbO5acbtyAhX8WzTx2RwmqwJNNTW9ysAlfa3k8U1Oybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681790; c=relaxed/simple;
	bh=H2LBBJsUJiIc60MPGSJU2UBb5KBWsOEZhj5u9YgC6RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVQaegWXqx7OIPK2VBsahVDFZVWkqsxfMcALR5OUaHbJOuaIO4KBOz1riULu7eOZodNDnBYowhXoGsL063NMdv7Zev9tedZWSbtBvbxfvf8FItAZrfSGRX7dacQlBiQKu/oc0Pzviy298eY+vlHJxoK0s0i4Ti0Bus1hQF2acgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bAhKF5nS; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4067ac8f6cdso245678b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681788; x=1750286588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFtBqHig8Fed23T8+cfJndFoBL4sOX9Nb3YXu3tizw8=;
        b=bAhKF5nSF7/zh753RywiVD3wYcxamqEY4T14Ir080lwz3CDVS3mT0czYrHbHfCQgk/
         sNBEBLDtkarkNPtwxG454AUBr7FJwN5TO5BvppLK3YI+2Nqbg/ekz6mQ6I+zuBIcX23s
         o7NZakcsVWeH2eg+WXlrRXAZ95vuYZxPVVwrJ4ikNrbL9872xvUPOWdcp+dq3PT4Twi9
         q7zHq1b6o2yjyUec6dYBTfrckYMEKisKJ5tsXOXopRrP46WB/AkR4pZ7nrs9z0UHETIO
         ECXxDvSt9ZaqvkNmBJGk2WMhLVPyR/yC6ojyzNDMc4lnzEWuYQlnr6SN+qTeaaxC/Ndg
         Wb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681788; x=1750286588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFtBqHig8Fed23T8+cfJndFoBL4sOX9Nb3YXu3tizw8=;
        b=wLY9nqbsKtz2+LPNU6N6VarSeDB9SD0nvyF5ZssWQyl+vhF0ceSgypHctANBk2UVXL
         LyLALjpl49qpB/h81KZ4hm+oe/+yQR0+7M50uxy66SpXXG7b+iaej0Mbm9b3U76yvxCx
         KiMYY9Yk+9gRSS1P7GPZBes2oVWsxcBKsdl9BFUcZpeRaa3E2fB0WozVcnlaUz2KVwcF
         jfdf4Vs/HfgOENEYpSjO0QMGqkpJNFZtnE549bJxJgBKvqEvbRqADK1YG0zC8pYRr2Qh
         EgoS+xKnT8DGn5cn8Cgsme36evmJNuVex1iWttAoNuFtDxFkUgeTmp3TX2sfUlN3eXeT
         bw0w==
X-Forwarded-Encrypted: i=1; AJvYcCXetMn8wzCAfwYiQwnBkS7hqiWr68LtC8cFudx8k7mnIvLcsyGoGM+vqyQUd+5gyBtxVCWo8QHl7XK2xA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2K83BvA3af9C0mrRtuJncpiKACdnOSHHrMshjVS27s69diLlu
	m6CjkLhZAIn7Iv2109Yj1dhFJoBVUMrKdAXanUS1XtNXAAoaizJ8W0gGC6ebRWb5YFM=
X-Gm-Gg: ASbGncs8eUn+jBoMqw+k9melrTCWAmGAClmkhbYbfAGtj5bXgJFIRNtgpmIQdUbLJP5
	1FmZSU3nw3z9VCsCj+yM+FlnjpoSIWHGkLoMKEbH4blCBLjdhRQjEFG06DiCGbgO0BaNpL0O7r7
	Y0XeKN+leDQz0ptYlBUlDAN8cf3jK0wrjhN6BohhAAdmT8KWGw/bJIIOlKF0ZQ8J8NB0DUMyo+1
	tNY7WYr0TGn3sw99H7uua+gsYMpgvLgRnLXuUM/7YRPKmv1AaqJ1Iq72XwNIXU1DqfpHaNWsDBN
	lE67iVua3r3tDtLxXvnbyNY+KLxm5TT0OfoXBEMYNNAoElfsDYhnstgYkA6BbU2j7FHF
X-Google-Smtp-Source: AGHT+IG5W7kH4+hxgdGC5cYojtw65mnpGPuM8rfmDxflahn9sv2QuWNjrWb24/1rv7CIa/pXKjlkYg==
X-Received: by 2002:a05:6808:238c:b0:406:72ad:bb6b with SMTP id 5614622812f47-40a66adbc50mr575420b6e.37.1749681788466;
        Wed, 11 Jun 2025 15:43:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:43:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:19 -0500
Subject: [PATCH 27/28] iio: proximity: irsd200: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-27-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=H2LBBJsUJiIc60MPGSJU2UBb5KBWsOEZhj5u9YgC6RQ=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGhKBjfIgQfT+NI7ZBHF6EqEZASLyMpQI6Xmjd023Z/HVL55R
 YkBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJoSgY3AAoJEMLMIAH/AY/A1PwH/1/i
 g0gWTD7ZaRxp/hx7awW+jIFoQGzh6qTEbYue/UlgwqG8WG/qXLGJtE2TMNEr4xak/0DjEmHUQi0
 6TuTAR57tOQGCcFyvgFcpEHWGzydpL1M2UuzsT6SrTEkw8xRBk1Sjru/5SPcKg3fG0YQNSV0u/u
 y6b5ToQ6S7Fyrp/CQ9iLat82yU2B4m6UeVvKbVnUqQKf5W6irfzYAIiHsGm0U6Vt2JB0bw/xENa
 0AvOII7wKZ+yCTn68OJNIUuuO2GriVCbnOFFVj9k1xyiFlL1+f/o9rELPgpsoL23p4rJAR11ciY
 NhG+Uu1ETT3wLhRDyyFvmrfMPWxajwsHHsexQU0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/irsd200.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 5e751fb0b12fb2167f4d11e814915cb2761ab9bf..253e4aef22fbdca84a0f8393d6f423385c8dcda8 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -763,10 +763,9 @@ static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
 	struct {
 		s16 channel;
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int ret;
 
-	memset(&scan, 0, sizeof(scan));
 	ret = irsd200_read_data(data, &scan.channel);
 	if (ret)
 		goto end;

-- 
2.43.0


