Return-Path: <linux-kernel+bounces-874775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A72C17103
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C11A6042B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC622E0917;
	Tue, 28 Oct 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcywpJ5w"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A02DF14A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687269; cv=none; b=ET8VWVUr5MjnCh8b9BZxPdiKkJ2Rq9Ts8kqBreNl+5U46pLim8nL74CL1RGeuR9WNhFq9gO1M24TLPmChFHKJ/G/FIDYNCWQ0T1DTsQprk533zzLBAKcRMSjUfJbjBvX+LfTPFKoI/WgEST9YEZ6X98pQ4V85BhRQ187JV43QiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687269; c=relaxed/simple;
	bh=fSoDX+QWdkPQKwwwC25/FSkyezQzT4MNTwKjc3pdxOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFY5jEaEPGGsBeZCKYv7okkNjqyue6TeE1/1r8EtTfI43SF+z/dNq5Ua0QqW6b/M5g9wNSykf8iOubZ119S9dDoGoxj/W/R6EcrtZKtPBR/yMKzPJRw6RBlgHhkZjqDx+0eQCSNHJBBRF5wYYy/YVJJNp9/+lnR19L/iv02Llok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcywpJ5w; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so850082466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687266; x=1762292066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNeIjx3lptZuujiNnKEUW6K0BzRaMu+x9cOk++i6hWg=;
        b=fcywpJ5wXoMtU8PUiShTJD4vfSAozVSZBWRwUTL0+gYY8DDpJz4AX+91GD8QRJehu9
         YJxmEbk2KreTjZGfZGNjJFa60SHOwjMeABUR6AbieEJokvkG5yzGoane0nrh92BMo0L6
         afWvxu4oQWH1uPSQNnC8azEFtN0eZip6RHryPBEZ8ubLgglUAmqLRtOHt10+Dj+8EQZA
         3Yc5qv3+k/tjQqlJXfXerM18HOl1SF0s4xE/2Q+gqvRk2597a7MeIMoIN5dEa5wg292S
         PEqfuhw8y+6/1TutfEC5caJTf0bZ2gyMLY3pFY2gtahrNeG4o2E1HVeIAmAYEeIbc3Hc
         n8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687266; x=1762292066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNeIjx3lptZuujiNnKEUW6K0BzRaMu+x9cOk++i6hWg=;
        b=onf9fm3D/+j16ck5Hcy16mmiRXHyHtPYUYOZwmc1I5bZklkflN8FPhyeaUIJHEdhfj
         rnVbTBxqQgeNQm0aEUFYJfx5pAZgEj4v6ASg4wCFG1YEQfpEnp/MPTNL556jxswEqdIv
         mNxLLerN2KMseCGD5a9iXAHPVyTivlHfi0Pdn5mRaqlX9G4EjqTAM9W5NrVTYjtEN5HT
         DvpeaGDPt4mBW3DSnLUxNJveCSdwuvLlony3Aae3Hp1/9Ynltn3kKM1yJTuK7het/GG+
         HIOWYUg3YXX/zWSJh9IcSFRJuPdmTi/A2SOmz9/J+7ImlstoFbjbiSwphMuC0jfxJqgR
         mOgA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0jUX8lhE+ERJIIGv2ImsHGgGF0Sw0Vh1LyDkfksi9ZT3BXdiCC7Gn0k0fpZPLP5bH5CfHKcGh54kK2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsrrUP7GQLlhyBhZxp7aAVHb4nuVnVTUVW8dBIy2XA/ujelVX
	BLbHk+z2qQE7m2tHQk0xW6n+M/Gf0mdoELOPPk5eq4ceam/mgfYNAxNt
X-Gm-Gg: ASbGncufHLa3QLbVok0GPzlA9bhwOIK0SIHhMhaW0b+ulF3Evk9IEvzTE+sFhLqrPMW
	8E1YIkGGYRAyF13ossNJ2DoTkrY7nEPg2gCXEOPnVTaO+pa2w5jIxzWGbg43W/4MxcvUKlE1v48
	PmffjWqUBUSA8WPaO3oIYIPy1Zzk7SeASImJUAiBB/ay9B0bxut5FkjJd71StITFfPCrNY2o5mA
	OsA1Ec8c0mP4KLj8jo7gc/6bclCczuiUSSB5wQPVn74/gbSUbLo2gMXE9o1Ai7Hup16b/Syvhcf
	IlAA0nzf5O/YSKQxj1VK8BFbBInnm7urBe5IVUw3m8J+vsl9HgQXqc06ap2isL4vTqyGItaCxmj
	1LdDHTJ8h5/jisCmM/2bNSfSxR+4CIlAXMFEqtJ33LDak26BmofePTW1Mf6qa/N0Drt32Awn4zc
	dEmXEaLZRs+zTLV/nGzZgREdudgQ==
X-Google-Smtp-Source: AGHT+IEyYqq65Dt6k7rhFlOuIQ7JykxsGjnM09MaiEHl+ci+PgMQWD+VL54JqHbfcGxpMotOd4fWEg==
X-Received: by 2002:a17:907:7253:b0:b6d:2c70:4542 with SMTP id a640c23a62f3a-b703d4f7dfemr44439766b.30.1761687265578;
        Tue, 28 Oct 2025 14:34:25 -0700 (PDT)
Received: from localhost.localdomain ([37.161.59.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6db9b86c80sm451303666b.43.2025.10.28.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:34:25 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 1/2] iio: mpl3115: add ctrl_reg4 to mpl3115_data
Date: Tue, 28 Oct 2025 22:33:51 +0100
Message-Id: <20251028213351.77368-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251028213351.77368-1-apokusinski01@gmail.com>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache the value of CTRL_REG4 in the mpl3115_data structure. This is a
preparation for adding support for the threshold events.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index c212dfdf59ff..4cc103e20a39 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -83,6 +83,7 @@ struct mpl3115_data {
 	struct iio_trigger *drdy_trig;
 	struct mutex lock;
 	u8 ctrl_reg1;
+	u8 ctrl_reg4;
 };
 
 enum mpl3115_irq_pin {
@@ -376,6 +377,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
 		goto reg1_cleanup;
 
 	data->ctrl_reg1 = ctrl_reg1;
+	data->ctrl_reg4 = ctrl_reg4;
 
 	return 0;
 
@@ -390,12 +392,15 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mpl3115_data *data = iio_priv(indio_dev);
 	u8 ctrl_reg1 = data->ctrl_reg1;
-	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
+	u8 ctrl_reg4 = data->ctrl_reg4;
 
-	if (state)
+	if (state) {
 		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
-	else
+		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
+	} else {
 		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
+	}
 
 	guard(mutex)(&data->lock);
 
-- 
2.25.1


