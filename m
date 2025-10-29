Return-Path: <linux-kernel+bounces-875368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066FC18CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5FC462BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595E30DD00;
	Wed, 29 Oct 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWAuAwou"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0111F4188
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724315; cv=none; b=kIwAKPFqfBG9azPH90tLvhMjkLt5h8GKoQOn1ICnNKN0YJqs/+5u3oh4/YgGdaQOqYpCvfbVbtaGXxpLyX/DANAdj9lH+Ze7KDjiKNvv082zilLawTOcrRaJqpLHld12C0gNP8JCXOHXV5KhwS5+T2Zbq2ONBqm/820PmKEZgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724315; c=relaxed/simple;
	bh=R//xgOGffUTe+9aSDmu6b6N2JOiXux9JodaCX1BCJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HA7voTMNoTa5Os5gVB3znpOntWvV8rHodzCNhSOQQGl7FJXnLVFG6qkWiQhC4uGWxO9K6hSUgj+qLL/quB4AhLNgY5ItbJJw8phroCYBpz6RRQUOb6WUU57+GbSQKbYM9akrmzgop//Ag6dbw1x2UNWXURGdwnKdw9qj8chDP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWAuAwou; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so103899475ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724314; x=1762329114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFgF36l2HyFre4LmabzRtUo8eP+DInseCp8ECHz06WE=;
        b=QWAuAwouKaesOCq/mxceRzf5VQFVfR7t/u8GmVsAWOZIcbVieAcBmsjTbl9tAdRiSR
         EbxzuYqDQ9QVDExkkKofI0TKafS+BQVxDu6JT2iPbCTaCK4YyJC5taPrKMQtvVO0Fnvy
         6PTd/JuBW8WnKXFScf+tHDVg2t/uPlZKWSEjhd44jmGo1HywCEYFfvRZ6P5pD/Vyyo7v
         NmBb8AlFvd1yZ4TW6MK/lkXav/AhitrEOd1OdBbqSGt73Ocrses3Vmg1dLIk9R93pBtS
         TJQzHEK3Wwj5tCMa9YPUO9lqtHT6PQ+3Ms0aoZuxmMLWDld9RSh4iZ4d0+Jr2Ek8vBMx
         aMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724314; x=1762329114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFgF36l2HyFre4LmabzRtUo8eP+DInseCp8ECHz06WE=;
        b=KlFC6l5w+f1y9f8UX87mgLCD7aKcQE402Ky7kHxZ8h7kkzF6LBs9a602UfQ1doszOL
         MLoVq2/xLEg1USWHOEArPRidcYV5E+d7m49emHDjFCSVlVxyv69F+cGxemyZ5U8r1fx0
         SNLVu0BXZjk4T33s7+kfhTIkIrUTa/sWtxo0AFUNifGrltvsUXe2w2+Qm1G0+4rTb4AS
         u91VJEoPrkn7IDs/OqBM6nOtBSS3lPWwOOAVoXhjPkqo9iDmmKu9JfU8ukmLBIJeH6dw
         Gq1+IYUCqTlEHY8uZ8Ggdr7V8o1EnPhOIAmeCkaPxxvpAhlQh3zB0Ade0v5reWAtFx5k
         bvsA==
X-Forwarded-Encrypted: i=1; AJvYcCU+1F+04oZqett7bEKc3KnaZ435XjlZIPnHqHNYrteEKrajUlbfhPSFCsm5jUO2kccF58d/es7Uf5bGXYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImsAlJgUNjyQLBxyzcV3zq1uFKCgJ05j8zCaQ4I2dg0wbYUY/
	pYJYfwWyG/QiJAZpJy1El36mJtX1y9krGjsis0Ne7qp+VGEGcOW3AYRD
X-Gm-Gg: ASbGncs0/UKZ0D2JEMPUDCamYzsvwvf+ucc3PclAFjl3Tj2locUT0wwGscAbP2fqr5f
	cRUDHG/mVXN4YmF0QeDVgGHPJZpCHzsnVvGiX/1yRWr8IsTFtVZB0QHfZUh8NdYsSHO8NXVgM1p
	1vyK6zHZ+R8FTUWq1PWfdKitHKXl0W6HbWv3nddeD1V4PhCnB5Z55D/bukaYpi+k4SaUE4Ab0/7
	tOKiujr9KxxX/3gQVGsWwrXKIa4OYSX31JuQpR0oCmf4VeTIOcUzdXblmOszkeVWzg0o2xhWaLN
	+uspRHACxYUOIm3Ob/ozTv1bB03Ijnvpb5yKjTbamKt7/LFljglZl5N08qnVHrCAXSN/JvTduG9
	QRl4Aum8+i4Z9LCG1ovOIE6Tt2xgUwscU3AgpBC1Q5zHzB0k5Hb+gHHZGzlltsYERLjlHyPdl+f
	oABTGT
X-Google-Smtp-Source: AGHT+IGZomJoLjP5COyqxCSaKhN2NqGWDmMGxh6UCXMB4fEdvmiwFvN+wWcXQr3P3Jjcl6bBGDvOiw==
X-Received: by 2002:a17:903:1a43:b0:26f:f489:bba6 with SMTP id d9443c01a7336-294def00e7emr24838525ad.50.1761724313711;
        Wed, 29 Oct 2025 00:51:53 -0700 (PDT)
Received: from hsukr3.. ([2405:201:d019:4872:4680:8a:2bce:378c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm140868435ad.24.2025.10.29.00.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:51:53 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	linux-iio@vger.kernel.org (open list:IIO BACKEND FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] iio: backend: document @chan in iio_backend_oversampling_ratio_set kernel-doc comment
Date: Wed, 29 Oct 2025 13:21:16 +0530
Message-ID: <20251029075117.104758-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buidling with W=1 reports:
Warning: drivers/iio/industrialio-backend.c:727 function parameter 'chan'
not described in 'iio_backend_oversampling_ratio_set'

The @chan parameter was added when iio_backend_oversampling_ratio_set() was
updated so the contexts could specify the channel, but the parameter was
never documented. Document @chan to silence this warning.

Fixes: 97e6882ed1a1 ("iio: backend: update iio_backend_oversampling_ratio_set")
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/iio/industrialio-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 23760652a046..937f4ef38e1e 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -717,6 +717,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
 /**
  * iio_backend_oversampling_ratio_set - set the oversampling ratio
  * @back: Backend device
+ * @chan: Channel number
  * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
  *
  * Return:
-- 
2.43.0


